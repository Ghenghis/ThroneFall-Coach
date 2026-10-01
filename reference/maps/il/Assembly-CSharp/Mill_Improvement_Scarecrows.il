// ===== Mill_Improvement_Scarecrows  (token 0x020001F5) =====
  .method Mill_Improvement_Scarecrows::OnEnable()  // token 0x06000A5B rva 0x30dd4 attrs Private, HideBySig
    // code size 210 (0xd2), max stack 2, init locals
    .locals ([0] List.Enumerator<BuildSlot>, [1] BuildSlot, [2] Scarecrow[], [3] int, [4] Scarecrow)
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot Mill_Improvement_Scarecrows::buildSlot  /*0x04000D1D*/
    IL_0006: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_000b: ldc.i4.1
    IL_000c: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0011: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0016: ldc.i4.0
    IL_0017: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_001c: ldarg.0
    IL_001d: ldfld Mesh Mill_Improvement_Scarecrows::lvl2Mesh  /*0x04000D1E*/
    IL_0022: stfld Mesh BuildSlot.UpgradeBranch::replacementMesh  /*0x040003C0*/
    IL_0027: ldarg.0
    IL_0028: ldfld BuildSlot Mill_Improvement_Scarecrows::buildSlot  /*0x04000D1D*/
    IL_002d: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0032: ldc.i4.2
    IL_0033: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0038: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_003d: ldc.i4.0
    IL_003e: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_0043: ldarg.0
    IL_0044: ldfld Mesh Mill_Improvement_Scarecrows::lvl3Mesh  /*0x04000D1F*/
    IL_0049: stfld Mesh BuildSlot.UpgradeBranch::replacementMesh  /*0x040003C0*/
    IL_004e: ldarg.0
    IL_004f: ldfld BuildSlot Mill_Improvement_Scarecrows::buildSlot  /*0x04000D1D*/
    IL_0054: callvirt List<BuildSlot> BuildSlot::get_BuiltSlotsThatRelyOnThisBuilding()  /*0x060002EC*/
    IL_0059: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot>::GetEnumerator()  /*0x0A000137*/
    IL_005e: stloc.0
    IL_005f: br.s IL_00b8
    IL_0061: ldloca.s 0
    IL_0063: call !0 System.Collections.Generic.List.Enumerator<BuildSlot>::get_Current()  /*0x0A000138*/
    IL_0068: stloc.1
    IL_0069: ldloc.1
    IL_006a: callvirt !!0[] UnityEngine.Component::GetComponents()<Scarecrow>  /*0x2B0000A1*/
    IL_006f: stloc.2
    IL_0070: ldc.i4.0
    IL_0071: stloc.3
    IL_0072: br.s IL_00b2
    IL_0074: ldloc.2
    IL_0075: ldloc.3
    IL_0076: ldelem.ref
    IL_0077: stloc.s 4
    IL_0079: ldloc.s 4
    IL_007b: ldfld GameObject Scarecrow::scareCrow  /*0x0A000484*/
    IL_0080: ldc.i4.1
    IL_0081: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0086: ldloc.1
    IL_0087: callvirt List<BuildSlot.Upgrade> BuildSlot::get_Upgrades()  /*0x060002D1*/
    IL_008c: ldc.i4.0
    IL_008d: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0092: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0097: ldc.i4.0
    IL_0098: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_009d: ldfld List<GameObject> BuildSlot.UpgradeBranch::objectsToActivate  /*0x040003C4*/
    IL_00a2: ldloc.s 4
    IL_00a4: ldfld GameObject Scarecrow::scareCrow  /*0x0A000484*/
    IL_00a9: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_00ae: ldloc.3
    IL_00af: ldc.i4.1
    IL_00b0: add
    IL_00b1: stloc.3
    IL_00b2: ldloc.3
    IL_00b3: ldloc.2
    IL_00b4: ldlen
    IL_00b5: conv.i4
    IL_00b6: blt.s IL_0074
    IL_00b8: ldloca.s 0
    IL_00ba: call bool System.Collections.Generic.List.Enumerator<BuildSlot>::MoveNext()  /*0x0A000139*/
    IL_00bf: brtrue.s IL_0061
    IL_00c1: leave.s IL_00d1
    IL_00c3: ldloca.s 0
    IL_00c5: constrained. System.Collections.Generic.List.Enumerator<BuildSlot>  /*0x1B000029*/
    IL_00cb: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00d0: endfinally
    IL_00d1: ret
    .try IL_005f-IL_00c3 finally handler IL_00c3-IL_00d1

  .method Mill_Improvement_Scarecrows::.ctor()  // token 0x06000A5C rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

