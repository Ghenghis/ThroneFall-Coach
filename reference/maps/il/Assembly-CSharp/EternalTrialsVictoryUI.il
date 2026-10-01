// ===== EternalTrialsVictoryUI  (token 0x020002CB) =====
  .method EternalTrialsVictoryUI::Update()  // token 0x06000F71 rva 0x465e8 attrs Private, HideBySig
    // code size 113 (0x71), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Player EternalTrialsVictoryUI::input  /*0x04001245*/
    IL_0006: brtrue.s IL_0019
    IL_0008: ldarg.0
    IL_0009: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_000e: ldc.i4.0
    IL_000f: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_0014: stfld Player EternalTrialsVictoryUI::input  /*0x04001245*/
    IL_0019: ldarg.0
    IL_001a: ldfld Player EternalTrialsVictoryUI::input  /*0x04001245*/
    IL_001f: brtrue.s IL_0022
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldfld Player EternalTrialsVictoryUI::input  /*0x04001245*/
    IL_0028: ldstr "Interact"
    IL_002d: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0032: brfalse.s IL_0070
    IL_0034: ldarg.0
    IL_0035: ldfld bool EternalTrialsVictoryUI::inScoreUnroll  /*0x04001239*/
    IL_003a: brfalse.s IL_0070
    IL_003c: ldarg.0
    IL_003d: ldfld Coroutine EternalTrialsVictoryUI::currentScoringAnimation  /*0x04001242*/
    IL_0042: brfalse.s IL_0050
    IL_0044: ldarg.0
    IL_0045: ldarg.0
    IL_0046: ldfld Coroutine EternalTrialsVictoryUI::currentScoringAnimation  /*0x04001242*/
    IL_004b: call void UnityEngine.MonoBehaviour::StopCoroutine(UnityEngine.Coroutine)  /*0x0A000114*/
    IL_0050: ldarg.0
    IL_0051: ldnull
    IL_0052: stfld Coroutine EternalTrialsVictoryUI::currentScoringAnimation  /*0x04001242*/
    IL_0057: ldarg.0
    IL_0058: ldfld AudioSource EternalTrialsVictoryUI::audioSource  /*0x04001237*/
    IL_005d: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_0062: ldarg.0
    IL_0063: ldc.i4.1
    IL_0064: stfld bool EternalTrialsVictoryUI::skipScoringAnimation  /*0x04001243*/
    IL_0069: ldarg.0
    IL_006a: ldc.i4.0
    IL_006b: stfld bool EternalTrialsVictoryUI::inScoreUnroll  /*0x04001239*/
    IL_0070: ret

  .method EternalTrialsVictoryUI::PlayAnimation(UIFrame)  // token 0x06000F72 rva 0x46665 attrs Public, Virtual, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EternalTrialsVictoryUI.<PlayAnimation>d__29::.ctor(int)  /*0x06000F8D*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EternalTrialsVictoryUI EternalTrialsVictoryUI.<PlayAnimation>d__29::<>4__this  /*0x0400125A*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld UIFrame EternalTrialsVictoryUI.<PlayAnimation>d__29::contextFrame  /*0x0400125B*/
    IL_0014: ret

  .method EternalTrialsVictoryUI::Reset()  // token 0x06000F73 rva 0x4667b attrs Public, Virtual, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject EternalTrialsVictoryUI::parentObject  /*0x0400122A*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method EternalTrialsVictoryUI::UnrollScores()  // token 0x06000F74 rva 0x46689 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EternalTrialsVictoryUI.<UnrollScores>d__31::.ctor(int)  /*0x06000F99*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EternalTrialsVictoryUI EternalTrialsVictoryUI.<UnrollScores>d__31::<>4__this  /*0x04001268*/
    IL_000d: ret

  .method EternalTrialsVictoryUI::SkipUnrollScores()  // token 0x06000F75 rva 0x46698 attrs Private, HideBySig
    // code size 339 (0x153), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0006: callvirt int SceneTransitionManager::get_IngameScoreFromLastMatch()  /*0x060009BE*/
    IL_000b: stfld int EternalTrialsVictoryUI::baseScoreThisRound  /*0x0400123A*/
    IL_0010: ldarg.0
    IL_0011: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0016: callvirt int SceneTransitionManager::get_GoldBonusScoreFromLastMatch()  /*0x060009BF*/
    IL_001b: stfld int EternalTrialsVictoryUI::goldScoreThisRound  /*0x0400123B*/
    IL_0020: ldarg.0
    IL_0021: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0026: ldfld int EternalTrialsRun::score  /*0x04000850*/
    IL_002b: stfld int EternalTrialsVictoryUI::overallScoreThisRound  /*0x0400123C*/
    IL_0030: ldarg.0
    IL_0031: ldfld TextMeshProUGUI EternalTrialsVictoryUI::baseScore  /*0x0400122E*/
    IL_0036: ldarg.0
    IL_0037: ldflda int EternalTrialsVictoryUI::baseScoreThisRound  /*0x0400123A*/
    IL_003c: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0041: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0046: ldarg.0
    IL_0047: ldfld TextMeshProUGUI EternalTrialsVictoryUI::goldScore  /*0x04001230*/
    IL_004c: ldarg.0
    IL_004d: ldflda int EternalTrialsVictoryUI::goldScoreThisRound  /*0x0400123B*/
    IL_0052: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0057: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_005c: ldarg.0
    IL_005d: ldfld TextMeshProUGUI EternalTrialsVictoryUI::overallScore  /*0x04001232*/
    IL_0062: ldarg.0
    IL_0063: ldflda int EternalTrialsVictoryUI::overallScoreThisRound  /*0x0400123C*/
    IL_0068: call string System.Int32::ToString()  /*0x0A000031*/
    IL_006d: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0072: ldarg.0
    IL_0073: ldfld GameObject EternalTrialsVictoryUI::dividerParent  /*0x0400122B*/
    IL_0078: ldc.i4.1
    IL_0079: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_007e: ldarg.0
    IL_007f: ldfld TextMeshProUGUI EternalTrialsVictoryUI::baseScoreName  /*0x0400122F*/
    IL_0084: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0089: ldc.i4.1
    IL_008a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_008f: ldarg.0
    IL_0090: ldfld TextMeshProUGUI EternalTrialsVictoryUI::baseScore  /*0x0400122E*/
    IL_0095: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_009a: ldc.i4.1
    IL_009b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00a0: ldarg.0
    IL_00a1: ldfld TextMeshProUGUI EternalTrialsVictoryUI::goldBonusName  /*0x04001231*/
    IL_00a6: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00ab: ldc.i4.1
    IL_00ac: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld TextMeshProUGUI EternalTrialsVictoryUI::goldScore  /*0x04001230*/
    IL_00b7: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00bc: ldc.i4.1
    IL_00bd: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00c2: ldarg.0
    IL_00c3: ldfld GameObject EternalTrialsVictoryUI::dividerParent  /*0x0400122B*/
    IL_00c8: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00cd: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00d2: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00d7: ldarg.0
    IL_00d8: ldfld TextMeshProUGUI EternalTrialsVictoryUI::baseScoreName  /*0x0400122F*/
    IL_00dd: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_00e2: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00e7: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00ec: ldarg.0
    IL_00ed: ldfld TextMeshProUGUI EternalTrialsVictoryUI::baseScore  /*0x0400122E*/
    IL_00f2: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_00f7: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00fc: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0101: ldarg.0
    IL_0102: ldfld TextMeshProUGUI EternalTrialsVictoryUI::goldBonusName  /*0x04001231*/
    IL_0107: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_010c: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0111: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0116: ldarg.0
    IL_0117: ldfld TextMeshProUGUI EternalTrialsVictoryUI::goldScore  /*0x04001230*/
    IL_011c: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0121: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0126: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_012b: ldarg.0
    IL_012c: ldfld TextMeshProUGUI EternalTrialsVictoryUI::overallScore  /*0x04001232*/
    IL_0131: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0136: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_013b: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0140: ldarg.0
    IL_0141: ldarg.0
    IL_0142: ldc.r4 0.5f
    IL_0147: call IEnumerator EternalTrialsVictoryUI::LockInScoreBump(float)  /*0x06000F77*/
    IL_014c: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0151: pop
    IL_0152: ret

  .method EternalTrialsVictoryUI::AddToOverallScore(int,float)  // token 0x06000F76 rva 0x467f7 attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EternalTrialsVictoryUI.<AddToOverallScore>d__33::.ctor(int)  /*0x06000F7B*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EternalTrialsVictoryUI EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>4__this  /*0x04001249*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld int EternalTrialsVictoryUI.<AddToOverallScore>d__33::scoreToAdd  /*0x04001248*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld float EternalTrialsVictoryUI.<AddToOverallScore>d__33::animTime  /*0x0400124A*/
    IL_001b: ret

  .method EternalTrialsVictoryUI::LockInScoreBump(float)  // token 0x06000F77 rva 0x46814 attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EternalTrialsVictoryUI.<LockInScoreBump>d__34::.ctor(int)  /*0x06000F87*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EternalTrialsVictoryUI EternalTrialsVictoryUI.<LockInScoreBump>d__34::<>4__this  /*0x04001255*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float EternalTrialsVictoryUI.<LockInScoreBump>d__34::animTime  /*0x04001256*/
    IL_0014: ret

  .method EternalTrialsVictoryUI::Bump(float,UnityEngine.Transform,UnityEngine.AudioClip)  // token 0x06000F78 rva 0x4682a attrs Private, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EternalTrialsVictoryUI.<Bump>d__35::.ctor(int)  /*0x06000F81*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EternalTrialsVictoryUI EternalTrialsVictoryUI.<Bump>d__35::<>4__this  /*0x0400124F*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float EternalTrialsVictoryUI.<Bump>d__35::animTime  /*0x04001251*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld Transform EternalTrialsVictoryUI.<Bump>d__35::target  /*0x04001250*/
    IL_001b: dup
    IL_001c: ldarg.3
    IL_001d: stfld AudioClip EternalTrialsVictoryUI.<Bump>d__35::clip  /*0x0400124E*/
    IL_0022: ret

  .method EternalTrialsVictoryUI::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  // token 0x06000F79 rva 0x4684e attrs Private, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void EternalTrialsVictoryUI.<PopShowTransform>d__36::.ctor(int)  /*0x06000F93*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld EternalTrialsVictoryUI EternalTrialsVictoryUI.<PopShowTransform>d__36::<>4__this  /*0x04001261*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld Transform EternalTrialsVictoryUI.<PopShowTransform>d__36::target  /*0x04001262*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld AudioClip EternalTrialsVictoryUI.<PopShowTransform>d__36::clip  /*0x04001260*/
    IL_001b: dup
    IL_001c: ldarg.3
    IL_001d: stfld AnimationCurve EternalTrialsVictoryUI.<PopShowTransform>d__36::curve  /*0x04001263*/
    IL_0022: dup
    IL_0023: ldarg.s 4
    IL_0025: stfld float EternalTrialsVictoryUI.<PopShowTransform>d__36::animTime  /*0x04001264*/
    IL_002a: ret

  .method EternalTrialsVictoryUI::.ctor()  // token 0x06000F7A rva 0x4687a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.5f
    IL_0006: stfld float EternalTrialsVictoryUI::defaultWaitStep  /*0x0400123E*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.25f
    IL_0011: stfld float EternalTrialsVictoryUI::minorWaitStep  /*0x0400123F*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1.5f
    IL_001c: stfld float EternalTrialsVictoryUI::animationStepA  /*0x04001240*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 0.5f
    IL_0027: stfld float EternalTrialsVictoryUI::animationStepB  /*0x04001241*/
    IL_002c: ldarg.0
    IL_002d: call void IUIAnimationSequence::.ctor()  /*0x06000FA1*/
    IL_0032: ret

