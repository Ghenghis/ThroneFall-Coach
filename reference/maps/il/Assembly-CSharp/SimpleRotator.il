// ===== SimpleRotator  (token 0x02000040) =====
  .method SimpleRotator::OnEnable()  // token 0x06000139 rva 0x6f9c attrs Private, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SimpleRotator::randomYRotationOnEnable  /*0x0400018E*/
    IL_0006: brfalse.s IL_002d
    IL_0008: ldarg.0
    IL_0009: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000e: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0013: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0018: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_001d: ldc.r4 360f
    IL_0022: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0027: ldc.i4.0
    IL_0028: callvirt void UnityEngine.Transform::Rotate(UnityEngine.Vector3,UnityEngine.Space)  /*0x0A0000B7*/
    IL_002d: ret

  .method SimpleRotator::Update()  // token 0x0600013A rva 0x6fcb attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: ldarg.0
    IL_0007: ldfld Vector3 SimpleRotator::rotationDelta  /*0x0400018C*/
    IL_000c: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0011: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0016: ldarg.0
    IL_0017: ldfld Space SimpleRotator::relativeTo  /*0x0400018D*/
    IL_001c: callvirt void UnityEngine.Transform::Rotate(UnityEngine.Vector3,UnityEngine.Space)  /*0x0A0000B7*/
    IL_0021: ret

  .method SimpleRotator::.ctor()  // token 0x0600013B rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

