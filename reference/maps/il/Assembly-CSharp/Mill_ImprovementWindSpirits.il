// ===== Mill_ImprovementWindSpirits  (token 0x020001F4) =====
  .method Mill_ImprovementWindSpirits::Start()  // token 0x06000A51 rva 0x30b40 attrs Private, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: stfld TagManager Mill_ImprovementWindSpirits::tagManager  /*0x04000D19*/
    IL_000b: ldarg.0
    IL_000c: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0011: ldarg.0
    IL_0012: ldfld float Mill_ImprovementWindSpirits::blockInterval  /*0x04000D15*/
    IL_0017: mul
    IL_0018: stfld float Mill_ImprovementWindSpirits::cooldown  /*0x04000D18*/
    IL_001d: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0022: ldarg.0
    IL_0023: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0028: ret

  .method Mill_ImprovementWindSpirits::Update()  // token 0x06000A52 rva 0x30b6a attrs Private, HideBySig
    // code size 59 (0x3b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float Mill_ImprovementWindSpirits::cooldown  /*0x04000D18*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float Mill_ImprovementWindSpirits::cooldown  /*0x04000D18*/
    IL_0012: br.s IL_002d
    IL_0014: ldarg.0
    IL_0015: call void Mill_ImprovementWindSpirits::BlockAnArrow()  /*0x06000A53*/
    IL_001a: ldarg.0
    IL_001b: ldarg.0
    IL_001c: ldfld float Mill_ImprovementWindSpirits::cooldown  /*0x04000D18*/
    IL_0021: ldarg.0
    IL_0022: ldfld float Mill_ImprovementWindSpirits::blockInterval  /*0x04000D15*/
    IL_0027: add
    IL_0028: stfld float Mill_ImprovementWindSpirits::cooldown  /*0x04000D18*/
    IL_002d: ldarg.0
    IL_002e: ldfld float Mill_ImprovementWindSpirits::cooldown  /*0x04000D18*/
    IL_0033: ldc.r4 0f
    IL_0038: ble.s IL_0014
    IL_003a: ret

  .method Mill_ImprovementWindSpirits::BlockAnArrow()  // token 0x06000A53 rva 0x30ba8 attrs Private, HideBySig
    // code size 141 (0x8d), max stack 4, init locals
    .locals ([0] TaggedObject, [1] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld TagManager Mill_ImprovementWindSpirits::tagManager  /*0x04000D19*/
    IL_0006: ldarg.0
    IL_0007: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0011: ldarg.0
    IL_0012: ldfld List<TagManager.ETag> Mill_ImprovementWindSpirits::mustHaveTags  /*0x04000D1A*/
    IL_0017: ldarg.0
    IL_0018: ldfld List<TagManager.ETag> Mill_ImprovementWindSpirits::mayNotHaveTags  /*0x04000D1B*/
    IL_001d: callvirt TaggedObject TagManager::FindClosestTaggedObjectWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5E*/
    IL_0022: stloc.0
    IL_0023: ldloc.0
    IL_0024: ldnull
    IL_0025: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_002a: brfalse.s IL_002d
    IL_002c: ret
    IL_002d: ldloc.0
    IL_002e: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0033: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0038: ldarg.0
    IL_0039: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0043: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0048: stloc.1
    IL_0049: ldloca.s 1
    IL_004b: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0050: ldarg.0
    IL_0051: ldfld float Mill_ImprovementWindSpirits::range  /*0x04000D16*/
    IL_0056: bge.un.s IL_008c
    IL_0058: ldarg.0
    IL_0059: ldfld GameObject Mill_ImprovementWindSpirits::fxBlockArrow  /*0x04000D17*/
    IL_005e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0063: brfalse.s IL_0081
    IL_0065: ldarg.0
    IL_0066: ldfld GameObject Mill_ImprovementWindSpirits::fxBlockArrow  /*0x04000D17*/
    IL_006b: ldloc.0
    IL_006c: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0071: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0076: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_007b: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_0080: pop
    IL_0081: ldloc.0
    IL_0082: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0087: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_008c: ret

  .method Mill_ImprovementWindSpirits::OnEnable()  // token 0x06000A54 rva 0x30c44 attrs Private, HideBySig
    // code size 170 (0xaa), max stack 2, init locals
    .locals ([0] List.Enumerator<BuildSlot>)
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot Mill_ImprovementWindSpirits::buildSlot  /*0x04000D0F*/
    IL_0006: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_000b: ldc.i4.1
    IL_000c: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0011: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0016: ldc.i4.0
    IL_0017: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_001c: ldarg.0
    IL_001d: ldfld Mesh Mill_ImprovementWindSpirits::lvl2Mesh  /*0x04000D13*/
    IL_0022: stfld Mesh BuildSlot.UpgradeBranch::replacementMesh  /*0x040003C0*/
    IL_0027: ldarg.0
    IL_0028: ldfld BuildSlot Mill_ImprovementWindSpirits::buildSlot  /*0x04000D0F*/
    IL_002d: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0032: ldc.i4.2
    IL_0033: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0038: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_003d: ldc.i4.0
    IL_003e: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_0043: ldarg.0
    IL_0044: ldfld Mesh Mill_ImprovementWindSpirits::lvl3Mesh  /*0x04000D14*/
    IL_0049: stfld Mesh BuildSlot.UpgradeBranch::replacementMesh  /*0x040003C0*/
    IL_004e: ldarg.0
    IL_004f: call !!0 UnityEngine.Component::GetComponentInParent()<TaggedObject>  /*0x2B00001D*/
    IL_0054: ldarg.0
    IL_0055: ldfld TagManager.ETag Mill_ImprovementWindSpirits::giveSelfAndFieldsmillThisTag  /*0x04000D1C*/
    IL_005a: callvirt void TaggedObject::AddTag(TagManager.ETag)  /*0x06000E49*/
    IL_005f: ldarg.0
    IL_0060: call !!0 UnityEngine.Component::GetComponentInParent()<BuildSlot>  /*0x2B000004*/
    IL_0065: callvirt List<BuildSlot> BuildSlot::get_BuiltSlotsThatRelyOnThisBuilding()  /*0x060002EC*/
    IL_006a: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot>::GetEnumerator()  /*0x0A000137*/
    IL_006f: stloc.0
    IL_0070: br.s IL_008a
    IL_0072: ldloca.s 0
    IL_0074: call !0 System.Collections.Generic.List.Enumerator<BuildSlot>::get_Current()  /*0x0A000138*/
    IL_0079: ldc.i4.1
    IL_007a: callvirt !!0 UnityEngine.Component::GetComponentInChildren(bool)<TaggedObject>  /*0x2B0000A0*/
    IL_007f: ldarg.0
    IL_0080: ldfld TagManager.ETag Mill_ImprovementWindSpirits::giveSelfAndFieldsmillThisTag  /*0x04000D1C*/
    IL_0085: callvirt void TaggedObject::AddTag(TagManager.ETag)  /*0x06000E49*/
    IL_008a: ldloca.s 0
    IL_008c: call bool System.Collections.Generic.List.Enumerator<BuildSlot>::MoveNext()  /*0x0A000139*/
    IL_0091: brtrue.s IL_0072
    IL_0093: leave.s IL_00a3
    IL_0095: ldloca.s 0
    IL_0097: constrained. System.Collections.Generic.List.Enumerator<BuildSlot>  /*0x1B000029*/
    IL_009d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00a2: endfinally
    IL_00a3: ldarg.0
    IL_00a4: call void Mill_ImprovementWindSpirits::SetCorrectWeapon()  /*0x06000A58*/
    IL_00a9: ret
    .try IL_0070-IL_0095 finally handler IL_0095-IL_00a3

  .method Mill_ImprovementWindSpirits::OnDusk()  // token 0x06000A55 rva 0x30d0c attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void Mill_ImprovementWindSpirits::SetCorrectWeapon()  /*0x06000A58*/
    IL_0006: ret

  .method Mill_ImprovementWindSpirits::OnDawn_AfterSunrise()  // token 0x06000A56 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Mill_ImprovementWindSpirits::OnDawn_BeforeSunrise()  // token 0x06000A57 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Mill_ImprovementWindSpirits::SetCorrectWeapon()  // token 0x06000A58 rva 0x30d14 attrs Private, HideBySig
    // code size 81 (0x51), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot Mill_ImprovementWindSpirits::buildSlot  /*0x04000D0F*/
    IL_0006: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_000b: ldc.i4.1
    IL_000c: bne.un.s IL_001b
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: ldfld float Mill_ImprovementWindSpirits::blockIntervalLvl1  /*0x04000D10*/
    IL_0015: stfld float Mill_ImprovementWindSpirits::blockInterval  /*0x04000D15*/
    IL_001a: ret
    IL_001b: ldarg.0
    IL_001c: ldfld BuildSlot Mill_ImprovementWindSpirits::buildSlot  /*0x04000D0F*/
    IL_0021: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0026: ldc.i4.2
    IL_0027: bne.un.s IL_0036
    IL_0029: ldarg.0
    IL_002a: ldarg.0
    IL_002b: ldfld float Mill_ImprovementWindSpirits::blockIntervalLvl2  /*0x04000D11*/
    IL_0030: stfld float Mill_ImprovementWindSpirits::blockInterval  /*0x04000D15*/
    IL_0035: ret
    IL_0036: ldarg.0
    IL_0037: ldfld BuildSlot Mill_ImprovementWindSpirits::buildSlot  /*0x04000D0F*/
    IL_003c: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0041: ldc.i4.3
    IL_0042: bne.un.s IL_0050
    IL_0044: ldarg.0
    IL_0045: ldarg.0
    IL_0046: ldfld float Mill_ImprovementWindSpirits::blockIntervalLvl3  /*0x04000D12*/
    IL_004b: stfld float Mill_ImprovementWindSpirits::blockInterval  /*0x04000D15*/
    IL_0050: ret

  .method Mill_ImprovementWindSpirits::OnDuskEarly()  // token 0x06000A59 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Mill_ImprovementWindSpirits::.ctor()  // token 0x06000A5A rva 0x30d74 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 84 (0x54), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float Mill_ImprovementWindSpirits::blockIntervalLvl1  /*0x04000D10*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.5f
    IL_0011: stfld float Mill_ImprovementWindSpirits::blockIntervalLvl2  /*0x04000D11*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.25f
    IL_001c: stfld float Mill_ImprovementWindSpirits::blockIntervalLvl3  /*0x04000D12*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 1f
    IL_0027: stfld float Mill_ImprovementWindSpirits::blockInterval  /*0x04000D15*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 30f
    IL_0032: stfld float Mill_ImprovementWindSpirits::range  /*0x04000D16*/
    IL_0037: ldarg.0
    IL_0038: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_003d: stfld List<TagManager.ETag> Mill_ImprovementWindSpirits::mustHaveTags  /*0x04000D1A*/
    IL_0042: ldarg.0
    IL_0043: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0048: stfld List<TagManager.ETag> Mill_ImprovementWindSpirits::mayNotHaveTags  /*0x04000D1B*/
    IL_004d: ldarg.0
    IL_004e: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0053: ret

