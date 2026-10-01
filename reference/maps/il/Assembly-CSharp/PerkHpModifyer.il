// ===== PerkHpModifyer  (token 0x02000222) =====
  .method PerkHpModifyer::OnBeforeMainLoadPass(string)  // token 0x06000B6B rva 0x36748 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: call void PerkHpModifyer::Execute(bool)  /*0x06000B70*/
    IL_0007: ret

  .method PerkHpModifyer::OnAfterMainLoadPass(string)  // token 0x06000B6C rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PerkHpModifyer::OnLoad(string)  // token 0x06000B6D rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PerkHpModifyer::OnSave(string)  // token 0x06000B6E rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PerkHpModifyer::Start()  // token 0x06000B6F rva 0x36751 attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: call void PerkHpModifyer::Execute(bool)  /*0x06000B70*/
    IL_0007: ret

  .method PerkHpModifyer::Execute(bool)  // token 0x06000B70 rva 0x3675c attrs Private, HideBySig
    // code size 238 (0xee), max stack 3, init locals
    .locals ([0] BuildSlot, [1] List.Enumerator<BuildSlot.Upgrade>, [2] List.Enumerator<BuildSlot.UpgradeBranch>)
    IL_0000: ldarg.0
    IL_0001: ldfld bool PerkHpModifyer::executed  /*0x04000E52*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.i4.1
    IL_000b: stfld bool PerkHpModifyer::executed  /*0x04000E52*/
    IL_0010: ldarg.0
    IL_0011: ldfld Equippable PerkHpModifyer::requiredPerk  /*0x04000E4E*/
    IL_0016: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_001b: brfalse IL_00e7
    IL_0020: ldarg.0
    IL_0021: ldfld bool PerkHpModifyer::isUnit  /*0x04000E51*/
    IL_0026: brtrue IL_00bc
    IL_002b: ldarg.0
    IL_002c: call !!0 UnityEngine.Component::GetComponent()<BuildSlot>  /*0x2B00001A*/
    IL_0031: stloc.0
    IL_0032: ldloc.0
    IL_0033: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0038: brtrue.s IL_0041
    IL_003a: ldarg.0
    IL_003b: call !!0 UnityEngine.Component::GetComponentInParent()<BuildSlot>  /*0x2B000004*/
    IL_0040: stloc.0
    IL_0041: ldloc.0
    IL_0042: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0047: brfalse.s IL_00bc
    IL_0049: ldloc.0
    IL_004a: callvirt List<BuildSlot.Upgrade> BuildSlot::get_OwnUpgrades()  /*0x060002D2*/
    IL_004f: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot.Upgrade>::GetEnumerator()  /*0x0A000127*/
    IL_0054: stloc.1
    IL_0055: br.s IL_00a3
    IL_0057: ldloca.s 1
    IL_0059: call !0 System.Collections.Generic.List.Enumerator<BuildSlot.Upgrade>::get_Current()  /*0x0A000128*/
    IL_005e: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0063: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot.UpgradeBranch>::GetEnumerator()  /*0x0A000121*/
    IL_0068: stloc.2
    IL_0069: br.s IL_008a
    IL_006b: ldloca.s 2
    IL_006d: call !0 System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::get_Current()  /*0x0A000122*/
    IL_0072: dup
    IL_0073: ldfld int BuildSlot.UpgradeBranch::hpChange  /*0x040003C3*/
    IL_0078: conv.r4
    IL_0079: ldarg.0
    IL_007a: ldfld float PerkHpModifyer::hpMultiplyer  /*0x04000E4F*/
    IL_007f: mul
    IL_0080: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0085: stfld int BuildSlot.UpgradeBranch::hpChange  /*0x040003C3*/
    IL_008a: ldloca.s 2
    IL_008c: call bool System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::MoveNext()  /*0x0A000125*/
    IL_0091: brtrue.s IL_006b
    IL_0093: leave.s IL_00a3
    IL_0095: ldloca.s 2
    IL_0097: constrained. System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>  /*0x1B000022*/
    IL_009d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00a2: endfinally
    IL_00a3: ldloca.s 1
    IL_00a5: call bool System.Collections.Generic.List.Enumerator<BuildSlot.Upgrade>::MoveNext()  /*0x0A00012C*/
    IL_00aa: brtrue.s IL_0057
    IL_00ac: leave.s IL_00bc
    IL_00ae: ldloca.s 1
    IL_00b0: constrained. System.Collections.Generic.List.Enumerator<BuildSlot.Upgrade>  /*0x1B000023*/
    IL_00b6: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00bb: endfinally
    IL_00bc: ldarg.0
    IL_00bd: ldfld Hp PerkHpModifyer::hp  /*0x04000E50*/
    IL_00c2: dup
    IL_00c3: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_00c8: ldarg.0
    IL_00c9: ldfld float PerkHpModifyer::hpMultiplyer  /*0x04000E4F*/
    IL_00ce: mul
    IL_00cf: stfld float Hp::maxHp  /*0x04000A2C*/
    IL_00d4: ldarg.1
    IL_00d5: brfalse.s IL_00e7
    IL_00d7: ldarg.0
    IL_00d8: ldfld Hp PerkHpModifyer::hp  /*0x04000E50*/
    IL_00dd: ldc.r4 3.4028235E+38f
    IL_00e2: callvirt void Hp::Heal(float)  /*0x0600082E*/
    IL_00e7: ldarg.0
    IL_00e8: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_00ed: ret
    .try IL_0069-IL_0095 finally handler IL_0095-IL_00a3
    .try IL_0055-IL_00ae finally handler IL_00ae-IL_00bc

  .method PerkHpModifyer::.ctor()  // token 0x06000B71 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

