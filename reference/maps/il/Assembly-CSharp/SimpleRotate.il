// ===== SimpleRotate  (token 0x0200003F) =====
  .method SimpleRotate::Update()  // token 0x06000137 rva 0x6f6f attrs Private, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: dup
    IL_0007: callvirt Quaternion UnityEngine.Transform::get_localRotation()  /*0x0A00008D*/
    IL_000c: ldarg.0
    IL_000d: ldfld Vector3 SimpleRotate::angle  /*0x0400018B*/
    IL_0012: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0017: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_001c: call Quaternion UnityEngine.Quaternion::Euler(UnityEngine.Vector3)  /*0x0A0000B6*/
    IL_0021: call Quaternion UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Quaternion)  /*0x0A00007F*/
    IL_0026: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_002b: ret

  .method SimpleRotate::.ctor()  // token 0x06000138 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

