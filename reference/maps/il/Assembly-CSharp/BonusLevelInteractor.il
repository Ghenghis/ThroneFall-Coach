// ===== BonusLevelInteractor  (token 0x020002D7) =====
  .method BonusLevelInteractor::UpdateVisualsOnStart()  // token 0x06000FAC rva 0x47378 attrs Public, HideBySig
    // code size 345 (0x159), max stack 9, init locals
    .locals ([0] int, [1] int, [2] LevelInfo[], [3] int, [4] LevelInfo)
    IL_0000: ldarg.0
    IL_0001: ldfld LevelData BonusLevelInteractor::myLevelData  /*0x04001273*/
    IL_0006: brtrue.s IL_002f
    IL_0008: ldarg.0
    IL_0009: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_000e: stfld LevelProgressManager BonusLevelInteractor::levelProgressManager  /*0x04001272*/
    IL_0013: ldarg.0
    IL_0014: ldarg.0
    IL_0015: ldfld LevelProgressManager BonusLevelInteractor::levelProgressManager  /*0x04001272*/
    IL_001a: ldarg.0
    IL_001b: ldfld LevelInfo BonusLevelInteractor::baseLevelInfo  /*0x0400127E*/
    IL_0020: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0025: callvirt LevelData LevelProgressManager::GetLevelDataForScene(string)  /*0x0600094A*/
    IL_002a: stfld LevelData BonusLevelInteractor::myLevelData  /*0x04001273*/
    IL_002f: ldarg.0
    IL_0030: ldfld GameObject BonusLevelInteractor::lockedLevelVisuals  /*0x04001278*/
    IL_0035: ldc.i4.0
    IL_0036: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003b: ldarg.0
    IL_003c: ldfld GameObject BonusLevelInteractor::unlockedLevelVisuals  /*0x04001279*/
    IL_0041: ldc.i4.0
    IL_0042: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0047: ldarg.0
    IL_0048: ldfld GameObject BonusLevelInteractor::beatenLevelVisuals  /*0x0400127A*/
    IL_004d: ldc.i4.0
    IL_004e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0053: ldarg.0
    IL_0054: ldfld TMP_Text BonusLevelInteractor::questsComplete  /*0x0400127B*/
    IL_0059: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_005e: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_0063: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0068: ldc.i4.0
    IL_0069: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_006e: ldc.i4.0
    IL_006f: stloc.0
    IL_0070: ldc.i4.0
    IL_0071: stloc.1
    IL_0072: ldarg.0
    IL_0073: ldfld LevelInfo[] BonusLevelInteractor::levelsToPick  /*0x0400127D*/
    IL_0078: stloc.2
    IL_0079: ldc.i4.0
    IL_007a: stloc.3
    IL_007b: br.s IL_009a
    IL_007d: ldloc.2
    IL_007e: ldloc.3
    IL_007f: ldelem.ref
    IL_0080: stloc.s 4
    IL_0082: ldloc.0
    IL_0083: ldloc.s 4
    IL_0085: callvirt int LevelInfo::QuestsTotal()  /*0x060008E5*/
    IL_008a: add
    IL_008b: stloc.0
    IL_008c: ldloc.1
    IL_008d: ldloc.s 4
    IL_008f: callvirt int LevelInfo::QuestsComplete()  /*0x060008E4*/
    IL_0094: add
    IL_0095: stloc.1
    IL_0096: ldloc.3
    IL_0097: ldc.i4.1
    IL_0098: add
    IL_0099: stloc.3
    IL_009a: ldloc.3
    IL_009b: ldloc.2
    IL_009c: ldlen
    IL_009d: conv.i4
    IL_009e: blt.s IL_007d
    IL_00a0: ldarg.0
    IL_00a1: ldfld TMP_Text BonusLevelInteractor::questsComplete  /*0x0400127B*/
    IL_00a6: ldloca.s 1
    IL_00a8: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00ad: ldstr "/"
    IL_00b2: ldloca.s 0
    IL_00b4: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00b9: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_00be: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00c3: ldarg.0
    IL_00c4: ldfld TMP_Text BonusLevelInteractor::questsComplete  /*0x0400127B*/
    IL_00c9: ldloc.1
    IL_00ca: ldloc.0
    IL_00cb: bge.s IL_00d5
    IL_00cd: ldarg.0
    IL_00ce: ldfld Color BonusLevelInteractor::notAllQuestComplete  /*0x04001281*/
    IL_00d3: br.s IL_00db
    IL_00d5: ldarg.0
    IL_00d6: ldfld Color BonusLevelInteractor::allQuestComplete  /*0x04001280*/
    IL_00db: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00e0: ldarg.0
    IL_00e1: ldfld TextMeshProUGUI BonusLevelInteractor::challengeName  /*0x0400127C*/
    IL_00e6: ldnull
    IL_00e7: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00ec: brfalse.s IL_010a
    IL_00ee: ldarg.0
    IL_00ef: ldfld TextMeshProUGUI BonusLevelInteractor::challengeName  /*0x0400127C*/
    IL_00f4: ldstr "Menu/Bonus Modes"
    IL_00f9: ldc.i4.1
    IL_00fa: ldc.i4.0
    IL_00fb: ldc.i4.1
    IL_00fc: ldc.i4.0
    IL_00fd: ldnull
    IL_00fe: ldnull
    IL_00ff: ldc.i4.1
    IL_0100: call string I2.Loc.LocalizationManager::GetTermTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001856*/
    IL_0105: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_010a: ldarg.0
    IL_010b: call bool BonusLevelInteractor::get_CanBePlayed()  /*0x06000FAD*/
    IL_0110: brtrue.s IL_011f
    IL_0112: ldarg.0
    IL_0113: ldfld GameObject BonusLevelInteractor::lockedLevelVisuals  /*0x04001278*/
    IL_0118: ldc.i4.1
    IL_0119: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_011e: ret
    IL_011f: ldloc.1
    IL_0120: ldloc.0
    IL_0121: blt.s IL_0131
    IL_0123: ldarg.0
    IL_0124: ldfld GameObject BonusLevelInteractor::beatenLevelVisuals  /*0x0400127A*/
    IL_0129: ldc.i4.1
    IL_012a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_012f: br.s IL_013d
    IL_0131: ldarg.0
    IL_0132: ldfld GameObject BonusLevelInteractor::unlockedLevelVisuals  /*0x04001279*/
    IL_0137: ldc.i4.1
    IL_0138: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_013d: ldarg.0
    IL_013e: ldfld TMP_Text BonusLevelInteractor::questsComplete  /*0x0400127B*/
    IL_0143: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0148: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_014d: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0152: ldc.i4.1
    IL_0153: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0158: ret

  .method BonusLevelInteractor::get_CanBePlayed()  // token 0x06000FAD rva 0x474dd attrs Public, HideBySig, SpecialName
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LevelInfo BonusLevelInteractor::levelToBeatToUnlock  /*0x0400127F*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_001d
    IL_000e: ldarg.0
    IL_000f: ldfld LevelInfo BonusLevelInteractor::levelToBeatToUnlock  /*0x0400127F*/
    IL_0014: callvirt bool LevelInfo::get_Beaten()  /*0x060008E6*/
    IL_0019: brtrue.s IL_001d
    IL_001b: ldc.i4.0
    IL_001c: ret
    IL_001d: ldc.i4.1
    IL_001e: ret

  .method BonusLevelInteractor::get_CanNotBePlayedReason()  // token 0x06000FAE rva 0x47500 attrs Public, HideBySig, SpecialName
    // code size 64 (0x40), max stack 7, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld LevelInfo BonusLevelInteractor::levelToBeatToUnlock  /*0x0400127F*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_003a
    IL_000d: ldarg.0
    IL_000e: ldfld LevelInfo BonusLevelInteractor::levelToBeatToUnlock  /*0x0400127F*/
    IL_0013: callvirt bool LevelInfo::get_Beaten()  /*0x060008E6*/
    IL_0018: brtrue.s IL_003a
    IL_001a: ldstr "Menu/Beat Map to Unlock Cue"
    IL_001f: ldarg.0
    IL_0020: ldfld LevelInfo BonusLevelInteractor::levelToBeatToUnlock  /*0x0400127F*/
    IL_0025: ldfld string LevelInfo::displayName  /*0x04000B20*/
    IL_002a: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_002f: ldc.i4.1
    IL_0030: ldc.i4.1
    IL_0031: ldc.i4.0
    IL_0032: ldc.i4.1
    IL_0033: ldc.i4.1
    IL_0034: call string TextTranslator::TranslateAndInsertMapName(string,string,bool,bool,int,bool,bool)  /*0x060009E5*/
    IL_0039: ret
    IL_003a: ldstr ""
    IL_003f: ret

  .method BonusLevelInteractor::Start()  // token 0x06000FAF rva 0x4754c attrs Private, HideBySig
    // code size 82 (0x52), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponentInParent()<LevelSelectManager>  /*0x2B000093*/
    IL_0007: stfld LevelSelectManager BonusLevelInteractor::levelSelectManager  /*0x04001271*/
    IL_000c: ldarg.0
    IL_000d: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0012: stfld LevelProgressManager BonusLevelInteractor::levelProgressManager  /*0x04001272*/
    IL_0017: ldarg.0
    IL_0018: ldarg.0
    IL_0019: ldfld LevelProgressManager BonusLevelInteractor::levelProgressManager  /*0x04001272*/
    IL_001e: ldarg.0
    IL_001f: ldfld LevelInfo BonusLevelInteractor::baseLevelInfo  /*0x0400127E*/
    IL_0024: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0029: callvirt LevelData LevelProgressManager::GetLevelDataForScene(string)  /*0x0600094A*/
    IL_002e: stfld LevelData BonusLevelInteractor::myLevelData  /*0x04001273*/
    IL_0033: ldarg.0
    IL_0034: ldfld GameObject BonusLevelInteractor::focusPanel  /*0x04001275*/
    IL_0039: ldc.i4.0
    IL_003a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003f: ldarg.0
    IL_0040: ldfld GameObject BonusLevelInteractor::cantBePlayedPanel  /*0x04001276*/
    IL_0045: ldc.i4.0
    IL_0046: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_004b: ldarg.0
    IL_004c: call void BonusLevelInteractor::UpdateVisualsOnStart()  /*0x06000FAC*/
    IL_0051: ret

  .method BonusLevelInteractor::ReturnTooltip()  // token 0x06000FB0 rva 0x475aa attrs Public, Virtual, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool BonusLevelInteractor::get_CanBePlayed()  /*0x06000FAD*/
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

  .method BonusLevelInteractor::GenerateCueText()  // token 0x06000FB1 rva 0x475c8 attrs Private, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool BonusLevelInteractor::get_CanBePlayed()  /*0x06000FAD*/
    IL_0006: brtrue.s IL_000f
    IL_0008: ldarg.0
    IL_0009: call string BonusLevelInteractor::get_CanNotBePlayedReason()  /*0x06000FAE*/
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld LevelSelectManager BonusLevelInteractor::levelSelectManager  /*0x04001271*/
    IL_0015: callvirt bool LevelSelectManager::get_PreLevelMenuIsOpen()  /*0x060008B1*/
    IL_001a: brfalse.s IL_0022
    IL_001c: ldstr ""
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldfld LevelInfo BonusLevelInteractor::baseLevelInfo  /*0x0400127E*/
    IL_0028: callvirt string LevelInfo::get_LocalizedDisplayName()  /*0x060008DF*/
    IL_002d: ret

  .method BonusLevelInteractor::InteractionBegin(PlayerInteraction)  // token 0x06000FB2 rva 0x475f7 attrs Public, Virtual, HideBySig
    // code size 58 (0x3a), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool BonusLevelInteractor::get_CanBePlayed()  /*0x06000FAD*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: stsfld BonusLevelInteractor BonusLevelInteractor::lastSelected  /*0x0400126F*/
    IL_000f: ldarg.0
    IL_0010: ldfld LevelInfo BonusLevelInteractor::baseLevelInfo  /*0x0400127E*/
    IL_0015: stsfld LevelInfo BonusLevelInteractor::lastActiveLevelInfo  /*0x04001270*/
    IL_001a: ldsfld InGamePopUpHelper InGamePopUpHelper::instance  /*0x04001433*/
    IL_001f: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0024: brfalse.s IL_0033
    IL_0026: ldsfld InGamePopUpHelper InGamePopUpHelper::instance  /*0x04001433*/
    IL_002b: callvirt bool InGamePopUpHelper::PopMiniModes()  /*0x060010F6*/
    IL_0030: brfalse.s IL_0033
    IL_0032: ret
    IL_0033: call bool UIFrameManager::TryOpenBonusLevelSelect()  /*0x06001310*/
    IL_0038: pop
    IL_0039: ret

  .method BonusLevelInteractor::Focus(PlayerInteraction)  // token 0x06000FB3 rva 0x47634 attrs Public, Virtual, HideBySig
    // code size 159 (0x9f), max stack 9, init locals
    IL_0000: ldarg.0
    IL_0001: call bool BonusLevelInteractor::get_CanBePlayed()  /*0x06000FAD*/
    IL_0006: brfalse.s IL_004b
    IL_0008: ldarg.0
    IL_0009: ldfld GameObject BonusLevelInteractor::focusPanel  /*0x04001275*/
    IL_000e: ldc.i4.1
    IL_000f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0014: ldarg.0
    IL_0015: ldfld GameObject BonusLevelInteractor::cantBePlayedPanel  /*0x04001276*/
    IL_001a: ldc.i4.0
    IL_001b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0020: ldarg.0
    IL_0021: ldfld TextMeshProUGUI BonusLevelInteractor::challengeName  /*0x0400127C*/
    IL_0026: ldnull
    IL_0027: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002c: brfalse.s IL_009e
    IL_002e: ldarg.0
    IL_002f: ldfld TextMeshProUGUI BonusLevelInteractor::challengeName  /*0x0400127C*/
    IL_0034: ldstr "Menu/Bonus Modes"
    IL_0039: ldc.i4.1
    IL_003a: ldc.i4.0
    IL_003b: ldc.i4.1
    IL_003c: ldc.i4.0
    IL_003d: ldnull
    IL_003e: ldnull
    IL_003f: ldc.i4.1
    IL_0040: call string I2.Loc.LocalizationManager::GetTermTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001856*/
    IL_0045: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_004a: ret
    IL_004b: ldarg.0
    IL_004c: ldfld TextMeshProUGUI BonusLevelInteractor::cantBePlayedCue  /*0x04001277*/
    IL_0051: ldarg.0
    IL_0052: call string BonusLevelInteractor::GenerateCueText()  /*0x06000FB1*/
    IL_0057: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_005c: ldarg.0
    IL_005d: ldfld GameObject BonusLevelInteractor::cantBePlayedPanel  /*0x04001276*/
    IL_0062: ldc.i4.1
    IL_0063: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0068: ldarg.0
    IL_0069: ldfld GameObject BonusLevelInteractor::focusPanel  /*0x04001275*/
    IL_006e: ldc.i4.0
    IL_006f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0074: ldarg.0
    IL_0075: ldfld TextMeshProUGUI BonusLevelInteractor::challengeName  /*0x0400127C*/
    IL_007a: ldnull
    IL_007b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0080: brfalse.s IL_009e
    IL_0082: ldarg.0
    IL_0083: ldfld TextMeshProUGUI BonusLevelInteractor::challengeName  /*0x0400127C*/
    IL_0088: ldstr "Menu/Bonus Modes"
    IL_008d: ldc.i4.1
    IL_008e: ldc.i4.0
    IL_008f: ldc.i4.1
    IL_0090: ldc.i4.0
    IL_0091: ldnull
    IL_0092: ldnull
    IL_0093: ldc.i4.1
    IL_0094: call string I2.Loc.LocalizationManager::GetTermTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001856*/
    IL_0099: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_009e: ret

  .method BonusLevelInteractor::Unfocus(PlayerInteraction)  // token 0x06000FB4 rva 0x476df attrs Public, Virtual, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject BonusLevelInteractor::focusPanel  /*0x04001275*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: ldfld GameObject BonusLevelInteractor::cantBePlayedPanel  /*0x04001276*/
    IL_0012: ldc.i4.0
    IL_0013: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0018: ret

  .method BonusLevelInteractor::.ctor()  // token 0x06000FB5 rva 0x476f9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldstr "Beat <lvlname> to unlock this level."
    IL_0006: stfld string BonusLevelInteractor::tooltipThisLevelMustBeBeaten  /*0x04001274*/
    IL_000b: ldarg.0
    IL_000c: call void InteractorBase::.ctor()  /*0x06000BEE*/
    IL_0011: ret

