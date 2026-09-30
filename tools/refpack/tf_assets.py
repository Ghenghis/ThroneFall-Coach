"""tf_assets — object graph over Thronefall's Unity asset files (scenes, shared assets, resources).

Built on UnityPy for the container format and tf_reader (+ TfMap layouts) for MonoBehaviour payloads.
Every MonoBehaviour value returned here was decoded by a layout proven byte-exact by verify_layouts.py.

    g = Game(DATA_DIR, MAPS_DIR)
    f = g.file("level5")                       # Nordfels
    for pid, mb in f.monobehaviours("EnemySpawner"):  ...
    pos = f.world_pos(f.transform_of_go(go_pid))
"""
from __future__ import annotations

import math
import os
import re
import struct
from dataclasses import dataclass, field
from typing import Any, Iterator

import UnityPy
from UnityPy.enums import ClassIDType

import tf_reader as T

Ref = tuple[str, int]  # (file basename, pathID); pathID 0 = null


@dataclass
class MB:
    pid: int
    cls: str            # script class name (no namespace)
    key: str            # layout key  asm.dll|ns|Class
    go: int             # owning GameObject pathID in the same file (0 = none, e.g. ScriptableObject)
    name: str           # m_Name
    v: dict[str, Any]   # decoded fields (excluding the Unity header)
    enabled: bool = True


