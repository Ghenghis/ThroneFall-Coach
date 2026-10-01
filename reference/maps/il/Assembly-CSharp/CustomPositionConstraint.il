// ===== CustomPositionConstraint  (token 0x020000A7) =====
  .method CustomPositionConstraint::Update()  // token 0x06000398 rva 0x101c8 attrs Private, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Transform CustomPositionConstraint::followTransform  /*0x040004A5*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_0024
    IL_000e: ldarg.0
    IL_000f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0014: ldarg.0
    IL_0015: ldfld Transform CustomPositionConstraint::followTransform  /*0x040004A5*/
    IL_001a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_001f: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0024: ret

  .method CustomPositionConstraint::.ctor()  // token 0x06000399 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

