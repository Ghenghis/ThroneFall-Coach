// ===== DelayManualAttackWhileMoving  (token 0x020000B5) =====
  .method DelayManualAttackWhileMoving::Update()  // token 0x060003E2 rva 0x11119 attrs Private, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld PlayerMovement DelayManualAttackWhileMoving::playerMovement  /*0x04000506*/
    IL_0006: callvirt bool PlayerMovement::get_Moving()  /*0x06000C1D*/
    IL_000b: brfalse.s IL_002b
    IL_000d: ldarg.0
    IL_000e: ldfld ManualAttack DelayManualAttackWhileMoving::manualAttack  /*0x04000505*/
    IL_0013: dup
    IL_0014: callvirt float ManualAttack::get_Cooldown()  /*0x060009FD*/
    IL_0019: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_001e: ldarg.0
    IL_001f: ldfld float DelayManualAttackWhileMoving::percentage  /*0x04000507*/
    IL_0024: mul
    IL_0025: add
    IL_0026: callvirt void ManualAttack::set_Cooldown(float)  /*0x060009FE*/
    IL_002b: ret

  .method DelayManualAttackWhileMoving::.ctor()  // token 0x060003E3 rva 0x11146 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float DelayManualAttackWhileMoving::percentage  /*0x04000507*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

