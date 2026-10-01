// ===== UpgradePlayerHp  (token 0x02000242) =====
  .method UpgradePlayerHp::OnEnable()  // token 0x06000C65 rva 0x397c8 attrs Private, HideBySig
    // code size 86 (0x56), max stack 4, init locals
    .locals ([0] PlayerMovement[], [1] int)
    IL_0000: call PlayerManager PlayerManager::get_Instance()  /*0x06000C14*/
    IL_0005: callvirt PlayerMovement[] PlayerManager::get_RegisteredPlayers()  /*0x06000C15*/
    IL_000a: stloc.0
    IL_000b: ldc.i4.0
    IL_000c: stloc.1
    IL_000d: br.s IL_0038
    IL_000f: ldloc.0
    IL_0010: ldloc.1
    IL_0011: ldelem.ref
    IL_0012: callvirt !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_0017: dup
    IL_0018: dup
    IL_0019: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_001e: ldarg.0
    IL_001f: ldfld float UpgradePlayerHp::healthMultiplyer  /*0x04000F1F*/
    IL_0024: mul
    IL_0025: stfld float Hp::maxHp  /*0x04000A2C*/
    IL_002a: ldc.r4 3.4028235E+38f
    IL_002f: callvirt void Hp::Heal(float)  /*0x0600082E*/
    IL_0034: ldloc.1
    IL_0035: ldc.i4.1
    IL_0036: add
    IL_0037: stloc.1
    IL_0038: ldloc.1
    IL_0039: ldloc.0
    IL_003a: ldlen
    IL_003b: conv.i4
    IL_003c: blt.s IL_000f
    IL_003e: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0043: dup
    IL_0044: callvirt float PlayerUpgradeManager::get_PlayerHealthRegenerationMultiplyer()  /*0x06000C69*/
    IL_0049: ldarg.0
    IL_004a: ldfld float UpgradePlayerHp::heatlhRegenMultiplyer  /*0x04000F20*/
    IL_004f: mul
    IL_0050: callvirt void PlayerUpgradeManager::set_PlayerHealthRegenerationMultiplyer(float)  /*0x06000C6A*/
    IL_0055: ret

  .method UpgradePlayerHp::.ctor()  // token 0x06000C66 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

