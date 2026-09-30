"""tf_reader — interpret Unity serialized-object layouts (produced by TfMap) against raw object bytes.

The Thronefall build ships *without* type trees, so UnityPy cannot decode MonoBehaviour / ScriptableObject
payloads by itself. TfMap derives the field layout of every script class from the managed assemblies
(reference/maps/serialization/layouts.json); this module walks such a layout over the raw bytes.

Rules mirrored from Unity's binary reader (verified byte-exact by verify_layouts.py):
  * a node whose meta flag has 0x4000 aligns the stream to 4 bytes after it is read
  * `string` = int32 length + bytes + align(4)
  * a node whose first child is `Array` is a vector: int32 count, then `count` elements of Array.children[1];
    the vector is aligned afterwards when the Array node (or the vector node) carries the align flag
  * `ManagedReferencesRegistry` (a [SerializeReference] table) is parsed with class layouts (class_layouts.json)
"""
from __future__ import annotations

import json
import struct
from typing import Any

ALIGN = 0x4000
MAX_ARRAY = 200_000_000


class ParseError(Exception):
    def __init__(self, msg: str, pos: int = -1, path: str = ""):
        super().__init__(msg)
        self.msg, self.pos, self.path = msg, pos, path

    def __str__(self) -> str:
        return f"{self.msg} @0x{self.pos:x} in {self.path}" if self.pos >= 0 else self.msg


class Node:
    __slots__ = ("type", "name", "meta", "children")

    def __init__(self, t: str, n: str, m: int):
        self.type, self.name, self.meta = t, n, m
        self.children: list[Node] = []


def build_tree(rows: list[list[Any]]) -> Node:
    """rows = [[level, type, name, meta], ...] → Node tree."""
    stack: list[Node] = []
    root: Node | None = None
    for lvl, typ, name, meta in rows:
        n = Node(typ, name, meta)
        if lvl == 0:
            root, stack = n, [n]
        else:
            del stack[lvl:]
            stack[-1].children.append(n)
            stack.append(n)
    assert root is not None
    return root


_PRIM = {
    "SInt8": ("<b", 1), "UInt8": ("<B", 1), "char": ("<B", 1), "bool": ("<B", 1),
    "short": ("<h", 2), "SInt16": ("<h", 2), "UInt16": ("<H", 2), "unsigned short": ("<H", 2),
    "int": ("<i", 4), "SInt32": ("<i", 4), "UInt32": ("<I", 4), "unsigned int": ("<I", 4),
    "SInt64": ("<q", 8), "long long": ("<q", 8), "UInt64": ("<Q", 8), "unsigned long long": ("<Q", 8),
    "float": ("<f", 4), "double": ("<d", 8),
}


class Reader:
    __slots__ = ("b", "p", "n", "layouts", "classes", "trace")

    def __init__(self, data: bytes, classes: dict[str, Node] | None = None, trace: bool = False):
        self.b, self.p, self.n = data, 0, len(data)
        self.classes = classes or {}
        self.trace: list[tuple[str, int]] | None = [] if trace else None

    def need(self, k: int, what: str = "") -> None:
        if self.p + k > self.n:
            raise ParseError(f"unexpected end of data (need {k} bytes for {what})", self.p)

    def align(self) -> None:
        self.p = (self.p + 3) & ~3

    def i32(self) -> int:
        self.need(4, "int32")
        v = struct.unpack_from("<i", self.b, self.p)[0]
        self.p += 4
        return v

    def i64(self) -> int:
        self.need(8, "int64")
        v = struct.unpack_from("<q", self.b, self.p)[0]
        self.p += 8
        return v

    def string(self) -> str:
        n = self.i32()
        if n < 0 or n > self.n - self.p:
            raise ParseError(f"bad string length {n}", self.p - 4)
        s = self.b[self.p:self.p + n].decode("utf-8", "replace")
        self.p += n
        self.align()
        return s


