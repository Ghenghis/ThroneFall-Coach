// ===== PerkCostModifyer  (token 0x0200021E) =====
  .method PerkCostModifyer::Start()  // token 0x06000B62 rva 0x364b4 attrs Private, HideBySig
    // code size 108 (0x6c), max stack 4, init locals
    .locals ([0] BuildSlot, [1] int, [2] BuildSlot.Upgrade)
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkCostModifyer::requiredPerk  /*0x04000E47*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brfalse.s IL_0065
    IL_000d: ldarg.0
    IL_000e: call !!0 UnityEngine.Component::GetComponentInParent()<BuildSlot>  /*0x2B000004*/
    IL_0013: stloc.0
    IL_0014: ldc.i4.0
    IL_0015: stloc.1
    IL_0016: br.s IL_0057
    IL_0018: ldloc.0
    IL_0019: callvirt List<BuildSlot.Upgrade> BuildSlot::get_Upgrades()  /*0x060002D1*/
    IL_001e: ldloc.1
    IL_001f: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0024: stloc.2
    IL_0025: ldloc.0
    IL_0026: callvirt ReadOnlyCollection<BuildSlot.Upgrade> BuildSlot::get_UpgradesWithCostsLoadedFromSave()  /*0x060002D8*/
    IL_002b: ldloc.2
    IL_002c: callvirt bool System.Collections.ObjectModel.ReadOnlyCollection<BuildSlot.Upgrade>::Contains(!0)  /*0x0A0004EA*/
    IL_0031: brtrue.s IL_0053
    IL_0033: ldarg.0
    IL_0034: ldfld int[] PerkCostModifyer::upgradeCostChange  /*0x04000E48*/
    IL_0039: ldlen
    IL_003a: conv.i4
    IL_003b: ldloc.1
    IL_003c: ble.s IL_0053
    IL_003e: ldloc.2
    IL_003f: dup
    IL_0040: ldfld int BuildSlot.Upgrade::cost  /*0x040003BB*/
    IL_0045: ldarg.0
    IL_0046: ldfld int[] PerkCostModifyer::upgradeCostChange  /*0x04000E48*/
    IL_004b: ldloc.1
    IL_004c: ldelem.i4
    IL_004d: add
    IL_004e: stfld int BuildSlot.Upgrade::cost  /*0x040003BB*/
    IL_0053: ldloc.1
    IL_0054: ldc.i4.1
    IL_0055: add
    IL_0056: stloc.1
    IL_0057: ldloc.1
    IL_0058: ldloc.0
    IL_0059: callvirt List<BuildSlot.Upgrade> BuildSlot::get_Upgrades()  /*0x060002D1*/
    IL_005e: callvirt int System.Collections.Generic.List<BuildSlot.Upgrade>::get_Count()  /*0x0A000118*/
    IL_0063: blt.s IL_0018
    IL_0065: ldarg.0
    IL_0066: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_006b: ret

  .method PerkCostModifyer::.ctor()  // token 0x06000B63 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

