// ===== KB.FogRTS.Runtime.SingletonContainer`1  (token 0x02000006) =====
  .method KB.FogRTS.Runtime.SingletonContainer::GetInstance()  // token 0x06000019 rva 0x254e attrs Assembly, Static, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldsfld !0 KB.FogRTS.Runtime.SingletonContainer<!0>::instance  /*0x0A000039*/
    IL_0005: box !0  /*0x1B00000D*/
    IL_000a: ldnull
    IL_000b: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A00003A*/
    IL_0010: brfalse.s IL_001c
    IL_0012: call !!0 UnityEngine.ScriptableObject::CreateInstance()<!0>  /*0x2B000003*/
    IL_0017: stsfld !0 KB.FogRTS.Runtime.SingletonContainer<!0>::instance  /*0x0A000039*/
    IL_001c: ldsfld !0 KB.FogRTS.Runtime.SingletonContainer<!0>::instance  /*0x0A000039*/
    IL_0021: ret

  .method KB.FogRTS.Runtime.SingletonContainer::.ctor()  // token 0x0600001A rva 0x2571 attrs Family, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.ScriptableObject::.ctor()  /*0x0A00003C*/
    IL_0006: ret

