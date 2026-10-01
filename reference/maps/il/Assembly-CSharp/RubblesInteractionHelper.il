// ===== RubblesInteractionHelper  (token 0x02000120) =====
  .method RubblesInteractionHelper::OnEnable()  // token 0x060005E2 rva 0x19153 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot RubblesInteractionHelper::buildSlot  /*0x04000757*/
    IL_0006: ldfld UnityEvent BuildSlot::OnUpgrade  /*0x040003B0*/
    IL_000b: ldarg.0
    IL_000c: ldftn void RubblesInteractionHelper::OnBuildSlotUpgrade()  /*0x060005E5*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method RubblesInteractionHelper::OnDisable()  // token 0x060005E3 rva 0x19171 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot RubblesInteractionHelper::buildSlot  /*0x04000757*/
    IL_0006: ldfld UnityEvent BuildSlot::OnUpgrade  /*0x040003B0*/
    IL_000b: ldarg.0
    IL_000c: ldftn void RubblesInteractionHelper::OnBuildSlotUpgrade()  /*0x060005E5*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)  /*0x0A0000B2*/
    IL_001c: ret

  .method RubblesInteractionHelper::Start()  // token 0x060005E4 rva 0x19190 attrs Private, HideBySig
    // code size 86 (0x56), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Hp RubblesInteractionHelper::rubblesBuildingHP  /*0x04000755*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brtrue.s IL_001c
    IL_000e: ldarg.0
    IL_000f: ldfld NavmeshCut RubblesInteractionHelper::defaultCut  /*0x04000756*/
    IL_0014: ldnull
    IL_0015: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_001a: brfalse.s IL_0027
    IL_001c: ldstr "Must apply reference to control rubble properly."
    IL_0021: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0026: ret
    IL_0027: ldarg.0
    IL_0028: ldfld Hp RubblesInteractionHelper::rubblesBuildingHP  /*0x04000755*/
    IL_002d: callvirt void Hp::SetHpToMaxHp()  /*0x06000825*/
    IL_0032: ldarg.0
    IL_0033: ldfld Hp RubblesInteractionHelper::rubblesBuildingHP  /*0x04000755*/
    IL_0038: ldc.i4.0
    IL_0039: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_003e: ldarg.0
    IL_003f: ldfld NavmeshCut RubblesInteractionHelper::defaultCut  /*0x04000756*/
    IL_0044: ldc.i4.0
    IL_0045: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_004a: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_004f: ldarg.0
    IL_0050: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0055: ret

  .method RubblesInteractionHelper::OnBuildSlotUpgrade()  // token 0x060005E5 rva 0x191f2 attrs Private, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildingInteractor RubblesInteractionHelper::buildingInteractor  /*0x04000759*/
    IL_0006: ldc.i4.1
    IL_0007: stfld bool BuildingInteractor::buildingIsCurrentlyBusyAndCantBeUpgraded  /*0x04000E9F*/
    IL_000c: ldarg.0
    IL_000d: ldfld bool RubblesInteractionHelper::wasCut  /*0x0400075A*/
    IL_0012: brfalse.s IL_0015
    IL_0014: ret
    IL_0015: ldarg.0
    IL_0016: ldfld GameObject RubblesInteractionHelper::defaultStructure  /*0x04000758*/
    IL_001b: ldc.i4.0
    IL_001c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0021: ldarg.0
    IL_0022: ldc.i4.1
    IL_0023: stfld bool RubblesInteractionHelper::wasCut  /*0x0400075A*/
    IL_0028: ret

  .method RubblesInteractionHelper::OnDuskEarly()  // token 0x060005E6 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method RubblesInteractionHelper::OnDusk()  // token 0x060005E7 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method RubblesInteractionHelper::OnDawn_AfterSunrise()  // token 0x060005E8 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method RubblesInteractionHelper::OnDawn_BeforeSunrise()  // token 0x060005E9 rva 0x1921c attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildingInteractor RubblesInteractionHelper::buildingInteractor  /*0x04000759*/
    IL_0006: ldc.i4.0
    IL_0007: stfld bool BuildingInteractor::buildingIsCurrentlyBusyAndCantBeUpgraded  /*0x04000E9F*/
    IL_000c: ret

  .method RubblesInteractionHelper::OnBeforeMainLoadPass(string)  // token 0x060005EA rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method RubblesInteractionHelper::OnLoad(string)  // token 0x060005EB rva 0x1922a attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 55 (0x37), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldstr "wasCut"
    IL_0006: ldarg.0
    IL_0007: ldflda bool RubblesInteractionHelper::wasCut  /*0x0400075A*/
    IL_000c: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<bool>  /*0x2B000047*/
    IL_0011: brfalse.s IL_001f
    IL_0013: ldarg.0
    IL_0014: ldfld GameObject RubblesInteractionHelper::defaultStructure  /*0x04000758*/
    IL_0019: ldc.i4.0
    IL_001a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001f: ldarg.1
    IL_0020: ldstr "wasUsedThisDay"
    IL_0025: ldarg.0
    IL_0026: ldfld BuildingInteractor RubblesInteractionHelper::buildingInteractor  /*0x04000759*/
    IL_002b: ldflda bool BuildingInteractor::buildingIsCurrentlyBusyAndCantBeUpgraded  /*0x04000E9F*/
    IL_0030: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<bool>  /*0x2B000047*/
    IL_0035: pop
    IL_0036: ret

  .method RubblesInteractionHelper::OnAfterMainLoadPass(string)  // token 0x060005EC rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method RubblesInteractionHelper::OnSave(string)  // token 0x060005ED rva 0x19262 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldstr "wasCut"
    IL_0006: ldarg.0
    IL_0007: ldfld bool RubblesInteractionHelper::wasCut  /*0x0400075A*/
    IL_000c: call void MatchSaveLoadHandler::SaveValue(string,string,bool)  /*0x06000CF8*/
    IL_0011: ldarg.1
    IL_0012: ldstr "wasUsedThisDay"
    IL_0017: ldarg.0
    IL_0018: ldfld BuildingInteractor RubblesInteractionHelper::buildingInteractor  /*0x04000759*/
    IL_001d: ldfld bool BuildingInteractor::buildingIsCurrentlyBusyAndCantBeUpgraded  /*0x04000E9F*/
    IL_0022: call void MatchSaveLoadHandler::SaveValue(string,string,bool)  /*0x06000CF8*/
    IL_0027: ret

  .method RubblesInteractionHelper::.ctor()  // token 0x060005EE rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

