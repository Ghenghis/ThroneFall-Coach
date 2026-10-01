// ===== TentacleAnimationOffset  (token 0x02000045) =====
  .method TentacleAnimationOffset::Start()  // token 0x0600014C rva 0x7394 attrs Private, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.Animator>  /*0x2B000013*/
    IL_0006: ldstr "Offset"
    IL_000b: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0010: callvirt void UnityEngine.Animator::SetFloat(string,float)  /*0x0A0000BA*/
    IL_0015: ret

  .method TentacleAnimationOffset::.ctor()  // token 0x0600014D rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

