// ===== SimpleMove  (token 0x02000291) =====
  .method SimpleMove::Update()  // token 0x06000E29 rva 0x3f4b0 attrs Private, HideBySig
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: dup
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000c: ldarg.0
    IL_000d: ldfld Vector3 SimpleMove::movementSpeed  /*0x04001070*/
    IL_0012: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0017: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_001c: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0021: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0026: ret

  .method SimpleMove::.ctor()  // token 0x06000E2A rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

