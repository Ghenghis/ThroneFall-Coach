#!/usr/bin/env python3
"""Export recorded runs into a real RL dataset.

Every agent run (ticks.jsonl + notes.jsonl + match outcome) becomes
training rows:  (state_vector, action, reward, next_state, done)

Layout — agent/dataset/<run>.jsonl, one row per decision tick:
  s   : state vector (normalized floats — see FEATURES)
  a   : action the policy took (mode + key parameters)
  r   : immediate reward this tick (shaped)
  s2  : next state vector
  done: match ended
  meta: scene, outcome, wave

Rewards (shaped, matches src/Policy.cs):
  victory +10 | defeat -10 | castle_hp_saved*5 | night-survived +0.2
  breach -0.4 | build paid +0.05 | squad posted +0.1 | hero hurt -0.1
Feature order lives in FEATURES — keep in sync with src/BotPerception.cs
Snapshot fields. Feed into any offline trainer (PPO/BC/DQN adapter).

Usage: python tools/episodes.py [--out agent/dataset]
"""
import json, pathlib, sys, glob, os

AGENT = pathlib.Path(os.environ.get(
    "THRONEFALL_AGENT",
    r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent"))
OUT = AGENT / "dataset"
MODES = ["Idle","CollectCoin","ReturnHome","HoldCastle","Engage",
         "EnterLevel","StartNight","SpendGold","ResolveUI",
         "PositionArmy","HeroDead"]

def feats(t, s):
    """State vector — normalized so a net sees 0..1-ish inputs."""
    return [
        (t.get("gold") or 0) / 500.0,
        (t.get("foes") or 0) / 60.0,
        (t.get("ally") or 0) / 60.0,
        (t.get("free") or 0) / 60.0,
        (t.get("drc") or 0) / max(1, t.get("drn") or 1),   # coverage fraction
        (t.get("drn") or 0) / 16.0,
        (t.get("at") or 0) / 80.0,                        # army target
        1.0 if t.get("night") else 0.0,
        1.0 if t.get("ra") else 0.0,                      # red alert
        (t.get("hp") or 0),
        (t.get("chp") or 0) / 100.0 if t.get("chp") else 0.5,
        (s or {}).get("wave_idx", 0) / 60.0,
    ]

def reward(prev, t, outcome_done, hp_delta):
    r = 0.0
    if outcome_done == "victory": r += 10.0
    if outcome_done == "defeat":  r -= 10.0
    if prev and prev.get("night") and not t.get("night"):
        r += 0.2                                        # survived a night
    if hp_delta < -0.001: r += hp_delta * 10            # hero hurt
    return r

def convert(run_dir: pathlib.Path):
    ticks = run_dir / "ticks.jsonl"
    if not ticks.exists(): return None
    rows = []
    prev, prev_hp = None, 1.0
    match = "unknown"
    notes = run_dir / "events.jsonl"
    if notes.exists():
        for nl in notes.read_text(errors="replace").splitlines():
            try: n = json.loads(nl)
            except Exception: continue
            if n.get("note") in ("victory", "defeat"): match = n["note"]
            if n.get("note") == "match-end" and n.get("result"):
                match = n["result"]
    for line in ticks.read_text(errors="replace").splitlines():
        if not line.strip(): continue
        try: t = json.loads(line)
        except Exception: continue
        if "mode" not in t: continue
        if t["mode"] not in MODES:
            # Unknown/new mode → index-0 ("Idle") poisoning of the training
            # set. Skip the row instead of mislabeling it.
            continue
        hp = t.get("hp") or prev_hp
        row = {
            "s": feats(t, None),
            "a": MODES.index(t["mode"]),
            "mode": t["mode"],
            "t": t.get("t"),
            "hp_d": hp - prev_hp,
        }
        prev_hp = hp
        if prev is not None:
            rows[-1]["s2"] = row["s"]
            rows[-1]["r"] = reward(prev, t, None, row["hp_d"])
        rows.append(row)
        prev = t
    if not rows: return None
    rows[-1]["done"] = True
    rows[-1]["r"] = rows[-1].get("r", 0) + reward(None, rows[-1], match, 0)
    for r in rows:
        r.setdefault("s2", r["s"]); r.setdefault("r", 0.0); r.setdefault("done", False)
        r["meta"] = {"run": run_dir.name, "outcome": match}
    return rows

def main():
    out = pathlib.Path(sys.argv[sys.argv.index("--out") + 1]) \
        if "--out" in sys.argv else OUT
    out.mkdir(parents=True, exist_ok=True)
    total = 0
    for rd in sorted(glob.glob(str(AGENT / "runs" / "*"))):
        rd = pathlib.Path(rd)
        rows = convert(rd)
        if not rows: continue
        dst = out / (rd.name + ".jsonl")
        with open(dst, "w", encoding="utf-8") as f:
            for r in rows:
                f.write(json.dumps(r) + "\n")
        total += len(rows)
        print(f"{rd.name}: {len(rows)} rows "
              f"({rows[-1]['meta']['outcome']})")
    print(f"\n{total} training rows -> {out}")

if __name__ == "__main__":
    main()
