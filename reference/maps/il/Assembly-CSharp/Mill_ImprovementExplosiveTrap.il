// ===== Mill_ImprovementExplosiveTrap  (token 0x020001F3) =====
  .method Mill_ImprovementExplosiveTrap::Start()  // token 0x06000A49 rva 0xad0b attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: ret

  .method Mill_ImprovementExplosiveTrap::OnDawn_AfterSunrise()  // token 0x06000A4A rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Mill_ImprovementExplosiveTrap::OnDawn_BeforeSunrise()  // token 0x06000A4B rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Mill_ImprovementExplosiveTrap::OnDusk()  // token 0x06000A4C rva 0x30970 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void Mill_ImprovementExplosiveTrap::SetCorrectWeapon()  /*0x06000A4E*/
    IL_0006: ret

  .method Mill_ImprovementExplosiveTrap::OnEnable()  // token 0x06000A4D rva 0x30978 attrs Private, HideBySig
    // code size 85 (0x55), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot Mill_ImprovementExplosiveTrap::buildSlot  /*0x04000D0C*/
    IL_0006: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_000b: ldc.i4.1
    IL_000c: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0011: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0016: ldc.i4.0
    IL_0017: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_001c: ldarg.0
    IL_001d: ldfld Mesh Mill_ImprovementExplosiveTrap::lvl2Mesh  /*0x04000D0D*/
    IL_0022: stfld Mesh BuildSlot.UpgradeBranch::replacementMesh  /*0x040003C0*/
    IL_0027: ldarg.0
    IL_0028: ldfld BuildSlot Mill_ImprovementExplosiveTrap::buildSlot  /*0x04000D0C*/
    IL_002d: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0032: ldc.i4.2
    IL_0033: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0038: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_003d: ldc.i4.0
    IL_003e: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_0043: ldarg.0
    IL_0044: ldfld Mesh Mill_ImprovementExplosiveTrap::lvl3Mesh  /*0x04000D0E*/
    IL_0049: stfld Mesh BuildSlot.UpgradeBranch::replacementMesh  /*0x040003C0*/
    IL_004e: ldarg.0
    IL_004f: call void Mill_ImprovementExplosiveTrap::SetCorrectWeapon()  /*0x06000A4E*/
    IL_0054: ret

  .method Mill_ImprovementExplosiveTrap::SetCorrectWeapon()  // token 0x06000A4E rva 0x309dc attrs Private, HideBySig
    // code size 301 (0x12d), max stack 2, init locals
    .locals ([0] List.Enumerator<BuildSlot>)
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot Mill_ImprovementExplosiveTrap::buildSlot  /*0x04000D0C*/
    IL_0006: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_000b: ldc.i4.1
    IL_000c: bne.un.s IL_0066
    IL_000e: ldarg.0
    IL_000f: ldfld Hp Mill_ImprovementExplosiveTrap::hpOfBuilding  /*0x04000D0B*/
    IL_0014: ldarg.0
    IL_0015: ldfld Weapon Mill_ImprovementExplosiveTrap::weaponLvl1  /*0x04000D08*/
    IL_001a: callvirt void Hp::set_SpwanAttackOnDeath(Weapon)  /*0x0600081A*/
    IL_001f: ldarg.0
    IL_0020: ldfld BuildSlot Mill_ImprovementExplosiveTrap::buildSlot  /*0x04000D0C*/
    IL_0025: callvirt List<BuildSlot> BuildSlot::get_IsActivatorOf()  /*0x060002C9*/
    IL_002a: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot>::GetEnumerator()  /*0x0A000137*/
    IL_002f: stloc.0
    IL_0030: br.s IL_004a
    IL_0032: ldloca.s 0
    IL_0034: call !0 System.Collections.Generic.List.Enumerator<BuildSlot>::get_Current()  /*0x0A000138*/
    IL_0039: ldc.i4.1
    IL_003a: callvirt !!0 UnityEngine.Component::GetComponentInChildren(bool)<Hp>  /*0x2B000023*/
    IL_003f: ldarg.0
    IL_0040: ldfld Weapon Mill_ImprovementExplosiveTrap::weaponLvl1  /*0x04000D08*/
    IL_0045: callvirt void Hp::set_SpwanAttackOnDeath(Weapon)  /*0x0600081A*/
    IL_004a: ldloca.s 0
    IL_004c: call bool System.Collections.Generic.List.Enumerator<BuildSlot>::MoveNext()  /*0x0A000139*/
    IL_0051: brtrue.s IL_0032
    IL_0053: leave IL_012c
    IL_0058: ldloca.s 0
    IL_005a: constrained. System.Collections.Generic.List.Enumerator<BuildSlot>  /*0x1B000029*/
    IL_0060: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0065: endfinally
    IL_0066: ldarg.0
    IL_0067: ldfld BuildSlot Mill_ImprovementExplosiveTrap::buildSlot  /*0x04000D0C*/
    IL_006c: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0071: ldc.i4.2
    IL_0072: bne.un.s IL_00c9
    IL_0074: ldarg.0
    IL_0075: ldfld Hp Mill_ImprovementExplosiveTrap::hpOfBuilding  /*0x04000D0B*/
    IL_007a: ldarg.0
    IL_007b: ldfld Weapon Mill_ImprovementExplosiveTrap::weaponLvl2  /*0x04000D09*/
    IL_0080: callvirt void Hp::set_SpwanAttackOnDeath(Weapon)  /*0x0600081A*/
    IL_0085: ldarg.0
    IL_0086: ldfld BuildSlot Mill_ImprovementExplosiveTrap::buildSlot  /*0x04000D0C*/
    IL_008b: callvirt List<BuildSlot> BuildSlot::get_IsActivatorOf()  /*0x060002C9*/
    IL_0090: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot>::GetEnumerator()  /*0x0A000137*/
    IL_0095: stloc.0
    IL_0096: br.s IL_00b0
    IL_0098: ldloca.s 0
    IL_009a: call !0 System.Collections.Generic.List.Enumerator<BuildSlot>::get_Current()  /*0x0A000138*/
    IL_009f: ldc.i4.1
    IL_00a0: callvirt !!0 UnityEngine.Component::GetComponentInChildren(bool)<Hp>  /*0x2B000023*/
    IL_00a5: ldarg.0
    IL_00a6: ldfld Weapon Mill_ImprovementExplosiveTrap::weaponLvl2  /*0x04000D09*/
    IL_00ab: callvirt void Hp::set_SpwanAttackOnDeath(Weapon)  /*0x0600081A*/
    IL_00b0: ldloca.s 0
    IL_00b2: call bool System.Collections.Generic.List.Enumerator<BuildSlot>::MoveNext()  /*0x0A000139*/
    IL_00b7: brtrue.s IL_0098
    IL_00b9: leave.s IL_012c
    IL_00bb: ldloca.s 0
    IL_00bd: constrained. System.Collections.Generic.List.Enumerator<BuildSlot>  /*0x1B000029*/
    IL_00c3: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00c8: endfinally
    IL_00c9: ldarg.0
    IL_00ca: ldfld BuildSlot Mill_ImprovementExplosiveTrap::buildSlot  /*0x04000D0C*/
    IL_00cf: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_00d4: ldc.i4.3
    IL_00d5: bne.un.s IL_012c
    IL_00d7: ldarg.0
    IL_00d8: ldfld Hp Mill_ImprovementExplosiveTrap::hpOfBuilding  /*0x04000D0B*/
    IL_00dd: ldarg.0
    IL_00de: ldfld Weapon Mill_ImprovementExplosiveTrap::weaponLvl3  /*0x04000D0A*/
    IL_00e3: callvirt void Hp::set_SpwanAttackOnDeath(Weapon)  /*0x0600081A*/
    IL_00e8: ldarg.0
    IL_00e9: ldfld BuildSlot Mill_ImprovementExplosiveTrap::buildSlot  /*0x04000D0C*/
    IL_00ee: callvirt List<BuildSlot> BuildSlot::get_IsActivatorOf()  /*0x060002C9*/
    IL_00f3: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot>::GetEnumerator()  /*0x0A000137*/
    IL_00f8: stloc.0
    IL_00f9: br.s IL_0113
    IL_00fb: ldloca.s 0
    IL_00fd: call !0 System.Collections.Generic.List.Enumerator<BuildSlot>::get_Current()  /*0x0A000138*/
    IL_0102: ldc.i4.1
    IL_0103: callvirt !!0 UnityEngine.Component::GetComponentInChildren(bool)<Hp>  /*0x2B000023*/
    IL_0108: ldarg.0
    IL_0109: ldfld Weapon Mill_ImprovementExplosiveTrap::weaponLvl3  /*0x04000D0A*/
    IL_010e: callvirt void Hp::set_SpwanAttackOnDeath(Weapon)  /*0x0600081A*/
    IL_0113: ldloca.s 0
    IL_0115: call bool System.Collections.Generic.List.Enumerator<BuildSlot>::MoveNext()  /*0x0A000139*/
    IL_011a: brtrue.s IL_00fb
    IL_011c: leave.s IL_012c
    IL_011e: ldloca.s 0
    IL_0120: constrained. System.Collections.Generic.List.Enumerator<BuildSlot>  /*0x1B000029*/
    IL_0126: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_012b: endfinally
    IL_012c: ret
    .try IL_0030-IL_0058 finally handler IL_0058-IL_0066
    .try IL_0096-IL_00bb finally handler IL_00bb-IL_00c9
    .try IL_00f9-IL_011e finally handler IL_011e-IL_012c

  .method Mill_ImprovementExplosiveTrap::OnDuskEarly()  // token 0x06000A4F rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Mill_ImprovementExplosiveTrap::.ctor()  // token 0x06000A50 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

