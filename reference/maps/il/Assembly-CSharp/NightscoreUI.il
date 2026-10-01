// ===== NightscoreUI  (token 0x02000327) =====
  .method NightscoreUI::Awake()  // token 0x0600115E rva 0x51e45 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld NightscoreUI NightscoreUI::instance  /*0x040014D4*/
    IL_0006: ret

  .method NightscoreUI::Start()  // token 0x0600115F rva 0x51e50 attrs Private, HideBySig
    // code size 67 (0x43), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject NightscoreUI::nightScorePanel  /*0x040014BF*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: call ScoreManager ScoreManager::get_Instance()  /*0x06000D10*/
    IL_0011: ldfld UnityEvent<int, int, float, int> ScoreManager::OnNightScoreAdd  /*0x04000FAB*/
    IL_0016: ldarg.0
    IL_0017: ldftn void NightscoreUI::ShowNightScore(int,int,float,int)  /*0x06001161*/
    IL_001d: newobj void UnityEngine.Events.UnityAction<int, int, float, int>::.ctor(object,IntPtr)  /*0x0A0006F0*/
    IL_0022: callvirt void UnityEngine.Events.UnityEvent<int, int, float, int>::AddListener(UnityEngine.Events.UnityAction<!0, !1, !2, !3>)  /*0x0A0006F1*/
    IL_0027: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_002c: ldfld UnityEvent UIFrameManager::onFrameOpen  /*0x0400170D*/
    IL_0031: ldarg.0
    IL_0032: ldftn void NightscoreUI::StopPointFillSoundOnPause()  /*0x06001160*/
    IL_0038: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_003d: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0042: ret

  .method NightscoreUI::StopPointFillSoundOnPause()  // token 0x06001160 rva 0x51e9f attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AudioSource NightscoreUI::pointSFXSource  /*0x040014C5*/
    IL_0006: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_000b: ret

  .method NightscoreUI::ShowNightScore(int,int,float,int)  // token 0x06001161 rva 0x51eac attrs Public, HideBySig
    // code size 73 (0x49), max stack 6, init locals
    IL_0000: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0005: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_000a: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_000f: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0014: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_0019: ldc.i4.1
    IL_001a: sub
    IL_001b: blt.s IL_001e
    IL_001d: ret
    IL_001e: ldarg.0
    IL_001f: ldc.i4.1
    IL_0020: stfld bool NightscoreUI::shown  /*0x040014D9*/
    IL_0025: ldarg.0
    IL_0026: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_002b: ldarg.0
    IL_002c: ldc.r4 0f
    IL_0031: stfld float NightscoreUI::clock  /*0x040014D8*/
    IL_0036: ldarg.0
    IL_0037: ldarg.0
    IL_0038: ldarg.1
    IL_0039: ldarg.2
    IL_003a: ldarg.3
    IL_003b: ldarg.s 4
    IL_003d: call IEnumerator NightscoreUI::PlayPopUpAnimation(int,int,float,int)  /*0x06001163*/
    IL_0042: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0047: pop
    IL_0048: ret

  .method NightscoreUI::HideNightScore()  // token 0x06001162 rva 0x51f01 attrs Public, HideBySig
    // code size 38 (0x26), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool NightscoreUI::shown  /*0x040014D9*/
    IL_0007: ldarg.0
    IL_0008: ldfld AudioSource NightscoreUI::pointSFXSource  /*0x040014C5*/
    IL_000d: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_0012: ldarg.0
    IL_0013: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0018: ldarg.0
    IL_0019: ldarg.0
    IL_001a: call IEnumerator NightscoreUI::PlayHideAnimation()  /*0x06001164*/
    IL_001f: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0024: pop
    IL_0025: ret

  .method NightscoreUI::PlayPopUpAnimation(int,int,float,int)  // token 0x06001163 rva 0x51f28 attrs Private, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void NightscoreUI.<PlayPopUpAnimation>d__32::.ctor(int)  /*0x0600116C*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld NightscoreUI NightscoreUI.<PlayPopUpAnimation>d__32::<>4__this  /*0x040014E2*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::basescore  /*0x040014E3*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::timebonus  /*0x040014E4*/
    IL_001b: dup
    IL_001c: ldarg.3
    IL_001d: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::protectionpercent  /*0x040014E6*/
    IL_0022: dup
    IL_0023: ldarg.s 4
    IL_0025: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::protectionbonus  /*0x040014E5*/
    IL_002a: ret

  .method NightscoreUI::PlayHideAnimation()  // token 0x06001164 rva 0x51f54 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void NightscoreUI.<PlayHideAnimation>d__33::.ctor(int)  /*0x06001166*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld NightscoreUI NightscoreUI.<PlayHideAnimation>d__33::<>4__this  /*0x040014DC*/
    IL_000d: ret

  .method NightscoreUI::.ctor()  // token 0x06001165 rva 0x51f63 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 3f
    IL_0006: stfld float NightscoreUI::initialWaitTime  /*0x040014D5*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 3f
    IL_0011: stfld float NightscoreUI::completeWaitTime  /*0x040014D6*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.8f
    IL_001c: stfld float NightscoreUI::buildUpSFXVol  /*0x040014D7*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

// ===== NightscoreUI/<PlayHideAnimation>d__33  (token 0x02000328) =====
  .method NightscoreUI.<PlayHideAnimation>d__33::.ctor(int)  // token 0x06001166 rva 0x51f8c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int NightscoreUI.<PlayHideAnimation>d__33::<>1__state  /*0x040014DA*/
    IL_000d: ret

  .method NightscoreUI.<PlayHideAnimation>d__33::System.IDisposable.Dispose()  // token 0x06001167 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method NightscoreUI.<PlayHideAnimation>d__33::MoveNext()  // token 0x06001168 rva 0x51f9c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1260 (0x4ec), max stack 7, init locals
    .locals ([0] int, [1] NightscoreUI)
    IL_0000: ldarg.0
    IL_0001: ldfld int NightscoreUI.<PlayHideAnimation>d__33::<>1__state  /*0x040014DA*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld NightscoreUI NightscoreUI.<PlayHideAnimation>d__33::<>4__this  /*0x040014DC*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_002a, IL_019d, IL_0290, IL_03af, IL_04a1)
    IL_0028: ldc.i4.0
    IL_0029: ret
    IL_002a: ldarg.0
    IL_002b: ldc.i4.m1
    IL_002c: stfld int NightscoreUI.<PlayHideAnimation>d__33::<>1__state  /*0x040014DA*/
    IL_0031: ldloc.1
    IL_0032: ldfld AudioSource NightscoreUI::pointSFXSource  /*0x040014C5*/
    IL_0037: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_003c: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0041: callvirt AudioClip AudioSet::get_PointScreenBuildB()  /*0x060001E2*/
    IL_0046: ldloc.1
    IL_0047: ldfld float NightscoreUI::buildUpSFXVol  /*0x040014D7*/
    IL_004c: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_0051: ldarg.0
    IL_0052: ldc.r4 0f
    IL_0057: stfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_005c: ldarg.0
    IL_005d: ldc.r4 0f
    IL_0062: stfld float NightscoreUI.<PlayHideAnimation>d__33::<animTime>5__3  /*0x040014DE*/
    IL_0067: ldarg.0
    IL_0068: ldloc.1
    IL_0069: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_006e: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0073: stfld Vector2 NightscoreUI.<PlayHideAnimation>d__33::<contentSizeDelta>5__4  /*0x040014DF*/
    IL_0078: ldloc.1
    IL_0079: ldfld RectTransform NightscoreUI::nightSurviveText  /*0x040014C8*/
    IL_007e: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0083: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0088: ldloc.1
    IL_0089: ldfld RectTransform NightscoreUI::nightSurviveNumber  /*0x040014C9*/
    IL_008e: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0093: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0098: ldloc.1
    IL_0099: ldfld RectTransform NightscoreUI::timeText  /*0x040014CA*/
    IL_009e: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00a3: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00a8: ldloc.1
    IL_00a9: ldfld RectTransform NightscoreUI::timeNumber  /*0x040014CB*/
    IL_00ae: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00b3: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00b8: ldloc.1
    IL_00b9: ldfld RectTransform NightscoreUI::protectionText  /*0x040014CC*/
    IL_00be: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00c3: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00c8: ldloc.1
    IL_00c9: ldfld RectTransform NightscoreUI::protectionNumber  /*0x040014CD*/
    IL_00ce: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00d3: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00d8: ldloc.1
    IL_00d9: ldfld RectTransform NightscoreUI::overallScoreBG  /*0x040014CE*/
    IL_00de: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00e3: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00e8: ldloc.1
    IL_00e9: ldfld RectTransform NightscoreUI::overallScoreNumber  /*0x040014CF*/
    IL_00ee: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00f3: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00f8: ldloc.1
    IL_00f9: ldfld RectTransform NightscoreUI::timeText  /*0x040014CA*/
    IL_00fe: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0103: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0108: ldloc.1
    IL_0109: ldfld RectTransform NightscoreUI::timeNumber  /*0x040014CB*/
    IL_010e: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0113: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0118: ldarg.0
    IL_0119: ldc.r4 0.4f
    IL_011e: stfld float NightscoreUI.<PlayHideAnimation>d__33::<animTime>5__3  /*0x040014DE*/
    IL_0123: ldarg.0
    IL_0124: ldc.r4 0f
    IL_0129: stfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_012e: br.s IL_01a4
    IL_0130: ldarg.0
    IL_0131: ldarg.0
    IL_0132: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_0137: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_013c: add
    IL_013d: stfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_0142: ldloc.1
    IL_0143: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_0148: ldarg.0
    IL_0149: ldfld Vector2 NightscoreUI.<PlayHideAnimation>d__33::<contentSizeDelta>5__4  /*0x040014DF*/
    IL_014e: call Vector2 UnityEngine.Vector2::get_up()  /*0x0A0001CE*/
    IL_0153: ldc.r4 30f
    IL_0158: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_015d: ldloc.1
    IL_015e: ldfld AnimationCurve NightscoreUI::expandCurve  /*0x040014D1*/
    IL_0163: ldc.r4 0f
    IL_0168: ldarg.0
    IL_0169: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<animTime>5__3  /*0x040014DE*/
    IL_016e: ldarg.0
    IL_016f: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_0174: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0179: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_017e: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_0183: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_0188: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_018d: ldarg.0
    IL_018e: ldnull
    IL_018f: stfld object NightscoreUI.<PlayHideAnimation>d__33::<>2__current  /*0x040014DB*/
    IL_0194: ldarg.0
    IL_0195: ldc.i4.1
    IL_0196: stfld int NightscoreUI.<PlayHideAnimation>d__33::<>1__state  /*0x040014DA*/
    IL_019b: ldc.i4.1
    IL_019c: ret
    IL_019d: ldarg.0
    IL_019e: ldc.i4.m1
    IL_019f: stfld int NightscoreUI.<PlayHideAnimation>d__33::<>1__state  /*0x040014DA*/
    IL_01a4: ldarg.0
    IL_01a5: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_01aa: ldarg.0
    IL_01ab: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<animTime>5__3  /*0x040014DE*/
    IL_01b0: blt IL_0130
    IL_01b5: ldloc.1
    IL_01b6: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_01bb: ldarg.0
    IL_01bc: ldfld Vector2 NightscoreUI.<PlayHideAnimation>d__33::<contentSizeDelta>5__4  /*0x040014DF*/
    IL_01c1: call Vector2 UnityEngine.Vector2::get_up()  /*0x0A0001CE*/
    IL_01c6: ldc.r4 30f
    IL_01cb: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_01d0: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_01d5: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_01da: ldarg.0
    IL_01db: ldloc.1
    IL_01dc: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_01e1: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_01e6: stfld Vector2 NightscoreUI.<PlayHideAnimation>d__33::<contentSizeDelta>5__4  /*0x040014DF*/
    IL_01eb: ldloc.1
    IL_01ec: ldfld RectTransform NightscoreUI::protectionText  /*0x040014CC*/
    IL_01f1: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_01f6: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_01fb: ldloc.1
    IL_01fc: ldfld RectTransform NightscoreUI::protectionNumber  /*0x040014CD*/
    IL_0201: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0206: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_020b: ldarg.0
    IL_020c: ldc.r4 0.4f
    IL_0211: stfld float NightscoreUI.<PlayHideAnimation>d__33::<animTime>5__3  /*0x040014DE*/
    IL_0216: ldarg.0
    IL_0217: ldc.r4 0f
    IL_021c: stfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_0221: br.s IL_0297
    IL_0223: ldarg.0
    IL_0224: ldarg.0
    IL_0225: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_022a: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_022f: add
    IL_0230: stfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_0235: ldloc.1
    IL_0236: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_023b: ldarg.0
    IL_023c: ldfld Vector2 NightscoreUI.<PlayHideAnimation>d__33::<contentSizeDelta>5__4  /*0x040014DF*/
    IL_0241: call Vector2 UnityEngine.Vector2::get_up()  /*0x0A0001CE*/
    IL_0246: ldc.r4 30f
    IL_024b: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_0250: ldloc.1
    IL_0251: ldfld AnimationCurve NightscoreUI::expandCurve  /*0x040014D1*/
    IL_0256: ldc.r4 0f
    IL_025b: ldarg.0
    IL_025c: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<animTime>5__3  /*0x040014DE*/
    IL_0261: ldarg.0
    IL_0262: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_0267: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_026c: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0271: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_0276: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_027b: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_0280: ldarg.0
    IL_0281: ldnull
    IL_0282: stfld object NightscoreUI.<PlayHideAnimation>d__33::<>2__current  /*0x040014DB*/
    IL_0287: ldarg.0
    IL_0288: ldc.i4.2
    IL_0289: stfld int NightscoreUI.<PlayHideAnimation>d__33::<>1__state  /*0x040014DA*/
    IL_028e: ldc.i4.1
    IL_028f: ret
    IL_0290: ldarg.0
    IL_0291: ldc.i4.m1
    IL_0292: stfld int NightscoreUI.<PlayHideAnimation>d__33::<>1__state  /*0x040014DA*/
    IL_0297: ldarg.0
    IL_0298: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_029d: ldarg.0
    IL_029e: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<animTime>5__3  /*0x040014DE*/
    IL_02a3: blt IL_0223
    IL_02a8: ldloc.1
    IL_02a9: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_02ae: ldarg.0
    IL_02af: ldfld Vector2 NightscoreUI.<PlayHideAnimation>d__33::<contentSizeDelta>5__4  /*0x040014DF*/
    IL_02b4: call Vector2 UnityEngine.Vector2::get_up()  /*0x0A0001CE*/
    IL_02b9: ldc.r4 30f
    IL_02be: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_02c3: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_02c8: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_02cd: ldarg.0
    IL_02ce: ldloc.1
    IL_02cf: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_02d4: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_02d9: stfld Vector2 NightscoreUI.<PlayHideAnimation>d__33::<contentSizeDelta>5__4  /*0x040014DF*/
    IL_02de: ldloc.1
    IL_02df: ldfld RectTransform NightscoreUI::nightSurviveText  /*0x040014C8*/
    IL_02e4: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_02e9: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_02ee: ldloc.1
    IL_02ef: ldfld RectTransform NightscoreUI::nightSurviveNumber  /*0x040014C9*/
    IL_02f4: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_02f9: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_02fe: ldarg.0
    IL_02ff: ldc.r4 0.4f
    IL_0304: stfld float NightscoreUI.<PlayHideAnimation>d__33::<animTime>5__3  /*0x040014DE*/
    IL_0309: ldarg.0
    IL_030a: ldc.r4 0f
    IL_030f: stfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_0314: br IL_03b6
    IL_0319: ldarg.0
    IL_031a: ldarg.0
    IL_031b: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_0320: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0325: add
    IL_0326: stfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_032b: ldc.r4 0f
    IL_0330: ldarg.0
    IL_0331: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<animTime>5__3  /*0x040014DE*/
    IL_0336: ldarg.0
    IL_0337: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_033c: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0341: ldc.r4 0.425f
    IL_0346: ble.un.s IL_0354
    IL_0348: ldloc.1
    IL_0349: ldfld MPImage NightscoreUI::backgroundImage  /*0x040014C6*/
    IL_034e: ldc.i4.0
    IL_034f: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0354: ldloc.1
    IL_0355: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_035a: ldarg.0
    IL_035b: ldfld Vector2 NightscoreUI.<PlayHideAnimation>d__33::<contentSizeDelta>5__4  /*0x040014DF*/
    IL_0360: call Vector2 UnityEngine.Vector2::get_up()  /*0x0A0001CE*/
    IL_0365: ldc.r4 55f
    IL_036a: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_036f: ldloc.1
    IL_0370: ldfld AnimationCurve NightscoreUI::expandCurve  /*0x040014D1*/
    IL_0375: ldc.r4 0f
    IL_037a: ldarg.0
    IL_037b: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<animTime>5__3  /*0x040014DE*/
    IL_0380: ldarg.0
    IL_0381: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_0386: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_038b: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0390: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_0395: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_039a: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_039f: ldarg.0
    IL_03a0: ldnull
    IL_03a1: stfld object NightscoreUI.<PlayHideAnimation>d__33::<>2__current  /*0x040014DB*/
    IL_03a6: ldarg.0
    IL_03a7: ldc.i4.3
    IL_03a8: stfld int NightscoreUI.<PlayHideAnimation>d__33::<>1__state  /*0x040014DA*/
    IL_03ad: ldc.i4.1
    IL_03ae: ret
    IL_03af: ldarg.0
    IL_03b0: ldc.i4.m1
    IL_03b1: stfld int NightscoreUI.<PlayHideAnimation>d__33::<>1__state  /*0x040014DA*/
    IL_03b6: ldarg.0
    IL_03b7: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_03bc: ldarg.0
    IL_03bd: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<animTime>5__3  /*0x040014DE*/
    IL_03c2: blt IL_0319
    IL_03c7: ldloc.1
    IL_03c8: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_03cd: ldarg.0
    IL_03ce: ldfld Vector2 NightscoreUI.<PlayHideAnimation>d__33::<contentSizeDelta>5__4  /*0x040014DF*/
    IL_03d3: call Vector2 UnityEngine.Vector2::get_up()  /*0x0A0001CE*/
    IL_03d8: ldc.r4 55f
    IL_03dd: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_03e2: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_03e7: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_03ec: ldloc.1
    IL_03ed: ldfld MPImage NightscoreUI::backgroundImage  /*0x040014C6*/
    IL_03f2: ldc.i4.1
    IL_03f3: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_03f8: ldarg.0
    IL_03f9: ldc.r4 0.2f
    IL_03fe: stfld float NightscoreUI.<PlayHideAnimation>d__33::<animTime>5__3  /*0x040014DE*/
    IL_0403: ldarg.0
    IL_0404: ldc.r4 0f
    IL_0409: stfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_040e: br IL_04a8
    IL_0413: ldarg.0
    IL_0414: ldarg.0
    IL_0415: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_041a: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_041f: add
    IL_0420: stfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_0425: ldloc.1
    IL_0426: ldfld RectTransform NightscoreUI::overallScoreNumber  /*0x040014CF*/
    IL_042b: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0430: ldloc.1
    IL_0431: ldfld AnimationCurve NightscoreUI::simpleQuad  /*0x040014D3*/
    IL_0436: ldarg.0
    IL_0437: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<animTime>5__3  /*0x040014DE*/
    IL_043c: ldc.r4 0f
    IL_0441: ldarg.0
    IL_0442: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_0447: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_044c: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0451: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0456: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_045b: ldloc.1
    IL_045c: ldfld RectTransform NightscoreUI::overallScoreBG  /*0x040014CE*/
    IL_0461: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0466: ldloc.1
    IL_0467: ldfld AnimationCurve NightscoreUI::simpleQuad  /*0x040014D3*/
    IL_046c: ldarg.0
    IL_046d: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<animTime>5__3  /*0x040014DE*/
    IL_0472: ldc.r4 0f
    IL_0477: ldarg.0
    IL_0478: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_047d: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0482: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0487: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_048c: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0491: ldarg.0
    IL_0492: ldnull
    IL_0493: stfld object NightscoreUI.<PlayHideAnimation>d__33::<>2__current  /*0x040014DB*/
    IL_0498: ldarg.0
    IL_0499: ldc.i4.4
    IL_049a: stfld int NightscoreUI.<PlayHideAnimation>d__33::<>1__state  /*0x040014DA*/
    IL_049f: ldc.i4.1
    IL_04a0: ret
    IL_04a1: ldarg.0
    IL_04a2: ldc.i4.m1
    IL_04a3: stfld int NightscoreUI.<PlayHideAnimation>d__33::<>1__state  /*0x040014DA*/
    IL_04a8: ldarg.0
    IL_04a9: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<timer>5__2  /*0x040014DD*/
    IL_04ae: ldarg.0
    IL_04af: ldfld float NightscoreUI.<PlayHideAnimation>d__33::<animTime>5__3  /*0x040014DE*/
    IL_04b4: blt IL_0413
    IL_04b9: ldloc.1
    IL_04ba: ldfld RectTransform NightscoreUI::overallScoreNumber  /*0x040014CF*/
    IL_04bf: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_04c4: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_04c9: ldloc.1
    IL_04ca: ldfld RectTransform NightscoreUI::overallScoreBG  /*0x040014CE*/
    IL_04cf: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0004B6*/
    IL_04d4: call Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)  /*0x0A0001CF*/
    IL_04d9: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_04de: ldloc.1
    IL_04df: ldfld GameObject NightscoreUI::nightScorePanel  /*0x040014BF*/
    IL_04e4: ldc.i4.0
    IL_04e5: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_04ea: ldc.i4.0
    IL_04eb: ret

  .method NightscoreUI.<PlayHideAnimation>d__33::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06001169 rva 0x52494 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object NightscoreUI.<PlayHideAnimation>d__33::<>2__current  /*0x040014DB*/
    IL_0006: ret

  .method NightscoreUI.<PlayHideAnimation>d__33::System.Collections.IEnumerator.Reset()  // token 0x0600116A rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method NightscoreUI.<PlayHideAnimation>d__33::System.Collections.IEnumerator.get_Current()  // token 0x0600116B rva 0x52494 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object NightscoreUI.<PlayHideAnimation>d__33::<>2__current  /*0x040014DB*/
    IL_0006: ret

