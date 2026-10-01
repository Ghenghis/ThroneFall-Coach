// ===== SimpleWalk  (token 0x02000041) =====
  .method SimpleWalk::Start()  // token 0x0600013C rva 0x6fee attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Transform SimpleWalk::animationRoot  /*0x04000190*/
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_000c: stfld Vector3 SimpleWalk::initialRootPos  /*0x04000199*/
    IL_0011: ldarg.0
    IL_0012: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0017: stfld float SimpleWalk::bounceClock  /*0x04000194*/
    IL_001c: ret

  .method SimpleWalk::Update()  // token 0x0600013D rva 0x700c attrs Private, HideBySig
    // code size 279 (0x117), max stack 5, init locals
    .locals ([0] Vector3, [1] Vector3)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: stloc.0
    IL_000c: ldloc.0
    IL_000d: ldarg.0
    IL_000e: ldfld Vector3 SimpleWalk::lastPosition  /*0x0400019B*/
    IL_0013: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0018: stloc.1
    IL_0019: ldarg.0
    IL_001a: ldloc.0
    IL_001b: stfld Vector3 SimpleWalk::lastPosition  /*0x0400019B*/
    IL_0020: ldloca.s 1
    IL_0022: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_0027: call float TimeUtils::get_InverseDeltaTimeSqr()  /*0x060013C4*/
    IL_002c: mul
    IL_002d: ldarg.0
    IL_002e: ldfld float SimpleWalk::velocitySqrtDeadzone  /*0x04000196*/
    IL_0033: ble.un IL_00eb
    IL_0038: ldarg.0
    IL_0039: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_003e: ldarg.0
    IL_003f: ldfld float SimpleWalk::bounceSpeed  /*0x04000193*/
    IL_0044: mul
    IL_0045: stfld float SimpleWalk::clockDelta  /*0x04000195*/
    IL_004a: ldarg.0
    IL_004b: ldarg.0
    IL_004c: ldfld float SimpleWalk::bounceClock  /*0x04000194*/
    IL_0051: ldarg.0
    IL_0052: ldfld float SimpleWalk::clockDelta  /*0x04000195*/
    IL_0057: add
    IL_0058: stfld float SimpleWalk::bounceClock  /*0x04000194*/
    IL_005d: ldarg.0
    IL_005e: ldfld Transform SimpleWalk::animationRoot  /*0x04000190*/
    IL_0063: ldarg.0
    IL_0064: ldfld Vector3 SimpleWalk::initialRootPos  /*0x04000199*/
    IL_0069: ldarg.0
    IL_006a: ldfld Vector3 SimpleWalk::initialRootPos  /*0x04000199*/
    IL_006f: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0074: ldarg.0
    IL_0075: ldfld float SimpleWalk::bounceHeight  /*0x04000191*/
    IL_007a: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_007f: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0084: ldarg.0
    IL_0085: ldfld AnimationCurve SimpleWalk::bounceCurve  /*0x04000192*/
    IL_008a: ldarg.0
    IL_008b: ldfld float SimpleWalk::bounceClock  /*0x04000194*/
    IL_0090: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0095: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_009a: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_009f: ldarg.0
    IL_00a0: ldfld float SimpleWalk::bounceClock  /*0x04000194*/
    IL_00a5: ldc.r4 1f
    IL_00aa: rem
    IL_00ab: ldarg.0
    IL_00ac: ldfld float SimpleWalk::clockDelta  /*0x04000195*/
    IL_00b1: bgt.un.s IL_00e3
    IL_00b3: ldarg.0
    IL_00b4: ldfld float SimpleWalk::bounceClock  /*0x04000194*/
    IL_00b9: ldarg.0
    IL_00ba: ldfld float SimpleWalk::lastGroundContactTimeStamp  /*0x04000198*/
    IL_00bf: sub
    IL_00c0: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_00c5: ldc.r4 0.5f
    IL_00ca: ble.un.s IL_00e3
    IL_00cc: ldarg.0
    IL_00cd: ldarg.0
    IL_00ce: ldfld float SimpleWalk::bounceClock  /*0x04000194*/
    IL_00d3: stfld float SimpleWalk::lastGroundContactTimeStamp  /*0x04000198*/
    IL_00d8: ldarg.0
    IL_00d9: ldfld UnityEvent SimpleWalk::onGroundContact  /*0x04000197*/
    IL_00de: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_00e3: ldarg.0
    IL_00e4: ldc.i4.1
    IL_00e5: stfld bool SimpleWalk::needsReset  /*0x0400019A*/
    IL_00ea: ret
    IL_00eb: ldarg.0
    IL_00ec: ldfld bool SimpleWalk::needsReset  /*0x0400019A*/
    IL_00f1: brfalse.s IL_0116
    IL_00f3: ldarg.0
    IL_00f4: ldfld Transform SimpleWalk::animationRoot  /*0x04000190*/
    IL_00f9: ldarg.0
    IL_00fa: ldfld Vector3 SimpleWalk::initialRootPos  /*0x04000199*/
    IL_00ff: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_0104: ldarg.0
    IL_0105: ldc.r4 0f
    IL_010a: stfld float SimpleWalk::bounceClock  /*0x04000194*/
    IL_010f: ldarg.0
    IL_0110: ldc.i4.0
    IL_0111: stfld bool SimpleWalk::needsReset  /*0x0400019A*/
    IL_0116: ret

  .method SimpleWalk::.ctor()  // token 0x0600013E rva 0x712f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 58 (0x3a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.5f
    IL_0006: stfld float SimpleWalk::bounceHeight  /*0x04000191*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float SimpleWalk::bounceSpeed  /*0x04000193*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.15f
    IL_001c: stfld float SimpleWalk::velocitySqrtDeadzone  /*0x04000196*/
    IL_0021: ldarg.0
    IL_0022: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0027: stfld UnityEvent SimpleWalk::onGroundContact  /*0x04000197*/
    IL_002c: ldarg.0
    IL_002d: ldc.i4.1
    IL_002e: stfld bool SimpleWalk::needsReset  /*0x0400019A*/
    IL_0033: ldarg.0
    IL_0034: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0039: ret

