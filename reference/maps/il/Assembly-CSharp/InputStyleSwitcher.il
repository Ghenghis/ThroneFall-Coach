// ===== InputStyleSwitcher  (token 0x0200019B) =====
  .method InputStyleSwitcher::Start()  // token 0x06000856 rva 0x2895f attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_000c: stfld Player InputStyleSwitcher::player  /*0x04000A64*/
    IL_0011: ret

  .method InputStyleSwitcher::Update()  // token 0x06000857 rva 0x28974 attrs Private, HideBySig
    // code size 74 (0x4a), max stack 2, init locals
    .locals ([0] Controller)
    IL_0000: ldarg.0
    IL_0001: ldfld Player InputStyleSwitcher::player  /*0x04000A64*/
    IL_0006: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_000b: callvirt Controller Rewired.Player.ControllerHelper::GetLastActiveController()  /*0x0A000005*/
    IL_0010: stloc.0
    IL_0011: ldloc.0
    IL_0012: brfalse.s IL_0049
    IL_0014: ldloc.0
    IL_0015: callvirt ControllerType Rewired.Controller::get_type()  /*0x0A000006*/
    IL_001a: brfalse.s IL_0025
    IL_001c: ldloc.0
    IL_001d: callvirt ControllerType Rewired.Controller::get_type()  /*0x0A000006*/
    IL_0022: ldc.i4.1
    IL_0023: bne.un.s IL_002e
    IL_0025: ldarg.0
    IL_0026: ldc.i4.1
    IL_0027: stfld InputActionGlyph.InputPriority InputStyleSwitcher::inputPriority  /*0x04000A63*/
    IL_002c: br.s IL_003e
    IL_002e: ldloc.0
    IL_002f: callvirt ControllerType Rewired.Controller::get_type()  /*0x0A000006*/
    IL_0034: ldc.i4.2
    IL_0035: bne.un.s IL_003e
    IL_0037: ldarg.0
    IL_0038: ldc.i4.0
    IL_0039: stfld InputActionGlyph.InputPriority InputStyleSwitcher::inputPriority  /*0x04000A63*/
    IL_003e: ldarg.0
    IL_003f: ldfld InputActionGlyph.InputPriority InputStyleSwitcher::inputPriority  /*0x04000A63*/
    IL_0044: stsfld InputActionGlyph.InputPriority TextTranslator::inputPriority  /*0x04000C96*/
    IL_0049: ret

  .method InputStyleSwitcher::.ctor()  // token 0x06000858 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

