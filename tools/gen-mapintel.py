import json, glob, os, math

# v3.5 map-intel generator: synthesizes strategy_<scene>.auto.json from the
# extracted botpack (<scene>.json) — spawn corridors, chokepoint widths, wave
# composition, build-slot inventory. The plugin prefers hand-tuned
# strategy_<scene>.json and falls back to the .auto draft, so any map (even a
# never-seen one) gets a competent playbook instead of hardcoded defaults.
#
# Consumed fields (BotPerception.LoadStrategy):
#   squad_size, reserve_size, escort_size, army_target, door_distance_m,
#   build_order[], wave_priority[{line,squad,note}], build_focus,
#   hero_rules, breach_rules, economy_rules, notes (free text, advisory).

base = r'K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent\botpack'
dst = base  # strategy_*.auto.json sits next to the hand packs

def cat_of(building_name):
    """Mirror of BotPerception.BuildCat — keep categories identical."""
    n = (building_name or '').lower()
    if 'gate' in n: return 'gate'
    if 'wall' in n or 'palisade' in n or 'fence' in n: return 'wall'
    if 'tower' in n or 'ballista' in n or 'catapult' in n or 'mortar' in n: return 'tower'
    if ('barrack' in n or 'archer' in n or 'militia' in n or 'knight' in n
            or 'siege' in n or 'stable' in n): return 'military'
    if ('castle' in n or 'keep' in n): return 'castle'
    if ('shrine' in n or 'temple' in n or 'altar' in n): return 'shrine'
    return 'income'   # house/farm/mill/mine/tavern/fishing etc.

def dist(a, b):
    return math.hypot(a[0] - b[0], a[1] - b[1])

