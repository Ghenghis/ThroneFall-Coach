// ===== SummoningCircle  (token 0x02000296) =====
  .method SummoningCircle::OnEnable()  // token 0x06000E32 rva 0x3f630 attrs Private, HideBySig
    // code size 74 (0x4a), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponentInParent()<SaveLoadEntity>  /*0x2B00001E*/
    IL_0007: callvirt string SaveLoadEntity::get_GUID()  /*0x06000D09*/
    IL_000c: call void SummoningCircle::ManualLoad(string)  /*0x06000E34*/
    IL_0011: ldarg.0
    IL_0012: ldfld bool SummoningCircle::hasBeenUsedAlready  /*0x0400107D*/
    IL_0017: brtrue.s IL_0049
    IL_0019: call Wave EnemySpawner::GetNextWave()  /*0x06000696*/
    IL_001e: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0023: ldarg.0
    IL_0024: ldfld List<Spawn> SummoningCircle::spawnsToAdd  /*0x0400107A*/
    IL_0029: callvirt void System.Collections.Generic.List<Spawn>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0005B5*/
    IL_002e: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0033: callvirt void EnemySpawner::DestroyMarkers()  /*0x0600068E*/
    IL_0038: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_003d: callvirt void EnemySpawner::PlaceMarkersForNextWave()  /*0x0600068B*/
    IL_0042: ldarg.0
    IL_0043: ldc.i4.1
    IL_0044: stfld bool SummoningCircle::hasBeenUsedAlready  /*0x0400107D*/
    IL_0049: ret

  .method SummoningCircle::OnSave(string)  // token 0x06000E33 rva 0x3f686 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 60 (0x3c), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0007: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_000c: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0011: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0016: ldstr "_"
    IL_001b: ldarg.0
    IL_001c: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0021: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0026: ldstr "_used"
    IL_002b: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0030: ldarg.0
    IL_0031: ldfld bool SummoningCircle::hasBeenUsedAlready  /*0x0400107D*/
    IL_0036: call void MatchSaveLoadHandler::SaveValue(string,string,bool)  /*0x06000CF8*/
    IL_003b: ret

  .method SummoningCircle::ManualLoad(string)  // token 0x06000E34 rva 0x3f6c4 attrs Private, HideBySig
    // code size 74 (0x4a), max stack 6, init locals
    IL_0000: call bool MatchSaveLoadHandler::get_IsLoadingPermitted()  /*0x06000CF2*/
    IL_0005: brtrue.s IL_0008
    IL_0007: ret
    IL_0008: ldarg.0
    IL_0009: ldarg.1
    IL_000a: ldarg.0
    IL_000b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0010: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_0015: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001a: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_001f: ldstr "_"
    IL_0024: ldarg.0
    IL_0025: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002a: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_002f: ldstr "_used"
    IL_0034: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0039: ldarg.0
    IL_003a: ldflda bool SummoningCircle::hasBeenUsedAlready  /*0x0400107D*/
    IL_003f: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<bool>  /*0x2B000047*/
    IL_0044: stfld bool SummoningCircle::hasBeenUsedAlready  /*0x0400107D*/
    IL_0049: ret

  .method SummoningCircle::OnBeforeMainLoadPass(string)  // token 0x06000E35 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SummoningCircle::OnLoad(string)  // token 0x06000E36 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SummoningCircle::OnAfterMainLoadPass(string)  // token 0x06000E37 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SummoningCircle::.ctor()  // token 0x06000E38 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

