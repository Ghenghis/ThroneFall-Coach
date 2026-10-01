// ===== AncientShrinePerk  (token 0x02000016) =====
  .method AncientShrinePerk::Start()  // token 0x0600008B rva 0x4759 attrs Private, HideBySig
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable AncientShrinePerk::requiredPerk  /*0x0400008F*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brtrue.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: ldfld BuildSlot AncientShrinePerk::buildSlot  /*0x04000090*/
    IL_0014: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0019: brtrue.s IL_002c
    IL_001b: ldarg.0
    IL_001c: ldfld BuildSlot AncientShrinePerk::buildSlot  /*0x04000090*/
    IL_0021: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0026: ldc.i4.0
    IL_0027: callvirt void BuildSlot::ExecuteBuildOrUpgrade(PlayerInteraction,bool)  /*0x060002F7*/
    IL_002c: ldarg.0
    IL_002d: ldfld Shrine AncientShrinePerk::shrine  /*0x04000091*/
    IL_0032: ldarg.0
    IL_0033: ldfld float AncientShrinePerk::xpRequirementMulti  /*0x04000092*/
    IL_0038: callvirt void Shrine::AdjustRequiredXp(float)  /*0x06000E16*/
    IL_003d: ret

  .method AncientShrinePerk::.ctor()  // token 0x0600008C rva 0x4798 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 2f
    IL_0006: stfld float AncientShrinePerk::xpRequirementMulti  /*0x04000092*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