built = []
for fp in sorted(glob.glob(os.path.join(base, '*.json'))):
    bn = os.path.basename(fp)
    if bn.startswith(('strategy_', 'policystats', 'monitor')):
        continue
    b = json.load(open(fp, encoding='utf-8'))
    sc = b.get('scene') or os.path.splitext(bn)[0]
    spawns = b.get('spawns') or []
    waves = b.get('waves') or []
    slots = b.get('slots') or []
    gates = b.get('gates') or []
    cp = b.get('castlePos') or [0, 0, 0]

    # ---- per-line risk weighting ----
    lines = {}
    for s in spawns:
        lines.setdefault(s['line'], {'foes': 0, 'hp': 0.0, 'elite': 0,
                                     'fly': bool(s.get('fly')), 'ground': bool(s.get('ground')),
                                     'lenM': s.get('lenM') or 0.0,
                                     'narrowM': s.get('narrowM') or 99.0})
        lines[s['line']]['fly'] |= bool(s.get('fly'))
        lines[s['line']]['ground'] |= bool(s.get('ground'))
        lines[s['line']]['narrowM'] = min(lines[s['line']]['narrowM'], s.get('narrowM') or 99.0)
    for w in waves:
        ln = w.get('line') or ''
        for k in (ln,) if ln in lines else [k for k in lines if ln.startswith(k)]:
            lines[k]['foes'] += w.get('count', 0)
            lines[k]['hp'] += w.get('count', 0) * w.get('hp', 0)
            lines[k]['elite'] += 1 if w.get('elite') else 0
    # fly-only lanes can't be stopped by walls — squads still cover them
    # (archers), so weight them normally rather than zero.
    order = sorted(lines.items(), key=lambda kv: (-(kv[1]['foes'] + kv[1]['elite'] * 8),
                                                  kv[1]['narrowM']))
    wave_priority = []
    max_foes = max((v['foes'] for v in lines.values()), default=1) or 1
    for ln, v in order:
        frac = (v['foes'] + v['elite'] * 8) / max(1, max_foes + 8)
        squad = max(3, min(8, round(3 + frac * 5)))
        note = []
        if v['elite']: note.append(f"{v['elite']} elite waves")
        if v['fly'] and not v['ground']: note.append('air-only: walls useless, archer squad')
        elif v['fly']: note.append('mixed air+ground')
        if v['narrowM'] < 3: note.append(f"{v['narrowM']:.1f}m choke")
        if v['foes'] == 0: note.append('no waves seen — pre-post to avoid scramble')
        wave_priority.append({'line': ln, 'squad': squad,
                              'note': f"{v['foes']} foes; {'; '.join(note) or 'coverage'}"})

    # ---- army sizing: scale to the biggest single night ----
    per_night = {}
    for w in waves:
        per_night[w.get('wave', 0)] = per_night.get(w.get('wave', 0), 0) + w.get('count', 0)
    biggest = max(per_night.values() or [10])
    army_target = max(15, min(60, int(round(biggest * 0.42))))
    squad_size = max(3, min(8, int(round(sum(p['squad'] for p in wave_priority) /
                                         max(1, len(wave_priority))))) if wave_priority else 5)
    escort_size = 2 if any(w.get('elite') for w in waves) else 0
    reserve_size = 4

    # ---- door anchoring: between castle and corridor narrows ----
    nd = [dist(s['narrowAt'], [cp[0], cp[2]]) for s in spawns
          if s.get('narrowAt') and cp]
    door_distance_m = round(min(80.0, max(35.0,
        (sorted(nd)[len(nd) // 2] * 0.55 if nd else 45.0))), 1)

    # ---- build order from the slot inventory ----
    have = {}
    for s in slots:
        have[cat_of(s.get('building'))] = have.get(cat_of(s.get('building')), 0) + 1
    any_fly = any(v['fly'] for v in lines.values())
    many_ground = sum(1 for v in lines.values() if v['ground'])
    bo = []
    if have.get('income'): bo += ['income:opening income', 'income:second income']
    if have.get('military'): bo += ['military:first barracks before the early wave',
                                    'military:second military by mid-game']
    if any_fly and have.get('tower'): bo.append('tower:AA coverage on the air lane before flyers')
    if have.get('wall') and many_ground >= 2:
        bo += ['wall:chokepoint wall on the tightest ground corridor',
               'wall:second corridor wall']
    if have.get('gate') and any(v['elite'] for v in lines.values()):
        bo.append('gate:gate on the elite lane to vent without breaking')
    if have.get('tower'): bo.append('tower:choker tower overlapping squads')
    if have.get('castle'): bo.append('castle:castle upgrade when economy allows')

    focus = 'defense' if any_fly or many_ground >= 4 else ('military' if many_ground >= 2 else 'balanced')

    out = {
        '_generated': 'gen-mapintel.py — heuristic draft; hand strategy_*.json wins if present',
        'squad_size': squad_size, 'reserve_size': reserve_size,
        'escort_size': escort_size, 'army_target': army_target,
        'door_distance_m': door_distance_m, 'build_focus': focus,
        'build_order': bo, 'wave_priority': wave_priority,
        'hero_rules': 'stall elites (elite_stall_hp); build while squads fight' if
                      any(v['elite'] for v in lines.values()) else 'builder posture; self-defense only',
        'breach_rules': 'rebuild knocked-out walls between waves (blost tracking)',
        'economy_rules': f"{have.get('income', 0)} income slots; harvest-first when broke",
        'notes': f"{len(spawns)} routes ({sum(1 for v in lines.values() if v['fly'])} air-capable), "
                 f"{len(slots)} slots {dict(have)}, biggest night={biggest} foes",
        'objective': (b.get('level') or {}).get('kind') or 'standard',
    }

    outp = os.path.join(dst, 'strategy_' + sc.lower() + '.auto.json')
    with open(outp, 'w', encoding='utf-8') as fh:
        json.dump(out, fh, ensure_ascii=False, indent=1)
    built.append(sc)
    print(f"{sc:26s} at={army_target:2d} sq={squad_size} doors={len(spawns)} "
          f"doorDist={door_distance_m:5.1f} focus={focus}")

print('auto strategies written:', len(built))
