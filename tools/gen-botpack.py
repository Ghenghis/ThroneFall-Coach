import json, glob, os, csv

# Generates agent/botpack/<scene>.json — the flat per-scene pack the plugin
# consumes (castle+stands, slots, spawn routes, gates, waves, enemy stats,
# level meta). Same format family agreed with claude-refpack; produced from
# the already-delivered reference/ extraction so work isn't blocked on him.

base = r'K:\Downloads-IDM\Thronefall\Trainer\reference\data'
dst  = r'K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent\botpack'

terr = {os.path.splitext(os.path.basename(f))[0]: f for f in glob.glob(base + r'\terrain\*.json')}
nav  = {os.path.splitext(os.path.basename(f))[0]: f for f in glob.glob(base + r'\navmesh\*.json')}
lvl  = {os.path.splitext(os.path.basename(f))[0]: f for f in glob.glob(base + r'\levels\*.json')}

def scene_name(fp):
    # No-underscore filenames used to IndexError on BOTH paths (the except
    # re-threw the same expression). Fall back to the full stem.
    fb = os.path.basename(fp)
    parts = os.path.splitext(fb)[0].split('_', 1)
    try:
        with open(fp, encoding='utf-8') as fh:
            return json.load(fh).get('scene') or parts[1] if len(parts) > 1 else parts[0]
    except Exception:
        return parts[1] if len(parts) > 1 else parts[0]

waves = {}
for row in csv.DictReader(open(base + r'\waves_all.csv', encoding='utf-8-sig')):
    waves.setdefault(row['scene'], []).append(row)

ep = json.load(open(base + r'\enemy_prefabs.json'))
enemies = {}
for k, e in ep.items():
    if isinstance(e, dict) and e.get('name'):
        aa = (e.get('attacks') or [{}])[0]
        enemies[e['name']] = {
            'disp': e.get('displayName'), 'hp': e.get('maxHp'), 'speed': e.get('speed'),
            'rng': aa.get('range'), 'cd': aa.get('cooldown'), 'dmg': aa.get('baseDamage'),
            'gold': e.get('coinDrop', 0), 'tags': e.get('tags', [])[:4]}

built = 0
for key, tf in sorted(terr.items()):
    t = json.load(open(tf))
    sc = scene_name(tf)
    out = {'scene': sc}
    out['castle'] = next((s for s in t.get('slots', [])
                          if s.get('building') == 'Castle Center' or 'astle' in str(s.get('name', ''))), None)
    out['slots'] = t.get('slots', [])
    out['gates'] = t.get('gates', [])

    nf = nav.get(key)
    if nf:
        n = json.load(open(nf))
        out['castlePos'] = (n.get('castle') or [[None] * 3])[0]
        out['spawns'] = [{'line': r.get('line'), 'spawn': r.get('spawnCenterXZ'),
                          'wp': r.get('waypoints', []), 'lenM': r.get('lengthM'),
                          'fly': r.get('canSpawnFlying'), 'ground': r.get('canSpawnSmallGround'),
                          'narrowM': r.get('narrowestClearanceM'), 'narrowAt': r.get('narrowestAtXZ')}
                         for r in n.get('enemyRoutes', [])]

    wsc = waves.get(sc) or []
    if not wsc:
        for k2 in waves:
            if k2.split('(')[0].strip() == sc:
                wsc = waves[k2]
                break
    def fnum(v, d=0.0):
        try:
            return float(v)
        except (TypeError, ValueError):
            return d
    out['waves'] = [{'wave': int(fnum(r['night'])), 'count': int(fnum(r['count'])),
                     'enemy': r['enemy'], 'disp': r['displayName'], 'elite': r['elite'] == 'True',
                     'gold': int(fnum(r['goldCoins'])), 'line': r['spawnLine'],
                     'hp': fnum(r['maxHp'])} for r in wsc]
    out['enemyStats'] = enemies

    lf = lvl.get(key)
    if lf:
        l = json.load(open(lf))
        out['level'] = {'buildIndex': l.get('buildIndex'), 'kind': l.get('kind'),
                        'dayNight': l.get('dayNight'), 'autoDayNight': l.get('autoDayNight'),
                        'nightCall': l.get('nightCall')}

    os.makedirs(dst, exist_ok=True)   # fresh checkout crashed on missing dir
    with open(os.path.join(dst, sc + '.json'), 'w', encoding='utf-8') as fh:
        json.dump(out, fh)   # default cp1252 mojibake'd non-ASCII displayNames
    built += 1

print('botpack scenes written:', built)