@dataclass
class SFile:
    game: "Game"
    name: str
    sf: Any
    externals: list[str]
    _mb: dict[int, MB | None] = field(default_factory=dict)
    _go: dict[int, dict] = field(default_factory=dict)
    _tf: dict[int, dict] = field(default_factory=dict)
    _by_cls: dict[str, list[int]] | None = None
    _go_comps: dict[int, list[int]] | None = None

    # ---- object typing
    def objects(self) -> dict:
        return self.sf.objects

    def unity_type(self, pid: int) -> str:
        o = self.sf.objects.get(pid)
        return o.type.name if o is not None else "?"

    def script_ident(self, pid: int) -> tuple[str, str, str] | None:
        o = self.sf.objects.get(pid)
        if o is None or o.type != ClassIDType.MonoBehaviour:
            return None
        raw = o.get_raw_data()
        _, _, sc_file, sc_path, _ = T.peek_header(raw)
        base = self.name if sc_file == 0 else (self.externals[sc_file - 1] if 0 < sc_file <= len(self.externals) else "?")
        return self.game.scripts.get((base, sc_path))

    def class_index(self) -> dict[str, list[int]]:
        """script class name → [pathIDs] for every MonoBehaviour in this file."""
        if self._by_cls is None:
            idx: dict[str, list[int]] = {}
            for pid, o in self.sf.objects.items():
                if o.type != ClassIDType.MonoBehaviour:
                    continue
                ident = self.script_ident(pid)
                idx.setdefault(ident[2] if ident else "?", []).append(pid)
            self._by_cls = idx
        return self._by_cls

    # ---- MonoBehaviour
    def mb(self, pid: int) -> MB | None:
        if pid in self._mb:
            return self._mb[pid]
        o = self.sf.objects.get(pid)
        res: MB | None = None
        if o is not None and o.type == ClassIDType.MonoBehaviour:
            ident = self.script_ident(pid)
            if ident:
                key = f"{ident[0]}|{ident[1]}|{ident[2]}" if ident[0].endswith(".dll") else f"{ident[0]}.dll|{ident[1]}|{ident[2]}"
                tree = self.game.trees.get(key)
                if tree is not None:
                    raw = o.get_raw_data()
                    val, _, _ = T.parse_object(tree, raw, self.game.classes)
                    go = val["m_GameObject"]["m_PathID"] if val["m_GameObject"]["m_FileID"] == 0 else 0
                    res = MB(pid, ident[2], key, go, val.get("m_Name", ""),
                             {k: x for k, x in val.items() if k not in ("m_GameObject", "m_Enabled", "m_Script", "m_Name")},
                             bool(val.get("m_Enabled", 1)))
        self._mb[pid] = res
        return res

    def monobehaviours(self, cls: str) -> Iterator[tuple[int, MB]]:
        for pid in self.class_index().get(cls, []):
            m = self.mb(pid)
            if m is not None:
                yield pid, m

    # ---- GameObject / Transform (native classes, read by UnityPy's built-in layouts)
    def go(self, pid: int) -> dict:
        if pid in self._go:
            return self._go[pid]
        o = self.sf.objects.get(pid)
        d: dict = {"pid": pid, "name": "", "active": True, "layer": 0, "tag": 0, "comps": []}
        if o is not None and o.type == ClassIDType.GameObject:
            g = o.read()
            d = {"pid": pid, "name": g.m_Name, "active": bool(g.m_IsActive), "layer": g.m_Layer, "tag": g.m_Tag,
                 "comps": [c.m_PathID for c in g.m_Components if c.m_FileID == 0]}
        self._go[pid] = d
        return d

    def go_components(self, go_pid: int) -> list[tuple[int, str]]:
        """[(pathID, unity type or script class)] of a GameObject's components."""
        out = []
        for c in self.go(go_pid)["comps"]:
            t = self.unity_type(c)
            if t == "MonoBehaviour":
                ident = self.script_ident(c)
                t = ident[2] if ident else "MonoBehaviour?"
            out.append((c, t))
        return out

    def tf(self, pid: int) -> dict:
        if pid in self._tf:
            return self._tf[pid]
        o = self.sf.objects.get(pid)
        d: dict = {}
        if o is not None and o.type in (ClassIDType.Transform, ClassIDType.RectTransform):
            t = o.read()
            d = {"pid": pid, "go": t.m_GameObject.m_PathID,
                 "pos": (t.m_LocalPosition.x, t.m_LocalPosition.y, t.m_LocalPosition.z),
                 "rot": (t.m_LocalRotation.x, t.m_LocalRotation.y, t.m_LocalRotation.z, t.m_LocalRotation.w),
                 "scale": (t.m_LocalScale.x, t.m_LocalScale.y, t.m_LocalScale.z),
                 "father": t.m_Father.m_PathID if t.m_Father.m_FileID == 0 else 0,
                 "children": [c.m_PathID for c in t.m_Children], "rect": o.type == ClassIDType.RectTransform}
        self._tf[pid] = d
        return d

    def owner_go(self, pid: int) -> int:
        """GameObject pathID that owns any component / transform / GameObject reference (0 = unknown)."""
        t = self.unity_type(pid)
        if t == "GameObject":
            return pid
        if t == "MonoBehaviour":
            m = self.mb(pid)
            return m.go if m else 0
        o = self.sf.objects.get(pid)
        try:
            return o.read().m_GameObject.m_PathID if o is not None else 0
        except Exception:  # noqa: BLE001
            return 0

    def transform_of_go(self, go_pid: int) -> int:
        for c in self.go(go_pid)["comps"]:
            if self.unity_type(c) in ("Transform", "RectTransform"):
                return c
        return 0

    def world(self, tf_pid: int) -> tuple[tuple[float, float, float], tuple[float, float, float, float], tuple[float, float, float]]:
        """(position, rotation quaternion xyzw, lossy scale) in world space."""
        chain = []
        cur = tf_pid
        guard = 0
        while cur and guard < 200:
            t = self.tf(cur)
            if not t:
                break
            chain.append(t)
            cur = t["father"]
            guard += 1
        pos = (0.0, 0.0, 0.0)
        rot = (0.0, 0.0, 0.0, 1.0)
        scl = (1.0, 1.0, 1.0)
        for t in reversed(chain):  # root first
            lp = (t["pos"][0] * scl[0], t["pos"][1] * scl[1], t["pos"][2] * scl[2])
            rp = qrot(rot, lp)
            pos = (pos[0] + rp[0], pos[1] + rp[1], pos[2] + rp[2])
            rot = qmul(rot, t["rot"])
            scl = (scl[0] * t["scale"][0], scl[1] * t["scale"][1], scl[2] * t["scale"][2])
        return pos, rot, scl

    def world_pos(self, tf_pid: int) -> tuple[float, float, float]:
        return self.world(tf_pid)[0]

    def path(self, go_pid: int) -> str:
        """Hierarchy path 'Root/Child/Leaf' of a GameObject."""
        names = []
        cur = self.transform_of_go(go_pid)
        guard = 0
        while cur and guard < 200:
            t = self.tf(cur)
            names.append(self.go(t["go"])["name"])
            cur = t["father"]
            guard += 1
        return "/".join(reversed(names))

    # ---- references
    def ref(self, ptr: dict) -> Ref | None:
        """Resolve a decoded PPtr {'m_FileID','m_PathID'} → (file basename, pathID)."""
        pid = ptr["m_PathID"]
        if pid == 0:
            return None
        fid = ptr["m_FileID"]
        if fid == 0:
            return (self.name, pid)
        if 0 < fid <= len(self.externals):
            return (self.externals[fid - 1], pid)
        return ("?", pid)


