import collections, json, math, statistics
REF = r"K:\Downloads-IDM\Thronefall\Trainer\reference"
LOG = r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\bot-log.jsonl"
castle = {}
for sc, f in (("Nordfels", "05_Nordfels"), ("Durststein", "06_Durststein"), ("Neuland(Tutorial)", "04_Neuland_Tutorial_")):
    t = json.load(open(f"{REF}/data/terrain/{f}.json", encoding="utf-8"))
    c = t["features"]["castle"]
    if isinstance(c, tuple) or isinstance(c, list): c = c[0]
    castle[sc] = (c[0], c[2])
print(castle)
rows = []
for line in open(LOG, encoding="utf-8", errors="replace"):
    try: d = json.loads(line)
    except ValueError: continue
    if "mode" in d: rows.append(d)
# sessions
sess = []; cur = []; prev = -1
for r in rows:
    if r["t"] < prev - 1: sess.append(cur); cur = []
    cur.append(r); prev = r["t"]
sess.append(cur)
tot = collections.Counter(); idle = collections.Counter(); episodes = []
for si, s in enumerate(sess):
    ep = None
    for r in s:
        if r["state"] != "InMatch" or r["scene"] not in castle: 
            ep = None; continue
        c = castle[r["scene"]]
        dist = math.hypot(r["pos"][0] - c[0], r["pos"][1] - c[1])
        key = ("night" if r["night"] else "day", r["mode"])
        tot[key] += 1
        if r["night"] and r["mode"] == "Idle":
            if ep is None: ep = {"session": si, "scene": r["scene"], "t0": r["t"], "wave": r["wave"], "n": 0, "dists": [], "foes": [], "gold": [], "hp": [], "pos0": r["pos"], "nf": []}
            ep["n"] += 1; ep["t1"] = r["t"]; ep["dists"].append(dist); ep["foes"].append(r["foes"]); ep["gold"].append(r["gold"]); ep["hp"].append(r["hp"]); ep["nf"].append(r.get("nf", -1))
            if ep["n"] == 1: episodes.append(ep)
        else:
            ep = None
print("ticks by (phase, mode):")
for k, v in sorted(tot.items(), key=lambda kv: -kv[1]): print(f"  {v:7d} {k}")
print("night-idle episodes:", len(episodes), "ticks", sum(e['n'] for e in episodes))
big = sorted(episodes, key=lambda e: -e["n"])[:15]
for e in big:
    print(f"  s{e['session']} {e['scene']} wave {e['wave']} t={e['t0']:.0f}..{e['t1']:.0f} ({e['t1']-e['t0']:.0f}s) ticks={e['n']} distCastle med={statistics.median(e['dists']):.0f} foes med={statistics.median(e['foes']):.0f} nf med={statistics.median(e['nf']):.0f} gold med={statistics.median(e['gold'])} hp med={statistics.median(e['hp'])} pos0={e['pos0']}")
# overall stats over all night-idle ticks
alld = [d for e in episodes for d in e["dists"]]
print("night-idle ticks: dist to castle percentiles", [round(statistics.quantiles(alld, n=10)[i]) for i in (0, 4, 8)] if len(alld) > 10 else alld)
