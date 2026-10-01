// ===== FlyBehaviour  (token 0x020000D8) =====
  .method FlyBehaviour::RequestFly(UnityEngine.Vector3,bool)  // token 0x0600048C rva 0x144c1 attrs Public, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool FlyBehaviour::requestFly  /*0x040005E2*/
    IL_0007: ldarg.0
    IL_0008: ldarg.1
    IL_0009: stfld Vector3 FlyBehaviour::positionToFly  /*0x040005E1*/
    IL_000e: ldarg.0
    IL_000f: ldarg.2
    IL_0010: stfld bool FlyBehaviour::needPathCheck  /*0x040005E4*/
    IL_0015: ret

  .method FlyBehaviour::NoFlyWithEvent()  // token 0x0600048D rva 0x144d8 attrs Public, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent FlyBehaviour::EndFlyEvent  /*0x040005E0*/
    IL_0006: dup
    IL_0007: brtrue.s IL_000b
    IL_0009: pop
    IL_000a: ret
    IL_000b: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0010: ret

  .method FlyBehaviour::SnapFlyWithEvent(UnityEngine.Vector3)  // token 0x0600048E rva 0x144ec attrs Public, HideBySig
    // code size 42 (0x2a), max stack 2, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld PathfindMovementEnemy FlyBehaviour::unitMovement  /*0x040005DB*/
    IL_0006: ldarg.1
    IL_0007: callvirt Vector3 PathfindMovementEnemy::GetNearestGroundPosition(UnityEngine.Vector3)  /*0x06000B1B*/
    IL_000c: stloc.0
    IL_000d: ldarg.0
    IL_000e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0013: ldloc.0
    IL_0014: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0019: ldarg.0
    IL_001a: ldfld UnityEvent FlyBehaviour::EndFlyEvent  /*0x040005E0*/
    IL_001f: dup
    IL_0020: brtrue.s IL_0024
    IL_0022: pop
    IL_0023: ret
    IL_0024: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0029: ret

  .method FlyBehaviour::Update()  // token 0x0600048F rva 0x14522 attrs Private, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool FlyBehaviour::requestFly  /*0x040005E2*/
    IL_0006: brfalse.s IL_0010
    IL_0008: ldarg.0
    IL_0009: ldfld bool FlyBehaviour::flyAnimRunning  /*0x040005E3*/
    IL_000e: brfalse.s IL_0011
    IL_0010: ret
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: call IEnumerator FlyBehaviour::FlyAnimation()  /*0x06000490*/
    IL_0018: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_001d: pop
    IL_001e: ret

  .method FlyBehaviour::FlyAnimation()  // token 0x06000490 rva 0x14542 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void FlyBehaviour.<FlyAnimation>d__14::.ctor(int)  /*0x06000492*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld FlyBehaviour FlyBehaviour.<FlyAnimation>d__14::<>4__this  /*0x040005E7*/
    IL_000d: ret

  .method FlyBehaviour::.ctor()  // token 0x06000491 rva 0x14551 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.1f
    IL_0006: stfld float FlyBehaviour::snapRange  /*0x040005DC*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float FlyBehaviour::flyDuration  /*0x040005DD*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.1
    IL_0018: stfld bool FlyBehaviour::needPathCheck  /*0x040005E4*/
    IL_001d: ldarg.0
    IL_001e: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0023: ret

