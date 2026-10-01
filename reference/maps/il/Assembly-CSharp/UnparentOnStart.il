// ===== UnparentOnStart  (token 0x02000395) =====
  .method UnparentOnStart::Start()  // token 0x060013AE rva 0x5d74b attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: ldnull
    IL_0007: callvirt void UnityEngine.Transform::set_parent(UnityEngine.Transform)  /*0x0A0000E2*/
    IL_000c: ret

  .method UnparentOnStart::.ctor()  // token 0x060013AF rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

