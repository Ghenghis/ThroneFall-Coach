// ===== ControlConfigSaveLoad  (token 0x020001C7) =====
  .method ControlConfigSaveLoad::get_SavePath()  // token 0x0600092C rva 0x2ba5c attrs Private, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldstr "ControlsConfig_v2.json"
    IL_0005: ret

  .method ControlConfigSaveLoad::SaveControlConfigToJson()  // token 0x0600092D rva 0x2ba64 attrs Public, Static, HideBySig
    // code size 102 (0x66), max stack 3, init locals
    .locals ([0] Player, [1] string)
    IL_0000: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0005: ldc.i4.0
    IL_0006: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_000b: stloc.0
    IL_000c: newobj void ControlConfig::.ctor()  /*0x06000932*/
    IL_0011: dup
    IL_0012: ldloc.0
    IL_0013: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0018: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_001d: callvirt IEnumerable<ControllerMap> Rewired.Player.ControllerHelper.MapHelper::GetAllMaps()  /*0x0A0003E5*/
    IL_0022: newobj void System.Collections.Generic.List<Rewired.ControllerMap>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0003E6*/
    IL_0027: callvirt void ControlConfig::Initialize(System.Collections.Generic.List<Rewired.ControllerMap>)  /*0x06000931*/
    IL_002c: call string UnityEngine.JsonUtility::ToJson(object)  /*0x0A0002D4*/
    IL_0031: stloc.1
    IL_0032: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0037: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_003c: call string ControlConfigSaveLoad::get_SavePath()  /*0x0600092C*/
    IL_0041: callvirt string Thronefall.SaveServices.ISaveServices::GetFullSavePath(string)  /*0x06003DE1*/
    IL_0046: ldloc.1
    IL_0047: callvirt void Thronefall.SaveServices.ISaveServices::WriteAllText(string,string)  /*0x06003DDB*/
    IL_004c: ldstr "Control Config successfully saved."
    IL_0051: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_0056: leave.s IL_0065
    IL_0058: pop
    IL_0059: ldstr "There has been an error while trying to save the control config."
    IL_005e: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0063: leave.s IL_0065
    IL_0065: ret
    .try IL_0000-IL_0058 catch System.Object handler IL_0058-IL_0065

  .method ControlConfigSaveLoad::LoadControlConfigFromJson()  // token 0x0600092E rva 0x2bae8 attrs Public, Static, HideBySig
    // code size 254 (0xfe), max stack 4, init locals
    .locals ([0] Player, [1] List<int>, [2] List.Enumerator<ControlConfig.ControllerData>, [3] ControlConfig.ControllerData, [4] Controller, [5] ControllerMap)
    IL_0000: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0005: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_000a: call string ControlConfigSaveLoad::get_SavePath()  /*0x0600092C*/
    IL_000f: callvirt string Thronefall.SaveServices.ISaveServices::GetFullSavePath(string)  /*0x06003DE1*/
    IL_0014: callvirt bool Thronefall.SaveServices.ISaveServices::Exists(string)  /*0x06003DD8*/
    IL_0019: brfalse IL_00ee
    IL_001e: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0023: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0028: call string ControlConfigSaveLoad::get_SavePath()  /*0x0600092C*/
    IL_002d: callvirt string Thronefall.SaveServices.ISaveServices::GetFullSavePath(string)  /*0x06003DE1*/
    IL_0032: callvirt string Thronefall.SaveServices.ISaveServices::ReadAllText(string)  /*0x06003DDE*/
    IL_0037: call !!0 UnityEngine.JsonUtility::FromJson(string)<ControlConfig>  /*0x2B000099*/
    IL_003c: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0041: ldc.i4.0
    IL_0042: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_0047: stloc.0
    IL_0048: call List<int> ControlConfigSaveLoad::GetAllKnownActionIDs()  /*0x0600092F*/
    IL_004d: stloc.1
    IL_004e: ldfld List<ControlConfig.ControllerData> ControlConfig::controllerDataSet  /*0x04000B99*/
    IL_0053: callvirt List.Enumerator<!0> System.Collections.Generic.List<ControlConfig.ControllerData>::GetEnumerator()  /*0x0A0003E7*/
    IL_0058: stloc.2
    IL_0059: br.s IL_00cb
    IL_005b: ldloca.s 2
    IL_005d: call !0 System.Collections.Generic.List.Enumerator<ControlConfig.ControllerData>::get_Current()  /*0x0A0003E8*/
    IL_0062: stloc.3
    IL_0063: call ReInput.ControllerHelper Rewired.ReInput::get_controllers()  /*0x0A0003E9*/
    IL_0068: ldloc.3
    IL_0069: ldfld ControllerType ControlConfig.ControllerData::controllerType  /*0x04000B9A*/
    IL_006e: ldloc.3
    IL_006f: ldfld int ControlConfig.ControllerData::controllerId  /*0x04000B9B*/
    IL_0074: callvirt Controller Rewired.ReInput.ControllerHelper::GetController(Rewired.ControllerType,int)  /*0x0A0003EA*/
    IL_0079: stloc.s 4
    IL_007b: ldloc.s 4
    IL_007d: brfalse.s IL_00cb
    IL_007f: ldloc.s 4
    IL_0081: callvirt ControllerType Rewired.Controller::get_type()  /*0x0A000006*/
    IL_0086: ldloc.3
    IL_0087: ldfld string ControlConfig.ControllerData::jsonMap  /*0x04000B9C*/
    IL_008c: call ControllerMap Rewired.ControllerMap::CreateFromJson(Rewired.ControllerType,string)  /*0x0A0003EB*/
    IL_0091: stloc.s 5
    IL_0093: ldloc.s 4
    IL_0095: callvirt ControllerIdentifier Rewired.Controller::get_identifier()  /*0x0A0003EC*/
    IL_009a: ldloc.s 5
    IL_009c: ldloc.3
    IL_009d: ldfld List<int> ControlConfig.ControllerData::knownActionIds  /*0x04000B9D*/
    IL_00a2: ldloc.1
    IL_00a3: call void ControlConfigSaveLoad::AddDefaultMappingsForNewActions(Rewired.ControllerIdentifier,Rewired.ControllerMap,System.Collections.Generic.List<int>,System.Collections.Generic.List<int>)  /*0x06000930*/
    IL_00a8: ldloc.0
    IL_00a9: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_00ae: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_00b3: ldloc.s 4
    IL_00b5: ldloc.s 5
    IL_00b7: callvirt void Rewired.Player.ControllerHelper.MapHelper::AddMap(Rewired.Controller,Rewired.ControllerMap)  /*0x0A0003ED*/
    IL_00bc: leave.s IL_00cb
    IL_00be: pop
    IL_00bf: ldstr "There was an error when trying to load a control map"
    IL_00c4: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_00c9: leave.s IL_00cb
    IL_00cb: ldloca.s 2
    IL_00cd: call bool System.Collections.Generic.List.Enumerator<ControlConfig.ControllerData>::MoveNext()  /*0x0A0003EE*/
    IL_00d2: brtrue.s IL_005b
    IL_00d4: leave.s IL_00e4
    IL_00d6: ldloca.s 2
    IL_00d8: constrained. System.Collections.Generic.List.Enumerator<ControlConfig.ControllerData>  /*0x1B0000B5*/
    IL_00de: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00e3: endfinally
    IL_00e4: ldstr "Controls Config loaded."
    IL_00e9: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_00ee: leave.s IL_00fd
    IL_00f0: pop
    IL_00f1: ldstr "There has been an error while trying to load the control config."
    IL_00f6: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_00fb: leave.s IL_00fd
    IL_00fd: ret
    .try IL_007f-IL_00be catch System.Object handler IL_00be-IL_00cb
    .try IL_0059-IL_00d6 finally handler IL_00d6-IL_00e4
    .try IL_0000-IL_00f0 catch System.Object handler IL_00f0-IL_00fd

  .method ControlConfigSaveLoad::GetAllKnownActionIDs()  // token 0x0600092F rva 0x2bc1c attrs Public, Static, HideBySig
    // code size 67 (0x43), max stack 3, init locals
    .locals ([0] List<int>, [1] IList<InputAction>, [2] int)
    IL_0000: call bool Rewired.ReInput::get_isReady()  /*0x0A0003EF*/
    IL_0005: brtrue.s IL_000d
    IL_0007: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_000c: ret
    IL_000d: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0012: stloc.0
    IL_0013: call ReInput.MappingHelper Rewired.ReInput::get_mapping()  /*0x0A0003F0*/
    IL_0018: callvirt IList<InputAction> Rewired.ReInput.MappingHelper::get_Actions()  /*0x0A0003F1*/
    IL_001d: stloc.1
    IL_001e: ldc.i4.0
    IL_001f: stloc.2
    IL_0020: br.s IL_0038
    IL_0022: ldloc.0
    IL_0023: ldloc.1
    IL_0024: ldloc.2
    IL_0025: callvirt !0 System.Collections.Generic.IList<Rewired.InputAction>::get_Item(int)  /*0x0A0003F2*/
    IL_002a: callvirt int Rewired.InputAction::get_id()  /*0x0A0003F3*/
    IL_002f: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0034: ldloc.2
    IL_0035: ldc.i4.1
    IL_0036: add
    IL_0037: stloc.2
    IL_0038: ldloc.2
    IL_0039: ldloc.1
    IL_003a: callvirt int System.Collections.Generic.ICollection<Rewired.InputAction>::get_Count()  /*0x0A0003F4*/
    IL_003f: blt.s IL_0022
    IL_0041: ldloc.0
    IL_0042: ret

  .method ControlConfigSaveLoad::AddDefaultMappingsForNewActions(Rewired.ControllerIdentifier,Rewired.ControllerMap,System.Collections.Generic.List<int>,System.Collections.Generic.List<int>)  // token 0x06000930 rva 0x2bc6c attrs Private, Static, HideBySig
    // code size 271 (0x10f), max stack 10, init locals
    .locals ([0] ControllerMap, [1] List<int>, [2] List.Enumerator<int>, [3] int, [4] IEnumerator<ActionElementMap>, [5] ActionElementMap, [6] ElementAssignment)
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_0006
    IL_0003: ldarg.2
    IL_0004: brtrue.s IL_0007
    IL_0006: ret
    IL_0007: ldarg.2
    IL_0008: brfalse.s IL_0012
    IL_000a: ldarg.2
    IL_000b: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0010: brtrue.s IL_0013
    IL_0012: ret
    IL_0013: call ReInput.MappingHelper Rewired.ReInput::get_mapping()  /*0x0A0003F0*/
    IL_0018: ldarg.0
    IL_0019: ldarg.1
    IL_001a: callvirt int Rewired.ControllerMap::get_categoryId()  /*0x0A0003F5*/
    IL_001f: ldarg.1
    IL_0020: callvirt int Rewired.ControllerMap::get_layoutId()  /*0x0A0003F6*/
    IL_0025: callvirt ControllerMap Rewired.ReInput.MappingHelper::GetControllerMapInstance(Rewired.ControllerIdentifier,int,int)  /*0x0A0003F7*/
    IL_002a: stloc.0
    IL_002b: ldloc.0
    IL_002c: brtrue.s IL_002f
    IL_002e: ret
    IL_002f: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0034: stloc.1
    IL_0035: ldarg.3
    IL_0036: callvirt List.Enumerator<!0> System.Collections.Generic.List<int>::GetEnumerator()  /*0x0A0002C5*/
    IL_003b: stloc.2
    IL_003c: br.s IL_0056
    IL_003e: ldloca.s 2
    IL_0040: call !0 System.Collections.Generic.List.Enumerator<int>::get_Current()  /*0x0A0002C6*/
    IL_0045: stloc.3
    IL_0046: ldarg.2
    IL_0047: ldloc.3
    IL_0048: callvirt bool System.Collections.Generic.List<int>::Contains(!0)  /*0x0A000123*/
    IL_004d: brtrue.s IL_0056
    IL_004f: ldloc.1
    IL_0050: ldloc.3
    IL_0051: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0056: ldloca.s 2
    IL_0058: call bool System.Collections.Generic.List.Enumerator<int>::MoveNext()  /*0x0A0002C9*/
    IL_005d: brtrue.s IL_003e
    IL_005f: leave.s IL_006f
    IL_0061: ldloca.s 2
    IL_0063: constrained. System.Collections.Generic.List.Enumerator<int>  /*0x1B00007C*/
    IL_0069: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_006e: endfinally
    IL_006f: ldloc.1
    IL_0070: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0075: brtrue.s IL_0078
    IL_0077: ret
    IL_0078: ldloc.0
    IL_0079: callvirt IList<ActionElementMap> Rewired.ControllerMap::get_AllMaps()  /*0x0A0003F8*/
    IL_007e: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<Rewired.ActionElementMap>::GetEnumerator()  /*0x0A0003F9*/
    IL_0083: stloc.s 4
    IL_0085: br.s IL_00f7
    IL_0087: ldloc.s 4
    IL_0089: callvirt !0 System.Collections.Generic.IEnumerator<Rewired.ActionElementMap>::get_Current()  /*0x0A0003FA*/
    IL_008e: stloc.s 5
    IL_0090: ldloc.1
    IL_0091: ldloc.s 5
    IL_0093: callvirt int Rewired.ActionElementMap::get_actionId()  /*0x0A0003FB*/
    IL_0098: callvirt bool System.Collections.Generic.List<int>::Contains(!0)  /*0x0A000123*/
    IL_009d: brfalse.s IL_00f7
    IL_009f: ldarg.1
    IL_00a0: ldloc.s 5
    IL_00a2: callvirt bool Rewired.ControllerMap::DoesElementAssignmentConflict(Rewired.ActionElementMap)  /*0x0A0003FC*/
    IL_00a7: brtrue.s IL_00f7
    IL_00a9: ldloca.s 6
    IL_00ab: ldarg.1
    IL_00ac: callvirt ControllerType Rewired.ControllerMap::get_controllerType()  /*0x0A0003FD*/
    IL_00b1: ldloc.s 5
    IL_00b3: callvirt ControllerElementType Rewired.ActionElementMap::get_elementType()  /*0x0A0003FE*/
    IL_00b8: ldloc.s 5
    IL_00ba: callvirt int Rewired.ActionElementMap::get_elementIdentifierId()  /*0x0A0003FF*/
    IL_00bf: ldloc.s 5
    IL_00c1: callvirt AxisRange Rewired.ActionElementMap::get_axisRange()  /*0x0A000400*/
    IL_00c6: ldloc.s 5
    IL_00c8: callvirt KeyCode Rewired.ActionElementMap::get_keyCode()  /*0x0A000401*/
    IL_00cd: ldloc.s 5
    IL_00cf: callvirt ModifierKeyFlags Rewired.ActionElementMap::get_modifierKeyFlags()  /*0x0A000402*/
    IL_00d4: ldloc.s 5
    IL_00d6: callvirt int Rewired.ActionElementMap::get_actionId()  /*0x0A0003FB*/
    IL_00db: ldloc.s 5
    IL_00dd: callvirt Pole Rewired.ActionElementMap::get_axisContribution()  /*0x0A000403*/
    IL_00e2: ldloc.s 5
    IL_00e4: callvirt bool Rewired.ActionElementMap::get_invert()  /*0x0A000404*/
    IL_00e9: call void Rewired.ElementAssignment::.ctor(Rewired.ControllerType,Rewired.ControllerElementType,int,Rewired.AxisRange,UnityEngine.KeyCode,Rewired.ModifierKeyFlags,int,Rewired.Pole,bool)  /*0x0A000405*/
    IL_00ee: ldarg.1
    IL_00ef: ldloc.s 6
    IL_00f1: callvirt bool Rewired.ControllerMap::CreateElementMap(Rewired.ElementAssignment)  /*0x0A000406*/
    IL_00f6: pop
    IL_00f7: ldloc.s 4
    IL_00f9: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_00fe: brtrue.s IL_0087
    IL_0100: leave.s IL_010e
    IL_0102: ldloc.s 4
    IL_0104: brfalse.s IL_010d
    IL_0106: ldloc.s 4
    IL_0108: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_010d: endfinally
    IL_010e: ret
    .try IL_003c-IL_0061 finally handler IL_0061-IL_006f
    .try IL_0085-IL_0102 finally handler IL_0102-IL_010e

