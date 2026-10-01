// ===== BalancingParameters  (token 0x0200007C) =====
  .method BalancingParameters::.ctor()  // token 0x0600027E rva 0xb247 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void StringFloatSerializableDictionary::.ctor()  /*0x0600027F*/
    IL_0006: stfld StringFloatSerializableDictionary BalancingParameters::parameters  /*0x0400034D*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.ScriptableObject::.ctor()  /*0x0A00002B*/
    IL_0011: ret

