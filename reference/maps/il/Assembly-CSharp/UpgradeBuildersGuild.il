// ===== UpgradeBuildersGuild  (token 0x0200023B) =====
  .method UpgradeBuildersGuild::get_Instance()  // token 0x06000C35 rva 0x39191 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld UpgradeBuildersGuild UpgradeBuildersGuild::instance  /*0x04000F05*/
    IL_0005: ret

  .method UpgradeBuildersGuild::OnEnable()  // token 0x06000C36 rva 0x39198 attrs Private, HideBySig
    // code size 91 (0x5b), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld List<TagManager.ETag> UpgradeBuildersGuild::mustHaveTags  /*0x04000F06*/
    IL_0006: ldc.i4.s 20
    IL_0008: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_000d: brtrue.s IL_001c
    IL_000f: ldarg.0
    IL_0010: ldfld List<TagManager.ETag> UpgradeBuildersGuild::mustHaveTags  /*0x04000F06*/
    IL_0015: ldc.i4.s 20
    IL_0017: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_001c: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0021: ldarg.0
    IL_0022: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0027: ldarg.0
    IL_0028: stsfld UpgradeBuildersGuild UpgradeBuildersGuild::instance  /*0x04000F05*/
    IL_002d: ldarg.0
    IL_002e: ldarg.0
    IL_002f: call !!0 UnityEngine.Component::GetComponentInParent()<SaveLoadEntity>  /*0x2B00001E*/
    IL_0034: callvirt string SaveLoadEntity::get_GUID()  /*0x06000D09*/
    IL_0039: call void UpgradeBuildersGuild::ManualLoad(string)  /*0x06000C40*/
    IL_003e: ldarg.0
    IL_003f: ldfld bool UpgradeBuildersGuild::hasBeenUsedAlready  /*0x04000F0A*/
    IL_0044: brtrue.s IL_005a
    IL_0046: ldarg.0
    IL_0047: ldarg.0
    IL_0048: call IEnumerator UpgradeBuildersGuild::UpgradeAHouseWithDelay()  /*0x06000C3C*/
    IL_004d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0052: pop
    IL_0053: ldarg.0
    IL_0054: ldc.i4.1
    IL_0055: stfld bool UpgradeBuildersGuild::hasBeenUsedAlready  /*0x04000F0A*/
    IL_005a: ret

  .method UpgradeBuildersGuild::OnDisable()  // token 0x06000C37 rva 0x391ff attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldnull
    IL_0001: stsfld UpgradeBuildersGuild UpgradeBuildersGuild::instance  /*0x04000F05*/
    IL_0006: ret

  .method UpgradeBuildersGuild::OnDuskEarly()  // token 0x06000C38 rva 0x39207 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UpgradeBuildersGuild::UpgradeAHouse()  /*0x06000C3D*/
    IL_0006: ret

  .method UpgradeBuildersGuild::OnDusk()  // token 0x06000C39 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UpgradeBuildersGuild::OnDawn_BeforeSunrise()  // token 0x06000C3A rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UpgradeBuildersGuild::OnDawn_AfterSunrise()  // token 0x06000C3B rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UpgradeBuildersGuild::UpgradeAHouseWithDelay()  // token 0x06000C3C rva 0x3920f attrs Public, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::.ctor(int)  /*0x06000C47*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld UpgradeBuildersGuild UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::<>4__this  /*0x04000F0D*/
    IL_000d: ret

  .method UpgradeBuildersGuild::UpgradeAHouse()  // token 0x06000C3D rva 0x39220 attrs Private, HideBySig
    // code size 121 (0x79), max stack 4, init locals
    .locals ([0] int, [1] BuildSlot)
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: ldarg.0
    IL_0006: ldfld List<TaggedObject> UpgradeBuildersGuild::allHousesTaggedObjs  /*0x04000F08*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<TagManager.ETag> UpgradeBuildersGuild::mustHaveTags  /*0x04000F06*/
    IL_0011: ldarg.0
    IL_0012: ldfld List<TagManager.ETag> UpgradeBuildersGuild::mayNotHaveTags  /*0x04000F07*/
    IL_0017: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_001c: ldarg.0
    IL_001d: ldarg.0
    IL_001e: ldfld List<TaggedObject> UpgradeBuildersGuild::allHousesTaggedObjs  /*0x04000F08*/
    IL_0023: ldarg.0
    IL_0024: ldftn float UpgradeBuildersGuild::<UpgradeAHouse>b__15_0(TaggedObject)  /*0x06000C45*/
    IL_002a: newobj void System.Func<TaggedObject, float>::.ctor(object,IntPtr)  /*0x0A000515*/
    IL_002f: call IOrderedEnumerable<!!0> System.Linq.Enumerable::OrderBy(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, !!1>)<TaggedObject,float>  /*0x2B0000B5*/
    IL_0034: call List<!!0> System.Linq.Enumerable::ToList(System.Collections.Generic.IEnumerable<!!0>)<TaggedObject>  /*0x2B0000B6*/
    IL_0039: stfld List<TaggedObject> UpgradeBuildersGuild::allHousesTaggedObjsSorted  /*0x04000F09*/
    IL_003e: ldc.i4.0
    IL_003f: stloc.0
    IL_0040: br.s IL_006a
    IL_0042: ldarg.0
    IL_0043: ldfld List<TaggedObject> UpgradeBuildersGuild::allHousesTaggedObjs  /*0x04000F08*/
    IL_0048: ldloc.0
    IL_0049: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_004e: callvirt !!0 UnityEngine.Component::GetComponentInParent()<BuildSlot>  /*0x2B000004*/
    IL_0053: stloc.1
    IL_0054: ldloc.1
    IL_0055: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_005a: ldc.i4.1
    IL_005b: bne.un.s IL_0066
    IL_005d: ldloc.1
    IL_005e: ldnull
    IL_005f: ldc.i4.0
    IL_0060: callvirt void BuildSlot::TryToBuildOrUpgradeAndPay(PlayerInteraction,bool)  /*0x060002F6*/
    IL_0065: ret
    IL_0066: ldloc.0
    IL_0067: ldc.i4.1
    IL_0068: add
    IL_0069: stloc.0
    IL_006a: ldloc.0
    IL_006b: ldarg.0
    IL_006c: ldfld List<TaggedObject> UpgradeBuildersGuild::allHousesTaggedObjsSorted  /*0x04000F09*/
    IL_0071: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0076: blt.s IL_0042
    IL_0078: ret

  .method UpgradeBuildersGuild::GetIncomeChangeIfNextUpgradeIsPossible()  // token 0x06000C3E rva 0x392a8 attrs Public, HideBySig
    // code size 151 (0x97), max stack 4, init locals
    .locals ([0] int, [1] int, [2] BuildSlot)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0007: ldarg.0
    IL_0008: ldfld List<TaggedObject> UpgradeBuildersGuild::allHousesTaggedObjs  /*0x04000F08*/
    IL_000d: ldarg.0
    IL_000e: ldfld List<TagManager.ETag> UpgradeBuildersGuild::mustHaveTags  /*0x04000F06*/
    IL_0013: ldarg.0
    IL_0014: ldfld List<TagManager.ETag> UpgradeBuildersGuild::mayNotHaveTags  /*0x04000F07*/
    IL_0019: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_001e: ldarg.0
    IL_001f: ldarg.0
    IL_0020: ldfld List<TaggedObject> UpgradeBuildersGuild::allHousesTaggedObjs  /*0x04000F08*/
    IL_0025: ldarg.0
    IL_0026: ldftn float UpgradeBuildersGuild::<GetIncomeChangeIfNextUpgradeIsPossible>b__16_0(TaggedObject)  /*0x06000C46*/
    IL_002c: newobj void System.Func<TaggedObject, float>::.ctor(object,IntPtr)  /*0x0A000515*/
    IL_0031: call IOrderedEnumerable<!!0> System.Linq.Enumerable::OrderBy(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, !!1>)<TaggedObject,float>  /*0x2B0000B5*/
    IL_0036: call List<!!0> System.Linq.Enumerable::ToList(System.Collections.Generic.IEnumerable<!!0>)<TaggedObject>  /*0x2B0000B6*/
    IL_003b: stfld List<TaggedObject> UpgradeBuildersGuild::allHousesTaggedObjsSorted  /*0x04000F09*/
    IL_0040: ldc.i4.0
    IL_0041: stloc.1
    IL_0042: br.s IL_0087
    IL_0044: ldarg.0
    IL_0045: ldfld List<TaggedObject> UpgradeBuildersGuild::allHousesTaggedObjs  /*0x04000F08*/
    IL_004a: ldloc.1
    IL_004b: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0050: callvirt !!0 UnityEngine.Component::GetComponentInParent()<BuildSlot>  /*0x2B000004*/
    IL_0055: stloc.2
    IL_0056: ldloc.2
    IL_0057: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_005c: ldc.i4.1
    IL_005d: bne.un.s IL_0083
    IL_005f: ldloc.2
    IL_0060: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0065: ldloc.2
    IL_0066: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_006b: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0070: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0075: ldc.i4.0
    IL_0076: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_007b: ldfld int BuildSlot.UpgradeBranch::goldIncomeChange  /*0x040003C1*/
    IL_0080: stloc.0
    IL_0081: br.s IL_0095
    IL_0083: ldloc.1
    IL_0084: ldc.i4.1
    IL_0085: add
    IL_0086: stloc.1
    IL_0087: ldloc.1
    IL_0088: ldarg.0
    IL_0089: ldfld List<TaggedObject> UpgradeBuildersGuild::allHousesTaggedObjsSorted  /*0x04000F09*/
    IL_008e: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0093: blt.s IL_0044
    IL_0095: ldloc.0
    IL_0096: ret

  .method UpgradeBuildersGuild::OnSave(string)  // token 0x06000C3F rva 0x3934b attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
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
    IL_0026: ldstr "_build_used"
    IL_002b: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0030: ldarg.0
    IL_0031: ldfld bool UpgradeBuildersGuild::hasBeenUsedAlready  /*0x04000F0A*/
    IL_0036: call void MatchSaveLoadHandler::SaveValue(string,string,bool)  /*0x06000CF8*/
    IL_003b: ret

  .method UpgradeBuildersGuild::ManualLoad(string)  // token 0x06000C40 rva 0x39388 attrs Private, HideBySig
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
    IL_002f: ldstr "_build_used"
    IL_0034: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0039: ldarg.0
    IL_003a: ldflda bool UpgradeBuildersGuild::hasBeenUsedAlready  /*0x04000F0A*/
    IL_003f: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<bool>  /*0x2B000047*/
    IL_0044: stfld bool UpgradeBuildersGuild::hasBeenUsedAlready  /*0x04000F0A*/
    IL_0049: ret

  .method UpgradeBuildersGuild::OnBeforeMainLoadPass(string)  // token 0x06000C41 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UpgradeBuildersGuild::OnLoad(string)  // token 0x06000C42 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UpgradeBuildersGuild::OnAfterMainLoadPass(string)  // token 0x06000C43 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UpgradeBuildersGuild::.ctor()  // token 0x06000C44 rva 0x393de attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0006: stfld List<TagManager.ETag> UpgradeBuildersGuild::mustHaveTags  /*0x04000F06*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0011: stfld List<TagManager.ETag> UpgradeBuildersGuild::mayNotHaveTags  /*0x04000F07*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_001c: stfld List<TaggedObject> UpgradeBuildersGuild::allHousesTaggedObjs  /*0x04000F08*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0027: stfld List<TaggedObject> UpgradeBuildersGuild::allHousesTaggedObjsSorted  /*0x04000F09*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0032: ret

  .method UpgradeBuildersGuild::<UpgradeAHouse>b__15_0(TaggedObject)  // token 0x06000C45 rva 0x39414 attrs Private, HideBySig
    // code size 36 (0x24), max stack 2, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.1
    IL_0001: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: ldarg.0
    IL_000c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0011: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0016: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_001b: stloc.0
    IL_001c: ldloca.s 0
    IL_001e: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0023: ret

  .method UpgradeBuildersGuild::<GetIncomeChangeIfNextUpgradeIsPossible>b__16_0(TaggedObject)  // token 0x06000C46 rva 0x39444 attrs Private, HideBySig
    // code size 36 (0x24), max stack 2, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.1
    IL_0001: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: ldarg.0
    IL_000c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0011: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0016: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_001b: stloc.0
    IL_001c: ldloca.s 0
    IL_001e: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0023: ret

