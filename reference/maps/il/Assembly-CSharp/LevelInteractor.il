// ===== LevelInteractor  (token 0x020001A9) =====
  .method LevelInteractor::get_PlayerTeleportPosition()  // token 0x0600089B rva 0x29847 attrs Public, HideBySig, SpecialName
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject LevelInteractor::unlockedLevelVisuals  /*0x04000AC4*/
    IL_0006: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_000b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0010: ret

  .method LevelInteractor::get_Quests()  // token 0x0600089C rva 0x29859 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0006: ldfld List<Quest> LevelInfo::quests  /*0x04000B29*/
    IL_000b: ret

  .method LevelInteractor::UpdateVisualsOnStart()  // token 0x0600089D rva 0x29868 attrs Public, HideBySig
    // code size 485 (0x1e5), max stack 6, init locals
    .locals ([0] int, [1] float, [2] int, [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld LevelData LevelInteractor::myLevelData  /*0x04000ABE*/
    IL_0006: brtrue.s IL_002f
    IL_0008: ldarg.0
    IL_0009: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_000e: stfld LevelProgressManager LevelInteractor::levelProgressManager  /*0x04000ABD*/
    IL_0013: ldarg.0
    IL_0014: ldarg.0
    IL_0015: ldfld LevelProgressManager LevelInteractor::levelProgressManager  /*0x04000ABD*/
    IL_001a: ldarg.0
    IL_001b: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0020: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0025: callvirt LevelData LevelProgressManager::GetLevelDataForScene(string)  /*0x0600094A*/
    IL_002a: stfld LevelData LevelInteractor::myLevelData  /*0x04000ABE*/
    IL_002f: ldarg.0
    IL_0030: ldfld GameObject LevelInteractor::lockedLevelVisuals  /*0x04000AC3*/
    IL_0035: ldc.i4.0
    IL_0036: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003b: ldarg.0
    IL_003c: ldfld GameObject LevelInteractor::unlockedLevelVisuals  /*0x04000AC4*/
    IL_0041: ldc.i4.0
    IL_0042: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0047: ldarg.0
    IL_0048: ldfld GameObject LevelInteractor::beatenLevelVisuals  /*0x04000AC5*/
    IL_004d: ldc.i4.0
    IL_004e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0053: ldarg.0
    IL_0054: ldfld TMP_Text LevelInteractor::questsComplete  /*0x04000AC7*/
    IL_0059: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_005e: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_0063: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0068: ldc.i4.0
    IL_0069: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_006e: ldarg.0
    IL_006f: ldfld TMP_Text LevelInteractor::questsComplete  /*0x04000AC7*/
    IL_0074: ldarg.0
    IL_0075: call string LevelInteractor::QuestsBeatenString()  /*0x060008A7*/
    IL_007a: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_007f: ldarg.0
    IL_0080: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0085: callvirt int LevelInfo::QuestsComplete()  /*0x060008E4*/
    IL_008a: stloc.0
    IL_008b: ldloc.0
    IL_008c: ldarg.0
    IL_008d: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0092: callvirt int LevelInfo::QuestsTotal()  /*0x060008E5*/
    IL_0097: bne.un.s IL_00a9
    IL_0099: ldarg.0
    IL_009a: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_009f: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_00a4: call void AchievementManager::LevelAllQuestsComplete(string)  /*0x06000914*/
    IL_00a9: ldarg.0
    IL_00aa: ldfld LevelData LevelInteractor::myLevelData  /*0x04000ABE*/
    IL_00af: ldfld bool LevelData::beatenBest  /*0x04000BC1*/
    IL_00b4: brfalse.s IL_00c6
    IL_00b6: ldarg.0
    IL_00b7: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_00bc: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_00c1: call void AchievementManager::LevelBeaten(string)  /*0x06000913*/
    IL_00c6: ldarg.0
    IL_00c7: ldfld TMP_Text LevelInteractor::questsComplete  /*0x04000AC7*/
    IL_00cc: ldloc.0
    IL_00cd: ldarg.0
    IL_00ce: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_00d3: callvirt int LevelInfo::QuestsTotal()  /*0x060008E5*/
    IL_00d8: bge.s IL_00e2
    IL_00da: ldarg.0
    IL_00db: ldfld Color LevelInteractor::notAllQuestComplete  /*0x04000ACA*/
    IL_00e0: br.s IL_00e8
    IL_00e2: ldarg.0
    IL_00e3: ldfld Color LevelInteractor::allQuestComplete  /*0x04000AC9*/
    IL_00e8: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00ed: ldloc.0
    IL_00ee: conv.r4
    IL_00ef: ldarg.0
    IL_00f0: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_00f5: callvirt int LevelInfo::QuestsTotal()  /*0x060008E5*/
    IL_00fa: conv.r4
    IL_00fb: div
    IL_00fc: stloc.1
    IL_00fd: ldarg.0
    IL_00fe: ldfld Transform LevelInteractor::rewardBuildingsParent  /*0x04000AC6*/
    IL_0103: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0108: conv.r4
    IL_0109: ldarg.0
    IL_010a: ldfld LevelData LevelInteractor::myLevelData  /*0x04000ABE*/
    IL_010f: ldfld int LevelData::questsCompleteWhenLastVisitingMap  /*0x04000BBC*/
    IL_0114: conv.r4
    IL_0115: mul
    IL_0116: ldarg.0
    IL_0117: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_011c: callvirt int LevelInfo::QuestsTotal()  /*0x060008E5*/
    IL_0121: conv.r4
    IL_0122: div
    IL_0123: call int UnityEngine.Mathf::FloorToInt(float)  /*0x0A000144*/
    IL_0128: stloc.2
    IL_0129: ldarg.0
    IL_012a: ldfld Transform LevelInteractor::rewardBuildingsParent  /*0x04000AC6*/
    IL_012f: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0134: conv.r4
    IL_0135: ldloc.1
    IL_0136: mul
    IL_0137: call int UnityEngine.Mathf::FloorToInt(float)  /*0x0A000144*/
    IL_013c: stloc.3
    IL_013d: ldloc.2
    IL_013e: ldloc.3
    IL_013f: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_0144: stloc.2
    IL_0145: ldarg.0
    IL_0146: ldfld LevelData LevelInteractor::myLevelData  /*0x04000ABE*/
    IL_014b: ldloc.3
    IL_014c: stfld int LevelData::questsCompleteWhenLastVisitingMap  /*0x04000BBC*/
    IL_0151: ldarg.0
    IL_0152: ldarg.0
    IL_0153: ldloc.2
    IL_0154: ldloc.3
    IL_0155: ldc.r4 0.75f
    IL_015a: ldc.r4 0.5f
    IL_015f: call IEnumerator LevelInteractor::EnableBuildingsCoroutine(int,int,float,float)  /*0x0600089E*/
    IL_0164: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0169: pop
    IL_016a: ldarg.0
    IL_016b: ldfld TextMeshProUGUI LevelInteractor::challengeName  /*0x04000AC8*/
    IL_0170: ldnull
    IL_0171: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0176: brfalse.s IL_018e
    IL_0178: ldarg.0
    IL_0179: ldfld TextMeshProUGUI LevelInteractor::challengeName  /*0x04000AC8*/
    IL_017e: ldarg.0
    IL_017f: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0184: callvirt string LevelInfo::get_displaySubtitle()  /*0x060008E0*/
    IL_0189: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_018e: ldarg.0
    IL_018f: call bool LevelInteractor::get_CanBePlayed()  /*0x0600089F*/
    IL_0194: brtrue.s IL_01a3
    IL_0196: ldarg.0
    IL_0197: ldfld GameObject LevelInteractor::lockedLevelVisuals  /*0x04000AC3*/
    IL_019c: ldc.i4.1
    IL_019d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01a2: ret
    IL_01a3: ldarg.0
    IL_01a4: ldfld TMP_Text LevelInteractor::questsComplete  /*0x04000AC7*/
    IL_01a9: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_01ae: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_01b3: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01b8: ldc.i4.1
    IL_01b9: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01be: ldarg.0
    IL_01bf: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_01c4: callvirt bool LevelInfo::get_Beaten()  /*0x060008E6*/
    IL_01c9: brtrue.s IL_01d8
    IL_01cb: ldarg.0
    IL_01cc: ldfld GameObject LevelInteractor::unlockedLevelVisuals  /*0x04000AC4*/
    IL_01d1: ldc.i4.1
    IL_01d2: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01d7: ret
    IL_01d8: ldarg.0
    IL_01d9: ldfld GameObject LevelInteractor::beatenLevelVisuals  /*0x04000AC5*/
    IL_01de: ldc.i4.1
    IL_01df: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01e4: ret

  .method LevelInteractor::EnableBuildingsCoroutine(int,int,float,float)  // token 0x0600089E rva 0x29a59 attrs Private, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void LevelInteractor.<EnableBuildingsCoroutine>d__22::.ctor(int)  /*0x060008A9*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld LevelInteractor LevelInteractor.<EnableBuildingsCoroutine>d__22::<>4__this  /*0x04000ACE*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::_enabledBuildings  /*0x04000AD0*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::_enabledBuildingsUpTo  /*0x04000ACF*/
    IL_001b: dup
    IL_001c: ldarg.3
    IL_001d: stfld float LevelInteractor.<EnableBuildingsCoroutine>d__22::_initialDelay  /*0x04000AD1*/
    IL_0022: dup
    IL_0023: ldarg.s 4
    IL_0025: stfld float LevelInteractor.<EnableBuildingsCoroutine>d__22::_interval  /*0x04000AD2*/
    IL_002a: ret

  .method LevelInteractor::get_CanBePlayed()  // token 0x0600089F rva 0x29a85 attrs Public, HideBySig, SpecialName
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0006: ldfld LevelInfo LevelInfo::unlockRequirement  /*0x04000B27*/
    IL_000b: ldnull
    IL_000c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0011: brfalse.s IL_0027
    IL_0013: ldarg.0
    IL_0014: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0019: ldfld LevelInfo LevelInfo::unlockRequirement  /*0x04000B27*/
    IL_001e: callvirt bool LevelInfo::get_Beaten()  /*0x060008E6*/
    IL_0023: brtrue.s IL_0027
    IL_0025: ldc.i4.0
    IL_0026: ret
    IL_0027: ldc.i4.1
    IL_0028: ret

  .method LevelInteractor::get_CanNotBePlayedReason()  // token 0x060008A0 rva 0x29ab0 attrs Public, HideBySig, SpecialName
    // code size 79 (0x4f), max stack 7, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0006: ldfld LevelInfo LevelInfo::unlockRequirement  /*0x04000B27*/
    IL_000b: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0010: brfalse.s IL_0049
    IL_0012: ldarg.0
    IL_0013: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0018: ldfld LevelInfo LevelInfo::unlockRequirement  /*0x04000B27*/
    IL_001d: callvirt bool LevelInfo::get_Beaten()  /*0x060008E6*/
    IL_0022: brtrue.s IL_0049
    IL_0024: ldstr "Menu/Beat Map to Unlock Cue"
    IL_0029: ldarg.0
    IL_002a: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_002f: ldfld LevelInfo LevelInfo::unlockRequirement  /*0x04000B27*/
    IL_0034: ldfld string LevelInfo::displayName  /*0x04000B20*/
    IL_0039: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_003e: ldc.i4.1
    IL_003f: ldc.i4.1
    IL_0040: ldc.i4.0
    IL_0041: ldc.i4.1
    IL_0042: ldc.i4.1
    IL_0043: call string TextTranslator::TranslateAndInsertMapName(string,string,bool,bool,int,bool,bool)  /*0x060009E5*/
    IL_0048: ret
    IL_0049: ldstr ""
    IL_004e: ret

  .method LevelInteractor::Start()  // token 0x060008A1 rva 0x29b0c attrs Private, HideBySig
    // code size 113 (0x71), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0006: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_000b: call bool LevelProgressManager::SceneExists(string)  /*0x0600094C*/
    IL_0010: brtrue.s IL_001f
    IL_0012: ldarg.0
    IL_0013: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0018: ldc.i4.0
    IL_0019: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001e: ret
    IL_001f: ldarg.0
    IL_0020: ldarg.0
    IL_0021: call !!0 UnityEngine.Component::GetComponentInParent()<LevelSelectManager>  /*0x2B000093*/
    IL_0026: stfld LevelSelectManager LevelInteractor::levelSelectManager  /*0x04000ABC*/
    IL_002b: ldarg.0
    IL_002c: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0031: stfld LevelProgressManager LevelInteractor::levelProgressManager  /*0x04000ABD*/
    IL_0036: ldarg.0
    IL_0037: ldarg.0
    IL_0038: ldfld LevelProgressManager LevelInteractor::levelProgressManager  /*0x04000ABD*/
    IL_003d: ldarg.0
    IL_003e: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0043: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0048: callvirt LevelData LevelProgressManager::GetLevelDataForScene(string)  /*0x0600094A*/
    IL_004d: stfld LevelData LevelInteractor::myLevelData  /*0x04000ABE*/
    IL_0052: ldarg.0
    IL_0053: ldfld GameObject LevelInteractor::focusPanel  /*0x04000AC0*/
    IL_0058: ldc.i4.0
    IL_0059: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_005e: ldarg.0
    IL_005f: ldfld GameObject LevelInteractor::cantBePlayedPanel  /*0x04000AC1*/
    IL_0064: ldc.i4.0
    IL_0065: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_006a: ldarg.0
    IL_006b: call void LevelInteractor::UpdateVisualsOnStart()  /*0x0600089D*/
    IL_0070: ret

  .method LevelInteractor::ReturnTooltip()  // token 0x060008A2 rva 0x29b89 attrs Public, Virtual, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool LevelInteractor::get_CanBePlayed()  /*0x0600089F*/
    IL_0006: brfalse.s IL_0017
    IL_0008: ldstr "Menu/Level Interactor Cue"
    IL_000d: ldc.i4.1
    IL_000e: ldc.i4.0
    IL_000f: ldc.i4.1
    IL_0010: ldc.i4.1
    IL_0011: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0016: ret
    IL_0017: ldstr ""
    IL_001c: ret

  .method LevelInteractor::GenerateCueText()  // token 0x060008A3 rva 0x29ba7 attrs Private, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool LevelInteractor::get_CanBePlayed()  /*0x0600089F*/
    IL_0006: brtrue.s IL_000f
    IL_0008: ldarg.0
    IL_0009: call string LevelInteractor::get_CanNotBePlayedReason()  /*0x060008A0*/
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld LevelSelectManager LevelInteractor::levelSelectManager  /*0x04000ABC*/
    IL_0015: callvirt bool LevelSelectManager::get_PreLevelMenuIsOpen()  /*0x060008B1*/
    IL_001a: brfalse.s IL_0022
    IL_001c: ldstr ""
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0028: callvirt string LevelInfo::get_LocalizedDisplayName()  /*0x060008DF*/
    IL_002d: ret

  .method LevelInteractor::InteractionBegin(PlayerInteraction)  // token 0x060008A4 rva 0x29bd6 attrs Public, Virtual, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool LevelInteractor::get_CanBePlayed()  /*0x0600089F*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_000f: stsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_0014: call bool UIFrameManager::TryOpenLevelSelect()  /*0x0600130D*/
    IL_0019: pop
    IL_001a: ret

  .method LevelInteractor::Focus(PlayerInteraction)  // token 0x060008A5 rva 0x29bf4 attrs Public, Virtual, HideBySig
    // code size 147 (0x93), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: call bool LevelInteractor::get_CanBePlayed()  /*0x0600089F*/
    IL_0006: brfalse.s IL_0045
    IL_0008: ldarg.0
    IL_0009: ldfld GameObject LevelInteractor::focusPanel  /*0x04000AC0*/
    IL_000e: ldc.i4.1
    IL_000f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0014: ldarg.0
    IL_0015: ldfld GameObject LevelInteractor::cantBePlayedPanel  /*0x04000AC1*/
    IL_001a: ldc.i4.0
    IL_001b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0020: ldarg.0
    IL_0021: ldfld TextMeshProUGUI LevelInteractor::challengeName  /*0x04000AC8*/
    IL_0026: ldnull
    IL_0027: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002c: brfalse.s IL_0092
    IL_002e: ldarg.0
    IL_002f: ldfld TextMeshProUGUI LevelInteractor::challengeName  /*0x04000AC8*/
    IL_0034: ldarg.0
    IL_0035: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_003a: callvirt string LevelInfo::get_displaySubtitle()  /*0x060008E0*/
    IL_003f: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0044: ret
    IL_0045: ldarg.0
    IL_0046: ldfld TextMeshProUGUI LevelInteractor::cantBePlayedCue  /*0x04000AC2*/
    IL_004b: ldarg.0
    IL_004c: call string LevelInteractor::GenerateCueText()  /*0x060008A3*/
    IL_0051: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0056: ldarg.0
    IL_0057: ldfld GameObject LevelInteractor::cantBePlayedPanel  /*0x04000AC1*/
    IL_005c: ldc.i4.1
    IL_005d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0062: ldarg.0
    IL_0063: ldfld GameObject LevelInteractor::focusPanel  /*0x04000AC0*/
    IL_0068: ldc.i4.0
    IL_0069: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_006e: ldarg.0
    IL_006f: ldfld TextMeshProUGUI LevelInteractor::challengeName  /*0x04000AC8*/
    IL_0074: ldnull
    IL_0075: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_007a: brfalse.s IL_0092
    IL_007c: ldarg.0
    IL_007d: ldfld TextMeshProUGUI LevelInteractor::challengeName  /*0x04000AC8*/
    IL_0082: ldarg.0
    IL_0083: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0088: callvirt string LevelInfo::get_displaySubtitle()  /*0x060008E0*/
    IL_008d: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0092: ret

  .method LevelInteractor::Unfocus(PlayerInteraction)  // token 0x060008A6 rva 0x29c93 attrs Public, Virtual, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject LevelInteractor::focusPanel  /*0x04000AC0*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: ldfld GameObject LevelInteractor::cantBePlayedPanel  /*0x04000AC1*/
    IL_0012: ldc.i4.0
    IL_0013: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0018: ret

  .method LevelInteractor::QuestsBeatenString()  // token 0x060008A7 rva 0x29cb0 attrs Public, HideBySig
    // code size 49 (0x31), max stack 3, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0006: callvirt int LevelInfo::QuestsComplete()  /*0x060008E4*/
    IL_000b: stloc.0
    IL_000c: ldloca.s 0
    IL_000e: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0013: ldstr "/"
    IL_0018: ldarg.0
    IL_0019: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_001e: callvirt int LevelInfo::QuestsTotal()  /*0x060008E5*/
    IL_0023: stloc.0
    IL_0024: ldloca.s 0
    IL_0026: call string System.Int32::ToString()  /*0x0A000031*/
    IL_002b: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0030: ret

  .method LevelInteractor::.ctor()  // token 0x060008A8 rva 0x29ced attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldstr "Beat <lvlname> to unlock this level."
    IL_0006: stfld string LevelInteractor::tooltipThisLevelMustBeBeaten  /*0x04000ABF*/
    IL_000b: ldarg.0
    IL_000c: call void InteractorBase::.ctor()  /*0x06000BEE*/
    IL_0011: ret

// ===== LevelInteractor/<EnableBuildingsCoroutine>d__22  (token 0x020001AA) =====
  .method LevelInteractor.<EnableBuildingsCoroutine>d__22::.ctor(int)  // token 0x060008A9 rva 0x29d00 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::<>1__state  /*0x04000ACC*/
    IL_000d: ret

  .method LevelInteractor.<EnableBuildingsCoroutine>d__22::System.IDisposable.Dispose()  // token 0x060008AA rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LevelInteractor.<EnableBuildingsCoroutine>d__22::MoveNext()  // token 0x060008AB rva 0x29d10 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 364 (0x16c), max stack 3, init locals
    .locals ([0] int, [1] LevelInteractor, [2] int, [3] int, [4] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::<>1__state  /*0x04000ACC*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld LevelInteractor LevelInteractor.<EnableBuildingsCoroutine>d__22::<>4__this  /*0x04000ACE*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_00d6, IL_0143)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::<>1__state  /*0x04000ACC*/
    IL_0029: ldloc.1
    IL_002a: ldfld Transform LevelInteractor::rewardBuildingsParent  /*0x04000AC6*/
    IL_002f: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0034: ldarg.0
    IL_0035: ldfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::_enabledBuildingsUpTo  /*0x04000ACF*/
    IL_003a: bge.s IL_0048
    IL_003c: ldstr "Not enough children in the rewardBuildingsParent to satisfy enabledBuildingsUpTo"
    IL_0041: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_0046: ldc.i4.0
    IL_0047: ret
    IL_0048: ldloc.1
    IL_0049: ldfld Transform LevelInteractor::rewardBuildingsParent  /*0x04000AC6*/
    IL_004e: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0053: ldarg.0
    IL_0054: ldfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::_enabledBuildings  /*0x04000AD0*/
    IL_0059: bge.s IL_0067
    IL_005b: ldstr "Not enough children in the rewardBuildingsParent to satisfy enabledBuildings"
    IL_0060: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_0065: ldc.i4.0
    IL_0066: ret
    IL_0067: ldc.i4.0
    IL_0068: stloc.2
    IL_0069: br.s IL_0086
    IL_006b: ldloc.1
    IL_006c: ldfld Transform LevelInteractor::rewardBuildingsParent  /*0x04000AC6*/
    IL_0071: ldloc.2
    IL_0072: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0077: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_007c: ldc.i4.0
    IL_007d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0082: ldloc.2
    IL_0083: ldc.i4.1
    IL_0084: add
    IL_0085: stloc.2
    IL_0086: ldloc.2
    IL_0087: ldloc.1
    IL_0088: ldfld Transform LevelInteractor::rewardBuildingsParent  /*0x04000AC6*/
    IL_008d: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0092: blt.s IL_006b
    IL_0094: ldc.i4.0
    IL_0095: stloc.3
    IL_0096: br.s IL_00b3
    IL_0098: ldloc.1
    IL_0099: ldfld Transform LevelInteractor::rewardBuildingsParent  /*0x04000AC6*/
    IL_009e: ldloc.3
    IL_009f: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_00a4: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00a9: ldc.i4.1
    IL_00aa: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00af: ldloc.3
    IL_00b0: ldc.i4.1
    IL_00b1: add
    IL_00b2: stloc.3
    IL_00b3: ldloc.3
    IL_00b4: ldarg.0
    IL_00b5: ldfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::_enabledBuildings  /*0x04000AD0*/
    IL_00ba: blt.s IL_0098
    IL_00bc: ldarg.0
    IL_00bd: ldarg.0
    IL_00be: ldfld float LevelInteractor.<EnableBuildingsCoroutine>d__22::_initialDelay  /*0x04000AD1*/
    IL_00c3: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_00c8: stfld object LevelInteractor.<EnableBuildingsCoroutine>d__22::<>2__current  /*0x04000ACD*/
    IL_00cd: ldarg.0
    IL_00ce: ldc.i4.1
    IL_00cf: stfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::<>1__state  /*0x04000ACC*/
    IL_00d4: ldc.i4.1
    IL_00d5: ret
    IL_00d6: ldarg.0
    IL_00d7: ldc.i4.m1
    IL_00d8: stfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::<>1__state  /*0x04000ACC*/
    IL_00dd: ldarg.0
    IL_00de: ldarg.0
    IL_00df: ldfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::_enabledBuildings  /*0x04000AD0*/
    IL_00e4: stfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::<i>5__2  /*0x04000AD3*/
    IL_00e9: br.s IL_015c
    IL_00eb: ldloc.1
    IL_00ec: ldfld Transform LevelInteractor::rewardBuildingsParent  /*0x04000AC6*/
    IL_00f1: ldarg.0
    IL_00f2: ldfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::<i>5__2  /*0x04000AD3*/
    IL_00f7: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_00fc: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0101: ldc.i4.1
    IL_0102: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0107: ldloc.1
    IL_0108: ldfld Transform LevelInteractor::rewardBuildingsParent  /*0x04000AC6*/
    IL_010d: ldarg.0
    IL_010e: ldfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::<i>5__2  /*0x04000AD3*/
    IL_0113: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0118: ldc.i4.0
    IL_0119: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_011e: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0123: ldc.i4.1
    IL_0124: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0129: ldarg.0
    IL_012a: ldarg.0
    IL_012b: ldfld float LevelInteractor.<EnableBuildingsCoroutine>d__22::_interval  /*0x04000AD2*/
    IL_0130: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0135: stfld object LevelInteractor.<EnableBuildingsCoroutine>d__22::<>2__current  /*0x04000ACD*/
    IL_013a: ldarg.0
    IL_013b: ldc.i4.2
    IL_013c: stfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::<>1__state  /*0x04000ACC*/
    IL_0141: ldc.i4.1
    IL_0142: ret
    IL_0143: ldarg.0
    IL_0144: ldc.i4.m1
    IL_0145: stfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::<>1__state  /*0x04000ACC*/
    IL_014a: ldarg.0
    IL_014b: ldfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::<i>5__2  /*0x04000AD3*/
    IL_0150: stloc.s 4
    IL_0152: ldarg.0
    IL_0153: ldloc.s 4
    IL_0155: ldc.i4.1
    IL_0156: add
    IL_0157: stfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::<i>5__2  /*0x04000AD3*/
    IL_015c: ldarg.0
    IL_015d: ldfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::<i>5__2  /*0x04000AD3*/
    IL_0162: ldarg.0
    IL_0163: ldfld int LevelInteractor.<EnableBuildingsCoroutine>d__22::_enabledBuildingsUpTo  /*0x04000ACF*/
    IL_0168: blt.s IL_00eb
    IL_016a: ldc.i4.0
    IL_016b: ret

  .method LevelInteractor.<EnableBuildingsCoroutine>d__22::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060008AC rva 0x29e88 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LevelInteractor.<EnableBuildingsCoroutine>d__22::<>2__current  /*0x04000ACD*/
    IL_0006: ret

  .method LevelInteractor.<EnableBuildingsCoroutine>d__22::System.Collections.IEnumerator.Reset()  // token 0x060008AD rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method LevelInteractor.<EnableBuildingsCoroutine>d__22::System.Collections.IEnumerator.get_Current()  // token 0x060008AE rva 0x29e88 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LevelInteractor.<EnableBuildingsCoroutine>d__22::<>2__current  /*0x04000ACD*/
    IL_0006: ret

