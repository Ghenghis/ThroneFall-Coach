// ===== KB.FogRTS.Runtime.TransformHelper  (token 0x02000012) =====
  .method KB.FogRTS.Runtime.TransformHelper::get_DummyTransform()  // token 0x06000066 rva 0x3b72 attrs Public, Static, HideBySig, SpecialName
    // code size 47 (0x2f), max stack 8
    IL_0000: ldsfld Transform KB.FogRTS.Runtime.TransformHelper::temp  /*0x04000066*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A00003A*/
    IL_000b: brfalse.s IL_0029
    IL_000d: ldstr "DummyTransform"
    IL_0012: newobj void UnityEngine.GameObject::.ctor(string)  /*0x0A0000BE*/
    IL_0017: dup
    IL_0018: ldc.i4.s 61
    IL_001a: callvirt void UnityEngine.Object::set_hideFlags(UnityEngine.HideFlags)  /*0x0A0000BF*/
    IL_001f: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A0000C0*/
    IL_0024: stsfld Transform KB.FogRTS.Runtime.TransformHelper::temp  /*0x04000066*/
    IL_0029: ldsfld Transform KB.FogRTS.Runtime.TransformHelper::temp  /*0x04000066*/
    IL_002e: ret

