# 11 · Code-map index — the mapping files

*'Mapping file' here means machine-readable indexes of the game's code and data: which classes exist, what fields they serialize, who calls whom, where every value lives. Nothing was deobfuscated: Thronefall ships a Mono build with original names, so the map is pure metadata + IL analysis (`tools/refpack/TfMap`).*

## Inventory

| File | What it is | Size / count |
|---|---|---|
| `maps/assemblies.json` | every managed DLL: version, MVID, sha256, type/method/field counts, references | 168 assemblies |
| `maps/code/<asm>.types.jsonl` | one JSON object per type: base chain, flags, attributes, fields (serialized?, const), properties, methods (token, RVA, IL size, Unity message, inline risk) | 4,284 types |
| `maps/il/<asm>/<Type>.il` | readable IL disassembly of every game method with resolved operands | 5,297 method bodies, 365,426 IL bytes |
| `maps/code/<asm>.methods.tsv` | method id → token, key, logical owner (coroutines/lambdas mapped to their source method) | 5,348 methods |
| `maps/code/<asm>.xrefs.jsonl` | per method: calls, field reads/writes, string literals, type references, with IL offsets |  |
| `maps/code/callers.json` | callee key → ids of calling methods (reverse call graph) | 4,655 callees |
| `maps/code/field_readers.json`, `field_writers.json` | field key → ids of methods that read/write it | 5,701 read, 3,681 written |
| `maps/code/enums_all.json` | all enums of all assemblies (Unity, Rewired, game) with values | 3,599 enums |
| `maps/code/singletons.md` | static instance accessors of game classes | 64 classes |
| `maps/serialization/layouts.json` (+ `layouts.txt`) | Unity serialization layout of every script class (what the asset files contain, in order) | 1470 scripts, all verified byte-exact |
| `maps/serialization/class_layouts.json` | layouts of classes stored behind `[SerializeReference]` | 152 classes |
| `verification/layout_check*.json` | byte-exact proof of the layouts against the real assets (both builds) | 655,330 + 655,157 objects |

## Composition of the game code

| Measure | Value |
|---|---|
| Game types (excl. vendor & compiler-generated) | 950 |
| Kinds | class: 857, enum: 73, struct: 15, interface: 5 |
| Unity roles | MonoBehaviour: 566, None: 348, ScriptableObject: 36 |
| Most common Unity messages | Start (291), Update (222), OnEnable (94), Awake (79), OnDisable (26), OnDestroy (15), OnValidate (4), Reset (4) |

## Example queries

```python
import json
# who calls Hp.TakeDamage?
c = json.load(open('maps/code/callers.json'))
ids = c['Hp::TakeDamage(float,TaggedObject,bool,bool)']
# which methods write EnemySpawner.wavenumber?
w = json.load(open('maps/code/field_writers.json'))['EnemySpawner::wavenumber']
```
```powershell
# find every IL mention of a string literal / method
Select-String -Path reference\maps\il\Assembly-CSharp\*.il -Pattern 'Call Night'
```
