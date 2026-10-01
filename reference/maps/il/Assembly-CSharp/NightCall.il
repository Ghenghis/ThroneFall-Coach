// ===== NightCall  (token 0x02000324) =====
  .method NightCall::Awake()  // token 0x0600114F rva 0x518c4 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld NightCall NightCall::instance  /*0x040014A9*/
    IL_0006: ret

  .method NightCall::Start()  // token 0x06001150 rva 0x518cc attrs Private, HideBySig
    // code size 95 (0x5f), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_000c: stfld Player NightCall::input  /*0x040014B4*/
    IL_0011: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0016: ldarg.0
    IL_0017: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_001c: ldarg.0
    IL_001d: ldfld MPImage NightCall::targetFill  /*0x040014AC*/
    IL_0022: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0027: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_002c: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0031: ldarg.0
    IL_0032: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0037: stfld PlayerInteraction NightCall::player  /*0x040014B7*/
    IL_003c: ldarg.0
    IL_003d: ldarg.0
    IL_003e: ldfld MPImage NightCall::background  /*0x040014AD*/
    IL_0043: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0048: stfld Color NightCall::defaultBackgroundColor  /*0x040014B8*/
    IL_004d: ldarg.0
    IL_004e: ldarg.0
    IL_004f: ldfld AudioSource NightCall::nightCallAudio  /*0x040014B3*/
    IL_0054: callvirt float UnityEngine.AudioSource::get_volume()  /*0x0A0000C4*/
    IL_0059: stfld float NightCall::nightCallTargetVolume  /*0x040014B9*/
    IL_005e: ret

  .method NightCall::Update()  // token 0x06001151 rva 0x51937 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void NightCall::UpdateFill()  /*0x06001152*/
    IL_0006: ret

  .method NightCall::UpdateFill()  // token 0x06001152 rva 0x51940 attrs Public, HideBySig
    // code size 700 (0x2bc), max stack 6, init locals
    .locals ([0] float)
    IL_0000: ldarg.0
    IL_0001: ldfld bool NightCall::active  /*0x040014B5*/
    IL_0006: brfalse IL_0265
    IL_000b: ldarg.0
    IL_000c: ldfld RectTransform NightCall::scaleParent  /*0x040014B2*/
    IL_0011: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0016: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_001b: ldarg.0
    IL_001c: ldfld Player NightCall::input  /*0x040014B4*/
    IL_0021: ldstr "Call Night"
    IL_0026: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_002b: brfalse.s IL_0070
    IL_002d: ldarg.0
    IL_002e: ldfld PlayerInteraction NightCall::player  /*0x040014B7*/
    IL_0033: callvirt bool PlayerInteraction::get_IsFreeToCallNight()  /*0x06000BFD*/
    IL_0038: brfalse.s IL_0070
    IL_003a: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_003f: callvirt bool DayNightCycle::get_AutomatedDaytime()  /*0x060003A5*/
    IL_0044: brtrue.s IL_0070
    IL_0046: ldarg.0
    IL_0047: ldfld AudioSource NightCall::nightCallAudio  /*0x040014B3*/
    IL_004c: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_0051: ldarg.0
    IL_0052: ldfld AudioSource NightCall::nightCallAudio  /*0x040014B3*/
    IL_0057: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_005c: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0061: callvirt AudioClip AudioSet::get_NightCallStart()  /*0x060001DB*/
    IL_0066: ldc.r4 0.45f
    IL_006b: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_0070: ldarg.0
    IL_0071: ldfld Player NightCall::input  /*0x040014B4*/
    IL_0076: ldstr "Call Night"
    IL_007b: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_0080: brfalse.s IL_00bc
    IL_0082: ldarg.0
    IL_0083: ldfld PlayerInteraction NightCall::player  /*0x040014B7*/
    IL_0088: callvirt bool PlayerInteraction::get_IsFreeToCallNight()  /*0x06000BFD*/
    IL_008d: brfalse.s IL_00bc
    IL_008f: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0094: callvirt bool DayNightCycle::get_AutomatedDaytime()  /*0x060003A5*/
    IL_0099: brtrue.s IL_00bc
    IL_009b: ldarg.0
    IL_009c: ldarg.0
    IL_009d: ldfld float NightCall::currentFill  /*0x040014B6*/
    IL_00a2: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00a7: ldc.r4 1f
    IL_00ac: ldarg.0
    IL_00ad: ldfld float NightCall::nightCallTime  /*0x040014AA*/
    IL_00b2: div
    IL_00b3: mul
    IL_00b4: add
    IL_00b5: stfld float NightCall::currentFill  /*0x040014B6*/
    IL_00ba: br.s IL_00e1
    IL_00bc: ldarg.0
    IL_00bd: ldarg.0
    IL_00be: ldfld float NightCall::currentFill  /*0x040014B6*/
    IL_00c3: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00c8: ldc.r4 2f
    IL_00cd: mul
    IL_00ce: ldc.r4 1f
    IL_00d3: ldarg.0
    IL_00d4: ldfld float NightCall::nightCallTime  /*0x040014AA*/
    IL_00d9: div
    IL_00da: mul
    IL_00db: sub
    IL_00dc: stfld float NightCall::currentFill  /*0x040014B6*/
    IL_00e1: ldarg.0
    IL_00e2: ldfld float NightCall::currentFill  /*0x040014B6*/
    IL_00e7: ldc.r4 1f
    IL_00ec: blt.un.s IL_0129
    IL_00ee: ldarg.0
    IL_00ef: ldfld AudioSource NightCall::nightCallAudio  /*0x040014B3*/
    IL_00f4: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_00f9: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_00fe: callvirt AudioClip AudioSet::get_NightCallComplete()  /*0x060001DC*/
    IL_0103: ldc.r4 0.8f
    IL_0108: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_010d: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0112: callvirt void DayNightCycle::SwitchToNight()  /*0x060003B1*/
    IL_0117: ldarg.0
    IL_0118: ldfld MMF_Player NightCall::fullFeedback  /*0x040014B0*/
    IL_011d: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0122: ldarg.0
    IL_0123: ldc.i4.0
    IL_0124: stfld bool NightCall::active  /*0x040014B5*/
    IL_0129: ldarg.0
    IL_012a: ldfld float NightCall::currentFill  /*0x040014B6*/
    IL_012f: ldc.r4 0f
    IL_0134: ble.un IL_01eb
    IL_0139: ldarg.0
    IL_013a: ldfld TextMeshProUGUI NightCall::nightCallCueText  /*0x040014AE*/
    IL_013f: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0144: ldc.i4.1
    IL_0145: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_014a: ldarg.0
    IL_014b: ldfld TextMeshProUGUI NightCall::nightCallTimeText  /*0x040014AF*/
    IL_0150: ldarg.0
    IL_0151: ldfld float NightCall::nightCallTime  /*0x040014AA*/
    IL_0156: ldc.r4 1f
    IL_015b: ldarg.0
    IL_015c: ldfld float NightCall::currentFill  /*0x040014B6*/
    IL_0161: sub
    IL_0162: mul
    IL_0163: stloc.0
    IL_0164: ldloca.s 0
    IL_0166: ldstr "F1"
    IL_016b: call string System.Single::ToString(string)  /*0x0A000623*/
    IL_0170: ldstr "s"
    IL_0175: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_017a: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_017f: ldarg.0
    IL_0180: ldfld TextMeshProUGUI NightCall::nightCallCueText  /*0x040014AE*/
    IL_0185: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_018a: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_018f: ldarg.0
    IL_0190: ldfld AnimationCurve NightCall::textCueScaleCurve  /*0x040014B1*/
    IL_0195: ldc.r4 0f
    IL_019a: ldc.r4 0.15f
    IL_019f: ldarg.0
    IL_01a0: ldfld float NightCall::currentFill  /*0x040014B6*/
    IL_01a5: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_01aa: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_01af: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_01b4: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_01b9: ldarg.0
    IL_01ba: ldfld AudioSource NightCall::nightCallAudio  /*0x040014B3*/
    IL_01bf: ldc.r4 0f
    IL_01c4: ldarg.0
    IL_01c5: ldfld float NightCall::nightCallTargetVolume  /*0x040014B9*/
    IL_01ca: ldc.r4 0f
    IL_01cf: ldc.r4 0.3f
    IL_01d4: ldarg.0
    IL_01d5: ldfld float NightCall::currentFill  /*0x040014B6*/
    IL_01da: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_01df: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_01e4: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_01e9: br.s IL_0211
    IL_01eb: ldarg.0
    IL_01ec: ldfld TextMeshProUGUI NightCall::nightCallCueText  /*0x040014AE*/
    IL_01f1: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01f6: ldc.i4.0
    IL_01f7: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01fc: ldarg.0
    IL_01fd: ldfld TextMeshProUGUI NightCall::nightCallCueText  /*0x040014AE*/
    IL_0202: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0207: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_020c: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0211: ldarg.0
    IL_0212: ldflda Color NightCall::defaultBackgroundColor  /*0x040014B8*/
    IL_0217: ldc.r4 0f
    IL_021c: ldc.r4 0.4f
    IL_0221: ldarg.0
    IL_0222: ldfld float NightCall::currentFill  /*0x040014B6*/
    IL_0227: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_022c: stfld float UnityEngine.Color::a  /*0x0A000187*/
    IL_0231: ldarg.0
    IL_0232: ldfld MPImage NightCall::background  /*0x040014AD*/
    IL_0237: ldarg.0
    IL_0238: ldfld Color NightCall::defaultBackgroundColor  /*0x040014B8*/
    IL_023d: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0242: ldarg.0
    IL_0243: ldarg.0
    IL_0244: ldfld float NightCall::currentFill  /*0x040014B6*/
    IL_0249: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_024e: stfld float NightCall::currentFill  /*0x040014B6*/
    IL_0253: ldarg.0
    IL_0254: ldfld MPImage NightCall::targetGraphic  /*0x040014AB*/
    IL_0259: ldarg.0
    IL_025a: ldfld float NightCall::currentFill  /*0x040014B6*/
    IL_025f: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_0264: ret
    IL_0265: ldarg.0
    IL_0266: ldfld float NightCall::currentFill  /*0x040014B6*/
    IL_026b: ldc.r4 0f
    IL_0270: ble.un.s IL_02bb
    IL_0272: ldarg.0
    IL_0273: ldarg.0
    IL_0274: ldfld float NightCall::currentFill  /*0x040014B6*/
    IL_0279: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_027e: ldc.r4 2f
    IL_0283: mul
    IL_0284: sub
    IL_0285: stfld float NightCall::currentFill  /*0x040014B6*/
    IL_028a: ldarg.0
    IL_028b: ldflda Color NightCall::defaultBackgroundColor  /*0x040014B8*/
    IL_0290: ldc.r4 0f
    IL_0295: ldc.r4 0.4f
    IL_029a: ldarg.0
    IL_029b: ldfld float NightCall::currentFill  /*0x040014B6*/
    IL_02a0: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_02a5: stfld float UnityEngine.Color::a  /*0x0A000187*/
    IL_02aa: ldarg.0
    IL_02ab: ldfld MPImage NightCall::background  /*0x040014AD*/
    IL_02b0: ldarg.0
    IL_02b1: ldfld Color NightCall::defaultBackgroundColor  /*0x040014B8*/
    IL_02b6: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_02bb: ret

  .method NightCall::OnDawn_AfterSunrise()  // token 0x06001153 rva 0x51c08 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 148 (0x94), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld MPImage NightCall::targetFill  /*0x040014AC*/
    IL_0006: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000b: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0010: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0015: ldarg.0
    IL_0016: ldfld MPImage NightCall::targetGraphic  /*0x040014AB*/
    IL_001b: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0020: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0025: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_002a: ldarg.0
    IL_002b: ldfld MPImage NightCall::targetGraphic  /*0x040014AB*/
    IL_0030: ldc.r4 0f
    IL_0035: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_003a: ldarg.0
    IL_003b: ldfld TextMeshProUGUI NightCall::nightCallCueText  /*0x040014AE*/
    IL_0040: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0045: ldc.i4.0
    IL_0046: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_004b: ldarg.0
    IL_004c: ldfld TextMeshProUGUI NightCall::nightCallCueText  /*0x040014AE*/
    IL_0051: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0056: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_005b: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0060: ldarg.0
    IL_0061: ldflda Color NightCall::defaultBackgroundColor  /*0x040014B8*/
    IL_0066: ldc.r4 0f
    IL_006b: stfld float UnityEngine.Color::a  /*0x0A000187*/
    IL_0070: ldarg.0
    IL_0071: ldfld MPImage NightCall::background  /*0x040014AD*/
    IL_0076: ldarg.0
    IL_0077: ldfld Color NightCall::defaultBackgroundColor  /*0x040014B8*/
    IL_007c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0081: ldarg.0
    IL_0082: ldc.r4 0f
    IL_0087: stfld float NightCall::currentFill  /*0x040014B6*/
    IL_008c: ldarg.0
    IL_008d: ldc.i4.1
    IL_008e: stfld bool NightCall::active  /*0x040014B5*/
    IL_0093: ret

  .method NightCall::OnDawn_BeforeSunrise()  // token 0x06001154 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method NightCall::OnDusk()  // token 0x06001155 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method NightCall::OnDuskEarly()  // token 0x06001156 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method NightCall::.ctor()  // token 0x06001157 rva 0x51ca8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float NightCall::nightCallTime  /*0x040014AA*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.1
    IL_000d: stfld bool NightCall::active  /*0x040014B5*/
    IL_0012: ldarg.0
    IL_0013: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0018: ret

