// ===== FakeTransorm  (token 0x020002AC) =====
  .method FakeTransorm::.ctor(UnityEngine.Transform)  // token 0x06000EB8 rva 0x4241d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: call void FakeTransorm::SetToTransormValues(UnityEngine.Transform)  /*0x06000EB9*/
    IL_000d: ret

  .method FakeTransorm::SetToTransormValues(UnityEngine.Transform)  // token 0x06000EB9 rva 0x4242c attrs Public, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_0007: stfld Vector3 FakeTransorm::localPosition  /*0x04001108*/
    IL_000c: ldarg.0
    IL_000d: ldarg.1
    IL_000e: callvirt Vector3 UnityEngine.Transform::get_localScale()  /*0x0A00007A*/
    IL_0013: stfld Vector3 FakeTransorm::localScale  /*0x04001109*/
    IL_0018: ldarg.0
    IL_0019: ldarg.1
    IL_001a: callvirt Quaternion UnityEngine.Transform::get_localRotation()  /*0x0A00008D*/
    IL_001f: stfld Quaternion FakeTransorm::localRotation  /*0x0400110A*/
    IL_0024: ret

  .method FakeTransorm::IsEqualTo(UnityEngine.Transform)  // token 0x06000EBA rva 0x42454 attrs Public, HideBySig
    // code size 65 (0x41), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Vector3 FakeTransorm::localPosition  /*0x04001108*/
    IL_0006: ldarg.1
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_000c: call bool UnityEngine.Vector3::op_Inequality(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A00006F*/
    IL_0011: brfalse.s IL_0015
    IL_0013: ldc.i4.0
    IL_0014: ret
    IL_0015: ldarg.0
    IL_0016: ldfld Vector3 FakeTransorm::localScale  /*0x04001109*/
    IL_001b: ldarg.1
    IL_001c: callvirt Vector3 UnityEngine.Transform::get_localScale()  /*0x0A00007A*/
    IL_0021: call bool UnityEngine.Vector3::op_Inequality(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A00006F*/
    IL_0026: brfalse.s IL_002a
    IL_0028: ldc.i4.0
    IL_0029: ret
    IL_002a: ldarg.0
    IL_002b: ldfld Quaternion FakeTransorm::localRotation  /*0x0400110A*/
    IL_0030: ldarg.1
    IL_0031: callvirt Quaternion UnityEngine.Transform::get_localRotation()  /*0x0A00008D*/
    IL_0036: call bool UnityEngine.Quaternion::op_Inequality(UnityEngine.Quaternion,UnityEngine.Quaternion)  /*0x0A000511*/
    IL_003b: brfalse.s IL_003f
    IL_003d: ldc.i4.0
    IL_003e: ret
    IL_003f: ldc.i4.1
    IL_0040: ret

