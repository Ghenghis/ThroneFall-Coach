// ===== EndOfMatchScoreUIHelper  (token 0x020002F7) =====
  .method EndOfMatchScoreUIHelper::Update()  // token 0x06001055 rva 0x4a628 attrs Private, HideBySig
    // code size 79 (0x4f), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Player EndOfMatchScoreUIHelper::input  /*0x0400137B*/
    IL_0006: ldstr "Interact"
    IL_000b: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0010: brfalse.s IL_004e
    IL_0012: ldarg.0
    IL_0013: ldfld bool EndOfMatchScoreUIHelper::inScoreUnroll  /*0x0400137E*/
    IL_0018: brfalse.s IL_004e
    IL_001a: ldarg.0
    IL_001b: ldfld Coroutine EndOfMatchScoreUIHelper::currentScoringAnimation  /*0x0400138A*/
    IL_0020: brfalse.s IL_002e
    IL_0022: ldarg.0
    IL_0023: ldarg.0
    IL_0024: ldfld Coroutine EndOfMatchScoreUIHelper::currentScoringAnimation  /*0x0400138A*/
    IL_0029: call void UnityEngine.MonoBehaviour::StopCoroutine(UnityEngine.Coroutine)  /*0x0A000114*/
    IL_002e: ldarg.0
    IL_002f: ldnull
    IL_0030: stfld Coroutine EndOfMatchScoreUIHelper::currentScoringAnimation  /*0x0400138A*/
    IL_0035: ldarg.0
    IL_0036: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_003b: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_0040: ldarg.0
    IL_0041: ldc.i4.1
    IL_0042: stfld bool EndOfMatchScoreUIHelper::skipScoringAnimation  /*0x04001389*/
    IL_0047: ldarg.0
    IL_0048: ldc.i4.0
    IL_0049: stfld bool EndOfMatchScoreUIHelper::inScoreUnroll  /*0x0400137E*/
    IL_004e: ret

  .method EndOfMatchScoreUIHelper::OnActivate()  // token 0x06001056 rva 0x4a684 attrs Public, HideBySig
    // code size 356 (0x164), max stack 3, init locals
    IL_0000: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_0023
    IL_000c: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0011: ldfld bool LocalGamestate::endScreenShownThisMatch  /*0x04000B4B*/
    IL_0016: brfalse.s IL_0023
    IL_0018: ldc.r4 0f
    IL_001d: call void UnityEngine.Time::set_timeScale(float)  /*0x0A00050F*/
    IL_0022: ret
    IL_0023: ldarg.0
    IL_0024: ldfld bool EndOfMatchScoreUIHelper::inAnimation  /*0x0400137D*/
    IL_0029: brfalse.s IL_002c
    IL_002b: ret
    IL_002c: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0031: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0036: brfalse.s IL_0043
    IL_0038: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_003d: ldc.i4.1
    IL_003e: stfld bool LocalGamestate::endScreenShownThisMatch  /*0x04000B4B*/
    IL_0043: ldarg.0
    IL_0044: ldc.i4.1
    IL_0045: stfld bool EndOfMatchScoreUIHelper::inAnimation  /*0x0400137D*/
    IL_004a: ldarg.0
    IL_004b: ldc.i4.0
    IL_004c: stfld bool EndOfMatchScoreUIHelper::inScoreUnroll  /*0x0400137E*/
    IL_0051: ldarg.0
    IL_0052: ldc.i4.0
    IL_0053: stfld bool EndOfMatchScoreUIHelper::skipScoringAnimation  /*0x04001389*/
    IL_0058: ldarg.0
    IL_0059: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_005e: stfld PerkManager EndOfMatchScoreUIHelper::perkManager  /*0x0400137A*/
    IL_0063: ldarg.0
    IL_0064: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0069: ldc.i4.0
    IL_006a: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_006f: stfld Player EndOfMatchScoreUIHelper::input  /*0x0400137B*/
    IL_0074: ldarg.0
    IL_0075: ldarg.0
    IL_0076: call !!0 UnityEngine.Component::GetComponent()<UIFrame>  /*0x2B0000E8*/
    IL_007b: stfld UIFrame EndOfMatchScoreUIHelper::frame  /*0x0400137C*/
    IL_0080: ldarg.0
    IL_0081: ldfld IUIAnimationSequence EndOfMatchScoreUIHelper::eternalTrialsDefeat  /*0x04001373*/
    IL_0086: callvirt void IUIAnimationSequence::Reset()  /*0x06000F9F*/
    IL_008b: ldarg.0
    IL_008c: ldfld IUIAnimationSequence EndOfMatchScoreUIHelper::eternalTrialsVictory  /*0x04001372*/
    IL_0091: callvirt void IUIAnimationSequence::Reset()  /*0x06000F9F*/
    IL_0096: ldarg.0
    IL_0097: ldfld GameObject EndOfMatchScoreUIHelper::mainFrameParent  /*0x04001333*/
    IL_009c: ldc.i4.0
    IL_009d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00a2: ldarg.0
    IL_00a3: ldfld GameObject EndOfMatchScoreUIHelper::preFrameParent  /*0x04001332*/
    IL_00a8: ldc.i4.1
    IL_00a9: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00ae: ldarg.0
    IL_00af: ldfld RectTransform EndOfMatchScoreUIHelper::preFrameMask  /*0x04001336*/
    IL_00b4: ldarg.0
    IL_00b5: ldfld RectTransform EndOfMatchScoreUIHelper::preFrameMask  /*0x04001336*/
    IL_00ba: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_00bf: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_00c4: ldc.r4 0f
    IL_00c9: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_00ce: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_00d3: ldarg.0
    IL_00d4: ldfld CanvasGroup EndOfMatchScoreUIHelper::preFrameCG  /*0x04001337*/
    IL_00d9: ldc.r4 0f
    IL_00de: callvirt void UnityEngine.CanvasGroup::set_alpha(float)  /*0x0A000609*/
    IL_00e3: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_00e8: callvirt LocalGamestate.State LocalGamestate::get_CurrentState()  /*0x060008FD*/
    IL_00ed: ldc.i4.2
    IL_00ee: bne.un.s IL_0124
    IL_00f0: ldarg.0
    IL_00f1: ldfld GameObject EndOfMatchScoreUIHelper::preFrameVictory  /*0x04001334*/
    IL_00f6: ldc.i4.1
    IL_00f7: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00fc: ldarg.0
    IL_00fd: ldfld GameObject EndOfMatchScoreUIHelper::preFrameDefeat  /*0x04001335*/
    IL_0102: ldc.i4.0
    IL_0103: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0108: ldarg.0
    IL_0109: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_010e: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0113: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0118: callvirt AudioClip AudioSet::get_Victory()  /*0x060001DD*/
    IL_011d: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_0122: br.s IL_0156
    IL_0124: ldarg.0
    IL_0125: ldfld GameObject EndOfMatchScoreUIHelper::preFrameVictory  /*0x04001334*/
    IL_012a: ldc.i4.0
    IL_012b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0130: ldarg.0
    IL_0131: ldfld GameObject EndOfMatchScoreUIHelper::preFrameDefeat  /*0x04001335*/
    IL_0136: ldc.i4.1
    IL_0137: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_013c: ldarg.0
    IL_013d: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_0142: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0147: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_014c: callvirt AudioClip AudioSet::get_Defeat()  /*0x060001DE*/
    IL_0151: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_0156: ldarg.0
    IL_0157: ldarg.0
    IL_0158: call IEnumerator EndOfMatchScoreUIHelper::ActivateAnimation()  /*0x0600105C*/
    IL_015d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0162: pop
    IL_0163: ret

  .method EndOfMatchScoreUIHelper::OnContinue()  // token 0x06001057 rva 0x4a7f4 attrs Public, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0005: callvirt void SceneTransitionManager::TransitionFromEndScreenToLevelSelect()  /*0x060009CE*/
    IL_000a: ret

  .method EndOfMatchScoreUIHelper::OnTryAgain()  // token 0x06001058 rva 0x4a800 attrs Public, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0005: callvirt void SceneTransitionManager::RestartCurrentLevel()  /*0x060009CB*/
    IL_000a: ret

  .method EndOfMatchScoreUIHelper::OnTryAgainET()  // token 0x06001059 rva 0x4a80c attrs Public, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: call void EternalTrialsRunManager::CreateFreshRun()  /*0x060006F5*/
    IL_0005: call bool UIFrameManager::OpenEternalTrialsLoadoutPick()  /*0x06001312*/
    IL_000a: pop
    IL_000b: ret

  .method EndOfMatchScoreUIHelper::OnContinueET()  // token 0x0600105A rva 0x4a819 attrs Public, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: call bool UIFrameManager::OpenEternalTrialsLoadoutPick()  /*0x06001312*/
    IL_0005: pop
    IL_0006: ret

  .method EndOfMatchScoreUIHelper::ToMenuET()  // token 0x0600105B rva 0x4a7f4 attrs Public, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0005: callvirt void SceneTransitionManager::TransitionFromEndScreenToLevelSelect()  /*0x060009CE*/
    IL_000a: ret

  .method EndOfMatchScoreUIHelper::ActivateAnimation()  // token 0x0600105C rva 0x4a821 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::.ctor(int)  /*0x0600106E*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>4__this  /*0x0400138D*/
    IL_000d: ret

  .method EndOfMatchScoreUIHelper::ClassicModeAnimationSequence()  // token 0x0600105D rva 0x4a830 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::.ctor(int)  /*0x06001080*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>4__this  /*0x0400139E*/
    IL_000d: ret

  .method EndOfMatchScoreUIHelper::ShowCampaignLevelBeatenRewards()  // token 0x0600105E rva 0x4a83f attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::.ctor(int)  /*0x06001098*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>4__this  /*0x040013BA*/
    IL_000d: ret

  .method EndOfMatchScoreUIHelper::GetNextMetaLevel()  // token 0x0600105F rva 0x4a84e attrs Private, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld PerkManager EndOfMatchScoreUIHelper::perkManager  /*0x0400137A*/
    IL_0007: callvirt MetaLevel PerkManager::get_NextMetaLevel()  /*0x0600097C*/
    IL_000c: stfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_0011: ldarg.0
    IL_0012: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_0017: brtrue.s IL_001f
    IL_0019: ldarg.0
    IL_001a: call void EndOfMatchScoreUIHelper::EnableMaxLevelReachedUI()  /*0x06001060*/
    IL_001f: ret

  .method EndOfMatchScoreUIHelper::EnableMaxLevelReachedUI()  // token 0x06001060 rva 0x4a86f attrs Private, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject EndOfMatchScoreUIHelper::progressionBarParent  /*0x04001351*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: ldfld GameObject EndOfMatchScoreUIHelper::regularMaxLevel  /*0x04001353*/
    IL_0012: ldc.i4.1
    IL_0013: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0018: ldc.i4.8
    IL_0019: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_001e: ret

  .method EndOfMatchScoreUIHelper::EnableDemoLockedUI()  // token 0x06001061 rva 0x4a88f attrs Private, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject EndOfMatchScoreUIHelper::progressionBarParent  /*0x04001351*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: ldfld GameObject EndOfMatchScoreUIHelper::demoMaxLevel  /*0x04001352*/
    IL_0012: ldc.i4.1
    IL_0013: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0018: ret

  .method EndOfMatchScoreUIHelper::EnableRewardDisplayUI(Equippable)  // token 0x06001062 rva 0x4a8ac attrs Private, HideBySig
    // code size 189 (0xbd), max stack 9, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::levelUpLevelDisplay  /*0x04001346*/
    IL_0006: ldstr "NEW PERK"
    IL_000b: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0010: ldarg.1
    IL_0011: isinst EquippableWeapon  /*0x0200021B*/
    IL_0016: brfalse.s IL_002a
    IL_0018: ldarg.0
    IL_0019: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::levelUpLevelDisplay  /*0x04001346*/
    IL_001e: ldstr "NEW WEAPON"
    IL_0023: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0028: br.s IL_005c
    IL_002a: ldarg.1
    IL_002b: isinst EquippableMutation  /*0x02000219*/
    IL_0030: brfalse.s IL_0044
    IL_0032: ldarg.0
    IL_0033: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::levelUpLevelDisplay  /*0x04001346*/
    IL_0038: ldstr "NEW MUTATOR"
    IL_003d: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0042: br.s IL_005c
    IL_0044: ldarg.1
    IL_0045: isinst EquippableBuildingUpgrade  /*0x02000218*/
    IL_004a: brfalse.s IL_005c
    IL_004c: ldarg.0
    IL_004d: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::levelUpLevelDisplay  /*0x04001346*/
    IL_0052: ldstr "NEW UPGRADE"
    IL_0057: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_005c: ldarg.0
    IL_005d: ldfld MPImageBasic EndOfMatchScoreUIHelper::levelUpRewardIcon  /*0x04001360*/
    IL_0062: ldarg.1
    IL_0063: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_0068: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_006d: ldarg.0
    IL_006e: ldfld MPImageBasic EndOfMatchScoreUIHelper::levelUpRewardBg  /*0x04001361*/
    IL_0073: ldarg.0
    IL_0074: ldarg.1
    IL_0075: call Color EndOfMatchScoreUIHelper::GetColorForEquippable(Equippable)  /*0x0600106B*/
    IL_007a: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_007f: ldarg.0
    IL_0080: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::levelUpRewardDescription  /*0x04001347*/
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

  .method EndOfMatchScoreUIHelper::UpdateLevelingBar()  // token 0x06001063 rva 0x4a978 attrs Private, HideBySig
    // code size 90 (0x5a), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::xpDisplay  /*0x04001345*/
    IL_0006: ldarg.0
    IL_0007: ldfld PerkManager EndOfMatchScoreUIHelper::perkManager  /*0x0400137A*/
    IL_000c: ldflda int PerkManager::xp  /*0x04000BEB*/
    IL_0011: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0016: ldstr " / "
    IL_001b: ldarg.0
    IL_001c: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_0021: ldflda int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_0026: call string System.Int32::ToString()  /*0x0A000031*/
    IL_002b: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0030: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0035: ldarg.0
    IL_0036: ldfld MPImageBasic EndOfMatchScoreUIHelper::xpFill  /*0x0400135D*/
    IL_003b: ldarg.0
    IL_003c: ldfld PerkManager EndOfMatchScoreUIHelper::perkManager  /*0x0400137A*/
    IL_0041: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_0046: conv.r4
    IL_0047: ldarg.0
    IL_0048: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_004d: ldfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_0052: conv.r4
    IL_0053: div
    IL_0054: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_0059: ret

  .method EndOfMatchScoreUIHelper::UnrollScores()  // token 0x06001064 rva 0x4a9de attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EndOfMatchScoreUIHelper.<UnrollScores>d__104::.ctor(int)  /*0x0600109F*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>4__this  /*0x040013C2*/
    IL_000d: ret

  .method EndOfMatchScoreUIHelper::SkipUnrollScores()  // token 0x06001065 rva 0x4a9f0 attrs Private, HideBySig
    // code size 619 (0x26b), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0006: callvirt int SceneTransitionManager::get_IngameScoreFromLastMatch()  /*0x060009BE*/
    IL_000b: stfld int EndOfMatchScoreUIHelper::baseScoreThisRound  /*0x0400137F*/
    IL_0010: ldarg.0
    IL_0011: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0016: callvirt int SceneTransitionManager::get_GoldBonusScoreFromLastMatch()  /*0x060009BF*/
    IL_001b: stfld int EndOfMatchScoreUIHelper::goldScoreThisRound  /*0x04001380*/
    IL_0020: ldarg.0
    IL_0021: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0026: callvirt int SceneTransitionManager::get_MutatorBonusScoreFromLastMatch()  /*0x060009C0*/
    IL_002b: stfld int EndOfMatchScoreUIHelper::mutatorScoreThisRound  /*0x04001381*/
    IL_0030: ldarg.0
    IL_0031: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0036: callvirt int SceneTransitionManager::get_NoRetryBonusScoreFromLastMatch()  /*0x060009C1*/
    IL_003b: stfld int EndOfMatchScoreUIHelper::noRetryScoreThisRound  /*0x04001382*/
    IL_0040: ldarg.0
    IL_0041: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0046: callvirt int SceneTransitionManager::get_TotalScoreFromLastMatch()  /*0x060009C2*/
    IL_004b: stfld int EndOfMatchScoreUIHelper::overallScoreThisRound  /*0x04001383*/
    IL_0050: ldarg.0
    IL_0051: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::baseScore  /*0x0400133E*/
    IL_0056: ldarg.0
    IL_0057: ldflda int EndOfMatchScoreUIHelper::baseScoreThisRound  /*0x0400137F*/
    IL_005c: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0061: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0066: ldarg.0
    IL_0067: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::goldScore  /*0x0400133F*/
    IL_006c: ldarg.0
    IL_006d: ldflda int EndOfMatchScoreUIHelper::goldScoreThisRound  /*0x04001380*/
    IL_0072: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0077: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_007c: ldarg.0
    IL_007d: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::mutatorScore  /*0x04001340*/
    IL_0082: ldarg.0
    IL_0083: ldflda int EndOfMatchScoreUIHelper::mutatorScoreThisRound  /*0x04001381*/
    IL_0088: call string System.Int32::ToString()  /*0x0A000031*/
    IL_008d: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0092: ldarg.0
    IL_0093: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::noRetriesScore  /*0x04001341*/
    IL_0098: ldarg.0
    IL_0099: ldflda int EndOfMatchScoreUIHelper::noRetryScoreThisRound  /*0x04001382*/
    IL_009e: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00a3: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00a8: ldarg.0
    IL_00a9: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::overallScore  /*0x04001342*/
    IL_00ae: ldarg.0
    IL_00af: ldflda int EndOfMatchScoreUIHelper::overallScoreThisRound  /*0x04001383*/
    IL_00b4: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00b9: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00be: ldarg.0
    IL_00bf: ldfld GameObject EndOfMatchScoreUIHelper::newHighscoreIndicator  /*0x04001350*/
    IL_00c4: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_00c9: callvirt bool SceneTransitionManager::get_TotalScoreFromLastMatchIsNewPersonalRecord()  /*0x060009C3*/
    IL_00ce: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00d3: ldarg.0
    IL_00d4: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::bestScore  /*0x04001343*/
    IL_00d9: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_00de: callvirt LevelData SceneTransitionManager::get_LevelDataFromLastMatch()  /*0x060009C5*/
    IL_00e3: ldflda int LevelData::highscoreBest  /*0x04000BC2*/
    IL_00e8: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00ed: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00f2: ldarg.0
    IL_00f3: ldfld GameObject EndOfMatchScoreUIHelper::dividerParent  /*0x04001359*/
    IL_00f8: ldc.i4.1
    IL_00f9: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00fe: ldarg.0
    IL_00ff: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::baseScoreName  /*0x0400134A*/
    IL_0104: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0109: ldc.i4.1
    IL_010a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_010f: ldarg.0
    IL_0110: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::baseScore  /*0x0400133E*/
    IL_0115: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_011a: ldc.i4.1
    IL_011b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0120: ldarg.0
    IL_0121: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::goldBonusName  /*0x0400134B*/
    IL_0126: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_012b: ldc.i4.1
    IL_012c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0131: ldarg.0
    IL_0132: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::goldScore  /*0x0400133F*/
    IL_0137: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_013c: ldc.i4.1
    IL_013d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0142: ldarg.0
    IL_0143: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::MutatorBonusName  /*0x0400134C*/
    IL_0148: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_014d: ldc.i4.1
    IL_014e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0153: ldarg.0
    IL_0154: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::mutatorScore  /*0x04001340*/
    IL_0159: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_015e: ldc.i4.1
    IL_015f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0164: ldarg.0
    IL_0165: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::noRetryBonusName  /*0x0400134D*/
    IL_016a: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_016f: ldc.i4.1
    IL_0170: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0175: ldarg.0
    IL_0176: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::noRetriesScore  /*0x04001341*/
    IL_017b: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0180: ldc.i4.1
    IL_0181: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0186: ldarg.0
    IL_0187: ldfld GameObject EndOfMatchScoreUIHelper::dividerParent  /*0x04001359*/
    IL_018c: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0191: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0196: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_019b: ldarg.0
    IL_019c: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::baseScoreName  /*0x0400134A*/
    IL_01a1: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_01a6: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_01ab: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_01b0: ldarg.0
    IL_01b1: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::baseScore  /*0x0400133E*/
    IL_01b6: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_01bb: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_01c0: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_01c5: ldarg.0
    IL_01c6: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::goldBonusName  /*0x0400134B*/
    IL_01cb: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_01d0: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_01d5: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_01da: ldarg.0
    IL_01db: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::goldScore  /*0x0400133F*/
    IL_01e0: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_01e5: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_01ea: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_01ef: ldarg.0
    IL_01f0: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::MutatorBonusName  /*0x0400134C*/
    IL_01f5: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_01fa: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_01ff: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0204: ldarg.0
    IL_0205: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::mutatorScore  /*0x04001340*/
    IL_020a: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_020f: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0214: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0219: ldarg.0
    IL_021a: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::noRetriesScore  /*0x04001341*/
    IL_021f: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0224: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0229: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_022e: ldarg.0
    IL_022f: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::noRetryBonusName  /*0x0400134D*/
    IL_0234: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0239: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_023e: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0243: ldarg.0
    IL_0244: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::overallScore  /*0x04001342*/
    IL_0249: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_024e: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0253: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0258: ldarg.0
    IL_0259: ldarg.0
    IL_025a: ldc.r4 0.5f
    IL_025f: call IEnumerator EndOfMatchScoreUIHelper::LockInScoreBump(float)  /*0x06001067*/
    IL_0264: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0269: pop
    IL_026a: ret

  .method EndOfMatchScoreUIHelper::AddToOverallScore(int,float)  // token 0x06001066 rva 0x4ac67 attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::.ctor(int)  /*0x06001074*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>4__this  /*0x04001392*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld int EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::scoreToAdd  /*0x04001391*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld float EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::animTime  /*0x04001393*/
    IL_001b: ret

  .method EndOfMatchScoreUIHelper::LockInScoreBump(float)  // token 0x06001067 rva 0x4ac84 attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::.ctor(int)  /*0x0600108C*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::<>4__this  /*0x040013AD*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::animTime  /*0x040013AE*/
    IL_0014: ret

  .method EndOfMatchScoreUIHelper::Bump(float,UnityEngine.Transform,UnityEngine.AudioClip)  // token 0x06001068 rva 0x4ac9a attrs Private, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EndOfMatchScoreUIHelper.<Bump>d__108::.ctor(int)  /*0x0600107A*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<Bump>d__108::<>4__this  /*0x04001398*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float EndOfMatchScoreUIHelper.<Bump>d__108::animTime  /*0x0400139A*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld Transform EndOfMatchScoreUIHelper.<Bump>d__108::target  /*0x04001399*/
    IL_001b: dup
    IL_001c: ldarg.3
    IL_001d: stfld AudioClip EndOfMatchScoreUIHelper.<Bump>d__108::clip  /*0x04001397*/
    IL_0022: ret

  .method EndOfMatchScoreUIHelper::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  // token 0x06001069 rva 0x4acbe attrs Private, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EndOfMatchScoreUIHelper.<PopShowTransform>d__109::.ctor(int)  /*0x06001092*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<PopShowTransform>d__109::<>4__this  /*0x040013B3*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld Transform EndOfMatchScoreUIHelper.<PopShowTransform>d__109::target  /*0x040013B4*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld AudioClip EndOfMatchScoreUIHelper.<PopShowTransform>d__109::clip  /*0x040013B2*/
    IL_001b: dup
    IL_001c: ldarg.3
    IL_001d: stfld AnimationCurve EndOfMatchScoreUIHelper.<PopShowTransform>d__109::curve  /*0x040013B5*/
    IL_0022: dup
    IL_0023: ldarg.s 4
    IL_0025: stfld float EndOfMatchScoreUIHelper.<PopShowTransform>d__109::animTime  /*0x040013B6*/
    IL_002a: ret

  .method EndOfMatchScoreUIHelper::FillUpXPBar(int)  // token 0x0600106A rva 0x4acea attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::.ctor(int)  /*0x06001086*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>4__this  /*0x040013A5*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::xp  /*0x040013A4*/
    IL_0014: ret

  .method EndOfMatchScoreUIHelper::GetColorForEquippable(Equippable)  // token 0x0600106B rva 0x4ad00 attrs Private, HideBySig
    // code size 110 (0x6e), max stack 2, init locals
    .locals ([0] Color)
    IL_0000: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0005: stloc.0
    IL_0006: ldarg.1
    IL_0007: isinst EquippableWeapon  /*0x0200021B*/
    IL_000c: brfalse.s IL_0015
    IL_000e: ldarg.0
    IL_000f: ldfld Color EndOfMatchScoreUIHelper::weaponBG  /*0x04001363*/
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
    IL_0030: ldfld Color EndOfMatchScoreUIHelper::trophyBG  /*0x04001368*/
    IL_0035: stloc.0
    IL_0036: br.s IL_003f
    IL_0038: ldarg.0
    IL_0039: ldfld Color EndOfMatchScoreUIHelper::perkBG  /*0x04001364*/
    IL_003e: stloc.0
    IL_003f: ldarg.1
    IL_0040: isinst PerkPoint  /*0x0200021C*/
    IL_0045: brfalse.s IL_004e
    IL_0047: ldarg.0
    IL_0048: ldfld Color EndOfMatchScoreUIHelper::perkpointBG  /*0x04001366*/
    IL_004d: stloc.0
    IL_004e: ldarg.1
    IL_004f: isinst EquippableMutation  /*0x02000219*/
    IL_0054: brfalse.s IL_005d
    IL_0056: ldarg.0
    IL_0057: ldfld Color EndOfMatchScoreUIHelper::mutatorBG  /*0x04001365*/
    IL_005c: stloc.0
    IL_005d: ldarg.1
    IL_005e: isinst EquippableBuildingUpgrade  /*0x02000218*/
    IL_0063: brfalse.s IL_006c
    IL_0065: ldarg.0
    IL_0066: ldfld Color EndOfMatchScoreUIHelper::buildingUpgradeBG  /*0x04001367*/
    IL_006b: stloc.0
    IL_006c: ldloc.0
    IL_006d: ret

  .method EndOfMatchScoreUIHelper::OnDisable()  // token 0x0600106C rva 0x4ad7a attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool EndOfMatchScoreUIHelper::inAnimation  /*0x0400137D*/
    IL_0007: ret

  .method EndOfMatchScoreUIHelper::.ctor()  // token 0x0600106D rva 0x4ad84 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 117 (0x75), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.75f
    IL_0006: stfld float EndOfMatchScoreUIHelper::preFrameAnimationTime  /*0x0400133B*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 3f
    IL_0011: stfld float EndOfMatchScoreUIHelper::timeToFillUpABar  /*0x04001374*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.25f
    IL_001c: stfld float EndOfMatchScoreUIHelper::waitAtBeginning  /*0x04001375*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 0.25f
    IL_0027: stfld float EndOfMatchScoreUIHelper::waitAfterFillingUpABar  /*0x04001376*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 2f
    IL_0032: stfld float EndOfMatchScoreUIHelper::waitAfterReward  /*0x04001377*/
    IL_0037: ldarg.0
    IL_0038: ldc.r4 0.5f
    IL_003d: stfld float EndOfMatchScoreUIHelper::waitWhenMaxLevelAlreadyReached  /*0x04001378*/
    IL_0042: ldarg.0
    IL_0043: ldc.r4 0.5f
    IL_0048: stfld float EndOfMatchScoreUIHelper::defaultWaitStep  /*0x04001385*/
    IL_004d: ldarg.0
    IL_004e: ldc.r4 0.25f
    IL_0053: stfld float EndOfMatchScoreUIHelper::minorWaitStep  /*0x04001386*/
    IL_0058: ldarg.0
    IL_0059: ldc.r4 1.5f
    IL_005e: stfld float EndOfMatchScoreUIHelper::animationStepA  /*0x04001387*/
    IL_0063: ldarg.0
    IL_0064: ldc.r4 0.5f
    IL_0069: stfld float EndOfMatchScoreUIHelper::animationStepB  /*0x04001388*/
    IL_006e: ldarg.0
    IL_006f: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0074: ret

