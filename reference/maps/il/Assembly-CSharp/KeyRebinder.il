// ===== KeyRebinder  (token 0x0200031A) =====
  .method KeyRebinder::get_player()  // token 0x0600110A rva 0x4f37e attrs Private, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0005: ldc.i4.0
    IL_0006: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_000b: ret

  .method KeyRebinder::get_SelectedJoystick()  // token 0x0600110B rva 0x4f38b attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Joystick KeyRebinder::selectedJoystick  /*0x0400145A*/
    IL_0006: ret

  .method KeyRebinder::get_KeyboardMap()  // token 0x0600110C rva 0x4f393 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ControllerMap KeyRebinder::keyboardMap  /*0x0400145B*/
    IL_0006: ret

  .method KeyRebinder::get_MouseMap()  // token 0x0600110D rva 0x4f39b attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ControllerMap KeyRebinder::mouseMap  /*0x0400145C*/
    IL_0006: ret

  .method KeyRebinder::get_JoystickMap()  // token 0x0600110E rva 0x4f3a3 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ControllerMap KeyRebinder::joystickMap  /*0x0400145D*/
    IL_0006: ret

  .method KeyRebinder::get_UICategoryId()  // token 0x0600110F rva 0x4f3ab attrs Private, HideBySig, SpecialName
    // code size 16 (0x10), max stack 8
    IL_0000: call ReInput.MappingHelper Rewired.ReInput::get_mapping()  /*0x0A0003F0*/
    IL_0005: ldstr "UI"
    IL_000a: callvirt int Rewired.ReInput.MappingHelper::GetActionCategoryId(string)  /*0x0A00068D*/
    IL_000f: ret

  .method KeyRebinder::get_GameplayAlwaysCategoryId()  // token 0x06001110 rva 0x4f3bc attrs Private, HideBySig, SpecialName
    // code size 16 (0x10), max stack 8
    IL_0000: call ReInput.MappingHelper Rewired.ReInput::get_mapping()  /*0x0A0003F0*/
    IL_0005: ldstr "Gameplay Always"
    IL_000a: callvirt int Rewired.ReInput.MappingHelper::GetActionCategoryId(string)  /*0x0A00068D*/
    IL_000f: ret

  .method KeyRebinder::get_GameplayNotOverlappingCategoriesIds()  // token 0x06001111 rva 0x4f3d0 attrs Private, HideBySig, SpecialName
    // code size 50 (0x32), max stack 3, init locals
    .locals ([0] List<int>, [1] string[], [2] int, [3] string)
    IL_0000: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0005: stloc.0
    IL_0006: ldarg.0
    IL_0007: ldfld string[] KeyRebinder::gameplayNotOverlappingCategories  /*0x04001462*/
    IL_000c: stloc.1
    IL_000d: ldc.i4.0
    IL_000e: stloc.2
    IL_000f: br.s IL_002a
    IL_0011: ldloc.1
    IL_0012: ldloc.2
    IL_0013: ldelem.ref
    IL_0014: stloc.3
    IL_0015: ldloc.0
    IL_0016: call ReInput.MappingHelper Rewired.ReInput::get_mapping()  /*0x0A0003F0*/
    IL_001b: ldloc.3
    IL_001c: callvirt int Rewired.ReInput.MappingHelper::GetActionCategoryId(string)  /*0x0A00068D*/
    IL_0021: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0026: ldloc.2
    IL_0027: ldc.i4.1
    IL_0028: add
    IL_0029: stloc.2
    IL_002a: ldloc.2
    IL_002b: ldloc.1
    IL_002c: ldlen
    IL_002d: conv.i4
    IL_002e: blt.s IL_0011
    IL_0030: ldloc.0
    IL_0031: ret

  .method KeyRebinder::OnEnable()  // token 0x06001112 rva 0x4f410 attrs Private, HideBySig
    // code size 474 (0x1da), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: newobj void Rewired.InputMapper::.ctor()  /*0x0A00068E*/
    IL_0006: stfld InputMapper KeyRebinder::keyboardMapper  /*0x04001457*/
    IL_000b: ldarg.0
    IL_000c: ldfld InputMapper KeyRebinder::keyboardMapper  /*0x04001457*/
    IL_0011: callvirt InputMapper.Options Rewired.InputMapper::get_options()  /*0x0A00068F*/
    IL_0016: ldc.i4.1
    IL_0017: callvirt void Rewired.InputMapper.Options::set_allowKeyboardModifierKeyAsPrimary(bool)  /*0x0A000690*/
    IL_001c: ldarg.0
    IL_001d: ldfld InputMapper KeyRebinder::keyboardMapper  /*0x04001457*/
    IL_0022: callvirt InputMapper.Options Rewired.InputMapper::get_options()  /*0x0A00068F*/
    IL_0027: ldc.i4.0
    IL_0028: callvirt void Rewired.InputMapper.Options::set_allowKeyboardKeysWithModifiers(bool)  /*0x0A000691*/
    IL_002d: ldarg.0
    IL_002e: ldfld InputMapper KeyRebinder::keyboardMapper  /*0x04001457*/
    IL_0033: callvirt InputMapper.Options Rewired.InputMapper::get_options()  /*0x0A00068F*/
    IL_0038: ldc.i4.1
    IL_0039: callvirt void Rewired.InputMapper.Options::set_ignoreMouseXAxis(bool)  /*0x0A000692*/
    IL_003e: ldarg.0
    IL_003f: ldfld InputMapper KeyRebinder::keyboardMapper  /*0x04001457*/
    IL_0044: callvirt InputMapper.Options Rewired.InputMapper::get_options()  /*0x0A00068F*/
    IL_0049: ldc.i4.1
    IL_004a: callvirt void Rewired.InputMapper.Options::set_ignoreMouseYAxis(bool)  /*0x0A000693*/
    IL_004f: ldarg.0
    IL_0050: ldfld InputMapper KeyRebinder::keyboardMapper  /*0x04001457*/
    IL_0055: callvirt InputMapper.Options Rewired.InputMapper::get_options()  /*0x0A00068F*/
    IL_005a: ldc.r4 3f
    IL_005f: callvirt void Rewired.InputMapper.Options::set_timeout(float)  /*0x0A000694*/
    IL_0064: ldarg.0
    IL_0065: ldfld InputMapper KeyRebinder::keyboardMapper  /*0x04001457*/
    IL_006a: callvirt InputMapper.Options Rewired.InputMapper::get_options()  /*0x0A00068F*/
    IL_006f: ldc.i4.1
    IL_0070: callvirt void Rewired.InputMapper.Options::set_checkForConflicts(bool)  /*0x0A000695*/
    IL_0075: ldarg.0
    IL_0076: ldfld InputMapper KeyRebinder::keyboardMapper  /*0x04001457*/
    IL_007b: ldarg.0
    IL_007c: ldftn void KeyRebinder::OnBindConflict(Rewired.InputMapper.ConflictFoundEventData)  /*0x0600111E*/
    IL_0082: newobj void System.Action<Rewired.InputMapper.ConflictFoundEventData>::.ctor(object,IntPtr)  /*0x0A000696*/
    IL_0087: callvirt void Rewired.InputMapper::add_ConflictFoundEvent(System.Action<Rewired.InputMapper.ConflictFoundEventData>)  /*0x0A000697*/
    IL_008c: ldarg.0
    IL_008d: newobj void Rewired.InputMapper::.ctor()  /*0x0A00068E*/
    IL_0092: stfld InputMapper KeyRebinder::mouseMapper  /*0x04001458*/
    IL_0097: ldarg.0
    IL_0098: ldfld InputMapper KeyRebinder::mouseMapper  /*0x04001458*/
    IL_009d: callvirt InputMapper.Options Rewired.InputMapper::get_options()  /*0x0A00068F*/
    IL_00a2: ldc.i4.1
    IL_00a3: callvirt void Rewired.InputMapper.Options::set_ignoreMouseXAxis(bool)  /*0x0A000692*/
    IL_00a8: ldarg.0
    IL_00a9: ldfld InputMapper KeyRebinder::mouseMapper  /*0x04001458*/
    IL_00ae: callvirt InputMapper.Options Rewired.InputMapper::get_options()  /*0x0A00068F*/
    IL_00b3: ldc.i4.1
    IL_00b4: callvirt void Rewired.InputMapper.Options::set_ignoreMouseYAxis(bool)  /*0x0A000693*/
    IL_00b9: ldarg.0
    IL_00ba: ldfld InputMapper KeyRebinder::mouseMapper  /*0x04001458*/
    IL_00bf: callvirt InputMapper.Options Rewired.InputMapper::get_options()  /*0x0A00068F*/
    IL_00c4: ldc.r4 3f
    IL_00c9: callvirt void Rewired.InputMapper.Options::set_timeout(float)  /*0x0A000694*/
    IL_00ce: ldarg.0
    IL_00cf: ldfld InputMapper KeyRebinder::mouseMapper  /*0x04001458*/
    IL_00d4: callvirt InputMapper.Options Rewired.InputMapper::get_options()  /*0x0A00068F*/
    IL_00d9: ldc.i4.1
    IL_00da: callvirt void Rewired.InputMapper.Options::set_checkForConflicts(bool)  /*0x0A000695*/
    IL_00df: ldarg.0
    IL_00e0: ldfld InputMapper KeyRebinder::mouseMapper  /*0x04001458*/
    IL_00e5: ldarg.0
    IL_00e6: ldftn void KeyRebinder::OnBindConflict(Rewired.InputMapper.ConflictFoundEventData)  /*0x0600111E*/
    IL_00ec: newobj void System.Action<Rewired.InputMapper.ConflictFoundEventData>::.ctor(object,IntPtr)  /*0x0A000696*/
    IL_00f1: callvirt void Rewired.InputMapper::add_ConflictFoundEvent(System.Action<Rewired.InputMapper.ConflictFoundEventData>)  /*0x0A000697*/
    IL_00f6: ldarg.0
    IL_00f7: newobj void Rewired.InputMapper::.ctor()  /*0x0A00068E*/
    IL_00fc: stfld InputMapper KeyRebinder::joystickMapper  /*0x04001459*/
    IL_0101: ldarg.0
    IL_0102: ldfld InputMapper KeyRebinder::joystickMapper  /*0x04001459*/
    IL_0107: callvirt InputMapper.Options Rewired.InputMapper::get_options()  /*0x0A00068F*/
    IL_010c: ldc.i4.1
    IL_010d: callvirt void Rewired.InputMapper.Options::set_ignoreMouseXAxis(bool)  /*0x0A000692*/
    IL_0112: ldarg.0
    IL_0113: ldfld InputMapper KeyRebinder::joystickMapper  /*0x04001459*/
    IL_0118: callvirt InputMapper.Options Rewired.InputMapper::get_options()  /*0x0A00068F*/
    IL_011d: ldc.i4.1
    IL_011e: callvirt void Rewired.InputMapper.Options::set_ignoreMouseYAxis(bool)  /*0x0A000693*/
    IL_0123: ldarg.0
    IL_0124: ldfld InputMapper KeyRebinder::joystickMapper  /*0x04001459*/
    IL_0129: callvirt InputMapper.Options Rewired.InputMapper::get_options()  /*0x0A00068F*/
    IL_012e: ldc.r4 3f
    IL_0133: callvirt void Rewired.InputMapper.Options::set_timeout(float)  /*0x0A000694*/
    IL_0138: ldarg.0
    IL_0139: ldfld InputMapper KeyRebinder::joystickMapper  /*0x04001459*/
    IL_013e: callvirt InputMapper.Options Rewired.InputMapper::get_options()  /*0x0A00068F*/
    IL_0143: ldc.i4.1
    IL_0144: callvirt void Rewired.InputMapper.Options::set_checkForConflicts(bool)  /*0x0A000695*/
    IL_0149: ldarg.0
    IL_014a: ldfld InputMapper KeyRebinder::joystickMapper  /*0x04001459*/
    IL_014f: ldarg.0
    IL_0150: ldftn void KeyRebinder::OnBindConflict(Rewired.InputMapper.ConflictFoundEventData)  /*0x0600111E*/
    IL_0156: newobj void System.Action<Rewired.InputMapper.ConflictFoundEventData>::.ctor(object,IntPtr)  /*0x0A000696*/
    IL_015b: callvirt void Rewired.InputMapper::add_ConflictFoundEvent(System.Action<Rewired.InputMapper.ConflictFoundEventData>)  /*0x0A000697*/
    IL_0160: ldarg.0
    IL_0161: ldftn void KeyRebinder::OnControllerConnectionChange(Rewired.ControllerStatusChangedEventArgs)  /*0x06001116*/
    IL_0167: newobj void System.Action<Rewired.ControllerStatusChangedEventArgs>::.ctor(object,IntPtr)  /*0x0A000009*/
    IL_016c: call void Rewired.ReInput::add_ControllerConnectedEvent(System.Action<Rewired.ControllerStatusChangedEventArgs>)  /*0x0A00000A*/
    IL_0171: ldarg.0
    IL_0172: ldftn void KeyRebinder::OnControllerConnectionChange(Rewired.ControllerStatusChangedEventArgs)  /*0x06001116*/
    IL_0178: newobj void System.Action<Rewired.ControllerStatusChangedEventArgs>::.ctor(object,IntPtr)  /*0x0A000009*/
    IL_017d: call void Rewired.ReInput::add_ControllerDisconnectedEvent(System.Action<Rewired.ControllerStatusChangedEventArgs>)  /*0x0A00000B*/
    IL_0182: ldarg.0
    IL_0183: ldfld InputMapper KeyRebinder::keyboardMapper  /*0x04001457*/
    IL_0188: ldarg.0
    IL_0189: ldftn void KeyRebinder::OnInputMapped(Rewired.InputMapper.InputMappedEventData)  /*0x0600111D*/
    IL_018f: newobj void System.Action<Rewired.InputMapper.InputMappedEventData>::.ctor(object,IntPtr)  /*0x0A000698*/
    IL_0194: callvirt void Rewired.InputMapper::add_InputMappedEvent(System.Action<Rewired.InputMapper.InputMappedEventData>)  /*0x0A000699*/
    IL_0199: ldarg.0
    IL_019a: ldfld InputMapper KeyRebinder::mouseMapper  /*0x04001458*/
    IL_019f: ldarg.0
    IL_01a0: ldftn void KeyRebinder::OnInputMapped(Rewired.InputMapper.InputMappedEventData)  /*0x0600111D*/
    IL_01a6: newobj void System.Action<Rewired.InputMapper.InputMappedEventData>::.ctor(object,IntPtr)  /*0x0A000698*/
    IL_01ab: callvirt void Rewired.InputMapper::add_InputMappedEvent(System.Action<Rewired.InputMapper.InputMappedEventData>)  /*0x0A000699*/
    IL_01b0: ldarg.0
    IL_01b1: ldfld InputMapper KeyRebinder::joystickMapper  /*0x04001459*/
    IL_01b6: ldarg.0
    IL_01b7: ldftn void KeyRebinder::OnInputMapped(Rewired.InputMapper.InputMappedEventData)  /*0x0600111D*/
    IL_01bd: newobj void System.Action<Rewired.InputMapper.InputMappedEventData>::.ctor(object,IntPtr)  /*0x0A000698*/
    IL_01c2: callvirt void Rewired.InputMapper::add_InputMappedEvent(System.Action<Rewired.InputMapper.InputMappedEventData>)  /*0x0A000699*/
    IL_01c7: ldarg.0
    IL_01c8: ldfld GameObject KeyRebinder::listeningToRemapPopUp  /*0x0400144E*/
    IL_01cd: ldc.i4.0
    IL_01ce: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01d3: ldarg.0
    IL_01d4: call void KeyRebinder::RegenerateButtons()  /*0x06001114*/
    IL_01d9: ret

  .method KeyRebinder::OnDisable()  // token 0x06001113 rva 0x4f5f6 attrs Private, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldftn void KeyRebinder::OnControllerConnectionChange(Rewired.ControllerStatusChangedEventArgs)  /*0x06001116*/
    IL_0007: newobj void System.Action<Rewired.ControllerStatusChangedEventArgs>::.ctor(object,IntPtr)  /*0x0A000009*/
    IL_000c: call void Rewired.ReInput::remove_ControllerConnectedEvent(System.Action<Rewired.ControllerStatusChangedEventArgs>)  /*0x0A00000C*/
    IL_0011: ldarg.0
    IL_0012: ldftn void KeyRebinder::OnControllerConnectionChange(Rewired.ControllerStatusChangedEventArgs)  /*0x06001116*/
    IL_0018: newobj void System.Action<Rewired.ControllerStatusChangedEventArgs>::.ctor(object,IntPtr)  /*0x0A000009*/
    IL_001d: call void Rewired.ReInput::remove_ControllerDisconnectedEvent(System.Action<Rewired.ControllerStatusChangedEventArgs>)  /*0x0A00000D*/
    IL_0022: ret

  .method KeyRebinder::RegenerateButtons()  // token 0x06001114 rva 0x4f61c attrs Public, HideBySig
    // code size 943 (0x3af), max stack 4, init locals
    .locals ([0] int, [1] List<GameObject>, [2] ThronefallUIElement, [3] ThronefallUIElement, [4] IEnumerator, [5] Transform, [6] IDisposable, [7] int, [8] List.Enumerator<string>, [9] string, [10] ControlMapButton, [11] IEnumerator<InputAction>, [12] InputAction, [13] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldarg.0
    IL_0003: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_0008: callvirt void System.Collections.Generic.List<ControlMapButton>::Clear()  /*0x0A00069A*/
    IL_000d: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000133*/
    IL_0012: stloc.1
    IL_0013: ldarg.0
    IL_0014: ldfld Transform KeyRebinder::buttonParent  /*0x04001454*/
    IL_0019: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_001e: stloc.s 4
    IL_0020: br.s IL_003d
    IL_0022: ldloc.s 4
    IL_0024: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_0029: castclass UnityEngine.Transform  /*0x01000015*/
    IL_002e: stloc.s 5
    IL_0030: ldloc.1
    IL_0031: ldloc.s 5
    IL_0033: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0038: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_003d: ldloc.s 4
    IL_003f: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0044: brtrue.s IL_0022
    IL_0046: leave.s IL_005d
    IL_0048: ldloc.s 4
    IL_004a: isinst System.IDisposable  /*0x0100001B*/
    IL_004f: stloc.s 6
    IL_0051: ldloc.s 6
    IL_0053: brfalse.s IL_005c
    IL_0055: ldloc.s 6
    IL_0057: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_005c: endfinally
    IL_005d: ldloc.1
    IL_005e: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_0063: ldc.i4.1
    IL_0064: sub
    IL_0065: stloc.s 7
    IL_0067: br.s IL_007c
    IL_0069: ldloc.1
    IL_006a: ldloc.s 7
    IL_006c: callvirt !0 System.Collections.Generic.List<UnityEngine.GameObject>::get_Item(int)  /*0x0A0001C5*/
    IL_0071: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0076: ldloc.s 7
    IL_0078: ldc.i4.1
    IL_0079: sub
    IL_007a: stloc.s 7
    IL_007c: ldloc.s 7
    IL_007e: ldc.i4.0
    IL_007f: bge.s IL_0069
    IL_0081: ldarg.0
    IL_0082: ldfld ThronefallUIElement KeyRebinder::controllerPickerButtonPrefab  /*0x04001452*/
    IL_0087: ldarg.0
    IL_0088: ldfld Transform KeyRebinder::buttonParent  /*0x04001454*/
    IL_008d: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<ThronefallUIElement>  /*0x2B0000F5*/
    IL_0092: stloc.2
    IL_0093: ldloc.2
    IL_0094: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0099: callvirt !!0 UnityEngine.GameObject::AddComponent()<ScrollElementID>  /*0x2B0000F6*/
    IL_009e: ldloc.0
    IL_009f: stfld int ScrollElementID::id  /*0x04001574*/
    IL_00a4: ldloc.0
    IL_00a5: ldc.i4.1
    IL_00a6: add
    IL_00a7: stloc.0
    IL_00a8: ldarg.0
    IL_00a9: ldloc.2
    IL_00aa: callvirt !!0 UnityEngine.Component::GetComponentInChildren()<EnumSelector>  /*0x2B0000F7*/
    IL_00af: stfld EnumSelector KeyRebinder::controllerSelector  /*0x04001463*/
    IL_00b4: ldarg.0
    IL_00b5: ldfld EnumSelector KeyRebinder::controllerSelector  /*0x04001463*/
    IL_00ba: ldfld UnityEvent EnumSelector::onChange  /*0x040013D4*/
    IL_00bf: ldarg.0
    IL_00c0: ldftn void KeyRebinder::OnControllerSelectionChange()  /*0x0600111A*/
    IL_00c6: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00cb: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00d0: ldarg.0
    IL_00d1: call void KeyRebinder::RefreshControllerPickOptions()  /*0x06001119*/
    IL_00d6: ldarg.0
    IL_00d7: call void KeyRebinder::RefreshAllMaps()  /*0x06001117*/
    IL_00dc: ldarg.0
    IL_00dd: ldfld ThronefallUIElement KeyRebinder::restoreControlsButtonPrefab  /*0x04001451*/
    IL_00e2: ldarg.0
    IL_00e3: ldfld Transform KeyRebinder::buttonParent  /*0x04001454*/
    IL_00e8: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<ThronefallUIElement>  /*0x2B0000F5*/
    IL_00ed: stloc.3
    IL_00ee: ldloc.3
    IL_00ef: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00f4: callvirt !!0 UnityEngine.GameObject::AddComponent()<ScrollElementID>  /*0x2B0000F6*/
    IL_00f9: ldloc.0
    IL_00fa: stfld int ScrollElementID::id  /*0x04001574*/
    IL_00ff: ldloc.0
    IL_0100: ldc.i4.1
    IL_0101: add
    IL_0102: stloc.0
    IL_0103: ldarg.0
    IL_0104: ldfld GameObject KeyRebinder::controlDevicesIconsPrefab  /*0x04001450*/
    IL_0109: ldarg.0
    IL_010a: ldfld Transform KeyRebinder::buttonParent  /*0x04001454*/
    IL_010f: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_0114: callvirt GameObject UnityEngine.GameObject::get_gameObject()  /*0x0A0005FE*/
    IL_0119: callvirt !!0 UnityEngine.GameObject::AddComponent()<ScrollElementID>  /*0x2B0000F6*/
    IL_011e: ldloc.0
    IL_011f: stfld int ScrollElementID::id  /*0x04001574*/
    IL_0124: ldloc.0
    IL_0125: ldc.i4.1
    IL_0126: add
    IL_0127: stloc.0
    IL_0128: ldarg.0
    IL_0129: ldfld List<string> KeyRebinder::actionCategoriesToShow  /*0x0400144D*/
    IL_012e: callvirt List.Enumerator<!0> System.Collections.Generic.List<string>::GetEnumerator()  /*0x0A0002EB*/
    IL_0133: stloc.s 8
    IL_0135: br IL_025e
    IL_013a: ldloca.s 8
    IL_013c: call !0 System.Collections.Generic.List.Enumerator<string>::get_Current()  /*0x0A0002EC*/
    IL_0141: stloc.s 9
    IL_0143: ldnull
    IL_0144: stloc.s 10
    IL_0146: call ReInput.MappingHelper Rewired.ReInput::get_mapping()  /*0x0A0003F0*/
    IL_014b: ldloc.s 9
    IL_014d: callvirt IEnumerable<InputAction> Rewired.ReInput.MappingHelper::ActionsInCategory(string)  /*0x0A00069B*/
    IL_0152: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<Rewired.InputAction>::GetEnumerator()  /*0x0A00069C*/
    IL_0157: stloc.s 11
    IL_0159: br IL_0244
    IL_015e: ldloc.s 11
    IL_0160: callvirt !0 System.Collections.Generic.IEnumerator<Rewired.InputAction>::get_Current()  /*0x0A00069D*/
    IL_0165: stloc.s 12
    IL_0167: ldloc.s 12
    IL_0169: callvirt bool Rewired.InputAction::get_userAssignable()  /*0x0A00069E*/
    IL_016e: brfalse IL_0244
    IL_0173: ldloc.s 12
    IL_0175: callvirt InputActionType Rewired.InputAction::get_type()  /*0x0A000685*/
    IL_017a: brtrue IL_0203
    IL_017f: ldarg.0
    IL_0180: ldfld ControlMapButton KeyRebinder::buttonPrefab  /*0x04001453*/
    IL_0185: ldarg.0
    IL_0186: ldfld Transform KeyRebinder::buttonParent  /*0x04001454*/
    IL_018b: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<ControlMapButton>  /*0x2B0000F8*/
    IL_0190: stloc.s 10
    IL_0192: ldloc.s 10
    IL_0194: ldloc.s 12
    IL_0196: ldarg.0
    IL_0197: ldc.i4.1
    IL_0198: callvirt void ControlMapButton::SetData(Rewired.InputAction,KeyRebinder,ControlMapButton.AxisMode)  /*0x0600100A*/
    IL_019d: ldloc.s 10
    IL_019f: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01a4: callvirt !!0 UnityEngine.GameObject::AddComponent()<ScrollElementID>  /*0x2B0000F6*/
    IL_01a9: ldloc.0
    IL_01aa: stfld int ScrollElementID::id  /*0x04001574*/
    IL_01af: ldloc.0
    IL_01b0: ldc.i4.1
    IL_01b1: add
    IL_01b2: stloc.0
    IL_01b3: ldarg.0
    IL_01b4: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_01b9: ldloc.s 10
    IL_01bb: callvirt void System.Collections.Generic.List<ControlMapButton>::Add(!0)  /*0x0A00069F*/
    IL_01c0: ldarg.0
    IL_01c1: ldfld ControlMapButton KeyRebinder::buttonPrefab  /*0x04001453*/
    IL_01c6: ldarg.0
    IL_01c7: ldfld Transform KeyRebinder::buttonParent  /*0x04001454*/
    IL_01cc: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<ControlMapButton>  /*0x2B0000F8*/
    IL_01d1: stloc.s 10
    IL_01d3: ldloc.s 10
    IL_01d5: ldloc.s 12
    IL_01d7: ldarg.0
    IL_01d8: ldc.i4.2
    IL_01d9: callvirt void ControlMapButton::SetData(Rewired.InputAction,KeyRebinder,ControlMapButton.AxisMode)  /*0x0600100A*/
    IL_01de: ldloc.s 10
    IL_01e0: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01e5: callvirt !!0 UnityEngine.GameObject::AddComponent()<ScrollElementID>  /*0x2B0000F6*/
    IL_01ea: ldloc.0
    IL_01eb: stfld int ScrollElementID::id  /*0x04001574*/
    IL_01f0: ldloc.0
    IL_01f1: ldc.i4.1
    IL_01f2: add
    IL_01f3: stloc.0
    IL_01f4: ldarg.0
    IL_01f5: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_01fa: ldloc.s 10
    IL_01fc: callvirt void System.Collections.Generic.List<ControlMapButton>::Add(!0)  /*0x0A00069F*/
    IL_0201: br.s IL_0244
    IL_0203: ldarg.0
    IL_0204: ldfld ControlMapButton KeyRebinder::buttonPrefab  /*0x04001453*/
    IL_0209: ldarg.0
    IL_020a: ldfld Transform KeyRebinder::buttonParent  /*0x04001454*/
    IL_020f: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<ControlMapButton>  /*0x2B0000F8*/
    IL_0214: stloc.s 10
    IL_0216: ldloc.s 10
    IL_0218: ldloc.s 12
    IL_021a: ldarg.0
    IL_021b: ldc.i4.0
    IL_021c: callvirt void ControlMapButton::SetData(Rewired.InputAction,KeyRebinder,ControlMapButton.AxisMode)  /*0x0600100A*/
    IL_0221: ldloc.s 10
    IL_0223: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0228: callvirt !!0 UnityEngine.GameObject::AddComponent()<ScrollElementID>  /*0x2B0000F6*/
    IL_022d: ldloc.0
    IL_022e: stfld int ScrollElementID::id  /*0x04001574*/
    IL_0233: ldloc.0
    IL_0234: ldc.i4.1
    IL_0235: add
    IL_0236: stloc.0
    IL_0237: ldarg.0
    IL_0238: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_023d: ldloc.s 10
    IL_023f: callvirt void System.Collections.Generic.List<ControlMapButton>::Add(!0)  /*0x0A00069F*/
    IL_0244: ldloc.s 11
    IL_0246: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_024b: brtrue IL_015e
    IL_0250: leave.s IL_025e
    IL_0252: ldloc.s 11
    IL_0254: brfalse.s IL_025d
    IL_0256: ldloc.s 11
    IL_0258: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_025d: endfinally
    IL_025e: ldloca.s 8
    IL_0260: call bool System.Collections.Generic.List.Enumerator<string>::MoveNext()  /*0x0A0002ED*/
    IL_0265: brtrue IL_013a
    IL_026a: leave.s IL_027a
    IL_026c: ldloca.s 8
    IL_026e: constrained. System.Collections.Generic.List.Enumerator<string>  /*0x1B000087*/
    IL_0274: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0279: endfinally
    IL_027a: ldloc.2
    IL_027b: ldarg.0
    IL_027c: ldfld ThronefallUIElement KeyRebinder::tabButton  /*0x0400144F*/
    IL_0281: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0286: ldloc.2
    IL_0287: ldloc.3
    IL_0288: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_028d: ldloc.3
    IL_028e: ldloc.2
    IL_028f: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0294: ldc.i4.0
    IL_0295: stloc.s 13
    IL_0297: br IL_0346
    IL_029c: ldloc.s 13
    IL_029e: brtrue.s IL_02ba
    IL_02a0: ldarg.0
    IL_02a1: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_02a6: ldloc.s 13
    IL_02a8: callvirt !0 System.Collections.Generic.List<ControlMapButton>::get_Item(int)  /*0x0A0006A0*/
    IL_02ad: ldfld TFUITextButton ControlMapButton::target  /*0x040012DA*/
    IL_02b2: ldloc.3
    IL_02b3: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_02b8: br.s IL_02e5
    IL_02ba: ldarg.0
    IL_02bb: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_02c0: ldloc.s 13
    IL_02c2: callvirt !0 System.Collections.Generic.List<ControlMapButton>::get_Item(int)  /*0x0A0006A0*/
    IL_02c7: ldfld TFUITextButton ControlMapButton::target  /*0x040012DA*/
    IL_02cc: ldarg.0
    IL_02cd: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_02d2: ldloc.s 13
    IL_02d4: ldc.i4.1
    IL_02d5: sub
    IL_02d6: callvirt !0 System.Collections.Generic.List<ControlMapButton>::get_Item(int)  /*0x0A0006A0*/
    IL_02db: ldfld TFUITextButton ControlMapButton::target  /*0x040012DA*/
    IL_02e0: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_02e5: ldloc.s 13
    IL_02e7: ldarg.0
    IL_02e8: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_02ed: callvirt int System.Collections.Generic.List<ControlMapButton>::get_Count()  /*0x0A0006A1*/
    IL_02f2: ldc.i4.1
    IL_02f3: sub
    IL_02f4: bne.un.s IL_0315
    IL_02f6: ldarg.0
    IL_02f7: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_02fc: ldloc.s 13
    IL_02fe: callvirt !0 System.Collections.Generic.List<ControlMapButton>::get_Item(int)  /*0x0A0006A0*/
    IL_0303: ldfld TFUITextButton ControlMapButton::target  /*0x040012DA*/
    IL_0308: ldarg.0
    IL_0309: ldfld ThronefallUIElement KeyRebinder::tabButton  /*0x0400144F*/
    IL_030e: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0313: br.s IL_0340
    IL_0315: ldarg.0
    IL_0316: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_031b: ldloc.s 13
    IL_031d: callvirt !0 System.Collections.Generic.List<ControlMapButton>::get_Item(int)  /*0x0A0006A0*/
    IL_0322: ldfld TFUITextButton ControlMapButton::target  /*0x040012DA*/
    IL_0327: ldarg.0
    IL_0328: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_032d: ldloc.s 13
    IL_032f: ldc.i4.1
    IL_0330: add
    IL_0331: callvirt !0 System.Collections.Generic.List<ControlMapButton>::get_Item(int)  /*0x0A0006A0*/
    IL_0336: ldfld TFUITextButton ControlMapButton::target  /*0x040012DA*/
    IL_033b: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0340: ldloc.s 13
    IL_0342: ldc.i4.1
    IL_0343: add
    IL_0344: stloc.s 13
    IL_0346: ldloc.s 13
    IL_0348: ldarg.0
    IL_0349: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_034e: callvirt int System.Collections.Generic.List<ControlMapButton>::get_Count()  /*0x0A0006A1*/
    IL_0353: blt IL_029c
    IL_0358: ldarg.0
    IL_0359: ldfld ThronefallUIElement KeyRebinder::tabButton  /*0x0400144F*/
    IL_035e: ldloc.2
    IL_035f: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0364: ldarg.0
    IL_0365: ldfld ThronefallUIElement KeyRebinder::tabButton  /*0x0400144F*/
    IL_036a: ldarg.0
    IL_036b: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_0370: ldarg.0
    IL_0371: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_0376: callvirt int System.Collections.Generic.List<ControlMapButton>::get_Count()  /*0x0A0006A1*/
    IL_037b: ldc.i4.1
    IL_037c: sub
    IL_037d: callvirt !0 System.Collections.Generic.List<ControlMapButton>::get_Item(int)  /*0x0A0006A0*/
    IL_0382: ldfld TFUITextButton ControlMapButton::target  /*0x040012DA*/
    IL_0387: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_038c: ldloc.3
    IL_038d: ldarg.0
    IL_038e: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_0393: ldc.i4.0
    IL_0394: callvirt !0 System.Collections.Generic.List<ControlMapButton>::get_Item(int)  /*0x0A0006A0*/
    IL_0399: ldfld TFUITextButton ControlMapButton::target  /*0x040012DA*/
    IL_039e: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_03a3: ldarg.0
    IL_03a4: call !!0 UnityEngine.Component::GetComponentInParent()<UIFrame>  /*0x2B0000F9*/
    IL_03a9: callvirt void UIFrame::RefetchManagedElements()  /*0x060012F7*/
    IL_03ae: ret
    .try IL_0020-IL_0048 finally handler IL_0048-IL_005d
    .try IL_0159-IL_0252 finally handler IL_0252-IL_025e
    .try IL_0135-IL_026c finally handler IL_026c-IL_027a

  .method KeyRebinder::UpdateButtonLabels()  // token 0x06001115 rva 0x4fa24 attrs Public, HideBySig
    // code size 52 (0x34), max stack 1, init locals
    .locals ([0] List.Enumerator<ControlMapButton>)
    IL_0000: ldarg.0
    IL_0001: ldfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<ControlMapButton>::GetEnumerator()  /*0x0A0006A2*/
    IL_000b: stloc.0
    IL_000c: br.s IL_001a
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<ControlMapButton>::get_Current()  /*0x0A0006A3*/
    IL_0015: callvirt void ControlMapButton::Refresh()  /*0x0600100B*/
    IL_001a: ldloca.s 0
    IL_001c: call bool System.Collections.Generic.List.Enumerator<ControlMapButton>::MoveNext()  /*0x0A0006A4*/
    IL_0021: brtrue.s IL_000e
    IL_0023: leave.s IL_0033
    IL_0025: ldloca.s 0
    IL_0027: constrained. System.Collections.Generic.List.Enumerator<ControlMapButton>  /*0x1B000133*/
    IL_002d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0032: endfinally
    IL_0033: ret
    .try IL_000c-IL_0025 finally handler IL_0025-IL_0033

  .method KeyRebinder::OnControllerConnectionChange(Rewired.ControllerStatusChangedEventArgs)  // token 0x06001116 rva 0x4fa74 attrs Public, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void KeyRebinder::RefreshControllerPickOptions()  /*0x06001119*/
    IL_0006: ldarg.0
    IL_0007: call void KeyRebinder::RefreshSelectedJoystickAndLoadMap()  /*0x06001118*/
    IL_000c: ldarg.0
    IL_000d: call void KeyRebinder::UpdateButtonLabels()  /*0x06001115*/
    IL_0012: ret

  .method KeyRebinder::RefreshAllMaps()  // token 0x06001117 rva 0x4fa88 attrs Private, HideBySig
    // code size 176 (0xb0), max stack 2, init locals
    .locals ([0] IEnumerator<ControllerMap>, [1] ControllerMap, [2] ControllerMap)
    IL_0000: ldarg.0
    IL_0001: call Player KeyRebinder::get_player()  /*0x0600110A*/
    IL_0006: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_000b: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_0010: callvirt IEnumerable<ControllerMap> Rewired.Player.ControllerHelper.MapHelper::GetAllMaps()  /*0x0A0003E5*/
    IL_0015: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<Rewired.ControllerMap>::GetEnumerator()  /*0x0A00062A*/
    IL_001a: stloc.0
    IL_001b: br.s IL_0040
    IL_001d: ldloc.0
    IL_001e: callvirt !0 System.Collections.Generic.IEnumerator<Rewired.ControllerMap>::get_Current()  /*0x0A00062B*/
    IL_0023: stloc.1
    IL_0024: ldloc.1
    IL_0025: callvirt Controller Rewired.ControllerMap::get_controller()  /*0x0A0006A5*/
    IL_002a: callvirt ControllerType Rewired.Controller::get_type()  /*0x0A000006*/
    IL_002f: brtrue.s IL_0040
    IL_0031: ldloc.1
    IL_0032: callvirt int Rewired.ControllerMap::get_categoryId()  /*0x0A0003F5*/
    IL_0037: brtrue.s IL_0040
    IL_0039: ldarg.0
    IL_003a: ldloc.1
    IL_003b: stfld ControllerMap KeyRebinder::keyboardMap  /*0x0400145B*/
    IL_0040: ldloc.0
    IL_0041: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0046: brtrue.s IL_001d
    IL_0048: leave.s IL_0054
    IL_004a: ldloc.0
    IL_004b: brfalse.s IL_0053
    IL_004d: ldloc.0
    IL_004e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0053: endfinally
    IL_0054: ldarg.0
    IL_0055: call Player KeyRebinder::get_player()  /*0x0600110A*/
    IL_005a: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_005f: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_0064: callvirt IEnumerable<ControllerMap> Rewired.Player.ControllerHelper.MapHelper::GetAllMaps()  /*0x0A0003E5*/
    IL_0069: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<Rewired.ControllerMap>::GetEnumerator()  /*0x0A00062A*/
    IL_006e: stloc.0
    IL_006f: br.s IL_0095
    IL_0071: ldloc.0
    IL_0072: callvirt !0 System.Collections.Generic.IEnumerator<Rewired.ControllerMap>::get_Current()  /*0x0A00062B*/
    IL_0077: stloc.2
    IL_0078: ldloc.2
    IL_0079: callvirt Controller Rewired.ControllerMap::get_controller()  /*0x0A0006A5*/
    IL_007e: callvirt ControllerType Rewired.Controller::get_type()  /*0x0A000006*/
    IL_0083: ldc.i4.1
    IL_0084: bne.un.s IL_0095
    IL_0086: ldloc.2
    IL_0087: callvirt int Rewired.ControllerMap::get_categoryId()  /*0x0A0003F5*/
    IL_008c: brtrue.s IL_0095
    IL_008e: ldarg.0
    IL_008f: ldloc.2
    IL_0090: stfld ControllerMap KeyRebinder::mouseMap  /*0x0400145C*/
    IL_0095: ldloc.0
    IL_0096: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_009b: brtrue.s IL_0071
    IL_009d: leave.s IL_00a9
    IL_009f: ldloc.0
    IL_00a0: brfalse.s IL_00a8
    IL_00a2: ldloc.0
    IL_00a3: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00a8: endfinally
    IL_00a9: ldarg.0
    IL_00aa: call void KeyRebinder::RefreshSelectedJoystickAndLoadMap()  /*0x06001118*/
    IL_00af: ret
    .try IL_001b-IL_004a finally handler IL_004a-IL_0054
    .try IL_006f-IL_009f finally handler IL_009f-IL_00a9

  .method KeyRebinder::RefreshSelectedJoystickAndLoadMap()  // token 0x06001118 rva 0x4fb60 attrs Private, HideBySig
    // code size 138 (0x8a), max stack 5, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldnull
    IL_0002: stfld Joystick KeyRebinder::selectedJoystick  /*0x0400145A*/
    IL_0007: ldarg.0
    IL_0008: ldfld EnumSelector KeyRebinder::controllerSelector  /*0x04001463*/
    IL_000d: ldnull
    IL_000e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0013: brfalse.s IL_0089
    IL_0015: ldarg.0
    IL_0016: ldfld Dictionary<string, int> KeyRebinder::registeredJoysticks  /*0x04001464*/
    IL_001b: ldarg.0
    IL_001c: ldfld EnumSelector KeyRebinder::controllerSelector  /*0x04001463*/
    IL_0021: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_0026: ldarg.0
    IL_0027: ldfld EnumSelector KeyRebinder::controllerSelector  /*0x04001463*/
    IL_002c: callvirt int EnumSelector::get_Index()  /*0x060010AE*/
    IL_0031: callvirt !0 System.Collections.Generic.List<string>::get_Item(int)  /*0x0A000362*/
    IL_0036: ldloca.s 0
    IL_0038: callvirt bool System.Collections.Generic.Dictionary<string, int>::TryGetValue(!0,ref !1)  /*0x0A0006A6*/
    IL_003d: brfalse.s IL_0089
    IL_003f: ldarg.0
    IL_0040: ldarg.0
    IL_0041: call Player KeyRebinder::get_player()  /*0x0600110A*/
    IL_0046: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_004b: ldloc.0
    IL_004c: callvirt !!0 Rewired.Player.ControllerHelper::GetController(int)<Rewired.Joystick>  /*0x2B0000FA*/
    IL_0051: stfld Joystick KeyRebinder::selectedJoystick  /*0x0400145A*/
    IL_0056: ldarg.0
    IL_0057: ldfld Joystick KeyRebinder::selectedJoystick  /*0x0400145A*/
    IL_005c: brfalse.s IL_0082
    IL_005e: ldarg.0
    IL_005f: ldarg.0
    IL_0060: call Player KeyRebinder::get_player()  /*0x0600110A*/
    IL_0065: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_006a: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_006f: ldarg.0
    IL_0070: ldfld Joystick KeyRebinder::selectedJoystick  /*0x0400145A*/
    IL_0075: ldc.i4.0
    IL_0076: ldc.i4.0
    IL_0077: callvirt ControllerMap Rewired.Player.ControllerHelper.MapHelper::GetMap(Rewired.Controller,int,int)  /*0x0A0006A8*/
    IL_007c: stfld ControllerMap KeyRebinder::joystickMap  /*0x0400145D*/
    IL_0081: ret
    IL_0082: ldarg.0
    IL_0083: ldnull
    IL_0084: stfld ControllerMap KeyRebinder::joystickMap  /*0x0400145D*/
    IL_0089: ret

  .method KeyRebinder::RefreshControllerPickOptions()  // token 0x06001119 rva 0x4fbf8 attrs Private, HideBySig
    // code size 202 (0xca), max stack 9, init locals
    .locals ([0] IEnumerator<Joystick>, [1] Joystick)
    IL_0000: ldarg.0
    IL_0001: ldfld EnumSelector KeyRebinder::controllerSelector  /*0x04001463*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld EnumSelector KeyRebinder::controllerSelector  /*0x04001463*/
    IL_0015: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_001a: callvirt void System.Collections.Generic.List<string>::Clear()  /*0x0A00045B*/
    IL_001f: ldarg.0
    IL_0020: ldfld Dictionary<string, int> KeyRebinder::registeredJoysticks  /*0x04001464*/
    IL_0025: callvirt void System.Collections.Generic.Dictionary<string, int>::Clear()  /*0x0A0006A9*/
    IL_002a: ldarg.0
    IL_002b: call Player KeyRebinder::get_player()  /*0x0600110A*/
    IL_0030: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0035: callvirt int Rewired.Player.ControllerHelper::get_joystickCount()  /*0x0A0006AA*/
    IL_003a: ldc.i4.0
    IL_003b: ble.s IL_009d
    IL_003d: ldarg.0
    IL_003e: call Player KeyRebinder::get_player()  /*0x0600110A*/
    IL_0043: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0048: callvirt IList<Joystick> Rewired.Player.ControllerHelper::get_Joysticks()  /*0x0A0006AB*/
    IL_004d: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<Rewired.Joystick>::GetEnumerator()  /*0x0A0006AC*/
    IL_0052: stloc.0
    IL_0053: br.s IL_0089
    IL_0055: ldloc.0
    IL_0056: callvirt !0 System.Collections.Generic.IEnumerator<Rewired.Joystick>::get_Current()  /*0x0A0006AD*/
    IL_005b: stloc.1
    IL_005c: ldarg.0
    IL_005d: ldfld EnumSelector KeyRebinder::controllerSelector  /*0x04001463*/
    IL_0062: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_0067: ldloc.1
    IL_0068: callvirt string Rewired.Controller::get_name()  /*0x0A0006AE*/
    IL_006d: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0072: ldarg.0
    IL_0073: ldfld Dictionary<string, int> KeyRebinder::registeredJoysticks  /*0x04001464*/
    IL_0078: ldloc.1
    IL_0079: callvirt string Rewired.Controller::get_name()  /*0x0A0006AE*/
    IL_007e: ldloc.1
    IL_007f: ldfld int Rewired.Controller::id  /*0x0A0006AF*/
    IL_0084: callvirt void System.Collections.Generic.Dictionary<string, int>::Add(!0,!1)  /*0x0A0006B0*/
    IL_0089: ldloc.0
    IL_008a: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_008f: brtrue.s IL_0055
    IL_0091: leave.s IL_00be
    IL_0093: ldloc.0
    IL_0094: brfalse.s IL_009c
    IL_0096: ldloc.0
    IL_0097: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_009c: endfinally
    IL_009d: ldarg.0
    IL_009e: ldfld EnumSelector KeyRebinder::controllerSelector  /*0x04001463*/
    IL_00a3: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_00a8: ldstr "Controls/No Controller"
    IL_00ad: ldc.i4.1
    IL_00ae: ldc.i4.0
    IL_00af: ldc.i4.1
    IL_00b0: ldc.i4.0
    IL_00b1: ldnull
    IL_00b2: ldnull
    IL_00b3: ldc.i4.1
    IL_00b4: call string I2.Loc.LocalizationManager::GetTermTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001856*/
    IL_00b9: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_00be: ldarg.0
    IL_00bf: ldfld EnumSelector KeyRebinder::controllerSelector  /*0x04001463*/
    IL_00c4: callvirt void EnumSelector::UpdateDisplay()  /*0x060010B0*/
    IL_00c9: ret
    .try IL_0053-IL_0093 finally handler IL_0093-IL_009d

  .method KeyRebinder::OnControllerSelectionChange()  // token 0x0600111A rva 0x4fce0 attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void KeyRebinder::RefreshSelectedJoystickAndLoadMap()  /*0x06001118*/
    IL_0006: ldarg.0
    IL_0007: call void KeyRebinder::UpdateButtonLabels()  /*0x06001115*/
    IL_000c: ret

  .method KeyRebinder::TriggerRebind(Rewired.InputAction,Rewired.ActionElementMap,Rewired.ActionElementMap,Rewired.ActionElementMap,ControlMapButton.AxisMode)  // token 0x0600111B rva 0x4fcf0 attrs Public, HideBySig
    // code size 72 (0x48), max stack 7, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool KeyRebinder::listening  /*0x0400145E*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.i4.1
    IL_000b: stfld bool KeyRebinder::listening  /*0x0400145E*/
    IL_0010: ldarg.0
    IL_0011: call Player KeyRebinder::get_player()  /*0x0600110A*/
    IL_0016: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_001b: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_0020: ldc.i4.0
    IL_0021: callvirt int Rewired.Player.ControllerHelper.MapHelper::SetAllMapsEnabled(bool)  /*0x0A00062E*/
    IL_0026: pop
    IL_0027: ldarg.0
    IL_0028: ldfld GameObject KeyRebinder::listeningToRemapPopUp  /*0x0400144E*/
    IL_002d: ldc.i4.1
    IL_002e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0033: ldarg.0
    IL_0034: ldarg.0
    IL_0035: ldarg.1
    IL_0036: ldarg.2
    IL_0037: ldarg.3
    IL_0038: ldarg.s 4
    IL_003a: ldarg.s 5
    IL_003c: call IEnumerator KeyRebinder::ListenForRebind(Rewired.InputAction,Rewired.ActionElementMap,Rewired.ActionElementMap,Rewired.ActionElementMap,ControlMapButton.AxisMode)  /*0x0600111C*/
    IL_0041: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0046: pop
    IL_0047: ret

  .method KeyRebinder::ListenForRebind(Rewired.InputAction,Rewired.ActionElementMap,Rewired.ActionElementMap,Rewired.ActionElementMap,ControlMapButton.AxisMode)  // token 0x0600111C rva 0x4fd44 attrs Private, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void KeyRebinder.<ListenForRebind>d__50::.ctor(int)  /*0x06001121*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld KeyRebinder KeyRebinder.<ListenForRebind>d__50::<>4__this  /*0x04001467*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld InputAction KeyRebinder.<ListenForRebind>d__50::actionToMap  /*0x04001469*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld ActionElementMap KeyRebinder.<ListenForRebind>d__50::keyboardMapToReplace  /*0x0400146A*/
    IL_001b: dup
    IL_001c: ldarg.3
    IL_001d: stfld ActionElementMap KeyRebinder.<ListenForRebind>d__50::mouseMapToReplace  /*0x0400146B*/
    IL_0022: dup
    IL_0023: ldarg.s 4
    IL_0025: stfld ActionElementMap KeyRebinder.<ListenForRebind>d__50::joystickMapToReplace  /*0x0400146C*/
    IL_002a: dup
    IL_002b: ldarg.s 5
    IL_002d: stfld ControlMapButton.AxisMode KeyRebinder.<ListenForRebind>d__50::axisMode  /*0x04001468*/
    IL_0032: ret

  .method KeyRebinder::OnInputMapped(Rewired.InputMapper.InputMappedEventData)  // token 0x0600111D rva 0x4fd78 attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool KeyRebinder::mapCallbackRecieved  /*0x0400145F*/
    IL_0007: ret

  .method KeyRebinder::OnBindConflict(Rewired.InputMapper.ConflictFoundEventData)  // token 0x0600111E rva 0x4fd84 attrs Private, HideBySig
    // code size 461 (0x1cd), max stack 2, init locals
    .locals ([0] int, [1] List<int>, [2] int, [3] int, [4] List<int>, [5] List<ElementAssignmentConflictInfo>, [6] IEnumerator<ElementAssignmentConflictInfo>, [7] ElementAssignmentConflictInfo, [8] ElementAssignmentConflictInfo, [9] ElementAssignmentConflictInfo, [10] ElementAssignmentConflictInfo, [11] List.Enumerator<ElementAssignmentConflictInfo>, [12] ElementAssignmentConflictInfo)
    IL_0000: ldarg.0
    IL_0001: call int KeyRebinder::get_GameplayAlwaysCategoryId()  /*0x06001110*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: call List<int> KeyRebinder::get_GameplayNotOverlappingCategoriesIds()  /*0x06001111*/
    IL_000d: stloc.1
    IL_000e: ldarg.0
    IL_000f: call int KeyRebinder::get_UICategoryId()  /*0x0600110F*/
    IL_0014: stloc.2
    IL_0015: ldarg.1
    IL_0016: ldfld ElementAssignmentInfo Rewired.InputMapper.ConflictFoundEventData::assignment  /*0x0A0006B1*/
    IL_001b: callvirt InputAction Rewired.ElementAssignmentInfo::get_action()  /*0x0A0006B2*/
    IL_0020: callvirt int Rewired.InputAction::get_categoryId()  /*0x0A0006B3*/
    IL_0025: stloc.3
    IL_0026: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_002b: stloc.s 4
    IL_002d: ldarg.1
    IL_002e: ldfld IList<ElementAssignmentConflictInfo> Rewired.InputMapper.ConflictFoundEventData::conflicts  /*0x0A0006B4*/
    IL_0033: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<Rewired.ElementAssignmentConflictInfo>::GetEnumerator()  /*0x0A0006B5*/
    IL_0038: stloc.s 6
    IL_003a: br.s IL_0058
    IL_003c: ldloc.s 6
    IL_003e: callvirt !0 System.Collections.Generic.IEnumerator<Rewired.ElementAssignmentConflictInfo>::get_Current()  /*0x0A0006B6*/
    IL_0043: stloc.s 7
    IL_0045: ldloc.s 4
    IL_0047: ldloca.s 7
    IL_0049: call InputAction Rewired.ElementAssignmentConflictInfo::get_action()  /*0x0A0006B7*/
    IL_004e: callvirt int Rewired.InputAction::get_categoryId()  /*0x0A0006B3*/
    IL_0053: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0058: ldloc.s 6
    IL_005a: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_005f: brtrue.s IL_003c
    IL_0061: leave.s IL_006f
    IL_0063: ldloc.s 6
    IL_0065: brfalse.s IL_006e
    IL_0067: ldloc.s 6
    IL_0069: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_006e: endfinally
    IL_006f: newobj void System.Collections.Generic.List<Rewired.ElementAssignmentConflictInfo>::.ctor()  /*0x0A0006B8*/
    IL_0074: stloc.s 5
    IL_0076: ldloc.3
    IL_0077: ldloc.0
    IL_0078: bne.un.s IL_00d5
    IL_007a: ldarg.1
    IL_007b: ldfld IList<ElementAssignmentConflictInfo> Rewired.InputMapper.ConflictFoundEventData::conflicts  /*0x0A0006B4*/
    IL_0080: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<Rewired.ElementAssignmentConflictInfo>::GetEnumerator()  /*0x0A0006B5*/
    IL_0085: stloc.s 6
    IL_0087: br.s IL_00be
    IL_0089: ldloc.s 6
    IL_008b: callvirt !0 System.Collections.Generic.IEnumerator<Rewired.ElementAssignmentConflictInfo>::get_Current()  /*0x0A0006B6*/
    IL_0090: stloc.s 8
    IL_0092: ldloca.s 8
    IL_0094: call InputAction Rewired.ElementAssignmentConflictInfo::get_action()  /*0x0A0006B7*/
    IL_0099: callvirt int Rewired.InputAction::get_categoryId()  /*0x0A0006B3*/
    IL_009e: ldloc.3
    IL_009f: beq.s IL_00b5
    IL_00a1: ldloc.1
    IL_00a2: ldloca.s 8
    IL_00a4: call InputAction Rewired.ElementAssignmentConflictInfo::get_action()  /*0x0A0006B7*/
    IL_00a9: callvirt int Rewired.InputAction::get_categoryId()  /*0x0A0006B3*/
    IL_00ae: callvirt bool System.Collections.Generic.List<int>::Contains(!0)  /*0x0A000123*/
    IL_00b3: brfalse.s IL_00be
    IL_00b5: ldloc.s 5
    IL_00b7: ldloc.s 8
    IL_00b9: callvirt void System.Collections.Generic.List<Rewired.ElementAssignmentConflictInfo>::Add(!0)  /*0x0A0006B9*/
    IL_00be: ldloc.s 6
    IL_00c0: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_00c5: brtrue.s IL_0089
    IL_00c7: leave.s IL_0134
    IL_00c9: ldloc.s 6
    IL_00cb: brfalse.s IL_00d4
    IL_00cd: ldloc.s 6
    IL_00cf: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00d4: endfinally
    IL_00d5: ldloc.1
    IL_00d6: ldloc.3
    IL_00d7: callvirt bool System.Collections.Generic.List<int>::Contains(!0)  /*0x0A000123*/
    IL_00dc: brfalse.s IL_0134
    IL_00de: ldarg.1
    IL_00df: ldfld IList<ElementAssignmentConflictInfo> Rewired.InputMapper.ConflictFoundEventData::conflicts  /*0x0A0006B4*/
    IL_00e4: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<Rewired.ElementAssignmentConflictInfo>::GetEnumerator()  /*0x0A0006B5*/
    IL_00e9: stloc.s 6
    IL_00eb: br.s IL_011d
    IL_00ed: ldloc.s 6
    IL_00ef: callvirt !0 System.Collections.Generic.IEnumerator<Rewired.ElementAssignmentConflictInfo>::get_Current()  /*0x0A0006B6*/
    IL_00f4: stloc.s 9
    IL_00f6: ldloca.s 9
    IL_00f8: call InputAction Rewired.ElementAssignmentConflictInfo::get_action()  /*0x0A0006B7*/
    IL_00fd: callvirt int Rewired.InputAction::get_categoryId()  /*0x0A0006B3*/
    IL_0102: ldloc.3
    IL_0103: beq.s IL_0114
    IL_0105: ldloca.s 9
    IL_0107: call InputAction Rewired.ElementAssignmentConflictInfo::get_action()  /*0x0A0006B7*/
    IL_010c: callvirt int Rewired.InputAction::get_categoryId()  /*0x0A0006B3*/
    IL_0111: ldloc.0
    IL_0112: bne.un.s IL_011d
    IL_0114: ldloc.s 5
    IL_0116: ldloc.s 9
    IL_0118: callvirt void System.Collections.Generic.List<Rewired.ElementAssignmentConflictInfo>::Add(!0)  /*0x0A0006B9*/
    IL_011d: ldloc.s 6
    IL_011f: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0124: brtrue.s IL_00ed
    IL_0126: leave.s IL_0134
    IL_0128: ldloc.s 6
    IL_012a: brfalse.s IL_0133
    IL_012c: ldloc.s 6
    IL_012e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0133: endfinally
    IL_0134: ldloc.3
    IL_0135: ldloc.2
    IL_0136: bne.un.s IL_017f
    IL_0138: ldarg.1
    IL_0139: ldfld IList<ElementAssignmentConflictInfo> Rewired.InputMapper.ConflictFoundEventData::conflicts  /*0x0A0006B4*/
    IL_013e: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<Rewired.ElementAssignmentConflictInfo>::GetEnumerator()  /*0x0A0006B5*/
    IL_0143: stloc.s 6
    IL_0145: br.s IL_0168
    IL_0147: ldloc.s 6
    IL_0149: callvirt !0 System.Collections.Generic.IEnumerator<Rewired.ElementAssignmentConflictInfo>::get_Current()  /*0x0A0006B6*/
    IL_014e: stloc.s 10
    IL_0150: ldloca.s 10
    IL_0152: call InputAction Rewired.ElementAssignmentConflictInfo::get_action()  /*0x0A0006B7*/
    IL_0157: callvirt int Rewired.InputAction::get_categoryId()  /*0x0A0006B3*/
    IL_015c: ldloc.2
    IL_015d: bne.un.s IL_0168
    IL_015f: ldloc.s 5
    IL_0161: ldloc.s 10
    IL_0163: callvirt void System.Collections.Generic.List<Rewired.ElementAssignmentConflictInfo>::Add(!0)  /*0x0A0006B9*/
    IL_0168: ldloc.s 6
    IL_016a: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_016f: brtrue.s IL_0147
    IL_0171: leave.s IL_017f
    IL_0173: ldloc.s 6
    IL_0175: brfalse.s IL_017e
    IL_0177: ldloc.s 6
    IL_0179: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_017e: endfinally
    IL_017f: ldloc.s 5
    IL_0181: callvirt List.Enumerator<!0> System.Collections.Generic.List<Rewired.ElementAssignmentConflictInfo>::GetEnumerator()  /*0x0A0006BA*/
    IL_0186: stloc.s 11
    IL_0188: br.s IL_01a7
    IL_018a: ldloca.s 11
    IL_018c: call !0 System.Collections.Generic.List.Enumerator<Rewired.ElementAssignmentConflictInfo>::get_Current()  /*0x0A0006BB*/
    IL_0191: stloc.s 12
    IL_0193: ldloca.s 12
    IL_0195: call ControllerMap Rewired.ElementAssignmentConflictInfo::get_controllerMap()  /*0x0A0006BC*/
    IL_019a: ldloca.s 12
    IL_019c: call int Rewired.ElementAssignmentConflictInfo::get_elementMapId()  /*0x0A0006BD*/
    IL_01a1: callvirt bool Rewired.ControllerMap::DeleteElementMap(int)  /*0x0A0006BE*/
    IL_01a6: pop
    IL_01a7: ldloca.s 11
    IL_01a9: call bool System.Collections.Generic.List.Enumerator<Rewired.ElementAssignmentConflictInfo>::MoveNext()  /*0x0A0006BF*/
    IL_01ae: brtrue.s IL_018a
    IL_01b0: leave.s IL_01c0
    IL_01b2: ldloca.s 11
    IL_01b4: constrained. System.Collections.Generic.List.Enumerator<Rewired.ElementAssignmentConflictInfo>  /*0x1B00013A*/
    IL_01ba: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01bf: endfinally
    IL_01c0: ldarg.1
    IL_01c1: ldfld Action<InputMapper.ConflictResponse> Rewired.InputMapper.ConflictFoundEventData::responseCallback  /*0x0A0006C0*/
    IL_01c6: ldc.i4.2
    IL_01c7: callvirt void System.Action<Rewired.InputMapper.ConflictResponse>::Invoke(!0)  /*0x0A0006C1*/
    IL_01cc: ret
    .try IL_003a-IL_0063 finally handler IL_0063-IL_006f
    .try IL_0087-IL_00c9 finally handler IL_00c9-IL_00d5
    .try IL_00eb-IL_0128 finally handler IL_0128-IL_0134
    .try IL_0145-IL_0173 finally handler IL_0173-IL_017f
    .try IL_0188-IL_01b2 finally handler IL_01b2-IL_01c0

  .method KeyRebinder::TriggerControlsReset()  // token 0x0600111F rva 0x4ffa0 attrs Public, HideBySig
    // code size 84 (0x54), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: call Player KeyRebinder::get_player()  /*0x0600110A*/
    IL_0006: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_000b: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_0010: ldc.i4.1
    IL_0011: callvirt void Rewired.Player.ControllerHelper.MapHelper::LoadDefaultMaps(Rewired.ControllerType)  /*0x0A0006C2*/
    IL_0016: ldarg.0
    IL_0017: call Player KeyRebinder::get_player()  /*0x0600110A*/
    IL_001c: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0021: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_0026: ldc.i4.0
    IL_0027: callvirt void Rewired.Player.ControllerHelper.MapHelper::LoadDefaultMaps(Rewired.ControllerType)  /*0x0A0006C2*/
    IL_002c: ldarg.0
    IL_002d: call Player KeyRebinder::get_player()  /*0x0600110A*/
    IL_0032: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0037: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_003c: ldc.i4.2
    IL_003d: callvirt void Rewired.Player.ControllerHelper.MapHelper::LoadDefaultMaps(Rewired.ControllerType)  /*0x0A0006C2*/
    IL_0042: call void ControlConfigSaveLoad::SaveControlConfigToJson()  /*0x0600092D*/
    IL_0047: ldarg.0
    IL_0048: call void KeyRebinder::RefreshAllMaps()  /*0x06001117*/
    IL_004d: ldarg.0
    IL_004e: call void KeyRebinder::UpdateButtonLabels()  /*0x06001115*/
    IL_0053: ret

  .method KeyRebinder::.ctor()  // token 0x06001120 rva 0x50000 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 68 (0x44), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_0006: stfld List<string> KeyRebinder::actionCategoriesToShow  /*0x0400144D*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<ControlMapButton>::.ctor()  /*0x0A0006C3*/
    IL_0011: stfld List<ControlMapButton> KeyRebinder::buttons  /*0x04001456*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.2
    IL_0018: newarr System.String  /*0x0100001D*/
    IL_001d: dup
    IL_001e: ldc.i4.0
    IL_001f: ldstr "Gameplay Day"
    IL_0024: stelem.ref
    IL_0025: dup
    IL_0026: ldc.i4.1
    IL_0027: ldstr "Gameplay Night"
    IL_002c: stelem.ref
    IL_002d: stfld string[] KeyRebinder::gameplayNotOverlappingCategories  /*0x04001462*/
    IL_0032: ldarg.0
    IL_0033: newobj void System.Collections.Generic.Dictionary<string, int>::.ctor()  /*0x0A0006C4*/
    IL_0038: stfld Dictionary<string, int> KeyRebinder::registeredJoysticks  /*0x04001464*/
    IL_003d: ldarg.0
    IL_003e: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0043: ret

// ===== KeyRebinder/<ListenForRebind>d__50  (token 0x0200031B) =====
  .method KeyRebinder.<ListenForRebind>d__50::.ctor(int)  // token 0x06001121 rva 0x50050 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int KeyRebinder.<ListenForRebind>d__50::<>1__state  /*0x04001465*/
    IL_000d: ret

  .method KeyRebinder.<ListenForRebind>d__50::System.IDisposable.Dispose()  // token 0x06001122 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method KeyRebinder.<ListenForRebind>d__50::MoveNext()  // token 0x06001123 rva 0x50060 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 764 (0x2fc), max stack 4, init locals
    .locals ([0] int, [1] KeyRebinder, [2] AxisRange, [3] IEnumerator<AxisCalibration>, [4] AxisCalibration, [5] int, [6] AxisCalibration, [7] float)
    IL_0000: ldarg.0
    IL_0001: ldfld int KeyRebinder.<ListenForRebind>d__50::<>1__state  /*0x04001465*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld KeyRebinder KeyRebinder.<ListenForRebind>d__50::<>4__this  /*0x04001467*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0026, IL_0046, IL_01f1, IL_02d0)
    IL_0024: ldc.i4.0
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldc.i4.m1
    IL_0028: stfld int KeyRebinder.<ListenForRebind>d__50::<>1__state  /*0x04001465*/
    IL_002d: ldarg.0
    IL_002e: ldc.r4 0.1f
    IL_0033: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0038: stfld object KeyRebinder.<ListenForRebind>d__50::<>2__current  /*0x04001466*/
    IL_003d: ldarg.0
    IL_003e: ldc.i4.1
    IL_003f: stfld int KeyRebinder.<ListenForRebind>d__50::<>1__state  /*0x04001465*/
    IL_0044: ldc.i4.1
    IL_0045: ret
    IL_0046: ldarg.0
    IL_0047: ldc.i4.m1
    IL_0048: stfld int KeyRebinder.<ListenForRebind>d__50::<>1__state  /*0x04001465*/
    IL_004d: ldloc.1
    IL_004e: ldc.i4.0
    IL_004f: stfld bool KeyRebinder::mapCallbackRecieved  /*0x0400145F*/
    IL_0054: ldarg.0
    IL_0055: newobj void System.Collections.Generic.Dictionary<Rewired.AxisCalibration, float>::.ctor()  /*0x0A0006C5*/
    IL_005a: stfld Dictionary<AxisCalibration, float> KeyRebinder.<ListenForRebind>d__50::<modifiedAxes>5__2  /*0x0400146D*/
    IL_005f: ldloc.1
    IL_0060: ldfld Joystick KeyRebinder::selectedJoystick  /*0x0400145A*/
    IL_0065: brfalse.s IL_00bb
    IL_0067: ldloc.1
    IL_0068: ldfld Joystick KeyRebinder::selectedJoystick  /*0x0400145A*/
    IL_006d: callvirt CalibrationMap Rewired.ControllerWithAxes::get_calibrationMap()  /*0x0A0006C6*/
    IL_0072: callvirt IList<AxisCalibration> Rewired.CalibrationMap::get_Axes()  /*0x0A0006C7*/
    IL_0077: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<Rewired.AxisCalibration>::GetEnumerator()  /*0x0A0006C8*/
    IL_007c: stloc.3
    IL_007d: br.s IL_00a7
    IL_007f: ldloc.3
    IL_0080: callvirt !0 System.Collections.Generic.IEnumerator<Rewired.AxisCalibration>::get_Current()  /*0x0A0006C9*/
    IL_0085: stloc.s 4
    IL_0087: ldarg.0
    IL_0088: ldfld Dictionary<AxisCalibration, float> KeyRebinder.<ListenForRebind>d__50::<modifiedAxes>5__2  /*0x0400146D*/
    IL_008d: ldloc.s 4
    IL_008f: ldloc.s 4
    IL_0091: callvirt float Rewired.AxisCalibration::get_deadZone()  /*0x0A0006CA*/
    IL_0096: callvirt void System.Collections.Generic.Dictionary<Rewired.AxisCalibration, float>::Add(!0,!1)  /*0x0A0006CB*/
    IL_009b: ldloc.s 4
    IL_009d: ldc.r4 0.75f
    IL_00a2: callvirt void Rewired.AxisCalibration::set_deadZone(float)  /*0x0A0006CC*/
    IL_00a7: ldloc.3
    IL_00a8: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_00ad: brtrue.s IL_007f
    IL_00af: leave.s IL_00bb
    IL_00b1: ldloc.3
    IL_00b2: brfalse.s IL_00ba
    IL_00b4: ldloc.3
    IL_00b5: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00ba: endfinally
    IL_00bb: ldc.i4.1
    IL_00bc: stloc.2
    IL_00bd: ldarg.0
    IL_00be: ldfld ControlMapButton.AxisMode KeyRebinder.<ListenForRebind>d__50::axisMode  /*0x04001468*/
    IL_00c3: ldc.i4.1
    IL_00c4: bne.un.s IL_00ca
    IL_00c6: ldc.i4.1
    IL_00c7: stloc.2
    IL_00c8: br.s IL_00d5
    IL_00ca: ldarg.0
    IL_00cb: ldfld ControlMapButton.AxisMode KeyRebinder.<ListenForRebind>d__50::axisMode  /*0x04001468*/
    IL_00d0: ldc.i4.2
    IL_00d1: bne.un.s IL_00d5
    IL_00d3: ldc.i4.2
    IL_00d4: stloc.2
    IL_00d5: ldloc.1
    IL_00d6: ldfld ControllerMap KeyRebinder::keyboardMap  /*0x0400145B*/
    IL_00db: brfalse.s IL_011e
    IL_00dd: ldloc.1
    IL_00de: ldfld InputMapper KeyRebinder::keyboardMapper  /*0x04001457*/
    IL_00e3: newobj void Rewired.InputMapper.Context::.ctor()  /*0x0A0006CD*/
    IL_00e8: dup
    IL_00e9: ldarg.0
    IL_00ea: ldfld InputAction KeyRebinder.<ListenForRebind>d__50::actionToMap  /*0x04001469*/
    IL_00ef: callvirt int Rewired.InputAction::get_id()  /*0x0A0003F3*/
    IL_00f4: callvirt void Rewired.InputMapper.Context::set_actionId(int)  /*0x0A0006CE*/
    IL_00f9: dup
    IL_00fa: ldloc.1
    IL_00fb: ldfld ControllerMap KeyRebinder::keyboardMap  /*0x0400145B*/
    IL_0100: callvirt void Rewired.InputMapper.Context::set_controllerMap(Rewired.ControllerMap)  /*0x0A0006CF*/
    IL_0105: dup
    IL_0106: ldloc.2
    IL_0107: callvirt void Rewired.InputMapper.Context::set_actionRange(Rewired.AxisRange)  /*0x0A0006D0*/
    IL_010c: dup
    IL_010d: ldarg.0
    IL_010e: ldfld ActionElementMap KeyRebinder.<ListenForRebind>d__50::keyboardMapToReplace  /*0x0400146A*/
    IL_0113: callvirt void Rewired.InputMapper.Context::set_actionElementMapToReplace(Rewired.ActionElementMap)  /*0x0A0006D1*/
    IL_0118: callvirt bool Rewired.InputMapper::Start(Rewired.InputMapper.Context)  /*0x0A0006D2*/
    IL_011d: pop
    IL_011e: ldloc.1
    IL_011f: ldfld ControllerMap KeyRebinder::mouseMap  /*0x0400145C*/
    IL_0124: brfalse.s IL_0167
    IL_0126: ldloc.1
    IL_0127: ldfld InputMapper KeyRebinder::mouseMapper  /*0x04001458*/
    IL_012c: newobj void Rewired.InputMapper.Context::.ctor()  /*0x0A0006CD*/
    IL_0131: dup
    IL_0132: ldarg.0
    IL_0133: ldfld InputAction KeyRebinder.<ListenForRebind>d__50::actionToMap  /*0x04001469*/
    IL_0138: callvirt int Rewired.InputAction::get_id()  /*0x0A0003F3*/
    IL_013d: callvirt void Rewired.InputMapper.Context::set_actionId(int)  /*0x0A0006CE*/
    IL_0142: dup
    IL_0143: ldloc.1
    IL_0144: ldfld ControllerMap KeyRebinder::mouseMap  /*0x0400145C*/
    IL_0149: callvirt void Rewired.InputMapper.Context::set_controllerMap(Rewired.ControllerMap)  /*0x0A0006CF*/
    IL_014e: dup
    IL_014f: ldloc.2
    IL_0150: callvirt void Rewired.InputMapper.Context::set_actionRange(Rewired.AxisRange)  /*0x0A0006D0*/
    IL_0155: dup
    IL_0156: ldarg.0
    IL_0157: ldfld ActionElementMap KeyRebinder.<ListenForRebind>d__50::mouseMapToReplace  /*0x0400146B*/
    IL_015c: callvirt void Rewired.InputMapper.Context::set_actionElementMapToReplace(Rewired.ActionElementMap)  /*0x0A0006D1*/
    IL_0161: callvirt bool Rewired.InputMapper::Start(Rewired.InputMapper.Context)  /*0x0A0006D2*/
    IL_0166: pop
    IL_0167: ldloc.1
    IL_0168: ldfld ControllerMap KeyRebinder::joystickMap  /*0x0400145D*/
    IL_016d: brfalse IL_01f8
    IL_0172: ldloc.1
    IL_0173: ldfld InputMapper KeyRebinder::joystickMapper  /*0x04001459*/
    IL_0178: newobj void Rewired.InputMapper.Context::.ctor()  /*0x0A0006CD*/
    IL_017d: dup
    IL_017e: ldarg.0
    IL_017f: ldfld InputAction KeyRebinder.<ListenForRebind>d__50::actionToMap  /*0x04001469*/
    IL_0184: callvirt int Rewired.InputAction::get_id()  /*0x0A0003F3*/
    IL_0189: callvirt void Rewired.InputMapper.Context::set_actionId(int)  /*0x0A0006CE*/
    IL_018e: dup
    IL_018f: ldloc.1
    IL_0190: ldfld ControllerMap KeyRebinder::joystickMap  /*0x0400145D*/
    IL_0195: callvirt void Rewired.InputMapper.Context::set_controllerMap(Rewired.ControllerMap)  /*0x0A0006CF*/
    IL_019a: dup
    IL_019b: ldloc.2
    IL_019c: callvirt void Rewired.InputMapper.Context::set_actionRange(Rewired.AxisRange)  /*0x0A0006D0*/
    IL_01a1: dup
    IL_01a2: ldarg.0
    IL_01a3: ldfld ActionElementMap KeyRebinder.<ListenForRebind>d__50::joystickMapToReplace  /*0x0400146C*/
    IL_01a8: callvirt void Rewired.InputMapper.Context::set_actionElementMapToReplace(Rewired.ActionElementMap)  /*0x0A0006D1*/
    IL_01ad: callvirt bool Rewired.InputMapper::Start(Rewired.InputMapper.Context)  /*0x0A0006D2*/
    IL_01b2: pop
    IL_01b3: br.s IL_01f8
    IL_01b5: ldloc.1
    IL_01b6: ldfld TextMeshProUGUI KeyRebinder::remapListenTimerText  /*0x04001455*/
    IL_01bb: ldloc.1
    IL_01bc: ldfld InputMapper KeyRebinder::keyboardMapper  /*0x04001457*/
    IL_01c1: callvirt float Rewired.InputMapper::get_timeRemaining()  /*0x0A0006D3*/
    IL_01c6: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_01cb: stloc.s 5
    IL_01cd: ldloca.s 5
    IL_01cf: call string System.Int32::ToString()  /*0x0A000031*/
    IL_01d4: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_01d9: ldloc.1
    IL_01da: ldfld bool KeyRebinder::mapCallbackRecieved  /*0x0400145F*/
    IL_01df: brtrue.s IL_022e
    IL_01e1: ldarg.0
    IL_01e2: ldnull
    IL_01e3: stfld object KeyRebinder.<ListenForRebind>d__50::<>2__current  /*0x04001466*/
    IL_01e8: ldarg.0
    IL_01e9: ldc.i4.2
    IL_01ea: stfld int KeyRebinder.<ListenForRebind>d__50::<>1__state  /*0x04001465*/
    IL_01ef: ldc.i4.1
    IL_01f0: ret
    IL_01f1: ldarg.0
    IL_01f2: ldc.i4.m1
    IL_01f3: stfld int KeyRebinder.<ListenForRebind>d__50::<>1__state  /*0x04001465*/
    IL_01f8: ldloc.1
    IL_01f9: ldfld InputMapper KeyRebinder::keyboardMapper  /*0x04001457*/
    IL_01fe: callvirt float Rewired.InputMapper::get_timeRemaining()  /*0x0A0006D3*/
    IL_0203: ldc.r4 0f
    IL_0208: bgt.s IL_01b5
    IL_020a: ldloc.1
    IL_020b: ldfld InputMapper KeyRebinder::joystickMapper  /*0x04001459*/
    IL_0210: callvirt float Rewired.InputMapper::get_timeRemaining()  /*0x0A0006D3*/
    IL_0215: ldc.r4 0f
    IL_021a: bgt.s IL_01b5
    IL_021c: ldloc.1
    IL_021d: ldfld InputMapper KeyRebinder::mouseMapper  /*0x04001458*/
    IL_0222: callvirt float Rewired.InputMapper::get_timeRemaining()  /*0x0A0006D3*/
    IL_0227: ldc.r4 0f
    IL_022c: bgt.s IL_01b5
    IL_022e: ldloc.1
    IL_022f: ldfld InputMapper KeyRebinder::keyboardMapper  /*0x04001457*/
    IL_0234: callvirt void Rewired.InputMapper::Stop()  /*0x0A0006D4*/
    IL_0239: ldloc.1
    IL_023a: ldfld InputMapper KeyRebinder::mouseMapper  /*0x04001458*/
    IL_023f: callvirt void Rewired.InputMapper::Stop()  /*0x0A0006D4*/
    IL_0244: ldloc.1
    IL_0245: ldfld InputMapper KeyRebinder::joystickMapper  /*0x04001459*/
    IL_024a: callvirt void Rewired.InputMapper::Stop()  /*0x0A0006D4*/
    IL_024f: ldloc.1
    IL_0250: ldfld GameObject KeyRebinder::listeningToRemapPopUp  /*0x0400144E*/
    IL_0255: ldc.i4.0
    IL_0256: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_025b: ldloc.1
    IL_025c: call void KeyRebinder::UpdateButtonLabels()  /*0x06001115*/
    IL_0261: ldloc.1
    IL_0262: ldfld Joystick KeyRebinder::selectedJoystick  /*0x0400145A*/
    IL_0267: brfalse.s IL_02b7
    IL_0269: ldloc.1
    IL_026a: ldfld Joystick KeyRebinder::selectedJoystick  /*0x0400145A*/
    IL_026f: callvirt CalibrationMap Rewired.ControllerWithAxes::get_calibrationMap()  /*0x0A0006C6*/
    IL_0274: callvirt IList<AxisCalibration> Rewired.CalibrationMap::get_Axes()  /*0x0A0006C7*/
    IL_0279: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<Rewired.AxisCalibration>::GetEnumerator()  /*0x0A0006C8*/
    IL_027e: stloc.3
    IL_027f: br.s IL_02a3
    IL_0281: ldloc.3
    IL_0282: callvirt !0 System.Collections.Generic.IEnumerator<Rewired.AxisCalibration>::get_Current()  /*0x0A0006C9*/
    IL_0287: stloc.s 6
    IL_0289: ldarg.0
    IL_028a: ldfld Dictionary<AxisCalibration, float> KeyRebinder.<ListenForRebind>d__50::<modifiedAxes>5__2  /*0x0400146D*/
    IL_028f: ldloc.s 6
    IL_0291: ldloca.s 7
    IL_0293: callvirt bool System.Collections.Generic.Dictionary<Rewired.AxisCalibration, float>::TryGetValue(!0,ref !1)  /*0x0A0006D5*/
    IL_0298: brfalse.s IL_02a3
    IL_029a: ldloc.s 6
    IL_029c: ldloc.s 7
    IL_029e: callvirt void Rewired.AxisCalibration::set_deadZone(float)  /*0x0A0006CC*/
    IL_02a3: ldloc.3
    IL_02a4: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_02a9: brtrue.s IL_0281
    IL_02ab: leave.s IL_02b7
    IL_02ad: ldloc.3
    IL_02ae: brfalse.s IL_02b6
    IL_02b0: ldloc.3
    IL_02b1: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_02b6: endfinally
    IL_02b7: ldarg.0
    IL_02b8: ldc.r4 0.1f
    IL_02bd: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_02c2: stfld object KeyRebinder.<ListenForRebind>d__50::<>2__current  /*0x04001466*/
    IL_02c7: ldarg.0
    IL_02c8: ldc.i4.3
    IL_02c9: stfld int KeyRebinder.<ListenForRebind>d__50::<>1__state  /*0x04001465*/
    IL_02ce: ldc.i4.1
    IL_02cf: ret
    IL_02d0: ldarg.0
    IL_02d1: ldc.i4.m1
    IL_02d2: stfld int KeyRebinder.<ListenForRebind>d__50::<>1__state  /*0x04001465*/
    IL_02d7: ldloc.1
    IL_02d8: ldc.i4.0
    IL_02d9: stfld bool KeyRebinder::listening  /*0x0400145E*/
    IL_02de: ldloc.1
    IL_02df: call Player KeyRebinder::get_player()  /*0x0600110A*/
    IL_02e4: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_02e9: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_02ee: ldc.i4.1
    IL_02ef: callvirt int Rewired.Player.ControllerHelper.MapHelper::SetAllMapsEnabled(bool)  /*0x0A00062E*/
    IL_02f4: pop
    IL_02f5: call void ControlConfigSaveLoad::SaveControlConfigToJson()  /*0x0600092D*/
    IL_02fa: ldc.i4.0
    IL_02fb: ret
    .try IL_007d-IL_00b1 finally handler IL_00b1-IL_00bb
    .try IL_027f-IL_02ad finally handler IL_02ad-IL_02b7

  .method KeyRebinder.<ListenForRebind>d__50::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06001124 rva 0x50384 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object KeyRebinder.<ListenForRebind>d__50::<>2__current  /*0x04001466*/
    IL_0006: ret

  .method KeyRebinder.<ListenForRebind>d__50::System.Collections.IEnumerator.Reset()  // token 0x06001125 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method KeyRebinder.<ListenForRebind>d__50::System.Collections.IEnumerator.get_Current()  // token 0x06001126 rva 0x50384 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object KeyRebinder.<ListenForRebind>d__50::<>2__current  /*0x04001466*/
    IL_0006: ret