// ===== UpgradeBuildersGuild/<UpgradeAHouseWithDelay>d__14  (token 0x0200023C) =====
  .method UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::.ctor(int)  // token 0x06000C47 rva 0x39474 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::<>1__state  /*0x04000F0B*/
    IL_000d: ret

  .method UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::System.IDisposable.Dispose()  // token 0x06000C48 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::MoveNext()  // token 0x06000C49 rva 0x39484 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 95 (0x5f), max stack 2, init locals
    .locals ([0] int, [1] UpgradeBuildersGuild)
    IL_0000: ldarg.0
    IL_0001: ldfld int UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::<>1__state  /*0x04000F0B*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld UpgradeBuildersGuild UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::<>4__this  /*0x04000F0D*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_0039, IL_0050)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::<>1__state  /*0x04000F0B*/
    IL_0029: ldarg.0
    IL_002a: ldnull
    IL_002b: stfld object UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::<>2__current  /*0x04000F0C*/
    IL_0030: ldarg.0
    IL_0031: ldc.i4.1
    IL_0032: stfld int UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::<>1__state  /*0x04000F0B*/
    IL_0037: ldc.i4.1
    IL_0038: ret
    IL_0039: ldarg.0
    IL_003a: ldc.i4.m1
    IL_003b: stfld int UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::<>1__state  /*0x04000F0B*/
    IL_0040: ldarg.0
    IL_0041: ldnull
    IL_0042: stfld object UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::<>2__current  /*0x04000F0C*/
    IL_0047: ldarg.0
    IL_0048: ldc.i4.2
    IL_0049: stfld int UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::<>1__state  /*0x04000F0B*/
    IL_004e: ldc.i4.1
    IL_004f: ret
    IL_0050: ldarg.0
    IL_0051: ldc.i4.m1
    IL_0052: stfld int UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::<>1__state  /*0x04000F0B*/
    IL_0057: ldloc.1
    IL_0058: call void UpgradeBuildersGuild::UpgradeAHouse()  /*0x06000C3D*/
    IL_005d: ldc.i4.0
    IL_005e: ret

  .method UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000C4A rva 0x394ef attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::<>2__current  /*0x04000F0C*/
    IL_0006: ret

  .method UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::System.Collections.IEnumerator.Reset()  // token 0x06000C4B rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::System.Collections.IEnumerator.get_Current()  // token 0x06000C4C rva 0x394ef attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object UpgradeBuildersGuild.<UpgradeAHouseWithDelay>d__14::<>2__current  /*0x04000F0C*/
    IL_0006: ret

