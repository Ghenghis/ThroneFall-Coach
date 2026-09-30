#!/usr/bin/env python3
"""MiniMax M3 "grandmaster coach" for the Thronefall autopilot.

Phase A (offline research): feed M3 the real map data (botpack waves,
spawn routes, enemy stats) plus distilled web research -> it writes a
structured playbook the bot loads as strategy.json + PLAYBOOK.md.

Phase B (runtime advisor) is handled in the plugin itself (Coach.cs);
this script is the offline half + a smoke-test for the endpoint.

Usage:  python tools/mm-coach.py [--scene Durststein] [--advise digest.json]
"""
import json, os, sys, urllib.request, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
BOTPACK = pathlib.Path(os.environ.get(
    "THRONEFALL_BOTPACK",
    r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent\botpack"))

def load_env_key():
    for p in (r"K:\private\.env", r"K:\private\minimax-m3-ultra.env"):
        try:
            for ln in pathlib.Path(p).read_text().splitlines():
                ln = ln.strip()
                if ln.startswith(("MINIMAX_API_KEY=", "minimax=")) and "=" in ln:
                    return ln.split("=", 1)[1].strip()
        except OSError:
            continue
    return os.environ.get("MINIMAX_API_KEY", "")

def chat(messages, model=None, max_tokens=8192, temperature=0.4):
    key = load_env_key()
    base = "https://api.minimax.io/v1"
    body = {
        "model": model or os.environ.get("MINIMAX_MODEL", "MiniMax-M3"),
        "messages": messages,
        "max_tokens": max_tokens,
        "reasoning_split": True,
        "temperature": temperature,
    }
    req = urllib.request.Request(
        base + "/chat/completions",
        data=json.dumps(body).encode(),
        headers={"Authorization": "Bearer " + key,
                 "Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=180) as r:
        out = json.loads(r.read())
    return out["choices"][0]["message"]["content"], out.get("usage", {})

def game_digest(scene="Durststein"):
    """Compact, token-cheap digest of the real map data."""
    f = BOTPACK / f"{scene}.json"
    packs = sorted(p for p in BOTPACK.glob("*.json")
                   if not p.stem.startswith(("strategy_",)))
    if not f.exists() and packs:
        # exact stem match only — a substring would grab challenge maps
        m = [p for p in packs if p.stem.lower() == scene.lower()]
        if not m:
            sys.exit(f"no botpack for '{scene}' — refusing to silently "
                     f"substitute another scene's data into the prompt")
        f = m[0]
    elif not f.exists():
        sys.exit(f"no botpack for '{scene}' and no packs at all")
    d = json.loads(f.read_text(encoding='utf-8'))
    waves = d.get("waves", [])[:12]
    return {
        "scene": d.get("scene", f.stem),
        "slots": len(d.get("slots", [])),
        "gates": len(d.get("gates", [])),
        "spawn_lines": sorted({r.get("line", "?") for r in d.get("spawns", [])}),
        "routes": len(d.get("spawns", [])),
        "route_detail": [{"line": r.get("line"), "len_m": r.get("lenM"),
                          "flying": r.get("fly"), "ground": r.get("ground"),
                          "choke_m": r.get("narrowM")}
                         for r in d.get("spawns", [])],
        "waves": [{"w": w.get("wave"), "n": w.get("count"),
                   "e": w.get("enemy"), "line": w.get("line"),
                   "elite": w.get("elite"), "hp": w.get("hp")} for w in waves],
        "enemy_stats": (d.get("enemyStats") if isinstance(d.get("enemyStats"), list)
                        else list((d.get("enemyStats") or {}).items()))[:20],
    }

SYSTEM = """You are Grandmaster, the strategy brain for a Thronefall autopilot.
Your job: be the best Thronefall player in the world. You have studied
every level, every enemy, every build order, every spawn corridor.

THRONEFALL RULES YOU KNOW:
- Day: build/upgrade structures with gold; each slot has branches.
- Night: enemies march along fixed spawn lines toward the castle.
- Troop buildings (barracks/archery/militia etc.) produce units that can
  be commanded or posted to hold positions.
- The hero is one unit; the ARMY is the army. A good player builds a big
  army, posts squads on threatened corridors OUTSIDE the walls, keeps a
  reserve, and only fights personally as last resort.
- Economy funds everything; broke = dead. Income buildings pay every day.
- Walls/towers/gates on a corridor slow and kill waves before they arrive.
- You may NOT cheat: no damage injection, no teleports, no god mode.
  Win with positioning, timing, economy, and troop placement.

You answer ONLY with the JSON object requested. No prose around it."""

PROMPT = """Here is real extracted data for the level '{scene}':

{data}

Produce the grandmaster strategy for this level as JSON:
{{
 "squad_size": <int, units per corridor squad>,
 "reserve_size": <int, units kept near castle>,
 "escort_size": <int, units following the hero>,
 "door_distance_m": <int, how far out on the corridor to post squads>,
 "army_target": <int, total units to produce>,
 "build_order": ["<class>:<why>", ...],  // classes: income, military,
                                       // wall, tower, gate, upgrade
 "wave_priority": [{{"line": "<spawn line name>",
                     "squad": <units>, "note": "<why>"}}],
 "hero_rules": ["<rule>", ...],
 "breach_rules": ["<rule>", ...],
 "economy_rules": ["<rule>", ...],
 "notes": "<3-sentence grandmaster summary>"
}}
Use the wave table: big/elite/ranged lines get bigger squads."""

def main():
    scene = "Durststein"
    if "--scene" in sys.argv:
        scene = sys.argv[sys.argv.index("--scene") + 1]
    digest = game_digest(scene)
    sys.stderr.write("[coach] digest: " + json.dumps(
        {k: (len(v) if isinstance(v, list) else v)
         for k, v in digest.items()}) + "\n")
    text, usage = chat([
        {"role": "system", "content": SYSTEM},
        {"role": "user", "content":
            PROMPT.format(scene=digest["scene"],
                          data=json.dumps(digest, indent=1))},
    ])
    sys.stderr.write(f"[coach] tokens: {usage}\n")
    (BOTPACK / f"strategy_{digest['scene'].lower()}.raw.txt").write_text(text)
    # tolerant JSON extraction
    start, end = text.find("{"), text.rfind("}")
    if start >= 0 and end > start:
        try:
            strat = json.loads(text[start:end + 1])
            out = BOTPACK / f"strategy_{digest['scene'].lower()}.json"
            out.write_text(json.dumps(strat, indent=2))
            print(f"WROTE {out}")
            print(json.dumps(strat, indent=2)[:3000])
            return
        except json.JSONDecodeError as e:
            sys.stderr.write(f"[coach] JSON parse failed: {e}\n")
    (BOTPACK / f"strategy_{digest['scene'].lower()}.md").write_text(text)
    print("saved as markdown (unstructured)")

if __name__ == "__main__":
    main()
