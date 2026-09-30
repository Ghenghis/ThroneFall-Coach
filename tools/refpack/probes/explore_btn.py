import sys, json
sys.path.insert(0, r"K:\Downloads-IDM\Thronefall\Trainer\tools\refpack")
import tf_assets as A
g = A.Game(r"K:\Downloads-IDM\Thronefall\Thronefall_Data", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
f = g.file("level2")
n=0
for pid,m in f.monobehaviours("TFUITextButton"):
    path=f.path(m.go)
    if 'Title Frame' in path or 'After Match' in path:
        print(path, json.dumps(m.v, ensure_ascii=False, default=str)[:900]); n+=1
    if n>=4: break
import re
src=open(r"K:\Downloads-IDM\Thronefall\Trainer\decompiled\TFUITextButton.cs",encoding='utf-8').read()
print(src[:1800])
