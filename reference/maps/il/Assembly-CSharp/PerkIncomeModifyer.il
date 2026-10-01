// ===== PerkIncomeModifyer  (token 0x02000223) =====
  .method PerkIncomeModifyer::OnBeforeMainLoadPass(string)  // token 0x06000B72 rva 0x36874 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void PerkIncomeModifyer::Execute()  /*0x06000B77*/
    IL_0006: ret

  .method PerkIncomeModifyer::OnAfterMainLoadPass(string)  // token 0x06000B73 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PerkIncomeModifyer::OnLoad(string)  // token 0x06000B74 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PerkIncomeModifyer::OnSave(string)  // token 0x06000B75 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PerkIncomeModifyer::Start()  // token 0x06000B76 rva 0x36874 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void PerkIncomeModifyer::Execute()  /*0x06000B77*/
    IL_0006: ret

  .method PerkIncomeModifyer::Execute()  // token 0x06000B77 rva 0x3687c attrs Private, HideBySig
    // code size 155 (0x9b), max stack 4, init locals
    .locals ([0] BuildSlot, [1] int, [2] List.Enumerator<BuildSlot.UpgradeBranch>, [3] BuildSlot.UpgradeBranch)
    IL_0000: ldarg.0
    IL_0001: ldfld bool PerkIncomeModifyer::executed  /*0x04000E55*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.i4.1
    IL_000b: stfld bool PerkIncomeModifyer::executed  /*0x04000E55*/
    IL_0010: ldarg.0
    IL_0011: ldfld Equippable PerkIncomeModifyer::requiredPerk  /*0x04000E53*/
    IL_0016: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_001b: brfalse.s IL_0094
    IL_001d: ldarg.0
    IL_001e: call !!0 UnityEngine.Component::GetComponent()<BuildSlot>  /*0x2B00001A*/
    IL_0023: stloc.0
    IL_0024: ldc.i4.0
    IL_0025: stloc.1
    IL_0026: br.s IL_0086
    IL_0028: ldloc.0
    IL_0029: callvirt List<BuildSlot.Upgrade> BuildSlot::get_Upgrades()  /*0x060002D1*/
    IL_002e: ldloc.1
    IL_002f: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0034: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0039: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot.UpgradeBranch>::GetEnumerator()  /*0x0A000121*/
    IL_003e: stloc.2
    IL_003f: br.s IL_0069
    IL_0041: ldloca.s 2
    IL_0043: call !0 System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::get_Current()  /*0x0A000122*/
    IL_0048: stloc.3
    IL_0049: ldarg.0
    IL_004a: ldfld int[] PerkIncomeModifyer::upgradeIncomeChange  /*0x04000E54*/
    IL_004f: ldlen
    IL_0050: conv.i4
    IL_0051: ldloc.1
    IL_0052: ble.s IL_0069
    IL_0054: ldloc.3
    IL_0055: dup
    IL_0056: ldfld int BuildSlot.UpgradeBranch::goldIncomeChange  /*0x040003C1*/
    IL_005b: ldarg.0
    IL_005c: ldfld int[] PerkIncomeModifyer::upgradeIncomeChange  /*0x04000E54*/
    IL_0061: ldloc.1
    IL_0062: ldelem.i4
    IL_0063: add
    IL_0064: stfld int BuildSlot.UpgradeBranch::goldIncomeChange  /*0x040003C1*/
    IL_0069: ldloca.s 2
    IL_006b: call bool System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::MoveNext()  /*0x0A000125*/
    IL_0070: brtrue.s IL_0041
    IL_0072: leave.s IL_0082
    IL_0074: ldloca.s 2
    IL_0076: constrained. System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>  /*0x1B000022*/
    IL_007c: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0081: endfinally
    IL_0082: ldloc.1
    IL_0083: ldc.i4.1
    IL_0084: add
    IL_0085: stloc.1
    IL_0086: ldloc.1
    IL_0087: ldloc.0
    IL_0088: callvirt List<BuildSlot.Upgrade> BuildSlot::get_Upgrades()  /*0x060002D1*/
    IL_008d: callvirt int System.Collections.Generic.List<BuildSlot.Upgrade>::get_Count()  /*0x0A000118*/
    IL_0092: blt.s IL_0028
    IL_0094: ldarg.0
    IL_0095: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_009a: ret
    .try IL_003f-IL_0074 finally handler IL_0074-IL_0082

  .method PerkIncomeModifyer::.ctor()  // token 0x06000B78 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

