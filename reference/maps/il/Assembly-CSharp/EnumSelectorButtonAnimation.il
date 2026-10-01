// ===== EnumSelectorButtonAnimation  (token 0x02000305) =====
  .method EnumSelectorButtonAnimation::OnEnable()  // token 0x060010BB rva 0x4cd16 attrs Private, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Transform EnumSelectorButtonAnimation::decreaseB  /*0x040013D9*/
    IL_0006: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_000b: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0010: ldarg.0
    IL_0011: ldfld Transform EnumSelectorButtonAnimation::increaseB  /*0x040013DA*/
    IL_0016: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_001b: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0020: ret

  .method EnumSelectorButtonAnimation::.ctor()  // token 0x060010BC rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

