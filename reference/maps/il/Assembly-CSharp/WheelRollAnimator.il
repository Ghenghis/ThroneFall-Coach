// ===== WheelRollAnimator  (token 0x0200004B) =====
  .method WheelRollAnimator::Update()  // token 0x06000168 rva 0x771c attrs Private, HideBySig
    // code size 140 (0x8c), max stack 5, init locals
    .locals ([0] Vector3, [1] Vector3, [2] float, [3] Transform[], [4] int)
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_000b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0010: stloc.0
    IL_0011: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0016: ldc.r4 0f
    IL_001b: bne.un.s IL_001e
    IL_001d: ret
    IL_001e: ldloc.0
    IL_001f: ldarg.0
    IL_0020: ldfld Vector3 WheelRollAnimator::lastPosition  /*0x040001C5*/
    IL_0025: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_002a: call float TimeUtils::get_CurrentSmoothedFps()  /*0x060013BE*/
    IL_002f: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0034: stloc.1
    IL_0035: ldloca.s 1
    IL_0037: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_003c: stloc.2
    IL_003d: ldarg.0
    IL_003e: ldloc.0
    IL_003f: stfld Vector3 WheelRollAnimator::lastPosition  /*0x040001C5*/
    IL_0044: ldarg.0
    IL_0045: ldloc.2
    IL_0046: ldarg.0
    IL_0047: ldfld float WheelRollAnimator::speedMultiplier  /*0x040001C2*/
    IL_004c: mul
    IL_004d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0052: mul
    IL_0053: stfld float WheelRollAnimator::currentRotationSpeed  /*0x040001C4*/
    IL_0058: ldarg.0
    IL_0059: ldfld Transform[] WheelRollAnimator::targetTransforms  /*0x040001C3*/
    IL_005e: stloc.3
    IL_005f: ldc.i4.0
    IL_0060: stloc.s 4
    IL_0062: br.s IL_0084
    IL_0064: ldloc.3
    IL_0065: ldloc.s 4
    IL_0067: ldelem.ref
    IL_0068: ldarg.0
    IL_0069: ldfld float WheelRollAnimator::currentRotationSpeed  /*0x040001C4*/
    IL_006e: ldc.r4 0f
    IL_0073: ldc.r4 0f
    IL_0078: ldc.i4.1
    IL_0079: callvirt void UnityEngine.Transform::Rotate(float,float,float,UnityEngine.Space)  /*0x0A0000B1*/
    IL_007e: ldloc.s 4
    IL_0080: ldc.i4.1
    IL_0081: add
    IL_0082: stloc.s 4
    IL_0084: ldloc.s 4
    IL_0086: ldloc.3
    IL_0087: ldlen
    IL_0088: conv.i4
    IL_0089: blt.s IL_0064
    IL_008b: ret

  .method WheelRollAnimator::.ctor()  // token 0x06000169 rva 0x77b4 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 4f
    IL_0006: stfld float WheelRollAnimator::speedMultiplier  /*0x040001C2*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

