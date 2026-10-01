// ===== TreasureChestUIHelper  (token 0x0200036D) =====
  .method TreasureChestUIHelper::Awake()  // token 0x060012CF rva 0x59516 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld TreasureChestUIHelper TreasureChestUIHelper::instance  /*0x040016A5*/
    IL_0006: ret

  .method TreasureChestUIHelper::get_EnergyCoreBalanceNumber()  // token 0x060012D0 rva 0x59520 attrs Public, HideBySig, SpecialName
    // code size 114 (0x72), max stack 3, init locals
    .locals ([0] LevelInfo, [1] GameObject)
    IL_0000: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0005: callvirt LevelInfo LevelProgressManager::GetLevelInfoFromCurrentSceneName()  /*0x06000945*/
    IL_000a: stloc.0
    IL_000b: ldarg.0
    IL_000c: ldfld TextMeshProUGUI TreasureChestUIHelper::energyCoreBalanceNumber  /*0x040016AB*/
    IL_0011: ldnull
    IL_0012: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0017: brfalse.s IL_006b
    IL_0019: ldloc.0
    IL_001a: ldnull
    IL_001b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0020: brfalse.s IL_006b
    IL_0022: ldc.i4.0
    IL_0023: ldloc.0
    IL_0024: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0029: call bool DlcConfiguration::IsDlcMap(IDlcProvider.DlcId,string)  /*0x0600001D*/
    IL_002e: brfalse.s IL_006b
    IL_0030: ldc.i4.0
    IL_0031: call bool DlcConfiguration::IsDlcAvailable(IDlcProvider.DlcId)  /*0x0600001C*/
    IL_0036: brfalse.s IL_006b
    IL_0038: ldstr "UI/Energy Core Count"
    IL_003d: call !!0 UnityEngine.Resources::Load(string)<UnityEngine.GameObject>  /*0x2B000002*/
    IL_0042: stloc.1
    IL_0043: ldarg.0
    IL_0044: ldloc.1
    IL_0045: ldarg.0
    IL_0046: ldfld GameObject TreasureChestUIHelper::toggleParent  /*0x040016A9*/
    IL_004b: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0050: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_0055: stfld GameObject TreasureChestUIHelper::energyCoreCounter  /*0x040016AA*/
    IL_005a: ldarg.0
    IL_005b: ldarg.0
    IL_005c: ldfld GameObject TreasureChestUIHelper::energyCoreCounter  /*0x040016AA*/
    IL_0061: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<TMPro.TextMeshProUGUI>  /*0x2B000107*/
    IL_0066: stfld TextMeshProUGUI TreasureChestUIHelper::energyCoreBalanceNumber  /*0x040016AB*/
    IL_006b: ldarg.0
    IL_006c: ldfld TextMeshProUGUI TreasureChestUIHelper::energyCoreBalanceNumber  /*0x040016AB*/
    IL_0071: ret

  .method TreasureChestUIHelper::Update()  // token 0x060012D1 rva 0x595a0 attrs Private, HideBySig
    // code size 163 (0xa3), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld DayNightCycle TreasureChestUIHelper::dnc  /*0x040016AC*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_0019
    IL_000e: ldarg.0
    IL_000f: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0014: stfld DayNightCycle TreasureChestUIHelper::dnc  /*0x040016AC*/
    IL_0019: ldarg.0
    IL_001a: ldfld LocalGamestate TreasureChestUIHelper::lgs  /*0x040016AD*/
    IL_001f: ldnull
    IL_0020: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0025: brfalse.s IL_0032
    IL_0027: ldarg.0
    IL_0028: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_002d: stfld LocalGamestate TreasureChestUIHelper::lgs  /*0x040016AD*/
    IL_0032: ldarg.0
    IL_0033: ldfld DayNightCycle TreasureChestUIHelper::dnc  /*0x040016AC*/
    IL_0038: ldnull
    IL_0039: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_003e: brtrue.s IL_004e
    IL_0040: ldarg.0
    IL_0041: ldfld LocalGamestate TreasureChestUIHelper::lgs  /*0x040016AD*/
    IL_0046: ldnull
    IL_0047: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_004c: brfalse.s IL_0062
    IL_004e: ldarg.0
    IL_004f: ldfld GameObject TreasureChestUIHelper::toggleParent  /*0x040016A9*/
    IL_0054: ldc.i4.0
    IL_0055: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_005a: ldarg.0
    IL_005b: ldc.i4.1
    IL_005c: stfld bool TreasureChestUIHelper::overrideActiveState  /*0x040016A6*/
    IL_0061: ret
    IL_0062: ldarg.0
    IL_0063: ldfld DayNightCycle TreasureChestUIHelper::dnc  /*0x040016AC*/
    IL_0068: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_006d: brtrue.s IL_008f
    IL_006f: ldarg.0
    IL_0070: ldfld LocalGamestate TreasureChestUIHelper::lgs  /*0x040016AD*/
    IL_0075: callvirt LocalGamestate.State LocalGamestate::get_CurrentState()  /*0x060008FD*/
    IL_007a: ldc.i4.1
    IL_007b: bne.un.s IL_008f
    IL_007d: ldarg.0
    IL_007e: ldfld GameObject TreasureChestUIHelper::toggleParent  /*0x040016A9*/
    IL_0083: ldarg.0
    IL_0084: ldfld bool TreasureChestUIHelper::overrideActiveState  /*0x040016A6*/
    IL_0089: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_008e: ret
    IL_008f: ldarg.0
    IL_0090: ldfld GameObject TreasureChestUIHelper::toggleParent  /*0x040016A9*/
    IL_0095: ldc.i4.0
    IL_0096: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_009b: ldarg.0
    IL_009c: ldc.i4.1
    IL_009d: stfld bool TreasureChestUIHelper::overrideActiveState  /*0x040016A6*/
    IL_00a2: ret

  .method TreasureChestUIHelper::.ctor()  // token 0x060012D2 rva 0x5964f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool TreasureChestUIHelper::overrideActiveState  /*0x040016A6*/
    IL_0007: ldarg.0
    IL_0008: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_000d: ret