// ===== NightscoreUI/<PlayPopUpAnimation>d__32  (token 0x02000329) =====
  .method NightscoreUI.<PlayPopUpAnimation>d__32::.ctor(int)  // token 0x0600116C rva 0x5249c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_000d: ret

  .method NightscoreUI.<PlayPopUpAnimation>d__32::System.IDisposable.Dispose()  // token 0x0600116D rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method NightscoreUI.<PlayPopUpAnimation>d__32::MoveNext()  // token 0x0600116E rva 0x524ac attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 2803 (0xaf3), max stack 9, init locals
    .locals ([0] int, [1] NightscoreUI, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld NightscoreUI NightscoreUI.<PlayPopUpAnimation>d__32::<>4__this  /*0x040014E2*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_004a, IL_024a, IL_02fa, IL_034b, IL_03f7, IL_050e, IL_05eb, IL_0702, IL_07df, IL_08f7, IL_09d7, IL_0aa4, IL_0ae4)
    IL_0048: ldc.i4.0
    IL_0049: ret
    IL_004a: ldarg.0
    IL_004b: ldc.i4.m1
    IL_004c: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_0051: ldloc.1
    IL_0052: ldfld GameObject NightscoreUI::nightScorePanel  /*0x040014BF*/
    IL_0057: ldc.i4.1
    IL_0058: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_005d: ldarg.0
    IL_005e: ldc.r4 0f
    IL_0063: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0068: ldarg.0
    IL_0069: ldc.r4 0f
    IL_006e: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_0073: ldarg.0
    IL_0074: ldloc.1
    IL_0075: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_007a: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_007f: stfld Vector2 NightscoreUI.<PlayPopUpAnimation>d__32::<contentSizeDelta>5__4  /*0x040014E9*/
    IL_0084: ldarg.0
    IL_0085: call ScoreManager ScoreManager::get_Instance()  /*0x06000D10*/
    IL_008a: callvirt int ScoreManager::get_CurrentScore()  /*0x06000D11*/
    IL_008f: ldarg.0
    IL_0090: ldfld int NightscoreUI.<PlayPopUpAnimation>d__32::basescore  /*0x040014E3*/
    IL_0095: sub
    IL_0096: ldarg.0
    IL_0097: ldfld int NightscoreUI.<PlayPopUpAnimation>d__32::timebonus  /*0x040014E4*/
    IL_009c: sub
    IL_009d: ldarg.0
    IL_009e: ldfld int NightscoreUI.<PlayPopUpAnimation>d__32::protectionbonus  /*0x040014E5*/
    IL_00a3: sub
    IL_00a4: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<currentScore>5__5  /*0x040014EA*/
    IL_00a9: ldarg.0
    IL_00aa: ldarg.0
    IL_00ab: ldfld int NightscoreUI.<PlayPopUpAnimation>d__32::<currentScore>5__5  /*0x040014EA*/
    IL_00b0: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<nextScore>5__6  /*0x040014EB*/
    IL_00b5: ldloc.1
    IL_00b6: ldfld TextMeshProUGUI NightscoreUI::baseScore  /*0x040014C0*/
    IL_00bb: ldstr "+"
    IL_00c0: ldarg.0
    IL_00c1: ldflda int NightscoreUI.<PlayPopUpAnimation>d__32::basescore  /*0x040014E3*/
    IL_00c6: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00cb: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00d0: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00d5: ldloc.1
    IL_00d6: ldfld TextMeshProUGUI NightscoreUI::timeBonus  /*0x040014C1*/
    IL_00db: ldstr "+"
    IL_00e0: ldarg.0
    IL_00e1: ldflda int NightscoreUI.<PlayPopUpAnimation>d__32::timebonus  /*0x040014E4*/
    IL_00e6: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00eb: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00f0: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00f5: ldloc.1
    IL_00f6: ldfld TextMeshProUGUI NightscoreUI::protectionPercentage  /*0x040014C2*/
    IL_00fb: ldc.i4.5
    IL_00fc: newarr System.String  /*0x0100001D*/
    IL_0101: dup
    IL_0102: ldc.i4.0
    IL_0103: ldstr "Menu/Realm"
    IL_0108: ldc.i4.1
    IL_0109: ldc.i4.0
    IL_010a: ldc.i4.1
    IL_010b: ldc.i4.1
    IL_010c: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0111: stelem.ref
    IL_0112: dup
    IL_0113: ldc.i4.1
    IL_0114: ldstr " "
    IL_0119: stelem.ref
    IL_011a: dup
    IL_011b: ldc.i4.2
    IL_011c: ldarg.0
    IL_011d: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::protectionpercent  /*0x040014E6*/
    IL_0122: ldc.r4 100f
    IL_0127: mul
    IL_0128: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_012d: stloc.2
    IL_012e: ldloca.s 2
    IL_0130: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0135: stelem.ref
    IL_0136: dup
    IL_0137: ldc.i4.3
    IL_0138: ldstr "% "
    IL_013d: stelem.ref
    IL_013e: dup
    IL_013f: ldc.i4.4
    IL_0140: ldstr "Menu/Protected"
    IL_0145: ldc.i4.1
    IL_0146: ldc.i4.0
    IL_0147: ldc.i4.1
    IL_0148: ldc.i4.1
    IL_0149: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_014e: stelem.ref
    IL_014f: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_0154: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0159: ldloc.1
    IL_015a: ldfld TextMeshProUGUI NightscoreUI::protectionScore  /*0x040014C3*/
    IL_015f: ldstr "+"
    IL_0164: ldarg.0
    IL_0165: ldflda int NightscoreUI.<PlayPopUpAnimation>d__32::protectionbonus  /*0x040014E5*/
    IL_016a: call string System.Int32::ToString()  /*0x0A000031*/
    IL_016f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0174: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0179: ldloc.1
    IL_017a: ldfld TextMeshProUGUI NightscoreUI::overallScore  /*0x040014C4*/
    IL_017f: ldarg.0
    IL_0180: ldflda int NightscoreUI.<PlayPopUpAnimation>d__32::<currentScore>5__5  /*0x040014EA*/
    IL_0185: call string System.Int32::ToString()  /*0x0A000031*/
    IL_018a: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_018f: ldarg.0
    IL_0190: ldflda Vector2 NightscoreUI.<PlayPopUpAnimation>d__32::<contentSizeDelta>5__4  /*0x040014E9*/
    IL_0195: ldc.r4 0f
    IL_019a: stfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_019f: ldloc.1
    IL_01a0: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_01a5: ldarg.0
    IL_01a6: ldfld Vector2 NightscoreUI.<PlayPopUpAnimation>d__32::<contentSizeDelta>5__4  /*0x040014E9*/
    IL_01ab: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_01b0: ldloc.1
    IL_01b1: ldfld RectTransform NightscoreUI::nightSurviveText  /*0x040014C8*/
    IL_01b6: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_01bb: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_01c0: ldloc.1
    IL_01c1: ldfld RectTransform NightscoreUI::nightSurviveNumber  /*0x040014C9*/
    IL_01c6: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_01cb: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_01d0: ldloc.1
    IL_01d1: ldfld RectTransform NightscoreUI::timeText  /*0x040014CA*/
    IL_01d6: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_01db: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_01e0: ldloc.1
    IL_01e1: ldfld RectTransform NightscoreUI::timeNumber  /*0x040014CB*/
    IL_01e6: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_01eb: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_01f0: ldloc.1
    IL_01f1: ldfld RectTransform NightscoreUI::protectionText  /*0x040014CC*/
    IL_01f6: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_01fb: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0200: ldloc.1
    IL_0201: ldfld RectTransform NightscoreUI::protectionNumber  /*0x040014CD*/
    IL_0206: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_020b: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0210: ldloc.1
    IL_0211: ldfld RectTransform NightscoreUI::overallScoreBG  /*0x040014CE*/
    IL_0216: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_021b: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0220: ldloc.1
    IL_0221: ldfld RectTransform NightscoreUI::overallScoreNumber  /*0x040014CF*/
    IL_0226: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_022b: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0230: ldarg.0
    IL_0231: ldloc.1
    IL_0232: ldfld float NightscoreUI::initialWaitTime  /*0x040014D5*/
    IL_0237: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_023c: stfld object NightscoreUI.<PlayPopUpAnimation>d__32::<>2__current  /*0x040014E1*/
    IL_0241: ldarg.0
    IL_0242: ldc.i4.1
    IL_0243: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_0248: ldc.i4.1
    IL_0249: ret
    IL_024a: ldarg.0
    IL_024b: ldc.i4.m1
    IL_024c: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_0251: ldarg.0
    IL_0252: ldc.r4 0.5f
    IL_0257: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_025c: ldarg.0
    IL_025d: ldc.r4 0f
    IL_0262: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0267: br IL_0301
    IL_026c: ldarg.0
    IL_026d: ldarg.0
    IL_026e: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0273: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0278: add
    IL_0279: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_027e: ldloc.1
    IL_027f: ldfld RectTransform NightscoreUI::overallScoreBG  /*0x040014CE*/
    IL_0284: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0289: ldloc.1
    IL_028a: ldfld AnimationCurve NightscoreUI::popCurve  /*0x040014D0*/
    IL_028f: ldc.r4 0f
    IL_0294: ldarg.0
    IL_0295: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_029a: ldarg.0
    IL_029b: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_02a0: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_02a5: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_02aa: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_02af: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_02b4: ldloc.1
    IL_02b5: ldfld RectTransform NightscoreUI::overallScoreNumber  /*0x040014CF*/
    IL_02ba: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_02bf: ldloc.1
    IL_02c0: ldfld AnimationCurve NightscoreUI::popCurve  /*0x040014D0*/
    IL_02c5: ldc.r4 0f
    IL_02ca: ldarg.0
    IL_02cb: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_02d0: ldarg.0
    IL_02d1: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_02d6: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_02db: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_02e0: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_02e5: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_02ea: ldarg.0
    IL_02eb: ldnull
    IL_02ec: stfld object NightscoreUI.<PlayPopUpAnimation>d__32::<>2__current  /*0x040014E1*/
    IL_02f1: ldarg.0
    IL_02f2: ldc.i4.2
    IL_02f3: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_02f8: ldc.i4.1
    IL_02f9: ret
    IL_02fa: ldarg.0
    IL_02fb: ldc.i4.m1
    IL_02fc: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_0301: ldarg.0
    IL_0302: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0307: ldarg.0
    IL_0308: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_030d: blt IL_026c
    IL_0312: ldloc.1
    IL_0313: ldfld RectTransform NightscoreUI::overallScoreBG  /*0x040014CE*/
    IL_0318: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_031d: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0322: ldloc.1
    IL_0323: ldfld RectTransform NightscoreUI::overallScoreNumber  /*0x040014CF*/
    IL_0328: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_032d: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0332: ldarg.0
    IL_0333: ldc.r4 0.25f
    IL_0338: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_033d: stfld object NightscoreUI.<PlayPopUpAnimation>d__32::<>2__current  /*0x040014E1*/
    IL_0342: ldarg.0
    IL_0343: ldc.i4.3
    IL_0344: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_0349: ldc.i4.1
    IL_034a: ret
    IL_034b: ldarg.0
    IL_034c: ldc.i4.m1
    IL_034d: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_0352: ldloc.1
    IL_0353: ldfld AudioSource NightscoreUI::pointSFXSource  /*0x040014C5*/
    IL_0358: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_035d: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0362: callvirt AudioClip AudioSet::get_PointScreenBuildB()  /*0x060001E2*/
    IL_0367: ldloc.1
    IL_0368: ldfld float NightscoreUI::buildUpSFXVol  /*0x040014D7*/
    IL_036d: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_0372: ldarg.0
    IL_0373: ldc.r4 0.5f
    IL_0378: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_037d: ldarg.0
    IL_037e: ldc.r4 0f
    IL_0383: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0388: br.s IL_03fe
    IL_038a: ldarg.0
    IL_038b: ldarg.0
    IL_038c: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0391: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0396: add
    IL_0397: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_039c: ldloc.1
    IL_039d: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_03a2: ldarg.0
    IL_03a3: ldfld Vector2 NightscoreUI.<PlayPopUpAnimation>d__32::<contentSizeDelta>5__4  /*0x040014E9*/
    IL_03a8: call Vector2 UnityEngine.Vector2::get_up()  /*0x0A0001CE*/
    IL_03ad: ldc.r4 55f
    IL_03b2: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_03b7: ldloc.1
    IL_03b8: ldfld AnimationCurve NightscoreUI::expandCurve  /*0x040014D1*/
    IL_03bd: ldc.r4 0f
    IL_03c2: ldarg.0
    IL_03c3: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_03c8: ldarg.0
    IL_03c9: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_03ce: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_03d3: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_03d8: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_03dd: call Vector2 UnityEngine.Vector2::op_Addition(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000154*/
    IL_03e2: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_03e7: ldarg.0
    IL_03e8: ldnull
    IL_03e9: stfld object NightscoreUI.<PlayPopUpAnimation>d__32::<>2__current  /*0x040014E1*/
    IL_03ee: ldarg.0
    IL_03ef: ldc.i4.4
    IL_03f0: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_03f5: ldc.i4.1
    IL_03f6: ret
    IL_03f7: ldarg.0
    IL_03f8: ldc.i4.m1
    IL_03f9: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_03fe: ldarg.0
    IL_03ff: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0404: ldarg.0
    IL_0405: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_040a: blt IL_038a
    IL_040f: ldloc.1
    IL_0410: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_0415: ldarg.0
    IL_0416: ldfld Vector2 NightscoreUI.<PlayPopUpAnimation>d__32::<contentSizeDelta>5__4  /*0x040014E9*/
    IL_041b: call Vector2 UnityEngine.Vector2::get_up()  /*0x0A0001CE*/
    IL_0420: ldc.r4 55f
    IL_0425: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_042a: call Vector2 UnityEngine.Vector2::op_Addition(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000154*/
    IL_042f: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_0434: ldarg.0
    IL_0435: ldloc.1
    IL_0436: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_043b: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0440: stfld Vector2 NightscoreUI.<PlayPopUpAnimation>d__32::<contentSizeDelta>5__4  /*0x040014E9*/
    IL_0445: ldloc.1
    IL_0446: ldfld AudioSource NightscoreUI::pointSFXSource  /*0x040014C5*/
    IL_044b: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0450: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0455: callvirt AudioClip AudioSet::get_PointScreenBuildC()  /*0x060001E3*/
    IL_045a: ldloc.1
    IL_045b: ldfld float NightscoreUI::buildUpSFXVol  /*0x040014D7*/
    IL_0460: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_0465: ldarg.0
    IL_0466: ldc.r4 0.5f
    IL_046b: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_0470: ldarg.0
    IL_0471: ldc.r4 0f
    IL_0476: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_047b: br IL_0515
    IL_0480: ldarg.0
    IL_0481: ldarg.0
    IL_0482: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0487: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_048c: add
    IL_048d: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0492: ldloc.1
    IL_0493: ldfld RectTransform NightscoreUI::nightSurviveText  /*0x040014C8*/
    IL_0498: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_049d: ldloc.1
    IL_049e: ldfld AnimationCurve NightscoreUI::popCurve  /*0x040014D0*/
    IL_04a3: ldc.r4 0f
    IL_04a8: ldarg.0
    IL_04a9: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_04ae: ldarg.0
    IL_04af: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_04b4: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_04b9: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_04be: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_04c3: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_04c8: ldloc.1
    IL_04c9: ldfld RectTransform NightscoreUI::nightSurviveNumber  /*0x040014C9*/
    IL_04ce: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_04d3: ldloc.1
    IL_04d4: ldfld AnimationCurve NightscoreUI::popCurve  /*0x040014D0*/
    IL_04d9: ldc.r4 0f
    IL_04de: ldarg.0
    IL_04df: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_04e4: ldarg.0
    IL_04e5: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_04ea: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_04ef: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_04f4: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_04f9: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_04fe: ldarg.0
    IL_04ff: ldnull
    IL_0500: stfld object NightscoreUI.<PlayPopUpAnimation>d__32::<>2__current  /*0x040014E1*/
    IL_0505: ldarg.0
    IL_0506: ldc.i4.5
    IL_0507: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_050c: ldc.i4.1
    IL_050d: ret
    IL_050e: ldarg.0
    IL_050f: ldc.i4.m1
    IL_0510: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_0515: ldarg.0
    IL_0516: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_051b: ldarg.0
    IL_051c: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_0521: blt IL_0480
    IL_0526: ldloc.1
    IL_0527: ldfld RectTransform NightscoreUI::nightSurviveText  /*0x040014C8*/
    IL_052c: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0531: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0536: ldloc.1
    IL_0537: ldfld RectTransform NightscoreUI::nightSurviveNumber  /*0x040014C9*/
    IL_053c: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0541: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0546: ldloc.1
    IL_0547: ldfld AudioSource NightscoreUI::pointSFXSource  /*0x040014C5*/
    IL_054c: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0551: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0556: callvirt AudioClip AudioSet::get_PointScreenBuildB()  /*0x060001E2*/
    IL_055b: ldloc.1
    IL_055c: ldfld float NightscoreUI::buildUpSFXVol  /*0x040014D7*/
    IL_0561: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_0566: ldarg.0
    IL_0567: ldc.r4 0.5f
    IL_056c: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_0571: ldarg.0
    IL_0572: ldc.r4 0f
    IL_0577: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_057c: br.s IL_05f2
    IL_057e: ldarg.0
    IL_057f: ldarg.0
    IL_0580: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0585: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_058a: add
    IL_058b: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0590: ldloc.1
    IL_0591: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_0596: ldarg.0
    IL_0597: ldfld Vector2 NightscoreUI.<PlayPopUpAnimation>d__32::<contentSizeDelta>5__4  /*0x040014E9*/
    IL_059c: call Vector2 UnityEngine.Vector2::get_up()  /*0x0A0001CE*/
    IL_05a1: ldc.r4 30f
    IL_05a6: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_05ab: ldloc.1
    IL_05ac: ldfld AnimationCurve NightscoreUI::expandCurve  /*0x040014D1*/
    IL_05b1: ldc.r4 0f
    IL_05b6: ldarg.0
    IL_05b7: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_05bc: ldarg.0
    IL_05bd: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_05c2: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_05c7: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_05cc: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_05d1: call Vector2 UnityEngine.Vector2::op_Addition(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000154*/
    IL_05d6: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_05db: ldarg.0
    IL_05dc: ldnull
    IL_05dd: stfld object NightscoreUI.<PlayPopUpAnimation>d__32::<>2__current  /*0x040014E1*/
    IL_05e2: ldarg.0
    IL_05e3: ldc.i4.6
    IL_05e4: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_05e9: ldc.i4.1
    IL_05ea: ret
    IL_05eb: ldarg.0
    IL_05ec: ldc.i4.m1
    IL_05ed: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_05f2: ldarg.0
    IL_05f3: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_05f8: ldarg.0
    IL_05f9: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_05fe: blt IL_057e
    IL_0603: ldloc.1
    IL_0604: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_0609: ldarg.0
    IL_060a: ldfld Vector2 NightscoreUI.<PlayPopUpAnimation>d__32::<contentSizeDelta>5__4  /*0x040014E9*/
    IL_060f: call Vector2 UnityEngine.Vector2::get_up()  /*0x0A0001CE*/
    IL_0614: ldc.r4 30f
    IL_0619: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_061e: call Vector2 UnityEngine.Vector2::op_Addition(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000154*/
    IL_0623: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_0628: ldarg.0
    IL_0629: ldloc.1
    IL_062a: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_062f: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0634: stfld Vector2 NightscoreUI.<PlayPopUpAnimation>d__32::<contentSizeDelta>5__4  /*0x040014E9*/
    IL_0639: ldloc.1
    IL_063a: ldfld AudioSource NightscoreUI::pointSFXSource  /*0x040014C5*/
    IL_063f: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0644: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0649: callvirt AudioClip AudioSet::get_PointScreenBuildC()  /*0x060001E3*/
    IL_064e: ldloc.1
    IL_064f: ldfld float NightscoreUI::buildUpSFXVol  /*0x040014D7*/
    IL_0654: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_0659: ldarg.0
    IL_065a: ldc.r4 0.5f
    IL_065f: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_0664: ldarg.0
    IL_0665: ldc.r4 0f
    IL_066a: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_066f: br IL_0709
    IL_0674: ldarg.0
    IL_0675: ldarg.0
    IL_0676: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_067b: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0680: add
    IL_0681: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0686: ldloc.1
    IL_0687: ldfld RectTransform NightscoreUI::protectionText  /*0x040014CC*/
    IL_068c: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0691: ldloc.1
    IL_0692: ldfld AnimationCurve NightscoreUI::popCurve  /*0x040014D0*/
    IL_0697: ldc.r4 0f
    IL_069c: ldarg.0
    IL_069d: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_06a2: ldarg.0
    IL_06a3: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_06a8: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_06ad: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_06b2: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_06b7: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_06bc: ldloc.1
    IL_06bd: ldfld RectTransform NightscoreUI::protectionNumber  /*0x040014CD*/
    IL_06c2: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_06c7: ldloc.1
    IL_06c8: ldfld AnimationCurve NightscoreUI::popCurve  /*0x040014D0*/
    IL_06cd: ldc.r4 0f
    IL_06d2: ldarg.0
    IL_06d3: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_06d8: ldarg.0
    IL_06d9: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_06de: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_06e3: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_06e8: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_06ed: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_06f2: ldarg.0
    IL_06f3: ldnull
    IL_06f4: stfld object NightscoreUI.<PlayPopUpAnimation>d__32::<>2__current  /*0x040014E1*/
    IL_06f9: ldarg.0
    IL_06fa: ldc.i4.7
    IL_06fb: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_0700: ldc.i4.1
    IL_0701: ret
    IL_0702: ldarg.0
    IL_0703: ldc.i4.m1
    IL_0704: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_0709: ldarg.0
    IL_070a: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_070f: ldarg.0
    IL_0710: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_0715: blt IL_0674
    IL_071a: ldloc.1
    IL_071b: ldfld RectTransform NightscoreUI::protectionText  /*0x040014CC*/
    IL_0720: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0725: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_072a: ldloc.1
    IL_072b: ldfld RectTransform NightscoreUI::protectionNumber  /*0x040014CD*/
    IL_0730: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0735: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_073a: ldloc.1
    IL_073b: ldfld AudioSource NightscoreUI::pointSFXSource  /*0x040014C5*/
    IL_0740: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0745: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_074a: callvirt AudioClip AudioSet::get_PointScreenBuildB()  /*0x060001E2*/
    IL_074f: ldloc.1
    IL_0750: ldfld float NightscoreUI::buildUpSFXVol  /*0x040014D7*/
    IL_0755: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_075a: ldarg.0
    IL_075b: ldc.r4 0.5f
    IL_0760: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_0765: ldarg.0
    IL_0766: ldc.r4 0f
    IL_076b: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0770: br.s IL_07e6
    IL_0772: ldarg.0
    IL_0773: ldarg.0
    IL_0774: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0779: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_077e: add
    IL_077f: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0784: ldloc.1
    IL_0785: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_078a: ldarg.0
    IL_078b: ldfld Vector2 NightscoreUI.<PlayPopUpAnimation>d__32::<contentSizeDelta>5__4  /*0x040014E9*/
    IL_0790: call Vector2 UnityEngine.Vector2::get_up()  /*0x0A0001CE*/
    IL_0795: ldc.r4 30f
    IL_079a: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_079f: ldloc.1
    IL_07a0: ldfld AnimationCurve NightscoreUI::expandCurve  /*0x040014D1*/
    IL_07a5: ldc.r4 0f
    IL_07aa: ldarg.0
    IL_07ab: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_07b0: ldarg.0
    IL_07b1: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_07b6: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_07bb: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_07c0: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_07c5: call Vector2 UnityEngine.Vector2::op_Addition(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000154*/
    IL_07ca: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_07cf: ldarg.0
    IL_07d0: ldnull
    IL_07d1: stfld object NightscoreUI.<PlayPopUpAnimation>d__32::<>2__current  /*0x040014E1*/
    IL_07d6: ldarg.0
    IL_07d7: ldc.i4.8
    IL_07d8: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_07dd: ldc.i4.1
    IL_07de: ret
    IL_07df: ldarg.0
    IL_07e0: ldc.i4.m1
    IL_07e1: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_07e6: ldarg.0
    IL_07e7: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_07ec: ldarg.0
    IL_07ed: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_07f2: blt IL_0772
    IL_07f7: ldloc.1
    IL_07f8: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_07fd: ldarg.0
    IL_07fe: ldfld Vector2 NightscoreUI.<PlayPopUpAnimation>d__32::<contentSizeDelta>5__4  /*0x040014E9*/
    IL_0803: call Vector2 UnityEngine.Vector2::get_up()  /*0x0A0001CE*/
    IL_0808: ldc.r4 30f
    IL_080d: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_0812: call Vector2 UnityEngine.Vector2::op_Addition(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000154*/
    IL_0817: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_081c: ldarg.0
    IL_081d: ldloc.1
    IL_081e: ldfld RectTransform NightscoreUI::content  /*0x040014C7*/
    IL_0823: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0828: stfld Vector2 NightscoreUI.<PlayPopUpAnimation>d__32::<contentSizeDelta>5__4  /*0x040014E9*/
    IL_082d: ldloc.1
    IL_082e: ldfld AudioSource NightscoreUI::pointSFXSource  /*0x040014C5*/
    IL_0833: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0838: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_083d: callvirt AudioClip AudioSet::get_PointScreenBuildC()  /*0x060001E3*/
    IL_0842: ldloc.1
    IL_0843: ldfld float NightscoreUI::buildUpSFXVol  /*0x040014D7*/
    IL_0848: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_084d: ldarg.0
    IL_084e: ldc.r4 0.5f
    IL_0853: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_0858: ldarg.0
    IL_0859: ldc.r4 0f
    IL_085e: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0863: br IL_08fe
    IL_0868: ldarg.0
    IL_0869: ldarg.0
    IL_086a: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_086f: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0874: add
    IL_0875: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_087a: ldloc.1
    IL_087b: ldfld RectTransform NightscoreUI::timeText  /*0x040014CA*/
    IL_0880: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0885: ldloc.1
    IL_0886: ldfld AnimationCurve NightscoreUI::popCurve  /*0x040014D0*/
    IL_088b: ldc.r4 0f
    IL_0890: ldarg.0
    IL_0891: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_0896: ldarg.0
    IL_0897: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_089c: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_08a1: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_08a6: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_08ab: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_08b0: ldloc.1
    IL_08b1: ldfld RectTransform NightscoreUI::timeNumber  /*0x040014CB*/
    IL_08b6: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_08bb: ldloc.1
    IL_08bc: ldfld AnimationCurve NightscoreUI::popCurve  /*0x040014D0*/
    IL_08c1: ldc.r4 0f
    IL_08c6: ldarg.0
    IL_08c7: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_08cc: ldarg.0
    IL_08cd: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_08d2: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_08d7: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_08dc: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_08e1: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_08e6: ldarg.0
    IL_08e7: ldnull
    IL_08e8: stfld object NightscoreUI.<PlayPopUpAnimation>d__32::<>2__current  /*0x040014E1*/
    IL_08ed: ldarg.0
    IL_08ee: ldc.i4.s 9
    IL_08f0: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_08f5: ldc.i4.1
    IL_08f6: ret
    IL_08f7: ldarg.0
    IL_08f8: ldc.i4.m1
    IL_08f9: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_08fe: ldarg.0
    IL_08ff: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0904: ldarg.0
    IL_0905: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_090a: blt IL_0868
    IL_090f: ldloc.1
    IL_0910: ldfld RectTransform NightscoreUI::timeText  /*0x040014CA*/
    IL_0915: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_091a: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_091f: ldloc.1
    IL_0920: ldfld RectTransform NightscoreUI::timeNumber  /*0x040014CB*/
    IL_0925: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_092a: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_092f: ldloc.1
    IL_0930: ldfld AudioSource NightscoreUI::pointSFXSource  /*0x040014C5*/
    IL_0935: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_093a: ldarg.0
    IL_093b: ldc.r4 1.5f
    IL_0940: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_0945: ldarg.0
    IL_0946: ldc.r4 0f
    IL_094b: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0950: ldarg.0
    IL_0951: ldarg.0
    IL_0952: ldfld int NightscoreUI.<PlayPopUpAnimation>d__32::<nextScore>5__6  /*0x040014EB*/
    IL_0957: ldarg.0
    IL_0958: ldfld int NightscoreUI.<PlayPopUpAnimation>d__32::basescore  /*0x040014E3*/
    IL_095d: ldarg.0
    IL_095e: ldfld int NightscoreUI.<PlayPopUpAnimation>d__32::protectionbonus  /*0x040014E5*/
    IL_0963: add
    IL_0964: ldarg.0
    IL_0965: ldfld int NightscoreUI.<PlayPopUpAnimation>d__32::timebonus  /*0x040014E4*/
    IL_096a: add
    IL_096b: add
    IL_096c: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<nextScore>5__6  /*0x040014EB*/
    IL_0971: br.s IL_09de
    IL_0973: ldarg.0
    IL_0974: ldarg.0
    IL_0975: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_097a: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_097f: add
    IL_0980: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0985: ldloc.1
    IL_0986: ldfld TextMeshProUGUI NightscoreUI::overallScore  /*0x040014C4*/
    IL_098b: ldarg.0
    IL_098c: ldfld int NightscoreUI.<PlayPopUpAnimation>d__32::<currentScore>5__5  /*0x040014EA*/
    IL_0991: conv.r4
    IL_0992: ldarg.0
    IL_0993: ldfld int NightscoreUI.<PlayPopUpAnimation>d__32::<nextScore>5__6  /*0x040014EB*/
    IL_0998: conv.r4
    IL_0999: ldc.r4 0f
    IL_099e: ldarg.0
    IL_099f: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_09a4: ldarg.0
    IL_09a5: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_09aa: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_09af: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_09b4: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_09b9: stloc.2
    IL_09ba: ldloca.s 2
    IL_09bc: call string System.Int32::ToString()  /*0x0A000031*/
    IL_09c1: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_09c6: ldarg.0
    IL_09c7: ldnull
    IL_09c8: stfld object NightscoreUI.<PlayPopUpAnimation>d__32::<>2__current  /*0x040014E1*/
    IL_09cd: ldarg.0
    IL_09ce: ldc.i4.s 10
    IL_09d0: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_09d5: ldc.i4.1
    IL_09d6: ret
    IL_09d7: ldarg.0
    IL_09d8: ldc.i4.m1
    IL_09d9: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_09de: ldarg.0
    IL_09df: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_09e4: ldarg.0
    IL_09e5: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_09ea: blt.s IL_0973
    IL_09ec: ldarg.0
    IL_09ed: ldarg.0
    IL_09ee: ldfld int NightscoreUI.<PlayPopUpAnimation>d__32::<nextScore>5__6  /*0x040014EB*/
    IL_09f3: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<currentScore>5__5  /*0x040014EA*/
    IL_09f8: ldloc.1
    IL_09f9: ldfld TextMeshProUGUI NightscoreUI::overallScore  /*0x040014C4*/
    IL_09fe: ldarg.0
    IL_09ff: ldflda int NightscoreUI.<PlayPopUpAnimation>d__32::<currentScore>5__5  /*0x040014EA*/
    IL_0a04: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0a09: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0a0e: ldloc.1
    IL_0a0f: ldfld AudioSource NightscoreUI::pointSFXSource  /*0x040014C5*/
    IL_0a14: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_0a19: ldloc.1
    IL_0a1a: ldfld AudioSource NightscoreUI::pointSFXSource  /*0x040014C5*/
    IL_0a1f: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0a24: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0a29: callvirt AudioClip AudioSet::get_PointLockInMinor()  /*0x060001DF*/
    IL_0a2e: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_0a33: ldarg.0
    IL_0a34: ldc.r4 0.5f
    IL_0a39: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_0a3e: ldarg.0
    IL_0a3f: ldc.r4 0f
    IL_0a44: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0a49: br.s IL_0aab
    IL_0a4b: ldarg.0
    IL_0a4c: ldarg.0
    IL_0a4d: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0a52: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0a57: add
    IL_0a58: stfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0a5d: ldloc.1
    IL_0a5e: ldfld RectTransform NightscoreUI::overallScoreBG  /*0x040014CE*/
    IL_0a63: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0a68: ldloc.1
    IL_0a69: ldfld AnimationCurve NightscoreUI::bumpCurve  /*0x040014D2*/
    IL_0a6e: ldc.r4 0f
    IL_0a73: ldarg.0
    IL_0a74: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_0a79: ldarg.0
    IL_0a7a: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0a7f: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0a84: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0a89: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0a8e: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0a93: ldarg.0
    IL_0a94: ldnull
    IL_0a95: stfld object NightscoreUI.<PlayPopUpAnimation>d__32::<>2__current  /*0x040014E1*/
    IL_0a9a: ldarg.0
    IL_0a9b: ldc.i4.s 11
    IL_0a9d: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_0aa2: ldc.i4.1
    IL_0aa3: ret
    IL_0aa4: ldarg.0
    IL_0aa5: ldc.i4.m1
    IL_0aa6: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_0aab: ldarg.0
    IL_0aac: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<timer>5__2  /*0x040014E7*/
    IL_0ab1: ldarg.0
    IL_0ab2: ldfld float NightscoreUI.<PlayPopUpAnimation>d__32::<animTime>5__3  /*0x040014E8*/
    IL_0ab7: blt.s IL_0a4b
    IL_0ab9: ldloc.1
    IL_0aba: ldfld RectTransform NightscoreUI::overallScoreBG  /*0x040014CE*/
    IL_0abf: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0ac4: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0ac9: ldarg.0
    IL_0aca: ldloc.1
    IL_0acb: ldfld float NightscoreUI::completeWaitTime  /*0x040014D6*/
    IL_0ad0: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0ad5: stfld object NightscoreUI.<PlayPopUpAnimation>d__32::<>2__current  /*0x040014E1*/
    IL_0ada: ldarg.0
    IL_0adb: ldc.i4.s 12
    IL_0add: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_0ae2: ldc.i4.1
    IL_0ae3: ret
    IL_0ae4: ldarg.0
    IL_0ae5: ldc.i4.m1
    IL_0ae6: stfld int NightscoreUI.<PlayPopUpAnimation>d__32::<>1__state  /*0x040014E0*/
    IL_0aeb: ldloc.1
    IL_0aec: call void NightscoreUI::HideNightScore()  /*0x06001162*/
    IL_0af1: ldc.i4.0
    IL_0af2: ret

  .method NightscoreUI.<PlayPopUpAnimation>d__32::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600116F rva 0x52fab attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object NightscoreUI.<PlayPopUpAnimation>d__32::<>2__current  /*0x040014E1*/
    IL_0006: ret

  .method NightscoreUI.<PlayPopUpAnimation>d__32::System.Collections.IEnumerator.Reset()  // token 0x06001170 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method NightscoreUI.<PlayPopUpAnimation>d__32::System.Collections.IEnumerator.get_Current()  // token 0x06001171 rva 0x52fab attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object NightscoreUI.<PlayPopUpAnimation>d__32::<>2__current  /*0x040014E1*/
    IL_0006: ret

