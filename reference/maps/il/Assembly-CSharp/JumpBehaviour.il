// ===== JumpBehaviour  (token 0x020000DE) =====
  .method JumpBehaviour::RequestJump(UnityEngine.Vector3,bool)  // token 0x060004A9 rva 0x148ed attrs Public, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool JumpBehaviour::requestJump  /*0x04000601*/
    IL_0007: ldarg.0
    IL_0008: ldarg.1
    IL_0009: stfld Vector3 JumpBehaviour::positionToJump  /*0x04000600*/
    IL_000e: ldarg.0
    IL_000f: ldarg.2
    IL_0010: stfld bool JumpBehaviour::needPathCheck  /*0x04000603*/
    IL_0015: ret

  .method JumpBehaviour::NoJumpWithEvent()  // token 0x060004AA rva 0x14904 attrs Public, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent JumpBehaviour::EndJumpEvent  /*0x040005FF*/
    IL_0006: dup
    IL_0007: brtrue.s IL_000b
    IL_0009: pop
    IL_000a: ret
    IL_000b: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0010: ret

  .method JumpBehaviour::SnapJumpWithEvent(UnityEngine.Vector3)  // token 0x060004AB rva 0x14918 attrs Public, HideBySig
    // code size 42 (0x2a), max stack 2, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld PathfindMovementEnemy JumpBehaviour::unitMovement  /*0x040005F9*/
    IL_0006: ldarg.1
    IL_0007: callvirt Vector3 PathfindMovementEnemy::GetNearestGroundPosition(UnityEngine.Vector3)  /*0x06000B1B*/
    IL_000c: stloc.0
    IL_000d: ldarg.0
    IL_000e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0013: ldloc.0
    IL_0014: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0019: ldarg.0
    IL_001a: ldfld UnityEvent JumpBehaviour::EndJumpEvent  /*0x040005FF*/
    IL_001f: dup
    IL_0020: brtrue.s IL_0024
    IL_0022: pop
    IL_0023: ret
    IL_0024: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0029: ret

  .method JumpBehaviour::Update()  // token 0x060004AC rva 0x1494e attrs Private, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool JumpBehaviour::requestJump  /*0x04000601*/
    IL_0006: brfalse.s IL_0010
    IL_0008: ldarg.0
    IL_0009: ldfld bool JumpBehaviour::jumpAnimRunning  /*0x04000602*/
    IL_000e: brfalse.s IL_0011
    IL_0010: ret
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: call IEnumerator JumpBehaviour::JumpAnimation()  /*0x060004AD*/
    IL_0018: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_001d: pop
    IL_001e: ret

  .method JumpBehaviour::JumpAnimation()  // token 0x060004AD rva 0x1496e attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void JumpBehaviour.<JumpAnimation>d__15::.ctor(int)  /*0x060004AF*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld JumpBehaviour JumpBehaviour.<JumpAnimation>d__15::<>4__this  /*0x04000606*/
    IL_000d: ret

  .method JumpBehaviour::.ctor()  // token 0x060004AE rva 0x1497d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 47 (0x2f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.1f
    IL_0006: stfld float JumpBehaviour::snapRange  /*0x040005FA*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float JumpBehaviour::jumpDuration  /*0x040005FB*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 10f
    IL_001c: stfld float JumpBehaviour::jumpHeight  /*0x040005FC*/
    IL_0021: ldarg.0
    IL_0022: ldc.i4.1
    IL_0023: stfld bool JumpBehaviour::needPathCheck  /*0x04000603*/
    IL_0028: ldarg.0
    IL_0029: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_002e: ret

