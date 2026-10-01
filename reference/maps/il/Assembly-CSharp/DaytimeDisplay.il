// ===== DaytimeDisplay  (token 0x020000AF) =====
  .method DaytimeDisplay::Update()  // token 0x060003C8 rva 0x10c24 attrs Private, HideBySig
    // code size 48 (0x30), max stack 2, init locals
    .locals ([0] DayNightCycle.Timestate)
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_002f
    IL_000c: ldarg.0
    IL_000d: ldfld TextMeshProUGUI DaytimeDisplay::display  /*0x040004CB*/
    IL_0012: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0017: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_001c: stloc.0
    IL_001d: ldloca.s 0
    IL_001f: constrained. DayNightCycle.Timestate  /*0x020000AC*/
    IL_0025: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_002a: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_002f: ret

  .method DaytimeDisplay::.ctor()  // token 0x060003C9 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

