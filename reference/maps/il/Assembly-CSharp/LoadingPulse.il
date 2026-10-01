// ===== LoadingPulse  (token 0x02000172) =====
  .method LoadingPulse::Start()  // token 0x0600077D rva 0x254c2 attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<TMPro.TextMeshProUGUI>  /*0x2B000086*/
    IL_0007: stfld TextMeshProUGUI LoadingPulse::loadingText  /*0x04000964*/
    IL_000c: ret

  .method LoadingPulse::Update()  // token 0x0600077E rva 0x254d0 attrs Private, HideBySig
    // code size 66 (0x42), max stack 3, init locals
    .locals ([0] Color)
    IL_0000: ldarg.0
    IL_0001: ldfld TextMeshProUGUI LoadingPulse::loadingText  /*0x04000964*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0041
    IL_000d: ldarg.0
    IL_000e: ldfld TextMeshProUGUI LoadingPulse::loadingText  /*0x04000964*/
    IL_0013: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0018: stloc.0
    IL_0019: ldloca.s 0
    IL_001b: call float UnityEngine.Time::get_time()  /*0x0A00010A*/
    IL_0020: ldc.r4 2f
    IL_0025: call float UnityEngine.Mathf::PingPong(float,float)  /*0x0A000366*/
    IL_002a: ldc.r4 2f
    IL_002f: div
    IL_0030: stfld float UnityEngine.Color::a  /*0x0A000187*/
    IL_0035: ldarg.0
    IL_0036: ldfld TextMeshProUGUI LoadingPulse::loadingText  /*0x04000964*/
    IL_003b: ldloc.0
    IL_003c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0041: ret

  .method LoadingPulse::.ctor()  // token 0x0600077F rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

