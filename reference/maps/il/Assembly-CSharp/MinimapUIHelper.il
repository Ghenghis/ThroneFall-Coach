// ===== MinimapUIHelper  (token 0x02000322) =====
  .method MinimapUIHelper::Update()  // token 0x0600114B rva 0x51760 attrs Private, HideBySig
    // code size 145 (0x91), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld DayNightCycle MinimapUIHelper::dnc  /*0x040014A4*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_0019
    IL_000e: ldarg.0
    IL_000f: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0014: stfld DayNightCycle MinimapUIHelper::dnc  /*0x040014A4*/
    IL_0019: ldarg.0
    IL_001a: ldfld LocalGamestate MinimapUIHelper::lgs  /*0x040014A5*/
    IL_001f: ldnull
    IL_0020: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0025: brfalse.s IL_0032
    IL_0027: ldarg.0
    IL_0028: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_002d: stfld LocalGamestate MinimapUIHelper::lgs  /*0x040014A5*/
    IL_0032: ldarg.0
    IL_0033: ldfld DayNightCycle MinimapUIHelper::dnc  /*0x040014A4*/
    IL_0038: ldnull
    IL_0039: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_003e: brtrue.s IL_004e
    IL_0040: ldarg.0
    IL_0041: ldfld LocalGamestate MinimapUIHelper::lgs  /*0x040014A5*/
    IL_0046: ldnull
    IL_0047: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_004c: brfalse.s IL_005b
    IL_004e: ldarg.0
    IL_004f: ldfld GameObject MinimapUIHelper::toggleParent  /*0x040014A3*/
    IL_0054: ldc.i4.0
    IL_0055: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_005a: ret
    IL_005b: ldarg.0
    IL_005c: ldfld DayNightCycle MinimapUIHelper::dnc  /*0x040014A4*/
    IL_0061: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0066: ldc.i4.1
    IL_0067: bne.un.s IL_0084
    IL_0069: ldarg.0
    IL_006a: ldfld LocalGamestate MinimapUIHelper::lgs  /*0x040014A5*/
    IL_006f: callvirt LocalGamestate.State LocalGamestate::get_CurrentState()  /*0x060008FD*/
    IL_0074: ldc.i4.1
    IL_0075: bne.un.s IL_0084
    IL_0077: ldarg.0
    IL_0078: ldfld GameObject MinimapUIHelper::toggleParent  /*0x040014A3*/
    IL_007d: ldc.i4.1
    IL_007e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0083: ret
    IL_0084: ldarg.0
    IL_0085: ldfld GameObject MinimapUIHelper::toggleParent  /*0x040014A3*/
    IL_008a: ldc.i4.0
    IL_008b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0090: ret

  .method MinimapUIHelper::.ctor()  // token 0x0600114C rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

