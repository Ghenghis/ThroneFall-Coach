// ===== UpgradeAssassinsTraining  (token 0x0200023A) =====
  .method UpgradeAssassinsTraining::OnEnable()  // token 0x06000C33 rva 0x390ec attrs Private, HideBySig
    // code size 101 (0x65), max stack 3, init locals
    .locals ([0] ManualAttack[], [1] int, [2] ManualAttack)
    IL_0000: ldarg.0
    IL_0001: stsfld UpgradeAssassinsTraining UpgradeAssassinsTraining::instance  /*0x04000F00*/
    IL_0006: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_000b: ldc.i4.1
    IL_000c: stfld bool PlayerUpgradeManager::assassinsTraining  /*0x04000F26*/
    IL_0011: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_0016: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001b: ldc.i4.1
    IL_001c: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren(bool)<ManualAttack>  /*0x2B0000B4*/
    IL_0021: stloc.0
    IL_0022: ldc.i4.0
    IL_0023: stloc.1
    IL_0024: br.s IL_005e
    IL_0026: ldloc.0
    IL_0027: ldloc.1
    IL_0028: ldelem.ref
    IL_0029: stloc.2
    IL_002a: ldloc.2
    IL_002b: ldfld bool ManualAttack::autoAttack  /*0x04000CBE*/
    IL_0030: brfalse.s IL_0047
    IL_0032: ldloc.2
    IL_0033: dup
    IL_0034: ldfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_0039: ldarg.0
    IL_003a: ldfld float UpgradeAssassinsTraining::autoAttackCooldownDurationMulti  /*0x04000F01*/
    IL_003f: mul
    IL_0040: stfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_0045: br.s IL_005a
    IL_0047: ldloc.2
    IL_0048: dup
    IL_0049: ldfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_004e: ldarg.0
    IL_004f: ldfld float UpgradeAssassinsTraining::manualAttackCooldownDurationMulti  /*0x04000F02*/
    IL_0054: mul
    IL_0055: stfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_005a: ldloc.1
    IL_005b: ldc.i4.1
    IL_005c: add
    IL_005d: stloc.1
    IL_005e: ldloc.1
    IL_005f: ldloc.0
    IL_0060: ldlen
    IL_0061: conv.i4
    IL_0062: blt.s IL_0026
    IL_0064: ret

  .method UpgradeAssassinsTraining::.ctor()  // token 0x06000C34 rva 0x3915d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 2f
    IL_0006: stfld float UpgradeAssassinsTraining::autoAttackCooldownDurationMulti  /*0x04000F01*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 2f
    IL_0011: stfld float UpgradeAssassinsTraining::manualAttackCooldownDurationMulti  /*0x04000F02*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.5f
    IL_001c: stfld float UpgradeAssassinsTraining::activationWindow  /*0x04000F03*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 0.5f
    IL_0027: stfld float UpgradeAssassinsTraining::cooldownMultiForPerfectlyTimedAttacks  /*0x04000F04*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0032: ret

