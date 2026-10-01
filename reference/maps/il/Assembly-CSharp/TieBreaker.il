// ===== TieBreaker  (token 0x020002B7) =====
  .method TieBreaker::Awake()  // token 0x06000EEC rva 0x430cb attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld TieBreaker TieBreaker::instance  /*0x0400113E*/
    IL_0006: ret

  .method TieBreaker::Start()  // token 0x06000EED rva 0x430d3 attrs Private, HideBySig
    // code size 59 (0x3b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0006: stfld EnemySpawner TieBreaker::spawner  /*0x0400113F*/
    IL_000b: ldarg.0
    IL_000c: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0011: stfld TagManager TieBreaker::tagManager  /*0x04001140*/
    IL_0016: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_001b: ldarg.0
    IL_001c: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0021: ldarg.0
    IL_0022: ldfld List<TagManager.ETag> TieBreaker::mustHaveBuildings  /*0x0400113C*/
    IL_0027: ldc.i4.8
    IL_0028: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_002d: ldarg.0
    IL_002e: ldfld List<TagManager.ETag> TieBreaker::mustHaveBuildings  /*0x0400113C*/
    IL_0033: ldc.i4.s 10
    IL_0035: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_003a: ret

  .method TieBreaker::OnDuskEarly()  // token 0x06000EEE rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TieBreaker::OnDusk()  // token 0x06000EEF rva 0x4310f attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool TieBreaker::active  /*0x04001141*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.m1
    IL_0009: stfld int TieBreaker::enemiesLeftRemember  /*0x04001142*/
    IL_000e: ldarg.0
    IL_000f: ldc.i4.m1
    IL_0010: stfld int TieBreaker::buildingsLeftRemember  /*0x04001143*/
    IL_0015: ldarg.0
    IL_0016: ldc.r4 0f
    IL_001b: stfld float TieBreaker::timeupForTieBreaker  /*0x04001144*/
    IL_0020: ldarg.0
    IL_0021: ldc.i4.0
    IL_0022: stfld bool TieBreaker::tieBreakingActive  /*0x04001145*/
    IL_0027: ret

  .method TieBreaker::OnDawn_AfterSunrise()  // token 0x06000EF0 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TieBreaker::OnDawn_BeforeSunrise()  // token 0x06000EF1 rva 0x43138 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool TieBreaker::active  /*0x04001141*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.0
    IL_0009: stfld bool TieBreaker::tieBreakingActive  /*0x04001145*/
    IL_000e: ret

  .method TieBreaker::Update()  // token 0x06000EF2 rva 0x43148 attrs Private, HideBySig
    // code size 220 (0xdc), max stack 4, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld bool TieBreaker::tieBreakingActive  /*0x04001145*/
    IL_0006: brfalse.s IL_000f
    IL_0008: ldarg.0
    IL_0009: call void TieBreaker::TieBreak()  /*0x06000EF3*/
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld bool TieBreaker::active  /*0x04001141*/
    IL_0015: brtrue.s IL_0018
    IL_0017: ret
    IL_0018: ldarg.0
    IL_0019: ldfld EnemySpawner TieBreaker::spawner  /*0x0400113F*/
    IL_001e: callvirt bool EnemySpawner::get_SpawningInProgress()  /*0x0600066C*/
    IL_0023: brfalse.s IL_0026
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldarg.0
    IL_0028: ldfld float TieBreaker::timeupForTieBreaker  /*0x04001144*/
    IL_002d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0032: add
    IL_0033: stfld float TieBreaker::timeupForTieBreaker  /*0x04001144*/
    IL_0038: ldarg.0
    IL_0039: ldfld TagManager TieBreaker::tagManager  /*0x04001140*/
    IL_003e: ldc.i4.s 28
    IL_0040: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_0045: ldc.i4.0
    IL_0046: ble.s IL_0053
    IL_0048: ldarg.0
    IL_0049: ldc.r4 0f
    IL_004e: stfld float TieBreaker::timeupForTieBreaker  /*0x04001144*/
    IL_0053: ldarg.0
    IL_0054: ldfld EnemySpawner TieBreaker::spawner  /*0x0400113F*/
    IL_0059: callvirt int EnemySpawner::get_NumberOfEnemiesOnTheMap()  /*0x0600067B*/
    IL_005e: ldarg.0
    IL_005f: ldfld int TieBreaker::enemiesLeftRemember  /*0x04001142*/
    IL_0064: beq.s IL_0082
    IL_0066: ldarg.0
    IL_0067: ldc.r4 0f
    IL_006c: stfld float TieBreaker::timeupForTieBreaker  /*0x04001144*/
    IL_0071: ldarg.0
    IL_0072: ldarg.0
    IL_0073: ldfld EnemySpawner TieBreaker::spawner  /*0x0400113F*/
    IL_0078: callvirt int EnemySpawner::get_NumberOfEnemiesOnTheMap()  /*0x0600067B*/
    IL_007d: stfld int TieBreaker::enemiesLeftRemember  /*0x04001142*/
    IL_0082: ldarg.0
    IL_0083: ldfld TagManager TieBreaker::tagManager  /*0x04001140*/
    IL_0088: ldarg.0
    IL_0089: ldfld List<TaggedObject> TieBreaker::findTemp  /*0x04001146*/
    IL_008e: ldarg.0
    IL_008f: ldfld List<TagManager.ETag> TieBreaker::mustHaveBuildings  /*0x0400113C*/
    IL_0094: ldarg.0
    IL_0095: ldfld List<TagManager.ETag> TieBreaker::mayNotHaveBuildings  /*0x0400113D*/
    IL_009a: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_009f: ldarg.0
    IL_00a0: ldfld List<TaggedObject> TieBreaker::findTemp  /*0x04001146*/
    IL_00a5: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_00aa: stloc.0
    IL_00ab: ldarg.0
    IL_00ac: ldfld int TieBreaker::buildingsLeftRemember  /*0x04001143*/
    IL_00b1: ldloc.0
    IL_00b2: beq.s IL_00c6
    IL_00b4: ldarg.0
    IL_00b5: ldc.r4 0f
    IL_00ba: stfld float TieBreaker::timeupForTieBreaker  /*0x04001144*/
    IL_00bf: ldarg.0
    IL_00c0: ldloc.0
    IL_00c1: stfld int TieBreaker::buildingsLeftRemember  /*0x04001143*/
    IL_00c6: ldarg.0
    IL_00c7: ldfld float TieBreaker::timeupForTieBreaker  /*0x04001144*/
    IL_00cc: ldarg.0
    IL_00cd: ldfld float TieBreaker::requiredTimeWithNoDeathsOrDestroyedBuildings  /*0x0400113A*/
    IL_00d2: ble.un.s IL_00db
    IL_00d4: ldarg.0
    IL_00d5: ldc.i4.1
    IL_00d6: stfld bool TieBreaker::tieBreakingActive  /*0x04001145*/
    IL_00db: ret

  .method TieBreaker::TieBreak()  // token 0x06000EF3 rva 0x43230 attrs Private, HideBySig
    // code size 71 (0x47), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld TagManager TieBreaker::tagManager  /*0x04001140*/
    IL_0006: ldarg.0
    IL_0007: ldfld List<TaggedObject> TieBreaker::findTemp  /*0x04001146*/
    IL_000c: ldc.i4.1
    IL_000d: callvirt void TagManager::FindAllTaggedObjectsWithTag(System.Collections.Generic.List<TaggedObject>,TagManager.ETag)  /*0x06000E5C*/
    IL_0012: ldarg.0
    IL_0013: ldfld List<TaggedObject> TieBreaker::findTemp  /*0x04001146*/
    IL_0018: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_001d: ldc.i4.0
    IL_001e: ble.s IL_0046
    IL_0020: ldarg.0
    IL_0021: ldfld List<TaggedObject> TieBreaker::findTemp  /*0x04001146*/
    IL_0026: ldc.i4.0
    IL_0027: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_002c: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0031: ldarg.0
    IL_0032: ldfld float TieBreaker::damagePerSecond  /*0x0400113B*/
    IL_0037: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_003c: mul
    IL_003d: ldnull
    IL_003e: ldc.i4.0
    IL_003f: ldc.i4.0
    IL_0040: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0045: pop
    IL_0046: ret

  .method TieBreaker::.ctor()  // token 0x06000EF4 rva 0x43284 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 76 (0x4c), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 30f
    IL_0006: stfld float TieBreaker::requiredTimeWithNoDeathsOrDestroyedBuildings  /*0x0400113A*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 10f
    IL_0011: stfld float TieBreaker::damagePerSecond  /*0x0400113B*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_001c: stfld List<TagManager.ETag> TieBreaker::mustHaveBuildings  /*0x0400113C*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0027: stfld List<TagManager.ETag> TieBreaker::mayNotHaveBuildings  /*0x0400113D*/
    IL_002c: ldarg.0
    IL_002d: ldc.i4.m1
    IL_002e: stfld int TieBreaker::enemiesLeftRemember  /*0x04001142*/
    IL_0033: ldarg.0
    IL_0034: ldc.i4.m1
    IL_0035: stfld int TieBreaker::buildingsLeftRemember  /*0x04001143*/
    IL_003a: ldarg.0
    IL_003b: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0040: stfld List<TaggedObject> TieBreaker::findTemp  /*0x04001146*/
    IL_0045: ldarg.0
    IL_0046: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_004b: ret

