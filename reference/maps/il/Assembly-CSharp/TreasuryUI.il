// ===== TreasuryUI  (token 0x0200036E) =====
  .method TreasuryUI::get_shouldBeActive()  // token 0x060012D3 rva 0x5965e attrs Private, HideBySig, SpecialName
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float TreasuryUI::activationCounter  /*0x040016C3*/
    IL_0006: ldc.r4 0f
    IL_000b: bgt.s IL_0014
    IL_000d: ldarg.0
    IL_000e: ldfld bool TreasuryUI::overrideActivation  /*0x040016C4*/
    IL_0013: ret
    IL_0014: ldc.i4.1
    IL_0015: ret

  .method TreasuryUI::Start()  // token 0x060012D4 rva 0x59678 attrs Private, HideBySig
    // code size 211 (0xd3), max stack 3, init locals
    .locals ([0] LevelInfo, [1] bool)
    IL_0000: ldarg.0
    IL_0001: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0006: callvirt TreasureChestUIHelper UIFrameManager::get_TreasureChest()  /*0x060012FC*/
    IL_000b: ldfld Transform TreasureChestUIHelper::scaleTarget  /*0x040016A7*/
    IL_0010: stfld Transform TreasuryUI::scaleTarget  /*0x040016B8*/
    IL_0015: ldarg.0
    IL_0016: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_001b: callvirt TreasureChestUIHelper UIFrameManager::get_TreasureChest()  /*0x060012FC*/
    IL_0020: ldfld TextMeshProUGUI TreasureChestUIHelper::balanceNumber  /*0x040016A8*/
    IL_0025: stfld TextMeshProUGUI TreasuryUI::displayText  /*0x040016BA*/
    IL_002a: ldc.i4.0
    IL_002b: call bool DlcConfiguration::IsDlcAvailable(IDlcProvider.DlcId)  /*0x0600001C*/
    IL_0030: brfalse.s IL_0073
    IL_0032: ldarg.0
    IL_0033: ldc.i4.1
    IL_0034: stfld bool TreasuryUI::isCraaghelmDlcAvailable  /*0x040016C9*/
    IL_0039: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_003e: callvirt LevelInfo LevelProgressManager::GetLevelInfoFromCurrentSceneName()  /*0x06000945*/
    IL_0043: stloc.0
    IL_0044: ldc.i4.0
    IL_0045: stloc.1
    IL_0046: ldloc.0
    IL_0047: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_004c: brfalse.s IL_005b
    IL_004e: ldc.i4.0
    IL_004f: ldloc.0
    IL_0050: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0055: call bool DlcConfiguration::IsDlcMap(IDlcProvider.DlcId,string)  /*0x0600001D*/
    IL_005a: stloc.1
    IL_005b: ldloc.1
    IL_005c: brfalse.s IL_0073
    IL_005e: ldarg.0
    IL_005f: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0064: callvirt TreasureChestUIHelper UIFrameManager::get_TreasureChest()  /*0x060012FC*/
    IL_0069: callvirt TextMeshProUGUI TreasureChestUIHelper::get_EnergyCoreBalanceNumber()  /*0x060012D0*/
    IL_006e: stfld TextMeshProUGUI TreasuryUI::energyCoreDisplayText  /*0x040016BB*/
    IL_0073: ldarg.0
    IL_0074: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0079: callvirt IReadOnlyList<TaggedObject> TagManager::get_Players()  /*0x06000E54*/
    IL_007e: ldc.i4.0
    IL_007f: callvirt !0 System.Collections.Generic.IReadOnlyList<TaggedObject>::get_Item(int)  /*0x0A00019F*/
    IL_0084: callvirt !!0 UnityEngine.Component::GetComponent()<PlayerInteraction>  /*0x2B00002E*/
    IL_0089: stfld PlayerInteraction TreasuryUI::targetPlayer  /*0x040016BE*/
    IL_008e: ldarg.0
    IL_008f: ldfld PlayerInteraction TreasuryUI::targetPlayer  /*0x040016BE*/
    IL_0094: ldfld UnityEvent PlayerInteraction::onFocusPaymentInteraction  /*0x04000ED3*/
    IL_0099: ldarg.0
    IL_009a: ldftn void TreasuryUI::LockActivation()  /*0x060012DA*/
    IL_00a0: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00a5: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00aa: ldarg.0
    IL_00ab: ldfld PlayerInteraction TreasuryUI::targetPlayer  /*0x040016BE*/
    IL_00b0: ldfld UnityEvent PlayerInteraction::onUnfocusPaymentInteraction  /*0x04000ED4*/
    IL_00b5: ldarg.0
    IL_00b6: ldftn void TreasuryUI::UnlockActivation()  /*0x060012DB*/
    IL_00bc: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00c1: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00c6: ldarg.0
    IL_00c7: ldarg.0
    IL_00c8: ldfld TreasuryUI.AnimationState TreasuryUI::currentState  /*0x040016C5*/
    IL_00cd: call void TreasuryUI::SetState(TreasuryUI.AnimationState)  /*0x060012D8*/
    IL_00d2: ret

  .method TreasuryUI::OnColorChange()  // token 0x060012D5 rva 0x59757 attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool TreasuryUI::forceRender  /*0x040016C8*/
    IL_0007: ret

  .method TreasuryUI::OnEnable()  // token 0x060012D6 rva 0x59760 attrs Private, HideBySig
    // code size 50 (0x32), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: dup
    IL_0006: brtrue.s IL_000b
    IL_0008: pop
    IL_0009: br.s IL_0011
    IL_000b: ldarg.0
    IL_000c: call void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0011: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_0016: dup
    IL_0017: brtrue.s IL_001b
    IL_0019: pop
    IL_001a: ret
    IL_001b: ldfld UnityEvent ColorAndLightManager::OnColorChange  /*0x04000449*/
    IL_0020: ldarg.0
    IL_0021: ldftn void TreasuryUI::OnColorChange()  /*0x060012D5*/
    IL_0027: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_002c: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0031: ret

  .method TreasuryUI::OnDisable()  // token 0x060012D7 rva 0x59793 attrs Private, HideBySig
    // code size 50 (0x32), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: dup
    IL_0006: brtrue.s IL_000b
    IL_0008: pop
    IL_0009: br.s IL_0011
    IL_000b: ldarg.0
    IL_000c: call void DayNightCycle::UnregisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B4*/
    IL_0011: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_0016: dup
    IL_0017: brtrue.s IL_001b
    IL_0019: pop
    IL_001a: ret
    IL_001b: ldfld UnityEvent ColorAndLightManager::OnColorChange  /*0x04000449*/
    IL_0020: ldarg.0
    IL_0021: ldftn void TreasuryUI::OnColorChange()  /*0x060012D5*/
    IL_0027: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_002c: callvirt void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)  /*0x0A0000B2*/
    IL_0031: ret

  .method TreasuryUI::SetState(TreasuryUI.AnimationState)  // token 0x060012D8 rva 0x597c8 attrs Private, HideBySig
    // code size 184 (0xb8), max stack 4, init locals
    IL_0000: ldarg.1
    IL_0001: switch (IL_001f, IL_00b0, IL_0051, IL_00b0, IL_0094)
    IL_001a: br IL_00b0
    IL_001f: ldarg.0
    IL_0020: ldfld Transform TreasuryUI::scaleTarget  /*0x040016B8*/
    IL_0025: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_002a: ldarg.0
    IL_002b: ldfld AnimationCurve TreasuryUI::scaleCurve  /*0x040016B6*/
    IL_0030: ldc.r4 0f
    IL_0035: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_003a: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_003f: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0044: ldarg.0
    IL_0045: ldc.r4 0f
    IL_004a: stfld float TreasuryUI::scaleAnimationProgress  /*0x040016C6*/
    IL_004f: br.s IL_00b0
    IL_0051: ldarg.0
    IL_0052: ldfld Transform TreasuryUI::scaleTarget  /*0x040016B8*/
    IL_0057: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_005c: ldarg.0
    IL_005d: ldfld AnimationCurve TreasuryUI::scaleCurve  /*0x040016B6*/
    IL_0062: ldc.r4 1f
    IL_0067: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_006c: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0071: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0076: ldarg.0
    IL_0077: ldc.r4 1f
    IL_007c: stfld float TreasuryUI::scaleAnimationProgress  /*0x040016C6*/
    IL_0081: ldarg.0
    IL_0082: ldfld Animator TreasuryUI::treasureChestAnimator  /*0x040016BC*/
    IL_0087: ldstr "Open"
    IL_008c: ldc.i4.1
    IL_008d: callvirt void UnityEngine.Animator::SetBool(string,bool)  /*0x0A0001BA*/
    IL_0092: br.s IL_00b0
    IL_0094: ldarg.0
    IL_0095: ldfld Animator TreasuryUI::treasureChestAnimator  /*0x040016BC*/
    IL_009a: ldstr "Open"
    IL_009f: ldc.i4.0
    IL_00a0: callvirt void UnityEngine.Animator::SetBool(string,bool)  /*0x0A0001BA*/
    IL_00a5: ldarg.0
    IL_00a6: ldc.r4 0f
    IL_00ab: stfld float TreasuryUI::scaleOutWaitClock  /*0x040016C7*/
    IL_00b0: ldarg.0
    IL_00b1: ldarg.1
    IL_00b2: stfld TreasuryUI.AnimationState TreasuryUI::currentState  /*0x040016C5*/
    IL_00b7: ret

  .method TreasuryUI::Update()  // token 0x060012D9 rva 0x5988c attrs Private, HideBySig
    // code size 943 (0x3af), max stack 4, init locals
    .locals ([0] bool, [1] int, [2] GameObject, [3] int, [4] Rigidbody, [5] TreasuryUI.AnimationState)
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_000a: brtrue.s IL_0029
    IL_000c: ldarg.0
    IL_000d: ldfld List<GameObject> TreasuryUI::instantiatedCoins  /*0x040016BD*/
    IL_0012: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_0017: ldarg.0
    IL_0018: ldfld PlayerInteraction TreasuryUI::targetPlayer  /*0x040016BE*/
    IL_001d: callvirt int PlayerInteraction::get_Balance()  /*0x06000C04*/
    IL_0022: ceq
    IL_0024: ldc.i4.0
    IL_0025: ceq
    IL_0027: br.s IL_002a
    IL_0029: ldc.i4.0
    IL_002a: stloc.0
    IL_002b: ldarg.0
    IL_002c: ldfld bool TreasuryUI::forceRender  /*0x040016C8*/
    IL_0031: brtrue.s IL_0053
    IL_0033: ldarg.0
    IL_0034: call bool TreasuryUI::get_shouldBeActive()  /*0x060012D3*/
    IL_0039: brtrue.s IL_0053
    IL_003b: ldarg.0
    IL_003c: ldfld TreasuryUI.AnimationState TreasuryUI::currentState  /*0x040016C5*/
    IL_0041: brtrue.s IL_0053
    IL_0043: ldloc.0
    IL_0044: brtrue.s IL_0053
    IL_0046: ldarg.0
    IL_0047: ldfld GameObject TreasuryUI::renderCamera  /*0x040016B0*/
    IL_004c: ldc.i4.0
    IL_004d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0052: ret
    IL_0053: ldarg.0
    IL_0054: ldfld GameObject TreasuryUI::renderCamera  /*0x040016B0*/
    IL_0059: ldc.i4.1
    IL_005a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_005f: ldarg.0
    IL_0060: ldc.i4.0
    IL_0061: stfld bool TreasuryUI::forceRender  /*0x040016C8*/
    IL_0066: ldarg.0
    IL_0067: ldfld float TreasuryUI::addCounter  /*0x040016C1*/
    IL_006c: ldc.r4 0f
    IL_0071: ble.un.s IL_0085
    IL_0073: ldarg.0
    IL_0074: ldarg.0
    IL_0075: ldfld float TreasuryUI::addCounter  /*0x040016C1*/
    IL_007a: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_007f: sub
    IL_0080: stfld float TreasuryUI::addCounter  /*0x040016C1*/
    IL_0085: ldarg.0
    IL_0086: ldfld float TreasuryUI::removalCounter  /*0x040016C2*/
    IL_008b: ldc.r4 0f
    IL_0090: ble.un.s IL_00a4
    IL_0092: ldarg.0
    IL_0093: ldarg.0
    IL_0094: ldfld float TreasuryUI::removalCounter  /*0x040016C2*/
    IL_0099: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_009e: sub
    IL_009f: stfld float TreasuryUI::removalCounter  /*0x040016C2*/
    IL_00a4: ldarg.0
    IL_00a5: ldfld float TreasuryUI::activationCounter  /*0x040016C3*/
    IL_00aa: ldc.r4 0f
    IL_00af: ble.un.s IL_00c3
    IL_00b1: ldarg.0
    IL_00b2: ldarg.0
    IL_00b3: ldfld float TreasuryUI::activationCounter  /*0x040016C3*/
    IL_00b8: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00bd: sub
    IL_00be: stfld float TreasuryUI::activationCounter  /*0x040016C3*/
    IL_00c3: ldarg.0
    IL_00c4: ldarg.0
    IL_00c5: ldfld PlayerInteraction TreasuryUI::targetPlayer  /*0x040016BE*/
    IL_00ca: callvirt int PlayerInteraction::get_Balance()  /*0x06000C04*/
    IL_00cf: ldc.i4 200
    IL_00d4: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_00d9: stfld int TreasuryUI::bufferedBalance  /*0x040016BF*/
    IL_00de: ldarg.0
    IL_00df: ldarg.0
    IL_00e0: ldfld int TreasuryUI::bufferedBalance  /*0x040016BF*/
    IL_00e5: ldarg.0
    IL_00e6: ldfld List<GameObject> TreasuryUI::instantiatedCoins  /*0x040016BD*/
    IL_00eb: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_00f0: sub
    IL_00f1: stfld int TreasuryUI::coinQeue  /*0x040016C0*/
    IL_00f6: ldarg.0
    IL_00f7: ldfld TreasuryUI.AnimationState TreasuryUI::currentState  /*0x040016C5*/
    IL_00fc: brfalse.s IL_0126
    IL_00fe: ldarg.0
    IL_00ff: ldfld TextMeshProUGUI TreasuryUI::displayText  /*0x040016BA*/
    IL_0104: ldstr "<sprite name=\"coin\">"
    IL_0109: ldarg.0
    IL_010a: ldfld PlayerInteraction TreasuryUI::targetPlayer  /*0x040016BE*/
    IL_010f: callvirt int PlayerInteraction::get_Balance()  /*0x06000C04*/
    IL_0114: stloc.1
    IL_0115: ldloca.s 1
    IL_0117: call string System.Int32::ToString()  /*0x0A000031*/
    IL_011c: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0121: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0126: ldarg.0
    IL_0127: ldfld bool TreasuryUI::isCraaghelmDlcAvailable  /*0x040016C9*/
    IL_012c: brfalse.s IL_015a
    IL_012e: ldarg.0
    IL_012f: ldfld TextMeshProUGUI TreasuryUI::energyCoreDisplayText  /*0x040016BB*/
    IL_0134: ldnull
    IL_0135: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_013a: brfalse.s IL_015a
    IL_013c: ldarg.0
    IL_013d: ldfld TextMeshProUGUI TreasuryUI::energyCoreDisplayText  /*0x040016BB*/
    IL_0142: ldarg.0
    IL_0143: ldfld PlayerInteraction TreasuryUI::targetPlayer  /*0x040016BE*/
    IL_0148: callvirt int PlayerInteraction::get_EnergyCoreBalance()  /*0x06000C05*/
    IL_014d: stloc.1
    IL_014e: ldloca.s 1
    IL_0150: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0155: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_015a: ldarg.0
    IL_015b: ldfld int TreasuryUI::coinQeue  /*0x040016C0*/
    IL_0160: ldc.i4.0
    IL_0161: ble IL_0201
    IL_0166: ldarg.0
    IL_0167: ldfld float TreasuryUI::addCounter  /*0x040016C1*/
    IL_016c: ldc.r4 0f
    IL_0171: bgt.un IL_0201
    IL_0176: ldarg.0
    IL_0177: ldfld GameObject TreasuryUI::coinPrefab  /*0x040016B1*/
    IL_017c: ldarg.0
    IL_017d: ldfld Transform TreasuryUI::spawn  /*0x040016B2*/
    IL_0182: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0187: call Quaternion UnityEngine.Random::get_rotation()  /*0x0A000726*/
    IL_018c: ldarg.0
    IL_018d: ldfld Transform TreasuryUI::coinsParent  /*0x040016AF*/
    IL_0192: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B00000C*/
    IL_0197: stloc.2
    IL_0198: ldarg.0
    IL_0199: ldfld List<GameObject> TreasuryUI::instantiatedCoins  /*0x040016BD*/
    IL_019e: ldloc.2
    IL_019f: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_01a4: ldarg.0
    IL_01a5: ldarg.0
    IL_01a6: ldfld float TreasuryUI::addInterval  /*0x040016B4*/
    IL_01ab: stfld float TreasuryUI::addCounter  /*0x040016C1*/
    IL_01b0: ldarg.0
    IL_01b1: ldarg.0
    IL_01b2: ldfld float TreasuryUI::activationLifetime  /*0x040016B5*/
    IL_01b7: stfld float TreasuryUI::activationCounter  /*0x040016C3*/
    IL_01bc: ldarg.0
    IL_01bd: ldfld List<GameObject> TreasuryUI::instantiatedCoins  /*0x040016BD*/
    IL_01c2: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_01c7: ldc.i4.s 10
    IL_01c9: sub
    IL_01ca: stloc.3
    IL_01cb: ldloc.3
    IL_01cc: ldc.i4.0
    IL_01cd: blt.s IL_0201
    IL_01cf: ldarg.0
    IL_01d0: ldfld List<GameObject> TreasuryUI::instantiatedCoins  /*0x040016BD*/
    IL_01d5: ldloc.3
    IL_01d6: callvirt !0 System.Collections.Generic.List<UnityEngine.GameObject>::get_Item(int)  /*0x0A0001C5*/
    IL_01db: callvirt GameObject UnityEngine.GameObject::get_gameObject()  /*0x0A0005FE*/
    IL_01e0: callvirt !!0 UnityEngine.GameObject::GetComponent()<UnityEngine.Rigidbody>  /*0x2B000108*/
    IL_01e5: stloc.s 4
    IL_01e7: ldloc.s 4
    IL_01e9: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_01ee: brfalse.s IL_0201
    IL_01f0: ldloc.s 4
    IL_01f2: callvirt bool UnityEngine.Rigidbody::get_isKinematic()  /*0x0A000727*/
    IL_01f7: brtrue.s IL_0201
    IL_01f9: ldloc.s 4
    IL_01fb: ldc.i4.1
    IL_01fc: callvirt void UnityEngine.Rigidbody::set_isKinematic(bool)  /*0x0A000728*/
    IL_0201: ldarg.0
    IL_0202: ldfld int TreasuryUI::coinQeue  /*0x040016C0*/
    IL_0207: ldc.i4.0
    IL_0208: bge.s IL_0272
    IL_020a: ldarg.0
    IL_020b: ldfld float TreasuryUI::addCounter  /*0x040016C1*/
    IL_0210: ldc.r4 0f
    IL_0215: bgt.un.s IL_0272
    IL_0217: ldarg.0
    IL_0218: ldfld List<GameObject> TreasuryUI::instantiatedCoins  /*0x040016BD*/
    IL_021d: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_0222: ldc.i4.0
    IL_0223: ble.s IL_0272
    IL_0225: ldarg.0
    IL_0226: ldfld List<GameObject> TreasuryUI::instantiatedCoins  /*0x040016BD*/
    IL_022b: ldarg.0
    IL_022c: ldfld List<GameObject> TreasuryUI::instantiatedCoins  /*0x040016BD*/
    IL_0231: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_0236: ldc.i4.1
    IL_0237: sub
    IL_0238: callvirt !0 System.Collections.Generic.List<UnityEngine.GameObject>::get_Item(int)  /*0x0A0001C5*/
    IL_023d: ldarg.0
    IL_023e: ldfld List<GameObject> TreasuryUI::instantiatedCoins  /*0x040016BD*/
    IL_0243: ldarg.0
    IL_0244: ldfld List<GameObject> TreasuryUI::instantiatedCoins  /*0x040016BD*/
    IL_0249: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_024e: ldc.i4.1
    IL_024f: sub
    IL_0250: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::RemoveAt(int)  /*0x0A0001C7*/
    IL_0255: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_025a: ldarg.0
    IL_025b: ldarg.0
    IL_025c: ldfld float TreasuryUI::removalInterval  /*0x040016B3*/
    IL_0261: stfld float TreasuryUI::removalCounter  /*0x040016C2*/
    IL_0266: ldarg.0
    IL_0267: ldarg.0
    IL_0268: ldfld float TreasuryUI::activationLifetime  /*0x040016B5*/
    IL_026d: stfld float TreasuryUI::activationCounter  /*0x040016C3*/
    IL_0272: ldarg.0
    IL_0273: ldfld TreasuryUI.AnimationState TreasuryUI::currentState  /*0x040016C5*/
    IL_0278: stloc.s 5
    IL_027a: ldloc.s 5
    IL_027c: switch (IL_0296, IL_034b, IL_02a9, IL_02e7, IL_02bc)
    IL_0295: ret
    IL_0296: ldarg.0
    IL_0297: call bool TreasuryUI::get_shouldBeActive()  /*0x060012D3*/
    IL_029c: brfalse IL_03ae
    IL_02a1: ldarg.0
    IL_02a2: ldc.i4.1
    IL_02a3: call void TreasuryUI::SetState(TreasuryUI.AnimationState)  /*0x060012D8*/
    IL_02a8: ret
    IL_02a9: ldarg.0
    IL_02aa: call bool TreasuryUI::get_shouldBeActive()  /*0x060012D3*/
    IL_02af: brtrue IL_03ae
    IL_02b4: ldarg.0
    IL_02b5: ldc.i4.4
    IL_02b6: call void TreasuryUI::SetState(TreasuryUI.AnimationState)  /*0x060012D8*/
    IL_02bb: ret
    IL_02bc: ldarg.0
    IL_02bd: ldarg.0
    IL_02be: ldfld float TreasuryUI::scaleOutWaitClock  /*0x040016C7*/
    IL_02c3: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_02c8: add
    IL_02c9: stfld float TreasuryUI::scaleOutWaitClock  /*0x040016C7*/
    IL_02ce: ldarg.0
    IL_02cf: ldfld float TreasuryUI::scaleOutWaitClock  /*0x040016C7*/
    IL_02d4: ldarg.0
    IL_02d5: ldfld float TreasuryUI::waitTimeBeforeScaleOut  /*0x040016B9*/
    IL_02da: blt.un IL_03ae
    IL_02df: ldarg.0
    IL_02e0: ldc.i4.3
    IL_02e1: call void TreasuryUI::SetState(TreasuryUI.AnimationState)  /*0x060012D8*/
    IL_02e6: ret
    IL_02e7: ldarg.0
    IL_02e8: ldarg.0
    IL_02e9: ldfld float TreasuryUI::scaleAnimationProgress  /*0x040016C6*/
    IL_02ee: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_02f3: ldarg.0
    IL_02f4: ldfld float TreasuryUI::scaleAnimationSpeed  /*0x040016B7*/
    IL_02f9: mul
    IL_02fa: sub
    IL_02fb: stfld float TreasuryUI::scaleAnimationProgress  /*0x040016C6*/
    IL_0300: ldarg.0
    IL_0301: ldfld Transform TreasuryUI::scaleTarget  /*0x040016B8*/
    IL_0306: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_030b: ldarg.0
    IL_030c: ldfld AnimationCurve TreasuryUI::scaleCurve  /*0x040016B6*/
    IL_0311: ldarg.0
    IL_0312: ldfld float TreasuryUI::scaleAnimationProgress  /*0x040016C6*/
    IL_0317: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_031c: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0321: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0326: ldarg.0
    IL_0327: ldfld float TreasuryUI::scaleAnimationProgress  /*0x040016C6*/
    IL_032c: ldc.r4 0f
    IL_0331: bgt.un.s IL_033b
    IL_0333: ldarg.0
    IL_0334: ldc.i4.0
    IL_0335: call void TreasuryUI::SetState(TreasuryUI.AnimationState)  /*0x060012D8*/
    IL_033a: ret
    IL_033b: ldarg.0
    IL_033c: call bool TreasuryUI::get_shouldBeActive()  /*0x060012D3*/
    IL_0341: brfalse.s IL_03ae
    IL_0343: ldarg.0
    IL_0344: ldc.i4.1
    IL_0345: call void TreasuryUI::SetState(TreasuryUI.AnimationState)  /*0x060012D8*/
    IL_034a: ret
    IL_034b: ldarg.0
    IL_034c: ldarg.0
    IL_034d: ldfld float TreasuryUI::scaleAnimationProgress  /*0x040016C6*/
    IL_0352: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0357: ldarg.0
    IL_0358: ldfld float TreasuryUI::scaleAnimationSpeed  /*0x040016B7*/
    IL_035d: mul
    IL_035e: add
    IL_035f: stfld float TreasuryUI::scaleAnimationProgress  /*0x040016C6*/
    IL_0364: ldarg.0
    IL_0365: ldfld Transform TreasuryUI::scaleTarget  /*0x040016B8*/
    IL_036a: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_036f: ldarg.0
    IL_0370: ldfld AnimationCurve TreasuryUI::scaleCurve  /*0x040016B6*/
    IL_0375: ldarg.0
    IL_0376: ldfld float TreasuryUI::scaleAnimationProgress  /*0x040016C6*/
    IL_037b: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0380: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0385: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_038a: ldarg.0
    IL_038b: ldfld float TreasuryUI::scaleAnimationProgress  /*0x040016C6*/
    IL_0390: ldc.r4 1f
    IL_0395: blt.un.s IL_039f
    IL_0397: ldarg.0
    IL_0398: ldc.i4.2
    IL_0399: call void TreasuryUI::SetState(TreasuryUI.AnimationState)  /*0x060012D8*/
    IL_039e: ret
    IL_039f: ldarg.0
    IL_03a0: call bool TreasuryUI::get_shouldBeActive()  /*0x060012D3*/
    IL_03a5: brtrue.s IL_03ae
    IL_03a7: ldarg.0
    IL_03a8: ldc.i4.1
    IL_03a9: call void TreasuryUI::SetState(TreasuryUI.AnimationState)  /*0x060012D8*/
    IL_03ae: ret

  .method TreasuryUI::LockActivation()  // token 0x060012DA rva 0x59c47 attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool TreasuryUI::overrideActivation  /*0x040016C4*/
    IL_0007: ret

  .method TreasuryUI::UnlockActivation()  // token 0x060012DB rva 0x59c50 attrs Private, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool TreasuryUI::overrideActivation  /*0x040016C4*/
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldfld float TreasuryUI::activationLifetime  /*0x040016B5*/
    IL_000e: stfld float TreasuryUI::activationCounter  /*0x040016C3*/
    IL_0013: ret

  .method TreasuryUI::OnDusk()  // token 0x060012DC rva 0x59c65 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject TreasuryUI::renderCamera  /*0x040016B0*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method TreasuryUI::OnDawn_AfterSunrise()  // token 0x060012DD rva 0x59757 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool TreasuryUI::forceRender  /*0x040016C8*/
    IL_0007: ret

  .method TreasuryUI::OnDawn_BeforeSunrise()  // token 0x060012DE rva 0x59757 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool TreasuryUI::forceRender  /*0x040016C8*/
    IL_0007: ret

  .method TreasuryUI::OnDuskEarly()  // token 0x060012DF rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TreasuryUI::.ctor()  // token 0x060012E0 rva 0x59c73 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 58 (0x3a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.35f
    IL_0006: stfld float TreasuryUI::addInterval  /*0x040016B4*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float TreasuryUI::activationLifetime  /*0x040016B5*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.3f
    IL_001c: stfld float TreasuryUI::waitTimeBeforeScaleOut  /*0x040016B9*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000133*/
    IL_0027: stfld List<GameObject> TreasuryUI::instantiatedCoins  /*0x040016BD*/
    IL_002c: ldarg.0
    IL_002d: ldc.i4.1
    IL_002e: stfld bool TreasuryUI::forceRender  /*0x040016C8*/
    IL_0033: ldarg.0
    IL_0034: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0039: ret

// ===== TreasuryUI/AnimationState  (token 0x0200036F) =====
