import sys, os, collections, json, time
sys.path.insert(0, r"K:\Downloads-IDM\Thronefall\Trainer\tools\refpack")
import tf_assets as A
t=time.time()
g = A.Game(r"K:\Downloads-IDM\Thronefall\Thronefall_Data", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
print("game ready %.1fs; scenes=%d" % (time.time()-t, len(g.scene_names)))
for scene in ["Neuland(Tutorial)", "Nordfels"]:
    f = g.file(g.scene_file(scene))
    idx = f.class_index()
    print("\n==", scene, f.name, "objects", len(f.sf.objects), "MB classes", len(idx))
    print(sorted(((len(v),k) for k,v in idx.items()), reverse=True)[:45])
    for pid, m in f.monobehaviours("EnemySpawner"):
        v = m.v
        print("EnemySpawner pid", pid, "go", f.go(m.go)["name"], "mode", v["currentMode"], "goldStart", v["goldBalanceAtStart"], "endless", v["endlessMode"], "waves", len(v["waves"]), "pauseAt", v["pauseSpawningAtEnemyCount"], "reduceWait", v["reduceSpawnWaitTimes"])
        for i, w in enumerate(v["waves"][:3]):
            print("  wave", i, repr(w["warningText"]), "diff", w["difficultyMulti"], "spawns", len(w["spawns"]))
            for s in w["spawns"][:3]:
                pf = f.ref(s["enemyPrefab"]); sl = f.ref(s["spawnLine"])
                print("     ", {k: s[k] for k in ("delay","eliteEnemies","count","interval","goldCoins","waitBeforeNextSpawn")}, "prefab", pf, "line", sl)
