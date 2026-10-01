// ===== RacerRoll  (token 0x02000036) =====
  .method RacerRoll::Update()  // token 0x06000113 rva 0x6474 attrs Private, HideBySig
    // code size 105 (0x69), max stack 5, init locals
    .locals ([0] Vector3, [1] Vector3, [2] float)
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
    IL_0020: ldfld Vector3 RacerRoll::lastPosition  /*0x04000145*/
    IL_0025: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_002a: call float TimeUtils::get_InverseDeltaTime()  /*0x060013C2*/
    IL_002f: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0034: stloc.1
    IL_0035: ldloca.s 1
    IL_0037: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_003c: stloc.2
    IL_003d: ldarg.0
    IL_003e: ldloc.0
    IL_003f: stfld Vector3 RacerRoll::lastPosition  /*0x04000145*/
    IL_0044: ldarg.0
    IL_0045: ldfld Transform RacerRoll::targetTransform  /*0x04000144*/
    IL_004a: ldloc.2
    IL_004b: ldarg.0
    IL_004c: ldfld float RacerRoll::speedMultiplier  /*0x04000143*/
    IL_0051: mul
    IL_0052: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0057: mul
    IL_0058: ldc.r4 0f
    IL_005d: ldc.r4 0f
    IL_0062: ldc.i4.1
    IL_0063: callvirt void UnityEngine.Transform::Rotate(float,float,float,UnityEngine.Space)  /*0x0A0000B1*/
    IL_0068: ret

  .method RacerRoll::.ctor()  // token 0x06000114 rva 0x64e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 4f
    IL_0006: stfld float RacerRoll::speedMultiplier  /*0x04000143*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

