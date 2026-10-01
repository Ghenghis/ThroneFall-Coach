// ===== PriorityOverride  (token 0x0200005B) =====
  .method PriorityOverride::Start()  // token 0x06000206 rva 0x8806 attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.AudioSource>  /*0x2B000017*/
    IL_0007: stfld AudioSource PriorityOverride::target  /*0x04000270*/
    IL_000c: ldarg.0
    IL_000d: ldfld AudioSource PriorityOverride::target  /*0x04000270*/
    IL_0012: ldarg.0
    IL_0013: ldfld int PriorityOverride::prio  /*0x0400026F*/
    IL_0018: callvirt void UnityEngine.AudioSource::set_priority(int)  /*0x0A0000CB*/
    IL_001d: ret

  .method PriorityOverride::Update()  // token 0x06000207 rva 0x8825 attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AudioSource PriorityOverride::target  /*0x04000270*/
    IL_0006: ldarg.0
    IL_0007: ldfld int PriorityOverride::prio  /*0x0400026F*/
    IL_000c: callvirt void UnityEngine.AudioSource::set_priority(int)  /*0x0A0000CB*/
    IL_0011: ret

  .method PriorityOverride::.ctor()  // token 0x06000208 rva 0x8838 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld int PriorityOverride::prio  /*0x0400026F*/
    IL_0007: ldarg.0
    IL_0008: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_000d: ret