// ===== FlyBehaviour/<FlyAnimation>d__14  (token 0x020000D9) =====
  .method FlyBehaviour.<FlyAnimation>d__14::.ctor(int)  // token 0x06000492 rva 0x14576 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int FlyBehaviour.<FlyAnimation>d__14::<>1__state  /*0x040005E5*/
    IL_000d: ret

  .method FlyBehaviour.<FlyAnimation>d__14::System.IDisposable.Dispose()  // token 0x06000493 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method FlyBehaviour.<FlyAnimation>d__14::MoveNext()  // token 0x06000494 rva 0x14588 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 386 (0x182), max stack 4, init locals
    .locals ([0] int, [1] FlyBehaviour, [2] Vector3, [3] Vector3, [4] float)
    IL_0000: ldarg.0
    IL_0001: ldfld int FlyBehaviour.<FlyAnimation>d__14::<>1__state  /*0x040005E5*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld FlyBehaviour FlyBehaviour.<FlyAnimation>d__14::<>4__this  /*0x040005E7*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_0106
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int FlyBehaviour.<FlyAnimation>d__14::<>1__state  /*0x040005E5*/
    IL_0021: ldloc.1
    IL_0022: ldc.i4.1
    IL_0023: stfld bool FlyBehaviour::flyAnimRunning  /*0x040005E3*/
    IL_0028: ldloc.1
    IL_0029: ldfld PathfindMovementEnemy FlyBehaviour::unitMovement  /*0x040005DB*/
    IL_002e: ldc.i4.0
    IL_002f: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0034: ldarg.0
    IL_0035: ldloc.1
    IL_0036: ldfld Vector3 FlyBehaviour::positionToFly  /*0x040005E1*/
    IL_003b: stfld Vector3 FlyBehaviour.<FlyAnimation>d__14::<targetPosition>5__2  /*0x040005E8*/
    IL_0040: ldloc.1
    IL_0041: ldfld PathfindMovementEnemy FlyBehaviour::unitMovement  /*0x040005DB*/
    IL_0046: ldarg.0
    IL_0047: ldfld Vector3 FlyBehaviour.<FlyAnimation>d__14::<targetPosition>5__2  /*0x040005E8*/
    IL_004c: callvirt Vector3 PathfindMovementEnemy::GetNearestGroundPosition(UnityEngine.Vector3)  /*0x06000B1B*/
    IL_0051: stloc.2
    IL_0052: ldloc.1
    IL_0053: ldfld bool FlyBehaviour::needPathCheck  /*0x040005E4*/
    IL_0058: brfalse.s IL_0079
    IL_005a: ldloc.2
    IL_005b: ldarg.0
    IL_005c: ldfld Vector3 FlyBehaviour.<FlyAnimation>d__14::<targetPosition>5__2  /*0x040005E8*/
    IL_0061: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0066: stloc.3
    IL_0067: ldloca.s 3
    IL_0069: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_006e: ldloc.1
    IL_006f: ldfld float FlyBehaviour::snapRange  /*0x040005DC*/
    IL_0074: bge.un IL_0150
    IL_0079: ldarg.0
    IL_007a: ldloc.1
    IL_007b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0080: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0085: stfld Vector3 FlyBehaviour.<FlyAnimation>d__14::<startPos>5__3  /*0x040005E9*/
    IL_008a: ldarg.0
    IL_008b: ldloc.1
    IL_008c: ldfld bool FlyBehaviour::needPathCheck  /*0x040005E4*/
    IL_0091: brtrue.s IL_009b
    IL_0093: ldarg.0
    IL_0094: ldfld Vector3 FlyBehaviour.<FlyAnimation>d__14::<targetPosition>5__2  /*0x040005E8*/
    IL_0099: br.s IL_009c
    IL_009b: ldloc.2
    IL_009c: stfld Vector3 FlyBehaviour.<FlyAnimation>d__14::<targetPosition>5__2  /*0x040005E8*/
    IL_00a1: ldloc.1
    IL_00a2: ldfld UnityEvent<Vector3> FlyBehaviour::StartFlyEvent  /*0x040005DF*/
    IL_00a7: dup
    IL_00a8: brtrue.s IL_00ad
    IL_00aa: pop
    IL_00ab: br.s IL_00b8
    IL_00ad: ldarg.0
    IL_00ae: ldfld Vector3 FlyBehaviour.<FlyAnimation>d__14::<targetPosition>5__2  /*0x040005E8*/
    IL_00b3: call void UnityEngine.Events.UnityEvent<UnityEngine.Vector3>::Invoke(!0)  /*0x0A00020C*/
    IL_00b8: ldarg.0
    IL_00b9: ldc.r4 0f
    IL_00be: stfld float FlyBehaviour.<FlyAnimation>d__14::<t>5__4  /*0x040005EA*/
    IL_00c3: br.s IL_0126
    IL_00c5: ldloc.1
    IL_00c6: ldfld AnimationCurve FlyBehaviour::flyCurve  /*0x040005DE*/
    IL_00cb: ldarg.0
    IL_00cc: ldfld float FlyBehaviour.<FlyAnimation>d__14::<t>5__4  /*0x040005EA*/
    IL_00d1: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_00d6: stloc.s 4
    IL_00d8: ldloc.1
    IL_00d9: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00de: ldarg.0
    IL_00df: ldfld Vector3 FlyBehaviour.<FlyAnimation>d__14::<startPos>5__3  /*0x040005E9*/
    IL_00e4: ldarg.0
    IL_00e5: ldfld Vector3 FlyBehaviour.<FlyAnimation>d__14::<targetPosition>5__2  /*0x040005E8*/
    IL_00ea: ldloc.s 4
    IL_00ec: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_00f1: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_00f6: ldarg.0
    IL_00f7: ldnull
    IL_00f8: stfld object FlyBehaviour.<FlyAnimation>d__14::<>2__current  /*0x040005E6*/
    IL_00fd: ldarg.0
    IL_00fe: ldc.i4.1
    IL_00ff: stfld int FlyBehaviour.<FlyAnimation>d__14::<>1__state  /*0x040005E5*/
    IL_0104: ldc.i4.1
    IL_0105: ret
    IL_0106: ldarg.0
    IL_0107: ldc.i4.m1
    IL_0108: stfld int FlyBehaviour.<FlyAnimation>d__14::<>1__state  /*0x040005E5*/
    IL_010d: ldarg.0
    IL_010e: ldarg.0
    IL_010f: ldfld float FlyBehaviour.<FlyAnimation>d__14::<t>5__4  /*0x040005EA*/
    IL_0114: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0119: ldloc.1
    IL_011a: ldfld float FlyBehaviour::flyDuration  /*0x040005DD*/
    IL_011f: div
    IL_0120: add
    IL_0121: stfld float FlyBehaviour.<FlyAnimation>d__14::<t>5__4  /*0x040005EA*/
    IL_0126: ldarg.0
    IL_0127: ldfld float FlyBehaviour.<FlyAnimation>d__14::<t>5__4  /*0x040005EA*/
    IL_012c: ldc.r4 1f
    IL_0131: blt.s IL_00c5
    IL_0133: ldloc.1
    IL_0134: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0139: ldarg.0
    IL_013a: ldfld Vector3 FlyBehaviour.<FlyAnimation>d__14::<targetPosition>5__2  /*0x040005E8*/
    IL_013f: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0144: ldarg.0
    IL_0145: ldflda Vector3 FlyBehaviour.<FlyAnimation>d__14::<startPos>5__3  /*0x040005E9*/
    IL_014a: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_0150: ldloc.1
    IL_0151: ldfld UnityEvent FlyBehaviour::EndFlyEvent  /*0x040005E0*/
    IL_0156: dup
    IL_0157: brtrue.s IL_015c
    IL_0159: pop
    IL_015a: br.s IL_0161
    IL_015c: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0161: ldloc.1
    IL_0162: ldc.i4.0
    IL_0163: stfld bool FlyBehaviour::requestFly  /*0x040005E2*/
    IL_0168: ldloc.1
    IL_0169: ldc.i4.0
    IL_016a: stfld bool FlyBehaviour::flyAnimRunning  /*0x040005E3*/
    IL_016f: ldloc.1
    IL_0170: ldfld PathfindMovementEnemy FlyBehaviour::unitMovement  /*0x040005DB*/
    IL_0175: ldloc.1
    IL_0176: ldfld bool FlyBehaviour::needPathCheck  /*0x040005E4*/
    IL_017b: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0180: ldc.i4.0
    IL_0181: ret

  .method FlyBehaviour.<FlyAnimation>d__14::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000495 rva 0x14716 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object FlyBehaviour.<FlyAnimation>d__14::<>2__current  /*0x040005E6*/
    IL_0006: ret

  .method FlyBehaviour.<FlyAnimation>d__14::System.Collections.IEnumerator.Reset()  // token 0x06000496 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method FlyBehaviour.<FlyAnimation>d__14::System.Collections.IEnumerator.get_Current()  // token 0x06000497 rva 0x14716 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object FlyBehaviour.<FlyAnimation>d__14::<>2__current  /*0x040005E6*/
    IL_0006: ret

