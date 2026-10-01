// ===== DayCountdownUI  (token 0x020002F2) =====
  .method DayCountdownUI::Start()  // token 0x06001046 rva 0x4a38c attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0006: stfld DayNightCycle DayCountdownUI::dayNightCycle  /*0x04001327*/
    IL_000b: ret

  .method DayCountdownUI::FormatTime(float)  // token 0x06001047 rva 0x4a39c attrs Private, HideBySig
    // code size 51 (0x33), max stack 3, init locals
    .locals ([0] int, [1] int)
    IL_0000: ldc.r4 0f
    IL_0005: ldarg.1
    IL_0006: call float UnityEngine.Mathf::Max(float,float)  /*0x0A00004B*/
    IL_000b: starg.s 1
    IL_000d: ldarg.1
    IL_000e: call int UnityEngine.Mathf::FloorToInt(float)  /*0x0A000144*/
    IL_0013: dup
    IL_0014: ldc.i4.s 60
    IL_0016: div
    IL_0017: stloc.0
    IL_0018: ldc.i4.s 60
    IL_001a: rem
    IL_001b: stloc.1
    IL_001c: ldstr "{0}:{1:D2}"
    IL_0021: ldloc.0
    IL_0022: box System.Int32  /*0x01000026*/
    IL_0027: ldloc.1
    IL_0028: box System.Int32  /*0x01000026*/
    IL_002d: call string System.String::Format(string,object,object)  /*0x0A0002B7*/
    IL_0032: ret

  .method DayCountdownUI::Update()  // token 0x06001048 rva 0x4a3dc attrs Private, HideBySig
    // code size 119 (0x77), max stack 3, init locals
    .locals ([0] bool, [1] float)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldc.r4 0f
    IL_0007: stloc.1
    IL_0008: ldarg.0
    IL_0009: ldfld DayNightCycle DayCountdownUI::dayNightCycle  /*0x04001327*/
    IL_000e: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0013: brtrue.s IL_002f
    IL_0015: ldarg.0
    IL_0016: ldfld DayNightCycle DayCountdownUI::dayNightCycle  /*0x04001327*/
    IL_001b: callvirt bool DayNightCycle::get_AutomatedDaytime()  /*0x060003A5*/
    IL_0020: stloc.0
    IL_0021: ldarg.0
    IL_0022: ldfld DayNightCycle DayCountdownUI::dayNightCycle  /*0x04001327*/
    IL_0027: callvirt float DayNightCycle::get_RemainingAutoDayTime()  /*0x060003A6*/
    IL_002c: stloc.1
    IL_002d: br.s IL_0047
    IL_002f: ldarg.0
    IL_0030: ldfld DayNightCycle DayCountdownUI::dayNightCycle  /*0x04001327*/
    IL_0035: callvirt bool DayNightCycle::get_AutomatedNighttime()  /*0x060003A7*/
    IL_003a: stloc.0
    IL_003b: ldarg.0
    IL_003c: ldfld DayNightCycle DayCountdownUI::dayNightCycle  /*0x04001327*/
    IL_0041: callvirt float DayNightCycle::get_RemainingAutoNightTime()  /*0x060003A8*/
    IL_0046: stloc.1
    IL_0047: ldloc.0
    IL_0048: ldarg.0
    IL_0049: ldfld GameObject DayCountdownUI::parentToToggle  /*0x04001325*/
    IL_004e: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_0053: beq.s IL_0061
    IL_0055: ldarg.0
    IL_0056: ldfld GameObject DayCountdownUI::parentToToggle  /*0x04001325*/
    IL_005b: ldloc.0
    IL_005c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0061: ldloc.0
    IL_0062: brfalse.s IL_0076
    IL_0064: ldarg.0
    IL_0065: ldfld TextMeshProUGUI DayCountdownUI::clockText  /*0x04001326*/
    IL_006a: ldarg.0
    IL_006b: ldloc.1
    IL_006c: call string DayCountdownUI::FormatTime(float)  /*0x06001047*/
    IL_0071: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0076: ret

  .method DayCountdownUI::.ctor()  // token 0x06001049 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

