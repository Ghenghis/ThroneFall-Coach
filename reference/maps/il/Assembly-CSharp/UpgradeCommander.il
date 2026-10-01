// ===== UpgradeCommander  (token 0x0200023E) =====
  .method UpgradeCommander::OnEnable()  // token 0x06000C56 rva 0x39610 attrs Private, HideBySig
    // code size 208 (0xd0), max stack 3, init locals
    .locals ([0] List<TaggedObject>, [1] List<PathfindMovementPlayerunit>, [2] List.Enumerator<TaggedObject>, [3] PathfindMovementPlayerunit, [4] List.Enumerator<PathfindMovementPlayerunit>)
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: stfld TagManager UpgradeCommander::tagManager  /*0x04000F16*/
    IL_000b: ldarg.0
    IL_000c: stsfld UpgradeCommander UpgradeCommander::instance  /*0x04000F14*/
    IL_0011: ldsfld CommandUnits CommandUnits::instance  /*0x04000DAD*/
    IL_0016: ldc.i4.0
    IL_0017: callvirt void CommandUnits::PlaceCommandedUnitsAndCalculateTargetPositions(bool)  /*0x06000B01*/
    IL_001c: ldsfld CommandUnits CommandUnits::instance  /*0x04000DAD*/
    IL_0021: ldc.i4.0
    IL_0022: stfld bool CommandUnits::commanding  /*0x04000DC5*/
    IL_0027: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_002c: stloc.0
    IL_002d: newobj void System.Collections.Generic.List<PathfindMovementPlayerunit>::.ctor()  /*0x0A0004D8*/
    IL_0032: stloc.1
    IL_0033: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0038: ldloc.0
    IL_0039: ldc.i4.7
    IL_003a: callvirt void TagManager::FindAllTaggedObjectsWithTag(System.Collections.Generic.List<TaggedObject>,TagManager.ETag)  /*0x06000E5C*/
    IL_003f: ldloc.0
    IL_0040: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0045: stloc.2
    IL_0046: br.s IL_006b
    IL_0048: ldloca.s 2
    IL_004a: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_004f: callvirt !!0 UnityEngine.Component::GetComponent()<PathfindMovementPlayerunit>  /*0x2B00008A*/
    IL_0054: stloc.3
    IL_0055: ldloc.3
    IL_0056: callvirt bool PathfindMovementPlayerunit::get_HoldPosition()  /*0x06000B33*/
    IL_005b: brfalse.s IL_006b
    IL_005d: ldloc.1
    IL_005e: ldloc.3
    IL_005f: callvirt void System.Collections.Generic.List<PathfindMovementPlayerunit>::Add(!0)  /*0x0A0004CE*/
    IL_0064: ldloc.3
    IL_0065: ldc.i4.0
    IL_0066: callvirt void PathfindMovementPlayerunit::set_HoldPosition(bool)  /*0x06000B34*/
    IL_006b: ldloca.s 2
    IL_006d: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0072: brtrue.s IL_0048
    IL_0074: leave.s IL_0084
    IL_0076: ldloca.s 2
    IL_0078: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_007e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0083: endfinally
    IL_0084: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0089: ldc.i4.1
    IL_008a: stfld bool PlayerUpgradeManager::commander  /*0x04000F29*/
    IL_008f: ldloc.1
    IL_0090: callvirt List.Enumerator<!0> System.Collections.Generic.List<PathfindMovementPlayerunit>::GetEnumerator()  /*0x0A000057*/
    IL_0095: stloc.s 4
    IL_0097: br.s IL_00a6
    IL_0099: ldloca.s 4
    IL_009b: call !0 System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>::get_Current()  /*0x0A000058*/
    IL_00a0: ldc.i4.1
    IL_00a1: callvirt void PathfindMovementPlayerunit::set_HoldPosition(bool)  /*0x06000B34*/
    IL_00a6: ldloca.s 4
    IL_00a8: call bool System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>::MoveNext()  /*0x0A00005A*/
    IL_00ad: brtrue.s IL_0099
    IL_00af: leave.s IL_00bf
    IL_00b1: ldloca.s 4
    IL_00b3: constrained. System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>  /*0x1B00000D*/
    IL_00b9: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00be: endfinally
    IL_00bf: ldarg.0
    IL_00c0: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_00c5: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00ca: stfld Transform UpgradeCommander::playerTransform  /*0x04000F17*/
    IL_00cf: ret
    .try IL_0046-IL_0076 finally handler IL_0076-IL_0084
    .try IL_0097-IL_00b1 finally handler IL_00b1-IL_00bf

  .method UpgradeCommander::.ctor()  // token 0x06000C57 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

