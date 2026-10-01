// ===== AfterMatchUIManager  (token 0x02000009) =====
  .method AfterMatchUIManager::Start()  // token 0x06000029 rva 0x2786 attrs Private, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0006: stfld PerkManager AfterMatchUIManager::perkManager  /*0x0400003C*/
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: call IEnumerator AfterMatchUIManager::ShowRewards()  /*0x0600002A*/
    IL_0012: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0017: pop
    IL_0018: ldarg.0
    IL_0019: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_001e: ldc.i4.0
    IL_001f: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_0024: stfld Player AfterMatchUIManager::input  /*0x0400003E*/
    IL_0029: ret

  .method AfterMatchUIManager::ShowRewards()  // token 0x0600002A rva 0x27b1 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void AfterMatchUIManager.<ShowRewards>d__30::.ctor(int)  /*0x0600003C*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld AfterMatchUIManager AfterMatchUIManager.<ShowRewards>d__30::<>4__this  /*0x04000044*/
    IL_000d: ret

  .method AfterMatchUIManager::SelectNextMetaLevel()  // token 0x0600002B rva 0x27c0 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void AfterMatchUIManager.<SelectNextMetaLevel>d__31::.ctor(int)  /*0x06000036*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld AfterMatchUIManager AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>4__this  /*0x04000041*/
    IL_000d: ret

  .method AfterMatchUIManager::DisableAllUI()  // token 0x0600002C rva 0x27d0 attrs Private, HideBySig
    // code size 73 (0x49), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject AfterMatchUIManager::levelingProgressUI  /*0x0400002B*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: ldfld GameObject AfterMatchUIManager::rewardDisplayUI  /*0x04000031*/
    IL_0012: ldc.i4.0
    IL_0013: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0018: ldarg.0
    IL_0019: ldfld GameObject AfterMatchUIManager::maxLevelReachedUI  /*0x04000036*/
    IL_001e: ldc.i4.0
    IL_001f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0024: ldarg.0
    IL_0025: ldfld GameObject AfterMatchUIManager::graphs  /*0x04000028*/
    IL_002a: ldc.i4.0
    IL_002b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0030: ldarg.0
    IL_0031: ldfld GameObject AfterMatchUIManager::scoreScreenUI  /*0x04000022*/
    IL_0036: ldc.i4.0
    IL_0037: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003c: ldarg.0
    IL_003d: ldfld GameObject AfterMatchUIManager::demoLockedUI  /*0x04000037*/
    IL_0042: ldc.i4.0
    IL_0043: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0048: ret

  .method AfterMatchUIManager::EnableLevelingProgressUI()  // token 0x0600002D rva 0x2825 attrs Private, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AfterMatchUIManager::DisableAllUI()  /*0x0600002C*/
    IL_0006: ldarg.0
    IL_0007: ldfld GameObject AfterMatchUIManager::levelingProgressUI  /*0x0400002B*/
    IL_000c: ldc.i4.1
    IL_000d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0012: ret

  .method AfterMatchUIManager::EnableRewardDisplayUI()  // token 0x0600002E rva 0x2839 attrs Private, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AfterMatchUIManager::DisableAllUI()  /*0x0600002C*/
    IL_0006: ldarg.0
    IL_0007: ldfld GameObject AfterMatchUIManager::rewardDisplayUI  /*0x04000031*/
    IL_000c: ldc.i4.1
    IL_000d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0012: ret

  .method AfterMatchUIManager::EnableMaxLevelReachedUI()  // token 0x0600002F rva 0x284d attrs Private, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AfterMatchUIManager::DisableAllUI()  /*0x0600002C*/
    IL_0006: ldarg.0
    IL_0007: ldfld GameObject AfterMatchUIManager::maxLevelReachedUI  /*0x04000036*/
    IL_000c: ldc.i4.1
    IL_000d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0012: ret

  .method AfterMatchUIManager::EnableDemoLockedUI()  // token 0x06000030 rva 0x2861 attrs Private, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AfterMatchUIManager::DisableAllUI()  /*0x0600002C*/
    IL_0006: ldarg.0
    IL_0007: ldfld GameObject AfterMatchUIManager::demoLockedUI  /*0x04000037*/
    IL_000c: ldc.i4.1
    IL_000d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0012: ret

  .method AfterMatchUIManager::EnableGraphsUI()  // token 0x06000031 rva 0x2875 attrs Private, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AfterMatchUIManager::DisableAllUI()  /*0x0600002C*/
    IL_0006: ldarg.0
    IL_0007: ldfld GameObject AfterMatchUIManager::graphs  /*0x04000028*/
    IL_000c: ldc.i4.0
    IL_000d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0012: ret

  .method AfterMatchUIManager::EnableScoreUI()  // token 0x06000032 rva 0x2889 attrs Private, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AfterMatchUIManager::DisableAllUI()  /*0x0600002C*/
    IL_0006: ldarg.0
    IL_0007: ldfld GameObject AfterMatchUIManager::scoreScreenUI  /*0x04000022*/
    IL_000c: ldc.i4.1
    IL_000d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0012: ret

  .method AfterMatchUIManager::UpdateLevelingBar()  // token 0x06000033 rva 0x28a0 attrs Private, HideBySig
    // code size 85 (0x55), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld TMP_Text AfterMatchUIManager::xpDisplay  /*0x0400002F*/
    IL_0006: ldarg.0
    IL_0007: ldfld PerkManager AfterMatchUIManager::perkManager  /*0x0400003C*/
    IL_000c: ldflda int PerkManager::xp  /*0x04000BEB*/
    IL_0011: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0016: ldstr " / "
    IL_001b: ldarg.0
    IL_001c: ldfld MetaLevel AfterMatchUIManager::nextMetaLevel  /*0x0400003D*/
    IL_0021: ldflda int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_0026: call string System.Int32::ToString()  /*0x0A000031*/
    IL_002b: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0030: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0035: ldarg.0
    IL_0036: ldarg.0
    IL_0037: ldfld PerkManager AfterMatchUIManager::perkManager  /*0x0400003C*/
    IL_003c: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_0041: conv.r4
    IL_0042: ldarg.0
    IL_0043: ldfld MetaLevel AfterMatchUIManager::nextMetaLevel  /*0x0400003D*/
    IL_0048: ldfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_004d: conv.r4
    IL_004e: div
    IL_004f: call void AfterMatchUIManager::SetLevelingParPercentage(float)  /*0x06000034*/
    IL_0054: ret

  .method AfterMatchUIManager::SetLevelingParPercentage(float)  // token 0x06000034 rva 0x2904 attrs Private, HideBySig
    // code size 93 (0x5d), max stack 4, init locals
    .locals ([0] float, [1] float, [2] Rect)
    IL_0000: ldarg.0
    IL_0001: ldfld RectTransform AfterMatchUIManager::levelingBarBack  /*0x0400002D*/
    IL_0006: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A000033*/
    IL_000b: stloc.2
    IL_000c: ldloca.s 2
    IL_000e: call float UnityEngine.Rect::get_width()  /*0x0A000034*/
    IL_0013: stloc.0
    IL_0014: ldloc.0
    IL_0015: ldarg.1
    IL_0016: mul
    IL_0017: stloc.1
    IL_0018: ldarg.0
    IL_0019: ldfld RectTransform AfterMatchUIManager::levelingBarFront  /*0x0400002E*/
    IL_001e: ldarg.1
    IL_001f: ldc.r4 1f
    IL_0024: ldc.r4 1f
    IL_0029: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_002e: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0033: ldarg.0
    IL_0034: ldfld RectTransform AfterMatchUIManager::levelingBarFront  /*0x0400002E*/
    IL_0039: ldloc.1
    IL_003a: ldc.r4 2f
    IL_003f: div
    IL_0040: ldloc.0
    IL_0041: ldc.r4 2f
    IL_0046: div
    IL_0047: sub
    IL_0048: ldc.r4 0f
    IL_004d: ldc.r4 0f
    IL_0052: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0057: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_005c: ret

  .method AfterMatchUIManager::.ctor()  // token 0x06000035 rva 0x296d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 5f
    IL_0006: stfld float AfterMatchUIManager::timeToFillUpABar  /*0x04000038*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.25f
    IL_0011: stfld float AfterMatchUIManager::waitAtBeginning  /*0x04000039*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.25f
    IL_001c: stfld float AfterMatchUIManager::waitAfterFillingUpABar  /*0x0400003A*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 0.25f
    IL_0027: stfld float AfterMatchUIManager::waitBeforeYouCanInteract  /*0x0400003B*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0032: ret

// ===== AfterMatchUIManager/<SelectNextMetaLevel>d__31  (token 0x0200000A) =====
  .method AfterMatchUIManager.<SelectNextMetaLevel>d__31::.ctor(int)  // token 0x06000036 rva 0x29a1 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>1__state  /*0x0400003F*/
    IL_000d: ret

  .method AfterMatchUIManager.<SelectNextMetaLevel>d__31::System.IDisposable.Dispose()  // token 0x06000037 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AfterMatchUIManager.<SelectNextMetaLevel>d__31::MoveNext()  // token 0x06000038 rva 0x29b0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 193 (0xc1), max stack 2, init locals
    .locals ([0] int, [1] AfterMatchUIManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>1__state  /*0x0400003F*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld AfterMatchUIManager AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>4__this  /*0x04000041*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0026, IL_0066, IL_007f, IL_00b8)
    IL_0024: ldc.i4.0
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldc.i4.m1
    IL_0028: stfld int AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>1__state  /*0x0400003F*/
    IL_002d: ldloc.1
    IL_002e: ldloc.1
    IL_002f: ldfld PerkManager AfterMatchUIManager::perkManager  /*0x0400003C*/
    IL_0034: callvirt MetaLevel PerkManager::get_NextMetaLevel()  /*0x0600097C*/
    IL_0039: stfld MetaLevel AfterMatchUIManager::nextMetaLevel  /*0x0400003D*/
    IL_003e: ldloc.1
    IL_003f: ldfld MetaLevel AfterMatchUIManager::nextMetaLevel  /*0x0400003D*/
    IL_0044: brtrue.s IL_00bf
    IL_0046: ldloc.1
    IL_0047: call void AfterMatchUIManager::EnableMaxLevelReachedUI()  /*0x0600002F*/
    IL_004c: ldarg.0
    IL_004d: ldloc.1
    IL_004e: ldfld float AfterMatchUIManager::waitBeforeYouCanInteract  /*0x0400003B*/
    IL_0053: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0058: stfld object AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>2__current  /*0x04000040*/
    IL_005d: ldarg.0
    IL_005e: ldc.i4.1
    IL_005f: stfld int AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>1__state  /*0x0400003F*/
    IL_0064: ldc.i4.1
    IL_0065: ret
    IL_0066: ldarg.0
    IL_0067: ldc.i4.m1
    IL_0068: stfld int AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>1__state  /*0x0400003F*/
    IL_006d: br.s IL_0086
    IL_006f: ldarg.0
    IL_0070: ldnull
    IL_0071: stfld object AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>2__current  /*0x04000040*/
    IL_0076: ldarg.0
    IL_0077: ldc.i4.2
    IL_0078: stfld int AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>1__state  /*0x0400003F*/
    IL_007d: ldc.i4.1
    IL_007e: ret
    IL_007f: ldarg.0
    IL_0080: ldc.i4.m1
    IL_0081: stfld int AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>1__state  /*0x0400003F*/
    IL_0086: ldloc.1
    IL_0087: ldfld Player AfterMatchUIManager::input  /*0x0400003E*/
    IL_008c: ldstr "Interact"
    IL_0091: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0096: brfalse.s IL_006f
    IL_0098: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_009d: callvirt void SceneTransitionManager::TransitionFromEndScreenToLevelSelect()  /*0x060009CE*/
    IL_00a2: ldloc.1
    IL_00a3: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_00a8: ldarg.0
    IL_00a9: ldnull
    IL_00aa: stfld object AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>2__current  /*0x04000040*/
    IL_00af: ldarg.0
    IL_00b0: ldc.i4.3
    IL_00b1: stfld int AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>1__state  /*0x0400003F*/
    IL_00b6: ldc.i4.1
    IL_00b7: ret
    IL_00b8: ldarg.0
    IL_00b9: ldc.i4.m1
    IL_00ba: stfld int AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>1__state  /*0x0400003F*/
    IL_00bf: ldc.i4.0
    IL_00c0: ret

  .method AfterMatchUIManager.<SelectNextMetaLevel>d__31::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000039 rva 0x2a7d attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>2__current  /*0x04000040*/
    IL_0006: ret

  .method AfterMatchUIManager.<SelectNextMetaLevel>d__31::System.Collections.IEnumerator.Reset()  // token 0x0600003A rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method AfterMatchUIManager.<SelectNextMetaLevel>d__31::System.Collections.IEnumerator.get_Current()  // token 0x0600003B rva 0x2a7d attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterMatchUIManager.<SelectNextMetaLevel>d__31::<>2__current  /*0x04000040*/
    IL_0006: ret

// ===== AfterMatchUIManager/<ShowRewards>d__30  (token 0x0200000B) =====
  .method AfterMatchUIManager.<ShowRewards>d__30::.ctor(int)  // token 0x0600003C rva 0x2a8c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_000d: ret

  .method AfterMatchUIManager.<ShowRewards>d__30::System.IDisposable.Dispose()  // token 0x0600003D rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AfterMatchUIManager.<ShowRewards>d__30::MoveNext()  // token 0x0600003E rva 0x2a9c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1233 (0x4d1), max stack 4, init locals
    .locals ([0] int, [1] AfterMatchUIManager, [2] int, [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld AfterMatchUIManager AfterMatchUIManager.<ShowRewards>d__30::<>4__this  /*0x04000044*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0046, IL_010a, IL_0123, IL_0161, IL_01ce, IL_029c, IL_033e, IL_0357, IL_03b5, IL_042c, IL_0450, IL_046a)
    IL_0044: ldc.i4.0
    IL_0045: ret
    IL_0046: ldarg.0
    IL_0047: ldc.i4.m1
    IL_0048: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_004d: ldloc.1
    IL_004e: call void AfterMatchUIManager::EnableScoreUI()  /*0x06000032*/
    IL_0053: ldloc.1
    IL_0054: ldfld TMP_Text AfterMatchUIManager::ingameHighscore  /*0x04000023*/
    IL_0059: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_005e: callvirt int SceneTransitionManager::get_IngameScoreFromLastMatch()  /*0x060009BE*/
    IL_0063: stloc.2
    IL_0064: ldloca.s 2
    IL_0066: call string System.Int32::ToString()  /*0x0A000031*/
    IL_006b: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0070: ldloc.1
    IL_0071: ldfld TMP_Text AfterMatchUIManager::goldBonus  /*0x04000024*/
    IL_0076: ldstr "+"
    IL_007b: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0080: callvirt int SceneTransitionManager::get_GoldBonusScoreFromLastMatch()  /*0x060009BF*/
    IL_0085: stloc.2
    IL_0086: ldloca.s 2
    IL_0088: call string System.Int32::ToString()  /*0x0A000031*/
    IL_008d: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0092: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0097: ldloc.1
    IL_0098: ldfld TMP_Text AfterMatchUIManager::mutationBonus  /*0x04000025*/
    IL_009d: ldstr "+"
    IL_00a2: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_00a7: callvirt int SceneTransitionManager::get_MutatorBonusScoreFromLastMatch()  /*0x060009C0*/
    IL_00ac: stloc.2
    IL_00ad: ldloca.s 2
    IL_00af: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00b4: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00b9: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00be: ldloc.1
    IL_00bf: ldfld TMP_Text AfterMatchUIManager::totalScore  /*0x04000026*/
    IL_00c4: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_00c9: callvirt int SceneTransitionManager::get_TotalScoreFromLastMatch()  /*0x060009C2*/
    IL_00ce: stloc.2
    IL_00cf: ldloca.s 2
    IL_00d1: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00d6: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00db: ldloc.1
    IL_00dc: ldfld GameObject AfterMatchUIManager::newPersonalBest  /*0x04000027*/
    IL_00e1: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_00e6: callvirt bool SceneTransitionManager::get_TotalScoreFromLastMatchIsNewPersonalRecord()  /*0x060009C3*/
    IL_00eb: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00f0: ldarg.0
    IL_00f1: ldloc.1
    IL_00f2: ldfld float AfterMatchUIManager::waitAtBeginning  /*0x04000039*/
    IL_00f7: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_00fc: stfld object AfterMatchUIManager.<ShowRewards>d__30::<>2__current  /*0x04000043*/
    IL_0101: ldarg.0
    IL_0102: ldc.i4.1
    IL_0103: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_0108: ldc.i4.1
    IL_0109: ret
    IL_010a: ldarg.0
    IL_010b: ldc.i4.m1
    IL_010c: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_0111: br.s IL_012a
    IL_0113: ldarg.0
    IL_0114: ldnull
    IL_0115: stfld object AfterMatchUIManager.<ShowRewards>d__30::<>2__current  /*0x04000043*/
    IL_011a: ldarg.0
    IL_011b: ldc.i4.2
    IL_011c: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_0121: ldc.i4.1
    IL_0122: ret
    IL_0123: ldarg.0
    IL_0124: ldc.i4.m1
    IL_0125: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_012a: ldloc.1
    IL_012b: ldfld Player AfterMatchUIManager::input  /*0x0400003E*/
    IL_0130: ldstr "Interact"
    IL_0135: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_013a: brfalse.s IL_0113
    IL_013c: ldarg.0
    IL_013d: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0142: callvirt int SceneTransitionManager::get_TotalScoreFromLastMatch()  /*0x060009C2*/
    IL_0147: stfld int AfterMatchUIManager.<ShowRewards>d__30::<xpToGive>5__2  /*0x04000045*/
    IL_014c: ldarg.0
    IL_014d: ldloc.1
    IL_014e: call IEnumerator AfterMatchUIManager::SelectNextMetaLevel()  /*0x0600002B*/
    IL_0153: stfld object AfterMatchUIManager.<ShowRewards>d__30::<>2__current  /*0x04000043*/
    IL_0158: ldarg.0
    IL_0159: ldc.i4.3
    IL_015a: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_015f: ldc.i4.1
    IL_0160: ret
    IL_0161: ldarg.0
    IL_0162: ldc.i4.m1
    IL_0163: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_0168: ldloc.1
    IL_0169: call void AfterMatchUIManager::EnableLevelingProgressUI()  /*0x0600002D*/
    IL_016e: ldloc.1
    IL_016f: ldfld TMP_Text AfterMatchUIManager::currentLevelTxt1  /*0x0400002C*/
    IL_0174: ldstr "Level "
    IL_0179: ldloc.1
    IL_017a: ldfld PerkManager AfterMatchUIManager::perkManager  /*0x0400003C*/
    IL_017f: ldflda int PerkManager::level  /*0x04000BEC*/
    IL_0184: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0189: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_018e: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0193: ldloc.1
    IL_0194: ldfld Image AfterMatchUIManager::rewardPreview1  /*0x04000030*/
    IL_0199: ldloc.1
    IL_019a: ldfld MetaLevel AfterMatchUIManager::nextMetaLevel  /*0x0400003D*/
    IL_019f: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_01a4: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_01a9: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_01ae: ldloc.1
    IL_01af: call void AfterMatchUIManager::UpdateLevelingBar()  /*0x06000033*/
    IL_01b4: ldarg.0
    IL_01b5: ldloc.1
    IL_01b6: ldfld float AfterMatchUIManager::waitAtBeginning  /*0x04000039*/
    IL_01bb: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_01c0: stfld object AfterMatchUIManager.<ShowRewards>d__30::<>2__current  /*0x04000043*/
    IL_01c5: ldarg.0
    IL_01c6: ldc.i4.4
    IL_01c7: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_01cc: ldc.i4.1
    IL_01cd: ret
    IL_01ce: ldarg.0
    IL_01cf: ldc.i4.m1
    IL_01d0: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_01d5: ldarg.0
    IL_01d6: ldloc.1
    IL_01d7: ldfld MetaLevel AfterMatchUIManager::nextMetaLevel  /*0x0400003D*/
    IL_01dc: ldfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_01e1: conv.r4
    IL_01e2: ldloc.1
    IL_01e3: ldfld float AfterMatchUIManager::timeToFillUpABar  /*0x04000038*/
    IL_01e8: div
    IL_01e9: stfld float AfterMatchUIManager.<ShowRewards>d__30::<xPTrickleSpeed>5__3  /*0x04000046*/
    IL_01ee: ldarg.0
    IL_01ef: ldc.r4 0f
    IL_01f4: stfld float AfterMatchUIManager.<ShowRewards>d__30::<xpTrickle>5__4  /*0x04000047*/
    IL_01f9: br IL_0433
    IL_01fe: ldarg.0
    IL_01ff: ldarg.0
    IL_0200: ldfld float AfterMatchUIManager.<ShowRewards>d__30::<xpTrickle>5__4  /*0x04000047*/
    IL_0205: ldarg.0
    IL_0206: ldfld float AfterMatchUIManager.<ShowRewards>d__30::<xPTrickleSpeed>5__3  /*0x04000046*/
    IL_020b: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0210: mul
    IL_0211: add
    IL_0212: stfld float AfterMatchUIManager.<ShowRewards>d__30::<xpTrickle>5__4  /*0x04000047*/
    IL_0217: ldarg.0
    IL_0218: ldfld float AfterMatchUIManager.<ShowRewards>d__30::<xpTrickle>5__4  /*0x04000047*/
    IL_021d: conv.i4
    IL_021e: stloc.3
    IL_021f: ldarg.0
    IL_0220: ldarg.0
    IL_0221: ldfld float AfterMatchUIManager.<ShowRewards>d__30::<xpTrickle>5__4  /*0x04000047*/
    IL_0226: ldloc.3
    IL_0227: conv.r4
    IL_0228: sub
    IL_0229: stfld float AfterMatchUIManager.<ShowRewards>d__30::<xpTrickle>5__4  /*0x04000047*/
    IL_022e: ldarg.0
    IL_022f: ldarg.0
    IL_0230: ldfld int AfterMatchUIManager.<ShowRewards>d__30::<xpToGive>5__2  /*0x04000045*/
    IL_0235: ldloc.3
    IL_0236: sub
    IL_0237: stfld int AfterMatchUIManager.<ShowRewards>d__30::<xpToGive>5__2  /*0x04000045*/
    IL_023c: ldarg.0
    IL_023d: ldfld int AfterMatchUIManager.<ShowRewards>d__30::<xpToGive>5__2  /*0x04000045*/
    IL_0242: ldc.i4.0
    IL_0243: bge.s IL_024e
    IL_0245: ldloc.3
    IL_0246: ldarg.0
    IL_0247: ldfld int AfterMatchUIManager.<ShowRewards>d__30::<xpToGive>5__2  /*0x04000045*/
    IL_024c: sub
    IL_024d: stloc.3
    IL_024e: ldloc.1
    IL_024f: ldfld PerkManager AfterMatchUIManager::perkManager  /*0x0400003C*/
    IL_0254: dup
    IL_0255: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_025a: ldloc.3
    IL_025b: add
    IL_025c: stfld int PerkManager::xp  /*0x04000BEB*/
    IL_0261: ldloc.1
    IL_0262: call void AfterMatchUIManager::UpdateLevelingBar()  /*0x06000033*/
    IL_0267: ldloc.1
    IL_0268: ldfld PerkManager AfterMatchUIManager::perkManager  /*0x0400003C*/
    IL_026d: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_0272: ldloc.1
    IL_0273: ldfld MetaLevel AfterMatchUIManager::nextMetaLevel  /*0x0400003D*/
    IL_0278: ldfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_027d: blt IL_041b
    IL_0282: ldarg.0
    IL_0283: ldloc.1
    IL_0284: ldfld float AfterMatchUIManager::waitAfterFillingUpABar  /*0x0400003A*/
    IL_0289: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_028e: stfld object AfterMatchUIManager.<ShowRewards>d__30::<>2__current  /*0x04000043*/
    IL_0293: ldarg.0
    IL_0294: ldc.i4.5
    IL_0295: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_029a: ldc.i4.1
    IL_029b: ret
    IL_029c: ldarg.0
    IL_029d: ldc.i4.m1
    IL_029e: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_02a3: ldloc.1
    IL_02a4: call void AfterMatchUIManager::EnableRewardDisplayUI()  /*0x0600002E*/
    IL_02a9: ldloc.1
    IL_02aa: ldfld TMP_Text AfterMatchUIManager::currentLevelTxt2  /*0x04000032*/
    IL_02af: ldstr "Level "
    IL_02b4: ldc.i4.1
    IL_02b5: ldloc.1
    IL_02b6: ldfld PerkManager AfterMatchUIManager::perkManager  /*0x0400003C*/
    IL_02bb: ldfld int PerkManager::level  /*0x04000BEC*/
    IL_02c0: add
    IL_02c1: stloc.2
    IL_02c2: ldloca.s 2
    IL_02c4: call string System.Int32::ToString()  /*0x0A000031*/
    IL_02c9: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_02ce: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_02d3: ldloc.1
    IL_02d4: ldfld Image AfterMatchUIManager::rewardPreview2  /*0x04000033*/
    IL_02d9: ldloc.1
    IL_02da: ldfld MetaLevel AfterMatchUIManager::nextMetaLevel  /*0x0400003D*/
    IL_02df: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_02e4: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_02e9: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_02ee: ldloc.1
    IL_02ef: ldfld TMP_Text AfterMatchUIManager::itemName  /*0x04000034*/
    IL_02f4: ldloc.1
    IL_02f5: ldfld MetaLevel AfterMatchUIManager::nextMetaLevel  /*0x0400003D*/
    IL_02fa: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_02ff: ldfld string Equippable::displayName  /*0x04000E2B*/
    IL_0304: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0309: ldloc.1
    IL_030a: ldfld TMP_Text AfterMatchUIManager::itemDescription  /*0x04000035*/
    IL_030f: ldloc.1
    IL_0310: ldfld MetaLevel AfterMatchUIManager::nextMetaLevel  /*0x0400003D*/
    IL_0315: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_031a: ldfld string Equippable::description  /*0x04000E2C*/
    IL_031f: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0324: ldarg.0
    IL_0325: ldloc.1
    IL_0326: ldfld float AfterMatchUIManager::waitBeforeYouCanInteract  /*0x0400003B*/
    IL_032b: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0330: stfld object AfterMatchUIManager.<ShowRewards>d__30::<>2__current  /*0x04000043*/
    IL_0335: ldarg.0
    IL_0336: ldc.i4.6
    IL_0337: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_033c: ldc.i4.1
    IL_033d: ret
    IL_033e: ldarg.0
    IL_033f: ldc.i4.m1
    IL_0340: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_0345: br.s IL_035e
    IL_0347: ldarg.0
    IL_0348: ldnull
    IL_0349: stfld object AfterMatchUIManager.<ShowRewards>d__30::<>2__current  /*0x04000043*/
    IL_034e: ldarg.0
    IL_034f: ldc.i4.7
    IL_0350: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_0355: ldc.i4.1
    IL_0356: ret
    IL_0357: ldarg.0
    IL_0358: ldc.i4.m1
    IL_0359: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_035e: ldloc.1
    IL_035f: ldfld Player AfterMatchUIManager::input  /*0x0400003E*/
    IL_0364: ldstr "Interact"
    IL_0369: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_036e: brfalse.s IL_0347
    IL_0370: ldloc.1
    IL_0371: ldfld PerkManager AfterMatchUIManager::perkManager  /*0x0400003C*/
    IL_0376: dup
    IL_0377: ldfld int PerkManager::xp  /*0x04000BEB*/
    IL_037c: ldloc.1
    IL_037d: ldfld MetaLevel AfterMatchUIManager::nextMetaLevel  /*0x0400003D*/
    IL_0382: ldfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_0387: sub
    IL_0388: stfld int PerkManager::xp  /*0x04000BEB*/
    IL_038d: ldloc.1
    IL_038e: ldfld PerkManager AfterMatchUIManager::perkManager  /*0x0400003C*/
    IL_0393: dup
    IL_0394: ldfld int PerkManager::level  /*0x04000BEC*/
    IL_0399: ldc.i4.1
    IL_039a: add
    IL_039b: stfld int PerkManager::level  /*0x04000BEC*/
    IL_03a0: ldarg.0
    IL_03a1: ldloc.1
    IL_03a2: call IEnumerator AfterMatchUIManager::SelectNextMetaLevel()  /*0x0600002B*/
    IL_03a7: stfld object AfterMatchUIManager.<ShowRewards>d__30::<>2__current  /*0x04000043*/
    IL_03ac: ldarg.0
    IL_03ad: ldc.i4.8
    IL_03ae: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_03b3: ldc.i4.1
    IL_03b4: ret
    IL_03b5: ldarg.0
    IL_03b6: ldc.i4.m1
    IL_03b7: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_03bc: ldarg.0
    IL_03bd: ldloc.1
    IL_03be: ldfld MetaLevel AfterMatchUIManager::nextMetaLevel  /*0x0400003D*/
    IL_03c3: ldfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_03c8: conv.r4
    IL_03c9: ldloc.1
    IL_03ca: ldfld float AfterMatchUIManager::timeToFillUpABar  /*0x04000038*/
    IL_03cf: div
    IL_03d0: stfld float AfterMatchUIManager.<ShowRewards>d__30::<xPTrickleSpeed>5__3  /*0x04000046*/
    IL_03d5: ldloc.1
    IL_03d6: ldfld TMP_Text AfterMatchUIManager::currentLevelTxt1  /*0x0400002C*/
    IL_03db: ldstr "Level "
    IL_03e0: ldloc.1
    IL_03e1: ldfld PerkManager AfterMatchUIManager::perkManager  /*0x0400003C*/
    IL_03e6: ldflda int PerkManager::level  /*0x04000BEC*/
    IL_03eb: call string System.Int32::ToString()  /*0x0A000031*/
    IL_03f0: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_03f5: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_03fa: ldloc.1
    IL_03fb: ldfld Image AfterMatchUIManager::rewardPreview1  /*0x04000030*/
    IL_0400: ldloc.1
    IL_0401: ldfld MetaLevel AfterMatchUIManager::nextMetaLevel  /*0x0400003D*/
    IL_0406: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_040b: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_0410: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0415: ldloc.1
    IL_0416: call void AfterMatchUIManager::EnableLevelingProgressUI()  /*0x0600002D*/
    IL_041b: ldarg.0
    IL_041c: ldnull
    IL_041d: stfld object AfterMatchUIManager.<ShowRewards>d__30::<>2__current  /*0x04000043*/
    IL_0422: ldarg.0
    IL_0423: ldc.i4.s 9
    IL_0425: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_042a: ldc.i4.1
    IL_042b: ret
    IL_042c: ldarg.0
    IL_042d: ldc.i4.m1
    IL_042e: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_0433: ldarg.0
    IL_0434: ldfld int AfterMatchUIManager.<ShowRewards>d__30::<xpToGive>5__2  /*0x04000045*/
    IL_0439: ldc.i4.0
    IL_043a: bgt IL_01fe
    IL_043f: ldarg.0
    IL_0440: ldnull
    IL_0441: stfld object AfterMatchUIManager.<ShowRewards>d__30::<>2__current  /*0x04000043*/
    IL_0446: ldarg.0
    IL_0447: ldc.i4.s 10
    IL_0449: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_044e: ldc.i4.1
    IL_044f: ret
    IL_0450: ldarg.0
    IL_0451: ldc.i4.m1
    IL_0452: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_0457: br.s IL_0471
    IL_0459: ldarg.0
    IL_045a: ldnull
    IL_045b: stfld object AfterMatchUIManager.<ShowRewards>d__30::<>2__current  /*0x04000043*/
    IL_0460: ldarg.0
    IL_0461: ldc.i4.s 11
    IL_0463: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_0468: ldc.i4.1
    IL_0469: ret
    IL_046a: ldarg.0
    IL_046b: ldc.i4.m1
    IL_046c: stfld int AfterMatchUIManager.<ShowRewards>d__30::<>1__state  /*0x04000042*/
    IL_0471: ldloc.1
    IL_0472: ldfld Player AfterMatchUIManager::input  /*0x0400003E*/
    IL_0477: ldstr "Interact"
    IL_047c: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0481: brfalse.s IL_0459
    IL_0483: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0488: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_048d: callvirt string SceneTransitionManager::get_ComingFromGameplayScene()  /*0x060009C4*/
    IL_0492: callvirt LevelData LevelProgressManager::GetLevelDataForScene(string)  /*0x0600094A*/
    IL_0497: ldc.i4.1
    IL_0498: callvirt void LevelData::SaveScoreAndStatsToBestIfBest(bool)  /*0x06000951*/
    IL_049d: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_04a2: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_04a7: callvirt int SceneTransitionManager::get_TotalScoreFromLastMatch()  /*0x060009C2*/
    IL_04ac: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_04b1: callvirt string SceneTransitionManager::get_ComingFromGameplayScene()  /*0x060009C4*/
    IL_04b6: callvirt void Thronefall.GameServices.IGameServices::UploadHighscore(int,string)  /*0x06003DFD*/
    IL_04bb: ldsfld SaveLoadManager SaveLoadManager::instance  /*0x04000C65*/
    IL_04c0: callvirt void SaveLoadManager::SaveGame()  /*0x060009B5*/
    IL_04c5: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_04ca: callvirt void SceneTransitionManager::TransitionFromEndScreenToLevelSelect()  /*0x060009CE*/
    IL_04cf: ldc.i4.0
    IL_04d0: ret

  .method AfterMatchUIManager.<ShowRewards>d__30::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600003F rva 0x2f79 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterMatchUIManager.<ShowRewards>d__30::<>2__current  /*0x04000043*/
    IL_0006: ret

  .method AfterMatchUIManager.<ShowRewards>d__30::System.Collections.IEnumerator.Reset()  // token 0x06000040 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method AfterMatchUIManager.<ShowRewards>d__30::System.Collections.IEnumerator.get_Current()  // token 0x06000041 rva 0x2f79 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterMatchUIManager.<ShowRewards>d__30::<>2__current  /*0x04000043*/
    IL_0006: ret

