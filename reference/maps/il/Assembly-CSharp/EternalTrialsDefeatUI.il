// ===== EternalTrialsDefeatUI  (token 0x020002C2) =====
  .method EternalTrialsDefeatUI::Update()  // token 0x06000F2F rva 0x44e80 attrs Private, HideBySig
    // code size 88 (0x58), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Player EternalTrialsDefeatUI::input  /*0x040011EC*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld Player EternalTrialsDefeatUI::input  /*0x040011EC*/
    IL_000f: ldstr "Interact"
    IL_0014: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0019: brfalse.s IL_0057
    IL_001b: ldarg.0
    IL_001c: ldfld bool EternalTrialsDefeatUI::inScoreUnroll  /*0x040011EE*/
    IL_0021: brfalse.s IL_0057
    IL_0023: ldarg.0
    IL_0024: ldfld Coroutine EternalTrialsDefeatUI::currentScoringAnimation  /*0x040011F8*/
    IL_0029: brfalse.s IL_0037
    IL_002b: ldarg.0
    IL_002c: ldarg.0
    IL_002d: ldfld Coroutine EternalTrialsDefeatUI::currentScoringAnimation  /*0x040011F8*/
    IL_0032: call void UnityEngine.MonoBehaviour::StopCoroutine(UnityEngine.Coroutine)  /*0x0A000114*/
    IL_0037: ldarg.0
    IL_0038: ldnull
    IL_0039: stfld Coroutine EternalTrialsDefeatUI::currentScoringAnimation  /*0x040011F8*/
    IL_003e: ldarg.0
    IL_003f: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_0044: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_0049: ldarg.0
    IL_004a: ldc.i4.1
    IL_004b: stfld bool EternalTrialsDefeatUI::skipScoringAnimation  /*0x040011F7*/
    IL_0050: ldarg.0
    IL_0051: ldc.i4.0
    IL_0052: stfld bool EternalTrialsDefeatUI::inScoreUnroll  /*0x040011EE*/
    IL_0057: ret

  .method EternalTrialsDefeatUI::PlayAnimation(UIFrame)  // token 0x06000F30 rva 0x44ee4 attrs Public, Virtual, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EternalTrialsDefeatUI.<PlayAnimation>d__63::.ctor(int)  /*0x06000F5F*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<PlayAnimation>d__63::<>4__this  /*0x0400121D*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld UIFrame EternalTrialsDefeatUI.<PlayAnimation>d__63::contextFrame  /*0x0400121E*/
    IL_0014: ret

  .method EternalTrialsDefeatUI::Reset()  // token 0x06000F31 rva 0x44efa attrs Public, Virtual, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject EternalTrialsDefeatUI::parentObject  /*0x040011BB*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method EternalTrialsDefeatUI::ETDefeatAnimationSequence()  // token 0x06000F32 rva 0x44f08 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::.ctor(int)  /*0x06000F4D*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>4__this  /*0x04001208*/
    IL_000d: ret

  .method EternalTrialsDefeatUI::GetNextMetaLevel()  // token 0x06000F33 rva 0x44f17 attrs Private, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld PerkManager EternalTrialsDefeatUI::perkManager  /*0x040011EB*/
    IL_0007: callvirt MetaLevel PerkManager::get_NextMetaLevel()  /*0x0600097C*/
    IL_000c: stfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_0011: ldarg.0
    IL_0012: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_0017: brtrue.s IL_001f
    IL_0019: ldarg.0
    IL_001a: call void EternalTrialsDefeatUI::EnableMaxLevelReachedUI()  /*0x06000F34*/
    IL_001f: ret

  .method EternalTrialsDefeatUI::EnableMaxLevelReachedUI()  // token 0x06000F34 rva 0x44f38 attrs Private, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject EternalTrialsDefeatUI::progressionBarParent  /*0x040011CD*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: ldfld GameObject EternalTrialsDefeatUI::regularMaxLevel  /*0x040011CE*/
    IL_0012: ldc.i4.1
    IL_0013: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0018: ldc.i4.8
    IL_0019: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_001e: ret

  .method EternalTrialsDefeatUI::EnableRewardDisplayUI(Equippable)  // token 0x06000F35 rva 0x44f58 attrs Private, HideBySig
    // code size 189 (0xbd), max stack 9, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld TextMeshProUGUI EternalTrialsDefeatUI::levelUpLevelDisplay  /*0x040011C7*/
    IL_0006: ldstr "NEW PERK"
    IL_000b: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0010: ldarg.1
    IL_0011: isinst EquippableWeapon  /*0x0200021B*/
    IL_0016: brfalse.s IL_002a
    IL_0018: ldarg.0
    IL_0019: ldfld TextMeshProUGUI EternalTrialsDefeatUI::levelDisplay  /*0x040011C5*/
    IL_001e: ldstr "NEW WEAPON"
    IL_0023: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0028: br.s IL_005c
    IL_002a: ldarg.1
    IL_002b: isinst EquippableMutation  /*0x02000219*/
    IL_0030: brfalse.s IL_0044
    IL_0032: ldarg.0
    IL_0033: ldfld TextMeshProUGUI EternalTrialsDefeatUI::levelDisplay  /*0x040011C5*/
    IL_0038: ldstr "NEW MUTATOR"
    IL_003d: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0042: br.s IL_005c
    IL_0044: ldarg.1
    IL_0045: isinst EquippableBuildingUpgrade  /*0x02000218*/
    IL_004a: brfalse.s IL_005c
    IL_004c: ldarg.0
    IL_004d: ldfld TextMeshProUGUI EternalTrialsDefeatUI::levelDisplay  /*0x040011C5*/
    IL_0052: ldstr "NEW UPGRADE"
    IL_0057: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_005c: ldarg.0
    IL_005d: ldfld MPImageBasic EternalTrialsDefeatUI::levelUpRewardIcon  /*0x040011D7*/
    IL_0062: ldarg.1
    IL_0063: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_0068: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_006d: ldarg.0
    IL_006e: ldfld MPImageBasic EternalTrialsDefeatUI::levelUpRewardBg  /*0x040011D8*/
    IL_0073: ldarg.0
    IL_0074: ldarg.1
    IL_0075: call Color EternalTrialsDefeatUI::GetColorForEquippable(Equippable)  /*0x06000F3E*/
    IL_007a: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_007f: ldarg.0
    IL_0080: ldfld TextMeshProUGUI EternalTrialsDefeatUI::levelUpRewardDescription  /*0x040011C8*/
    IL_0085: ldstr "<style=\"Header\"><size=35>"
    IL_008a: ldarg.1
    IL_008b: callvirt string Equippable::get_LOCIDENTIFIER_NAME()  /*0x06000B4F*/
    IL_0090: ldc.i4.1
    IL_0091: ldc.i4.0
    IL_0092: ldc.i4.1
    IL_0093: ldc.i4.1
    IL_0094: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0099: ldstr "</style><style=\"Body Light\"><size=25>\n"
    IL_009e: ldarg.1
    IL_009f: callvirt string Equippable::get_LOCIDENTIFIER_DESCRIPTION()  /*0x06000B50*/
    IL_00a4: ldc.i4.1
    IL_00a5: ldc.i4.0
    IL_00a6: ldc.i4.1
    IL_00a7: ldc.i4.1
    IL_00a8: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_00ad: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_00b2: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00b7: call void UIFrameManager::ShowLevelUpReward()  /*0x06001315*/
    IL_00bc: ret

  .method EternalTrialsDefeatUI::UpdateLevelingBar()  // token 0x06000F36 rva 0x45024 attrs Private, HideBySig
    // code size 90 (0x5a), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld TextMeshProUGUI EternalTrialsDefeatUI::xpDisplay  /*0x040011C6*/
    IL_0006: ldarg.0
    IL_0007: ldfld PerkManager EternalTrialsDefeatUI::perkManager  /*0x040011EB*/
    IL_000c: ldflda int PerkManager::xp  /*0x04000BEB*/
    IL_0011: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0016: ldstr " / "
    IL_001b: ldarg.0
    IL_001c: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_0021: ldflda int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_0026: call string System.Int32::ToString()  /*0x0A000031*/
    IL_002b: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0030: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0035: ldarg.0
    IL_0036: ldfld MPImageBasic EternalTrialsDefeatUI::xpFill  /*0x040011D4*/
    IL_003b: ldarg.0
    IL_003c: ldfld PerkManager EternalTrialsDefeatUI::perkManager  /*0x040011EB*/
    IL_0041: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_0046: conv.r4
    IL_0047: ldarg.0
    IL_0048: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_004d: ldfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_0052: conv.r4
    IL_0053: div
    IL_0054: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_0059: ret

  .method EternalTrialsDefeatUI::UnrollScores()  // token 0x06000F37 rva 0x4508a attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EternalTrialsDefeatUI.<UnrollScores>d__70::.ctor(int)  /*0x06000F6B*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<UnrollScores>d__70::<>4__this  /*0x04001229*/
    IL_000d: ret

  .method EternalTrialsDefeatUI::SkipUnrollScores()  // token 0x06000F38 rva 0x4509c attrs Private, HideBySig
    // code size 394 (0x18a), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0006: ldfld int EternalTrialsRun::score  /*0x04000850*/
    IL_000b: stfld int EternalTrialsDefeatUI::baseScoreThisRound  /*0x040011EF*/
    IL_0010: ldarg.0
    IL_0011: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0016: callvirt int EternalTrialsRun::get_StageBonusScore()  /*0x060006FB*/
    IL_001b: stfld int EternalTrialsDefeatUI::stageBonusThisRound  /*0x040011F0*/
    IL_0020: ldarg.0
    IL_0021: ldarg.0
    IL_0022: ldfld int EternalTrialsDefeatUI::baseScoreThisRound  /*0x040011EF*/
    IL_0027: ldarg.0
    IL_0028: ldfld int EternalTrialsDefeatUI::stageBonusThisRound  /*0x040011F0*/
    IL_002d: add
    IL_002e: stfld int EternalTrialsDefeatUI::overallScoreThisRound  /*0x040011F1*/
    IL_0033: ldarg.0
    IL_0034: ldfld TextMeshProUGUI EternalTrialsDefeatUI::baseScore  /*0x040011C1*/
    IL_0039: ldarg.0
    IL_003a: ldflda int EternalTrialsDefeatUI::baseScoreThisRound  /*0x040011EF*/
    IL_003f: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0044: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0049: ldarg.0
    IL_004a: ldfld TextMeshProUGUI EternalTrialsDefeatUI::stageBonus  /*0x040011C2*/
    IL_004f: ldarg.0
    IL_0050: ldflda int EternalTrialsDefeatUI::stageBonusThisRound  /*0x040011F0*/
    IL_0055: call string System.Int32::ToString()  /*0x0A000031*/
    IL_005a: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_005f: ldarg.0
    IL_0060: ldfld TextMeshProUGUI EternalTrialsDefeatUI::overallScore  /*0x040011C3*/
    IL_0065: ldarg.0
    IL_0066: ldflda int EternalTrialsDefeatUI::overallScoreThisRound  /*0x040011F1*/
    IL_006b: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0070: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0075: ldarg.0
    IL_0076: ldfld GameObject EternalTrialsDefeatUI::newHighscoreIndicator  /*0x040011CC*/
    IL_007b: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0080: callvirt bool SceneTransitionManager::get_TotalScoreFromLastMatchIsNewPersonalRecord()  /*0x060009C3*/
    IL_0085: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_008a: ldarg.0
    IL_008b: ldfld TextMeshProUGUI EternalTrialsDefeatUI::bestScore  /*0x040011C4*/
    IL_0090: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0095: callvirt LevelData SceneTransitionManager::get_LevelDataFromLastMatch()  /*0x060009C5*/
    IL_009a: ldflda int LevelData::highscoreBest  /*0x04000BC2*/
    IL_009f: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00a4: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00a9: ldarg.0
    IL_00aa: ldfld GameObject EternalTrialsDefeatUI::dividerParent  /*0x040011D0*/
    IL_00af: ldc.i4.1
    IL_00b0: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00b5: ldarg.0
    IL_00b6: ldfld TextMeshProUGUI EternalTrialsDefeatUI::baseScoreName  /*0x040011CA*/
    IL_00bb: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00c0: ldc.i4.1
    IL_00c1: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00c6: ldarg.0
    IL_00c7: ldfld TextMeshProUGUI EternalTrialsDefeatUI::baseScore  /*0x040011C1*/
    IL_00cc: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00d1: ldc.i4.1
    IL_00d2: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00d7: ldarg.0
    IL_00d8: ldfld TextMeshProUGUI EternalTrialsDefeatUI::stageBonusName  /*0x040011CB*/
    IL_00dd: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00e2: ldc.i4.1
    IL_00e3: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00e8: ldarg.0
    IL_00e9: ldfld TextMeshProUGUI EternalTrialsDefeatUI::stageBonus  /*0x040011C2*/
    IL_00ee: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00f3: ldc.i4.1
    IL_00f4: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00f9: ldarg.0
    IL_00fa: ldfld GameObject EternalTrialsDefeatUI::dividerParent  /*0x040011D0*/
    IL_00ff: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0104: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0109: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_010e: ldarg.0
    IL_010f: ldfld TextMeshProUGUI EternalTrialsDefeatUI::baseScoreName  /*0x040011CA*/
    IL_0114: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0119: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_011e: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0123: ldarg.0
    IL_0124: ldfld TextMeshProUGUI EternalTrialsDefeatUI::baseScore  /*0x040011C1*/
    IL_0129: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_012e: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0133: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0138: ldarg.0
    IL_0139: ldfld TextMeshProUGUI EternalTrialsDefeatUI::stageBonusName  /*0x040011CB*/
    IL_013e: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0143: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0148: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_014d: ldarg.0
    IL_014e: ldfld TextMeshProUGUI EternalTrialsDefeatUI::stageBonus  /*0x040011C2*/
    IL_0153: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0158: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_015d: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0162: ldarg.0
    IL_0163: ldfld TextMeshProUGUI EternalTrialsDefeatUI::overallScore  /*0x040011C3*/
    IL_0168: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_016d: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0172: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0177: ldarg.0
    IL_0178: ldarg.0
    IL_0179: ldc.r4 0.5f
    IL_017e: call IEnumerator EternalTrialsDefeatUI::LockInScoreBump(float)  /*0x06000F3A*/
    IL_0183: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0188: pop
    IL_0189: ret

  .method EternalTrialsDefeatUI::AddToOverallScore(int,float)  // token 0x06000F39 rva 0x45232 attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EternalTrialsDefeatUI.<AddToOverallScore>d__72::.ctor(int)  /*0x06000F41*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>4__this  /*0x040011FC*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld int EternalTrialsDefeatUI.<AddToOverallScore>d__72::scoreToAdd  /*0x040011FB*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld float EternalTrialsDefeatUI.<AddToOverallScore>d__72::animTime  /*0x040011FD*/
    IL_001b: ret

  .method EternalTrialsDefeatUI::LockInScoreBump(float)  // token 0x06000F3A rva 0x4524f attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EternalTrialsDefeatUI.<LockInScoreBump>d__73::.ctor(int)  /*0x06000F59*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<LockInScoreBump>d__73::<>4__this  /*0x04001218*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float EternalTrialsDefeatUI.<LockInScoreBump>d__73::animTime  /*0x04001219*/
    IL_0014: ret

  .method EternalTrialsDefeatUI::Bump(float,UnityEngine.Transform,UnityEngine.AudioClip)  // token 0x06000F3B rva 0x45265 attrs Private, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EternalTrialsDefeatUI.<Bump>d__74::.ctor(int)  /*0x06000F47*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<Bump>d__74::<>4__this  /*0x04001202*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float EternalTrialsDefeatUI.<Bump>d__74::animTime  /*0x04001204*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld Transform EternalTrialsDefeatUI.<Bump>d__74::target  /*0x04001203*/
    IL_001b: dup
    IL_001c: ldarg.3
    IL_001d: stfld AudioClip EternalTrialsDefeatUI.<Bump>d__74::clip  /*0x04001201*/
    IL_0022: ret

  .method EternalTrialsDefeatUI::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  // token 0x06000F3C rva 0x45289 attrs Private, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EternalTrialsDefeatUI.<PopShowTransform>d__75::.ctor(int)  /*0x06000F65*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<PopShowTransform>d__75::<>4__this  /*0x04001222*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld Transform EternalTrialsDefeatUI.<PopShowTransform>d__75::target  /*0x04001223*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld AudioClip EternalTrialsDefeatUI.<PopShowTransform>d__75::clip  /*0x04001221*/
    IL_001b: dup
    IL_001c: ldarg.3
    IL_001d: stfld AnimationCurve EternalTrialsDefeatUI.<PopShowTransform>d__75::curve  /*0x04001224*/
    IL_0022: dup
    IL_0023: ldarg.s 4
    IL_0025: stfld float EternalTrialsDefeatUI.<PopShowTransform>d__75::animTime  /*0x04001225*/
    IL_002a: ret

  .method EternalTrialsDefeatUI::FillUpXPBar(int)  // token 0x06000F3D rva 0x452b5 attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EternalTrialsDefeatUI.<FillUpXPBar>d__76::.ctor(int)  /*0x06000F53*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>4__this  /*0x04001210*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::xp  /*0x0400120F*/
    IL_0014: ret

  .method EternalTrialsDefeatUI::GetColorForEquippable(Equippable)  // token 0x06000F3E rva 0x452cc attrs Private, HideBySig
    // code size 110 (0x6e), max stack 2, init locals
    .locals ([0] Color)
    IL_0000: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0005: stloc.0
    IL_0006: ldarg.1
    IL_0007: isinst EquippableWeapon  /*0x0200021B*/
    IL_000c: brfalse.s IL_0015
    IL_000e: ldarg.0
    IL_000f: ldfld Color EternalTrialsDefeatUI::weaponBG  /*0x040011DA*/
    IL_0014: stloc.0
    IL_0015: ldarg.1
    IL_0016: isinst EquippablePerk  /*0x0200021A*/
    IL_001b: brfalse.s IL_003f
    IL_001d: ldarg.1
    IL_001e: ldfld string Equippable::displayName  /*0x04000E2B*/
    IL_0023: ldstr "Trophy"
    IL_0028: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_002d: brfalse.s IL_0038
    IL_002f: ldarg.0
    IL_0030: ldfld Color EternalTrialsDefeatUI::trophyBG  /*0x040011DF*/
    IL_0035: stloc.0
    IL_0036: br.s IL_003f
    IL_0038: ldarg.0
    IL_0039: ldfld Color EternalTrialsDefeatUI::perkBG  /*0x040011DB*/
    IL_003e: stloc.0
    IL_003f: ldarg.1
    IL_0040: isinst PerkPoint  /*0x0200021C*/
    IL_0045: brfalse.s IL_004e
    IL_0047: ldarg.0
    IL_0048: ldfld Color EternalTrialsDefeatUI::perkpointBG  /*0x040011DD*/
    IL_004d: stloc.0
    IL_004e: ldarg.1
    IL_004f: isinst EquippableMutation  /*0x02000219*/
    IL_0054: brfalse.s IL_005d
    IL_0056: ldarg.0
    IL_0057: ldfld Color EternalTrialsDefeatUI::mutatorBG  /*0x040011DC*/
    IL_005c: stloc.0
    IL_005d: ldarg.1
    IL_005e: isinst EquippableBuildingUpgrade  /*0x02000218*/
    IL_0063: brfalse.s IL_006c
    IL_0065: ldarg.0
    IL_0066: ldfld Color EternalTrialsDefeatUI::buildingUpgradeBG  /*0x040011DE*/
    IL_006b: stloc.0
    IL_006c: ldloc.0
    IL_006d: ret

  .method EternalTrialsDefeatUI::OnDisable()  // token 0x06000F3F rva 0x45346 attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool EternalTrialsDefeatUI::inAnimation  /*0x040011ED*/
    IL_0007: ret

  .method EternalTrialsDefeatUI::.ctor()  // token 0x06000F40 rva 0x45350 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 106 (0x6a), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 3f
    IL_0006: stfld float EternalTrialsDefeatUI::timeToFillUpABar  /*0x040011E5*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.25f
    IL_0011: stfld float EternalTrialsDefeatUI::waitAtBeginning  /*0x040011E6*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.25f
    IL_001c: stfld float EternalTrialsDefeatUI::waitAfterFillingUpABar  /*0x040011E7*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 2f
    IL_0027: stfld float EternalTrialsDefeatUI::waitAfterReward  /*0x040011E8*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 0.5f
    IL_0032: stfld float EternalTrialsDefeatUI::waitWhenMaxLevelAlreadyReached  /*0x040011E9*/
    IL_0037: ldarg.0
    IL_0038: ldc.r4 0.5f
    IL_003d: stfld float EternalTrialsDefeatUI::defaultWaitStep  /*0x040011F3*/
    IL_0042: ldarg.0
    IL_0043: ldc.r4 0.25f
    IL_0048: stfld float EternalTrialsDefeatUI::minorWaitStep  /*0x040011F4*/
    IL_004d: ldarg.0
    IL_004e: ldc.r4 1.5f
    IL_0053: stfld float EternalTrialsDefeatUI::animationStepA  /*0x040011F5*/
    IL_0058: ldarg.0
    IL_0059: ldc.r4 0.5f
    IL_005e: stfld float EternalTrialsDefeatUI::animationStepB  /*0x040011F6*/
    IL_0063: ldarg.0
    IL_0064: call void IUIAnimationSequence::.ctor()  /*0x06000FA1*/
    IL_0069: ret