class Game:
    def __init__(self, data_dir: str, maps_dir: str):
        self.dir = data_dir
        self.maps = maps_dir
        ser = os.path.join(maps_dir, "serialization")
        self.layouts = T.load_layouts(os.path.join(ser, "layouts.json"))
        self.trees = {k: T.build_tree(v["nodes"]) for k, v in self.layouts.items()}
        self.classes = T.load_class_layouts(os.path.join(ser, "class_layouts.json"))
        self.files: dict[str, SFile] = {}
        self.scripts = self._script_table()
        self.scene_names = self._build_settings()

    # ---- bootstrap
    def _load(self, name: str) -> SFile:
        env = UnityPy.load(os.path.join(self.dir, name))
        sf = next(f for f in env.files.values() if hasattr(f, "objects"))
        ext = [os.path.basename(getattr(e, "path", "") or "") for e in sf.externals]
        return SFile(self, name, sf, ext)

    def _script_table(self) -> dict[tuple[str, int], tuple[str, str, str]]:
        tbl: dict[tuple[str, int], tuple[str, str, str]] = {}
        names = ["globalgamemanagers.assets", "resources.assets"] + sorted(
            f for f in os.listdir(self.dir) if re.fullmatch(r"sharedassets\d+\.assets", f))
        for name in names:
            if not os.path.exists(os.path.join(self.dir, name)):
                continue
            env = UnityPy.load(os.path.join(self.dir, name))
            for sf in env.files.values():
                if not hasattr(sf, "objects"):
                    continue
                for pid, o in sf.objects.items():
                    if o.type == ClassIDType.MonoScript:
                        s = o.read()
                        tbl[(name, pid)] = (s.m_AssemblyName, s.m_Namespace, s.m_ClassName)
        return tbl

    def _build_settings(self) -> list[str]:
        env = UnityPy.load(os.path.join(self.dir, "globalgamemanagers"))
        for sf in env.files.values():
            if not hasattr(sf, "objects"):
                continue
            for o in sf.objects.values():
                if o.type.name == "BuildSettings":
                    return [os.path.splitext(os.path.basename(s))[0] for s in o.read().scenes]
        return []

    def file(self, name: str) -> SFile:
        f = self.files.get(name)
        if f is None:
            f = self.files[name] = self._load(name)
        return f

    def scene_file(self, scene: str) -> str:
        return f"level{self.scene_names.index(scene)}"

    def deref_mb(self, ref: Ref | None) -> MB | None:
        return self.file(ref[0]).mb(ref[1]) if ref else None

    def drop(self, name: str) -> None:
        self.files.pop(name, None)


# ---- tiny quaternion helpers (avoid a numpy dependency) ---------------------------------------------

def qmul(a, b):
    ax, ay, az, aw = a
    bx, by, bz, bw = b
    return (aw * bx + ax * bw + ay * bz - az * by,
            aw * by - ax * bz + ay * bw + az * bx,
            aw * bz + ax * by - ay * bx + az * bw,
            aw * bw - ax * bx - ay * by - az * bz)


def qrot(q, v):
    x, y, z, w = q
    vx, vy, vz = v
    # v' = v + 2w(q×v) + 2 q×(q×v)
    cx, cy, cz = y * vz - z * vy, z * vx - x * vz, x * vy - y * vx
    dx, dy, dz = y * cz - z * cy, z * cx - x * cz, x * cy - y * cx
    return (vx + 2 * (w * cx + dx), vy + 2 * (w * cy + dy), vz + 2 * (w * cz + dz))


def yaw_deg(q) -> float:
    """Heading around Y (degrees) of a rotation quaternion."""
    x, y, z, w = q
    return math.degrees(math.atan2(2 * (w * y + x * z), 1 - 2 * (y * y + x * x)))
