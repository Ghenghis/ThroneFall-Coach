// ===== PerkPlayerHealthRegen  (token 0x02000225) =====
  .method PerkPlayerHealthRegen::OnBeforeMainLoadPass(string)  // token 0x06000B7B rva 0x3696a attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: call void PerkPlayerHealthRegen::Execute(bool)  /*0x06000B80*/
    IL_0007: ret

  .method PerkPlayerHealthRegen::OnAfterMainLoadPass(string)  // token 0x06000B7C rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PerkPlayerHealthRegen::OnLoad(string)  // token 0x06000B7D rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PerkPlayerHealthRegen::OnSave(string)  // token 0x06000B7E rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PerkPlayerHealthRegen::Start()  // token 0x06000B7F rva 0x36973 attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: call void PerkPlayerHealthRegen::Execute(bool)  /*0x06000B80*/
    IL_0007: ret

  .method PerkPlayerHealthRegen::Execute(bool)  // token 0x06000B80 rva 0x3697c attrs Private, HideBySig
    // code size 60 (0x3c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool PerkPlayerHealthRegen::executed  /*0x04000E59*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.i4.1
    IL_000b: stfld bool PerkPlayerHealthRegen::executed  /*0x04000E59*/
    IL_0010: ldarg.0
    IL_0011: ldfld Equippable PerkPlayerHealthRegen::requiredPerk  /*0x04000E57*/
    IL_0016: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_001b: brtrue.s IL_001e
    IL_001d: ret
    IL_001e: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0023: dup
    IL_0024: callvirt float PlayerUpgradeManager::get_PlayerHealthRegenerationMultiplyer()  /*0x06000C69*/
    IL_0029: ldarg.0
    IL_002a: ldfld float PerkPlayerHealthRegen::hpRegenMultiplyer  /*0x04000E58*/
    IL_002f: mul
    IL_0030: callvirt void PlayerUpgradeManager::set_PlayerHealthRegenerationMultiplyer(float)  /*0x06000C6A*/
    IL_0035: ldarg.0
    IL_0036: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_003b: ret

  .method PerkPlayerHealthRegen::.ctor()  // token 0x06000B81 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

