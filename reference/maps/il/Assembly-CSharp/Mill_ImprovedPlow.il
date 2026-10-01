// ===== Mill_ImprovedPlow  (token 0x020001F2) =====
  .method Mill_ImprovedPlow::OnEnable()  // token 0x06000A47 rva 0x30858 attrs Private, HideBySig
    // code size 240 (0xf0), max stack 3, init locals
    .locals ([0] List.Enumerator<BuildSlot.UpgradeBranch>)
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot Mill_ImprovedPlow::buildSlot  /*0x04000D05*/
    IL_0006: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_000b: ldc.i4.1
    IL_000c: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0011: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0016: ldc.i4.0
    IL_0017: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_001c: ldarg.0
    IL_001d: ldfld Mesh Mill_ImprovedPlow::lvl2Mesh  /*0x04000D06*/
    IL_0022: stfld Mesh BuildSlot.UpgradeBranch::replacementMesh  /*0x040003C0*/
    IL_0027: ldarg.0
    IL_0028: ldfld BuildSlot Mill_ImprovedPlow::buildSlot  /*0x04000D05*/
    IL_002d: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0032: ldc.i4.2
    IL_0033: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0038: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_003d: ldc.i4.0
    IL_003e: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_0043: ldarg.0
    IL_0044: ldfld Mesh Mill_ImprovedPlow::lvl3Mesh  /*0x04000D07*/
    IL_0049: stfld Mesh BuildSlot.UpgradeBranch::replacementMesh  /*0x040003C0*/
    IL_004e: ldarg.0
    IL_004f: ldfld BuildSlot Mill_ImprovedPlow::buildSlot  /*0x04000D05*/
    IL_0054: callvirt List<BuildSlot.Upgrade> BuildSlot::get_Upgrades()  /*0x060002D1*/
    IL_0059: ldc.i4.1
    IL_005a: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_005f: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0064: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot.UpgradeBranch>::GetEnumerator()  /*0x0A000121*/
    IL_0069: stloc.0
    IL_006a: br.s IL_0080
    IL_006c: ldloca.s 0
    IL_006e: call !0 System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::get_Current()  /*0x0A000122*/
    IL_0073: dup
    IL_0074: ldfld int BuildSlot.UpgradeBranch::goldIncomeChange  /*0x040003C1*/
    IL_0079: ldc.i4.1
    IL_007a: add
    IL_007b: stfld int BuildSlot.UpgradeBranch::goldIncomeChange  /*0x040003C1*/
    IL_0080: ldloca.s 0
    IL_0082: call bool System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::MoveNext()  /*0x0A000125*/
    IL_0087: brtrue.s IL_006c
    IL_0089: leave.s IL_0099
    IL_008b: ldloca.s 0
    IL_008d: constrained. System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>  /*0x1B000022*/
    IL_0093: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0098: endfinally
    IL_0099: ldarg.0
    IL_009a: ldfld BuildSlot Mill_ImprovedPlow::buildSlot  /*0x04000D05*/
    IL_009f: callvirt List<BuildSlot.Upgrade> BuildSlot::get_Upgrades()  /*0x060002D1*/
    IL_00a4: ldc.i4.2
    IL_00a5: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_00aa: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_00af: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot.UpgradeBranch>::GetEnumerator()  /*0x0A000121*/
    IL_00b4: stloc.0
    IL_00b5: br.s IL_00cb
    IL_00b7: ldloca.s 0
    IL_00b9: call !0 System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::get_Current()  /*0x0A000122*/
    IL_00be: dup
    IL_00bf: ldfld int BuildSlot.UpgradeBranch::goldIncomeChange  /*0x040003C1*/
    IL_00c4: ldc.i4.1
    IL_00c5: add
    IL_00c6: stfld int BuildSlot.UpgradeBranch::goldIncomeChange  /*0x040003C1*/
    IL_00cb: ldloca.s 0
    IL_00cd: call bool System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::MoveNext()  /*0x0A000125*/
    IL_00d2: brtrue.s IL_00b7
    IL_00d4: leave.s IL_00e4
    IL_00d6: ldloca.s 0
    IL_00d8: constrained. System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>  /*0x1B000022*/
    IL_00de: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00e3: endfinally
    IL_00e4: ldarg.0
    IL_00e5: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00ea: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_00ef: ret
    .try IL_006a-IL_008b finally handler IL_008b-IL_0099
    .try IL_00b5-IL_00d6 finally handler IL_00d6-IL_00e4

  .method Mill_ImprovedPlow::.ctor()  // token 0x06000A48 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

