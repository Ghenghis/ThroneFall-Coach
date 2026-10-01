// ===== ProjectileSphereArea  (token 0x02000117) =====
  .method ProjectileSphereArea::get_R2()  // token 0x060005C9 rva 0x189ee attrs Private, HideBySig, SpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float ProjectileSphereArea::radius  /*0x04000733*/
    IL_0006: ldarg.0
    IL_0007: ldfld float ProjectileSphereArea::radius  /*0x04000733*/
    IL_000c: mul
    IL_000d: ret

  .method ProjectileSphereArea::Inside(UnityEngine.Transform)  // token 0x060005CA rva 0x18a00 attrs Public, HideBySig
    // code size 42 (0x2a), max stack 2, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld Transform ProjectileSphereArea::transform  /*0x04000732*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: ldarg.1
    IL_000c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0011: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0016: stloc.0
    IL_0017: ldloca.s 0
    IL_0019: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_001e: ldarg.0
    IL_001f: call float ProjectileSphereArea::get_R2()  /*0x060005C9*/
    IL_0024: cgt.un
    IL_0026: ldc.i4.0
    IL_0027: ceq
    IL_0029: ret

  .method ProjectileSphereArea::.ctor()  // token 0x060005CB rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

