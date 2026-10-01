// ===== PlayerAttackTargetFacer  (token 0x0200002A) =====
  .method PlayerAttackTargetFacer::AssignAttack(ManualAttack)  // token 0x060000DA rva 0x583c attrs Public, HideBySig
    // code size 78 (0x4e), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld ManualAttack PlayerAttackTargetFacer::attack  /*0x04000102*/
    IL_0007: ldarg.0
    IL_0008: ldfld ManualAttack PlayerAttackTargetFacer::attack  /*0x04000102*/
    IL_000d: ldfld UnityEvent ManualAttack::onAttack  /*0x04000CCC*/
    IL_0012: ldarg.0
    IL_0013: ldftn void PlayerAttackTargetFacer::UpdateTarget()  /*0x060000DB*/
    IL_0019: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_001e: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0023: ldarg.0
    IL_0024: ldfld ManualAttack PlayerAttackTargetFacer::attack  /*0x04000102*/
    IL_0029: ldfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_002e: ldarg.0
    IL_002f: ldfld float PlayerAttackTargetFacer::lookBackTime  /*0x04000104*/
    IL_0034: bgt.un.s IL_004d
    IL_0036: ldarg.0
    IL_0037: ldarg.0
    IL_0038: ldfld ManualAttack PlayerAttackTargetFacer::attack  /*0x04000102*/
    IL_003d: ldfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_0042: ldc.r4 0.05f
    IL_0047: add
    IL_0048: stfld float PlayerAttackTargetFacer::lookBackTime  /*0x04000104*/
    IL_004d: ret

  .method PlayerAttackTargetFacer::UpdateTarget()  // token 0x060000DB rva 0x5898 attrs Private, HideBySig
    // code size 119 (0x77), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld ManualAttack PlayerAttackTargetFacer::attack  /*0x04000102*/
    IL_0006: callvirt Vector3 ManualAttack::get_LastTargetPos()  /*0x060009FF*/
    IL_000b: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0010: call bool UnityEngine.Vector3::op_Equality(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A00009F*/
    IL_0015: brfalse.s IL_0018
    IL_0017: ret
    IL_0018: ldarg.0
    IL_0019: ldarg.0
    IL_001a: ldfld ManualAttack PlayerAttackTargetFacer::attack  /*0x04000102*/
    IL_001f: callvirt Vector3 ManualAttack::get_LastTargetPos()  /*0x060009FF*/
    IL_0024: ldarg.0
    IL_0025: ldfld Transform PlayerAttackTargetFacer::targetTransform  /*0x04000101*/
    IL_002a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002f: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0034: stfld Vector3 PlayerAttackTargetFacer::desiredForwardVector  /*0x04000105*/
    IL_0039: ldarg.0
    IL_003a: ldflda Vector3 PlayerAttackTargetFacer::desiredForwardVector  /*0x04000105*/
    IL_003f: ldc.r4 0f
    IL_0044: stfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0049: ldarg.0
    IL_004a: ldflda Vector3 PlayerAttackTargetFacer::desiredForwardVector  /*0x04000105*/
    IL_004f: call void UnityEngine.Vector3::Normalize()  /*0x0A0000A0*/
    IL_0054: ldarg.0
    IL_0055: ldarg.0
    IL_0056: ldfld Vector3 PlayerAttackTargetFacer::desiredForwardVector  /*0x04000105*/
    IL_005b: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0060: call Quaternion UnityEngine.Quaternion::LookRotation(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000070*/
    IL_0065: stfld Quaternion PlayerAttackTargetFacer::desiredRotation  /*0x04000106*/
    IL_006a: ldarg.0
    IL_006b: ldarg.0
    IL_006c: ldfld float PlayerAttackTargetFacer::lookBackTime  /*0x04000104*/
    IL_0071: stfld float PlayerAttackTargetFacer::lookClock  /*0x04000107*/
    IL_0076: ret

  .method PlayerAttackTargetFacer::Update()  // token 0x060000DC rva 0x591c attrs Private, HideBySig
    // code size 232 (0xe8), max stack 5, init locals
    .locals ([0] Quaternion)
    IL_0000: ldarg.0
    IL_0001: ldfld float PlayerAttackTargetFacer::lookClock  /*0x04000107*/
    IL_0006: ldc.r4 0f
    IL_000b: blt.un.s IL_007c
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld float PlayerAttackTargetFacer::lookClock  /*0x04000107*/
    IL_0014: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0019: sub
    IL_001a: stfld float PlayerAttackTargetFacer::lookClock  /*0x04000107*/
    IL_001f: ldarg.0
    IL_0020: ldfld Transform PlayerAttackTargetFacer::targetTransform  /*0x04000101*/
    IL_0025: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_002a: stloc.0
    IL_002b: ldloca.s 0
    IL_002d: ldarg.0
    IL_002e: ldfld Quaternion PlayerAttackTargetFacer::desiredRotation  /*0x04000106*/
    IL_0033: call bool UnityEngine.Quaternion::Equals(UnityEngine.Quaternion)  /*0x0A0000A1*/
    IL_0038: brtrue.s IL_0067
    IL_003a: ldarg.0
    IL_003b: ldfld Transform PlayerAttackTargetFacer::targetTransform  /*0x04000101*/
    IL_0040: ldarg.0
    IL_0041: ldfld Transform PlayerAttackTargetFacer::targetTransform  /*0x04000101*/
    IL_0046: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_004b: ldarg.0
    IL_004c: ldfld Quaternion PlayerAttackTargetFacer::desiredRotation  /*0x04000106*/
    IL_0051: ldarg.0
    IL_0052: ldfld float PlayerAttackTargetFacer::maxRotationDelta  /*0x04000103*/
    IL_0057: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_005c: mul
    IL_005d: call Quaternion UnityEngine.Quaternion::RotateTowards(UnityEngine.Quaternion,UnityEngine.Quaternion,float)  /*0x0A0000A2*/
    IL_0062: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0067: ldarg.0
    IL_0068: ldfld float PlayerAttackTargetFacer::lookClock  /*0x04000107*/
    IL_006d: ldc.r4 0f
    IL_0072: bgt.un.s IL_00e7
    IL_0074: ldarg.0
    IL_0075: ldc.i4.1
    IL_0076: stfld bool PlayerAttackTargetFacer::shouldReset  /*0x04000108*/
    IL_007b: ret
    IL_007c: ldarg.0
    IL_007d: ldfld bool PlayerAttackTargetFacer::shouldReset  /*0x04000108*/
    IL_0082: brfalse.s IL_00e7
    IL_0084: ldarg.0
    IL_0085: ldfld Transform PlayerAttackTargetFacer::targetTransform  /*0x04000101*/
    IL_008a: ldarg.0
    IL_008b: ldfld Transform PlayerAttackTargetFacer::targetTransform  /*0x04000101*/
    IL_0090: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0095: ldarg.0
    IL_0096: ldfld Transform PlayerAttackTargetFacer::targetTransform  /*0x04000101*/
    IL_009b: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_00a0: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_00a5: ldarg.0
    IL_00a6: ldfld float PlayerAttackTargetFacer::maxRotationDelta  /*0x04000103*/
    IL_00ab: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00b0: mul
    IL_00b1: call Quaternion UnityEngine.Quaternion::RotateTowards(UnityEngine.Quaternion,UnityEngine.Quaternion,float)  /*0x0A0000A2*/
    IL_00b6: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_00bb: ldarg.0
    IL_00bc: ldfld Transform PlayerAttackTargetFacer::targetTransform  /*0x04000101*/
    IL_00c1: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_00c6: stloc.0
    IL_00c7: ldloca.s 0
    IL_00c9: ldarg.0
    IL_00ca: ldfld Transform PlayerAttackTargetFacer::targetTransform  /*0x04000101*/
    IL_00cf: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_00d4: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_00d9: call bool UnityEngine.Quaternion::Equals(UnityEngine.Quaternion)  /*0x0A0000A1*/
    IL_00de: brfalse.s IL_00e7
    IL_00e0: ldarg.0
    IL_00e1: ldc.i4.0
    IL_00e2: stfld bool PlayerAttackTargetFacer::shouldReset  /*0x04000108*/
    IL_00e7: ret

  .method PlayerAttackTargetFacer::.ctor()  // token 0x060000DD rva 0x5a10 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 360f
    IL_0006: stfld float PlayerAttackTargetFacer::maxRotationDelta  /*0x04000103*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.4f
    IL_0011: stfld float PlayerAttackTargetFacer::lookBackTime  /*0x04000104*/
    IL_0016: ldarg.0
    IL_0017: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_001c: stfld Quaternion PlayerAttackTargetFacer::desiredRotation  /*0x04000106*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