def read_node(r: Reader, node: Node, path: str = "") -> Any:
    t = node.type
    prim = _PRIM.get(t)
    if prim is not None:
        fmt, size = prim
        r.need(size, node.name)
        v = struct.unpack_from(fmt, r.b, r.p)[0]
        r.p += size
        if t == "bool":
            v = bool(v)
        if r.trace is not None:
            r.trace.append((path + "/" + node.name, r.p))
    elif t == "string":
        v = r.string()
        if r.trace is not None:
            r.trace.append((path + "/" + node.name, r.p))
    elif t == "ManagedReferencesRegistry":
        v = read_registry(r, path + "/" + node.name)
    elif node.children and node.children[0].type == "Array":
        arr = node.children[0]
        n = r.i32()
        if n < 0 or n > MAX_ARRAY:
            raise ParseError(f"bad array length {n}", r.p - 4, path + "/" + node.name)
        sub = arr.children[1]
        sp = _PRIM.get(sub.type)
        if sp is not None:
            fmt, size = sp
            r.need(n * size, node.name)
            if size == 1 and sub.type != "SInt8":
                v = bytes(r.b[r.p:r.p + n]) if sub.type != "bool" else [bool(x) for x in r.b[r.p:r.p + n]]
            else:
                v = list(struct.unpack_from("<%d%s" % (n, fmt[1]), r.b, r.p))
            r.p += n * size
        else:
            p2 = path + "/" + node.name
            v = [read_node(r, sub, p2 + f"[{i}]") for i in range(n)]
        if (arr.meta & ALIGN) or (node.meta & ALIGN):
            r.align()
        if r.trace is not None:
            r.trace.append((path + "/" + node.name + f"[{n}]", r.p))
    else:
        p2 = path + "/" + node.name
        v = {c.name: read_node(r, c, p2) for c in node.children}
    if node.meta & ALIGN:
        r.align()
    return v


def read_registry(r: Reader, path: str) -> dict[str, Any]:
    """[SerializeReference] table: version, then (rid, class/ns/asm, payload) entries."""
    version = r.i32()
    out: dict[str, Any] = {"version": version, "entries": []}
    if version == 1:
        # legacy: entries until a Terminus record
        while True:
            rid = r.i64()
            cls, ns, asm = r.string(), r.string(), r.string()
            if cls == "Terminus":
                break
            out["entries"].append(_read_ref_entry(r, rid, cls, ns, asm, path))
        return out
    n = r.i32()
    if n < 0 or n > 10_000_000:
        raise ParseError(f"bad registry count {n}", r.p - 4, path)
    for _ in range(n):
        rid = r.i64()
        cls, ns, asm = r.string(), r.string(), r.string()
        out["entries"].append(_read_ref_entry(r, rid, cls, ns, asm, path))
    return out


def _read_ref_entry(r: Reader, rid: int, cls: str, ns: str, asm: str, path: str) -> dict[str, Any]:
    entry = {"rid": rid, "class": cls, "ns": ns, "asm": asm}
    if cls == "" or (ns == "UnityEngine.DMAT" and cls == "Terminus"):
        return entry
    key = f"{asm}.dll|{ns}|{cls}" if not asm.endswith(".dll") else f"{asm}|{ns}|{cls}"
    node = r.classes.get(key)
    if node is None:
        raise ParseError(f"no class layout for managed reference {key}", r.p, path)
    entry["data"] = {c.name: read_node(r, c, path + f"<{cls}>") for c in node.children}
    return entry


def parse_object(rows: list[list[Any]] | Node, raw: bytes, classes: dict[str, Node] | None = None,
                 trace: bool = False) -> tuple[dict[str, Any], int, Reader]:
    """Parse one object. Returns (value, bytes consumed, reader). Raises ParseError with a field path."""
    root = rows if isinstance(rows, Node) else build_tree(rows)
    r = Reader(raw, classes, trace)
    try:
        val = {c.name: read_node(r, c, "") for c in root.children}
    except ParseError as e:
        if not e.path and r.trace:
            e.path = r.trace[-1][0]
        raise
    return val, r.p, r


def load_layouts(path: str) -> dict[str, dict]:
    with open(path, encoding="utf-8") as f:
        return json.load(f)


def load_class_layouts(path: str) -> dict[str, Node]:
    out: dict[str, Node] = {}
    for k, v in load_layouts(path).items():
        out[k] = build_tree(v["nodes"])
    return out


# ---- MonoBehaviour header peek (script reference) -------------------------------------------------

def peek_header(raw: bytes) -> tuple[int, int, int, int, str]:
    """Returns (go_fileID, go_pathID, script_fileID, script_pathID, m_Name) of a MonoBehaviour payload."""
    go_file, go_path = struct.unpack_from("<iq", raw, 0)
    # m_Enabled: 1 byte + pad to 4 → offset 12 + 4 = 16
    sc_file, sc_path = struct.unpack_from("<iq", raw, 16)
    n = struct.unpack_from("<i", raw, 28)[0]
    name = raw[32:32 + n].decode("utf-8", "replace") if 0 <= n < len(raw) else ""
    return go_file, go_path, sc_file, sc_path, name
