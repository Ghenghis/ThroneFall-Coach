// ===== PlayerAttack  (token 0x0200022C) =====
  .method PlayerAttack::Start()  // token 0x06000B8F rva 0x36b2d attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_000c: stfld Player PlayerAttack::input  /*0x04000E6E*/
    IL_0011: ret

  .method PlayerAttack::Update()  // token 0x06000B90 rva 0x36b40 attrs Private, HideBySig
    // code size 59 (0x3b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ManualAttack PlayerAttack::attack  /*0x04000E6D*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: ldfld ManualAttack PlayerAttack::attack  /*0x04000E6D*/
    IL_0014: callvirt void ManualAttack::Tick()  /*0x06000A04*/
    IL_0019: ldarg.0
    IL_001a: ldfld ManualAttack PlayerAttack::attack  /*0x04000E6D*/
    IL_001f: callvirt void ManualAttack::DisableMarkersIfDead()  /*0x06000A03*/
    IL_0024: ldarg.0
    IL_0025: ldfld AttackCooldownAnimation PlayerAttack::ui  /*0x04000E6C*/
    IL_002a: ldarg.0
    IL_002b: ldfld ManualAttack PlayerAttack::attack  /*0x04000E6D*/
    IL_0030: callvirt float ManualAttack::get_CooldownPercentage()  /*0x06000A01*/
    IL_0035: callvirt void AttackCooldownAnimation::SetCurrentCooldownPercentage(float)  /*0x06000FA5*/
    IL_003a: ret

  .method PlayerAttack::AssignManualAttack(ManualAttack)  // token 0x06000B91 rva 0x36b7c attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld ManualAttack PlayerAttack::attack  /*0x04000E6D*/
    IL_0007: ret

  .method PlayerAttack::.ctor()  // token 0x06000B92 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

