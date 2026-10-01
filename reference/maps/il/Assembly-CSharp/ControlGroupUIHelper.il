// ===== ControlGroupUIHelper  (token 0x02000004) =====
  .method ControlGroupUIHelper::Awake()  // token 0x06000005 rva 0x20f1 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_0006: ret

  .method ControlGroupUIHelper::OnEnable()  // token 0x06000006 rva 0x20f9 attrs Private, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldftn void ControlGroupUIHelper::OnControllerConnectionChange(Rewired.ControllerStatusChangedEventArgs)  /*0x06000009*/
    IL_0007: newobj void System.Action<Rewired.ControllerStatusChangedEventArgs>::.ctor(object,IntPtr)  /*0x0A000009*/
    IL_000c: call void Rewired.ReInput::add_ControllerConnectedEvent(System.Action<Rewired.ControllerStatusChangedEventArgs>)  /*0x0A00000A*/
    IL_0011: ldarg.0
    IL_0012: ldftn void ControlGroupUIHelper::OnControllerConnectionChange(Rewired.ControllerStatusChangedEventArgs)  /*0x06000009*/
    IL_0018: newobj void System.Action<Rewired.ControllerStatusChangedEventArgs>::.ctor(object,IntPtr)  /*0x0A000009*/
    IL_001d: call void Rewired.ReInput::add_ControllerDisconnectedEvent(System.Action<Rewired.ControllerStatusChangedEventArgs>)  /*0x0A00000B*/
    IL_0022: ret

  .method ControlGroupUIHelper::OnDestroy()  // token 0x06000007 rva 0x211d attrs Private, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldftn void ControlGroupUIHelper::OnControllerConnectionChange(Rewired.ControllerStatusChangedEventArgs)  /*0x06000009*/
    IL_0007: newobj void System.Action<Rewired.ControllerStatusChangedEventArgs>::.ctor(object,IntPtr)  /*0x0A000009*/
    IL_000c: call void Rewired.ReInput::remove_ControllerConnectedEvent(System.Action<Rewired.ControllerStatusChangedEventArgs>)  /*0x0A00000C*/
    IL_0011: ldarg.0
    IL_0012: ldftn void ControlGroupUIHelper::OnControllerConnectionChange(Rewired.ControllerStatusChangedEventArgs)  /*0x06000009*/
    IL_0018: newobj void System.Action<Rewired.ControllerStatusChangedEventArgs>::.ctor(object,IntPtr)  /*0x0A000009*/
    IL_001d: call void Rewired.ReInput::remove_ControllerDisconnectedEvent(System.Action<Rewired.ControllerStatusChangedEventArgs>)  /*0x0A00000D*/
    IL_0022: ret

  .method ControlGroupUIHelper::Start()  // token 0x06000008 rva 0x2144 attrs Public, HideBySig
    // code size 79 (0x4f), max stack 3, init locals
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_0027
    IL_000c: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0011: ldfld UnityEvent SettingsManager::onEnableControlGroupsChange  /*0x04000FFA*/
    IL_0016: ldarg.0
    IL_0017: ldftn void ControlGroupUIHelper::RefreshGroupFlags()  /*0x0600000B*/
    IL_001d: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0022: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0027: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_002c: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0031: brfalse.s IL_004e
    IL_0033: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0038: ldfld UnityEvent SceneTransitionManager::onSceneChange  /*0x04000C79*/
    IL_003d: ldarg.0
    IL_003e: ldftn void ControlGroupUIHelper::RefreshGroupFlags()  /*0x0600000B*/
    IL_0044: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0049: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_004e: ret

  .method ControlGroupUIHelper::OnControllerConnectionChange(Rewired.ControllerStatusChangedEventArgs)  // token 0x06000009 rva 0x219f attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ControlGroupUIHelper::RefreshGroupFlags()  /*0x0600000B*/
    IL_0006: ret

  .method ControlGroupUIHelper::Update()  // token 0x0600000A rva 0x21a8 attrs Private, HideBySig
    // code size 129 (0x81), max stack 2, init locals
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brtrue.s IL_000d
    IL_000c: ret
    IL_000d: ldarg.0
    IL_000e: ldfld DayNightCycle ControlGroupUIHelper::dnc  /*0x04000013*/
    IL_0013: ldnull
    IL_0014: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0019: brfalse.s IL_0026
    IL_001b: ldarg.0
    IL_001c: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0021: stfld DayNightCycle ControlGroupUIHelper::dnc  /*0x04000013*/
    IL_0026: ldarg.0
    IL_0027: ldfld LocalGamestate ControlGroupUIHelper::lgs  /*0x04000014*/
    IL_002c: ldnull
    IL_002d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0032: brfalse.s IL_003f
    IL_0034: ldarg.0
    IL_0035: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_003a: stfld LocalGamestate ControlGroupUIHelper::lgs  /*0x04000014*/
    IL_003f: ldarg.0
    IL_0040: ldfld DayNightCycle ControlGroupUIHelper::dnc  /*0x04000013*/
    IL_0045: ldnull
    IL_0046: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_004b: brtrue.s IL_0068
    IL_004d: ldarg.0
    IL_004e: ldfld LocalGamestate ControlGroupUIHelper::lgs  /*0x04000014*/
    IL_0053: ldnull
    IL_0054: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0059: brtrue.s IL_0068
    IL_005b: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0060: callvirt SceneTransitionManager.SceneState SceneTransitionManager::get_CurrentSceneState()  /*0x060009BC*/
    IL_0065: ldc.i4.2
    IL_0066: beq.s IL_0070
    IL_0068: ldarg.0
    IL_0069: ldc.i4.0
    IL_006a: call void ControlGroupUIHelper::SetVisible(bool)  /*0x0600000E*/
    IL_006f: ret
    IL_0070: ldarg.0
    IL_0071: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0076: callvirt bool SettingsManager::get_EnableControlGroups()  /*0x06000DAC*/
    IL_007b: call void ControlGroupUIHelper::SetVisible(bool)  /*0x0600000E*/
    IL_0080: ret

  .method ControlGroupUIHelper::RefreshGroupFlags()  // token 0x0600000B rva 0x2235 attrs Public, HideBySig
    // code size 50 (0x32), max stack 8
    IL_0000: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0005: callvirt SceneTransitionManager.SceneState SceneTransitionManager::get_CurrentSceneState()  /*0x060009BC*/
    IL_000a: ldc.i4.2
    IL_000b: bne.un.s IL_0031
    IL_000d: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0012: callvirt bool SettingsManager::get_EnableControlGroups()  /*0x06000DAC*/
    IL_0017: brfalse.s IL_0031
    IL_0019: ldarg.0
    IL_001a: ldc.i4.s 45
    IL_001c: call void ControlGroupUIHelper::RefreshFlag(TagManager.ETag)  /*0x0600000C*/
    IL_0021: ldarg.0
    IL_0022: ldc.i4.s 46
    IL_0024: call void ControlGroupUIHelper::RefreshFlag(TagManager.ETag)  /*0x0600000C*/
    IL_0029: ldarg.0
    IL_002a: ldc.i4.s 47
    IL_002c: call void ControlGroupUIHelper::RefreshFlag(TagManager.ETag)  /*0x0600000C*/
    IL_0031: ret

  .method ControlGroupUIHelper::RefreshFlag(TagManager.ETag)  // token 0x0600000C rva 0x2268 attrs Private, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call bool ControlGroupUIHelper::GroupHasUnits(TagManager.ETag)  /*0x0600000D*/
    IL_0007: brfalse.s IL_001d
    IL_0009: ldarg.0
    IL_000a: ldarg.1
    IL_000b: call void ControlGroupUIHelper::ShowFlag(TagManager.ETag)  /*0x0600000F*/
    IL_0010: ldarg.0
    IL_0011: ldarg.1
    IL_0012: ldc.r4 1f
    IL_0017: call void ControlGroupUIHelper::SetFillAmount(TagManager.ETag,float)  /*0x06000014*/
    IL_001c: ret
    IL_001d: ldarg.0
    IL_001e: ldarg.1
    IL_001f: call void ControlGroupUIHelper::HideFlag(TagManager.ETag)  /*0x06000010*/
    IL_0024: ret

  .method ControlGroupUIHelper::GroupHasUnits(TagManager.ETag)  // token 0x0600000D rva 0x2290 attrs Public, HideBySig
    // code size 104 (0x68), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld List<TagManager.ETag> ControlGroupUIHelper::mustHaveTags  /*0x04000010*/
    IL_0006: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<TagManager.ETag> ControlGroupUIHelper::mayNotHaveTags  /*0x04000011*/
    IL_0011: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_0016: ldarg.0
    IL_0017: ldfld List<TagManager.ETag> ControlGroupUIHelper::mustHaveTags  /*0x04000010*/
    IL_001c: ldc.i4.7
    IL_001d: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0022: ldarg.0
    IL_0023: ldfld List<TagManager.ETag> ControlGroupUIHelper::mustHaveTags  /*0x04000010*/
    IL_0028: ldarg.1
    IL_0029: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_002e: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0033: ldnull
    IL_0034: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0039: brfalse.s IL_0066
    IL_003b: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0040: ldarg.0
    IL_0041: ldfld List<TaggedObject> ControlGroupUIHelper::results  /*0x04000012*/
    IL_0046: ldarg.0
    IL_0047: ldfld List<TagManager.ETag> ControlGroupUIHelper::mustHaveTags  /*0x04000010*/
    IL_004c: ldarg.0
    IL_004d: ldfld List<TagManager.ETag> ControlGroupUIHelper::mayNotHaveTags  /*0x04000011*/
    IL_0052: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0057: ldarg.0
    IL_0058: ldfld List<TaggedObject> ControlGroupUIHelper::results  /*0x04000012*/
    IL_005d: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0062: ldc.i4.0
    IL_0063: cgt
    IL_0065: ret
    IL_0066: ldc.i4.0
    IL_0067: ret

  .method ControlGroupUIHelper::SetVisible(bool)  // token 0x0600000E rva 0x2304 attrs Public, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ControlGroupUIHelper::container  /*0x0400000A*/
    IL_0006: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_000b: ldarg.1
    IL_000c: beq.s IL_0020
    IL_000e: ldarg.0
    IL_000f: ldfld GameObject ControlGroupUIHelper::container  /*0x0400000A*/
    IL_0014: ldarg.1
    IL_0015: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001a: ldarg.0
    IL_001b: call void ControlGroupUIHelper::RefreshGroupFlags()  /*0x0600000B*/
    IL_0020: ret

  .method ControlGroupUIHelper::ShowFlag(TagManager.ETag)  // token 0x0600000F rva 0x2328 attrs Public, HideBySig
    // code size 54 (0x36), max stack 2, init locals
    .locals ([0] ControlGroupController)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call ControlGroupController ControlGroupUIHelper::GetControlGroupControllerFromTag(TagManager.ETag)  /*0x06000016*/
    IL_0007: stloc.0
    IL_0008: ldloc.0
    IL_0009: callvirt bool ControlGroupController::get_Hidden()  /*0x06000FEE*/
    IL_000e: brfalse.s IL_0035
    IL_0010: ldloc.0
    IL_0011: ldnull
    IL_0012: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0017: brfalse.s IL_0035
    IL_0019: ldloc.0
    IL_001a: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001f: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_0024: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0029: ldc.i4.1
    IL_002a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_002f: ldloc.0
    IL_0030: callvirt void ControlGroupController::FlagDrop()  /*0x06000FF1*/
    IL_0035: ret

  .method ControlGroupUIHelper::HideFlag(TagManager.ETag)  // token 0x06000010 rva 0x236c attrs Public, HideBySig
    // code size 32 (0x20), max stack 2, init locals
    .locals ([0] ControlGroupController)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call ControlGroupController ControlGroupUIHelper::GetControlGroupControllerFromTag(TagManager.ETag)  /*0x06000016*/
    IL_0007: stloc.0
    IL_0008: ldloc.0
    IL_0009: callvirt bool ControlGroupController::get_Hidden()  /*0x06000FEE*/
    IL_000e: brtrue.s IL_001f
    IL_0010: ldloc.0
    IL_0011: ldnull
    IL_0012: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0017: brfalse.s IL_001f
    IL_0019: ldloc.0
    IL_001a: callvirt void ControlGroupController::FlagHide()  /*0x06000FF2*/
    IL_001f: ret

  .method ControlGroupUIHelper::RemovingPulseAllGroups()  // token 0x06000011 rva 0x2398 attrs Public, HideBySig
    // code size 130 (0x82), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld ControlGroupController ControlGroupUIHelper::groupFlag1  /*0x0400000B*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_002b
    IL_000e: ldarg.0
    IL_000f: ldfld ControlGroupController ControlGroupUIHelper::groupFlag1  /*0x0400000B*/
    IL_0014: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0019: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_001e: brfalse.s IL_002b
    IL_0020: ldarg.0
    IL_0021: ldfld ControlGroupController ControlGroupUIHelper::groupFlag1  /*0x0400000B*/
    IL_0026: callvirt void ControlGroupController::RemovingPulse()  /*0x06000FF3*/
    IL_002b: ldarg.0
    IL_002c: ldfld ControlGroupController ControlGroupUIHelper::groupFlag2  /*0x0400000C*/
    IL_0031: ldnull
    IL_0032: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0037: brfalse.s IL_0056
    IL_0039: ldarg.0
    IL_003a: ldfld ControlGroupController ControlGroupUIHelper::groupFlag2  /*0x0400000C*/
    IL_003f: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0044: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0049: brfalse.s IL_0056
    IL_004b: ldarg.0
    IL_004c: ldfld ControlGroupController ControlGroupUIHelper::groupFlag2  /*0x0400000C*/
    IL_0051: callvirt void ControlGroupController::RemovingPulse()  /*0x06000FF3*/
    IL_0056: ldarg.0
    IL_0057: ldfld ControlGroupController ControlGroupUIHelper::groupFlag3  /*0x0400000D*/
    IL_005c: ldnull
    IL_005d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0062: brfalse.s IL_0081
    IL_0064: ldarg.0
    IL_0065: ldfld ControlGroupController ControlGroupUIHelper::groupFlag3  /*0x0400000D*/
    IL_006a: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_006f: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0074: brfalse.s IL_0081
    IL_0076: ldarg.0
    IL_0077: ldfld ControlGroupController ControlGroupUIHelper::groupFlag3  /*0x0400000D*/
    IL_007c: callvirt void ControlGroupController::RemovingPulse()  /*0x06000FF3*/
    IL_0081: ret

  .method ControlGroupUIHelper::OnGroupSet(TagManager.ETag)  // token 0x06000012 rva 0x2428 attrs Public, HideBySig
    // code size 24 (0x18), max stack 2, init locals
    .locals ([0] ControlGroupController)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call ControlGroupController ControlGroupUIHelper::GetControlGroupControllerFromTag(TagManager.ETag)  /*0x06000016*/
    IL_0007: stloc.0
    IL_0008: ldloc.0
    IL_0009: ldnull
    IL_000a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: callvirt void ControlGroupController::Pulse()  /*0x06000FF5*/
    IL_0017: ret

  .method ControlGroupUIHelper::SetFillAmountForAllGroups(float)  // token 0x06000013 rva 0x244c attrs Public, HideBySig
    // code size 79 (0x4f), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld ControlGroupController ControlGroupUIHelper::groupFlag1  /*0x0400000B*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_001a
    IL_000e: ldarg.0
    IL_000f: ldfld ControlGroupController ControlGroupUIHelper::groupFlag1  /*0x0400000B*/
    IL_0014: ldarg.1
    IL_0015: callvirt void ControlGroupController::SetFillAmount(float)  /*0x06000FF7*/
    IL_001a: ldarg.0
    IL_001b: ldfld ControlGroupController ControlGroupUIHelper::groupFlag2  /*0x0400000C*/
    IL_0020: ldnull
    IL_0021: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0026: brfalse.s IL_0034
    IL_0028: ldarg.0
    IL_0029: ldfld ControlGroupController ControlGroupUIHelper::groupFlag2  /*0x0400000C*/
    IL_002e: ldarg.1
    IL_002f: callvirt void ControlGroupController::SetFillAmount(float)  /*0x06000FF7*/
    IL_0034: ldarg.0
    IL_0035: ldfld ControlGroupController ControlGroupUIHelper::groupFlag3  /*0x0400000D*/
    IL_003a: ldnull
    IL_003b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0040: brfalse.s IL_004e
    IL_0042: ldarg.0
    IL_0043: ldfld ControlGroupController ControlGroupUIHelper::groupFlag3  /*0x0400000D*/
    IL_0048: ldarg.1
    IL_0049: callvirt void ControlGroupController::SetFillAmount(float)  /*0x06000FF7*/
    IL_004e: ret

  .method ControlGroupUIHelper::SetFillAmount(TagManager.ETag,float)  // token 0x06000014 rva 0x24a8 attrs Public, HideBySig
    // code size 25 (0x19), max stack 2, init locals
    .locals ([0] ControlGroupController)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call ControlGroupController ControlGroupUIHelper::GetControlGroupControllerFromTag(TagManager.ETag)  /*0x06000016*/
    IL_0007: stloc.0
    IL_0008: ldloc.0
    IL_0009: ldnull
    IL_000a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000f: brfalse.s IL_0018
    IL_0011: ldloc.0
    IL_0012: ldarg.2
    IL_0013: callvirt void ControlGroupController::SetFillAmount(float)  /*0x06000FF7*/
    IL_0018: ret

  .method ControlGroupUIHelper::PlayHoldingSFX(float)  // token 0x06000015 rva 0x24d0 attrs Public, HideBySig
    // code size 72 (0x48), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld AudioSource ControlGroupUIHelper::_sfx_group_build  /*0x0400000E*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_0047
    IL_000e: ldarg.1
    IL_000f: ldc.r4 1f
    IL_0014: bgt.un.s IL_0047
    IL_0016: ldarg.0
    IL_0017: ldfld AudioSource ControlGroupUIHelper::_sfx_group_build  /*0x0400000E*/
    IL_001c: ldc.r4 1f
    IL_0021: ldarg.1
    IL_0022: add
    IL_0023: ldarg.0
    IL_0024: ldfld float ControlGroupUIHelper::_pitchMultiplier  /*0x0400000F*/
    IL_0029: mul
    IL_002a: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_002f: ldarg.0
    IL_0030: ldfld AudioSource ControlGroupUIHelper::_sfx_group_build  /*0x0400000E*/
    IL_0035: callvirt bool UnityEngine.AudioSource::get_isPlaying()  /*0x0A00001C*/
    IL_003a: brtrue.s IL_0047
    IL_003c: ldarg.0
    IL_003d: ldfld AudioSource ControlGroupUIHelper::_sfx_group_build  /*0x0400000E*/
    IL_0042: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_0047: ret

  .method ControlGroupUIHelper::GetControlGroupControllerFromTag(TagManager.ETag)  // token 0x06000016 rva 0x2524 attrs Private, HideBySig
    // code size 52 (0x34), max stack 2, init locals
    .locals ([0] ControlGroupController)
    IL_0000: ldnull
    IL_0001: stloc.0
    IL_0002: ldarg.1
    IL_0003: ldc.i4.s 45
    IL_0005: sub
    IL_0006: switch (IL_0019, IL_0022, IL_002b)
    IL_0017: br.s IL_0032
    IL_0019: ldarg.0
    IL_001a: ldfld ControlGroupController ControlGroupUIHelper::groupFlag1  /*0x0400000B*/
    IL_001f: stloc.0
    IL_0020: br.s IL_0032
    IL_0022: ldarg.0
    IL_0023: ldfld ControlGroupController ControlGroupUIHelper::groupFlag2  /*0x0400000C*/
    IL_0028: stloc.0
    IL_0029: br.s IL_0032
    IL_002b: ldarg.0
    IL_002c: ldfld ControlGroupController ControlGroupUIHelper::groupFlag3  /*0x0400000D*/
    IL_0031: stloc.0
    IL_0032: ldloc.0
    IL_0033: ret

  .method ControlGroupUIHelper::.ctor()  // token 0x06000017 rva 0x2564 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float ControlGroupUIHelper::_pitchMultiplier  /*0x0400000F*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0011: stfld List<TagManager.ETag> ControlGroupUIHelper::mustHaveTags  /*0x04000010*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_001c: stfld List<TagManager.ETag> ControlGroupUIHelper::mayNotHaveTags  /*0x04000011*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0027: stfld List<TaggedObject> ControlGroupUIHelper::results  /*0x04000012*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0032: ret