// ===== EndOfMatchScoreUIHelper/<ActivateAnimation>d__96  (token 0x020002F8) =====
  .method EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::.ctor(int)  // token 0x0600106E rva 0x4ae05 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>1__state  /*0x0400138B*/
    IL_000d: ret

  .method EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::System.IDisposable.Dispose()  // token 0x0600106F rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::MoveNext()  // token 0x06001070 rva 0x4ae14 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 459 (0x1cb), max stack 5, init locals
    .locals ([0] int, [1] EndOfMatchScoreUIHelper, [2] float, [3] Vector2)
    IL_0000: ldarg.0
    IL_0001: ldfld int EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>1__state  /*0x0400138B*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>4__this  /*0x0400138D*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_002e, IL_00c9, IL_0139, IL_0175, IL_01a4, IL_01c2)
    IL_002c: ldc.i4.0
    IL_002d: ret
    IL_002e: ldarg.0
    IL_002f: ldc.i4.m1
    IL_0030: stfld int EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>1__state  /*0x0400138B*/
    IL_0035: ldarg.0
    IL_0036: ldc.r4 0f
    IL_003b: stfld float EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<preFrameTimer>5__2  /*0x0400138E*/
    IL_0040: br IL_00d0
    IL_0045: ldarg.0
    IL_0046: ldarg.0
    IL_0047: ldfld float EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<preFrameTimer>5__2  /*0x0400138E*/
    IL_004c: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0051: add
    IL_0052: stfld float EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<preFrameTimer>5__2  /*0x0400138E*/
    IL_0057: ldloc.1
    IL_0058: ldfld AnimationCurve EndOfMatchScoreUIHelper::preFrameMaskACCurve  /*0x0400133A*/
    IL_005d: ldc.r4 0f
    IL_0062: ldloc.1
    IL_0063: ldfld float EndOfMatchScoreUIHelper::preFrameAnimationTime  /*0x0400133B*/
    IL_0068: ldarg.0
    IL_0069: ldfld float EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<preFrameTimer>5__2  /*0x0400138E*/
    IL_006e: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0073: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0078: stloc.2
    IL_0079: ldloca.s 3
    IL_007b: ldloc.1
    IL_007c: ldfld RectTransform EndOfMatchScoreUIHelper::preFrameMask  /*0x04001336*/
    IL_0081: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0086: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_008b: ldc.r4 0f
    IL_0090: ldloc.1
    IL_0091: ldfld float EndOfMatchScoreUIHelper::preFrameMaskTargetHeight  /*0x04001339*/
    IL_0096: ldloc.2
    IL_0097: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_009c: call void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_00a1: ldloc.1
    IL_00a2: ldfld RectTransform EndOfMatchScoreUIHelper::preFrameMask  /*0x04001336*/
    IL_00a7: ldloc.3
    IL_00a8: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_00ad: ldloc.1
    IL_00ae: ldfld CanvasGroup EndOfMatchScoreUIHelper::preFrameCG  /*0x04001337*/
    IL_00b3: ldloc.2
    IL_00b4: callvirt void UnityEngine.CanvasGroup::set_alpha(float)  /*0x0A000609*/
    IL_00b9: ldarg.0
    IL_00ba: ldnull
    IL_00bb: stfld object EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>2__current  /*0x0400138C*/
    IL_00c0: ldarg.0
    IL_00c1: ldc.i4.1
    IL_00c2: stfld int EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>1__state  /*0x0400138B*/
    IL_00c7: ldc.i4.1
    IL_00c8: ret
    IL_00c9: ldarg.0
    IL_00ca: ldc.i4.m1
    IL_00cb: stfld int EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>1__state  /*0x0400138B*/
    IL_00d0: ldarg.0
    IL_00d1: ldfld float EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<preFrameTimer>5__2  /*0x0400138E*/
    IL_00d6: ldloc.1
    IL_00d7: ldfld float EndOfMatchScoreUIHelper::preFrameAnimationTime  /*0x0400133B*/
    IL_00dc: blt IL_0045
    IL_00e1: ldloc.1
    IL_00e2: ldfld RectTransform EndOfMatchScoreUIHelper::preFrameMask  /*0x04001336*/
    IL_00e7: ldloc.1
    IL_00e8: ldfld RectTransform EndOfMatchScoreUIHelper::preFrameMask  /*0x04001336*/
    IL_00ed: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_00f2: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_00f7: ldloc.1
    IL_00f8: ldfld float EndOfMatchScoreUIHelper::preFrameMaskTargetHeight  /*0x04001339*/
    IL_00fd: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0102: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_0107: ldloc.1
    IL_0108: ldfld CanvasGroup EndOfMatchScoreUIHelper::preFrameCG  /*0x04001337*/
    IL_010d: ldc.r4 1f
    IL_0112: callvirt void UnityEngine.CanvasGroup::set_alpha(float)  /*0x0A000609*/
    IL_0117: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_011c: brtrue.s IL_0142
    IL_011e: ldarg.0
    IL_011f: ldloc.1
    IL_0120: ldloc.1
    IL_0121: call IEnumerator EndOfMatchScoreUIHelper::ClassicModeAnimationSequence()  /*0x0600105D*/
    IL_0126: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_012b: stfld object EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>2__current  /*0x0400138C*/
    IL_0130: ldarg.0
    IL_0131: ldc.i4.2
    IL_0132: stfld int EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>1__state  /*0x0400138B*/
    IL_0137: ldc.i4.1
    IL_0138: ret
    IL_0139: ldarg.0
    IL_013a: ldc.i4.m1
    IL_013b: stfld int EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>1__state  /*0x0400138B*/
    IL_0140: br.s IL_01ab
    IL_0142: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0147: callvirt LocalGamestate.State LocalGamestate::get_CurrentState()  /*0x060008FD*/
    IL_014c: ldc.i4.2
    IL_014d: bne.un.s IL_017e
    IL_014f: ldarg.0
    IL_0150: ldloc.1
    IL_0151: ldloc.1
    IL_0152: ldfld IUIAnimationSequence EndOfMatchScoreUIHelper::eternalTrialsVictory  /*0x04001372*/
    IL_0157: ldloc.1
    IL_0158: ldfld UIFrame EndOfMatchScoreUIHelper::frame  /*0x0400137C*/
    IL_015d: callvirt IEnumerator IUIAnimationSequence::PlayAnimation(UIFrame)  /*0x06000FA0*/
    IL_0162: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0167: stfld object EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>2__current  /*0x0400138C*/
    IL_016c: ldarg.0
    IL_016d: ldc.i4.3
    IL_016e: stfld int EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>1__state  /*0x0400138B*/
    IL_0173: ldc.i4.1
    IL_0174: ret
    IL_0175: ldarg.0
    IL_0176: ldc.i4.m1
    IL_0177: stfld int EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>1__state  /*0x0400138B*/
    IL_017c: br.s IL_01ab
    IL_017e: ldarg.0
    IL_017f: ldloc.1
    IL_0180: ldloc.1
    IL_0181: ldfld IUIAnimationSequence EndOfMatchScoreUIHelper::eternalTrialsDefeat  /*0x04001373*/
    IL_0186: ldloc.1
    IL_0187: ldfld UIFrame EndOfMatchScoreUIHelper::frame  /*0x0400137C*/
    IL_018c: callvirt IEnumerator IUIAnimationSequence::PlayAnimation(UIFrame)  /*0x06000FA0*/
    IL_0191: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0196: stfld object EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>2__current  /*0x0400138C*/
    IL_019b: ldarg.0
    IL_019c: ldc.i4.4
    IL_019d: stfld int EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>1__state  /*0x0400138B*/
    IL_01a2: ldc.i4.1
    IL_01a3: ret
    IL_01a4: ldarg.0
    IL_01a5: ldc.i4.m1
    IL_01a6: stfld int EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>1__state  /*0x0400138B*/
    IL_01ab: ldloc.1
    IL_01ac: ldc.i4.0
    IL_01ad: stfld bool EndOfMatchScoreUIHelper::inAnimation  /*0x0400137D*/
    IL_01b2: ldarg.0
    IL_01b3: ldnull
    IL_01b4: stfld object EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>2__current  /*0x0400138C*/
    IL_01b9: ldarg.0
    IL_01ba: ldc.i4.5
    IL_01bb: stfld int EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>1__state  /*0x0400138B*/
    IL_01c0: ldc.i4.1
    IL_01c1: ret
    IL_01c2: ldarg.0
    IL_01c3: ldc.i4.m1
    IL_01c4: stfld int EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>1__state  /*0x0400138B*/
    IL_01c9: ldc.i4.0
    IL_01ca: ret

  .method EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06001071 rva 0x4afeb attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>2__current  /*0x0400138C*/
    IL_0006: ret

  .method EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::System.Collections.IEnumerator.Reset()  // token 0x06001072 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::System.Collections.IEnumerator.get_Current()  // token 0x06001073 rva 0x4afeb attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<ActivateAnimation>d__96::<>2__current  /*0x0400138C*/
    IL_0006: ret

