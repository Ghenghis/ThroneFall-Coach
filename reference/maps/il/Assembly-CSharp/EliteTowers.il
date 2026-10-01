// ===== EliteTowers  (token 0x02000131) =====
  .method EliteTowers::Start()  // token 0x06000657 rva 0x1a96c attrs Private, HideBySig
    // code size 65 (0x41), max stack 3, init locals
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: callvirt bool PerkManager::get_EliteTowersEquipped()  /*0x06000996*/
    IL_000a: brtrue.s IL_000d
    IL_000c: ret
    IL_000d: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0012: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0017: brfalse.s IL_0024
    IL_0019: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_001e: ldarg.0
    IL_001f: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0024: ldarg.0
    IL_0025: call !!0 UnityEngine.Component::GetComponentInParent()<BuildSlot>  /*0x2B000004*/
    IL_002a: ldfld UnityEvent BuildSlot::OnUpgrade  /*0x040003B0*/
    IL_002f: ldarg.0
    IL_0030: ldftn void EliteTowers::PutIntoEliteMode()  /*0x06000658*/
    IL_0036: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_003b: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0040: ret

  .method EliteTowers::PutIntoEliteMode()  // token 0x06000658 rva 0x1a9bc attrs Private, HideBySig
    // code size 131 (0x83), max stack 3, init locals
    .locals ([0] AutoAttack[], [1] int, [2] HotOilTower[])
    IL_0000: ldarg.0
    IL_0001: ldfld bool EliteTowers::eliteMode  /*0x040007AD*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.i4.1
    IL_000b: stfld bool EliteTowers::eliteMode  /*0x040007AD*/
    IL_0010: ldarg.0
    IL_0011: ldfld GameObject EliteTowers::eliteModeMarker  /*0x040007AE*/
    IL_0016: ldc.i4.1
    IL_0017: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001c: ldarg.0
    IL_001d: ldfld GameObject EliteTowers::intactParent  /*0x040007AF*/
    IL_0022: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren()<AutoAttack>  /*0x2B000053*/
    IL_0027: stloc.0
    IL_0028: ldc.i4.0
    IL_0029: stloc.1
    IL_002a: br.s IL_0049
    IL_002c: ldloc.0
    IL_002d: ldloc.1
    IL_002e: ldelem.ref
    IL_002f: dup
    IL_0030: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_0035: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_003a: ldfld float PerkManager::eliteTowerDamageMultiplyer  /*0x04000C3F*/
    IL_003f: mul
    IL_0040: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_0045: ldloc.1
    IL_0046: ldc.i4.1
    IL_0047: add
    IL_0048: stloc.1
    IL_0049: ldloc.1
    IL_004a: ldloc.0
    IL_004b: ldlen
    IL_004c: conv.i4
    IL_004d: blt.s IL_002c
    IL_004f: ldarg.0
    IL_0050: ldfld GameObject EliteTowers::intactParent  /*0x040007AF*/
    IL_0055: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren()<HotOilTower>  /*0x2B000054*/
    IL_005a: stloc.2
    IL_005b: ldc.i4.0
    IL_005c: stloc.1
    IL_005d: br.s IL_007c
    IL_005f: ldloc.2
    IL_0060: ldloc.1
    IL_0061: ldelem.ref
    IL_0062: dup
    IL_0063: ldfld float HotOilTower::DamageMultiplyer  /*0x04000A25*/
    IL_0068: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_006d: ldfld float PerkManager::eliteTowerDamageMultiplyer  /*0x04000C3F*/
    IL_0072: mul
    IL_0073: stfld float HotOilTower::DamageMultiplyer  /*0x04000A25*/
    IL_0078: ldloc.1
    IL_0079: ldc.i4.1
    IL_007a: add
    IL_007b: stloc.1
    IL_007c: ldloc.1
    IL_007d: ldloc.2
    IL_007e: ldlen
    IL_007f: conv.i4
    IL_0080: blt.s IL_005f
    IL_0082: ret

  .method EliteTowers::GoOutOfEliteMode()  // token 0x06000659 rva 0x1aa4c attrs Private, HideBySig
    // code size 131 (0x83), max stack 3, init locals
    .locals ([0] AutoAttack[], [1] int, [2] HotOilTower[])
    IL_0000: ldarg.0
    IL_0001: ldfld bool EliteTowers::eliteMode  /*0x040007AD*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.i4.0
    IL_000b: stfld bool EliteTowers::eliteMode  /*0x040007AD*/
    IL_0010: ldarg.0
    IL_0011: ldfld GameObject EliteTowers::eliteModeMarker  /*0x040007AE*/
    IL_0016: ldc.i4.0
    IL_0017: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001c: ldarg.0
    IL_001d: ldfld GameObject EliteTowers::intactParent  /*0x040007AF*/
    IL_0022: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren()<AutoAttack>  /*0x2B000053*/
    IL_0027: stloc.0
    IL_0028: ldc.i4.0
    IL_0029: stloc.1
    IL_002a: br.s IL_0049
    IL_002c: ldloc.0
    IL_002d: ldloc.1
    IL_002e: ldelem.ref
    IL_002f: dup
    IL_0030: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_0035: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_003a: ldfld float PerkManager::eliteTowerDamageMultiplyer  /*0x04000C3F*/
    IL_003f: div
    IL_0040: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_0045: ldloc.1
    IL_0046: ldc.i4.1
    IL_0047: add
    IL_0048: stloc.1
    IL_0049: ldloc.1
    IL_004a: ldloc.0
    IL_004b: ldlen
    IL_004c: conv.i4
    IL_004d: blt.s IL_002c
    IL_004f: ldarg.0
    IL_0050: ldfld GameObject EliteTowers::intactParent  /*0x040007AF*/
    IL_0055: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren()<HotOilTower>  /*0x2B000054*/
    IL_005a: stloc.2
    IL_005b: ldc.i4.0
    IL_005c: stloc.1
    IL_005d: br.s IL_007c
    IL_005f: ldloc.2
    IL_0060: ldloc.1
    IL_0061: ldelem.ref
    IL_0062: dup
    IL_0063: ldfld float HotOilTower::DamageMultiplyer  /*0x04000A25*/
    IL_0068: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_006d: ldfld float PerkManager::eliteTowerDamageMultiplyer  /*0x04000C3F*/
    IL_0072: div
    IL_0073: stfld float HotOilTower::DamageMultiplyer  /*0x04000A25*/
    IL_0078: ldloc.1
    IL_0079: ldc.i4.1
    IL_007a: add
    IL_007b: stloc.1
    IL_007c: ldloc.1
    IL_007d: ldloc.2
    IL_007e: ldlen
    IL_007f: conv.i4
    IL_0080: blt.s IL_005f
    IL_0082: ret

  .method EliteTowers::OnDuskEarly()  // token 0x0600065A rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EliteTowers::OnDusk()  // token 0x0600065B rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EliteTowers::OnDawn_AfterSunrise()  // token 0x0600065C rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EliteTowers::OnDawn_BeforeSunrise()  // token 0x0600065D rva 0x1aadb attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void EliteTowers::GoOutOfEliteMode()  /*0x06000659*/
    IL_0006: ret

  .method EliteTowers::.ctor()  // token 0x0600065E rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