// ===== EternalTrialsDefeatUI/<AddToOverallScore>d__72  (token 0x020002C3) =====
  .method EternalTrialsDefeatUI.<AddToOverallScore>d__72::.ctor(int)  // token 0x06000F41 rva 0x453c6 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>1__state  /*0x040011F9*/
    IL_000d: ret

  .method EternalTrialsDefeatUI.<AddToOverallScore>d__72::System.IDisposable.Dispose()  // token 0x06000F42 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EternalTrialsDefeatUI.<AddToOverallScore>d__72::MoveNext()  // token 0x06000F43 rva 0x453d8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 386 (0x182), max stack 6, init locals
    .locals ([0] int, [1] EternalTrialsDefeatUI, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>1__state  /*0x040011F9*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>4__this  /*0x040011FC*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0026, IL_004e, IL_010b, IL_0179)
    IL_0024: ldc.i4.0
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldc.i4.m1
    IL_0028: stfld int EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>1__state  /*0x040011F9*/
    IL_002d: ldarg.0
    IL_002e: ldfld int EternalTrialsDefeatUI.<AddToOverallScore>d__72::scoreToAdd  /*0x040011FB*/
    IL_0033: brtrue.s IL_0057
    IL_0035: ldarg.0
    IL_0036: ldc.r4 0.15f
    IL_003b: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0040: stfld object EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>2__current  /*0x040011FA*/
    IL_0045: ldarg.0
    IL_0046: ldc.i4.1
    IL_0047: stfld int EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>1__state  /*0x040011F9*/
    IL_004c: ldc.i4.1
    IL_004d: ret
    IL_004e: ldarg.0
    IL_004f: ldc.i4.m1
    IL_0050: stfld int EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>1__state  /*0x040011F9*/
    IL_0055: ldc.i4.0
    IL_0056: ret
    IL_0057: ldloc.1
    IL_0058: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_005d: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0062: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0067: callvirt AudioClip AudioSet::get_PointFill()  /*0x060001E5*/
    IL_006c: callvirt void UnityEngine.AudioSource::set_clip(UnityEngine.AudioClip)  /*0x0A0000D0*/
    IL_0071: ldloc.1
    IL_0072: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_0077: ldc.i4.1
    IL_0078: callvirt void UnityEngine.AudioSource::set_loop(bool)  /*0x0A0000DF*/
    IL_007d: ldloc.1
    IL_007e: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_0083: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_0088: ldloc.1
    IL_0089: ldloc.1
    IL_008a: ldfld int EternalTrialsDefeatUI::animationNextScore  /*0x040011F2*/
    IL_008f: ldarg.0
    IL_0090: ldfld int EternalTrialsDefeatUI.<AddToOverallScore>d__72::scoreToAdd  /*0x040011FB*/
    IL_0095: add
    IL_0096: stfld int EternalTrialsDefeatUI::animationNextScore  /*0x040011F2*/
    IL_009b: ldarg.0
    IL_009c: ldc.r4 0f
    IL_00a1: stfld float EternalTrialsDefeatUI.<AddToOverallScore>d__72::<timer>5__2  /*0x040011FE*/
    IL_00a6: br.s IL_0112
    IL_00a8: ldarg.0
    IL_00a9: ldarg.0
    IL_00aa: ldfld float EternalTrialsDefeatUI.<AddToOverallScore>d__72::<timer>5__2  /*0x040011FE*/
    IL_00af: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_00b4: add
    IL_00b5: stfld float EternalTrialsDefeatUI.<AddToOverallScore>d__72::<timer>5__2  /*0x040011FE*/
    IL_00ba: ldloc.1
    IL_00bb: ldfld TextMeshProUGUI EternalTrialsDefeatUI::overallScore  /*0x040011C3*/
    IL_00c0: ldloc.1
    IL_00c1: ldfld int EternalTrialsDefeatUI::overallScoreThisRound  /*0x040011F1*/
    IL_00c6: conv.r4
    IL_00c7: ldloc.1
    IL_00c8: ldfld int EternalTrialsDefeatUI::animationNextScore  /*0x040011F2*/
    IL_00cd: conv.r4
    IL_00ce: ldc.r4 0f
    IL_00d3: ldarg.0
    IL_00d4: ldfld float EternalTrialsDefeatUI.<AddToOverallScore>d__72::animTime  /*0x040011FD*/
    IL_00d9: ldarg.0
    IL_00da: ldfld float EternalTrialsDefeatUI.<AddToOverallScore>d__72::<timer>5__2  /*0x040011FE*/
    IL_00df: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_00e4: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_00e9: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_00ee: stloc.2
    IL_00ef: ldloca.s 2
    IL_00f1: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00f6: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00fb: ldarg.0
    IL_00fc: ldnull
    IL_00fd: stfld object EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>2__current  /*0x040011FA*/
    IL_0102: ldarg.0
    IL_0103: ldc.i4.2
    IL_0104: stfld int EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>1__state  /*0x040011F9*/
    IL_0109: ldc.i4.1
    IL_010a: ret
    IL_010b: ldarg.0
    IL_010c: ldc.i4.m1
    IL_010d: stfld int EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>1__state  /*0x040011F9*/
    IL_0112: ldarg.0
    IL_0113: ldfld float EternalTrialsDefeatUI.<AddToOverallScore>d__72::<timer>5__2  /*0x040011FE*/
    IL_0118: ldarg.0
    IL_0119: ldfld float EternalTrialsDefeatUI.<AddToOverallScore>d__72::animTime  /*0x040011FD*/
    IL_011e: blt.s IL_00a8
    IL_0120: ldloc.1
    IL_0121: ldloc.1
    IL_0122: ldfld int EternalTrialsDefeatUI::animationNextScore  /*0x040011F2*/
    IL_0127: stfld int EternalTrialsDefeatUI::overallScoreThisRound  /*0x040011F1*/
    IL_012c: ldloc.1
    IL_012d: ldfld TextMeshProUGUI EternalTrialsDefeatUI::overallScore  /*0x040011C3*/
    IL_0132: ldloc.1
    IL_0133: ldflda int EternalTrialsDefeatUI::overallScoreThisRound  /*0x040011F1*/
    IL_0138: call string System.Int32::ToString()  /*0x0A000031*/
    IL_013d: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0142: ldloc.1
    IL_0143: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_0148: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_014d: ldloc.1
    IL_014e: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_0153: ldc.i4.0
    IL_0154: callvirt void UnityEngine.AudioSource::set_loop(bool)  /*0x0A0000DF*/
    IL_0159: ldarg.0
    IL_015a: ldloc.1
    IL_015b: ldloc.1
    IL_015c: ldc.r4 0.5f
    IL_0161: call IEnumerator EternalTrialsDefeatUI::LockInScoreBump(float)  /*0x06000F3A*/
    IL_0166: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_016b: stfld object EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>2__current  /*0x040011FA*/
    IL_0170: ldarg.0
    IL_0171: ldc.i4.3
    IL_0172: stfld int EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>1__state  /*0x040011F9*/
    IL_0177: ldc.i4.1
    IL_0178: ret
    IL_0179: ldarg.0
    IL_017a: ldc.i4.m1
    IL_017b: stfld int EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>1__state  /*0x040011F9*/
    IL_0180: ldc.i4.0
    IL_0181: ret

  .method EternalTrialsDefeatUI.<AddToOverallScore>d__72::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F44 rva 0x45566 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>2__current  /*0x040011FA*/
    IL_0006: ret

  .method EternalTrialsDefeatUI.<AddToOverallScore>d__72::System.Collections.IEnumerator.Reset()  // token 0x06000F45 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EternalTrialsDefeatUI.<AddToOverallScore>d__72::System.Collections.IEnumerator.get_Current()  // token 0x06000F46 rva 0x45566 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<AddToOverallScore>d__72::<>2__current  /*0x040011FA*/
    IL_0006: ret

// ===== EternalTrialsDefeatUI/<Bump>d__74  (token 0x020002C4) =====
  .method EternalTrialsDefeatUI.<Bump>d__74::.ctor(int)  // token 0x06000F47 rva 0x4556e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EternalTrialsDefeatUI.<Bump>d__74::<>1__state  /*0x040011FF*/
    IL_000d: ret

  .method EternalTrialsDefeatUI.<Bump>d__74::System.IDisposable.Dispose()  // token 0x06000F48 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EternalTrialsDefeatUI.<Bump>d__74::MoveNext()  // token 0x06000F49 rva 0x45580 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 213 (0xd5), max stack 6, init locals
    .locals ([0] int, [1] EternalTrialsDefeatUI)
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsDefeatUI.<Bump>d__74::<>1__state  /*0x040011FF*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<Bump>d__74::<>4__this  /*0x04001202*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_00a9
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int EternalTrialsDefeatUI.<Bump>d__74::<>1__state  /*0x040011FF*/
    IL_0021: ldarg.0
    IL_0022: ldfld AudioClip EternalTrialsDefeatUI.<Bump>d__74::clip  /*0x04001201*/
    IL_0027: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002c: brfalse.s IL_003f
    IL_002e: ldloc.1
    IL_002f: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_0034: ldarg.0
    IL_0035: ldfld AudioClip EternalTrialsDefeatUI.<Bump>d__74::clip  /*0x04001201*/
    IL_003a: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_003f: ldarg.0
    IL_0040: ldc.r4 0f
    IL_0045: stfld float EternalTrialsDefeatUI.<Bump>d__74::<timer>5__2  /*0x04001205*/
    IL_004a: br.s IL_00b0
    IL_004c: ldarg.0
    IL_004d: ldarg.0
    IL_004e: ldfld float EternalTrialsDefeatUI.<Bump>d__74::<timer>5__2  /*0x04001205*/
    IL_0053: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0058: add
    IL_0059: stfld float EternalTrialsDefeatUI.<Bump>d__74::<timer>5__2  /*0x04001205*/
    IL_005e: ldarg.0
    IL_005f: ldfld Transform EternalTrialsDefeatUI.<Bump>d__74::target  /*0x04001203*/
    IL_0064: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0069: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_006e: ldloc.1
    IL_006f: ldfld AnimationCurve EternalTrialsDefeatUI::bumpCurve  /*0x040011E3*/
    IL_0074: ldc.r4 0f
    IL_0079: ldarg.0
    IL_007a: ldfld float EternalTrialsDefeatUI.<Bump>d__74::animTime  /*0x04001204*/
    IL_007f: ldarg.0
    IL_0080: ldfld float EternalTrialsDefeatUI.<Bump>d__74::<timer>5__2  /*0x04001205*/
    IL_0085: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_008a: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_008f: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0094: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0099: ldarg.0
    IL_009a: ldnull
    IL_009b: stfld object EternalTrialsDefeatUI.<Bump>d__74::<>2__current  /*0x04001200*/
    IL_00a0: ldarg.0
    IL_00a1: ldc.i4.1
    IL_00a2: stfld int EternalTrialsDefeatUI.<Bump>d__74::<>1__state  /*0x040011FF*/
    IL_00a7: ldc.i4.1
    IL_00a8: ret
    IL_00a9: ldarg.0
    IL_00aa: ldc.i4.m1
    IL_00ab: stfld int EternalTrialsDefeatUI.<Bump>d__74::<>1__state  /*0x040011FF*/
    IL_00b0: ldarg.0
    IL_00b1: ldfld float EternalTrialsDefeatUI.<Bump>d__74::<timer>5__2  /*0x04001205*/
    IL_00b6: ldarg.0
    IL_00b7: ldfld float EternalTrialsDefeatUI.<Bump>d__74::animTime  /*0x04001204*/
    IL_00bc: blt.s IL_004c
    IL_00be: ldarg.0
    IL_00bf: ldfld Transform EternalTrialsDefeatUI.<Bump>d__74::target  /*0x04001203*/
    IL_00c4: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00c9: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00ce: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00d3: ldc.i4.0
    IL_00d4: ret

  .method EternalTrialsDefeatUI.<Bump>d__74::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F4A rva 0x45661 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<Bump>d__74::<>2__current  /*0x04001200*/
    IL_0006: ret

  .method EternalTrialsDefeatUI.<Bump>d__74::System.Collections.IEnumerator.Reset()  // token 0x06000F4B rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EternalTrialsDefeatUI.<Bump>d__74::System.Collections.IEnumerator.get_Current()  // token 0x06000F4C rva 0x45661 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<Bump>d__74::<>2__current  /*0x04001200*/
    IL_0006: ret

// ===== EternalTrialsDefeatUI/<ETDefeatAnimationSequence>d__65  (token 0x020002C5) =====
  .method EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::.ctor(int)  // token 0x06000F4D rva 0x45669 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_000d: ret

  .method EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::System.IDisposable.Dispose()  // token 0x06000F4E rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::MoveNext()  // token 0x06000F4F rva 0x45678 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1222 (0x4c6), max stack 7, init locals
    .locals ([0] int, [1] EternalTrialsDefeatUI, [2] int, [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>4__this  /*0x04001208*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_003a, IL_019f, IL_0235, IL_02a6, IL_02c7, IL_03d3, IL_0433, IL_0470, IL_0493)
    IL_0038: ldc.i4.0
    IL_0039: ret
    IL_003a: ldarg.0
    IL_003b: ldc.i4.m1
    IL_003c: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_0041: ldloc.1
    IL_0042: ldfld TextMeshProUGUI EternalTrialsDefeatUI::defeatDisplay  /*0x040011C9*/
    IL_0047: ldstr "Menu/Defeat"
    IL_004c: ldc.i4.1
    IL_004d: ldc.i4.0
    IL_004e: ldc.i4.1
    IL_004f: ldc.i4.1
    IL_0050: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0055: ldstr "."
    IL_005a: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_005f: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0064: ldloc.1
    IL_0065: ldfld TextMeshProUGUI EternalTrialsDefeatUI::stageDisplay  /*0x040011C0*/
    IL_006a: ldstr "<style=Body Bold>"
    IL_006f: ldstr "Menu/Stage"
    IL_0074: ldc.i4.1
    IL_0075: ldc.i4.0
    IL_0076: ldc.i4.1
    IL_0077: ldc.i4.1
    IL_0078: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_007d: ldstr "<style=Body Numerals> "
    IL_0082: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0087: ldfld int EternalTrialsRun::stage  /*0x0400084F*/
    IL_008c: ldc.i4.1
    IL_008d: add
    IL_008e: stloc.3
    IL_008f: ldloca.s 3
    IL_0091: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0096: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_009b: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00a0: ldloc.1
    IL_00a1: ldfld TextMeshProUGUI EternalTrialsDefeatUI::baseScore  /*0x040011C1*/
    IL_00a6: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00ab: ldc.i4.0
    IL_00ac: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00b1: ldloc.1
    IL_00b2: ldfld TextMeshProUGUI EternalTrialsDefeatUI::baseScoreName  /*0x040011CA*/
    IL_00b7: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00bc: ldc.i4.0
    IL_00bd: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00c2: ldloc.1
    IL_00c3: ldfld TextMeshProUGUI EternalTrialsDefeatUI::stageBonus  /*0x040011C2*/
    IL_00c8: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00cd: ldc.i4.0
    IL_00ce: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00d3: ldloc.1
    IL_00d4: ldfld TextMeshProUGUI EternalTrialsDefeatUI::stageBonusName  /*0x040011CB*/
    IL_00d9: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00de: ldc.i4.0
    IL_00df: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00e4: ldloc.1
    IL_00e5: ldfld GameObject EternalTrialsDefeatUI::dividerParent  /*0x040011D0*/
    IL_00ea: ldc.i4.0
    IL_00eb: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00f0: ldloc.1
    IL_00f1: ldfld GameObject EternalTrialsDefeatUI::progressionBarORMaxLevelParent  /*0x040011D1*/
    IL_00f6: ldc.i4.0
    IL_00f7: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00fc: ldloc.1
    IL_00fd: ldfld TextMeshProUGUI EternalTrialsDefeatUI::levelDisplay  /*0x040011C5*/
    IL_0102: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0107: ldc.i4.0
    IL_0108: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_010d: ldloc.1
    IL_010e: ldfld GameObject EternalTrialsDefeatUI::newHighscoreIndicator  /*0x040011CC*/
    IL_0113: ldc.i4.0
    IL_0114: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0119: ldloc.1
    IL_011a: ldfld GameObject EternalTrialsDefeatUI::regularMaxLevel  /*0x040011CE*/
    IL_011f: ldc.i4.0
    IL_0120: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0125: ldloc.1
    IL_0126: ldfld GameObject EternalTrialsDefeatUI::progressionBarParent  /*0x040011CD*/
    IL_012b: ldc.i4.1
    IL_012c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0131: ldloc.1
    IL_0132: ldfld CanvasGroup EternalTrialsDefeatUI::mainFrameCG  /*0x040011BC*/
    IL_0137: ldc.r4 0f
    IL_013c: callvirt void UnityEngine.CanvasGroup::set_alpha(float)  /*0x0A000609*/
    IL_0141: ldloc.1
    IL_0142: ldfld GameObject EternalTrialsDefeatUI::parentObject  /*0x040011BB*/
    IL_0147: ldc.i4.1
    IL_0148: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_014d: ldarg.0
    IL_014e: ldc.r4 0f
    IL_0153: stfld float EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<mainFrameFadeTimer>5__2  /*0x04001209*/
    IL_0158: ldarg.0
    IL_0159: ldc.r4 0.25f
    IL_015e: stfld float EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<fadeTime>5__3  /*0x0400120A*/
    IL_0163: br.s IL_01a6
    IL_0165: ldarg.0
    IL_0166: ldarg.0
    IL_0167: ldfld float EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<mainFrameFadeTimer>5__2  /*0x04001209*/
    IL_016c: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0171: add
    IL_0172: stfld float EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<mainFrameFadeTimer>5__2  /*0x04001209*/
    IL_0177: ldloc.1
    IL_0178: ldfld CanvasGroup EternalTrialsDefeatUI::mainFrameCG  /*0x040011BC*/
    IL_017d: ldarg.0
    IL_017e: ldfld float EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<mainFrameFadeTimer>5__2  /*0x04001209*/
    IL_0183: ldarg.0
    IL_0184: ldfld float EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<fadeTime>5__3  /*0x0400120A*/
    IL_0189: div
    IL_018a: callvirt void UnityEngine.CanvasGroup::set_alpha(float)  /*0x0A000609*/
    IL_018f: ldarg.0
    IL_0190: ldnull
    IL_0191: stfld object EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>2__current  /*0x04001207*/
    IL_0196: ldarg.0
    IL_0197: ldc.i4.1
    IL_0198: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_019d: ldc.i4.1
    IL_019e: ret
    IL_019f: ldarg.0
    IL_01a0: ldc.i4.m1
    IL_01a1: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_01a6: ldarg.0
    IL_01a7: ldfld float EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<mainFrameFadeTimer>5__2  /*0x04001209*/
    IL_01ac: ldarg.0
    IL_01ad: ldfld float EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<fadeTime>5__3  /*0x0400120A*/
    IL_01b2: blt.s IL_0165
    IL_01b4: ldloc.1
    IL_01b5: ldfld CanvasGroup EternalTrialsDefeatUI::mainFrameCG  /*0x040011BC*/
    IL_01ba: ldc.r4 1f
    IL_01bf: callvirt void UnityEngine.CanvasGroup::set_alpha(float)  /*0x0A000609*/
    IL_01c4: ldc.r4 0f
    IL_01c9: call void UnityEngine.Time::set_timeScale(float)  /*0x0A00050F*/
    IL_01ce: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_01d3: ldfld int EternalTrialsRun::score  /*0x04000850*/
    IL_01d8: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_01dd: callvirt int EternalTrialsRun::get_StageBonusScore()  /*0x060006FB*/
    IL_01e2: add
    IL_01e3: stloc.2
    IL_01e4: ldarg.0
    IL_01e5: ldloc.2
    IL_01e6: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_01eb: callvirt int LevelProgressManager::get_EternalTrialsHighscore()  /*0x06000942*/
    IL_01f0: cgt
    IL_01f2: stfld bool EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<newHighscore>5__4  /*0x0400120B*/
    IL_01f7: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_01fc: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0201: callvirt int LevelProgressManager::get_EternalTrialsHighscore()  /*0x06000942*/
    IL_0206: ldloc.2
    IL_0207: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_020c: callvirt void LevelProgressManager::set_EternalTrialsHighscore(int)  /*0x06000943*/
    IL_0211: ldloc.1
    IL_0212: ldloc.1
    IL_0213: ldloc.1
    IL_0214: call IEnumerator EternalTrialsDefeatUI::UnrollScores()  /*0x06000F37*/
    IL_0219: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_021e: stfld Coroutine EternalTrialsDefeatUI::currentScoringAnimation  /*0x040011F8*/
    IL_0223: br.s IL_023c
    IL_0225: ldarg.0
    IL_0226: ldnull
    IL_0227: stfld object EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>2__current  /*0x04001207*/
    IL_022c: ldarg.0
    IL_022d: ldc.i4.2
    IL_022e: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_0233: ldc.i4.1
    IL_0234: ret
    IL_0235: ldarg.0
    IL_0236: ldc.i4.m1
    IL_0237: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_023c: ldloc.1
    IL_023d: ldfld Coroutine EternalTrialsDefeatUI::currentScoringAnimation  /*0x040011F8*/
    IL_0242: brtrue.s IL_0225
    IL_0244: ldloc.1
    IL_0245: ldfld bool EternalTrialsDefeatUI::skipScoringAnimation  /*0x040011F7*/
    IL_024a: brfalse.s IL_0252
    IL_024c: ldloc.1
    IL_024d: call void EternalTrialsDefeatUI::SkipUnrollScores()  /*0x06000F38*/
    IL_0252: ldarg.0
    IL_0253: ldfld bool EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<newHighscore>5__4  /*0x0400120B*/
    IL_0258: brfalse.s IL_02d0
    IL_025a: ldloc.1
    IL_025b: ldfld GameObject EternalTrialsDefeatUI::newHighscoreIndicator  /*0x040011CC*/
    IL_0260: ldc.i4.1
    IL_0261: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0266: ldarg.0
    IL_0267: ldloc.1
    IL_0268: ldloc.1
    IL_0269: ldloc.1
    IL_026a: ldfld GameObject EternalTrialsDefeatUI::newHighscoreIndicator  /*0x040011CC*/
    IL_026f: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0274: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0279: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_027e: callvirt AudioClip AudioSet::get_NewHighscore()  /*0x060001E6*/
    IL_0283: ldloc.1
    IL_0284: ldfld AnimationCurve EternalTrialsDefeatUI::popShowCurve  /*0x040011E2*/
    IL_0289: ldc.r4 0.5f
    IL_028e: call IEnumerator EternalTrialsDefeatUI::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06000F3C*/
    IL_0293: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0298: stfld object EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>2__current  /*0x04001207*/
    IL_029d: ldarg.0
    IL_029e: ldc.i4.3
    IL_029f: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_02a4: ldc.i4.1
    IL_02a5: ret
    IL_02a6: ldarg.0
    IL_02a7: ldc.i4.m1
    IL_02a8: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_02ad: ldarg.0
    IL_02ae: ldloc.1
    IL_02af: ldfld float EternalTrialsDefeatUI::minorWaitStep  /*0x040011F4*/
    IL_02b4: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_02b9: stfld object EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>2__current  /*0x04001207*/
    IL_02be: ldarg.0
    IL_02bf: ldc.i4.4
    IL_02c0: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_02c5: ldc.i4.1
    IL_02c6: ret
    IL_02c7: ldarg.0
    IL_02c8: ldc.i4.m1
    IL_02c9: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_02ce: br.s IL_02dc
    IL_02d0: ldloc.1
    IL_02d1: ldfld GameObject EternalTrialsDefeatUI::newHighscoreIndicator  /*0x040011CC*/
    IL_02d6: ldc.i4.0
    IL_02d7: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_02dc: ldarg.0
    IL_02dd: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_02e2: ldfld int EternalTrialsRun::score  /*0x04000850*/
    IL_02e7: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_02ec: callvirt int EternalTrialsRun::get_StageBonusScore()  /*0x060006FB*/
    IL_02f1: add
    IL_02f2: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<xpToGive>5__5  /*0x0400120C*/
    IL_02f7: ldloc.1
    IL_02f8: call void EternalTrialsDefeatUI::GetNextMetaLevel()  /*0x06000F33*/
    IL_02fd: ldloc.1
    IL_02fe: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_0303: brfalse.s IL_0342
    IL_0305: ldloc.1
    IL_0306: ldfld MPImageBasic EternalTrialsDefeatUI::nextUnlockIcon  /*0x040011D5*/
    IL_030b: ldloc.1
    IL_030c: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_0311: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_0316: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_031b: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0320: ldloc.1
    IL_0321: ldfld MPImageBasic EternalTrialsDefeatUI::nextunlockBG  /*0x040011D6*/
    IL_0326: ldloc.1
    IL_0327: ldloc.1
    IL_0328: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_032d: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_0332: call Color EternalTrialsDefeatUI::GetColorForEquippable(Equippable)  /*0x06000F3E*/
    IL_0337: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_033c: ldloc.1
    IL_033d: call void EternalTrialsDefeatUI::UpdateLevelingBar()  /*0x06000F36*/
    IL_0342: ldloc.1
    IL_0343: ldfld TextMeshProUGUI EternalTrialsDefeatUI::levelDisplay  /*0x040011C5*/
    IL_0348: ldstr "Menu/Level"
    IL_034d: ldc.i4.1
    IL_034e: ldc.i4.0
    IL_034f: ldc.i4.1
    IL_0350: ldc.i4.1
    IL_0351: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0356: ldstr " <style=\"Body Numerals\">"
    IL_035b: ldloc.1
    IL_035c: ldfld PerkManager EternalTrialsDefeatUI::perkManager  /*0x040011EB*/
    IL_0361: ldflda int PerkManager::level  /*0x04000BEC*/
    IL_0366: call string System.Int32::ToString()  /*0x0A000031*/
    IL_036b: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0370: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0375: ldloc.1
    IL_0376: ldfld TextMeshProUGUI EternalTrialsDefeatUI::levelDisplay  /*0x040011C5*/
    IL_037b: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0380: ldc.i4.1
    IL_0381: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0386: ldloc.1
    IL_0387: ldloc.1
    IL_0388: ldloc.1
    IL_0389: ldfld TextMeshProUGUI EternalTrialsDefeatUI::levelDisplay  /*0x040011C5*/
    IL_038e: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0393: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0398: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_039d: callvirt AudioClip AudioSet::get_PointScreenBuildB()  /*0x060001E2*/
    IL_03a2: ldloc.1
    IL_03a3: ldfld AnimationCurve EternalTrialsDefeatUI::popShowCurve  /*0x040011E2*/
    IL_03a8: ldloc.1
    IL_03a9: ldfld float EternalTrialsDefeatUI::animationStepB  /*0x040011F6*/
    IL_03ae: call IEnumerator EternalTrialsDefeatUI::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06000F3C*/
    IL_03b3: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_03b8: pop
    IL_03b9: ldarg.0
    IL_03ba: ldloc.1
    IL_03bb: ldfld float EternalTrialsDefeatUI::minorWaitStep  /*0x040011F4*/
    IL_03c0: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_03c5: stfld object EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>2__current  /*0x04001207*/
    IL_03ca: ldarg.0
    IL_03cb: ldc.i4.5
    IL_03cc: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_03d1: ldc.i4.1
    IL_03d2: ret
    IL_03d3: ldarg.0
    IL_03d4: ldc.i4.m1
    IL_03d5: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_03da: ldloc.1
    IL_03db: ldfld GameObject EternalTrialsDefeatUI::progressionBarORMaxLevelParent  /*0x040011D1*/
    IL_03e0: ldc.i4.1
    IL_03e1: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_03e6: ldloc.1
    IL_03e7: ldloc.1
    IL_03e8: ldloc.1
    IL_03e9: ldfld GameObject EternalTrialsDefeatUI::progressionBarORMaxLevelParent  /*0x040011D1*/
    IL_03ee: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_03f3: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_03f8: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_03fd: callvirt AudioClip AudioSet::get_PointScreenBuildC()  /*0x060001E3*/
    IL_0402: ldloc.1
    IL_0403: ldfld AnimationCurve EternalTrialsDefeatUI::popShowCurve  /*0x040011E2*/
    IL_0408: ldloc.1
    IL_0409: ldfld float EternalTrialsDefeatUI::animationStepB  /*0x040011F6*/
    IL_040e: call IEnumerator EternalTrialsDefeatUI::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06000F3C*/
    IL_0413: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0418: pop
    IL_0419: ldarg.0
    IL_041a: ldloc.1
    IL_041b: ldfld float EternalTrialsDefeatUI::defaultWaitStep  /*0x040011F3*/
    IL_0420: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0425: stfld object EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>2__current  /*0x04001207*/
    IL_042a: ldarg.0
    IL_042b: ldc.i4.6
    IL_042c: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_0431: ldc.i4.1
    IL_0432: ret
    IL_0433: ldarg.0
    IL_0434: ldc.i4.m1
    IL_0435: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_043a: ldloc.1
    IL_043b: ldc.i4.1
    IL_043c: stfld bool EternalTrialsDefeatUI::inAnimation  /*0x040011ED*/
    IL_0441: ldloc.1
    IL_0442: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_0447: brfalse.s IL_0479
    IL_0449: ldloc.1
    IL_044a: call void EternalTrialsDefeatUI::UpdateLevelingBar()  /*0x06000F36*/
    IL_044f: ldarg.0
    IL_0450: ldloc.1
    IL_0451: ldloc.1
    IL_0452: ldarg.0
    IL_0453: ldfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<xpToGive>5__5  /*0x0400120C*/
    IL_0458: call IEnumerator EternalTrialsDefeatUI::FillUpXPBar(int)  /*0x06000F3D*/
    IL_045d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0462: stfld object EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>2__current  /*0x04001207*/
    IL_0467: ldarg.0
    IL_0468: ldc.i4.7
    IL_0469: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_046e: ldc.i4.1
    IL_046f: ret
    IL_0470: ldarg.0
    IL_0471: ldc.i4.m1
    IL_0472: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_0477: br.s IL_049a
    IL_0479: ldarg.0
    IL_047a: ldloc.1
    IL_047b: ldfld float EternalTrialsDefeatUI::waitWhenMaxLevelAlreadyReached  /*0x040011E9*/
    IL_0480: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0485: stfld object EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>2__current  /*0x04001207*/
    IL_048a: ldarg.0
    IL_048b: ldc.i4.8
    IL_048c: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_0491: ldc.i4.1
    IL_0492: ret
    IL_0493: ldarg.0
    IL_0494: ldc.i4.m1
    IL_0495: stfld int EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>1__state  /*0x04001206*/
    IL_049a: ldloc.1
    IL_049b: ldc.i4.0
    IL_049c: stfld bool EternalTrialsDefeatUI::inAnimation  /*0x040011ED*/
    IL_04a1: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_04a6: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_04ab: callvirt int LevelProgressManager::get_EternalTrialsHighscore()  /*0x06000942*/
    IL_04b0: ldstr "Eternal Trials Season 4"
    IL_04b5: callvirt void Thronefall.GameServices.IGameServices::UploadHighscore(int,string)  /*0x06003DFD*/
    IL_04ba: ldsfld SaveLoadManager SaveLoadManager::instance  /*0x04000C65*/
    IL_04bf: callvirt void SaveLoadManager::SaveGame()  /*0x060009B5*/
    IL_04c4: ldc.i4.0
    IL_04c5: ret

  .method EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F50 rva 0x45b4a attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>2__current  /*0x04001207*/
    IL_0006: ret

  .method EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::System.Collections.IEnumerator.Reset()  // token 0x06000F51 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::System.Collections.IEnumerator.get_Current()  // token 0x06000F52 rva 0x45b4a attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<ETDefeatAnimationSequence>d__65::<>2__current  /*0x04001207*/
    IL_0006: ret

// ===== EternalTrialsDefeatUI/<FillUpXPBar>d__76  (token 0x020002C6) =====
  .method EternalTrialsDefeatUI.<FillUpXPBar>d__76::.ctor(int)  // token 0x06000F53 rva 0x45b52 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>1__state  /*0x0400120D*/
    IL_000d: ret

  .method EternalTrialsDefeatUI.<FillUpXPBar>d__76::System.IDisposable.Dispose()  // token 0x06000F54 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EternalTrialsDefeatUI.<FillUpXPBar>d__76::MoveNext()  // token 0x06000F55 rva 0x45b64 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1190 (0x4a6), max stack 6, init locals
    .locals ([0] int, [1] EternalTrialsDefeatUI, [2] int, [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>1__state  /*0x0400120D*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>4__this  /*0x04001210*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_002e, IL_0250, IL_02fe, IL_0353, IL_040f, IL_049d)
    IL_002c: ldc.i4.0
    IL_002d: ret
    IL_002e: ldarg.0
    IL_002f: ldc.i4.m1
    IL_0030: stfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>1__state  /*0x0400120D*/
    IL_0035: ldarg.0
    IL_0036: ldarg.0
    IL_0037: ldfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::xp  /*0x0400120F*/
    IL_003c: stfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<xpToGive>5__2  /*0x04001211*/
    IL_0041: ldarg.0
    IL_0042: ldloc.1
    IL_0043: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_0048: ldfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_004d: conv.r4
    IL_004e: ldloc.1
    IL_004f: ldfld float EternalTrialsDefeatUI::timeToFillUpABar  /*0x040011E5*/
    IL_0054: div
    IL_0055: stfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<xpFillSpeed>5__3  /*0x04001212*/
    IL_005a: ldloc.1
    IL_005b: ldfld PerkManager EternalTrialsDefeatUI::perkManager  /*0x040011EB*/
    IL_0060: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_0065: pop
    IL_0066: ldarg.0
    IL_0067: ldloc.1
    IL_0068: ldfld PerkManager EternalTrialsDefeatUI::perkManager  /*0x040011EB*/
    IL_006d: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_0072: conv.r4
    IL_0073: stfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<xpFillFloat>5__4  /*0x04001213*/
    IL_0078: ldc.i4.0
    IL_0079: stloc.2
    IL_007a: ldc.i4.0
    IL_007b: stloc.3
    IL_007c: ldloc.1
    IL_007d: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_0082: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0087: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_008c: callvirt AudioClip AudioSet::get_PointFill()  /*0x060001E5*/
    IL_0091: callvirt void UnityEngine.AudioSource::set_clip(UnityEngine.AudioClip)  /*0x0A0000D0*/
    IL_0096: ldloc.1
    IL_0097: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_009c: ldc.i4.1
    IL_009d: callvirt void UnityEngine.AudioSource::set_loop(bool)  /*0x0A0000DF*/
    IL_00a2: ldloc.1
    IL_00a3: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_00a8: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_00ad: ldarg.0
    IL_00ae: ldc.r4 0f
    IL_00b3: stfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<progressionBarWiggleTime>5__5  /*0x04001214*/
    IL_00b8: br IL_0416
    IL_00bd: ldloc.1
    IL_00be: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_00c3: callvirt bool UnityEngine.AudioSource::get_isPlaying()  /*0x0A00001C*/
    IL_00c8: brtrue.s IL_00d5
    IL_00ca: ldloc.1
    IL_00cb: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_00d0: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_00d5: ldarg.0
    IL_00d6: ldarg.0
    IL_00d7: ldfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<progressionBarWiggleTime>5__5  /*0x04001214*/
    IL_00dc: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_00e1: ldc.r4 10f
    IL_00e6: mul
    IL_00e7: add
    IL_00e8: stfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<progressionBarWiggleTime>5__5  /*0x04001214*/
    IL_00ed: ldloc.1
    IL_00ee: ldfld GameObject EternalTrialsDefeatUI::progressionBarOnly  /*0x040011D2*/
    IL_00f3: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00f8: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00fd: ldloc.1
    IL_00fe: ldfld AnimationCurve EternalTrialsDefeatUI::scoreFillWiggle  /*0x040011E4*/
    IL_0103: ldarg.0
    IL_0104: ldfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<progressionBarWiggleTime>5__5  /*0x04001214*/
    IL_0109: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_010e: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0113: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0118: ldloc.1
    IL_0119: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_011e: ldfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_0123: ldloc.1
    IL_0124: ldfld PerkManager EternalTrialsDefeatUI::perkManager  /*0x040011EB*/
    IL_0129: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_012e: sub
    IL_012f: stloc.3
    IL_0130: ldloc.1
    IL_0131: ldfld Player EternalTrialsDefeatUI::input  /*0x040011EC*/
    IL_0136: ldstr "Interact"
    IL_013b: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0140: brtrue.s IL_014a
    IL_0142: ldloc.1
    IL_0143: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_0148: brtrue.s IL_0153
    IL_014a: ldarg.0
    IL_014b: ldfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<xpToGive>5__2  /*0x04001211*/
    IL_0150: stloc.2
    IL_0151: br.s IL_0184
    IL_0153: ldarg.0
    IL_0154: ldarg.0
    IL_0155: ldfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<xpFillFloat>5__4  /*0x04001213*/
    IL_015a: ldarg.0
    IL_015b: ldfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<xpFillSpeed>5__3  /*0x04001212*/
    IL_0160: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0165: mul
    IL_0166: add
    IL_0167: stfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<xpFillFloat>5__4  /*0x04001213*/
    IL_016c: ldarg.0
    IL_016d: ldfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<xpFillFloat>5__4  /*0x04001213*/
    IL_0172: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0177: ldloc.1
    IL_0178: ldfld PerkManager EternalTrialsDefeatUI::perkManager  /*0x040011EB*/
    IL_017d: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_0182: sub
    IL_0183: stloc.2
    IL_0184: ldloc.2
    IL_0185: ldloc.3
    IL_0186: ble.s IL_018a
    IL_0188: ldloc.3
    IL_0189: stloc.2
    IL_018a: ldloc.1
    IL_018b: ldfld PerkManager EternalTrialsDefeatUI::perkManager  /*0x040011EB*/
    IL_0190: dup
    IL_0191: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_0196: ldloc.2
    IL_0197: add
    IL_0198: stfld int PerkManager::xp  /*0x04000BEB*/
    IL_019d: ldarg.0
    IL_019e: ldarg.0
    IL_019f: ldfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<xpToGive>5__2  /*0x04001211*/
    IL_01a4: ldloc.2
    IL_01a5: sub
    IL_01a6: stfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<xpToGive>5__2  /*0x04001211*/
    IL_01ab: ldloc.1
    IL_01ac: call void EternalTrialsDefeatUI::UpdateLevelingBar()  /*0x06000F36*/
    IL_01b1: ldloc.1
    IL_01b2: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_01b7: brfalse IL_03ff
    IL_01bc: ldloc.1
    IL_01bd: ldfld PerkManager EternalTrialsDefeatUI::perkManager  /*0x040011EB*/
    IL_01c2: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_01c7: ldloc.1
    IL_01c8: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_01cd: ldfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_01d2: blt IL_03ff
    IL_01d7: ldloc.1
    IL_01d8: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_01dd: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_01e2: ldloc.1
    IL_01e3: ldfld ThronefallUIElement EternalTrialsDefeatUI::rewardAcceptButton  /*0x040011E0*/
    IL_01e8: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01ed: ldc.i4.0
    IL_01ee: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01f3: ldloc.1
    IL_01f4: ldfld GameObject EternalTrialsDefeatUI::rewardWaitIndicator  /*0x040011CF*/
    IL_01f9: ldc.i4.1
    IL_01fa: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01ff: ldloc.1
    IL_0200: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_0205: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_020a: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_020f: callvirt AudioClip AudioSet::get_LevelUp()  /*0x060001E7*/
    IL_0214: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_0219: ldloc.1
    IL_021a: ldloc.1
    IL_021b: ldc.r4 0.5f
    IL_0220: ldloc.1
    IL_0221: ldfld GameObject EternalTrialsDefeatUI::nextPerk  /*0x040011D3*/
    IL_0226: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_022b: ldnull
    IL_022c: call IEnumerator EternalTrialsDefeatUI::Bump(float,UnityEngine.Transform,UnityEngine.AudioClip)  /*0x06000F3B*/
    IL_0231: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0236: pop
    IL_0237: ldarg.0
    IL_0238: ldc.r4 0.5f
    IL_023d: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0242: stfld object EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>2__current  /*0x0400120E*/
    IL_0247: ldarg.0
    IL_0248: ldc.i4.1
    IL_0249: stfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>1__state  /*0x0400120D*/
    IL_024e: ldc.i4.1
    IL_024f: ret
    IL_0250: ldarg.0
    IL_0251: ldc.i4.m1
    IL_0252: stfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>1__state  /*0x0400120D*/
    IL_0257: ldloc.1
    IL_0258: ldloc.1
    IL_0259: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_025e: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_0263: call void EternalTrialsDefeatUI::EnableRewardDisplayUI(Equippable)  /*0x06000F35*/
    IL_0268: ldloc.1
    IL_0269: ldfld PerkManager EternalTrialsDefeatUI::perkManager  /*0x040011EB*/
    IL_026e: ldc.i4.0
    IL_026f: stfld int PerkManager::xp  /*0x04000BEB*/
    IL_0274: ldarg.0
    IL_0275: ldc.r4 0f
    IL_027a: stfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<xpFillFloat>5__4  /*0x04001213*/
    IL_027f: ldloc.1
    IL_0280: ldfld PerkManager EternalTrialsDefeatUI::perkManager  /*0x040011EB*/
    IL_0285: dup
    IL_0286: ldfld int PerkManager::level  /*0x04000BEC*/
    IL_028b: ldc.i4.1
    IL_028c: add
    IL_028d: stfld int PerkManager::level  /*0x04000BEC*/
    IL_0292: ldloc.1
    IL_0293: call void EternalTrialsDefeatUI::GetNextMetaLevel()  /*0x06000F33*/
    IL_0298: ldarg.0
    IL_0299: ldc.r4 0f
    IL_029e: stfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<timer>5__6  /*0x04001215*/
    IL_02a3: br.s IL_0305
    IL_02a5: ldarg.0
    IL_02a6: ldfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<timer>5__6  /*0x04001215*/
    IL_02ab: ldc.r4 0f
    IL_02b0: beq.s IL_02c4
    IL_02b2: ldloc.1
    IL_02b3: ldfld Player EternalTrialsDefeatUI::input  /*0x040011EC*/
    IL_02b8: ldstr "Interact"
    IL_02bd: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_02c2: brtrue.s IL_0313
    IL_02c4: ldarg.0
    IL_02c5: ldarg.0
    IL_02c6: ldfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<timer>5__6  /*0x04001215*/
    IL_02cb: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_02d0: add
    IL_02d1: stfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<timer>5__6  /*0x04001215*/
    IL_02d6: ldloc.1
    IL_02d7: ldfld MPImageBasic EternalTrialsDefeatUI::rewardWaitFill  /*0x040011D9*/
    IL_02dc: ldarg.0
    IL_02dd: ldfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<timer>5__6  /*0x04001215*/
    IL_02e2: ldloc.1
    IL_02e3: ldfld float EternalTrialsDefeatUI::waitAfterReward  /*0x040011E8*/
    IL_02e8: div
    IL_02e9: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_02ee: ldarg.0
    IL_02ef: ldnull
    IL_02f0: stfld object EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>2__current  /*0x0400120E*/
    IL_02f5: ldarg.0
    IL_02f6: ldc.i4.2
    IL_02f7: stfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>1__state  /*0x0400120D*/
    IL_02fc: ldc.i4.1
    IL_02fd: ret
    IL_02fe: ldarg.0
    IL_02ff: ldc.i4.m1
    IL_0300: stfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>1__state  /*0x0400120D*/
    IL_0305: ldarg.0
    IL_0306: ldfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<timer>5__6  /*0x04001215*/
    IL_030b: ldloc.1
    IL_030c: ldfld float EternalTrialsDefeatUI::waitAfterReward  /*0x040011E8*/
    IL_0311: blt.s IL_02a5
    IL_0313: ldloc.1
    IL_0314: ldfld ThronefallUIElement EternalTrialsDefeatUI::rewardAcceptButton  /*0x040011E0*/
    IL_0319: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_031e: ldc.i4.1
    IL_031f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0324: ldloc.1
    IL_0325: ldfld GameObject EternalTrialsDefeatUI::rewardWaitIndicator  /*0x040011CF*/
    IL_032a: ldc.i4.0
    IL_032b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0330: ldloc.1
    IL_0331: ldfld UIFrame EternalTrialsDefeatUI::rewardFrame  /*0x040011E1*/
    IL_0336: ldloc.1
    IL_0337: ldfld ThronefallUIElement EternalTrialsDefeatUI::rewardAcceptButton  /*0x040011E0*/
    IL_033c: callvirt void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_0341: br.s IL_035a
    IL_0343: ldarg.0
    IL_0344: ldnull
    IL_0345: stfld object EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>2__current  /*0x0400120E*/
    IL_034a: ldarg.0
    IL_034b: ldc.i4.3
    IL_034c: stfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>1__state  /*0x0400120D*/
    IL_0351: ldc.i4.1
    IL_0352: ret
    IL_0353: ldarg.0
    IL_0354: ldc.i4.m1
    IL_0355: stfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>1__state  /*0x0400120D*/
    IL_035a: ldloc.1
    IL_035b: ldfld UIFrame EternalTrialsDefeatUI::frame  /*0x040011BD*/
    IL_0360: callvirt bool UIFrame::get_Interactable()  /*0x060012E9*/
    IL_0365: brfalse.s IL_0343
    IL_0367: ldloc.1
    IL_0368: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_036d: brfalse IL_03f5
    IL_0372: ldarg.0
    IL_0373: ldloc.1
    IL_0374: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_0379: ldfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_037e: conv.r4
    IL_037f: ldloc.1
    IL_0380: ldfld float EternalTrialsDefeatUI::timeToFillUpABar  /*0x040011E5*/
    IL_0385: div
    IL_0386: stfld float EternalTrialsDefeatUI.<FillUpXPBar>d__76::<xpFillSpeed>5__3  /*0x04001212*/
    IL_038b: ldloc.1
    IL_038c: ldfld TextMeshProUGUI EternalTrialsDefeatUI::levelDisplay  /*0x040011C5*/
    IL_0391: ldstr "Menu/Level"
    IL_0396: ldc.i4.1
    IL_0397: ldc.i4.0
    IL_0398: ldc.i4.1
    IL_0399: ldc.i4.1
    IL_039a: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_039f: ldstr " <style=\"Body Numerals\">"
    IL_03a4: ldloc.1
    IL_03a5: ldfld PerkManager EternalTrialsDefeatUI::perkManager  /*0x040011EB*/
    IL_03aa: ldflda int PerkManager::level  /*0x04000BEC*/
    IL_03af: call string System.Int32::ToString()  /*0x0A000031*/
    IL_03b4: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_03b9: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_03be: ldloc.1
    IL_03bf: ldfld MPImageBasic EternalTrialsDefeatUI::nextUnlockIcon  /*0x040011D5*/
    IL_03c4: ldloc.1
    IL_03c5: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_03ca: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_03cf: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_03d4: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_03d9: ldloc.1
    IL_03da: ldfld MPImageBasic EternalTrialsDefeatUI::nextunlockBG  /*0x040011D6*/
    IL_03df: ldloc.1
    IL_03e0: ldloc.1
    IL_03e1: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_03e6: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_03eb: call Color EternalTrialsDefeatUI::GetColorForEquippable(Equippable)  /*0x06000F3E*/
    IL_03f0: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_03f5: ldc.r4 0f
    IL_03fa: call void UnityEngine.Time::set_timeScale(float)  /*0x0A00050F*/
    IL_03ff: ldarg.0
    IL_0400: ldnull
    IL_0401: stfld object EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>2__current  /*0x0400120E*/
    IL_0406: ldarg.0
    IL_0407: ldc.i4.4
    IL_0408: stfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>1__state  /*0x0400120D*/
    IL_040d: ldc.i4.1
    IL_040e: ret
    IL_040f: ldarg.0
    IL_0410: ldc.i4.m1
    IL_0411: stfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>1__state  /*0x0400120D*/
    IL_0416: ldarg.0
    IL_0417: ldfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<xpToGive>5__2  /*0x04001211*/
    IL_041c: ldc.i4.0
    IL_041d: ble.s IL_042a
    IL_041f: ldloc.1
    IL_0420: ldfld MetaLevel EternalTrialsDefeatUI::nextMetaLevel  /*0x040011EA*/
    IL_0425: brtrue IL_00bd
    IL_042a: ldloc.1
    IL_042b: ldfld GameObject EternalTrialsDefeatUI::progressionBarOnly  /*0x040011D2*/
    IL_0430: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0435: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_043a: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_043f: ldloc.1
    IL_0440: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_0445: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_044a: ldloc.1
    IL_044b: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_0450: ldc.i4.0
    IL_0451: callvirt void UnityEngine.AudioSource::set_loop(bool)  /*0x0A0000DF*/
    IL_0456: ldloc.1
    IL_0457: ldloc.1
    IL_0458: ldloc.1
    IL_0459: ldfld float EternalTrialsDefeatUI::animationStepB  /*0x040011F6*/
    IL_045e: ldloc.1
    IL_045f: ldfld GameObject EternalTrialsDefeatUI::progressionBarParent  /*0x040011CD*/
    IL_0464: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0469: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_046e: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0473: callvirt AudioClip AudioSet::get_PointLockInMinor()  /*0x060001DF*/
    IL_0478: call IEnumerator EternalTrialsDefeatUI::Bump(float,UnityEngine.Transform,UnityEngine.AudioClip)  /*0x06000F3B*/
    IL_047d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0482: pop
    IL_0483: ldarg.0
    IL_0484: ldloc.1
    IL_0485: ldfld float EternalTrialsDefeatUI::minorWaitStep  /*0x040011F4*/
    IL_048a: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_048f: stfld object EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>2__current  /*0x0400120E*/
    IL_0494: ldarg.0
    IL_0495: ldc.i4.5
    IL_0496: stfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>1__state  /*0x0400120D*/
    IL_049b: ldc.i4.1
    IL_049c: ret
    IL_049d: ldarg.0
    IL_049e: ldc.i4.m1
    IL_049f: stfld int EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>1__state  /*0x0400120D*/
    IL_04a4: ldc.i4.0
    IL_04a5: ret

  .method EternalTrialsDefeatUI.<FillUpXPBar>d__76::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F56 rva 0x46016 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>2__current  /*0x0400120E*/
    IL_0006: ret

  .method EternalTrialsDefeatUI.<FillUpXPBar>d__76::System.Collections.IEnumerator.Reset()  // token 0x06000F57 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EternalTrialsDefeatUI.<FillUpXPBar>d__76::System.Collections.IEnumerator.get_Current()  // token 0x06000F58 rva 0x46016 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<FillUpXPBar>d__76::<>2__current  /*0x0400120E*/
    IL_0006: ret

// ===== EternalTrialsDefeatUI/<LockInScoreBump>d__73  (token 0x020002C7) =====
  .method EternalTrialsDefeatUI.<LockInScoreBump>d__73::.ctor(int)  // token 0x06000F59 rva 0x4601e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EternalTrialsDefeatUI.<LockInScoreBump>d__73::<>1__state  /*0x04001216*/
    IL_000d: ret

  .method EternalTrialsDefeatUI.<LockInScoreBump>d__73::System.IDisposable.Dispose()  // token 0x06000F5A rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EternalTrialsDefeatUI.<LockInScoreBump>d__73::MoveNext()  // token 0x06000F5B rva 0x46030 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 214 (0xd6), max stack 6, init locals
    .locals ([0] int, [1] EternalTrialsDefeatUI)
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsDefeatUI.<LockInScoreBump>d__73::<>1__state  /*0x04001216*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<LockInScoreBump>d__73::<>4__this  /*0x04001218*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_00aa
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int EternalTrialsDefeatUI.<LockInScoreBump>d__73::<>1__state  /*0x04001216*/
    IL_0021: ldloc.1
    IL_0022: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_0027: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_002c: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0031: callvirt AudioClip AudioSet::get_PointLockInMajor()  /*0x060001E0*/
    IL_0036: ldc.r4 0.85f
    IL_003b: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_0040: ldarg.0
    IL_0041: ldc.r4 0f
    IL_0046: stfld float EternalTrialsDefeatUI.<LockInScoreBump>d__73::<timer>5__2  /*0x0400121A*/
    IL_004b: br.s IL_00b1
    IL_004d: ldarg.0
    IL_004e: ldarg.0
    IL_004f: ldfld float EternalTrialsDefeatUI.<LockInScoreBump>d__73::<timer>5__2  /*0x0400121A*/
    IL_0054: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0059: add
    IL_005a: stfld float EternalTrialsDefeatUI.<LockInScoreBump>d__73::<timer>5__2  /*0x0400121A*/
    IL_005f: ldloc.1
    IL_0060: ldfld TextMeshProUGUI EternalTrialsDefeatUI::overallScore  /*0x040011C3*/
    IL_0065: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_006a: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_006f: ldloc.1
    IL_0070: ldfld AnimationCurve EternalTrialsDefeatUI::bumpCurve  /*0x040011E3*/
    IL_0075: ldc.r4 0f
    IL_007a: ldarg.0
    IL_007b: ldfld float EternalTrialsDefeatUI.<LockInScoreBump>d__73::animTime  /*0x04001219*/
    IL_0080: ldarg.0
    IL_0081: ldfld float EternalTrialsDefeatUI.<LockInScoreBump>d__73::<timer>5__2  /*0x0400121A*/
    IL_0086: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_008b: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0090: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0095: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_009a: ldarg.0
    IL_009b: ldnull
    IL_009c: stfld object EternalTrialsDefeatUI.<LockInScoreBump>d__73::<>2__current  /*0x04001217*/
    IL_00a1: ldarg.0
    IL_00a2: ldc.i4.1
    IL_00a3: stfld int EternalTrialsDefeatUI.<LockInScoreBump>d__73::<>1__state  /*0x04001216*/
    IL_00a8: ldc.i4.1
    IL_00a9: ret
    IL_00aa: ldarg.0
    IL_00ab: ldc.i4.m1
    IL_00ac: stfld int EternalTrialsDefeatUI.<LockInScoreBump>d__73::<>1__state  /*0x04001216*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld float EternalTrialsDefeatUI.<LockInScoreBump>d__73::<timer>5__2  /*0x0400121A*/
    IL_00b7: ldarg.0
    IL_00b8: ldfld float EternalTrialsDefeatUI.<LockInScoreBump>d__73::animTime  /*0x04001219*/
    IL_00bd: blt.s IL_004d
    IL_00bf: ldloc.1
    IL_00c0: ldfld TextMeshProUGUI EternalTrialsDefeatUI::overallScore  /*0x040011C3*/
    IL_00c5: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_00ca: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00cf: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00d4: ldc.i4.0
    IL_00d5: ret

  .method EternalTrialsDefeatUI.<LockInScoreBump>d__73::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F5C rva 0x46112 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<LockInScoreBump>d__73::<>2__current  /*0x04001217*/
    IL_0006: ret

  .method EternalTrialsDefeatUI.<LockInScoreBump>d__73::System.Collections.IEnumerator.Reset()  // token 0x06000F5D rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EternalTrialsDefeatUI.<LockInScoreBump>d__73::System.Collections.IEnumerator.get_Current()  // token 0x06000F5E rva 0x46112 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<LockInScoreBump>d__73::<>2__current  /*0x04001217*/
    IL_0006: ret

// ===== EternalTrialsDefeatUI/<PlayAnimation>d__63  (token 0x020002C8) =====
  .method EternalTrialsDefeatUI.<PlayAnimation>d__63::.ctor(int)  // token 0x06000F5F rva 0x4611a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EternalTrialsDefeatUI.<PlayAnimation>d__63::<>1__state  /*0x0400121B*/
    IL_000d: ret

  .method EternalTrialsDefeatUI.<PlayAnimation>d__63::System.IDisposable.Dispose()  // token 0x06000F60 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EternalTrialsDefeatUI.<PlayAnimation>d__63::MoveNext()  // token 0x06000F61 rva 0x4612c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 178 (0xb2), max stack 3, init locals
    .locals ([0] int, [1] EternalTrialsDefeatUI)
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsDefeatUI.<PlayAnimation>d__63::<>1__state  /*0x0400121B*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<PlayAnimation>d__63::<>4__this  /*0x0400121D*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_0081, IL_00a9)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int EternalTrialsDefeatUI.<PlayAnimation>d__63::<>1__state  /*0x0400121B*/
    IL_0029: ldloc.1
    IL_002a: ldc.i4.1
    IL_002b: stfld bool EternalTrialsDefeatUI::inAnimation  /*0x040011ED*/
    IL_0030: ldloc.1
    IL_0031: ldc.i4.0
    IL_0032: stfld bool EternalTrialsDefeatUI::inScoreUnroll  /*0x040011EE*/
    IL_0037: ldloc.1
    IL_0038: ldc.i4.0
    IL_0039: stfld bool EternalTrialsDefeatUI::skipScoringAnimation  /*0x040011F7*/
    IL_003e: ldloc.1
    IL_003f: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0044: stfld PerkManager EternalTrialsDefeatUI::perkManager  /*0x040011EB*/
    IL_0049: ldloc.1
    IL_004a: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_004f: ldc.i4.0
    IL_0050: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_0055: stfld Player EternalTrialsDefeatUI::input  /*0x040011EC*/
    IL_005a: ldloc.1
    IL_005b: ldfld GameObject EternalTrialsDefeatUI::parentObject  /*0x040011BB*/
    IL_0060: ldc.i4.1
    IL_0061: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0066: ldarg.0
    IL_0067: ldloc.1
    IL_0068: ldloc.1
    IL_0069: call IEnumerator EternalTrialsDefeatUI::ETDefeatAnimationSequence()  /*0x06000F32*/
    IL_006e: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0073: stfld object EternalTrialsDefeatUI.<PlayAnimation>d__63::<>2__current  /*0x0400121C*/
    IL_0078: ldarg.0
    IL_0079: ldc.i4.1
    IL_007a: stfld int EternalTrialsDefeatUI.<PlayAnimation>d__63::<>1__state  /*0x0400121B*/
    IL_007f: ldc.i4.1
    IL_0080: ret
    IL_0081: ldarg.0
    IL_0082: ldc.i4.m1
    IL_0083: stfld int EternalTrialsDefeatUI.<PlayAnimation>d__63::<>1__state  /*0x0400121B*/
    IL_0088: ldarg.0
    IL_0089: ldfld UIFrame EternalTrialsDefeatUI.<PlayAnimation>d__63::contextFrame  /*0x0400121E*/
    IL_008e: ldloc.1
    IL_008f: ldfld ThronefallUIElement EternalTrialsDefeatUI::continueButton  /*0x040011BE*/
    IL_0094: callvirt void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_0099: ldarg.0
    IL_009a: ldnull
    IL_009b: stfld object EternalTrialsDefeatUI.<PlayAnimation>d__63::<>2__current  /*0x0400121C*/
    IL_00a0: ldarg.0
    IL_00a1: ldc.i4.2
    IL_00a2: stfld int EternalTrialsDefeatUI.<PlayAnimation>d__63::<>1__state  /*0x0400121B*/
    IL_00a7: ldc.i4.1
    IL_00a8: ret
    IL_00a9: ldarg.0
    IL_00aa: ldc.i4.m1
    IL_00ab: stfld int EternalTrialsDefeatUI.<PlayAnimation>d__63::<>1__state  /*0x0400121B*/
    IL_00b0: ldc.i4.0
    IL_00b1: ret

  .method EternalTrialsDefeatUI.<PlayAnimation>d__63::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F62 rva 0x461ea attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<PlayAnimation>d__63::<>2__current  /*0x0400121C*/
    IL_0006: ret

  .method EternalTrialsDefeatUI.<PlayAnimation>d__63::System.Collections.IEnumerator.Reset()  // token 0x06000F63 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EternalTrialsDefeatUI.<PlayAnimation>d__63::System.Collections.IEnumerator.get_Current()  // token 0x06000F64 rva 0x461ea attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<PlayAnimation>d__63::<>2__current  /*0x0400121C*/
    IL_0006: ret

// ===== EternalTrialsDefeatUI/<PopShowTransform>d__75  (token 0x020002C9) =====
  .method EternalTrialsDefeatUI.<PopShowTransform>d__75::.ctor(int)  // token 0x06000F65 rva 0x461f2 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EternalTrialsDefeatUI.<PopShowTransform>d__75::<>1__state  /*0x0400121F*/
    IL_000d: ret

  .method EternalTrialsDefeatUI.<PopShowTransform>d__75::System.IDisposable.Dispose()  // token 0x06000F66 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EternalTrialsDefeatUI.<PopShowTransform>d__75::MoveNext()  // token 0x06000F67 rva 0x46204 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 203 (0xcb), max stack 6, init locals
    .locals ([0] int, [1] EternalTrialsDefeatUI)
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsDefeatUI.<PopShowTransform>d__75::<>1__state  /*0x0400121F*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<PopShowTransform>d__75::<>4__this  /*0x04001222*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_00a4
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int EternalTrialsDefeatUI.<PopShowTransform>d__75::<>1__state  /*0x0400121F*/
    IL_0021: ldarg.0
    IL_0022: ldfld AudioClip EternalTrialsDefeatUI.<PopShowTransform>d__75::clip  /*0x04001221*/
    IL_0027: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002c: brfalse.s IL_003f
    IL_002e: ldloc.1
    IL_002f: ldfld AudioSource EternalTrialsDefeatUI::audioSource  /*0x040011BF*/
    IL_0034: ldarg.0
    IL_0035: ldfld AudioClip EternalTrialsDefeatUI.<PopShowTransform>d__75::clip  /*0x04001221*/
    IL_003a: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_003f: ldarg.0
    IL_0040: ldc.r4 0f
    IL_0045: stfld float EternalTrialsDefeatUI.<PopShowTransform>d__75::<timer>5__2  /*0x04001226*/
    IL_004a: br.s IL_00ab
    IL_004c: ldarg.0
    IL_004d: ldarg.0
    IL_004e: ldfld float EternalTrialsDefeatUI.<PopShowTransform>d__75::<timer>5__2  /*0x04001226*/
    IL_0053: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0058: add
    IL_0059: stfld float EternalTrialsDefeatUI.<PopShowTransform>d__75::<timer>5__2  /*0x04001226*/
    IL_005e: ldarg.0
    IL_005f: ldfld Transform EternalTrialsDefeatUI.<PopShowTransform>d__75::target  /*0x04001223*/
    IL_0064: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0069: ldarg.0
    IL_006a: ldfld AnimationCurve EternalTrialsDefeatUI.<PopShowTransform>d__75::curve  /*0x04001224*/
    IL_006f: ldc.r4 0f
    IL_0074: ldarg.0
    IL_0075: ldfld float EternalTrialsDefeatUI.<PopShowTransform>d__75::animTime  /*0x04001225*/
    IL_007a: ldarg.0
    IL_007b: ldfld float EternalTrialsDefeatUI.<PopShowTransform>d__75::<timer>5__2  /*0x04001226*/
    IL_0080: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0085: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_008a: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_008f: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0094: ldarg.0
    IL_0095: ldnull
    IL_0096: stfld object EternalTrialsDefeatUI.<PopShowTransform>d__75::<>2__current  /*0x04001220*/
    IL_009b: ldarg.0
    IL_009c: ldc.i4.1
    IL_009d: stfld int EternalTrialsDefeatUI.<PopShowTransform>d__75::<>1__state  /*0x0400121F*/
    IL_00a2: ldc.i4.1
    IL_00a3: ret
    IL_00a4: ldarg.0
    IL_00a5: ldc.i4.m1
    IL_00a6: stfld int EternalTrialsDefeatUI.<PopShowTransform>d__75::<>1__state  /*0x0400121F*/
    IL_00ab: ldarg.0
    IL_00ac: ldfld float EternalTrialsDefeatUI.<PopShowTransform>d__75::<timer>5__2  /*0x04001226*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld float EternalTrialsDefeatUI.<PopShowTransform>d__75::animTime  /*0x04001225*/
    IL_00b7: blt.s IL_004c
    IL_00b9: ldarg.0
    IL_00ba: ldfld Transform EternalTrialsDefeatUI.<PopShowTransform>d__75::target  /*0x04001223*/
    IL_00bf: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00c4: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00c9: ldc.i4.0
    IL_00ca: ret

  .method EternalTrialsDefeatUI.<PopShowTransform>d__75::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F68 rva 0x462db attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<PopShowTransform>d__75::<>2__current  /*0x04001220*/
    IL_0006: ret

  .method EternalTrialsDefeatUI.<PopShowTransform>d__75::System.Collections.IEnumerator.Reset()  // token 0x06000F69 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EternalTrialsDefeatUI.<PopShowTransform>d__75::System.Collections.IEnumerator.get_Current()  // token 0x06000F6A rva 0x462db attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<PopShowTransform>d__75::<>2__current  /*0x04001220*/
    IL_0006: ret

// ===== EternalTrialsDefeatUI/<UnrollScores>d__70  (token 0x020002CA) =====
  .method EternalTrialsDefeatUI.<UnrollScores>d__70::.ctor(int)  // token 0x06000F6B rva 0x462e3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EternalTrialsDefeatUI.<UnrollScores>d__70::<>1__state  /*0x04001227*/
    IL_000d: ret

  .method EternalTrialsDefeatUI.<UnrollScores>d__70::System.IDisposable.Dispose()  // token 0x06000F6C rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EternalTrialsDefeatUI.<UnrollScores>d__70::MoveNext()  // token 0x06000F6D rva 0x462f4 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 733 (0x2dd), max stack 6, init locals
    .locals ([0] int, [1] EternalTrialsDefeatUI, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsDefeatUI.<UnrollScores>d__70::<>1__state  /*0x04001227*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EternalTrialsDefeatUI EternalTrialsDefeatUI.<UnrollScores>d__70::<>4__this  /*0x04001229*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0032, IL_015c, IL_01b3, IL_01db, IL_0240, IL_02a5, IL_02cd)
    IL_0030: ldc.i4.0
    IL_0031: ret
    IL_0032: ldarg.0
    IL_0033: ldc.i4.m1
    IL_0034: stfld int EternalTrialsDefeatUI.<UnrollScores>d__70::<>1__state  /*0x04001227*/
    IL_0039: ldloc.1
    IL_003a: ldc.i4.1
    IL_003b: stfld bool EternalTrialsDefeatUI::inScoreUnroll  /*0x040011EE*/
    IL_0040: ldloc.1
    IL_0041: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0046: ldfld int EternalTrialsRun::score  /*0x04000850*/
    IL_004b: stfld int EternalTrialsDefeatUI::baseScoreThisRound  /*0x040011EF*/
    IL_0050: ldloc.1
    IL_0051: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0056: callvirt int EternalTrialsRun::get_StageBonusScore()  /*0x060006FB*/
    IL_005b: stfld int EternalTrialsDefeatUI::stageBonusThisRound  /*0x040011F0*/
    IL_0060: ldloc.1
    IL_0061: ldc.i4.0
    IL_0062: stfld int EternalTrialsDefeatUI::overallScoreThisRound  /*0x040011F1*/
    IL_0067: ldloc.1
    IL_0068: ldc.i4.0
    IL_0069: stfld int EternalTrialsDefeatUI::animationNextScore  /*0x040011F2*/
    IL_006e: ldloc.1
    IL_006f: ldfld TextMeshProUGUI EternalTrialsDefeatUI::baseScore  /*0x040011C1*/
    IL_0074: ldloc.1
    IL_0075: ldflda int EternalTrialsDefeatUI::baseScoreThisRound  /*0x040011EF*/
    IL_007a: call string System.Int32::ToString()  /*0x0A000031*/
    IL_007f: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0084: ldloc.1
    IL_0085: ldfld TextMeshProUGUI EternalTrialsDefeatUI::stageBonus  /*0x040011C2*/
    IL_008a: ldloc.1
    IL_008b: ldflda int EternalTrialsDefeatUI::stageBonusThisRound  /*0x040011F0*/
    IL_0090: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0095: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_009a: ldloc.1
    IL_009b: ldfld TextMeshProUGUI EternalTrialsDefeatUI::overallScore  /*0x040011C3*/
    IL_00a0: ldloc.1
    IL_00a1: ldflda int EternalTrialsDefeatUI::overallScoreThisRound  /*0x040011F1*/
    IL_00a6: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00ab: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00b0: ldloc.1
    IL_00b1: ldfld TextMeshProUGUI EternalTrialsDefeatUI::bestScore  /*0x040011C4*/
    IL_00b6: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_00bb: callvirt int LevelProgressManager::get_EternalTrialsHighscore()  /*0x06000942*/
    IL_00c0: stloc.2
    IL_00c1: ldloca.s 2
    IL_00c3: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00c8: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00cd: ldloc.1
    IL_00ce: ldfld GameObject EternalTrialsDefeatUI::dividerParent  /*0x040011D0*/
    IL_00d3: ldc.i4.1
    IL_00d4: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00d9: ldloc.1
    IL_00da: ldloc.1
    IL_00db: ldloc.1
    IL_00dc: ldfld GameObject EternalTrialsDefeatUI::dividerParent  /*0x040011D0*/
    IL_00e1: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00e6: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_00eb: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_00f0: callvirt AudioClip AudioSet::get_PointScreenBuildB()  /*0x060001E2*/
    IL_00f5: ldloc.1
    IL_00f6: ldfld AnimationCurve EternalTrialsDefeatUI::popShowCurve  /*0x040011E2*/
    IL_00fb: ldloc.1
    IL_00fc: ldfld float EternalTrialsDefeatUI::animationStepB  /*0x040011F6*/
    IL_0101: call IEnumerator EternalTrialsDefeatUI::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06000F3C*/
    IL_0106: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_010b: pop
    IL_010c: ldloc.1
    IL_010d: ldfld TextMeshProUGUI EternalTrialsDefeatUI::baseScoreName  /*0x040011CA*/
    IL_0112: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0117: ldc.i4.1
    IL_0118: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_011d: ldloc.1
    IL_011e: ldloc.1
    IL_011f: ldloc.1
    IL_0120: ldfld TextMeshProUGUI EternalTrialsDefeatUI::baseScoreName  /*0x040011CA*/
    IL_0125: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_012a: ldnull
    IL_012b: ldloc.1
    IL_012c: ldfld AnimationCurve EternalTrialsDefeatUI::popShowCurve  /*0x040011E2*/
    IL_0131: ldloc.1
    IL_0132: ldfld float EternalTrialsDefeatUI::animationStepB  /*0x040011F6*/
    IL_0137: call IEnumerator EternalTrialsDefeatUI::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06000F3C*/
    IL_013c: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0141: pop
    IL_0142: ldarg.0
    IL_0143: ldloc.1
    IL_0144: ldfld float EternalTrialsDefeatUI::minorWaitStep  /*0x040011F4*/
    IL_0149: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_014e: stfld object EternalTrialsDefeatUI.<UnrollScores>d__70::<>2__current  /*0x04001228*/
    IL_0153: ldarg.0
    IL_0154: ldc.i4.1
    IL_0155: stfld int EternalTrialsDefeatUI.<UnrollScores>d__70::<>1__state  /*0x04001227*/
    IL_015a: ldc.i4.1
    IL_015b: ret
    IL_015c: ldarg.0
    IL_015d: ldc.i4.m1
    IL_015e: stfld int EternalTrialsDefeatUI.<UnrollScores>d__70::<>1__state  /*0x04001227*/
    IL_0163: ldloc.1
    IL_0164: ldfld TextMeshProUGUI EternalTrialsDefeatUI::baseScore  /*0x040011C1*/
    IL_0169: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_016e: ldc.i4.1
    IL_016f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0174: ldloc.1
    IL_0175: ldloc.1
    IL_0176: ldloc.1
    IL_0177: ldfld TextMeshProUGUI EternalTrialsDefeatUI::baseScore  /*0x040011C1*/
    IL_017c: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0181: ldnull
    IL_0182: ldloc.1
    IL_0183: ldfld AnimationCurve EternalTrialsDefeatUI::popShowCurve  /*0x040011E2*/
    IL_0188: ldloc.1
    IL_0189: ldfld float EternalTrialsDefeatUI::animationStepB  /*0x040011F6*/
    IL_018e: call IEnumerator EternalTrialsDefeatUI::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06000F3C*/
    IL_0193: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0198: pop
    IL_0199: ldarg.0
    IL_019a: ldloc.1
    IL_019b: ldfld float EternalTrialsDefeatUI::minorWaitStep  /*0x040011F4*/
    IL_01a0: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_01a5: stfld object EternalTrialsDefeatUI.<UnrollScores>d__70::<>2__current  /*0x04001228*/
    IL_01aa: ldarg.0
    IL_01ab: ldc.i4.2
    IL_01ac: stfld int EternalTrialsDefeatUI.<UnrollScores>d__70::<>1__state  /*0x04001227*/
    IL_01b1: ldc.i4.1
    IL_01b2: ret
    IL_01b3: ldarg.0
    IL_01b4: ldc.i4.m1
    IL_01b5: stfld int EternalTrialsDefeatUI.<UnrollScores>d__70::<>1__state  /*0x04001227*/
    IL_01ba: ldarg.0
    IL_01bb: ldloc.1
    IL_01bc: ldloc.1
    IL_01bd: ldfld int EternalTrialsDefeatUI::baseScoreThisRound  /*0x040011EF*/
    IL_01c2: ldloc.1
    IL_01c3: ldfld float EternalTrialsDefeatUI::animationStepA  /*0x040011F5*/
    IL_01c8: call IEnumerator EternalTrialsDefeatUI::AddToOverallScore(int,float)  /*0x06000F39*/
    IL_01cd: stfld object EternalTrialsDefeatUI.<UnrollScores>d__70::<>2__current  /*0x04001228*/
    IL_01d2: ldarg.0
    IL_01d3: ldc.i4.3
    IL_01d4: stfld int EternalTrialsDefeatUI.<UnrollScores>d__70::<>1__state  /*0x04001227*/
    IL_01d9: ldc.i4.1
    IL_01da: ret
    IL_01db: ldarg.0
    IL_01dc: ldc.i4.m1
    IL_01dd: stfld int EternalTrialsDefeatUI.<UnrollScores>d__70::<>1__state  /*0x04001227*/
    IL_01e2: ldloc.1
    IL_01e3: ldfld TextMeshProUGUI EternalTrialsDefeatUI::stageBonusName  /*0x040011CB*/
    IL_01e8: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01ed: ldc.i4.1
    IL_01ee: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01f3: ldloc.1
    IL_01f4: ldloc.1
    IL_01f5: ldloc.1
    IL_01f6: ldfld TextMeshProUGUI EternalTrialsDefeatUI::stageBonusName  /*0x040011CB*/
    IL_01fb: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0200: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0205: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_020a: callvirt AudioClip AudioSet::get_PointScreenBuildC()  /*0x060001E3*/
    IL_020f: ldloc.1
    IL_0210: ldfld AnimationCurve EternalTrialsDefeatUI::popShowCurve  /*0x040011E2*/
    IL_0215: ldloc.1
    IL_0216: ldfld float EternalTrialsDefeatUI::animationStepB  /*0x040011F6*/
    IL_021b: call IEnumerator EternalTrialsDefeatUI::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06000F3C*/
    IL_0220: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0225: pop
    IL_0226: ldarg.0
    IL_0227: ldloc.1
    IL_0228: ldfld float EternalTrialsDefeatUI::minorWaitStep  /*0x040011F4*/
    IL_022d: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0232: stfld object EternalTrialsDefeatUI.<UnrollScores>d__70::<>2__current  /*0x04001228*/
    IL_0237: ldarg.0
    IL_0238: ldc.i4.4
    IL_0239: stfld int EternalTrialsDefeatUI.<UnrollScores>d__70::<>1__state  /*0x04001227*/
    IL_023e: ldc.i4.1
    IL_023f: ret
    IL_0240: ldarg.0
    IL_0241: ldc.i4.m1
    IL_0242: stfld int EternalTrialsDefeatUI.<UnrollScores>d__70::<>1__state  /*0x04001227*/
    IL_0247: ldloc.1
    IL_0248: ldfld TextMeshProUGUI EternalTrialsDefeatUI::stageBonus  /*0x040011C2*/
    IL_024d: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0252: ldc.i4.1
    IL_0253: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0258: ldloc.1
    IL_0259: ldloc.1
    IL_025a: ldloc.1
    IL_025b: ldfld TextMeshProUGUI EternalTrialsDefeatUI::stageBonus  /*0x040011C2*/
    IL_0260: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0265: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_026a: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_026f: callvirt AudioClip AudioSet::get_PointScreenBuildA()  /*0x060001E1*/
    IL_0274: ldloc.1
    IL_0275: ldfld AnimationCurve EternalTrialsDefeatUI::popShowCurve  /*0x040011E2*/
    IL_027a: ldloc.1
    IL_027b: ldfld float EternalTrialsDefeatUI::animationStepB  /*0x040011F6*/
    IL_0280: call IEnumerator EternalTrialsDefeatUI::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06000F3C*/
    IL_0285: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_028a: pop
    IL_028b: ldarg.0
    IL_028c: ldloc.1
    IL_028d: ldfld float EternalTrialsDefeatUI::minorWaitStep  /*0x040011F4*/
    IL_0292: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0297: stfld object EternalTrialsDefeatUI.<UnrollScores>d__70::<>2__current  /*0x04001228*/
    IL_029c: ldarg.0
    IL_029d: ldc.i4.5
    IL_029e: stfld int EternalTrialsDefeatUI.<UnrollScores>d__70::<>1__state  /*0x04001227*/
    IL_02a3: ldc.i4.1
    IL_02a4: ret
    IL_02a5: ldarg.0
    IL_02a6: ldc.i4.m1
    IL_02a7: stfld int EternalTrialsDefeatUI.<UnrollScores>d__70::<>1__state  /*0x04001227*/
    IL_02ac: ldarg.0
    IL_02ad: ldloc.1
    IL_02ae: ldloc.1
    IL_02af: ldfld int EternalTrialsDefeatUI::stageBonusThisRound  /*0x040011F0*/
    IL_02b4: ldloc.1
    IL_02b5: ldfld float EternalTrialsDefeatUI::animationStepA  /*0x040011F5*/
    IL_02ba: call IEnumerator EternalTrialsDefeatUI::AddToOverallScore(int,float)  /*0x06000F39*/
    IL_02bf: stfld object EternalTrialsDefeatUI.<UnrollScores>d__70::<>2__current  /*0x04001228*/
    IL_02c4: ldarg.0
    IL_02c5: ldc.i4.6
    IL_02c6: stfld int EternalTrialsDefeatUI.<UnrollScores>d__70::<>1__state  /*0x04001227*/
    IL_02cb: ldc.i4.1
    IL_02cc: ret
    IL_02cd: ldarg.0
    IL_02ce: ldc.i4.m1
    IL_02cf: stfld int EternalTrialsDefeatUI.<UnrollScores>d__70::<>1__state  /*0x04001227*/
    IL_02d4: ldloc.1
    IL_02d5: ldnull
    IL_02d6: stfld Coroutine EternalTrialsDefeatUI::currentScoringAnimation  /*0x040011F8*/
    IL_02db: ldc.i4.0
    IL_02dc: ret

  .method EternalTrialsDefeatUI.<UnrollScores>d__70::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F6E rva 0x465dd attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<UnrollScores>d__70::<>2__current  /*0x04001228*/
    IL_0006: ret

  .method EternalTrialsDefeatUI.<UnrollScores>d__70::System.Collections.IEnumerator.Reset()  // token 0x06000F6F rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EternalTrialsDefeatUI.<UnrollScores>d__70::System.Collections.IEnumerator.get_Current()  // token 0x06000F70 rva 0x465dd attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsDefeatUI.<UnrollScores>d__70::<>2__current  /*0x04001228*/
    IL_0006: ret