// ===== EndOfMatchScoreUIHelper/<AddToOverallScore>d__106  (token 0x020002F9) =====
  .method EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::.ctor(int)  // token 0x06001074 rva 0x4aff3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>1__state  /*0x0400138F*/
    IL_000d: ret

  .method EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::System.IDisposable.Dispose()  // token 0x06001075 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::MoveNext()  // token 0x06001076 rva 0x4b004 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 386 (0x182), max stack 6, init locals
    .locals ([0] int, [1] EndOfMatchScoreUIHelper, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>1__state  /*0x0400138F*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>4__this  /*0x04001392*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0026, IL_004e, IL_010b, IL_0179)
    IL_0024: ldc.i4.0
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldc.i4.m1
    IL_0028: stfld int EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>1__state  /*0x0400138F*/
    IL_002d: ldarg.0
    IL_002e: ldfld int EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::scoreToAdd  /*0x04001391*/
    IL_0033: brtrue.s IL_0057
    IL_0035: ldarg.0
    IL_0036: ldc.r4 0.15f
    IL_003b: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0040: stfld object EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>2__current  /*0x04001390*/
    IL_0045: ldarg.0
    IL_0046: ldc.i4.1
    IL_0047: stfld int EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>1__state  /*0x0400138F*/
    IL_004c: ldc.i4.1
    IL_004d: ret
    IL_004e: ldarg.0
    IL_004f: ldc.i4.m1
    IL_0050: stfld int EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>1__state  /*0x0400138F*/
    IL_0055: ldc.i4.0
    IL_0056: ret
    IL_0057: ldloc.1
    IL_0058: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_005d: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0062: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0067: callvirt AudioClip AudioSet::get_PointFill()  /*0x060001E5*/
    IL_006c: callvirt void UnityEngine.AudioSource::set_clip(UnityEngine.AudioClip)  /*0x0A0000D0*/
    IL_0071: ldloc.1
    IL_0072: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_0077: ldc.i4.1
    IL_0078: callvirt void UnityEngine.AudioSource::set_loop(bool)  /*0x0A0000DF*/
    IL_007d: ldloc.1
    IL_007e: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_0083: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_0088: ldloc.1
    IL_0089: ldloc.1
    IL_008a: ldfld int EndOfMatchScoreUIHelper::animationNextScore  /*0x04001384*/
    IL_008f: ldarg.0
    IL_0090: ldfld int EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::scoreToAdd  /*0x04001391*/
    IL_0095: add
    IL_0096: stfld int EndOfMatchScoreUIHelper::animationNextScore  /*0x04001384*/
    IL_009b: ldarg.0
    IL_009c: ldc.r4 0f
    IL_00a1: stfld float EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<timer>5__2  /*0x04001394*/
    IL_00a6: br.s IL_0112
    IL_00a8: ldarg.0
    IL_00a9: ldarg.0
    IL_00aa: ldfld float EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<timer>5__2  /*0x04001394*/
    IL_00af: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_00b4: add
    IL_00b5: stfld float EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<timer>5__2  /*0x04001394*/
    IL_00ba: ldloc.1
    IL_00bb: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::overallScore  /*0x04001342*/
    IL_00c0: ldloc.1
    IL_00c1: ldfld int EndOfMatchScoreUIHelper::overallScoreThisRound  /*0x04001383*/
    IL_00c6: conv.r4
    IL_00c7: ldloc.1
    IL_00c8: ldfld int EndOfMatchScoreUIHelper::animationNextScore  /*0x04001384*/
    IL_00cd: conv.r4
    IL_00ce: ldc.r4 0f
    IL_00d3: ldarg.0
    IL_00d4: ldfld float EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::animTime  /*0x04001393*/
    IL_00d9: ldarg.0
    IL_00da: ldfld float EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<timer>5__2  /*0x04001394*/
    IL_00df: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_00e4: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_00e9: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_00ee: stloc.2
    IL_00ef: ldloca.s 2
    IL_00f1: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00f6: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00fb: ldarg.0
    IL_00fc: ldnull
    IL_00fd: stfld object EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>2__current  /*0x04001390*/
    IL_0102: ldarg.0
    IL_0103: ldc.i4.2
    IL_0104: stfld int EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>1__state  /*0x0400138F*/
    IL_0109: ldc.i4.1
    IL_010a: ret
    IL_010b: ldarg.0
    IL_010c: ldc.i4.m1
    IL_010d: stfld int EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>1__state  /*0x0400138F*/
    IL_0112: ldarg.0
    IL_0113: ldfld float EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<timer>5__2  /*0x04001394*/
    IL_0118: ldarg.0
    IL_0119: ldfld float EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::animTime  /*0x04001393*/
    IL_011e: blt.s IL_00a8
    IL_0120: ldloc.1
    IL_0121: ldloc.1
    IL_0122: ldfld int EndOfMatchScoreUIHelper::animationNextScore  /*0x04001384*/
    IL_0127: stfld int EndOfMatchScoreUIHelper::overallScoreThisRound  /*0x04001383*/
    IL_012c: ldloc.1
    IL_012d: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::overallScore  /*0x04001342*/
    IL_0132: ldloc.1
    IL_0133: ldflda int EndOfMatchScoreUIHelper::overallScoreThisRound  /*0x04001383*/
    IL_0138: call string System.Int32::ToString()  /*0x0A000031*/
    IL_013d: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0142: ldloc.1
    IL_0143: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_0148: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_014d: ldloc.1
    IL_014e: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_0153: ldc.i4.0
    IL_0154: callvirt void UnityEngine.AudioSource::set_loop(bool)  /*0x0A0000DF*/
    IL_0159: ldarg.0
    IL_015a: ldloc.1
    IL_015b: ldloc.1
    IL_015c: ldc.r4 0.5f
    IL_0161: call IEnumerator EndOfMatchScoreUIHelper::LockInScoreBump(float)  /*0x06001067*/
    IL_0166: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_016b: stfld object EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>2__current  /*0x04001390*/
    IL_0170: ldarg.0
    IL_0171: ldc.i4.3
    IL_0172: stfld int EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>1__state  /*0x0400138F*/
    IL_0177: ldc.i4.1
    IL_0178: ret
    IL_0179: ldarg.0
    IL_017a: ldc.i4.m1
    IL_017b: stfld int EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>1__state  /*0x0400138F*/
    IL_0180: ldc.i4.0
    IL_0181: ret

  .method EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06001077 rva 0x4b192 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>2__current  /*0x04001390*/
    IL_0006: ret

  .method EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::System.Collections.IEnumerator.Reset()  // token 0x06001078 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::System.Collections.IEnumerator.get_Current()  // token 0x06001079 rva 0x4b192 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<AddToOverallScore>d__106::<>2__current  /*0x04001390*/
    IL_0006: ret

// ===== EndOfMatchScoreUIHelper/<Bump>d__108  (token 0x020002FA) =====
  .method EndOfMatchScoreUIHelper.<Bump>d__108::.ctor(int)  // token 0x0600107A rva 0x4b19a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EndOfMatchScoreUIHelper.<Bump>d__108::<>1__state  /*0x04001395*/
    IL_000d: ret

  .method EndOfMatchScoreUIHelper.<Bump>d__108::System.IDisposable.Dispose()  // token 0x0600107B rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EndOfMatchScoreUIHelper.<Bump>d__108::MoveNext()  // token 0x0600107C rva 0x4b1ac attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 213 (0xd5), max stack 6, init locals
    .locals ([0] int, [1] EndOfMatchScoreUIHelper)
    IL_0000: ldarg.0
    IL_0001: ldfld int EndOfMatchScoreUIHelper.<Bump>d__108::<>1__state  /*0x04001395*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<Bump>d__108::<>4__this  /*0x04001398*/
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
    IL_001c: stfld int EndOfMatchScoreUIHelper.<Bump>d__108::<>1__state  /*0x04001395*/
    IL_0021: ldarg.0
    IL_0022: ldfld AudioClip EndOfMatchScoreUIHelper.<Bump>d__108::clip  /*0x04001397*/
    IL_0027: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002c: brfalse.s IL_003f
    IL_002e: ldloc.1
    IL_002f: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_0034: ldarg.0
    IL_0035: ldfld AudioClip EndOfMatchScoreUIHelper.<Bump>d__108::clip  /*0x04001397*/
    IL_003a: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_003f: ldarg.0
    IL_0040: ldc.r4 0f
    IL_0045: stfld float EndOfMatchScoreUIHelper.<Bump>d__108::<timer>5__2  /*0x0400139B*/
    IL_004a: br.s IL_00b0
    IL_004c: ldarg.0
    IL_004d: ldarg.0
    IL_004e: ldfld float EndOfMatchScoreUIHelper.<Bump>d__108::<timer>5__2  /*0x0400139B*/
    IL_0053: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0058: add
    IL_0059: stfld float EndOfMatchScoreUIHelper.<Bump>d__108::<timer>5__2  /*0x0400139B*/
    IL_005e: ldarg.0
    IL_005f: ldfld Transform EndOfMatchScoreUIHelper.<Bump>d__108::target  /*0x04001399*/
    IL_0064: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0069: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_006e: ldloc.1
    IL_006f: ldfld AnimationCurve EndOfMatchScoreUIHelper::bumpCurve  /*0x04001370*/
    IL_0074: ldc.r4 0f
    IL_0079: ldarg.0
    IL_007a: ldfld float EndOfMatchScoreUIHelper.<Bump>d__108::animTime  /*0x0400139A*/
    IL_007f: ldarg.0
    IL_0080: ldfld float EndOfMatchScoreUIHelper.<Bump>d__108::<timer>5__2  /*0x0400139B*/
    IL_0085: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_008a: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_008f: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0094: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0099: ldarg.0
    IL_009a: ldnull
    IL_009b: stfld object EndOfMatchScoreUIHelper.<Bump>d__108::<>2__current  /*0x04001396*/
    IL_00a0: ldarg.0
    IL_00a1: ldc.i4.1
    IL_00a2: stfld int EndOfMatchScoreUIHelper.<Bump>d__108::<>1__state  /*0x04001395*/
    IL_00a7: ldc.i4.1
    IL_00a8: ret
    IL_00a9: ldarg.0
    IL_00aa: ldc.i4.m1
    IL_00ab: stfld int EndOfMatchScoreUIHelper.<Bump>d__108::<>1__state  /*0x04001395*/
    IL_00b0: ldarg.0
    IL_00b1: ldfld float EndOfMatchScoreUIHelper.<Bump>d__108::<timer>5__2  /*0x0400139B*/
    IL_00b6: ldarg.0
    IL_00b7: ldfld float EndOfMatchScoreUIHelper.<Bump>d__108::animTime  /*0x0400139A*/
    IL_00bc: blt.s IL_004c
    IL_00be: ldarg.0
    IL_00bf: ldfld Transform EndOfMatchScoreUIHelper.<Bump>d__108::target  /*0x04001399*/
    IL_00c4: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00c9: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00ce: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00d3: ldc.i4.0
    IL_00d4: ret

  .method EndOfMatchScoreUIHelper.<Bump>d__108::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600107D rva 0x4b28d attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<Bump>d__108::<>2__current  /*0x04001396*/
    IL_0006: ret

  .method EndOfMatchScoreUIHelper.<Bump>d__108::System.Collections.IEnumerator.Reset()  // token 0x0600107E rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EndOfMatchScoreUIHelper.<Bump>d__108::System.Collections.IEnumerator.get_Current()  // token 0x0600107F rva 0x4b28d attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<Bump>d__108::<>2__current  /*0x04001396*/
    IL_0006: ret

// ===== EndOfMatchScoreUIHelper/<ClassicModeAnimationSequence>d__97  (token 0x020002FB) =====
  .method EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::.ctor(int)  // token 0x06001080 rva 0x4b295 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_000d: ret

  .method EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::System.IDisposable.Dispose()  // token 0x06001081 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::MoveNext()  // token 0x06001082 rva 0x4b2a4 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1657 (0x679), max stack 7, init locals
    .locals ([0] int, [1] EndOfMatchScoreUIHelper)
    IL_0000: ldarg.0
    IL_0001: ldfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>4__this  /*0x0400139E*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0042, IL_01f9, IL_026e, IL_02cd, IL_0342, IL_0363, IL_03a0, IL_04d0, IL_0530, IL_056e, IL_0592)
    IL_0040: ldc.i4.0
    IL_0041: ret
    IL_0042: ldarg.0
    IL_0043: ldc.i4.m1
    IL_0044: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_0049: ldloc.1
    IL_004a: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::victoryDisplay  /*0x04001348*/
    IL_004f: ldstr "Menu/Victory"
    IL_0054: ldc.i4.1
    IL_0055: ldc.i4.0
    IL_0056: ldc.i4.1
    IL_0057: ldc.i4.1
    IL_0058: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_005d: ldstr "."
    IL_0062: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0067: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_006c: ldloc.1
    IL_006d: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::defeatDisplay  /*0x04001349*/
    IL_0072: ldstr "Menu/Defeat"
    IL_0077: ldc.i4.1
    IL_0078: ldc.i4.0
    IL_0079: ldc.i4.1
    IL_007a: ldc.i4.1
    IL_007b: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0080: ldstr "."
    IL_0085: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_008a: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_008f: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0094: callvirt LocalGamestate.State LocalGamestate::get_CurrentState()  /*0x060008FD*/
    IL_0099: ldc.i4.3
    IL_009a: bne.un.s IL_00b6
    IL_009c: ldloc.1
    IL_009d: ldfld GameObject EndOfMatchScoreUIHelper::victoryParent  /*0x0400134E*/
    IL_00a2: ldc.i4.0
    IL_00a3: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00a8: ldloc.1
    IL_00a9: ldfld GameObject EndOfMatchScoreUIHelper::defeatParent  /*0x0400134F*/
    IL_00ae: ldc.i4.1
    IL_00af: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00b4: br.s IL_00ce
    IL_00b6: ldloc.1
    IL_00b7: ldfld GameObject EndOfMatchScoreUIHelper::victoryParent  /*0x0400134E*/
    IL_00bc: ldc.i4.1
    IL_00bd: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00c2: ldloc.1
    IL_00c3: ldfld GameObject EndOfMatchScoreUIHelper::defeatParent  /*0x0400134F*/
    IL_00c8: ldc.i4.0
    IL_00c9: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00ce: ldloc.1
    IL_00cf: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::baseScore  /*0x0400133E*/
    IL_00d4: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00d9: ldc.i4.0
    IL_00da: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00df: ldloc.1
    IL_00e0: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::baseScoreName  /*0x0400134A*/
    IL_00e5: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00ea: ldc.i4.0
    IL_00eb: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00f0: ldloc.1
    IL_00f1: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::goldScore  /*0x0400133F*/
    IL_00f6: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00fb: ldc.i4.0
    IL_00fc: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0101: ldloc.1
    IL_0102: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::goldBonusName  /*0x0400134B*/
    IL_0107: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_010c: ldc.i4.0
    IL_010d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0112: ldloc.1
    IL_0113: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::mutatorScore  /*0x04001340*/
    IL_0118: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_011d: ldc.i4.0
    IL_011e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0123: ldloc.1
    IL_0124: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::noRetriesScore  /*0x04001341*/
    IL_0129: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_012e: ldc.i4.0
    IL_012f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0134: ldloc.1
    IL_0135: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::noRetryBonusName  /*0x0400134D*/
    IL_013a: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_013f: ldc.i4.0
    IL_0140: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0145: ldloc.1
    IL_0146: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::MutatorBonusName  /*0x0400134C*/
    IL_014b: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0150: ldc.i4.0
    IL_0151: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0156: ldloc.1
    IL_0157: ldfld GameObject EndOfMatchScoreUIHelper::dividerParent  /*0x04001359*/
    IL_015c: ldc.i4.0
    IL_015d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0162: ldloc.1
    IL_0163: ldfld GameObject EndOfMatchScoreUIHelper::progressionBarORMaxLevelParent  /*0x0400135A*/
    IL_0168: ldc.i4.0
    IL_0169: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_016e: ldloc.1
    IL_016f: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::levelDisplay  /*0x04001344*/
    IL_0174: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0179: ldc.i4.0
    IL_017a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_017f: ldloc.1
    IL_0180: ldfld GameObject EndOfMatchScoreUIHelper::newHighscoreIndicator  /*0x04001350*/
    IL_0185: ldc.i4.0
    IL_0186: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_018b: ldloc.1
    IL_018c: ldfld GameObject EndOfMatchScoreUIHelper::victoryButtonsClassic  /*0x04001355*/
    IL_0191: ldc.i4.0
    IL_0192: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0197: ldloc.1
    IL_0198: ldfld GameObject EndOfMatchScoreUIHelper::defeatButtonsClassic  /*0x04001356*/
    IL_019d: ldc.i4.0
    IL_019e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01a3: ldloc.1
    IL_01a4: ldfld GameObject EndOfMatchScoreUIHelper::victoryButtonsET  /*0x04001357*/
    IL_01a9: ldc.i4.0
    IL_01aa: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01af: ldloc.1
    IL_01b0: ldfld GameObject EndOfMatchScoreUIHelper::defeatButtonsET  /*0x04001358*/
    IL_01b5: ldc.i4.0
    IL_01b6: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01bb: ldloc.1
    IL_01bc: ldfld GameObject EndOfMatchScoreUIHelper::demoMaxLevel  /*0x04001352*/
    IL_01c1: ldc.i4.0
    IL_01c2: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01c7: ldloc.1
    IL_01c8: ldfld GameObject EndOfMatchScoreUIHelper::regularMaxLevel  /*0x04001353*/
    IL_01cd: ldc.i4.0
    IL_01ce: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01d3: ldloc.1
    IL_01d4: ldfld GameObject EndOfMatchScoreUIHelper::progressionBarParent  /*0x04001351*/
    IL_01d9: ldc.i4.1
    IL_01da: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01df: ldarg.0
    IL_01e0: ldloc.1
    IL_01e1: ldfld float EndOfMatchScoreUIHelper::preFrameWaittime  /*0x0400133C*/
    IL_01e6: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_01eb: stfld object EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>2__current  /*0x0400139D*/
    IL_01f0: ldarg.0
    IL_01f1: ldc.i4.1
    IL_01f2: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_01f7: ldc.i4.1
    IL_01f8: ret
    IL_01f9: ldarg.0
    IL_01fa: ldc.i4.m1
    IL_01fb: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_0200: ldloc.1
    IL_0201: ldfld CanvasGroup EndOfMatchScoreUIHelper::mainFrameCG  /*0x04001338*/
    IL_0206: ldc.r4 0f
    IL_020b: callvirt void UnityEngine.CanvasGroup::set_alpha(float)  /*0x0A000609*/
    IL_0210: ldloc.1
    IL_0211: ldfld GameObject EndOfMatchScoreUIHelper::mainFrameParent  /*0x04001333*/
    IL_0216: ldc.i4.1
    IL_0217: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_021c: ldarg.0
    IL_021d: ldc.r4 0f
    IL_0222: stfld float EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<mainFrameFadeTimer>5__2  /*0x0400139F*/
    IL_0227: ldarg.0
    IL_0228: ldc.r4 0.25f
    IL_022d: stfld float EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<fadeTime>5__3  /*0x040013A0*/
    IL_0232: br.s IL_0275
    IL_0234: ldarg.0
    IL_0235: ldarg.0
    IL_0236: ldfld float EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<mainFrameFadeTimer>5__2  /*0x0400139F*/
    IL_023b: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0240: add
    IL_0241: stfld float EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<mainFrameFadeTimer>5__2  /*0x0400139F*/
    IL_0246: ldloc.1
    IL_0247: ldfld CanvasGroup EndOfMatchScoreUIHelper::mainFrameCG  /*0x04001338*/
    IL_024c: ldarg.0
    IL_024d: ldfld float EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<mainFrameFadeTimer>5__2  /*0x0400139F*/
    IL_0252: ldarg.0
    IL_0253: ldfld float EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<fadeTime>5__3  /*0x040013A0*/
    IL_0258: div
    IL_0259: callvirt void UnityEngine.CanvasGroup::set_alpha(float)  /*0x0A000609*/
    IL_025e: ldarg.0
    IL_025f: ldnull
    IL_0260: stfld object EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>2__current  /*0x0400139D*/
    IL_0265: ldarg.0
    IL_0266: ldc.i4.2
    IL_0267: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_026c: ldc.i4.1
    IL_026d: ret
    IL_026e: ldarg.0
    IL_026f: ldc.i4.m1
    IL_0270: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_0275: ldarg.0
    IL_0276: ldfld float EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<mainFrameFadeTimer>5__2  /*0x0400139F*/
    IL_027b: ldarg.0
    IL_027c: ldfld float EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<fadeTime>5__3  /*0x040013A0*/
    IL_0281: blt.s IL_0234
    IL_0283: ldloc.1
    IL_0284: ldfld CanvasGroup EndOfMatchScoreUIHelper::mainFrameCG  /*0x04001338*/
    IL_0289: ldc.r4 1f
    IL_028e: callvirt void UnityEngine.CanvasGroup::set_alpha(float)  /*0x0A000609*/
    IL_0293: ldloc.1
    IL_0294: ldfld GameObject EndOfMatchScoreUIHelper::preFrameParent  /*0x04001332*/
    IL_0299: ldc.i4.0
    IL_029a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_029f: ldc.r4 0f
    IL_02a4: call void UnityEngine.Time::set_timeScale(float)  /*0x0A00050F*/
    IL_02a9: ldloc.1
    IL_02aa: ldloc.1
    IL_02ab: ldloc.1
    IL_02ac: call IEnumerator EndOfMatchScoreUIHelper::UnrollScores()  /*0x06001064*/
    IL_02b1: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_02b6: stfld Coroutine EndOfMatchScoreUIHelper::currentScoringAnimation  /*0x0400138A*/
    IL_02bb: br.s IL_02d4
    IL_02bd: ldarg.0
    IL_02be: ldnull
    IL_02bf: stfld object EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>2__current  /*0x0400139D*/
    IL_02c4: ldarg.0
    IL_02c5: ldc.i4.3
    IL_02c6: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_02cb: ldc.i4.1
    IL_02cc: ret
    IL_02cd: ldarg.0
    IL_02ce: ldc.i4.m1
    IL_02cf: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_02d4: ldloc.1
    IL_02d5: ldfld Coroutine EndOfMatchScoreUIHelper::currentScoringAnimation  /*0x0400138A*/
    IL_02da: brtrue.s IL_02bd
    IL_02dc: ldloc.1
    IL_02dd: ldfld bool EndOfMatchScoreUIHelper::skipScoringAnimation  /*0x04001389*/
    IL_02e2: brfalse.s IL_02ea
    IL_02e4: ldloc.1
    IL_02e5: call void EndOfMatchScoreUIHelper::SkipUnrollScores()  /*0x06001065*/
    IL_02ea: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_02ef: callvirt bool SceneTransitionManager::get_TotalScoreFromLastMatchIsNewPersonalRecord()  /*0x060009C3*/
    IL_02f4: brfalse.s IL_036c
    IL_02f6: ldloc.1
    IL_02f7: ldfld GameObject EndOfMatchScoreUIHelper::newHighscoreIndicator  /*0x04001350*/
    IL_02fc: ldc.i4.1
    IL_02fd: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0302: ldarg.0
    IL_0303: ldloc.1
    IL_0304: ldloc.1
    IL_0305: ldloc.1
    IL_0306: ldfld GameObject EndOfMatchScoreUIHelper::newHighscoreIndicator  /*0x04001350*/
    IL_030b: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0310: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0315: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_031a: callvirt AudioClip AudioSet::get_NewHighscore()  /*0x060001E6*/
    IL_031f: ldloc.1
    IL_0320: ldfld AnimationCurve EndOfMatchScoreUIHelper::popShowCurve  /*0x0400136F*/
    IL_0325: ldc.r4 0.5f
    IL_032a: call IEnumerator EndOfMatchScoreUIHelper::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06001069*/
    IL_032f: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0334: stfld object EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>2__current  /*0x0400139D*/
    IL_0339: ldarg.0
    IL_033a: ldc.i4.4
    IL_033b: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_0340: ldc.i4.1
    IL_0341: ret
    IL_0342: ldarg.0
    IL_0343: ldc.i4.m1
    IL_0344: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_0349: ldarg.0
    IL_034a: ldloc.1
    IL_034b: ldfld float EndOfMatchScoreUIHelper::minorWaitStep  /*0x04001386*/
    IL_0350: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0355: stfld object EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>2__current  /*0x0400139D*/
    IL_035a: ldarg.0
    IL_035b: ldc.i4.5
    IL_035c: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_0361: ldc.i4.1
    IL_0362: ret
    IL_0363: ldarg.0
    IL_0364: ldc.i4.m1
    IL_0365: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_036a: br.s IL_0378
    IL_036c: ldloc.1
    IL_036d: ldfld GameObject EndOfMatchScoreUIHelper::newHighscoreIndicator  /*0x04001350*/
    IL_0372: ldc.i4.0
    IL_0373: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0378: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_037d: callvirt LocalGamestate.State LocalGamestate::get_CurrentState()  /*0x060008FD*/
    IL_0382: ldc.i4.2
    IL_0383: bne.un.s IL_03a7
    IL_0385: ldarg.0
    IL_0386: ldloc.1
    IL_0387: ldloc.1
    IL_0388: call IEnumerator EndOfMatchScoreUIHelper::ShowCampaignLevelBeatenRewards()  /*0x0600105E*/
    IL_038d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0392: stfld object EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>2__current  /*0x0400139D*/
    IL_0397: ldarg.0
    IL_0398: ldc.i4.6
    IL_0399: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_039e: ldc.i4.1
    IL_039f: ret
    IL_03a0: ldarg.0
    IL_03a1: ldc.i4.m1
    IL_03a2: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_03a7: ldarg.0
    IL_03a8: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_03ad: callvirt int SceneTransitionManager::get_TotalScoreFromLastMatch()  /*0x060009C2*/
    IL_03b2: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<xpToGive>5__4  /*0x040013A1*/
    IL_03b7: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_03bc: brfalse.s IL_03e5
    IL_03be: ldarg.0
    IL_03bf: ldarg.0
    IL_03c0: ldfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<xpToGive>5__4  /*0x040013A1*/
    IL_03c5: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_03ca: ldfld int MatchSave::highestScoreThisRun  /*0x04000F8E*/
    IL_03cf: sub
    IL_03d0: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<xpToGive>5__4  /*0x040013A1*/
    IL_03d5: ldarg.0
    IL_03d6: ldfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<xpToGive>5__4  /*0x040013A1*/
    IL_03db: ldc.i4.0
    IL_03dc: bge.s IL_03e5
    IL_03de: ldarg.0
    IL_03df: ldc.i4.0
    IL_03e0: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<xpToGive>5__4  /*0x040013A1*/
    IL_03e5: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_03ea: callvirt int SceneTransitionManager::get_TotalScoreFromLastMatch()  /*0x060009C2*/
    IL_03ef: call void MatchSaveLoadHandler::SubmitScoreAndSave(int)  /*0x06000CFF*/
    IL_03f4: ldloc.1
    IL_03f5: call void EndOfMatchScoreUIHelper::GetNextMetaLevel()  /*0x0600105F*/
    IL_03fa: ldloc.1
    IL_03fb: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_0400: brfalse.s IL_043f
    IL_0402: ldloc.1
    IL_0403: ldfld MPImageBasic EndOfMatchScoreUIHelper::nextUnlockIcon  /*0x0400135E*/
    IL_0408: ldloc.1
    IL_0409: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_040e: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_0413: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_0418: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_041d: ldloc.1
    IL_041e: ldfld MPImageBasic EndOfMatchScoreUIHelper::nextunlockBG  /*0x0400135F*/
    IL_0423: ldloc.1
    IL_0424: ldloc.1
    IL_0425: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_042a: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_042f: call Color EndOfMatchScoreUIHelper::GetColorForEquippable(Equippable)  /*0x0600106B*/
    IL_0434: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0439: ldloc.1
    IL_043a: call void EndOfMatchScoreUIHelper::UpdateLevelingBar()  /*0x06001063*/
    IL_043f: ldloc.1
    IL_0440: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::levelDisplay  /*0x04001344*/
    IL_0445: ldstr "Menu/Level"
    IL_044a: ldc.i4.1
    IL_044b: ldc.i4.0
    IL_044c: ldc.i4.1
    IL_044d: ldc.i4.1
    IL_044e: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0453: ldstr " <style=\"Body Numerals\">"
    IL_0458: ldloc.1
    IL_0459: ldfld PerkManager EndOfMatchScoreUIHelper::perkManager  /*0x0400137A*/
    IL_045e: ldflda int PerkManager::level  /*0x04000BEC*/
    IL_0463: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0468: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_046d: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0472: ldloc.1
    IL_0473: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::levelDisplay  /*0x04001344*/
    IL_0478: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_047d: ldc.i4.1
    IL_047e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0483: ldloc.1
    IL_0484: ldloc.1
    IL_0485: ldloc.1
    IL_0486: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::levelDisplay  /*0x04001344*/
    IL_048b: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0490: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0495: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_049a: callvirt AudioClip AudioSet::get_PointScreenBuildB()  /*0x060001E2*/
    IL_049f: ldloc.1
    IL_04a0: ldfld AnimationCurve EndOfMatchScoreUIHelper::popShowCurve  /*0x0400136F*/
    IL_04a5: ldloc.1
    IL_04a6: ldfld float EndOfMatchScoreUIHelper::animationStepB  /*0x04001388*/
    IL_04ab: call IEnumerator EndOfMatchScoreUIHelper::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06001069*/
    IL_04b0: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_04b5: pop
    IL_04b6: ldarg.0
    IL_04b7: ldloc.1
    IL_04b8: ldfld float EndOfMatchScoreUIHelper::minorWaitStep  /*0x04001386*/
    IL_04bd: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_04c2: stfld object EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>2__current  /*0x0400139D*/
    IL_04c7: ldarg.0
    IL_04c8: ldc.i4.7
    IL_04c9: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_04ce: ldc.i4.1
    IL_04cf: ret
    IL_04d0: ldarg.0
    IL_04d1: ldc.i4.m1
    IL_04d2: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_04d7: ldloc.1
    IL_04d8: ldfld GameObject EndOfMatchScoreUIHelper::progressionBarORMaxLevelParent  /*0x0400135A*/
    IL_04dd: ldc.i4.1
    IL_04de: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_04e3: ldloc.1
    IL_04e4: ldloc.1
    IL_04e5: ldloc.1
    IL_04e6: ldfld GameObject EndOfMatchScoreUIHelper::progressionBarORMaxLevelParent  /*0x0400135A*/
    IL_04eb: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_04f0: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_04f5: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_04fa: callvirt AudioClip AudioSet::get_PointScreenBuildC()  /*0x060001E3*/
    IL_04ff: ldloc.1
    IL_0500: ldfld AnimationCurve EndOfMatchScoreUIHelper::popShowCurve  /*0x0400136F*/
    IL_0505: ldloc.1
    IL_0506: ldfld float EndOfMatchScoreUIHelper::animationStepB  /*0x04001388*/
    IL_050b: call IEnumerator EndOfMatchScoreUIHelper::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06001069*/
    IL_0510: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0515: pop
    IL_0516: ldarg.0
    IL_0517: ldloc.1
    IL_0518: ldfld float EndOfMatchScoreUIHelper::defaultWaitStep  /*0x04001385*/
    IL_051d: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0522: stfld object EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>2__current  /*0x0400139D*/
    IL_0527: ldarg.0
    IL_0528: ldc.i4.8
    IL_0529: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_052e: ldc.i4.1
    IL_052f: ret
    IL_0530: ldarg.0
    IL_0531: ldc.i4.m1
    IL_0532: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_0537: ldloc.1
    IL_0538: ldc.i4.1
    IL_0539: stfld bool EndOfMatchScoreUIHelper::inAnimation  /*0x0400137D*/
    IL_053e: ldloc.1
    IL_053f: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_0544: brfalse.s IL_0577
    IL_0546: ldloc.1
    IL_0547: call void EndOfMatchScoreUIHelper::UpdateLevelingBar()  /*0x06001063*/
    IL_054c: ldarg.0
    IL_054d: ldloc.1
    IL_054e: ldloc.1
    IL_054f: ldarg.0
    IL_0550: ldfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<xpToGive>5__4  /*0x040013A1*/
    IL_0555: call IEnumerator EndOfMatchScoreUIHelper::FillUpXPBar(int)  /*0x0600106A*/
    IL_055a: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_055f: stfld object EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>2__current  /*0x0400139D*/
    IL_0564: ldarg.0
    IL_0565: ldc.i4.s 9
    IL_0567: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_056c: ldc.i4.1
    IL_056d: ret
    IL_056e: ldarg.0
    IL_056f: ldc.i4.m1
    IL_0570: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_0575: br.s IL_0599
    IL_0577: ldarg.0
    IL_0578: ldloc.1
    IL_0579: ldfld float EndOfMatchScoreUIHelper::waitWhenMaxLevelAlreadyReached  /*0x04001378*/
    IL_057e: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0583: stfld object EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>2__current  /*0x0400139D*/
    IL_0588: ldarg.0
    IL_0589: ldc.i4.s 10
    IL_058b: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_0590: ldc.i4.1
    IL_0591: ret
    IL_0592: ldarg.0
    IL_0593: ldc.i4.m1
    IL_0594: stfld int EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>1__state  /*0x0400139C*/
    IL_0599: ldloc.1
    IL_059a: ldc.i4.0
    IL_059b: stfld bool EndOfMatchScoreUIHelper::inAnimation  /*0x0400137D*/
    IL_05a0: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_05a5: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_05aa: callvirt string SceneTransitionManager::get_ComingFromGameplayScene()  /*0x060009C4*/
    IL_05af: callvirt LevelData LevelProgressManager::GetLevelDataForScene(string)  /*0x0600094A*/
    IL_05b4: ldc.i4.1
    IL_05b5: callvirt void LevelData::SaveScoreAndStatsToBestIfBest(bool)  /*0x06000951*/
    IL_05ba: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_05bf: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_05c4: callvirt int SceneTransitionManager::get_TotalScoreFromLastMatch()  /*0x060009C2*/
    IL_05c9: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_05ce: callvirt string SceneTransitionManager::get_ComingFromGameplayScene()  /*0x060009C4*/
    IL_05d3: callvirt void Thronefall.GameServices.IGameServices::UploadHighscore(int,string)  /*0x06003DFD*/
    IL_05d8: ldsfld SaveLoadManager SaveLoadManager::instance  /*0x04000C65*/
    IL_05dd: callvirt void SaveLoadManager::SaveGame()  /*0x060009B5*/
    IL_05e2: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_05e7: callvirt LocalGamestate.State LocalGamestate::get_CurrentState()  /*0x060008FD*/
    IL_05ec: ldc.i4.3
    IL_05ed: bne.un.s IL_0634
    IL_05ef: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_05f4: brtrue.s IL_0615
    IL_05f6: ldloc.1
    IL_05f7: ldfld GameObject EndOfMatchScoreUIHelper::defeatButtonsClassic  /*0x04001356*/
    IL_05fc: ldc.i4.1
    IL_05fd: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0602: ldloc.1
    IL_0603: ldfld UIFrame EndOfMatchScoreUIHelper::frame  /*0x0400137C*/
    IL_0608: ldloc.1
    IL_0609: ldfld ThronefallUIElement EndOfMatchScoreUIHelper::defeatClassicSelectedButton  /*0x0400136A*/
    IL_060e: callvirt void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_0613: br.s IL_0677
    IL_0615: ldloc.1
    IL_0616: ldfld GameObject EndOfMatchScoreUIHelper::defeatButtonsET  /*0x04001358*/
    IL_061b: ldc.i4.1
    IL_061c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0621: ldloc.1
    IL_0622: ldfld UIFrame EndOfMatchScoreUIHelper::frame  /*0x0400137C*/
    IL_0627: ldloc.1
    IL_0628: ldfld ThronefallUIElement EndOfMatchScoreUIHelper::defeatETSelectedButton  /*0x0400136C*/
    IL_062d: callvirt void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_0632: br.s IL_0677
    IL_0634: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_0639: brtrue.s IL_065a
    IL_063b: ldloc.1
    IL_063c: ldfld GameObject EndOfMatchScoreUIHelper::victoryButtonsClassic  /*0x04001355*/
    IL_0641: ldc.i4.1
    IL_0642: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0647: ldloc.1
    IL_0648: ldfld UIFrame EndOfMatchScoreUIHelper::frame  /*0x0400137C*/
    IL_064d: ldloc.1
    IL_064e: ldfld ThronefallUIElement EndOfMatchScoreUIHelper::victoryClassicSelectedButton  /*0x04001369*/
    IL_0653: callvirt void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_0658: br.s IL_0677
    IL_065a: ldloc.1
    IL_065b: ldfld GameObject EndOfMatchScoreUIHelper::victoryButtonsET  /*0x04001357*/
    IL_0660: ldc.i4.1
    IL_0661: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0666: ldloc.1
    IL_0667: ldfld UIFrame EndOfMatchScoreUIHelper::frame  /*0x0400137C*/
    IL_066c: ldloc.1
    IL_066d: ldfld ThronefallUIElement EndOfMatchScoreUIHelper::victoryETSelectedButton  /*0x0400136B*/
    IL_0672: callvirt void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_0677: ldc.i4.0
    IL_0678: ret

  .method EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06001083 rva 0x4b929 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>2__current  /*0x0400139D*/
    IL_0006: ret

  .method EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::System.Collections.IEnumerator.Reset()  // token 0x06001084 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::System.Collections.IEnumerator.get_Current()  // token 0x06001085 rva 0x4b929 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<ClassicModeAnimationSequence>d__97::<>2__current  /*0x0400139D*/
    IL_0006: ret

// ===== EndOfMatchScoreUIHelper/<FillUpXPBar>d__110  (token 0x020002FC) =====
  .method EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::.ctor(int)  // token 0x06001086 rva 0x4b931 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>1__state  /*0x040013A2*/
    IL_000d: ret

  .method EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::System.IDisposable.Dispose()  // token 0x06001087 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::MoveNext()  // token 0x06001088 rva 0x4b940 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1190 (0x4a6), max stack 6, init locals
    .locals ([0] int, [1] EndOfMatchScoreUIHelper, [2] int, [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>1__state  /*0x040013A2*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>4__this  /*0x040013A5*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_002e, IL_0250, IL_02fe, IL_0353, IL_040f, IL_049d)
    IL_002c: ldc.i4.0
    IL_002d: ret
    IL_002e: ldarg.0
    IL_002f: ldc.i4.m1
    IL_0030: stfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>1__state  /*0x040013A2*/
    IL_0035: ldarg.0
    IL_0036: ldarg.0
    IL_0037: ldfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::xp  /*0x040013A4*/
    IL_003c: stfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<xpToGive>5__2  /*0x040013A6*/
    IL_0041: ldarg.0
    IL_0042: ldloc.1
    IL_0043: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_0048: ldfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_004d: conv.r4
    IL_004e: ldloc.1
    IL_004f: ldfld float EndOfMatchScoreUIHelper::timeToFillUpABar  /*0x04001374*/
    IL_0054: div
    IL_0055: stfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<xpFillSpeed>5__3  /*0x040013A7*/
    IL_005a: ldloc.1
    IL_005b: ldfld PerkManager EndOfMatchScoreUIHelper::perkManager  /*0x0400137A*/
    IL_0060: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_0065: pop
    IL_0066: ldarg.0
    IL_0067: ldloc.1
    IL_0068: ldfld PerkManager EndOfMatchScoreUIHelper::perkManager  /*0x0400137A*/
    IL_006d: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_0072: conv.r4
    IL_0073: stfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<xpFillFloat>5__4  /*0x040013A8*/
    IL_0078: ldc.i4.0
    IL_0079: stloc.2
    IL_007a: ldc.i4.0
    IL_007b: stloc.3
    IL_007c: ldloc.1
    IL_007d: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_0082: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0087: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_008c: callvirt AudioClip AudioSet::get_PointFill()  /*0x060001E5*/
    IL_0091: callvirt void UnityEngine.AudioSource::set_clip(UnityEngine.AudioClip)  /*0x0A0000D0*/
    IL_0096: ldloc.1
    IL_0097: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_009c: ldc.i4.1
    IL_009d: callvirt void UnityEngine.AudioSource::set_loop(bool)  /*0x0A0000DF*/
    IL_00a2: ldloc.1
    IL_00a3: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_00a8: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_00ad: ldarg.0
    IL_00ae: ldc.r4 0f
    IL_00b3: stfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<progressionBarWiggleTime>5__5  /*0x040013A9*/
    IL_00b8: br IL_0416
    IL_00bd: ldloc.1
    IL_00be: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_00c3: callvirt bool UnityEngine.AudioSource::get_isPlaying()  /*0x0A00001C*/
    IL_00c8: brtrue.s IL_00d5
    IL_00ca: ldloc.1
    IL_00cb: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_00d0: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_00d5: ldarg.0
    IL_00d6: ldarg.0
    IL_00d7: ldfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<progressionBarWiggleTime>5__5  /*0x040013A9*/
    IL_00dc: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_00e1: ldc.r4 10f
    IL_00e6: mul
    IL_00e7: add
    IL_00e8: stfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<progressionBarWiggleTime>5__5  /*0x040013A9*/
    IL_00ed: ldloc.1
    IL_00ee: ldfld GameObject EndOfMatchScoreUIHelper::progressionBarOnly  /*0x0400135B*/
    IL_00f3: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00f8: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00fd: ldloc.1
    IL_00fe: ldfld AnimationCurve EndOfMatchScoreUIHelper::scoreFillWiggle  /*0x04001371*/
    IL_0103: ldarg.0
    IL_0104: ldfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<progressionBarWiggleTime>5__5  /*0x040013A9*/
    IL_0109: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_010e: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0113: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0118: ldloc.1
    IL_0119: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_011e: ldfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_0123: ldloc.1
    IL_0124: ldfld PerkManager EndOfMatchScoreUIHelper::perkManager  /*0x0400137A*/
    IL_0129: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_012e: sub
    IL_012f: stloc.3
    IL_0130: ldloc.1
    IL_0131: ldfld Player EndOfMatchScoreUIHelper::input  /*0x0400137B*/
    IL_0136: ldstr "Interact"
    IL_013b: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0140: brtrue.s IL_014a
    IL_0142: ldloc.1
    IL_0143: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_0148: brtrue.s IL_0153
    IL_014a: ldarg.0
    IL_014b: ldfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<xpToGive>5__2  /*0x040013A6*/
    IL_0150: stloc.2
    IL_0151: br.s IL_0184
    IL_0153: ldarg.0
    IL_0154: ldarg.0
    IL_0155: ldfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<xpFillFloat>5__4  /*0x040013A8*/
    IL_015a: ldarg.0
    IL_015b: ldfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<xpFillSpeed>5__3  /*0x040013A7*/
    IL_0160: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0165: mul
    IL_0166: add
    IL_0167: stfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<xpFillFloat>5__4  /*0x040013A8*/
    IL_016c: ldarg.0
    IL_016d: ldfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<xpFillFloat>5__4  /*0x040013A8*/
    IL_0172: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0177: ldloc.1
    IL_0178: ldfld PerkManager EndOfMatchScoreUIHelper::perkManager  /*0x0400137A*/
    IL_017d: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_0182: sub
    IL_0183: stloc.2
    IL_0184: ldloc.2
    IL_0185: ldloc.3
    IL_0186: ble.s IL_018a
    IL_0188: ldloc.3
    IL_0189: stloc.2
    IL_018a: ldloc.1
    IL_018b: ldfld PerkManager EndOfMatchScoreUIHelper::perkManager  /*0x0400137A*/
    IL_0190: dup
    IL_0191: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_0196: ldloc.2
    IL_0197: add
    IL_0198: stfld int PerkManager::xp  /*0x04000BEB*/
    IL_019d: ldarg.0
    IL_019e: ldarg.0
    IL_019f: ldfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<xpToGive>5__2  /*0x040013A6*/
    IL_01a4: ldloc.2
    IL_01a5: sub
    IL_01a6: stfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<xpToGive>5__2  /*0x040013A6*/
    IL_01ab: ldloc.1
    IL_01ac: call void EndOfMatchScoreUIHelper::UpdateLevelingBar()  /*0x06001063*/
    IL_01b1: ldloc.1
    IL_01b2: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_01b7: brfalse IL_03ff
    IL_01bc: ldloc.1
    IL_01bd: ldfld PerkManager EndOfMatchScoreUIHelper::perkManager  /*0x0400137A*/
    IL_01c2: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_01c7: ldloc.1
    IL_01c8: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_01cd: ldfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_01d2: blt IL_03ff
    IL_01d7: ldloc.1
    IL_01d8: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_01dd: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_01e2: ldloc.1
    IL_01e3: ldfld ThronefallUIElement EndOfMatchScoreUIHelper::rewardAcceptButton  /*0x0400136D*/
    IL_01e8: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01ed: ldc.i4.0
    IL_01ee: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01f3: ldloc.1
    IL_01f4: ldfld GameObject EndOfMatchScoreUIHelper::rewardWaitIndicator  /*0x04001354*/
    IL_01f9: ldc.i4.1
    IL_01fa: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01ff: ldloc.1
    IL_0200: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_0205: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_020a: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_020f: callvirt AudioClip AudioSet::get_LevelUp()  /*0x060001E7*/
    IL_0214: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_0219: ldloc.1
    IL_021a: ldloc.1
    IL_021b: ldc.r4 0.5f
    IL_0220: ldloc.1
    IL_0221: ldfld GameObject EndOfMatchScoreUIHelper::nextPerk  /*0x0400135C*/
    IL_0226: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_022b: ldnull
    IL_022c: call IEnumerator EndOfMatchScoreUIHelper::Bump(float,UnityEngine.Transform,UnityEngine.AudioClip)  /*0x06001068*/
    IL_0231: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0236: pop
    IL_0237: ldarg.0
    IL_0238: ldc.r4 0.5f
    IL_023d: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0242: stfld object EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>2__current  /*0x040013A3*/
    IL_0247: ldarg.0
    IL_0248: ldc.i4.1
    IL_0249: stfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>1__state  /*0x040013A2*/
    IL_024e: ldc.i4.1
    IL_024f: ret
    IL_0250: ldarg.0
    IL_0251: ldc.i4.m1
    IL_0252: stfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>1__state  /*0x040013A2*/
    IL_0257: ldloc.1
    IL_0258: ldloc.1
    IL_0259: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_025e: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_0263: call void EndOfMatchScoreUIHelper::EnableRewardDisplayUI(Equippable)  /*0x06001062*/
    IL_0268: ldloc.1
    IL_0269: ldfld PerkManager EndOfMatchScoreUIHelper::perkManager  /*0x0400137A*/
    IL_026e: ldc.i4.0
    IL_026f: stfld int PerkManager::xp  /*0x04000BEB*/
    IL_0274: ldarg.0
    IL_0275: ldc.r4 0f
    IL_027a: stfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<xpFillFloat>5__4  /*0x040013A8*/
    IL_027f: ldloc.1
    IL_0280: ldfld PerkManager EndOfMatchScoreUIHelper::perkManager  /*0x0400137A*/
    IL_0285: dup
    IL_0286: ldfld int PerkManager::level  /*0x04000BEC*/
    IL_028b: ldc.i4.1
    IL_028c: add
    IL_028d: stfld int PerkManager::level  /*0x04000BEC*/
    IL_0292: ldloc.1
    IL_0293: call void EndOfMatchScoreUIHelper::GetNextMetaLevel()  /*0x0600105F*/
    IL_0298: ldarg.0
    IL_0299: ldc.r4 0f
    IL_029e: stfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<timer>5__6  /*0x040013AA*/
    IL_02a3: br.s IL_0305
    IL_02a5: ldarg.0
    IL_02a6: ldfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<timer>5__6  /*0x040013AA*/
    IL_02ab: ldc.r4 0f
    IL_02b0: beq.s IL_02c4
    IL_02b2: ldloc.1
    IL_02b3: ldfld Player EndOfMatchScoreUIHelper::input  /*0x0400137B*/
    IL_02b8: ldstr "Interact"
    IL_02bd: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_02c2: brtrue.s IL_0313
    IL_02c4: ldarg.0
    IL_02c5: ldarg.0
    IL_02c6: ldfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<timer>5__6  /*0x040013AA*/
    IL_02cb: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_02d0: add
    IL_02d1: stfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<timer>5__6  /*0x040013AA*/
    IL_02d6: ldloc.1
    IL_02d7: ldfld MPImageBasic EndOfMatchScoreUIHelper::rewardWaitFill  /*0x04001362*/
    IL_02dc: ldarg.0
    IL_02dd: ldfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<timer>5__6  /*0x040013AA*/
    IL_02e2: ldloc.1
    IL_02e3: ldfld float EndOfMatchScoreUIHelper::waitAfterReward  /*0x04001377*/
    IL_02e8: div
    IL_02e9: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_02ee: ldarg.0
    IL_02ef: ldnull
    IL_02f0: stfld object EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>2__current  /*0x040013A3*/
    IL_02f5: ldarg.0
    IL_02f6: ldc.i4.2
    IL_02f7: stfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>1__state  /*0x040013A2*/
    IL_02fc: ldc.i4.1
    IL_02fd: ret
    IL_02fe: ldarg.0
    IL_02ff: ldc.i4.m1
    IL_0300: stfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>1__state  /*0x040013A2*/
    IL_0305: ldarg.0
    IL_0306: ldfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<timer>5__6  /*0x040013AA*/
    IL_030b: ldloc.1
    IL_030c: ldfld float EndOfMatchScoreUIHelper::waitAfterReward  /*0x04001377*/
    IL_0311: blt.s IL_02a5
    IL_0313: ldloc.1
    IL_0314: ldfld ThronefallUIElement EndOfMatchScoreUIHelper::rewardAcceptButton  /*0x0400136D*/
    IL_0319: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_031e: ldc.i4.1
    IL_031f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0324: ldloc.1
    IL_0325: ldfld GameObject EndOfMatchScoreUIHelper::rewardWaitIndicator  /*0x04001354*/
    IL_032a: ldc.i4.0
    IL_032b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0330: ldloc.1
    IL_0331: ldfld UIFrame EndOfMatchScoreUIHelper::rewardFrame  /*0x0400136E*/
    IL_0336: ldloc.1
    IL_0337: ldfld ThronefallUIElement EndOfMatchScoreUIHelper::rewardAcceptButton  /*0x0400136D*/
    IL_033c: callvirt void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_0341: br.s IL_035a
    IL_0343: ldarg.0
    IL_0344: ldnull
    IL_0345: stfld object EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>2__current  /*0x040013A3*/
    IL_034a: ldarg.0
    IL_034b: ldc.i4.3
    IL_034c: stfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>1__state  /*0x040013A2*/
    IL_0351: ldc.i4.1
    IL_0352: ret
    IL_0353: ldarg.0
    IL_0354: ldc.i4.m1
    IL_0355: stfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>1__state  /*0x040013A2*/
    IL_035a: ldloc.1
    IL_035b: ldfld UIFrame EndOfMatchScoreUIHelper::frame  /*0x0400137C*/
    IL_0360: callvirt bool UIFrame::get_Interactable()  /*0x060012E9*/
    IL_0365: brfalse.s IL_0343
    IL_0367: ldloc.1
    IL_0368: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_036d: brfalse IL_03f5
    IL_0372: ldarg.0
    IL_0373: ldloc.1
    IL_0374: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_0379: ldfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_037e: conv.r4
    IL_037f: ldloc.1
    IL_0380: ldfld float EndOfMatchScoreUIHelper::timeToFillUpABar  /*0x04001374*/
    IL_0385: div
    IL_0386: stfld float EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<xpFillSpeed>5__3  /*0x040013A7*/
    IL_038b: ldloc.1
    IL_038c: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::levelDisplay  /*0x04001344*/
    IL_0391: ldstr "Menu/Level"
    IL_0396: ldc.i4.1
    IL_0397: ldc.i4.0
    IL_0398: ldc.i4.1
    IL_0399: ldc.i4.1
    IL_039a: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_039f: ldstr " <style=\"Body Numerals\">"
    IL_03a4: ldloc.1
    IL_03a5: ldfld PerkManager EndOfMatchScoreUIHelper::perkManager  /*0x0400137A*/
    IL_03aa: ldflda int PerkManager::level  /*0x04000BEC*/
    IL_03af: call string System.Int32::ToString()  /*0x0A000031*/
    IL_03b4: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_03b9: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_03be: ldloc.1
    IL_03bf: ldfld MPImageBasic EndOfMatchScoreUIHelper::nextUnlockIcon  /*0x0400135E*/
    IL_03c4: ldloc.1
    IL_03c5: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_03ca: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_03cf: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_03d4: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_03d9: ldloc.1
    IL_03da: ldfld MPImageBasic EndOfMatchScoreUIHelper::nextunlockBG  /*0x0400135F*/
    IL_03df: ldloc.1
    IL_03e0: ldloc.1
    IL_03e1: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_03e6: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_03eb: call Color EndOfMatchScoreUIHelper::GetColorForEquippable(Equippable)  /*0x0600106B*/
    IL_03f0: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_03f5: ldc.r4 0f
    IL_03fa: call void UnityEngine.Time::set_timeScale(float)  /*0x0A00050F*/
    IL_03ff: ldarg.0
    IL_0400: ldnull
    IL_0401: stfld object EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>2__current  /*0x040013A3*/
    IL_0406: ldarg.0
    IL_0407: ldc.i4.4
    IL_0408: stfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>1__state  /*0x040013A2*/
    IL_040d: ldc.i4.1
    IL_040e: ret
    IL_040f: ldarg.0
    IL_0410: ldc.i4.m1
    IL_0411: stfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>1__state  /*0x040013A2*/
    IL_0416: ldarg.0
    IL_0417: ldfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<xpToGive>5__2  /*0x040013A6*/
    IL_041c: ldc.i4.0
    IL_041d: ble.s IL_042a
    IL_041f: ldloc.1
    IL_0420: ldfld MetaLevel EndOfMatchScoreUIHelper::nextMetaLevel  /*0x04001379*/
    IL_0425: brtrue IL_00bd
    IL_042a: ldloc.1
    IL_042b: ldfld GameObject EndOfMatchScoreUIHelper::progressionBarOnly  /*0x0400135B*/
    IL_0430: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0435: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_043a: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_043f: ldloc.1
    IL_0440: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_0445: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_044a: ldloc.1
    IL_044b: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_0450: ldc.i4.0
    IL_0451: callvirt void UnityEngine.AudioSource::set_loop(bool)  /*0x0A0000DF*/
    IL_0456: ldloc.1
    IL_0457: ldloc.1
    IL_0458: ldloc.1
    IL_0459: ldfld float EndOfMatchScoreUIHelper::animationStepB  /*0x04001388*/
    IL_045e: ldloc.1
    IL_045f: ldfld GameObject EndOfMatchScoreUIHelper::progressionBarParent  /*0x04001351*/
    IL_0464: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0469: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_046e: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0473: callvirt AudioClip AudioSet::get_PointLockInMinor()  /*0x060001DF*/
    IL_0478: call IEnumerator EndOfMatchScoreUIHelper::Bump(float,UnityEngine.Transform,UnityEngine.AudioClip)  /*0x06001068*/
    IL_047d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0482: pop
    IL_0483: ldarg.0
    IL_0484: ldloc.1
    IL_0485: ldfld float EndOfMatchScoreUIHelper::minorWaitStep  /*0x04001386*/
    IL_048a: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_048f: stfld object EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>2__current  /*0x040013A3*/
    IL_0494: ldarg.0
    IL_0495: ldc.i4.5
    IL_0496: stfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>1__state  /*0x040013A2*/
    IL_049b: ldc.i4.1
    IL_049c: ret
    IL_049d: ldarg.0
    IL_049e: ldc.i4.m1
    IL_049f: stfld int EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>1__state  /*0x040013A2*/
    IL_04a4: ldc.i4.0
    IL_04a5: ret

  .method EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06001089 rva 0x4bdf2 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>2__current  /*0x040013A3*/
    IL_0006: ret

  .method EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::System.Collections.IEnumerator.Reset()  // token 0x0600108A rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::System.Collections.IEnumerator.get_Current()  // token 0x0600108B rva 0x4bdf2 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<FillUpXPBar>d__110::<>2__current  /*0x040013A3*/
    IL_0006: ret

// ===== EndOfMatchScoreUIHelper/<LockInScoreBump>d__107  (token 0x020002FD) =====
  .method EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::.ctor(int)  // token 0x0600108C rva 0x4bdfa attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::<>1__state  /*0x040013AB*/
    IL_000d: ret

  .method EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::System.IDisposable.Dispose()  // token 0x0600108D rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::MoveNext()  // token 0x0600108E rva 0x4be0c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 214 (0xd6), max stack 6, init locals
    .locals ([0] int, [1] EndOfMatchScoreUIHelper)
    IL_0000: ldarg.0
    IL_0001: ldfld int EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::<>1__state  /*0x040013AB*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::<>4__this  /*0x040013AD*/
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
    IL_001c: stfld int EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::<>1__state  /*0x040013AB*/
    IL_0021: ldloc.1
    IL_0022: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_0027: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_002c: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0031: callvirt AudioClip AudioSet::get_PointLockInMajor()  /*0x060001E0*/
    IL_0036: ldc.r4 0.85f
    IL_003b: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_0040: ldarg.0
    IL_0041: ldc.r4 0f
    IL_0046: stfld float EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::<timer>5__2  /*0x040013AF*/
    IL_004b: br.s IL_00b1
    IL_004d: ldarg.0
    IL_004e: ldarg.0
    IL_004f: ldfld float EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::<timer>5__2  /*0x040013AF*/
    IL_0054: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0059: add
    IL_005a: stfld float EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::<timer>5__2  /*0x040013AF*/
    IL_005f: ldloc.1
    IL_0060: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::overallScore  /*0x04001342*/
    IL_0065: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_006a: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_006f: ldloc.1
    IL_0070: ldfld AnimationCurve EndOfMatchScoreUIHelper::bumpCurve  /*0x04001370*/
    IL_0075: ldc.r4 0f
    IL_007a: ldarg.0
    IL_007b: ldfld float EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::animTime  /*0x040013AE*/
    IL_0080: ldarg.0
    IL_0081: ldfld float EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::<timer>5__2  /*0x040013AF*/
    IL_0086: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_008b: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0090: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0095: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_009a: ldarg.0
    IL_009b: ldnull
    IL_009c: stfld object EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::<>2__current  /*0x040013AC*/
    IL_00a1: ldarg.0
    IL_00a2: ldc.i4.1
    IL_00a3: stfld int EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::<>1__state  /*0x040013AB*/
    IL_00a8: ldc.i4.1
    IL_00a9: ret
    IL_00aa: ldarg.0
    IL_00ab: ldc.i4.m1
    IL_00ac: stfld int EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::<>1__state  /*0x040013AB*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld float EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::<timer>5__2  /*0x040013AF*/
    IL_00b7: ldarg.0
    IL_00b8: ldfld float EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::animTime  /*0x040013AE*/
    IL_00bd: blt.s IL_004d
    IL_00bf: ldloc.1
    IL_00c0: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::overallScore  /*0x04001342*/
    IL_00c5: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_00ca: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00cf: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00d4: ldc.i4.0
    IL_00d5: ret

  .method EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600108F rva 0x4beee attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::<>2__current  /*0x040013AC*/
    IL_0006: ret

  .method EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::System.Collections.IEnumerator.Reset()  // token 0x06001090 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::System.Collections.IEnumerator.get_Current()  // token 0x06001091 rva 0x4beee attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<LockInScoreBump>d__107::<>2__current  /*0x040013AC*/
    IL_0006: ret

// ===== EndOfMatchScoreUIHelper/<PopShowTransform>d__109  (token 0x020002FE) =====
  .method EndOfMatchScoreUIHelper.<PopShowTransform>d__109::.ctor(int)  // token 0x06001092 rva 0x4bef6 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EndOfMatchScoreUIHelper.<PopShowTransform>d__109::<>1__state  /*0x040013B0*/
    IL_000d: ret

  .method EndOfMatchScoreUIHelper.<PopShowTransform>d__109::System.IDisposable.Dispose()  // token 0x06001093 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EndOfMatchScoreUIHelper.<PopShowTransform>d__109::MoveNext()  // token 0x06001094 rva 0x4bf08 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 203 (0xcb), max stack 6, init locals
    .locals ([0] int, [1] EndOfMatchScoreUIHelper)
    IL_0000: ldarg.0
    IL_0001: ldfld int EndOfMatchScoreUIHelper.<PopShowTransform>d__109::<>1__state  /*0x040013B0*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<PopShowTransform>d__109::<>4__this  /*0x040013B3*/
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
    IL_001c: stfld int EndOfMatchScoreUIHelper.<PopShowTransform>d__109::<>1__state  /*0x040013B0*/
    IL_0021: ldarg.0
    IL_0022: ldfld AudioClip EndOfMatchScoreUIHelper.<PopShowTransform>d__109::clip  /*0x040013B2*/
    IL_0027: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002c: brfalse.s IL_003f
    IL_002e: ldloc.1
    IL_002f: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_0034: ldarg.0
    IL_0035: ldfld AudioClip EndOfMatchScoreUIHelper.<PopShowTransform>d__109::clip  /*0x040013B2*/
    IL_003a: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_003f: ldarg.0
    IL_0040: ldc.r4 0f
    IL_0045: stfld float EndOfMatchScoreUIHelper.<PopShowTransform>d__109::<timer>5__2  /*0x040013B7*/
    IL_004a: br.s IL_00ab
    IL_004c: ldarg.0
    IL_004d: ldarg.0
    IL_004e: ldfld float EndOfMatchScoreUIHelper.<PopShowTransform>d__109::<timer>5__2  /*0x040013B7*/
    IL_0053: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0058: add
    IL_0059: stfld float EndOfMatchScoreUIHelper.<PopShowTransform>d__109::<timer>5__2  /*0x040013B7*/
    IL_005e: ldarg.0
    IL_005f: ldfld Transform EndOfMatchScoreUIHelper.<PopShowTransform>d__109::target  /*0x040013B4*/
    IL_0064: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0069: ldarg.0
    IL_006a: ldfld AnimationCurve EndOfMatchScoreUIHelper.<PopShowTransform>d__109::curve  /*0x040013B5*/
    IL_006f: ldc.r4 0f
    IL_0074: ldarg.0
    IL_0075: ldfld float EndOfMatchScoreUIHelper.<PopShowTransform>d__109::animTime  /*0x040013B6*/
    IL_007a: ldarg.0
    IL_007b: ldfld float EndOfMatchScoreUIHelper.<PopShowTransform>d__109::<timer>5__2  /*0x040013B7*/
    IL_0080: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0085: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_008a: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_008f: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0094: ldarg.0
    IL_0095: ldnull
    IL_0096: stfld object EndOfMatchScoreUIHelper.<PopShowTransform>d__109::<>2__current  /*0x040013B1*/
    IL_009b: ldarg.0
    IL_009c: ldc.i4.1
    IL_009d: stfld int EndOfMatchScoreUIHelper.<PopShowTransform>d__109::<>1__state  /*0x040013B0*/
    IL_00a2: ldc.i4.1
    IL_00a3: ret
    IL_00a4: ldarg.0
    IL_00a5: ldc.i4.m1
    IL_00a6: stfld int EndOfMatchScoreUIHelper.<PopShowTransform>d__109::<>1__state  /*0x040013B0*/
    IL_00ab: ldarg.0
    IL_00ac: ldfld float EndOfMatchScoreUIHelper.<PopShowTransform>d__109::<timer>5__2  /*0x040013B7*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld float EndOfMatchScoreUIHelper.<PopShowTransform>d__109::animTime  /*0x040013B6*/
    IL_00b7: blt.s IL_004c
    IL_00b9: ldarg.0
    IL_00ba: ldfld Transform EndOfMatchScoreUIHelper.<PopShowTransform>d__109::target  /*0x040013B4*/
    IL_00bf: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00c4: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00c9: ldc.i4.0
    IL_00ca: ret

  .method EndOfMatchScoreUIHelper.<PopShowTransform>d__109::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06001095 rva 0x4bfdf attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<PopShowTransform>d__109::<>2__current  /*0x040013B1*/
    IL_0006: ret

  .method EndOfMatchScoreUIHelper.<PopShowTransform>d__109::System.Collections.IEnumerator.Reset()  // token 0x06001096 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EndOfMatchScoreUIHelper.<PopShowTransform>d__109::System.Collections.IEnumerator.get_Current()  // token 0x06001097 rva 0x4bfdf attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<PopShowTransform>d__109::<>2__current  /*0x040013B1*/
    IL_0006: ret

// ===== EndOfMatchScoreUIHelper/<ShowCampaignLevelBeatenRewards>d__98  (token 0x020002FF) =====
  .method EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::.ctor(int)  // token 0x06001098 rva 0x4bfe7 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>1__state  /*0x040013B8*/
    IL_000d: ret

  .method EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::System.IDisposable.Dispose()  // token 0x06001099 rva 0x4bff8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 29 (0x1d), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>1__state  /*0x040013B8*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: ldc.i4.s -3
    IL_000a: beq.s IL_0012
    IL_000c: ldloc.0
    IL_000d: ldc.i4.1
    IL_000e: sub
    IL_000f: ldc.i4.2
    IL_0010: bgt.un.s IL_001c
    IL_0012: nop
    IL_0013: leave.s IL_001c
    IL_0015: ldarg.0
    IL_0016: call void EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>m__Finally1()  /*0x0600109B*/
    IL_001b: endfinally
    IL_001c: ret
    .try IL_0013-IL_0015 finally handler IL_0015-IL_001c

  .method EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::MoveNext()  // token 0x0600109A rva 0x4c034 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 668 (0x29c), max stack 5, init locals
    .locals ([0] bool, [1] int, [2] EndOfMatchScoreUIHelper, [3] bool)
    IL_0000: ldarg.0
    IL_0001: ldfld int EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>1__state  /*0x040013B8*/
    IL_0006: stloc.1
    IL_0007: ldarg.0
    IL_0008: ldfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>4__this  /*0x040013BA*/
    IL_000d: stloc.2
    IL_000e: ldloc.1
    IL_000f: switch (IL_002b, IL_0170, IL_01ef, IL_0247)
    IL_0024: ldc.i4.0
    IL_0025: stloc.0
    IL_0026: leave IL_029a
    IL_002b: ldarg.0
    IL_002c: ldc.i4.m1
    IL_002d: stfld int EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>1__state  /*0x040013B8*/
    IL_0032: ldarg.0
    IL_0033: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0038: callvirt LevelInfo LevelProgressManager::GetLevelInfoFromCurrentSceneName()  /*0x06000945*/
    IL_003d: stfld LevelInfo EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<currentLevelInfo>5__2  /*0x040013BB*/
    IL_0042: ldarg.0
    IL_0043: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0048: callvirt LevelData LevelProgressManager::GetLevelDataForActiveScene()  /*0x0600094B*/
    IL_004d: stfld LevelData EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<currentLevelData>5__3  /*0x040013BC*/
    IL_0052: ldarg.0
    IL_0053: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0058: ldfld List<Equippable> PerkManager::allEquippables  /*0x04000BE8*/
    IL_005d: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_0062: stfld List.Enumerator<Equippable> EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>7__wrap3  /*0x040013BD*/
    IL_0067: ldarg.0
    IL_0068: ldc.i4.s -3
    IL_006a: stfld int EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>1__state  /*0x040013B8*/
    IL_006f: br IL_026d
    IL_0074: ldarg.0
    IL_0075: ldarg.0
    IL_0076: ldflda List.Enumerator<Equippable> EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>7__wrap3  /*0x040013BD*/
    IL_007b: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_0080: stfld Equippable EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<e>5__5  /*0x040013BE*/
    IL_0085: ldarg.0
    IL_0086: ldfld Equippable EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<e>5__5  /*0x040013BE*/
    IL_008b: isinst EquippableBuildingUpgrade  /*0x02000218*/
    IL_0090: brtrue IL_026d
    IL_0095: ldarg.0
    IL_0096: ldfld Equippable EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<e>5__5  /*0x040013BE*/
    IL_009b: ldfld Equippable.UnlockRequirement Equippable::unlockRequirement  /*0x04000E2D*/
    IL_00a0: ldc.i4.1
    IL_00a1: bne.un.s IL_00db
    IL_00a3: ldarg.0
    IL_00a4: ldfld Equippable EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<e>5__5  /*0x040013BE*/
    IL_00a9: ldflda Equippable.LevelName Equippable::requiredBeatenLevel  /*0x04000E2E*/
    IL_00ae: constrained. Equippable.LevelName  /*0x02000215*/
    IL_00b4: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_00b9: ldarg.0
    IL_00ba: ldfld LevelInfo EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<currentLevelInfo>5__2  /*0x040013BB*/
    IL_00bf: ldfld string LevelInfo::displayName  /*0x04000B20*/
    IL_00c4: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_00c9: brfalse.s IL_00db
    IL_00cb: ldarg.0
    IL_00cc: ldfld LevelInfo EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<currentLevelInfo>5__2  /*0x040013BB*/
    IL_00d1: ldfld bool LevelInfo::useSubtitle  /*0x04000B21*/
    IL_00d6: ldc.i4.0
    IL_00d7: ceq
    IL_00d9: br.s IL_00dc
    IL_00db: ldc.i4.0
    IL_00dc: stloc.3
    IL_00dd: ldarg.0
    IL_00de: ldfld LevelData EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<currentLevelData>5__3  /*0x040013BC*/
    IL_00e3: ldfld bool LevelData::beatenBest  /*0x04000BC1*/
    IL_00e8: brfalse.s IL_00ec
    IL_00ea: ldc.i4.0
    IL_00eb: stloc.3
    IL_00ec: ldloc.3
    IL_00ed: brfalse IL_026d
    IL_00f2: ldloc.2
    IL_00f3: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_00f8: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_00fd: ldloc.2
    IL_00fe: ldfld ThronefallUIElement EndOfMatchScoreUIHelper::rewardAcceptButton  /*0x0400136D*/
    IL_0103: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0108: ldc.i4.0
    IL_0109: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_010e: ldloc.2
    IL_010f: ldfld GameObject EndOfMatchScoreUIHelper::rewardWaitIndicator  /*0x04001354*/
    IL_0114: ldc.i4.1
    IL_0115: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_011a: ldloc.2
    IL_011b: ldfld AudioSource EndOfMatchScoreUIHelper::audioSource  /*0x0400133D*/
    IL_0120: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0125: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_012a: callvirt AudioClip AudioSet::get_LevelUp()  /*0x060001E7*/
    IL_012f: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_0134: ldloc.2
    IL_0135: ldloc.2
    IL_0136: ldc.r4 0.5f
    IL_013b: ldloc.2
    IL_013c: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::victoryDisplay  /*0x04001348*/
    IL_0141: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0146: ldnull
    IL_0147: call IEnumerator EndOfMatchScoreUIHelper::Bump(float,UnityEngine.Transform,UnityEngine.AudioClip)  /*0x06001068*/
    IL_014c: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0151: pop
    IL_0152: ldarg.0
    IL_0153: ldc.r4 0.5f
    IL_0158: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_015d: stfld object EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>2__current  /*0x040013B9*/
    IL_0162: ldarg.0
    IL_0163: ldc.i4.1
    IL_0164: stfld int EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>1__state  /*0x040013B8*/
    IL_0169: ldc.i4.1
    IL_016a: stloc.0
    IL_016b: leave IL_029a
    IL_0170: ldarg.0
    IL_0171: ldc.i4.s -3
    IL_0173: stfld int EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>1__state  /*0x040013B8*/
    IL_0178: ldloc.2
    IL_0179: ldarg.0
    IL_017a: ldfld Equippable EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<e>5__5  /*0x040013BE*/
    IL_017f: call void EndOfMatchScoreUIHelper::EnableRewardDisplayUI(Equippable)  /*0x06001062*/
    IL_0184: ldarg.0
    IL_0185: ldc.r4 0f
    IL_018a: stfld float EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<timer>5__6  /*0x040013BF*/
    IL_018f: br.s IL_01f7
    IL_0191: ldarg.0
    IL_0192: ldfld float EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<timer>5__6  /*0x040013BF*/
    IL_0197: ldc.r4 0f
    IL_019c: beq.s IL_01b0
    IL_019e: ldloc.2
    IL_019f: ldfld Player EndOfMatchScoreUIHelper::input  /*0x0400137B*/
    IL_01a4: ldstr "Interact"
    IL_01a9: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_01ae: brtrue.s IL_0205
    IL_01b0: ldarg.0
    IL_01b1: ldarg.0
    IL_01b2: ldfld float EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<timer>5__6  /*0x040013BF*/
    IL_01b7: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_01bc: add
    IL_01bd: stfld float EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<timer>5__6  /*0x040013BF*/
    IL_01c2: ldloc.2
    IL_01c3: ldfld MPImageBasic EndOfMatchScoreUIHelper::rewardWaitFill  /*0x04001362*/
    IL_01c8: ldarg.0
    IL_01c9: ldfld float EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<timer>5__6  /*0x040013BF*/
    IL_01ce: ldloc.2
    IL_01cf: ldfld float EndOfMatchScoreUIHelper::waitAfterReward  /*0x04001377*/
    IL_01d4: div
    IL_01d5: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_01da: ldarg.0
    IL_01db: ldnull
    IL_01dc: stfld object EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>2__current  /*0x040013B9*/
    IL_01e1: ldarg.0
    IL_01e2: ldc.i4.2
    IL_01e3: stfld int EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>1__state  /*0x040013B8*/
    IL_01e8: ldc.i4.1
    IL_01e9: stloc.0
    IL_01ea: leave IL_029a
    IL_01ef: ldarg.0
    IL_01f0: ldc.i4.s -3
    IL_01f2: stfld int EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>1__state  /*0x040013B8*/
    IL_01f7: ldarg.0
    IL_01f8: ldfld float EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<timer>5__6  /*0x040013BF*/
    IL_01fd: ldloc.2
    IL_01fe: ldfld float EndOfMatchScoreUIHelper::waitAfterReward  /*0x04001377*/
    IL_0203: blt.s IL_0191
    IL_0205: ldloc.2
    IL_0206: ldfld ThronefallUIElement EndOfMatchScoreUIHelper::rewardAcceptButton  /*0x0400136D*/
    IL_020b: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0210: ldc.i4.1
    IL_0211: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0216: ldloc.2
    IL_0217: ldfld GameObject EndOfMatchScoreUIHelper::rewardWaitIndicator  /*0x04001354*/
    IL_021c: ldc.i4.0
    IL_021d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0222: ldloc.2
    IL_0223: ldfld UIFrame EndOfMatchScoreUIHelper::rewardFrame  /*0x0400136E*/
    IL_0228: ldloc.2
    IL_0229: ldfld ThronefallUIElement EndOfMatchScoreUIHelper::rewardAcceptButton  /*0x0400136D*/
    IL_022e: callvirt void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_0233: br.s IL_024f
    IL_0235: ldarg.0
    IL_0236: ldnull
    IL_0237: stfld object EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>2__current  /*0x040013B9*/
    IL_023c: ldarg.0
    IL_023d: ldc.i4.3
    IL_023e: stfld int EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>1__state  /*0x040013B8*/
    IL_0243: ldc.i4.1
    IL_0244: stloc.0
    IL_0245: leave.s IL_029a
    IL_0247: ldarg.0
    IL_0248: ldc.i4.s -3
    IL_024a: stfld int EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>1__state  /*0x040013B8*/
    IL_024f: ldloc.2
    IL_0250: ldfld UIFrame EndOfMatchScoreUIHelper::frame  /*0x0400137C*/
    IL_0255: callvirt bool UIFrame::get_Interactable()  /*0x060012E9*/
    IL_025a: brfalse.s IL_0235
    IL_025c: ldc.r4 0f
    IL_0261: call void UnityEngine.Time::set_timeScale(float)  /*0x0A00050F*/
    IL_0266: ldarg.0
    IL_0267: ldnull
    IL_0268: stfld Equippable EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<e>5__5  /*0x040013BE*/
    IL_026d: ldarg.0
    IL_026e: ldflda List.Enumerator<Equippable> EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>7__wrap3  /*0x040013BD*/
    IL_0273: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_0278: brtrue IL_0074
    IL_027d: ldarg.0
    IL_027e: call void EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>m__Finally1()  /*0x0600109B*/
    IL_0283: ldarg.0
    IL_0284: ldflda List.Enumerator<Equippable> EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>7__wrap3  /*0x040013BD*/
    IL_0289: initobj System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_028f: ldc.i4.0
    IL_0290: stloc.0
    IL_0291: leave.s IL_029a
    IL_0293: ldarg.0
    IL_0294: call void EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::System.IDisposable.Dispose()  /*0x06001099*/
    IL_0299: endfinally
    IL_029a: ldloc.0
    IL_029b: ret
    .try IL_0000-IL_0293 fault handler IL_0293-IL_029a

  .method EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>m__Finally1()  // token 0x0600109B rva 0x4c2f8 attrs Private, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.m1
    IL_0002: stfld int EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>1__state  /*0x040013B8*/
    IL_0007: ldarg.0
    IL_0008: ldflda List.Enumerator<Equippable> EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>7__wrap3  /*0x040013BD*/
    IL_000d: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_0013: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0018: ret

  .method EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600109C rva 0x4c312 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>2__current  /*0x040013B9*/
    IL_0006: ret

  .method EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::System.Collections.IEnumerator.Reset()  // token 0x0600109D rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::System.Collections.IEnumerator.get_Current()  // token 0x0600109E rva 0x4c312 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<ShowCampaignLevelBeatenRewards>d__98::<>2__current  /*0x040013B9*/
    IL_0006: ret

// ===== EndOfMatchScoreUIHelper/<UnrollScores>d__104  (token 0x02000300) =====
  .method EndOfMatchScoreUIHelper.<UnrollScores>d__104::.ctor(int)  // token 0x0600109F rva 0x4c31a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_000d: ret

  .method EndOfMatchScoreUIHelper.<UnrollScores>d__104::System.IDisposable.Dispose()  // token 0x060010A0 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EndOfMatchScoreUIHelper.<UnrollScores>d__104::MoveNext()  // token 0x060010A1 rva 0x4c32c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1323 (0x52b), max stack 6, init locals
    .locals ([0] int, [1] EndOfMatchScoreUIHelper)
    IL_0000: ldarg.0
    IL_0001: ldfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EndOfMatchScoreUIHelper EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>4__this  /*0x040013C2*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_004a, IL_01c2, IL_0219, IL_0241, IL_02a6, IL_030b, IL_0333, IL_0398, IL_03fd, IL_0426, IL_048c, IL_04f2, IL_051b)
    IL_0048: ldc.i4.0
    IL_0049: ret
    IL_004a: ldarg.0
    IL_004b: ldc.i4.m1
    IL_004c: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_0051: ldloc.1
    IL_0052: ldc.i4.1
    IL_0053: stfld bool EndOfMatchScoreUIHelper::inScoreUnroll  /*0x0400137E*/
    IL_0058: ldloc.1
    IL_0059: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_005e: callvirt int SceneTransitionManager::get_IngameScoreFromLastMatch()  /*0x060009BE*/
    IL_0063: stfld int EndOfMatchScoreUIHelper::baseScoreThisRound  /*0x0400137F*/
    IL_0068: ldloc.1
    IL_0069: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_006e: callvirt int SceneTransitionManager::get_GoldBonusScoreFromLastMatch()  /*0x060009BF*/
    IL_0073: stfld int EndOfMatchScoreUIHelper::goldScoreThisRound  /*0x04001380*/
    IL_0078: ldloc.1
    IL_0079: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_007e: callvirt int SceneTransitionManager::get_MutatorBonusScoreFromLastMatch()  /*0x060009C0*/
    IL_0083: stfld int EndOfMatchScoreUIHelper::mutatorScoreThisRound  /*0x04001381*/
    IL_0088: ldloc.1
    IL_0089: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_008e: callvirt int SceneTransitionManager::get_NoRetryBonusScoreFromLastMatch()  /*0x060009C1*/
    IL_0093: stfld int EndOfMatchScoreUIHelper::noRetryScoreThisRound  /*0x04001382*/
    IL_0098: ldloc.1
    IL_0099: ldc.i4.0
    IL_009a: stfld int EndOfMatchScoreUIHelper::overallScoreThisRound  /*0x04001383*/
    IL_009f: ldloc.1
    IL_00a0: ldc.i4.0
    IL_00a1: stfld int EndOfMatchScoreUIHelper::animationNextScore  /*0x04001384*/
    IL_00a6: ldloc.1
    IL_00a7: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::baseScore  /*0x0400133E*/
    IL_00ac: ldloc.1
    IL_00ad: ldflda int EndOfMatchScoreUIHelper::baseScoreThisRound  /*0x0400137F*/
    IL_00b2: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00b7: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00bc: ldloc.1
    IL_00bd: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::goldScore  /*0x0400133F*/
    IL_00c2: ldloc.1
    IL_00c3: ldflda int EndOfMatchScoreUIHelper::goldScoreThisRound  /*0x04001380*/
    IL_00c8: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00cd: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00d2: ldloc.1
    IL_00d3: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::mutatorScore  /*0x04001340*/
    IL_00d8: ldloc.1
    IL_00d9: ldflda int EndOfMatchScoreUIHelper::mutatorScoreThisRound  /*0x04001381*/
    IL_00de: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00e3: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00e8: ldloc.1
    IL_00e9: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::noRetriesScore  /*0x04001341*/
    IL_00ee: ldloc.1
    IL_00ef: ldflda int EndOfMatchScoreUIHelper::noRetryScoreThisRound  /*0x04001382*/
    IL_00f4: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00f9: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00fe: ldloc.1
    IL_00ff: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::overallScore  /*0x04001342*/
    IL_0104: ldloc.1
    IL_0105: ldflda int EndOfMatchScoreUIHelper::overallScoreThisRound  /*0x04001383*/
    IL_010a: call string System.Int32::ToString()  /*0x0A000031*/
    IL_010f: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0114: ldloc.1
    IL_0115: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::bestScore  /*0x04001343*/
    IL_011a: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_011f: callvirt LevelData SceneTransitionManager::get_LevelDataFromLastMatch()  /*0x060009C5*/
    IL_0124: ldflda int LevelData::highscoreBest  /*0x04000BC2*/
    IL_0129: call string System.Int32::ToString()  /*0x0A000031*/
    IL_012e: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0133: ldloc.1
    IL_0134: ldfld GameObject EndOfMatchScoreUIHelper::dividerParent  /*0x04001359*/
    IL_0139: ldc.i4.1
    IL_013a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_013f: ldloc.1
    IL_0140: ldloc.1
    IL_0141: ldloc.1
    IL_0142: ldfld GameObject EndOfMatchScoreUIHelper::dividerParent  /*0x04001359*/
    IL_0147: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_014c: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0151: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0156: callvirt AudioClip AudioSet::get_PointScreenBuildB()  /*0x060001E2*/
    IL_015b: ldloc.1
    IL_015c: ldfld AnimationCurve EndOfMatchScoreUIHelper::popShowCurve  /*0x0400136F*/
    IL_0161: ldloc.1
    IL_0162: ldfld float EndOfMatchScoreUIHelper::animationStepB  /*0x04001388*/
    IL_0167: call IEnumerator EndOfMatchScoreUIHelper::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06001069*/
    IL_016c: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0171: pop
    IL_0172: ldloc.1
    IL_0173: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::baseScoreName  /*0x0400134A*/
    IL_0178: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_017d: ldc.i4.1
    IL_017e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0183: ldloc.1
    IL_0184: ldloc.1
    IL_0185: ldloc.1
    IL_0186: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::baseScoreName  /*0x0400134A*/
    IL_018b: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0190: ldnull
    IL_0191: ldloc.1
    IL_0192: ldfld AnimationCurve EndOfMatchScoreUIHelper::popShowCurve  /*0x0400136F*/
    IL_0197: ldloc.1
    IL_0198: ldfld float EndOfMatchScoreUIHelper::animationStepB  /*0x04001388*/
    IL_019d: call IEnumerator EndOfMatchScoreUIHelper::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06001069*/
    IL_01a2: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_01a7: pop
    IL_01a8: ldarg.0
    IL_01a9: ldloc.1
    IL_01aa: ldfld float EndOfMatchScoreUIHelper::minorWaitStep  /*0x04001386*/
    IL_01af: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_01b4: stfld object EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>2__current  /*0x040013C1*/
    IL_01b9: ldarg.0
    IL_01ba: ldc.i4.1
    IL_01bb: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_01c0: ldc.i4.1
    IL_01c1: ret
    IL_01c2: ldarg.0
    IL_01c3: ldc.i4.m1
    IL_01c4: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_01c9: ldloc.1
    IL_01ca: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::baseScore  /*0x0400133E*/
    IL_01cf: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01d4: ldc.i4.1
    IL_01d5: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01da: ldloc.1
    IL_01db: ldloc.1
    IL_01dc: ldloc.1
    IL_01dd: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::baseScore  /*0x0400133E*/
    IL_01e2: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_01e7: ldnull
    IL_01e8: ldloc.1
    IL_01e9: ldfld AnimationCurve EndOfMatchScoreUIHelper::popShowCurve  /*0x0400136F*/
    IL_01ee: ldloc.1
    IL_01ef: ldfld float EndOfMatchScoreUIHelper::animationStepB  /*0x04001388*/
    IL_01f4: call IEnumerator EndOfMatchScoreUIHelper::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06001069*/
    IL_01f9: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_01fe: pop
    IL_01ff: ldarg.0
    IL_0200: ldloc.1
    IL_0201: ldfld float EndOfMatchScoreUIHelper::minorWaitStep  /*0x04001386*/
    IL_0206: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_020b: stfld object EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>2__current  /*0x040013C1*/
    IL_0210: ldarg.0
    IL_0211: ldc.i4.2
    IL_0212: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_0217: ldc.i4.1
    IL_0218: ret
    IL_0219: ldarg.0
    IL_021a: ldc.i4.m1
    IL_021b: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_0220: ldarg.0
    IL_0221: ldloc.1
    IL_0222: ldloc.1
    IL_0223: ldfld int EndOfMatchScoreUIHelper::baseScoreThisRound  /*0x0400137F*/
    IL_0228: ldloc.1
    IL_0229: ldfld float EndOfMatchScoreUIHelper::animationStepA  /*0x04001387*/
    IL_022e: call IEnumerator EndOfMatchScoreUIHelper::AddToOverallScore(int,float)  /*0x06001066*/
    IL_0233: stfld object EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>2__current  /*0x040013C1*/
    IL_0238: ldarg.0
    IL_0239: ldc.i4.3
    IL_023a: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_023f: ldc.i4.1
    IL_0240: ret
    IL_0241: ldarg.0
    IL_0242: ldc.i4.m1
    IL_0243: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_0248: ldloc.1
    IL_0249: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::goldBonusName  /*0x0400134B*/
    IL_024e: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0253: ldc.i4.1
    IL_0254: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0259: ldloc.1
    IL_025a: ldloc.1
    IL_025b: ldloc.1
    IL_025c: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::goldBonusName  /*0x0400134B*/
    IL_0261: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0266: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_026b: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0270: callvirt AudioClip AudioSet::get_PointScreenBuildC()  /*0x060001E3*/
    IL_0275: ldloc.1
    IL_0276: ldfld AnimationCurve EndOfMatchScoreUIHelper::popShowCurve  /*0x0400136F*/
    IL_027b: ldloc.1
    IL_027c: ldfld float EndOfMatchScoreUIHelper::animationStepB  /*0x04001388*/
    IL_0281: call IEnumerator EndOfMatchScoreUIHelper::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06001069*/
    IL_0286: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_028b: pop
    IL_028c: ldarg.0
    IL_028d: ldloc.1
    IL_028e: ldfld float EndOfMatchScoreUIHelper::minorWaitStep  /*0x04001386*/
    IL_0293: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0298: stfld object EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>2__current  /*0x040013C1*/
    IL_029d: ldarg.0
    IL_029e: ldc.i4.4
    IL_029f: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_02a4: ldc.i4.1
    IL_02a5: ret
    IL_02a6: ldarg.0
    IL_02a7: ldc.i4.m1
    IL_02a8: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_02ad: ldloc.1
    IL_02ae: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::goldScore  /*0x0400133F*/
    IL_02b3: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_02b8: ldc.i4.1
    IL_02b9: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_02be: ldloc.1
    IL_02bf: ldloc.1
    IL_02c0: ldloc.1
    IL_02c1: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::goldScore  /*0x0400133F*/
    IL_02c6: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_02cb: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_02d0: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_02d5: callvirt AudioClip AudioSet::get_PointScreenBuildA()  /*0x060001E1*/
    IL_02da: ldloc.1
    IL_02db: ldfld AnimationCurve EndOfMatchScoreUIHelper::popShowCurve  /*0x0400136F*/
    IL_02e0: ldloc.1
    IL_02e1: ldfld float EndOfMatchScoreUIHelper::animationStepB  /*0x04001388*/
    IL_02e6: call IEnumerator EndOfMatchScoreUIHelper::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06001069*/
    IL_02eb: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_02f0: pop
    IL_02f1: ldarg.0
    IL_02f2: ldloc.1
    IL_02f3: ldfld float EndOfMatchScoreUIHelper::minorWaitStep  /*0x04001386*/
    IL_02f8: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_02fd: stfld object EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>2__current  /*0x040013C1*/
    IL_0302: ldarg.0
    IL_0303: ldc.i4.5
    IL_0304: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_0309: ldc.i4.1
    IL_030a: ret
    IL_030b: ldarg.0
    IL_030c: ldc.i4.m1
    IL_030d: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_0312: ldarg.0
    IL_0313: ldloc.1
    IL_0314: ldloc.1
    IL_0315: ldfld int EndOfMatchScoreUIHelper::goldScoreThisRound  /*0x04001380*/
    IL_031a: ldloc.1
    IL_031b: ldfld float EndOfMatchScoreUIHelper::animationStepA  /*0x04001387*/
    IL_0320: call IEnumerator EndOfMatchScoreUIHelper::AddToOverallScore(int,float)  /*0x06001066*/
    IL_0325: stfld object EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>2__current  /*0x040013C1*/
    IL_032a: ldarg.0
    IL_032b: ldc.i4.6
    IL_032c: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_0331: ldc.i4.1
    IL_0332: ret
    IL_0333: ldarg.0
    IL_0334: ldc.i4.m1
    IL_0335: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_033a: ldloc.1
    IL_033b: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::MutatorBonusName  /*0x0400134C*/
    IL_0340: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0345: ldc.i4.1
    IL_0346: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_034b: ldloc.1
    IL_034c: ldloc.1
    IL_034d: ldloc.1
    IL_034e: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::MutatorBonusName  /*0x0400134C*/
    IL_0353: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0358: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_035d: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0362: callvirt AudioClip AudioSet::get_PointScreenBuildC()  /*0x060001E3*/
    IL_0367: ldloc.1
    IL_0368: ldfld AnimationCurve EndOfMatchScoreUIHelper::popShowCurve  /*0x0400136F*/
    IL_036d: ldloc.1
    IL_036e: ldfld float EndOfMatchScoreUIHelper::animationStepB  /*0x04001388*/
    IL_0373: call IEnumerator EndOfMatchScoreUIHelper::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06001069*/
    IL_0378: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_037d: pop
    IL_037e: ldarg.0
    IL_037f: ldloc.1
    IL_0380: ldfld float EndOfMatchScoreUIHelper::minorWaitStep  /*0x04001386*/
    IL_0385: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_038a: stfld object EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>2__current  /*0x040013C1*/
    IL_038f: ldarg.0
    IL_0390: ldc.i4.7
    IL_0391: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_0396: ldc.i4.1
    IL_0397: ret
    IL_0398: ldarg.0
    IL_0399: ldc.i4.m1
    IL_039a: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_039f: ldloc.1
    IL_03a0: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::mutatorScore  /*0x04001340*/
    IL_03a5: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_03aa: ldc.i4.1
    IL_03ab: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_03b0: ldloc.1
    IL_03b1: ldloc.1
    IL_03b2: ldloc.1
    IL_03b3: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::mutatorScore  /*0x04001340*/
    IL_03b8: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_03bd: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_03c2: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_03c7: callvirt AudioClip AudioSet::get_PointScreenBuildA()  /*0x060001E1*/
    IL_03cc: ldloc.1
    IL_03cd: ldfld AnimationCurve EndOfMatchScoreUIHelper::popShowCurve  /*0x0400136F*/
    IL_03d2: ldloc.1
    IL_03d3: ldfld float EndOfMatchScoreUIHelper::animationStepB  /*0x04001388*/
    IL_03d8: call IEnumerator EndOfMatchScoreUIHelper::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06001069*/
    IL_03dd: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_03e2: pop
    IL_03e3: ldarg.0
    IL_03e4: ldloc.1
    IL_03e5: ldfld float EndOfMatchScoreUIHelper::minorWaitStep  /*0x04001386*/
    IL_03ea: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_03ef: stfld object EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>2__current  /*0x040013C1*/
    IL_03f4: ldarg.0
    IL_03f5: ldc.i4.8
    IL_03f6: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_03fb: ldc.i4.1
    IL_03fc: ret
    IL_03fd: ldarg.0
    IL_03fe: ldc.i4.m1
    IL_03ff: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_0404: ldarg.0
    IL_0405: ldloc.1
    IL_0406: ldloc.1
    IL_0407: ldfld int EndOfMatchScoreUIHelper::mutatorScoreThisRound  /*0x04001381*/
    IL_040c: ldloc.1
    IL_040d: ldfld float EndOfMatchScoreUIHelper::animationStepA  /*0x04001387*/
    IL_0412: call IEnumerator EndOfMatchScoreUIHelper::AddToOverallScore(int,float)  /*0x06001066*/
    IL_0417: stfld object EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>2__current  /*0x040013C1*/
    IL_041c: ldarg.0
    IL_041d: ldc.i4.s 9
    IL_041f: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_0424: ldc.i4.1
    IL_0425: ret
    IL_0426: ldarg.0
    IL_0427: ldc.i4.m1
    IL_0428: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_042d: ldloc.1
    IL_042e: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::noRetryBonusName  /*0x0400134D*/
    IL_0433: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0438: ldc.i4.1
    IL_0439: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_043e: ldloc.1
    IL_043f: ldloc.1
    IL_0440: ldloc.1
    IL_0441: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::noRetryBonusName  /*0x0400134D*/
    IL_0446: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_044b: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0450: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0455: callvirt AudioClip AudioSet::get_PointScreenBuildC()  /*0x060001E3*/
    IL_045a: ldloc.1
    IL_045b: ldfld AnimationCurve EndOfMatchScoreUIHelper::popShowCurve  /*0x0400136F*/
    IL_0460: ldloc.1
    IL_0461: ldfld float EndOfMatchScoreUIHelper::animationStepB  /*0x04001388*/
    IL_0466: call IEnumerator EndOfMatchScoreUIHelper::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06001069*/
    IL_046b: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0470: pop
    IL_0471: ldarg.0
    IL_0472: ldloc.1
    IL_0473: ldfld float EndOfMatchScoreUIHelper::minorWaitStep  /*0x04001386*/
    IL_0478: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_047d: stfld object EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>2__current  /*0x040013C1*/
    IL_0482: ldarg.0
    IL_0483: ldc.i4.s 10
    IL_0485: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_048a: ldc.i4.1
    IL_048b: ret
    IL_048c: ldarg.0
    IL_048d: ldc.i4.m1
    IL_048e: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_0493: ldloc.1
    IL_0494: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::noRetriesScore  /*0x04001341*/
    IL_0499: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_049e: ldc.i4.1
    IL_049f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_04a4: ldloc.1
    IL_04a5: ldloc.1
    IL_04a6: ldloc.1
    IL_04a7: ldfld TextMeshProUGUI EndOfMatchScoreUIHelper::noRetriesScore  /*0x04001341*/
    IL_04ac: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_04b1: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_04b6: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_04bb: callvirt AudioClip AudioSet::get_PointScreenBuildA()  /*0x060001E1*/
    IL_04c0: ldloc.1
    IL_04c1: ldfld AnimationCurve EndOfMatchScoreUIHelper::popShowCurve  /*0x0400136F*/
    IL_04c6: ldloc.1
    IL_04c7: ldfld float EndOfMatchScoreUIHelper::animationStepB  /*0x04001388*/
    IL_04cc: call IEnumerator EndOfMatchScoreUIHelper::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06001069*/
    IL_04d1: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_04d6: pop
    IL_04d7: ldarg.0
    IL_04d8: ldloc.1
    IL_04d9: ldfld float EndOfMatchScoreUIHelper::minorWaitStep  /*0x04001386*/
    IL_04de: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_04e3: stfld object EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>2__current  /*0x040013C1*/
    IL_04e8: ldarg.0
    IL_04e9: ldc.i4.s 11
    IL_04eb: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_04f0: ldc.i4.1
    IL_04f1: ret
    IL_04f2: ldarg.0
    IL_04f3: ldc.i4.m1
    IL_04f4: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_04f9: ldarg.0
    IL_04fa: ldloc.1
    IL_04fb: ldloc.1
    IL_04fc: ldfld int EndOfMatchScoreUIHelper::noRetryScoreThisRound  /*0x04001382*/
    IL_0501: ldloc.1
    IL_0502: ldfld float EndOfMatchScoreUIHelper::animationStepA  /*0x04001387*/
    IL_0507: call IEnumerator EndOfMatchScoreUIHelper::AddToOverallScore(int,float)  /*0x06001066*/
    IL_050c: stfld object EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>2__current  /*0x040013C1*/
    IL_0511: ldarg.0
    IL_0512: ldc.i4.s 12
    IL_0514: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_0519: ldc.i4.1
    IL_051a: ret
    IL_051b: ldarg.0
    IL_051c: ldc.i4.m1
    IL_051d: stfld int EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>1__state  /*0x040013C0*/
    IL_0522: ldloc.1
    IL_0523: ldnull
    IL_0524: stfld Coroutine EndOfMatchScoreUIHelper::currentScoringAnimation  /*0x0400138A*/
    IL_0529: ldc.i4.0
    IL_052a: ret

  .method EndOfMatchScoreUIHelper.<UnrollScores>d__104::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060010A2 rva 0x4c863 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>2__current  /*0x040013C1*/
    IL_0006: ret

  .method EndOfMatchScoreUIHelper.<UnrollScores>d__104::System.Collections.IEnumerator.Reset()  // token 0x060010A3 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EndOfMatchScoreUIHelper.<UnrollScores>d__104::System.Collections.IEnumerator.get_Current()  // token 0x060010A4 rva 0x4c863 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EndOfMatchScoreUIHelper.<UnrollScores>d__104::<>2__current  /*0x040013C1*/
    IL_0006: ret