// ===== JumpBehaviour/<JumpAnimation>d__15  (token 0x020000DF) =====
  .method JumpBehaviour.<JumpAnimation>d__15::.ctor(int)  // token 0x060004AF rva 0x149ad attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int JumpBehaviour.<JumpAnimation>d__15::<>1__state  /*0x04000604*/
    IL_000d: ret

  .method JumpBehaviour.<JumpAnimation>d__15::System.IDisposable.Dispose()  // token 0x060004B0 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method JumpBehaviour.<JumpAnimation>d__15::MoveNext()  // token 0x060004B1 rva 0x149bc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 463 (0x1cf), max stack 4, init locals
    .locals ([0] int, [1] JumpBehaviour, [2] Vector3, [3] Vector3, [4] float)
    IL_0000: ldarg.0
    IL_0001: ldfld int JumpBehaviour.<JumpAnimation>d__15::<>1__state  /*0x04000604*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld JumpBehaviour JumpBehaviour.<JumpAnimation>d__15::<>4__this  /*0x04000606*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_0130
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int JumpBehaviour.<JumpAnimation>d__15::<>1__state  /*0x04000604*/
    IL_0021: ldloc.1
    IL_0022: ldc.i4.1
    IL_0023: stfld bool JumpBehaviour::jumpAnimRunning  /*0x04000602*/
    IL_0028: ldloc.1
    IL_0029: ldfld PathfindMovementEnemy JumpBehaviour::unitMovement  /*0x040005F9*/
    IL_002e: ldc.i4.0
    IL_002f: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0034: ldarg.0
    IL_0035: ldloc.1
    IL_0036: ldfld Vector3 JumpBehaviour::positionToJump  /*0x04000600*/
    IL_003b: stfld Vector3 JumpBehaviour.<JumpAnimation>d__15::<targetPosition>5__2  /*0x04000607*/
    IL_0040: ldloc.1
    IL_0041: ldfld PathfindMovementEnemy JumpBehaviour::unitMovement  /*0x040005F9*/
    IL_0046: ldarg.0
    IL_0047: ldfld Vector3 JumpBehaviour.<JumpAnimation>d__15::<targetPosition>5__2  /*0x04000607*/
    IL_004c: callvirt Vector3 PathfindMovementEnemy::GetNearestGroundPosition(UnityEngine.Vector3)  /*0x06000B1B*/
    IL_0051: stloc.2
    IL_0052: ldloc.1
    IL_0053: ldfld bool JumpBehaviour::needPathCheck  /*0x04000603*/
    IL_0058: brfalse.s IL_0079
    IL_005a: ldloc.2
    IL_005b: ldarg.0
    IL_005c: ldfld Vector3 JumpBehaviour.<JumpAnimation>d__15::<targetPosition>5__2  /*0x04000607*/
    IL_0061: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0066: stloc.3
    IL_0067: ldloca.s 3
    IL_0069: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_006e: ldloc.1
    IL_006f: ldfld float JumpBehaviour::snapRange  /*0x040005FA*/
    IL_0074: bge.un IL_017d
    IL_0079: ldarg.0
    IL_007a: ldloc.1
    IL_007b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0080: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0085: stfld Vector3 JumpBehaviour.<JumpAnimation>d__15::<startPos>5__3  /*0x04000608*/
    IL_008a: ldarg.0
    IL_008b: ldloc.1
    IL_008c: ldfld bool JumpBehaviour::needPathCheck  /*0x04000603*/
    IL_0091: brtrue.s IL_009b
    IL_0093: ldarg.0
    IL_0094: ldfld Vector3 JumpBehaviour.<JumpAnimation>d__15::<targetPosition>5__2  /*0x04000607*/
    IL_0099: br.s IL_009c
    IL_009b: ldloc.2
    IL_009c: stfld Vector3 JumpBehaviour.<JumpAnimation>d__15::<targetPosition>5__2  /*0x04000607*/
    IL_00a1: ldloc.1
    IL_00a2: ldfld UnityEvent<Vector3> JumpBehaviour::StartJumpEvent  /*0x040005FE*/
    IL_00a7: dup
    IL_00a8: brtrue.s IL_00ad
    IL_00aa: pop
    IL_00ab: br.s IL_00b8
    IL_00ad: ldarg.0
    IL_00ae: ldfld Vector3 JumpBehaviour.<JumpAnimation>d__15::<targetPosition>5__2  /*0x04000607*/
    IL_00b3: call void UnityEngine.Events.UnityEvent<UnityEngine.Vector3>::Invoke(!0)  /*0x0A00020C*/
    IL_00b8: ldarg.0
    IL_00b9: ldc.r4 0f
    IL_00be: stfld float JumpBehaviour.<JumpAnimation>d__15::<t>5__4  /*0x04000609*/
    IL_00c3: br IL_0150
    IL_00c8: ldloc.1
    IL_00c9: ldfld float JumpBehaviour::jumpHeight  /*0x040005FC*/
    IL_00ce: ldarg.0
    IL_00cf: ldfld float JumpBehaviour.<JumpAnimation>d__15::<t>5__4  /*0x04000609*/
    IL_00d4: neg
    IL_00d5: ldarg.0
    IL_00d6: ldfld float JumpBehaviour.<JumpAnimation>d__15::<t>5__4  /*0x04000609*/
    IL_00db: mul
    IL_00dc: ldarg.0
    IL_00dd: ldfld float JumpBehaviour.<JumpAnimation>d__15::<t>5__4  /*0x04000609*/
    IL_00e2: add
    IL_00e3: mul
    IL_00e4: stloc.s 4
    IL_00e6: ldloc.1
    IL_00e7: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00ec: ldarg.0
    IL_00ed: ldfld Vector3 JumpBehaviour.<JumpAnimation>d__15::<startPos>5__3  /*0x04000608*/
    IL_00f2: ldarg.0
    IL_00f3: ldfld Vector3 JumpBehaviour.<JumpAnimation>d__15::<targetPosition>5__2  /*0x04000607*/
    IL_00f8: ldarg.0
    IL_00f9: ldfld float JumpBehaviour.<JumpAnimation>d__15::<t>5__4  /*0x04000609*/
    IL_00fe: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_0103: ldloc.1
    IL_0104: ldfld float JumpBehaviour::jumpHeight  /*0x040005FC*/
    IL_0109: ldloc.s 4
    IL_010b: mul
    IL_010c: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0111: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_0116: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_011b: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0120: ldarg.0
    IL_0121: ldnull
    IL_0122: stfld object JumpBehaviour.<JumpAnimation>d__15::<>2__current  /*0x04000605*/
    IL_0127: ldarg.0
    IL_0128: ldc.i4.1
    IL_0129: stfld int JumpBehaviour.<JumpAnimation>d__15::<>1__state  /*0x04000604*/
    IL_012e: ldc.i4.1
    IL_012f: ret
    IL_0130: ldarg.0
    IL_0131: ldc.i4.m1
    IL_0132: stfld int JumpBehaviour.<JumpAnimation>d__15::<>1__state  /*0x04000604*/
    IL_0137: ldarg.0
    IL_0138: ldarg.0
    IL_0139: ldfld float JumpBehaviour.<JumpAnimation>d__15::<t>5__4  /*0x04000609*/
    IL_013e: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0143: ldloc.1
    IL_0144: ldfld float JumpBehaviour::jumpDuration  /*0x040005FB*/
    IL_0149: div
    IL_014a: add
    IL_014b: stfld float JumpBehaviour.<JumpAnimation>d__15::<t>5__4  /*0x04000609*/
    IL_0150: ldarg.0
    IL_0151: ldfld float JumpBehaviour.<JumpAnimation>d__15::<t>5__4  /*0x04000609*/
    IL_0156: ldc.r4 1f
    IL_015b: blt IL_00c8
    IL_0160: ldloc.1
    IL_0161: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0166: ldarg.0
    IL_0167: ldfld Vector3 JumpBehaviour.<JumpAnimation>d__15::<targetPosition>5__2  /*0x04000607*/
    IL_016c: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0171: ldarg.0
    IL_0172: ldflda Vector3 JumpBehaviour.<JumpAnimation>d__15::<startPos>5__3  /*0x04000608*/
    IL_0177: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_017d: ldloc.1
    IL_017e: ldfld UnityEvent JumpBehaviour::EndJumpEvent  /*0x040005FF*/
    IL_0183: dup
    IL_0184: brtrue.s IL_0189
    IL_0186: pop
    IL_0187: br.s IL_018e
    IL_0189: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_018e: ldloc.1
    IL_018f: ldc.i4.0
    IL_0190: stfld bool JumpBehaviour::requestJump  /*0x04000601*/
    IL_0195: ldloc.1
    IL_0196: ldfld PathfindMovementEnemy JumpBehaviour::unitMovement  /*0x040005F9*/
    IL_019b: ldloc.1
    IL_019c: ldfld bool JumpBehaviour::needPathCheck  /*0x04000603*/
    IL_01a1: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_01a6: ldloc.1
    IL_01a7: ldfld Transform JumpBehaviour::aliveParent  /*0x040005FD*/
    IL_01ac: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_01b1: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_01b6: ldloc.1
    IL_01b7: ldfld Transform JumpBehaviour::aliveParent  /*0x040005FD*/
    IL_01bc: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_01c1: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_01c6: ldloc.1
    IL_01c7: ldc.i4.0
    IL_01c8: stfld bool JumpBehaviour::jumpAnimRunning  /*0x04000602*/
    IL_01cd: ldc.i4.0
    IL_01ce: ret

  .method JumpBehaviour.<JumpAnimation>d__15::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060004B2 rva 0x14b97 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object JumpBehaviour.<JumpAnimation>d__15::<>2__current  /*0x04000605*/
    IL_0006: ret

  .method JumpBehaviour.<JumpAnimation>d__15::System.Collections.IEnumerator.Reset()  // token 0x060004B3 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method JumpBehaviour.<JumpAnimation>d__15::System.Collections.IEnumerator.get_Current()  // token 0x060004B4 rva 0x14b97 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object JumpBehaviour.<JumpAnimation>d__15::<>2__current  /*0x04000605*/
    IL_0006: ret

