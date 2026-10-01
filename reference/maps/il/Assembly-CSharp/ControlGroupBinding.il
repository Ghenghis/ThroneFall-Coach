// ===== ControlGroupBinding  (token 0x02000002) =====
  .method ControlGroupBinding::Start()  // token 0x06000001 rva 0x2050 attrs Private, HideBySig
    // code size 50 (0x32), max stack 8
    IL_0000: ldarg.0
    IL_0001: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_000c: stfld Player ControlGroupBinding::input  /*0x04000003*/
    IL_0011: ldarg.0
    IL_0012: ldfld Player ControlGroupBinding::input  /*0x04000003*/
    IL_0017: brfalse.s IL_0031
    IL_0019: ldarg.0
    IL_001a: ldfld Player ControlGroupBinding::input  /*0x04000003*/
    IL_001f: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0024: callvirt Controller Rewired.Player.ControllerHelper::GetLastActiveController()  /*0x0A000005*/
    IL_0029: pop
    IL_002a: ldarg.0
    IL_002b: ldc.i4.2
    IL_002c: call void ControlGroupBinding::Refresh(Rewired.ControllerType)  /*0x06000003*/
    IL_0031: ret

  .method ControlGroupBinding::Update()  // token 0x06000002 rva 0x2084 attrs Private, HideBySig
    // code size 52 (0x34), max stack 2, init locals
    .locals ([0] Controller, [1] ControllerType)
    IL_0000: ldarg.0
    IL_0001: ldfld Player ControlGroupBinding::input  /*0x04000003*/
    IL_0006: brfalse.s IL_0033
    IL_0008: ldarg.0
    IL_0009: ldfld Player ControlGroupBinding::input  /*0x04000003*/
    IL_000e: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0013: callvirt Controller Rewired.Player.ControllerHelper::GetLastActiveController()  /*0x0A000005*/
    IL_0018: stloc.0
    IL_0019: ldloc.0
    IL_001a: brfalse.s IL_0033
    IL_001c: ldloc.0
    IL_001d: callvirt ControllerType Rewired.Controller::get_type()  /*0x0A000006*/
    IL_0022: stloc.1
    IL_0023: ldarg.0
    IL_0024: ldfld ControllerType ControlGroupBinding::lastControllerType  /*0x04000004*/
    IL_0029: ldloc.1
    IL_002a: beq.s IL_0033
    IL_002c: ldarg.0
    IL_002d: ldloc.1
    IL_002e: call void ControlGroupBinding::Refresh(Rewired.ControllerType)  /*0x06000003*/
    IL_0033: ret

  .method ControlGroupBinding::Refresh(Rewired.ControllerType)  // token 0x06000003 rva 0x20c4 attrs Private, HideBySig
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_0009
    IL_0003: ldarg.1
    IL_0004: ldc.i4.1
    IL_0005: ceq
    IL_0007: br.s IL_000a
    IL_0009: ldc.i4.1
    IL_000a: pop
    IL_000b: ldarg.0
    IL_000c: ldfld TextMeshProUGUI ControlGroupBinding::displayGlyph  /*0x04000001*/
    IL_0011: ldarg.0
    IL_0012: ldfld string ControlGroupBinding::actionName  /*0x04000002*/
    IL_0017: ldc.i4.0
    IL_0018: ldc.i4.0
    IL_0019: call string InputActionGlyph::GetActionGlyph(string,InputActionGlyph.InputPriority,bool)  /*0x06001101*/
    IL_001e: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0023: ret

  .method ControlGroupBinding::.ctor()  // token 0x06000004 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== ControlGroupBinding/AxisMode  (token 0x02000003) =====
