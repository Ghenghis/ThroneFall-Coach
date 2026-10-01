// ===== ControlGroupPopUp  (token 0x020000A4) =====
  .method ControlGroupPopUp::Start()  // token 0x0600038F rva 0x10042 attrs Private, HideBySig
    // code size 57 (0x39), max stack 8
    IL_0000: ldarg.0
    IL_0001: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_000c: stfld Player ControlGroupPopUp::input  /*0x0400049A*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: ldfld Player ControlGroupPopUp::input  /*0x0400049A*/
    IL_0018: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_001d: callvirt Controller Rewired.Player.ControllerHelper::GetLastActiveController()  /*0x0A000005*/
    IL_0022: callvirt ControllerType Rewired.Controller::get_type()  /*0x0A000006*/
    IL_0027: stfld ControllerType ControlGroupPopUp::lastControllerType  /*0x0400049B*/
    IL_002c: ldarg.0
    IL_002d: ldarg.0
    IL_002e: ldfld ControllerType ControlGroupPopUp::lastControllerType  /*0x0400049B*/
    IL_0033: call void ControlGroupPopUp::Refresh(Rewired.ControllerType)  /*0x06000391*/
    IL_0038: ret

  .method ControlGroupPopUp::Update()  // token 0x06000390 rva 0x1007c attrs Private, HideBySig
    // code size 39 (0x27), max stack 2, init locals
    .locals ([0] ControllerType)
    IL_0000: ldarg.0
    IL_0001: ldfld Player ControlGroupPopUp::input  /*0x0400049A*/
    IL_0006: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_000b: callvirt Controller Rewired.Player.ControllerHelper::GetLastActiveController()  /*0x0A000005*/
    IL_0010: callvirt ControllerType Rewired.Controller::get_type()  /*0x0A000006*/
    IL_0015: stloc.0
    IL_0016: ldarg.0
    IL_0017: ldfld ControllerType ControlGroupPopUp::lastControllerType  /*0x0400049B*/
    IL_001c: ldloc.0
    IL_001d: beq.s IL_0026
    IL_001f: ldarg.0
    IL_0020: ldloc.0
    IL_0021: call void ControlGroupPopUp::Refresh(Rewired.ControllerType)  /*0x06000391*/
    IL_0026: ret

  .method ControlGroupPopUp::Refresh(Rewired.ControllerType)  // token 0x06000391 rva 0x100b0 attrs Private, HideBySig
    // code size 65 (0x41), max stack 6, init locals
    .locals ([0] bool)
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_0009
    IL_0003: ldarg.1
    IL_0004: ldc.i4.1
    IL_0005: ceq
    IL_0007: br.s IL_000a
    IL_0009: ldc.i4.1
    IL_000a: stloc.0
    IL_000b: ldarg.0
    IL_000c: ldfld Image ControlGroupPopUp::KeyboardExampleImg  /*0x04000496*/
    IL_0011: ldloc.0
    IL_0012: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0017: ldarg.0
    IL_0018: ldfld Image ControlGroupPopUp::ControllerExampleImg  /*0x04000497*/
    IL_001d: ldloc.0
    IL_001e: ldc.i4.0
    IL_001f: ceq
    IL_0021: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0026: ldarg.0
    IL_0027: ldfld TMP_Text ControlGroupPopUp::instructionsText  /*0x04000498*/
    IL_002c: ldarg.0
    IL_002d: ldfld string ControlGroupPopUp::instructionsKey  /*0x04000499*/
    IL_0032: ldc.i4.1
    IL_0033: ldc.i4.0
    IL_0034: ldc.i4.1
    IL_0035: ldc.i4.1
    IL_0036: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_003b: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0040: ret

  .method ControlGroupPopUp::.ctor()  // token 0x06000392 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

