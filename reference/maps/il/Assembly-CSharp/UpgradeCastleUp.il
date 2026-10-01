// ===== UpgradeCastleUp  (token 0x0200023D) =====
  .method UpgradeCastleUp::OnEnable()  // token 0x06000C4D rva 0x394f7 attrs Private, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: ldarg.0
    IL_000c: stsfld UpgradeCastleUp UpgradeCastleUp::instance  /*0x04000F0E*/
    IL_0011: call bool LocalMatchSaveLoad::get_CurrentlyLoadingMatch()  /*0x06000CD7*/
    IL_0016: brtrue.s IL_002b
    IL_0018: ldarg.0
    IL_0019: ldfld List<TagManager.ETag> UpgradeCastleUp::mustHaveTags  /*0x04000F11*/
    IL_001e: ldc.i4.s 21
    IL_0020: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0025: ldarg.0
    IL_0026: call void UpgradeCastleUp::DecreasePriceOfWallsAndTowers()  /*0x06000C51*/
    IL_002b: ret

  .method UpgradeCastleUp::OnDusk()  // token 0x06000C4E rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UpgradeCastleUp::OnDawn_BeforeSunrise()  // token 0x06000C4F rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UpgradeCastleUp::OnDawn_AfterSunrise()  // token 0x06000C50 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UpgradeCastleUp::DecreasePriceOfWallsAndTowers()  // token 0x06000C51 rva 0x39524 attrs Private, HideBySig
    // code size 76 (0x4c), max stack 4, init locals
    .locals ([0] int, [1] BuildSlot)
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: ldarg.0
    IL_0006: ldfld List<TaggedObject> UpgradeCastleUp::allWallsAndTowers  /*0x04000F13*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<TagManager.ETag> UpgradeCastleUp::mustHaveTags  /*0x04000F11*/
    IL_0011: ldarg.0
    IL_0012: ldfld List<TagManager.ETag> UpgradeCastleUp::mayNotHaveTags  /*0x04000F12*/
    IL_0017: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_001c: ldc.i4.0
    IL_001d: stloc.0
    IL_001e: br.s IL_003d
    IL_0020: ldarg.0
    IL_0021: ldfld List<TaggedObject> UpgradeCastleUp::allWallsAndTowers  /*0x04000F13*/
    IL_0026: ldloc.0
    IL_0027: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_002c: callvirt !!0 UnityEngine.Component::GetComponentInParent()<BuildSlot>  /*0x2B000004*/
    IL_0031: stloc.1
    IL_0032: ldarg.0
    IL_0033: ldloc.1
    IL_0034: call void UpgradeCastleUp::DecreasePriceOfWallOrTower(BuildSlot)  /*0x06000C52*/
    IL_0039: ldloc.0
    IL_003a: ldc.i4.1
    IL_003b: add
    IL_003c: stloc.0
    IL_003d: ldloc.0
    IL_003e: ldarg.0
    IL_003f: ldfld List<TaggedObject> UpgradeCastleUp::allWallsAndTowers  /*0x04000F13*/
    IL_0044: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0049: blt.s IL_0020
    IL_004b: ret

  .method UpgradeCastleUp::DecreasePriceOfWallOrTower(BuildSlot)  // token 0x06000C52 rva 0x3957c attrs Public, HideBySig
    // code size 78 (0x4e), max stack 4, init locals
    IL_0000: ldarg.1
    IL_0001: callvirt bool BuildSlot::get_ActivatorUpgradesThis()  /*0x060002D0*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.1
    IL_000a: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_000f: ldc.i4.1
    IL_0010: bne.un.s IL_002b
    IL_0012: ldarg.1
    IL_0013: ldc.i4.1
    IL_0014: ldarg.1
    IL_0015: callvirt int BuildSlot::get_NextUpgradeOrBuildCost()  /*0x060002E6*/
    IL_001a: ldarg.0
    IL_001b: ldfld int UpgradeCastleUp::immediateWallAndTowerDiscount2  /*0x04000F0F*/
    IL_0020: sub
    IL_0021: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_0026: callvirt void BuildSlot::set_NextUpgradeOrBuildCost(int)  /*0x060002E7*/
    IL_002b: ldarg.1
    IL_002c: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0031: ldc.i4.2
    IL_0032: bne.un.s IL_004d
    IL_0034: ldarg.1
    IL_0035: ldc.i4.1
    IL_0036: ldarg.1
    IL_0037: callvirt int BuildSlot::get_NextUpgradeOrBuildCost()  /*0x060002E6*/
    IL_003c: ldarg.0
    IL_003d: ldfld int UpgradeCastleUp::immediateWallAndTowerDiscount3  /*0x04000F10*/
    IL_0042: sub
    IL_0043: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_0048: callvirt void BuildSlot::set_NextUpgradeOrBuildCost(int)  /*0x060002E7*/
    IL_004d: ret

  .method UpgradeCastleUp::OnDuskEarly()  // token 0x06000C53 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UpgradeCastleUp::OnBeforeMainLoadPass(string)  // token 0x06000C54 rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UpgradeCastleUp::.ctor()  // token 0x06000C55 rva 0x395d6 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 54 (0x36), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.2
    IL_0002: stfld int UpgradeCastleUp::immediateWallAndTowerDiscount2  /*0x04000F0F*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.4
    IL_0009: stfld int UpgradeCastleUp::immediateWallAndTowerDiscount3  /*0x04000F10*/
    IL_000e: ldarg.0
    IL_000f: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0014: stfld List<TagManager.ETag> UpgradeCastleUp::mustHaveTags  /*0x04000F11*/
    IL_0019: ldarg.0
    IL_001a: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_001f: stfld List<TagManager.ETag> UpgradeCastleUp::mayNotHaveTags  /*0x04000F12*/
    IL_0024: ldarg.0
    IL_0025: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_002a: stfld List<TaggedObject> UpgradeCastleUp::allWallsAndTowers  /*0x04000F13*/
    IL_002f: ldarg.0
    IL_0030: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0035: ret