// ===== EternalTrialsVictoryUI/<AddToOverallScore>d__33  (token 0x020002CC) =====
  .method EternalTrialsVictoryUI.<AddToOverallScore>d__33::.ctor(int)  // token 0x06000F7B rva 0x468ae attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>1__state  /*0x04001246*/
    IL_000d: ret

  .method EternalTrialsVictoryUI.<AddToOverallScore>d__33::System.IDisposable.Dispose()  // token 0x06000F7C rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EternalTrialsVictoryUI.<AddToOverallScore>d__33::MoveNext()  // token 0x06000F7D rva 0x468c0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 386 (0x182), max stack 6, init locals
    .locals ([0] int, [1] EternalTrialsVictoryUI, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>1__state  /*0x04001246*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EternalTrialsVictoryUI EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>4__this  /*0x04001249*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0026, IL_004e, IL_010b, IL_0179)
    IL_0024: ldc.i4.0
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldc.i4.m1
    IL_0028: stfld int EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>1__state  /*0x04001246*/
    IL_002d: ldarg.0
    IL_002e: ldfld int EternalTrialsVictoryUI.<AddToOverallScore>d__33::scoreToAdd  /*0x04001248*/
    IL_0033: brtrue.s IL_0057
    IL_0035: ldarg.0
    IL_0036: ldc.r4 0.15f
    IL_003b: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0040: stfld object EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>2__current  /*0x04001247*/
    IL_0045: ldarg.0
    IL_0046: ldc.i4.1
    IL_0047: stfld int EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>1__state  /*0x04001246*/
    IL_004c: ldc.i4.1
    IL_004d: ret
    IL_004e: ldarg.0
    IL_004f: ldc.i4.m1
    IL_0050: stfld int EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>1__state  /*0x04001246*/
    IL_0055: ldc.i4.0
    IL_0056: ret
    IL_0057: ldloc.1
    IL_0058: ldfld AudioSource EternalTrialsVictoryUI::audioSource  /*0x04001237*/
    IL_005d: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0062: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0067: callvirt AudioClip AudioSet::get_PointFill()  /*0x060001E5*/
    IL_006c: callvirt void UnityEngine.AudioSource::set_clip(UnityEngine.AudioClip)  /*0x0A0000D0*/
    IL_0071: ldloc.1
    IL_0072: ldfld AudioSource EternalTrialsVictoryUI::audioSource  /*0x04001237*/
    IL_0077: ldc.i4.1
    IL_0078: callvirt void UnityEngine.AudioSource::set_loop(bool)  /*0x0A0000DF*/
    IL_007d: ldloc.1
    IL_007e: ldfld AudioSource EternalTrialsVictoryUI::audioSource  /*0x04001237*/
    IL_0083: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_0088: ldloc.1
    IL_0089: ldloc.1
    IL_008a: ldfld int EternalTrialsVictoryUI::animationNextScore  /*0x0400123D*/
    IL_008f: ldarg.0
    IL_0090: ldfld int EternalTrialsVictoryUI.<AddToOverallScore>d__33::scoreToAdd  /*0x04001248*/
    IL_0095: add
    IL_0096: stfld int EternalTrialsVictoryUI::animationNextScore  /*0x0400123D*/
    IL_009b: ldarg.0
    IL_009c: ldc.r4 0f
    IL_00a1: stfld float EternalTrialsVictoryUI.<AddToOverallScore>d__33::<timer>5__2  /*0x0400124B*/
    IL_00a6: br.s IL_0112
    IL_00a8: ldarg.0
    IL_00a9: ldarg.0
    IL_00aa: ldfld float EternalTrialsVictoryUI.<AddToOverallScore>d__33::<timer>5__2  /*0x0400124B*/
    IL_00af: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_00b4: add
    IL_00b5: stfld float EternalTrialsVictoryUI.<AddToOverallScore>d__33::<timer>5__2  /*0x0400124B*/
    IL_00ba: ldloc.1
    IL_00bb: ldfld TextMeshProUGUI EternalTrialsVictoryUI::overallScore  /*0x04001232*/
    IL_00c0: ldloc.1
    IL_00c1: ldfld int EternalTrialsVictoryUI::overallScoreThisRound  /*0x0400123C*/
    IL_00c6: conv.r4
    IL_00c7: ldloc.1
    IL_00c8: ldfld int EternalTrialsVictoryUI::animationNextScore  /*0x0400123D*/
    IL_00cd: conv.r4
    IL_00ce: ldc.r4 0f
    IL_00d3: ldarg.0
    IL_00d4: ldfld float EternalTrialsVictoryUI.<AddToOverallScore>d__33::animTime  /*0x0400124A*/
    IL_00d9: ldarg.0
    IL_00da: ldfld float EternalTrialsVictoryUI.<AddToOverallScore>d__33::<timer>5__2  /*0x0400124B*/
    IL_00df: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_00e4: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_00e9: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_00ee: stloc.2
    IL_00ef: ldloca.s 2
    IL_00f1: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00f6: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00fb: ldarg.0
    IL_00fc: ldnull
    IL_00fd: stfld object EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>2__current  /*0x04001247*/
    IL_0102: ldarg.0
    IL_0103: ldc.i4.2
    IL_0104: stfld int EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>1__state  /*0x04001246*/
    IL_0109: ldc.i4.1
    IL_010a: ret
    IL_010b: ldarg.0
    IL_010c: ldc.i4.m1
    IL_010d: stfld int EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>1__state  /*0x04001246*/
    IL_0112: ldarg.0
    IL_0113: ldfld float EternalTrialsVictoryUI.<AddToOverallScore>d__33::<timer>5__2  /*0x0400124B*/
    IL_0118: ldarg.0
    IL_0119: ldfld float EternalTrialsVictoryUI.<AddToOverallScore>d__33::animTime  /*0x0400124A*/
    IL_011e: blt.s IL_00a8
    IL_0120: ldloc.1
    IL_0121: ldloc.1
    IL_0122: ldfld int EternalTrialsVictoryUI::animationNextScore  /*0x0400123D*/
    IL_0127: stfld int EternalTrialsVictoryUI::overallScoreThisRound  /*0x0400123C*/
    IL_012c: ldloc.1
    IL_012d: ldfld TextMeshProUGUI EternalTrialsVictoryUI::overallScore  /*0x04001232*/
    IL_0132: ldloc.1
    IL_0133: ldflda int EternalTrialsVictoryUI::overallScoreThisRound  /*0x0400123C*/
    IL_0138: call string System.Int32::ToString()  /*0x0A000031*/
    IL_013d: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0142: ldloc.1
    IL_0143: ldfld AudioSource EternalTrialsVictoryUI::audioSource  /*0x04001237*/
    IL_0148: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_014d: ldloc.1
    IL_014e: ldfld AudioSource EternalTrialsVictoryUI::audioSource  /*0x04001237*/
    IL_0153: ldc.i4.0
    IL_0154: callvirt void UnityEngine.AudioSource::set_loop(bool)  /*0x0A0000DF*/
    IL_0159: ldarg.0
    IL_015a: ldloc.1
    IL_015b: ldloc.1
    IL_015c: ldc.r4 0.5f
    IL_0161: call IEnumerator EternalTrialsVictoryUI::LockInScoreBump(float)  /*0x06000F77*/
    IL_0166: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_016b: stfld object EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>2__current  /*0x04001247*/
    IL_0170: ldarg.0
    IL_0171: ldc.i4.3
    IL_0172: stfld int EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>1__state  /*0x04001246*/
    IL_0177: ldc.i4.1
    IL_0178: ret
    IL_0179: ldarg.0
    IL_017a: ldc.i4.m1
    IL_017b: stfld int EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>1__state  /*0x04001246*/
    IL_0180: ldc.i4.0
    IL_0181: ret

  .method EternalTrialsVictoryUI.<AddToOverallScore>d__33::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F7E rva 0x46a4e attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>2__current  /*0x04001247*/
    IL_0006: ret

  .method EternalTrialsVictoryUI.<AddToOverallScore>d__33::System.Collections.IEnumerator.Reset()  // token 0x06000F7F rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EternalTrialsVictoryUI.<AddToOverallScore>d__33::System.Collections.IEnumerator.get_Current()  // token 0x06000F80 rva 0x46a4e attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsVictoryUI.<AddToOverallScore>d__33::<>2__current  /*0x04001247*/
    IL_0006: ret

// ===== EternalTrialsVictoryUI/<Bump>d__35  (token 0x020002CD) =====
  .method EternalTrialsVictoryUI.<Bump>d__35::.ctor(int)  // token 0x06000F81 rva 0x46a56 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EternalTrialsVictoryUI.<Bump>d__35::<>1__state  /*0x0400124C*/
    IL_000d: ret

  .method EternalTrialsVictoryUI.<Bump>d__35::System.IDisposable.Dispose()  // token 0x06000F82 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EternalTrialsVictoryUI.<Bump>d__35::MoveNext()  // token 0x06000F83 rva 0x46a68 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 213 (0xd5), max stack 6, init locals
    .locals ([0] int, [1] EternalTrialsVictoryUI)
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsVictoryUI.<Bump>d__35::<>1__state  /*0x0400124C*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EternalTrialsVictoryUI EternalTrialsVictoryUI.<Bump>d__35::<>4__this  /*0x0400124F*/
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
    IL_001c: stfld int EternalTrialsVictoryUI.<Bump>d__35::<>1__state  /*0x0400124C*/
    IL_0021: ldarg.0
    IL_0022: ldfld AudioClip EternalTrialsVictoryUI.<Bump>d__35::clip  /*0x0400124E*/
    IL_0027: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002c: brfalse.s IL_003f
    IL_002e: ldloc.1
    IL_002f: ldfld AudioSource EternalTrialsVictoryUI::audioSource  /*0x04001237*/
    IL_0034: ldarg.0
    IL_0035: ldfld AudioClip EternalTrialsVictoryUI.<Bump>d__35::clip  /*0x0400124E*/
    IL_003a: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_003f: ldarg.0
    IL_0040: ldc.r4 0f
    IL_0045: stfld float EternalTrialsVictoryUI.<Bump>d__35::<timer>5__2  /*0x04001252*/
    IL_004a: br.s IL_00b0
    IL_004c: ldarg.0
    IL_004d: ldarg.0
    IL_004e: ldfld float EternalTrialsVictoryUI.<Bump>d__35::<timer>5__2  /*0x04001252*/
    IL_0053: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0058: add
    IL_0059: stfld float EternalTrialsVictoryUI.<Bump>d__35::<timer>5__2  /*0x04001252*/
    IL_005e: ldarg.0
    IL_005f: ldfld Transform EternalTrialsVictoryUI.<Bump>d__35::target  /*0x04001250*/
    IL_0064: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0069: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_006e: ldloc.1
    IL_006f: ldfld AnimationCurve EternalTrialsVictoryUI::bumpCurve  /*0x04001235*/
    IL_0074: ldc.r4 0f
    IL_0079: ldarg.0
    IL_007a: ldfld float EternalTrialsVictoryUI.<Bump>d__35::animTime  /*0x04001251*/
    IL_007f: ldarg.0
    IL_0080: ldfld float EternalTrialsVictoryUI.<Bump>d__35::<timer>5__2  /*0x04001252*/
    IL_0085: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_008a: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_008f: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0094: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0099: ldarg.0
    IL_009a: ldnull
    IL_009b: stfld object EternalTrialsVictoryUI.<Bump>d__35::<>2__current  /*0x0400124D*/
    IL_00a0: ldarg.0
    IL_00a1: ldc.i4.1
    IL_00a2: stfld int EternalTrialsVictoryUI.<Bump>d__35::<>1__state  /*0x0400124C*/
    IL_00a7: ldc.i4.1
    IL_00a8: ret
    IL_00a9: ldarg.0
    IL_00aa: ldc.i4.m1
    IL_00ab: stfld int EternalTrialsVictoryUI.<Bump>d__35::<>1__state  /*0x0400124C*/
    IL_00b0: ldarg.0
    IL_00b1: ldfld float EternalTrialsVictoryUI.<Bump>d__35::<timer>5__2  /*0x04001252*/
    IL_00b6: ldarg.0
    IL_00b7: ldfld float EternalTrialsVictoryUI.<Bump>d__35::animTime  /*0x04001251*/
    IL_00bc: blt.s IL_004c
    IL_00be: ldarg.0
    IL_00bf: ldfld Transform EternalTrialsVictoryUI.<Bump>d__35::target  /*0x04001250*/
    IL_00c4: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00c9: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00ce: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00d3: ldc.i4.0
    IL_00d4: ret

  .method EternalTrialsVictoryUI.<Bump>d__35::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F84 rva 0x46b49 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsVictoryUI.<Bump>d__35::<>2__current  /*0x0400124D*/
    IL_0006: ret

  .method EternalTrialsVictoryUI.<Bump>d__35::System.Collections.IEnumerator.Reset()  // token 0x06000F85 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EternalTrialsVictoryUI.<Bump>d__35::System.Collections.IEnumerator.get_Current()  // token 0x06000F86 rva 0x46b49 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsVictoryUI.<Bump>d__35::<>2__current  /*0x0400124D*/
    IL_0006: ret

// ===== EternalTrialsVictoryUI/<LockInScoreBump>d__34  (token 0x020002CE) =====
  .method EternalTrialsVictoryUI.<LockInScoreBump>d__34::.ctor(int)  // token 0x06000F87 rva 0x46b51 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EternalTrialsVictoryUI.<LockInScoreBump>d__34::<>1__state  /*0x04001253*/
    IL_000d: ret

  .method EternalTrialsVictoryUI.<LockInScoreBump>d__34::System.IDisposable.Dispose()  // token 0x06000F88 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EternalTrialsVictoryUI.<LockInScoreBump>d__34::MoveNext()  // token 0x06000F89 rva 0x46b60 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 214 (0xd6), max stack 6, init locals
    .locals ([0] int, [1] EternalTrialsVictoryUI)
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsVictoryUI.<LockInScoreBump>d__34::<>1__state  /*0x04001253*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EternalTrialsVictoryUI EternalTrialsVictoryUI.<LockInScoreBump>d__34::<>4__this  /*0x04001255*/
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
    IL_001c: stfld int EternalTrialsVictoryUI.<LockInScoreBump>d__34::<>1__state  /*0x04001253*/
    IL_0021: ldloc.1
    IL_0022: ldfld AudioSource EternalTrialsVictoryUI::audioSource  /*0x04001237*/
    IL_0027: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_002c: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0031: callvirt AudioClip AudioSet::get_PointLockInMajor()  /*0x060001E0*/
    IL_0036: ldc.r4 0.85f
    IL_003b: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_0040: ldarg.0
    IL_0041: ldc.r4 0f
    IL_0046: stfld float EternalTrialsVictoryUI.<LockInScoreBump>d__34::<timer>5__2  /*0x04001257*/
    IL_004b: br.s IL_00b1
    IL_004d: ldarg.0
    IL_004e: ldarg.0
    IL_004f: ldfld float EternalTrialsVictoryUI.<LockInScoreBump>d__34::<timer>5__2  /*0x04001257*/
    IL_0054: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0059: add
    IL_005a: stfld float EternalTrialsVictoryUI.<LockInScoreBump>d__34::<timer>5__2  /*0x04001257*/
    IL_005f: ldloc.1
    IL_0060: ldfld TextMeshProUGUI EternalTrialsVictoryUI::overallScore  /*0x04001232*/
    IL_0065: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_006a: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_006f: ldloc.1
    IL_0070: ldfld AnimationCurve EternalTrialsVictoryUI::bumpCurve  /*0x04001235*/
    IL_0075: ldc.r4 0f
    IL_007a: ldarg.0
    IL_007b: ldfld float EternalTrialsVictoryUI.<LockInScoreBump>d__34::animTime  /*0x04001256*/
    IL_0080: ldarg.0
    IL_0081: ldfld float EternalTrialsVictoryUI.<LockInScoreBump>d__34::<timer>5__2  /*0x04001257*/
    IL_0086: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_008b: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0090: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0095: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_009a: ldarg.0
    IL_009b: ldnull
    IL_009c: stfld object EternalTrialsVictoryUI.<LockInScoreBump>d__34::<>2__current  /*0x04001254*/
    IL_00a1: ldarg.0
    IL_00a2: ldc.i4.1
    IL_00a3: stfld int EternalTrialsVictoryUI.<LockInScoreBump>d__34::<>1__state  /*0x04001253*/
    IL_00a8: ldc.i4.1
    IL_00a9: ret
    IL_00aa: ldarg.0
    IL_00ab: ldc.i4.m1
    IL_00ac: stfld int EternalTrialsVictoryUI.<LockInScoreBump>d__34::<>1__state  /*0x04001253*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld float EternalTrialsVictoryUI.<LockInScoreBump>d__34::<timer>5__2  /*0x04001257*/
    IL_00b7: ldarg.0
    IL_00b8: ldfld float EternalTrialsVictoryUI.<LockInScoreBump>d__34::animTime  /*0x04001256*/
    IL_00bd: blt.s IL_004d
    IL_00bf: ldloc.1
    IL_00c0: ldfld TextMeshProUGUI EternalTrialsVictoryUI::overallScore  /*0x04001232*/
    IL_00c5: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_00ca: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00cf: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00d4: ldc.i4.0
    IL_00d5: ret

  .method EternalTrialsVictoryUI.<LockInScoreBump>d__34::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F8A rva 0x46c42 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsVictoryUI.<LockInScoreBump>d__34::<>2__current  /*0x04001254*/
    IL_0006: ret

  .method EternalTrialsVictoryUI.<LockInScoreBump>d__34::System.Collections.IEnumerator.Reset()  // token 0x06000F8B rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EternalTrialsVictoryUI.<LockInScoreBump>d__34::System.Collections.IEnumerator.get_Current()  // token 0x06000F8C rva 0x46c42 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsVictoryUI.<LockInScoreBump>d__34::<>2__current  /*0x04001254*/
    IL_0006: ret

// ===== EternalTrialsVictoryUI/<PlayAnimation>d__29  (token 0x020002CF) =====
  .method EternalTrialsVictoryUI.<PlayAnimation>d__29::.ctor(int)  // token 0x06000F8D rva 0x46c4a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EternalTrialsVictoryUI.<PlayAnimation>d__29::<>1__state  /*0x04001258*/
    IL_000d: ret

  .method EternalTrialsVictoryUI.<PlayAnimation>d__29::System.IDisposable.Dispose()  // token 0x06000F8E rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EternalTrialsVictoryUI.<PlayAnimation>d__29::MoveNext()  // token 0x06000F8F rva 0x46c5c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 512 (0x200), max stack 7, init locals
    .locals ([0] int, [1] EternalTrialsVictoryUI)
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsVictoryUI.<PlayAnimation>d__29::<>1__state  /*0x04001258*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EternalTrialsVictoryUI EternalTrialsVictoryUI.<PlayAnimation>d__29::<>4__this  /*0x0400125A*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0026, IL_015f, IL_01b2, IL_01f7)
    IL_0024: ldc.i4.0
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldc.i4.m1
    IL_0028: stfld int EternalTrialsVictoryUI.<PlayAnimation>d__29::<>1__state  /*0x04001258*/
    IL_002d: ldloc.1
    IL_002e: ldc.i4.0
    IL_002f: stfld bool EternalTrialsVictoryUI::inScoreUnroll  /*0x04001239*/
    IL_0034: ldloc.1
    IL_0035: ldc.i4.0
    IL_0036: stfld bool EternalTrialsVictoryUI::skipScoringAnimation  /*0x04001243*/
    IL_003b: ldloc.1
    IL_003c: ldfld GameObject EternalTrialsVictoryUI::parentObject  /*0x0400122A*/
    IL_0041: ldc.i4.1
    IL_0042: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0047: ldloc.1
    IL_0048: ldfld TextMeshProUGUI EternalTrialsVictoryUI::victoryDisplay  /*0x04001233*/
    IL_004d: ldstr "Menu/Victory"
    IL_0052: ldc.i4.1
    IL_0053: ldc.i4.0
    IL_0054: ldc.i4.1
    IL_0055: ldc.i4.1
    IL_0056: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_005b: ldstr "."
    IL_0060: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0065: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_006a: ldloc.1
    IL_006b: ldfld TextMeshProUGUI EternalTrialsVictoryUI::stageDisplay  /*0x0400122D*/
    IL_0070: ldstr "<style=Body Bold>"
    IL_0075: ldstr "Menu/Stage"
    IL_007a: ldc.i4.1
    IL_007b: ldc.i4.0
    IL_007c: ldc.i4.1
    IL_007d: ldc.i4.1
    IL_007e: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0083: ldstr "<style=Body Numerals> "
    IL_0088: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_008d: ldflda int EternalTrialsRun::stage  /*0x0400084F*/
    IL_0092: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0097: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_009c: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00a1: ldloc.1
    IL_00a2: ldfld TextMeshProUGUI EternalTrialsVictoryUI::baseScore  /*0x0400122E*/
    IL_00a7: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00ac: ldc.i4.0
    IL_00ad: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00b2: ldloc.1
    IL_00b3: ldfld TextMeshProUGUI EternalTrialsVictoryUI::baseScoreName  /*0x0400122F*/
    IL_00b8: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00bd: ldc.i4.0
    IL_00be: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00c3: ldloc.1
    IL_00c4: ldfld TextMeshProUGUI EternalTrialsVictoryUI::goldScore  /*0x04001230*/
    IL_00c9: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00ce: ldc.i4.0
    IL_00cf: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00d4: ldloc.1
    IL_00d5: ldfld TextMeshProUGUI EternalTrialsVictoryUI::goldBonusName  /*0x04001231*/
    IL_00da: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00df: ldc.i4.0
    IL_00e0: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00e5: ldloc.1
    IL_00e6: ldfld GameObject EternalTrialsVictoryUI::dividerParent  /*0x0400122B*/
    IL_00eb: ldc.i4.0
    IL_00ec: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00f1: ldloc.1
    IL_00f2: ldfld CanvasGroup EternalTrialsVictoryUI::backgroundCG  /*0x04001238*/
    IL_00f7: ldc.r4 0f
    IL_00fc: callvirt void UnityEngine.CanvasGroup::set_alpha(float)  /*0x0A000609*/
    IL_0101: ldloc.1
    IL_0102: ldfld GameObject EternalTrialsVictoryUI::parentObject  /*0x0400122A*/
    IL_0107: ldc.i4.1
    IL_0108: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_010d: ldarg.0
    IL_010e: ldc.r4 0f
    IL_0113: stfld float EternalTrialsVictoryUI.<PlayAnimation>d__29::<mainFrameFadeTimer>5__2  /*0x0400125C*/
    IL_0118: ldarg.0
    IL_0119: ldc.r4 0.25f
    IL_011e: stfld float EternalTrialsVictoryUI.<PlayAnimation>d__29::<fadeTime>5__3  /*0x0400125D*/
    IL_0123: br.s IL_0166
    IL_0125: ldarg.0
    IL_0126: ldarg.0
    IL_0127: ldfld float EternalTrialsVictoryUI.<PlayAnimation>d__29::<mainFrameFadeTimer>5__2  /*0x0400125C*/
    IL_012c: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0131: add
    IL_0132: stfld float EternalTrialsVictoryUI.<PlayAnimation>d__29::<mainFrameFadeTimer>5__2  /*0x0400125C*/
    IL_0137: ldloc.1
    IL_0138: ldfld CanvasGroup EternalTrialsVictoryUI::backgroundCG  /*0x04001238*/
    IL_013d: ldarg.0
    IL_013e: ldfld float EternalTrialsVictoryUI.<PlayAnimation>d__29::<mainFrameFadeTimer>5__2  /*0x0400125C*/
    IL_0143: ldarg.0
    IL_0144: ldfld float EternalTrialsVictoryUI.<PlayAnimation>d__29::<fadeTime>5__3  /*0x0400125D*/
    IL_0149: div
    IL_014a: callvirt void UnityEngine.CanvasGroup::set_alpha(float)  /*0x0A000609*/
    IL_014f: ldarg.0
    IL_0150: ldnull
    IL_0151: stfld object EternalTrialsVictoryUI.<PlayAnimation>d__29::<>2__current  /*0x04001259*/
    IL_0156: ldarg.0
    IL_0157: ldc.i4.1
    IL_0158: stfld int EternalTrialsVictoryUI.<PlayAnimation>d__29::<>1__state  /*0x04001258*/
    IL_015d: ldc.i4.1
    IL_015e: ret
    IL_015f: ldarg.0
    IL_0160: ldc.i4.m1
    IL_0161: stfld int EternalTrialsVictoryUI.<PlayAnimation>d__29::<>1__state  /*0x04001258*/
    IL_0166: ldarg.0
    IL_0167: ldfld float EternalTrialsVictoryUI.<PlayAnimation>d__29::<mainFrameFadeTimer>5__2  /*0x0400125C*/
    IL_016c: ldarg.0
    IL_016d: ldfld float EternalTrialsVictoryUI.<PlayAnimation>d__29::<fadeTime>5__3  /*0x0400125D*/
    IL_0172: blt.s IL_0125
    IL_0174: ldloc.1
    IL_0175: ldfld CanvasGroup EternalTrialsVictoryUI::backgroundCG  /*0x04001238*/
    IL_017a: ldc.r4 1f
    IL_017f: callvirt void UnityEngine.CanvasGroup::set_alpha(float)  /*0x0A000609*/
    IL_0184: ldc.r4 0f
    IL_0189: call void UnityEngine.Time::set_timeScale(float)  /*0x0A00050F*/
    IL_018e: ldloc.1
    IL_018f: ldloc.1
    IL_0190: ldloc.1
    IL_0191: call IEnumerator EternalTrialsVictoryUI::UnrollScores()  /*0x06000F74*/
    IL_0196: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_019b: stfld Coroutine EternalTrialsVictoryUI::currentScoringAnimation  /*0x04001242*/
    IL_01a0: br.s IL_01b9
    IL_01a2: ldarg.0
    IL_01a3: ldnull
    IL_01a4: stfld object EternalTrialsVictoryUI.<PlayAnimation>d__29::<>2__current  /*0x04001259*/
    IL_01a9: ldarg.0
    IL_01aa: ldc.i4.2
    IL_01ab: stfld int EternalTrialsVictoryUI.<PlayAnimation>d__29::<>1__state  /*0x04001258*/
    IL_01b0: ldc.i4.1
    IL_01b1: ret
    IL_01b2: ldarg.0
    IL_01b3: ldc.i4.m1
    IL_01b4: stfld int EternalTrialsVictoryUI.<PlayAnimation>d__29::<>1__state  /*0x04001258*/
    IL_01b9: ldloc.1
    IL_01ba: ldfld Coroutine EternalTrialsVictoryUI::currentScoringAnimation  /*0x04001242*/
    IL_01bf: brtrue.s IL_01a2
    IL_01c1: ldloc.1
    IL_01c2: ldfld bool EternalTrialsVictoryUI::skipScoringAnimation  /*0x04001243*/
    IL_01c7: brfalse.s IL_01cf
    IL_01c9: ldloc.1
    IL_01ca: call void EternalTrialsVictoryUI::SkipUnrollScores()  /*0x06000F75*/
    IL_01cf: ldloc.1
    IL_01d0: ldc.i4.0
    IL_01d1: stfld bool EternalTrialsVictoryUI::inAnimation  /*0x04001244*/
    IL_01d6: ldarg.0
    IL_01d7: ldfld UIFrame EternalTrialsVictoryUI.<PlayAnimation>d__29::contextFrame  /*0x0400125B*/
    IL_01dc: ldloc.1
    IL_01dd: ldfld ThronefallUIElement EternalTrialsVictoryUI::continueButton  /*0x0400122C*/
    IL_01e2: callvirt void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_01e7: ldarg.0
    IL_01e8: ldnull
    IL_01e9: stfld object EternalTrialsVictoryUI.<PlayAnimation>d__29::<>2__current  /*0x04001259*/
    IL_01ee: ldarg.0
    IL_01ef: ldc.i4.3
    IL_01f0: stfld int EternalTrialsVictoryUI.<PlayAnimation>d__29::<>1__state  /*0x04001258*/
    IL_01f5: ldc.i4.1
    IL_01f6: ret
    IL_01f7: ldarg.0
    IL_01f8: ldc.i4.m1
    IL_01f9: stfld int EternalTrialsVictoryUI.<PlayAnimation>d__29::<>1__state  /*0x04001258*/
    IL_01fe: ldc.i4.0
    IL_01ff: ret

  .method EternalTrialsVictoryUI.<PlayAnimation>d__29::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F90 rva 0x46e68 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsVictoryUI.<PlayAnimation>d__29::<>2__current  /*0x04001259*/
    IL_0006: ret

  .method EternalTrialsVictoryUI.<PlayAnimation>d__29::System.Collections.IEnumerator.Reset()  // token 0x06000F91 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EternalTrialsVictoryUI.<PlayAnimation>d__29::System.Collections.IEnumerator.get_Current()  // token 0x06000F92 rva 0x46e68 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsVictoryUI.<PlayAnimation>d__29::<>2__current  /*0x04001259*/
    IL_0006: ret

// ===== EternalTrialsVictoryUI/<PopShowTransform>d__36  (token 0x020002D0) =====
  .method EternalTrialsVictoryUI.<PopShowTransform>d__36::.ctor(int)  // token 0x06000F93 rva 0x46e70 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EternalTrialsVictoryUI.<PopShowTransform>d__36::<>1__state  /*0x0400125E*/
    IL_000d: ret

  .method EternalTrialsVictoryUI.<PopShowTransform>d__36::System.IDisposable.Dispose()  // token 0x06000F94 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EternalTrialsVictoryUI.<PopShowTransform>d__36::MoveNext()  // token 0x06000F95 rva 0x46e80 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 203 (0xcb), max stack 6, init locals
    .locals ([0] int, [1] EternalTrialsVictoryUI)
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsVictoryUI.<PopShowTransform>d__36::<>1__state  /*0x0400125E*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EternalTrialsVictoryUI EternalTrialsVictoryUI.<PopShowTransform>d__36::<>4__this  /*0x04001261*/
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
    IL_001c: stfld int EternalTrialsVictoryUI.<PopShowTransform>d__36::<>1__state  /*0x0400125E*/
    IL_0021: ldarg.0
    IL_0022: ldfld AudioClip EternalTrialsVictoryUI.<PopShowTransform>d__36::clip  /*0x04001260*/
    IL_0027: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002c: brfalse.s IL_003f
    IL_002e: ldloc.1
    IL_002f: ldfld AudioSource EternalTrialsVictoryUI::audioSource  /*0x04001237*/
    IL_0034: ldarg.0
    IL_0035: ldfld AudioClip EternalTrialsVictoryUI.<PopShowTransform>d__36::clip  /*0x04001260*/
    IL_003a: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_003f: ldarg.0
    IL_0040: ldc.r4 0f
    IL_0045: stfld float EternalTrialsVictoryUI.<PopShowTransform>d__36::<timer>5__2  /*0x04001265*/
    IL_004a: br.s IL_00ab
    IL_004c: ldarg.0
    IL_004d: ldarg.0
    IL_004e: ldfld float EternalTrialsVictoryUI.<PopShowTransform>d__36::<timer>5__2  /*0x04001265*/
    IL_0053: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0058: add
    IL_0059: stfld float EternalTrialsVictoryUI.<PopShowTransform>d__36::<timer>5__2  /*0x04001265*/
    IL_005e: ldarg.0
    IL_005f: ldfld Transform EternalTrialsVictoryUI.<PopShowTransform>d__36::target  /*0x04001262*/
    IL_0064: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0069: ldarg.0
    IL_006a: ldfld AnimationCurve EternalTrialsVictoryUI.<PopShowTransform>d__36::curve  /*0x04001263*/
    IL_006f: ldc.r4 0f
    IL_0074: ldarg.0
    IL_0075: ldfld float EternalTrialsVictoryUI.<PopShowTransform>d__36::animTime  /*0x04001264*/
    IL_007a: ldarg.0
    IL_007b: ldfld float EternalTrialsVictoryUI.<PopShowTransform>d__36::<timer>5__2  /*0x04001265*/
    IL_0080: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0085: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_008a: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_008f: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0094: ldarg.0
    IL_0095: ldnull
    IL_0096: stfld object EternalTrialsVictoryUI.<PopShowTransform>d__36::<>2__current  /*0x0400125F*/
    IL_009b: ldarg.0
    IL_009c: ldc.i4.1
    IL_009d: stfld int EternalTrialsVictoryUI.<PopShowTransform>d__36::<>1__state  /*0x0400125E*/
    IL_00a2: ldc.i4.1
    IL_00a3: ret
    IL_00a4: ldarg.0
    IL_00a5: ldc.i4.m1
    IL_00a6: stfld int EternalTrialsVictoryUI.<PopShowTransform>d__36::<>1__state  /*0x0400125E*/
    IL_00ab: ldarg.0
    IL_00ac: ldfld float EternalTrialsVictoryUI.<PopShowTransform>d__36::<timer>5__2  /*0x04001265*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld float EternalTrialsVictoryUI.<PopShowTransform>d__36::animTime  /*0x04001264*/
    IL_00b7: blt.s IL_004c
    IL_00b9: ldarg.0
    IL_00ba: ldfld Transform EternalTrialsVictoryUI.<PopShowTransform>d__36::target  /*0x04001262*/
    IL_00bf: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00c4: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00c9: ldc.i4.0
    IL_00ca: ret

  .method EternalTrialsVictoryUI.<PopShowTransform>d__36::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F96 rva 0x46f57 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsVictoryUI.<PopShowTransform>d__36::<>2__current  /*0x0400125F*/
    IL_0006: ret

  .method EternalTrialsVictoryUI.<PopShowTransform>d__36::System.Collections.IEnumerator.Reset()  // token 0x06000F97 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EternalTrialsVictoryUI.<PopShowTransform>d__36::System.Collections.IEnumerator.get_Current()  // token 0x06000F98 rva 0x46f57 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsVictoryUI.<PopShowTransform>d__36::<>2__current  /*0x0400125F*/
    IL_0006: ret

// ===== EternalTrialsVictoryUI/<UnrollScores>d__31  (token 0x020002D1) =====
  .method EternalTrialsVictoryUI.<UnrollScores>d__31::.ctor(int)  // token 0x06000F99 rva 0x46f5f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int EternalTrialsVictoryUI.<UnrollScores>d__31::<>1__state  /*0x04001266*/
    IL_000d: ret

  .method EternalTrialsVictoryUI.<UnrollScores>d__31::System.IDisposable.Dispose()  // token 0x06000F9A rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EternalTrialsVictoryUI.<UnrollScores>d__31::MoveNext()  // token 0x06000F9B rva 0x46f70 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 732 (0x2dc), max stack 6, init locals
    .locals ([0] int, [1] EternalTrialsVictoryUI)
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsVictoryUI.<UnrollScores>d__31::<>1__state  /*0x04001266*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld EternalTrialsVictoryUI EternalTrialsVictoryUI.<UnrollScores>d__31::<>4__this  /*0x04001268*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0032, IL_015b, IL_01b2, IL_01da, IL_023f, IL_02a4, IL_02cc)
    IL_0030: ldc.i4.0
    IL_0031: ret
    IL_0032: ldarg.0
    IL_0033: ldc.i4.m1
    IL_0034: stfld int EternalTrialsVictoryUI.<UnrollScores>d__31::<>1__state  /*0x04001266*/
    IL_0039: ldloc.1
    IL_003a: ldc.i4.1
    IL_003b: stfld bool EternalTrialsVictoryUI::inScoreUnroll  /*0x04001239*/
    IL_0040: ldloc.1
    IL_0041: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0046: callvirt int SceneTransitionManager::get_IngameScoreFromLastMatch()  /*0x060009BE*/
    IL_004b: stfld int EternalTrialsVictoryUI::baseScoreThisRound  /*0x0400123A*/
    IL_0050: ldloc.1
    IL_0051: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0056: callvirt int SceneTransitionManager::get_GoldBonusScoreFromLastMatch()  /*0x060009BF*/
    IL_005b: stfld int EternalTrialsVictoryUI::goldScoreThisRound  /*0x0400123B*/
    IL_0060: ldloc.1
    IL_0061: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0066: ldfld int EternalTrialsRun::score  /*0x04000850*/
    IL_006b: ldloc.1
    IL_006c: ldfld int EternalTrialsVictoryUI::baseScoreThisRound  /*0x0400123A*/
    IL_0071: sub
    IL_0072: ldloc.1
    IL_0073: ldfld int EternalTrialsVictoryUI::goldScoreThisRound  /*0x0400123B*/
    IL_0078: sub
    IL_0079: stfld int EternalTrialsVictoryUI::overallScoreThisRound  /*0x0400123C*/
    IL_007e: ldloc.1
    IL_007f: ldloc.1
    IL_0080: ldfld int EternalTrialsVictoryUI::overallScoreThisRound  /*0x0400123C*/
    IL_0085: stfld int EternalTrialsVictoryUI::animationNextScore  /*0x0400123D*/
    IL_008a: ldloc.1
    IL_008b: ldfld TextMeshProUGUI EternalTrialsVictoryUI::baseScore  /*0x0400122E*/
    IL_0090: ldloc.1
    IL_0091: ldflda int EternalTrialsVictoryUI::baseScoreThisRound  /*0x0400123A*/
    IL_0096: call string System.Int32::ToString()  /*0x0A000031*/
    IL_009b: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00a0: ldloc.1
    IL_00a1: ldfld TextMeshProUGUI EternalTrialsVictoryUI::goldScore  /*0x04001230*/
    IL_00a6: ldloc.1
    IL_00a7: ldflda int EternalTrialsVictoryUI::goldScoreThisRound  /*0x0400123B*/
    IL_00ac: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00b1: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00b6: ldloc.1
    IL_00b7: ldfld TextMeshProUGUI EternalTrialsVictoryUI::overallScore  /*0x04001232*/
    IL_00bc: ldloc.1
    IL_00bd: ldflda int EternalTrialsVictoryUI::overallScoreThisRound  /*0x0400123C*/
    IL_00c2: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00c7: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00cc: ldloc.1
    IL_00cd: ldfld GameObject EternalTrialsVictoryUI::dividerParent  /*0x0400122B*/
    IL_00d2: ldc.i4.1
    IL_00d3: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00d8: ldloc.1
    IL_00d9: ldloc.1
    IL_00da: ldloc.1
    IL_00db: ldfld GameObject EternalTrialsVictoryUI::dividerParent  /*0x0400122B*/
    IL_00e0: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00e5: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_00ea: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_00ef: callvirt AudioClip AudioSet::get_PointScreenBuildB()  /*0x060001E2*/
    IL_00f4: ldloc.1
    IL_00f5: ldfld AnimationCurve EternalTrialsVictoryUI::popShowCurve  /*0x04001234*/
    IL_00fa: ldloc.1
    IL_00fb: ldfld float EternalTrialsVictoryUI::animationStepB  /*0x04001241*/
    IL_0100: call IEnumerator EternalTrialsVictoryUI::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06000F79*/
    IL_0105: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_010a: pop
    IL_010b: ldloc.1
    IL_010c: ldfld TextMeshProUGUI EternalTrialsVictoryUI::baseScoreName  /*0x0400122F*/
    IL_0111: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0116: ldc.i4.1
    IL_0117: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_011c: ldloc.1
    IL_011d: ldloc.1
    IL_011e: ldloc.1
    IL_011f: ldfld TextMeshProUGUI EternalTrialsVictoryUI::baseScoreName  /*0x0400122F*/
    IL_0124: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0129: ldnull
    IL_012a: ldloc.1
    IL_012b: ldfld AnimationCurve EternalTrialsVictoryUI::popShowCurve  /*0x04001234*/
    IL_0130: ldloc.1
    IL_0131: ldfld float EternalTrialsVictoryUI::animationStepB  /*0x04001241*/
    IL_0136: call IEnumerator EternalTrialsVictoryUI::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06000F79*/
    IL_013b: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0140: pop
    IL_0141: ldarg.0
    IL_0142: ldloc.1
    IL_0143: ldfld float EternalTrialsVictoryUI::minorWaitStep  /*0x0400123F*/
    IL_0148: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_014d: stfld object EternalTrialsVictoryUI.<UnrollScores>d__31::<>2__current  /*0x04001267*/
    IL_0152: ldarg.0
    IL_0153: ldc.i4.1
    IL_0154: stfld int EternalTrialsVictoryUI.<UnrollScores>d__31::<>1__state  /*0x04001266*/
    IL_0159: ldc.i4.1
    IL_015a: ret
    IL_015b: ldarg.0
    IL_015c: ldc.i4.m1
    IL_015d: stfld int EternalTrialsVictoryUI.<UnrollScores>d__31::<>1__state  /*0x04001266*/
    IL_0162: ldloc.1
    IL_0163: ldfld TextMeshProUGUI EternalTrialsVictoryUI::baseScore  /*0x0400122E*/
    IL_0168: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_016d: ldc.i4.1
    IL_016e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0173: ldloc.1
    IL_0174: ldloc.1
    IL_0175: ldloc.1
    IL_0176: ldfld TextMeshProUGUI EternalTrialsVictoryUI::baseScore  /*0x0400122E*/
    IL_017b: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0180: ldnull
    IL_0181: ldloc.1
    IL_0182: ldfld AnimationCurve EternalTrialsVictoryUI::popShowCurve  /*0x04001234*/
    IL_0187: ldloc.1
    IL_0188: ldfld float EternalTrialsVictoryUI::animationStepB  /*0x04001241*/
    IL_018d: call IEnumerator EternalTrialsVictoryUI::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06000F79*/
    IL_0192: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0197: pop
    IL_0198: ldarg.0
    IL_0199: ldloc.1
    IL_019a: ldfld float EternalTrialsVictoryUI::minorWaitStep  /*0x0400123F*/
    IL_019f: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_01a4: stfld object EternalTrialsVictoryUI.<UnrollScores>d__31::<>2__current  /*0x04001267*/
    IL_01a9: ldarg.0
    IL_01aa: ldc.i4.2
    IL_01ab: stfld int EternalTrialsVictoryUI.<UnrollScores>d__31::<>1__state  /*0x04001266*/
    IL_01b0: ldc.i4.1
    IL_01b1: ret
    IL_01b2: ldarg.0
    IL_01b3: ldc.i4.m1
    IL_01b4: stfld int EternalTrialsVictoryUI.<UnrollScores>d__31::<>1__state  /*0x04001266*/
    IL_01b9: ldarg.0
    IL_01ba: ldloc.1
    IL_01bb: ldloc.1
    IL_01bc: ldfld int EternalTrialsVictoryUI::baseScoreThisRound  /*0x0400123A*/
    IL_01c1: ldloc.1
    IL_01c2: ldfld float EternalTrialsVictoryUI::animationStepA  /*0x04001240*/
    IL_01c7: call IEnumerator EternalTrialsVictoryUI::AddToOverallScore(int,float)  /*0x06000F76*/
    IL_01cc: stfld object EternalTrialsVictoryUI.<UnrollScores>d__31::<>2__current  /*0x04001267*/
    IL_01d1: ldarg.0
    IL_01d2: ldc.i4.3
    IL_01d3: stfld int EternalTrialsVictoryUI.<UnrollScores>d__31::<>1__state  /*0x04001266*/
    IL_01d8: ldc.i4.1
    IL_01d9: ret
    IL_01da: ldarg.0
    IL_01db: ldc.i4.m1
    IL_01dc: stfld int EternalTrialsVictoryUI.<UnrollScores>d__31::<>1__state  /*0x04001266*/
    IL_01e1: ldloc.1
    IL_01e2: ldfld TextMeshProUGUI EternalTrialsVictoryUI::goldBonusName  /*0x04001231*/
    IL_01e7: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01ec: ldc.i4.1
    IL_01ed: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01f2: ldloc.1
    IL_01f3: ldloc.1
    IL_01f4: ldloc.1
    IL_01f5: ldfld TextMeshProUGUI EternalTrialsVictoryUI::goldBonusName  /*0x04001231*/
    IL_01fa: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_01ff: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0204: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0209: callvirt AudioClip AudioSet::get_PointScreenBuildC()  /*0x060001E3*/
    IL_020e: ldloc.1
    IL_020f: ldfld AnimationCurve EternalTrialsVictoryUI::popShowCurve  /*0x04001234*/
    IL_0214: ldloc.1
    IL_0215: ldfld float EternalTrialsVictoryUI::animationStepB  /*0x04001241*/
    IL_021a: call IEnumerator EternalTrialsVictoryUI::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06000F79*/
    IL_021f: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0224: pop
    IL_0225: ldarg.0
    IL_0226: ldloc.1
    IL_0227: ldfld float EternalTrialsVictoryUI::minorWaitStep  /*0x0400123F*/
    IL_022c: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0231: stfld object EternalTrialsVictoryUI.<UnrollScores>d__31::<>2__current  /*0x04001267*/
    IL_0236: ldarg.0
    IL_0237: ldc.i4.4
    IL_0238: stfld int EternalTrialsVictoryUI.<UnrollScores>d__31::<>1__state  /*0x04001266*/
    IL_023d: ldc.i4.1
    IL_023e: ret
    IL_023f: ldarg.0
    IL_0240: ldc.i4.m1
    IL_0241: stfld int EternalTrialsVictoryUI.<UnrollScores>d__31::<>1__state  /*0x04001266*/
    IL_0246: ldloc.1
    IL_0247: ldfld TextMeshProUGUI EternalTrialsVictoryUI::goldScore  /*0x04001230*/
    IL_024c: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0251: ldc.i4.1
    IL_0252: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0257: ldloc.1
    IL_0258: ldloc.1
    IL_0259: ldloc.1
    IL_025a: ldfld TextMeshProUGUI EternalTrialsVictoryUI::goldScore  /*0x04001230*/
    IL_025f: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0264: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0269: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_026e: callvirt AudioClip AudioSet::get_PointScreenBuildA()  /*0x060001E1*/
    IL_0273: ldloc.1
    IL_0274: ldfld AnimationCurve EternalTrialsVictoryUI::popShowCurve  /*0x04001234*/
    IL_0279: ldloc.1
    IL_027a: ldfld float EternalTrialsVictoryUI::animationStepB  /*0x04001241*/
    IL_027f: call IEnumerator EternalTrialsVictoryUI::PopShowTransform(UnityEngine.Transform,UnityEngine.AudioClip,UnityEngine.AnimationCurve,float)  /*0x06000F79*/
    IL_0284: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0289: pop
    IL_028a: ldarg.0
    IL_028b: ldloc.1
    IL_028c: ldfld float EternalTrialsVictoryUI::minorWaitStep  /*0x0400123F*/
    IL_0291: newobj void UnityEngine.WaitForSecondsRealtime::.ctor(float)  /*0x0A000608*/
    IL_0296: stfld object EternalTrialsVictoryUI.<UnrollScores>d__31::<>2__current  /*0x04001267*/
    IL_029b: ldarg.0
    IL_029c: ldc.i4.5
    IL_029d: stfld int EternalTrialsVictoryUI.<UnrollScores>d__31::<>1__state  /*0x04001266*/
    IL_02a2: ldc.i4.1
    IL_02a3: ret
    IL_02a4: ldarg.0
    IL_02a5: ldc.i4.m1
    IL_02a6: stfld int EternalTrialsVictoryUI.<UnrollScores>d__31::<>1__state  /*0x04001266*/
    IL_02ab: ldarg.0
    IL_02ac: ldloc.1
    IL_02ad: ldloc.1
    IL_02ae: ldfld int EternalTrialsVictoryUI::goldScoreThisRound  /*0x0400123B*/
    IL_02b3: ldloc.1
    IL_02b4: ldfld float EternalTrialsVictoryUI::animationStepA  /*0x04001240*/
    IL_02b9: call IEnumerator EternalTrialsVictoryUI::AddToOverallScore(int,float)  /*0x06000F76*/
    IL_02be: stfld object EternalTrialsVictoryUI.<UnrollScores>d__31::<>2__current  /*0x04001267*/
    IL_02c3: ldarg.0
    IL_02c4: ldc.i4.6
    IL_02c5: stfld int EternalTrialsVictoryUI.<UnrollScores>d__31::<>1__state  /*0x04001266*/
    IL_02ca: ldc.i4.1
    IL_02cb: ret
    IL_02cc: ldarg.0
    IL_02cd: ldc.i4.m1
    IL_02ce: stfld int EternalTrialsVictoryUI.<UnrollScores>d__31::<>1__state  /*0x04001266*/
    IL_02d3: ldloc.1
    IL_02d4: ldnull
    IL_02d5: stfld Coroutine EternalTrialsVictoryUI::currentScoringAnimation  /*0x04001242*/
    IL_02da: ldc.i4.0
    IL_02db: ret

  .method EternalTrialsVictoryUI.<UnrollScores>d__31::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F9C rva 0x47258 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsVictoryUI.<UnrollScores>d__31::<>2__current  /*0x04001267*/
    IL_0006: ret

  .method EternalTrialsVictoryUI.<UnrollScores>d__31::System.Collections.IEnumerator.Reset()  // token 0x06000F9D rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method EternalTrialsVictoryUI.<UnrollScores>d__31::System.Collections.IEnumerator.get_Current()  // token 0x06000F9E rva 0x47258 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object EternalTrialsVictoryUI.<UnrollScores>d__31::<>2__current  /*0x04001267*/
    IL_0006: ret

