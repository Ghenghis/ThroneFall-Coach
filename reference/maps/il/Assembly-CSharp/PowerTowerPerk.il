// ===== PowerTowerPerk  (token 0x02000247) =====
  .method PowerTowerPerk::Start()  // token 0x06000C86 rva 0x39b2d attrs Private, HideBySig
    // code size 48 (0x30), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PowerTowerPerk::powerTowerPerk  /*0x04000F33*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brtrue.s IL_0014
    IL_000d: ldarg.0
    IL_000e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_001a: stfld TagManager PowerTowerPerk::tagManager  /*0x04000F36*/
    IL_001f: ldarg.0
    IL_0020: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0025: ldfld float PerkManager::powerTower_attackSpeedBonus  /*0x04000C16*/
    IL_002a: stfld float PowerTowerPerk::attackSpeedBonus  /*0x04000F37*/
    IL_002f: ret

  .method PowerTowerPerk::Update()  // token 0x06000C87 rva 0x39b60 attrs Private, HideBySig
    // code size 189 (0xbd), max stack 5, init locals
    .locals ([0] AutoAttack[], [1] int, [2] HotOilTower[])
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float PowerTowerPerk::nextRefreshIn  /*0x04000F38*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float PowerTowerPerk::nextRefreshIn  /*0x04000F38*/
    IL_0012: ldarg.0
    IL_0013: ldfld float PowerTowerPerk::nextRefreshIn  /*0x04000F38*/
    IL_0018: ldc.r4 0f
    IL_001d: bgt.un.s IL_0052
    IL_001f: ldarg.0
    IL_0020: ldarg.0
    IL_0021: ldfld TagManager PowerTowerPerk::tagManager  /*0x04000F36*/
    IL_0026: ldarg.0
    IL_0027: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0031: ldarg.0
    IL_0032: ldfld List<TagManager.ETag> PowerTowerPerk::mustHaveTags  /*0x04000F34*/
    IL_0037: ldarg.0
    IL_0038: ldfld List<TagManager.ETag> PowerTowerPerk::mayNotHaveTags  /*0x04000F35*/
    IL_003d: callvirt TaggedObject TagManager::FindClosestTaggedObjectWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5E*/
    IL_0042: stfld TaggedObject PowerTowerPerk::closestTower  /*0x04000F39*/
    IL_0047: ldarg.0
    IL_0048: ldc.r4 0.2f
    IL_004d: stfld float PowerTowerPerk::nextRefreshIn  /*0x04000F38*/
    IL_0052: ldarg.0
    IL_0053: ldfld TaggedObject PowerTowerPerk::closestTower  /*0x04000F39*/
    IL_0058: ldnull
    IL_0059: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_005e: brfalse.s IL_00bc
    IL_0060: ldarg.0
    IL_0061: ldfld TaggedObject PowerTowerPerk::closestTower  /*0x04000F39*/
    IL_0066: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren()<AutoAttack>  /*0x2B000015*/
    IL_006b: stloc.0
    IL_006c: ldc.i4.0
    IL_006d: stloc.1
    IL_006e: br.s IL_0088
    IL_0070: ldloc.0
    IL_0071: ldloc.1
    IL_0072: ldelem.ref
    IL_0073: ldarg.0
    IL_0074: ldfld float PowerTowerPerk::attackSpeedBonus  /*0x04000F37*/
    IL_0079: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_007e: mul
    IL_007f: callvirt void AutoAttack::ReduceCooldownBy(float)  /*0x06000231*/
    IL_0084: ldloc.1
    IL_0085: ldc.i4.1
    IL_0086: add
    IL_0087: stloc.1
    IL_0088: ldloc.1
    IL_0089: ldloc.0
    IL_008a: ldlen
    IL_008b: conv.i4
    IL_008c: blt.s IL_0070
    IL_008e: ldarg.0
    IL_008f: ldfld TaggedObject PowerTowerPerk::closestTower  /*0x04000F39*/
    IL_0094: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren()<HotOilTower>  /*0x2B0000B8*/
    IL_0099: stloc.2
    IL_009a: ldc.i4.0
    IL_009b: stloc.1
    IL_009c: br.s IL_00b6
    IL_009e: ldloc.2
    IL_009f: ldloc.1
    IL_00a0: ldelem.ref
    IL_00a1: ldarg.0
    IL_00a2: ldfld float PowerTowerPerk::attackSpeedBonus  /*0x04000F37*/
    IL_00a7: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00ac: mul
    IL_00ad: callvirt void HotOilTower::ReduceCooldownBy(float)  /*0x0600080C*/
    IL_00b2: ldloc.1
    IL_00b3: ldc.i4.1
    IL_00b4: add
    IL_00b5: stloc.1
    IL_00b6: ldloc.1
    IL_00b7: ldloc.2
    IL_00b8: ldlen
    IL_00b9: conv.i4
    IL_00ba: blt.s IL_009e
    IL_00bc: ret

  .method PowerTowerPerk::.ctor()  // token 0x06000C88 rva 0x39c29 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0006: stfld List<TagManager.ETag> PowerTowerPerk::mustHaveTags  /*0x04000F34*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0011: stfld List<TagManager.ETag> PowerTowerPerk::mayNotHaveTags  /*0x04000F35*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.2f
    IL_001c: stfld float PowerTowerPerk::nextRefreshIn  /*0x04000F38*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

