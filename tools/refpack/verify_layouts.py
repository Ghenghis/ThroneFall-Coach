"""verify_layouts — prove the TfMap layouts are byte-exact against the real Thronefall asset files.

For every MonoBehaviour object: resolve its MonoScript → (assembly, namespace, class) → layout key →
parse the raw bytes with tf_reader → require that the parser consumes *exactly* the object's byte size.
A layout that passes on thousands of real objects is evidence, not a guess; failures are reported with the
field path where parsing diverged.

usage: python verify_layouts.py [--game DIR] [--maps DIR] [--files REGEX] [--limit N] [--out FILE]
"""
from __future__ import annotations

import argparse
import collections
import json
import os
import re
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import tf_reader as T  # noqa: E402
import UnityPy  # noqa: E402
from UnityPy.enums import ClassIDType  # noqa: E402


def script_table(game: str) -> dict[tuple[str, int], tuple[str, str, str]]:
    """(basename, pathID) → (assembly, namespace, class) for every MonoScript in the data folder."""
    tbl: dict[tuple[str, int], tuple[str, str, str]] = {}
    names = ["globalgamemanagers.assets", "resources.assets"] + sorted(
        f for f in os.listdir(game) if re.fullmatch(r"sharedassets\d+\.assets", f))
    for name in names:
        path = os.path.join(game, name)
        if not os.path.exists(path):
            continue
        env = UnityPy.load(path)
        for sf in env.files.values():
            if not hasattr(sf, "objects"):
                continue
            for pid, o in sf.objects.items():
                if o.type != ClassIDType.MonoScript:
                    continue
                s = o.read()
                tbl[(name, pid)] = (s.m_AssemblyName, s.m_Namespace, s.m_ClassName)
    return tbl


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--game", default=r"K:\Downloads-IDM\Thronefall\Thronefall_Data")
    ap.add_argument("--maps", default=r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
    ap.add_argument("--files", default=r"^(level\d+|sharedassets\d+\.assets|resources\.assets|globalgamemanagers\.assets)$")
    ap.add_argument("--limit", type=int, default=0, help="max MonoBehaviours per file (0 = all)")
    ap.add_argument("--out", default=r"K:\Downloads-IDM\Thronefall\Trainer\reference\verification\layout_check.json")
    a = ap.parse_args()

    t0 = time.time()
    layouts = T.load_layouts(os.path.join(a.maps, "serialization", "layouts.json"))
    classes = T.load_class_layouts(os.path.join(a.maps, "serialization", "class_layouts.json"))
    trees = {k: T.build_tree(v["nodes"]) for k, v in layouts.items()}
    print(f"layouts: {len(trees)} script classes, {len(classes)} class layouts")
    scripts = script_table(a.game)
    print(f"MonoScripts resolved: {len(scripts)}  ({time.time() - t0:.1f}s)")

    rx = re.compile(a.files)
    files = sorted(f for f in os.listdir(a.game) if rx.match(f))
    per: dict[str, dict] = collections.defaultdict(lambda: {"ok": 0, "trailing": 0, "error": 0, "samples": []})
    unresolved = collections.Counter()
    nolayout: collections.Counter = collections.Counter()
    tot = collections.Counter()
    per_file = {}

    for name in files:
        env = UnityPy.load(os.path.join(a.game, name))
        cnt = collections.Counter()
        for sf in env.files.values():
            if not hasattr(sf, "objects"):
                continue
            externals = [os.path.basename(getattr(e, "path", "") or "") for e in sf.externals]
            n = 0
            for pid, o in sf.objects.items():
                if o.type != ClassIDType.MonoBehaviour:
                    continue
                if a.limit and n >= a.limit:
                    break
                n += 1
                raw = o.get_raw_data()
                tot["objects"] += 1
                try:
                    _, _, sc_file, sc_path, _ = T.peek_header(raw)
                except Exception:
                    unresolved["bad header"] += 1
                    cnt["unresolved"] += 1
                    continue
                base = name if sc_file == 0 else (externals[sc_file - 1] if 0 < sc_file <= len(externals) else "?")
                ident = scripts.get((base, sc_path))
                if ident is None:
                    unresolved[f"{base}:{sc_path}"] += 1
                    cnt["unresolved"] += 1
                    continue
                key = f"{ident[0]}.dll|{ident[1]}|{ident[2]}" if not ident[0].endswith(".dll") else f"{ident[0]}|{ident[1]}|{ident[2]}"
                tree = trees.get(key)
                if tree is None:
                    nolayout[key] += 1
                    cnt["nolayout"] += 1
                    continue
                rec = per[key]
                try:
                    _, used, _ = T.parse_object(tree, raw, classes)
                    if used == len(raw) or ((used + 3) & ~3) == len(raw):
                        rec["ok"] += 1
                        cnt["ok"] += 1
                    else:
                        rec["trailing"] += 1
                        cnt["trailing"] += 1
                        if len(rec["samples"]) < 3:
                            rec["samples"].append({"file": name, "pathID": pid, "kind": "trailing", "used": used, "size": len(raw)})
                except T.ParseError as e:
                    rec["error"] += 1
                    cnt["error"] += 1
                    if len(rec["samples"]) < 3:
                        # re-run with tracing to localise the field
                        try:
                            T.parse_object(tree, raw, classes, trace=True)
                            where = str(e)
                        except T.ParseError as e2:
                            where = str(e2)
                        rec["samples"].append({"file": name, "pathID": pid, "kind": "error", "msg": where, "size": len(raw)})
                except Exception as e:  # noqa: BLE001
                    rec["error"] += 1
                    cnt["error"] += 1
                    if len(rec["samples"]) < 3:
                        rec["samples"].append({"file": name, "pathID": pid, "kind": "exception", "msg": repr(e)[:300], "size": len(raw)})
        per_file[name] = dict(cnt)
        tot.update(cnt)
        done = tot["ok"] + tot["trailing"] + tot["error"]
        print(f"  {name:32s} {dict(cnt)}   running byte-exact {tot['ok']}/{done}  [{time.time() - t0:.0f}s]", flush=True)

    checked = tot["ok"] + tot["trailing"] + tot["error"]
    report = {
        "game": a.game,
        "objects": tot["objects"],
        "checked": checked,
        "byteExact": tot["ok"],
        "trailingBytes": tot["trailing"],
        "errors": tot["error"],
        "unresolvedScripts": tot["unresolved"],
        "noLayout": tot["nolayout"],
        "byteExactPct": round(100.0 * tot["ok"] / checked, 3) if checked else None,
        "perScript": {k: v for k, v in sorted(per.items(), key=lambda kv: -(kv[1]["error"] + kv[1]["trailing"]))},
        "noLayoutClasses": dict(nolayout.most_common()),
        "unresolved": dict(unresolved.most_common(50)),
        "perFile": per_file,
        "elapsedSeconds": round(time.time() - t0, 1),
    }
    os.makedirs(os.path.dirname(a.out), exist_ok=True)
    with open(a.out, "w", encoding="utf-8") as f:
        json.dump(report, f, indent=1)
    bad = [(k, v) for k, v in per.items() if v["error"] or v["trailing"]]
    print(f"\nchecked {checked} MonoBehaviours: byte-exact {tot['ok']} ({report['byteExactPct']}%), trailing {tot['trailing']}, errors {tot['error']}; "
          f"unresolved {tot['unresolved']}, no layout {tot['nolayout']}")
    print(f"{len(bad)} script classes with failures; {sum(1 for v in per.values() if v['ok'] and not v['error'] and not v['trailing'])} fully verified")
    for k, v in sorted(bad, key=lambda kv: -(kv[1]['error'] + kv[1]['trailing']))[:25]:
        s = v["samples"][0] if v["samples"] else {}
        print(f"  {k}: ok={v['ok']} trailing={v['trailing']} err={v['error']}  {s.get('msg') or s}")
    print("report ->", a.out)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
