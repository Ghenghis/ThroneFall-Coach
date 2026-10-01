// ===== CommandUnits  (token 0x0200020D) =====
  .method CommandUnits::get_ShouldShowUnitTypes()  // token 0x06000AF4 rva 0x33934 attrs Public, HideBySig, SpecialName
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnitCommandRadiusAnimation CommandUnits::rangeIndicator  /*0x04000DAE*/
    IL_0006: callvirt bool UnitCommandRadiusAnimation::get_Active()  /*0x06000152*/
    IL_000b: brtrue.s IL_0019
    IL_000d: ldarg.0
    IL_000e: ldfld GameObject CommandUnits::commandingIndicator  /*0x04000DAF*/
    IL_0013: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_0018: ret
    IL_0019: ldc.i4.1
    IL_001a: ret

  .method CommandUnits::get_PlayerUnitsCommanding()  // token 0x06000AF5 rva 0x33950 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_0006: ret

  .method CommandUnits::Awake()  // token 0x06000AF6 rva 0x33958 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld CommandUnits CommandUnits::instance  /*0x04000DAD*/
    IL_0006: ret

  .method CommandUnits::Start()  // token 0x06000AF7 rva 0x33960 attrs Private, HideBySig
    // code size 178 (0xb2), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0006: stfld ThronefallAudioManager CommandUnits::audioManager  /*0x04000DBE*/
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: ldfld ThronefallAudioManager CommandUnits::audioManager  /*0x04000DBE*/
    IL_0012: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0017: stfld AudioSet CommandUnits::audioSet  /*0x04000DBF*/
    IL_001c: ldarg.0
    IL_001d: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0022: ldc.i4.0
    IL_0023: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_0028: stfld Player CommandUnits::input  /*0x04000DC4*/
    IL_002d: ldarg.0
    IL_002e: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0033: stfld TagManager CommandUnits::tagManager  /*0x04000DC6*/
    IL_0038: ldarg.0
    IL_0039: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_003e: stfld AstarPath CommandUnits::astarPath  /*0x04000DC7*/
    IL_0043: ldarg.0
    IL_0044: ldfld NNConstraint CommandUnits::nearestConstraint  /*0x04000DC0*/
    IL_0049: ldarg.0
    IL_004a: ldfld string CommandUnits::graphNameOfPlayerUnits  /*0x04000DB3*/
    IL_004f: call GraphMask Pathfinding.GraphMask::FromGraphName(string)  /*0x0A000290*/
    IL_0054: stfld GraphMask Pathfinding.NNConstraint::graphMask  /*0x0A000291*/
    IL_0059: ldarg.0
    IL_005a: ldfld NNConstraint CommandUnits::nearestConstraintAir  /*0x04000DC1*/
    IL_005f: ldarg.0
    IL_0060: ldfld string CommandUnits::graphNameOfFlyingUnits  /*0x04000DB4*/
    IL_0065: call GraphMask Pathfinding.GraphMask::FromGraphName(string)  /*0x0A000290*/
    IL_006a: stfld GraphMask Pathfinding.NNConstraint::graphMask  /*0x0A000291*/
    IL_006f: ldarg.0
    IL_0070: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0075: stfld PlayerUpgradeManager CommandUnits::playerUPgradeManager  /*0x04000DC8*/
    IL_007a: ldarg.0
    IL_007b: ldarg.0
    IL_007c: call !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_0081: stfld Hp CommandUnits::hpPlayer  /*0x04000DC9*/
    IL_0086: call void UnitProductionSelector::Clear()  /*0x06001397*/
    IL_008b: ldarg.0
    IL_008c: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0091: callvirt bool PerkManager::get_RoyalProtectionEquipped()  /*0x0600099E*/
    IL_0096: stfld bool CommandUnits::royalProtectionEquipped  /*0x04000DD4*/
    IL_009b: ldarg.0
    IL_009c: ldc.r4 1f
    IL_00a1: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00a6: ldfld float PerkManager::royalProtectionDamageTakenMultiplyer  /*0x04000C52*/
    IL_00ab: div
    IL_00ac: stfld float CommandUnits::royalProtectionHealthMulti  /*0x04000DD3*/
    IL_00b1: ret

  .method CommandUnits::Update()  // token 0x06000AF8 rva 0x33a20 attrs Private, HideBySig
    // code size 1434 (0x59a), max stack 4, init locals
    .locals ([0] float, [1] UnitProductionSelector, [2] bool, [3] bool, [4] bool, [5] bool, [6] bool, [7] IEnumerator<TaggedObject>, [8] TaggedObject, [9] Vector2, [10] int, [11] PathfindMovementPlayerunit)
    IL_0000: call float UnityEngine.Time::get_timeScale()  /*0x0A0000E0*/
    IL_0005: ldc.r4 0f
    IL_000a: bne.un.s IL_000d
    IL_000c: ret
    IL_000d: ldarg.0
    IL_000e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0013: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0018: ldloca.s 0
    IL_001a: call UnitProductionSelector UnitProductionSelector::FindClosestToPoint(UnityEngine.Vector3,ref float)  /*0x0600139A*/
    IL_001f: stloc.1
    IL_0020: ldloc.0
    IL_0021: ldc.r4 4f
    IL_0026: ble.un.s IL_002a
    IL_0028: ldnull
    IL_0029: stloc.1
    IL_002a: ldarg.0
    IL_002b: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_0030: ldstr "Command Units Toggle"
    IL_0035: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_003a: brfalse.s IL_004b
    IL_003c: ldarg.0
    IL_003d: ldarg.0
    IL_003e: ldfld bool CommandUnits::commandUnitsToggledOn  /*0x04000DD1*/
    IL_0043: ldc.i4.0
    IL_0044: ceq
    IL_0046: stfld bool CommandUnits::commandUnitsToggledOn  /*0x04000DD1*/
    IL_004b: ldarg.0
    IL_004c: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_0051: ldstr "Command Units"
    IL_0056: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_005b: dup
    IL_005c: brfalse.s IL_0065
    IL_005e: ldarg.0
    IL_005f: ldc.i4.0
    IL_0060: stfld bool CommandUnits::commandUnitsToggledOn  /*0x04000DD1*/
    IL_0065: ldarg.0
    IL_0066: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_006b: ldstr "Smart Command Units"
    IL_0070: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_0075: stloc.2
    IL_0076: ldloc.2
    IL_0077: or
    IL_0078: brtrue.s IL_0082
    IL_007a: ldarg.0
    IL_007b: ldfld bool CommandUnits::commandUnitsToggledOn  /*0x04000DD1*/
    IL_0080: br.s IL_0083
    IL_0082: ldc.i4.1
    IL_0083: stloc.3
    IL_0084: ldloc.3
    IL_0085: brfalse.s IL_0092
    IL_0087: ldarg.0
    IL_0088: ldfld bool CommandUnits::commandUnitsButtonLast  /*0x04000DD6*/
    IL_008d: ldc.i4.0
    IL_008e: ceq
    IL_0090: br.s IL_0093
    IL_0092: ldc.i4.0
    IL_0093: stloc.s 4
    IL_0095: ldloc.3
    IL_0096: brtrue.s IL_00a0
    IL_0098: ldarg.0
    IL_0099: ldfld bool CommandUnits::commandUnitsButtonLast  /*0x04000DD6*/
    IL_009e: br.s IL_00a1
    IL_00a0: ldc.i4.0
    IL_00a1: stloc.s 5
    IL_00a3: ldarg.0
    IL_00a4: ldloc.3
    IL_00a5: stfld bool CommandUnits::commandUnitsButtonLast  /*0x04000DD6*/
    IL_00aa: ldloc.3
    IL_00ab: stloc.s 6
    IL_00ad: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_00b2: callvirt bool LocalGamestate::get_PlayerFrozen()  /*0x060008FF*/
    IL_00b7: brtrue IL_02db
    IL_00bc: ldarg.0
    IL_00bd: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_00c2: ldstr "Select All Army"
    IL_00c7: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_00cc: brfalse.s IL_0134
    IL_00ce: ldarg.0
    IL_00cf: ldfld Hp CommandUnits::hpPlayer  /*0x04000DC9*/
    IL_00d4: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_00d9: ldc.r4 0f
    IL_00de: ble.un.s IL_0134
    IL_00e0: ldarg.0
    IL_00e1: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_00e6: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_00eb: ldarg.0
    IL_00ec: ldfld List<TagManager.ETag> CommandUnits::mayNotHaveTags  /*0x04000DCF*/
    IL_00f1: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_00f6: ldarg.0
    IL_00f7: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_00fc: ldc.i4.7
    IL_00fd: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0102: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0107: ldarg.0
    IL_0108: ldfld List<TaggedObject> CommandUnits::results  /*0x04000DD0*/
    IL_010d: ldarg.0
    IL_010e: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_0113: ldarg.0
    IL_0114: ldfld List<TagManager.ETag> CommandUnits::mayNotHaveTags  /*0x04000DCF*/
    IL_0119: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_011e: ldarg.0
    IL_011f: ldarg.0
    IL_0120: ldfld List<TaggedObject> CommandUnits::results  /*0x04000DD0*/
    IL_0125: call void CommandUnits::TryToSelectUnits(System.Collections.Generic.List<TaggedObject>)  /*0x06000B04*/
    IL_012a: ldstr "allarmy"
    IL_012f: call void AfterTutorialTipManager::AddPostTutorialTipAsComplete(string)  /*0x06000049*/
    IL_0134: ldarg.0
    IL_0135: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_013a: ldstr "Select All Melee"
    IL_013f: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0144: brfalse.s IL_01c5
    IL_0146: ldarg.0
    IL_0147: ldfld Hp CommandUnits::hpPlayer  /*0x04000DC9*/
    IL_014c: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0151: ldc.r4 0f
    IL_0156: ble.un.s IL_01c5
    IL_0158: ldarg.0
    IL_0159: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_015e: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_0163: ldarg.0
    IL_0164: ldfld List<TagManager.ETag> CommandUnits::mayNotHaveTags  /*0x04000DCF*/
    IL_0169: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_016e: ldarg.0
    IL_016f: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_0174: ldc.i4.7
    IL_0175: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_017a: ldarg.0
    IL_017b: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_0180: ldc.i4.4
    IL_0181: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0186: ldarg.0
    IL_0187: ldfld List<TagManager.ETag> CommandUnits::mayNotHaveTags  /*0x04000DCF*/
    IL_018c: ldc.i4.s 37
    IL_018e: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0193: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0198: ldarg.0
    IL_0199: ldfld List<TaggedObject> CommandUnits::results  /*0x04000DD0*/
    IL_019e: ldarg.0
    IL_019f: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_01a4: ldarg.0
    IL_01a5: ldfld List<TagManager.ETag> CommandUnits::mayNotHaveTags  /*0x04000DCF*/
    IL_01aa: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_01af: ldarg.0
    IL_01b0: ldarg.0
    IL_01b1: ldfld List<TaggedObject> CommandUnits::results  /*0x04000DD0*/
    IL_01b6: call void CommandUnits::TryToSelectUnits(System.Collections.Generic.List<TaggedObject>)  /*0x06000B04*/
    IL_01bb: ldstr "allmelee"
    IL_01c0: call void AfterTutorialTipManager::AddPostTutorialTipAsComplete(string)  /*0x06000049*/
    IL_01c5: ldarg.0
    IL_01c6: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_01cb: ldstr "Select All Ranged"
    IL_01d0: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_01d5: brfalse.s IL_0256
    IL_01d7: ldarg.0
    IL_01d8: ldfld Hp CommandUnits::hpPlayer  /*0x04000DC9*/
    IL_01dd: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_01e2: ldc.r4 0f
    IL_01e7: ble.un.s IL_0256
    IL_01e9: ldarg.0
    IL_01ea: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_01ef: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_01f4: ldarg.0
    IL_01f5: ldfld List<TagManager.ETag> CommandUnits::mayNotHaveTags  /*0x04000DCF*/
    IL_01fa: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_01ff: ldarg.0
    IL_0200: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_0205: ldc.i4.7
    IL_0206: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_020b: ldarg.0
    IL_020c: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_0211: ldc.i4.5
    IL_0212: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0217: ldarg.0
    IL_0218: ldfld List<TagManager.ETag> CommandUnits::mayNotHaveTags  /*0x04000DCF*/
    IL_021d: ldc.i4.s 37
    IL_021f: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0224: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0229: ldarg.0
    IL_022a: ldfld List<TaggedObject> CommandUnits::results  /*0x04000DD0*/
    IL_022f: ldarg.0
    IL_0230: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_0235: ldarg.0
    IL_0236: ldfld List<TagManager.ETag> CommandUnits::mayNotHaveTags  /*0x04000DCF*/
    IL_023b: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0240: ldarg.0
    IL_0241: ldarg.0
    IL_0242: ldfld List<TaggedObject> CommandUnits::results  /*0x04000DD0*/
    IL_0247: call void CommandUnits::TryToSelectUnits(System.Collections.Generic.List<TaggedObject>)  /*0x06000B04*/
    IL_024c: ldstr "allranged"
    IL_0251: call void AfterTutorialTipManager::AddPostTutorialTipAsComplete(string)  /*0x06000049*/
    IL_0256: ldarg.0
    IL_0257: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_025c: ldstr "Select All Heroes"
    IL_0261: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0266: brfalse.s IL_02db
    IL_0268: ldarg.0
    IL_0269: ldfld Hp CommandUnits::hpPlayer  /*0x04000DC9*/
    IL_026e: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0273: ldc.r4 0f
    IL_0278: ble.un.s IL_02db
    IL_027a: ldarg.0
    IL_027b: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_0280: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_0285: ldarg.0
    IL_0286: ldfld List<TagManager.ETag> CommandUnits::mayNotHaveTags  /*0x04000DCF*/
    IL_028b: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_0290: ldarg.0
    IL_0291: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_0296: ldc.i4.7
    IL_0297: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_029c: ldarg.0
    IL_029d: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_02a2: ldc.i4.s 37
    IL_02a4: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_02a9: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_02ae: ldarg.0
    IL_02af: ldfld List<TaggedObject> CommandUnits::results  /*0x04000DD0*/
    IL_02b4: ldarg.0
    IL_02b5: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_02ba: ldarg.0
    IL_02bb: ldfld List<TagManager.ETag> CommandUnits::mayNotHaveTags  /*0x04000DCF*/
    IL_02c0: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_02c5: ldarg.0
    IL_02c6: ldarg.0
    IL_02c7: ldfld List<TaggedObject> CommandUnits::results  /*0x04000DD0*/
    IL_02cc: call void CommandUnits::TryToSelectUnits(System.Collections.Generic.List<TaggedObject>)  /*0x06000B04*/
    IL_02d1: ldstr "allhero"
    IL_02d6: call void AfterTutorialTipManager::AddPostTutorialTipAsComplete(string)  /*0x06000049*/
    IL_02db: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_02e0: callvirt bool SettingsManager::get_EnableControlGroups()  /*0x06000DAC*/
    IL_02e5: brfalse.s IL_02ee
    IL_02e7: ldarg.0
    IL_02e8: ldloc.3
    IL_02e9: call void CommandUnits::ControlGroupUpdate(bool)  /*0x06000AF9*/
    IL_02ee: ldarg.0
    IL_02ef: ldfld bool CommandUnits::commanding  /*0x04000DC5*/
    IL_02f4: brtrue IL_043a
    IL_02f9: ldloc.s 4
    IL_02fb: brfalse.s IL_0321
    IL_02fd: ldarg.0
    IL_02fe: ldfld Hp CommandUnits::hpPlayer  /*0x04000DC9*/
    IL_0303: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0308: ldc.r4 0f
    IL_030d: ble.un.s IL_0321
    IL_030f: ldarg.0
    IL_0310: ldfld UnitCommandRadiusAnimation CommandUnits::rangeIndicator  /*0x04000DAE*/
    IL_0315: callvirt void UnitCommandRadiusAnimation::Activate()  /*0x06000154*/
    IL_031a: ldarg.0
    IL_031b: ldc.i4.1
    IL_031c: stfld bool CommandUnits::rangeIndicatorActive  /*0x04000DD5*/
    IL_0321: ldloc.3
    IL_0322: brfalse IL_041d
    IL_0327: ldarg.0
    IL_0328: ldfld Hp CommandUnits::hpPlayer  /*0x04000DC9*/
    IL_032d: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0332: ldc.r4 0f
    IL_0337: ble.un IL_041d
    IL_033c: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0341: callvirt IReadOnlyList<TaggedObject> TagManager::get_PlayerUnits()  /*0x06000E52*/
    IL_0346: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<TaggedObject>::GetEnumerator()  /*0x0A000100*/
    IL_034b: stloc.s 7
    IL_034d: br IL_0400
    IL_0352: ldloc.s 7
    IL_0354: callvirt !0 System.Collections.Generic.IEnumerator<TaggedObject>::get_Current()  /*0x0A000101*/
    IL_0359: stloc.s 8
    IL_035b: ldarg.0
    IL_035c: ldfld TagManager CommandUnits::tagManager  /*0x04000DC6*/
    IL_0361: ldloc.s 8
    IL_0363: ldarg.0
    IL_0364: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0369: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_036e: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_0373: ldarg.0
    IL_0374: ldfld float CommandUnits::attractRange  /*0x04000DB2*/
    IL_0379: bgt.un.s IL_0386
    IL_037b: ldarg.0
    IL_037c: ldloc.s 8
    IL_037e: ldloc.2
    IL_037f: call void CommandUnits::OnUnitAdd(TaggedObject,bool)  /*0x06000B02*/
    IL_0384: br.s IL_0400
    IL_0386: ldloc.s 8
    IL_0388: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_038d: ldc.i4.6
    IL_038e: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0393: brfalse.s IL_0400
    IL_0395: ldarg.0
    IL_0396: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_039b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_03a0: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_03a5: ldarg.0
    IL_03a6: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_03ab: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_03b0: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_03b5: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_03ba: ldloc.s 8
    IL_03bc: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_03c1: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_03c6: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_03cb: ldloc.s 8
    IL_03cd: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_03d2: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_03d7: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_03dc: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_03e1: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_03e6: stloc.s 9
    IL_03e8: ldloca.s 9
    IL_03ea: call float UnityEngine.Vector2::get_magnitude()  /*0x0A00015A*/
    IL_03ef: ldarg.0
    IL_03f0: ldfld float CommandUnits::attractRange  /*0x04000DB2*/
    IL_03f5: bgt.un.s IL_0400
    IL_03f7: ldarg.0
    IL_03f8: ldloc.s 8
    IL_03fa: ldloc.2
    IL_03fb: call void CommandUnits::OnUnitAdd(TaggedObject,bool)  /*0x06000B02*/
    IL_0400: ldloc.s 7
    IL_0402: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0407: brtrue IL_0352
    IL_040c: leave IL_04db
    IL_0411: ldloc.s 7
    IL_0413: brfalse.s IL_041c
    IL_0415: ldloc.s 7
    IL_0417: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_041c: endfinally
    IL_041d: ldarg.0
    IL_041e: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_0423: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_0428: ldc.i4.0
    IL_0429: ble IL_04db
    IL_042e: ldarg.0
    IL_042f: ldc.i4.1
    IL_0430: stfld bool CommandUnits::commanding  /*0x04000DC5*/
    IL_0435: br IL_04db
    IL_043a: ldloc.s 4
    IL_043c: brtrue.s IL_0450
    IL_043e: ldarg.0
    IL_043f: ldfld Hp CommandUnits::hpPlayer  /*0x04000DC9*/
    IL_0444: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0449: ldc.r4 0f
    IL_044e: bgt.un.s IL_0469
    IL_0450: ldarg.0
    IL_0451: ldloc.2
    IL_0452: call void CommandUnits::PlaceCommandedUnitsAndCalculateTargetPositions(bool)  /*0x06000B01*/
    IL_0457: ldarg.0
    IL_0458: ldc.r4 0f
    IL_045d: stfld float CommandUnits::timeSincePlace  /*0x04000DCA*/
    IL_0462: ldarg.0
    IL_0463: ldc.i4.0
    IL_0464: stfld bool CommandUnits::switchedToHold  /*0x04000DCC*/
    IL_0469: ldloc.3
    IL_046a: brfalse.s IL_04b3
    IL_046c: ldarg.0
    IL_046d: ldfld Hp CommandUnits::hpPlayer  /*0x04000DC9*/
    IL_0472: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0477: ldc.r4 0f
    IL_047c: ble.un.s IL_04b3
    IL_047e: ldarg.0
    IL_047f: ldarg.0
    IL_0480: ldfld float CommandUnits::timeSincePlace  /*0x04000DCA*/
    IL_0485: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_048a: add
    IL_048b: stfld float CommandUnits::timeSincePlace  /*0x04000DCA*/
    IL_0490: ldarg.0
    IL_0491: ldfld float CommandUnits::timeSincePlace  /*0x04000DCA*/
    IL_0496: ldarg.0
    IL_0497: ldfld float CommandUnits::holdToHoldPositionTime  /*0x04000DB8*/
    IL_049c: ble.un.s IL_04b3
    IL_049e: ldarg.0
    IL_049f: ldfld bool CommandUnits::switchedToHold  /*0x04000DCC*/
    IL_04a4: brtrue.s IL_04b3
    IL_04a6: ldarg.0
    IL_04a7: ldc.i4.1
    IL_04a8: stfld bool CommandUnits::switchedToHold  /*0x04000DCC*/
    IL_04ad: ldarg.0
    IL_04ae: call void CommandUnits::MakeUnitsInBufferHoldPosition()  /*0x06000AFF*/
    IL_04b3: ldloc.s 5
    IL_04b5: brtrue.s IL_04c9
    IL_04b7: ldarg.0
    IL_04b8: ldfld Hp CommandUnits::hpPlayer  /*0x04000DC9*/
    IL_04bd: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_04c2: ldc.r4 0f
    IL_04c7: bgt.un.s IL_04db
    IL_04c9: ldarg.0
    IL_04ca: ldc.i4.0
    IL_04cb: stfld bool CommandUnits::commanding  /*0x04000DC5*/
    IL_04d0: ldarg.0
    IL_04d1: ldc.r4 0f
    IL_04d6: stfld float CommandUnits::timeSincePlace  /*0x04000DCA*/
    IL_04db: ldarg.0
    IL_04dc: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_04e1: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_04e6: ldc.i4.1
    IL_04e7: sub
    IL_04e8: stloc.s 10
    IL_04ea: br.s IL_0531
    IL_04ec: ldarg.0
    IL_04ed: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_04f2: ldloc.s 10
    IL_04f4: callvirt !0 System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Item(int)  /*0x0A0004C9*/
    IL_04f9: stloc.s 11
    IL_04fb: ldloc.s 11
    IL_04fd: ldarg.0
    IL_04fe: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0503: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0508: callvirt void PathfindMovementPlayerunit::set_HomePosition(UnityEngine.Vector3)  /*0x06000B2B*/
    IL_050d: ldloc.s 11
    IL_050f: callvirt bool UnityEngine.Behaviour::get_enabled()  /*0x0A0001B4*/
    IL_0514: brtrue.s IL_052b
    IL_0516: ldarg.0
    IL_0517: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_051c: ldloc.s 10
    IL_051e: callvirt void System.Collections.Generic.List<PathfindMovementPlayerunit>::RemoveAt(int)  /*0x0A0004CA*/
    IL_0523: ldarg.0
    IL_0524: ldloc.s 11
    IL_0526: call void CommandUnits::OnUnitRemove(PathfindMovementPlayerunit)  /*0x06000B03*/
    IL_052b: ldloc.s 10
    IL_052d: ldc.i4.1
    IL_052e: sub
    IL_052f: stloc.s 10
    IL_0531: ldloc.s 10
    IL_0533: ldc.i4.0
    IL_0534: bge.s IL_04ec
    IL_0536: ldarg.0
    IL_0537: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_053c: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_0541: ldc.i4.0
    IL_0542: ble.s IL_0555
    IL_0544: ldloc.3
    IL_0545: brtrue.s IL_0555
    IL_0547: ldarg.0
    IL_0548: ldfld GameObject CommandUnits::commandingIndicator  /*0x04000DAF*/
    IL_054d: ldc.i4.1
    IL_054e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0553: br.s IL_0561
    IL_0555: ldarg.0
    IL_0556: ldfld GameObject CommandUnits::commandingIndicator  /*0x04000DAF*/
    IL_055b: ldc.i4.0
    IL_055c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0561: ldloc.3
    IL_0562: brtrue.s IL_0583
    IL_0564: ldarg.0
    IL_0565: ldfld UnitCommandRadiusAnimation CommandUnits::rangeIndicator  /*0x04000DAE*/
    IL_056a: callvirt bool UnitCommandRadiusAnimation::get_Active()  /*0x06000152*/
    IL_056f: brfalse.s IL_0583
    IL_0571: ldarg.0
    IL_0572: ldfld UnitCommandRadiusAnimation CommandUnits::rangeIndicator  /*0x04000DAE*/
    IL_0577: callvirt void UnitCommandRadiusAnimation::Deactivate()  /*0x06000155*/
    IL_057c: ldarg.0
    IL_057d: ldc.i4.0
    IL_057e: stfld bool CommandUnits::rangeIndicatorActive  /*0x04000DD5*/
    IL_0583: ldarg.0
    IL_0584: ldfld bool CommandUnits::commanding  /*0x04000DC5*/
    IL_0589: brfalse.s IL_0590
    IL_058b: ldnull
    IL_058c: stloc.1
    IL_058d: ldc.i4.0
    IL_058e: stloc.s 6
    IL_0590: ldloc.1
    IL_0591: ldloc.s 6
    IL_0593: ldloc.2
    IL_0594: call void UnitProductionSelector::CustomUpdate(UnitProductionSelector,bool,bool)  /*0x0600139B*/
    IL_0599: ret
    .try IL_034d-IL_0411 finally handler IL_0411-IL_041d

  .method CommandUnits::ControlGroupUpdate(bool)  // token 0x06000AF9 rva 0x33fd8 attrs Private, HideBySig
    // code size 464 (0x1d0), max stack 2, init locals
    IL_0000: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0005: callvirt bool LocalGamestate::get_PlayerFrozen()  /*0x060008FF*/
    IL_000a: brtrue IL_00db
    IL_000f: ldarg.0
    IL_0010: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_0015: ldstr "Select Group 1"
    IL_001a: callvirt bool Rewired.Player::GetButtonUp(string)  /*0x0A0000A3*/
    IL_001f: brfalse.s IL_0029
    IL_0021: ldarg.0
    IL_0022: ldc.i4.s 45
    IL_0024: call void CommandUnits::OnGroupButtonUp(TagManager.ETag)  /*0x06000AFA*/
    IL_0029: ldarg.0
    IL_002a: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_002f: ldstr "Select Group 2"
    IL_0034: callvirt bool Rewired.Player::GetButtonUp(string)  /*0x0A0000A3*/
    IL_0039: brfalse.s IL_0043
    IL_003b: ldarg.0
    IL_003c: ldc.i4.s 46
    IL_003e: call void CommandUnits::OnGroupButtonUp(TagManager.ETag)  /*0x06000AFA*/
    IL_0043: ldarg.0
    IL_0044: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_0049: ldstr "Select Group 3"
    IL_004e: callvirt bool Rewired.Player::GetButtonUp(string)  /*0x0A0000A3*/
    IL_0053: brfalse.s IL_005d
    IL_0055: ldarg.0
    IL_0056: ldc.i4.s 47
    IL_0058: call void CommandUnits::OnGroupButtonUp(TagManager.ETag)  /*0x06000AFA*/
    IL_005d: ldarg.0
    IL_005e: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_0063: ldstr "Clear All Control Groups"
    IL_0068: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_006d: brfalse.s IL_00a0
    IL_006f: ldarg.0
    IL_0070: ldfld Hp CommandUnits::hpPlayer  /*0x04000DC9*/
    IL_0075: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_007a: ldc.r4 0f
    IL_007f: ble.un.s IL_00a0
    IL_0081: ldarg.0
    IL_0082: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_0087: ldstr "Clear All Control Groups"
    IL_008c: callvirt double Rewired.Player::GetButtonTimePressed(string)  /*0x0A0004CB*/
    IL_0091: ldarg.0
    IL_0092: ldfld float CommandUnits::groupHoldDelay  /*0x04000DBD*/
    IL_0097: conv.r8
    IL_0098: ble.un.s IL_00a0
    IL_009a: ldarg.0
    IL_009b: call void CommandUnits::OnAllClearGroupButtonHold()  /*0x06000AFB*/
    IL_00a0: ldarg.0
    IL_00a1: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_00a6: ldstr "Clear All Control Groups"
    IL_00ab: callvirt bool Rewired.Player::GetButtonUp(string)  /*0x0A0000A3*/
    IL_00b0: brfalse.s IL_00db
    IL_00b2: ldarg.0
    IL_00b3: ldfld bool CommandUnits::switchedToSet  /*0x04000DCD*/
    IL_00b8: brtrue.s IL_00c9
    IL_00ba: ldsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_00bf: ldc.r4 1f
    IL_00c4: callvirt void ControlGroupUIHelper::SetFillAmountForAllGroups(float)  /*0x06000013*/
    IL_00c9: ldarg.0
    IL_00ca: ldc.r4 0f
    IL_00cf: stfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_00d4: ldarg.0
    IL_00d5: ldc.i4.0
    IL_00d6: stfld bool CommandUnits::switchedToSet  /*0x04000DCD*/
    IL_00db: ldarg.1
    IL_00dc: brfalse.s IL_00f0
    IL_00de: ldarg.0
    IL_00df: ldfld Hp CommandUnits::hpPlayer  /*0x04000DC9*/
    IL_00e4: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_00e9: ldc.r4 0f
    IL_00ee: bgt.s IL_00fb
    IL_00f0: ldarg.0
    IL_00f1: ldfld bool CommandUnits::commanding  /*0x04000DC5*/
    IL_00f6: brfalse IL_01cf
    IL_00fb: ldarg.0
    IL_00fc: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_0101: ldstr "Select Group 1"
    IL_0106: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_010b: brfalse.s IL_0142
    IL_010d: ldarg.0
    IL_010e: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_0113: ldstr "Select Group 1"
    IL_0118: callvirt double Rewired.Player::GetButtonTimePressed(string)  /*0x0A0004CB*/
    IL_011d: ldarg.0
    IL_011e: ldfld float CommandUnits::groupHoldDelay  /*0x04000DBD*/
    IL_0123: conv.r8
    IL_0124: ble.un.s IL_0130
    IL_0126: ldarg.0
    IL_0127: ldc.i4.s 45
    IL_0129: call void CommandUnits::OnGroupButtonHold(TagManager.ETag)  /*0x06000AFC*/
    IL_012e: br.s IL_0142
    IL_0130: ldarg.0
    IL_0131: ldc.r4 0f
    IL_0136: stfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_013b: ldarg.0
    IL_013c: ldc.i4.0
    IL_013d: stfld bool CommandUnits::switchedToSet  /*0x04000DCD*/
    IL_0142: ldarg.0
    IL_0143: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_0148: ldstr "Select Group 2"
    IL_014d: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_0152: brfalse.s IL_0189
    IL_0154: ldarg.0
    IL_0155: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_015a: ldstr "Select Group 2"
    IL_015f: callvirt double Rewired.Player::GetButtonTimePressed(string)  /*0x0A0004CB*/
    IL_0164: ldarg.0
    IL_0165: ldfld float CommandUnits::groupHoldDelay  /*0x04000DBD*/
    IL_016a: conv.r8
    IL_016b: ble.un.s IL_0177
    IL_016d: ldarg.0
    IL_016e: ldc.i4.s 46
    IL_0170: call void CommandUnits::OnGroupButtonHold(TagManager.ETag)  /*0x06000AFC*/
    IL_0175: br.s IL_0189
    IL_0177: ldarg.0
    IL_0178: ldc.r4 0f
    IL_017d: stfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_0182: ldarg.0
    IL_0183: ldc.i4.0
    IL_0184: stfld bool CommandUnits::switchedToSet  /*0x04000DCD*/
    IL_0189: ldarg.0
    IL_018a: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_018f: ldstr "Select Group 3"
    IL_0194: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_0199: brfalse.s IL_01cf
    IL_019b: ldarg.0
    IL_019c: ldfld Player CommandUnits::input  /*0x04000DC4*/
    IL_01a1: ldstr "Select Group 3"
    IL_01a6: callvirt double Rewired.Player::GetButtonTimePressed(string)  /*0x0A0004CB*/
    IL_01ab: ldarg.0
    IL_01ac: ldfld float CommandUnits::groupHoldDelay  /*0x04000DBD*/
    IL_01b1: conv.r8
    IL_01b2: ble.un.s IL_01bd
    IL_01b4: ldarg.0
    IL_01b5: ldc.i4.s 47
    IL_01b7: call void CommandUnits::OnGroupButtonHold(TagManager.ETag)  /*0x06000AFC*/
    IL_01bc: ret
    IL_01bd: ldarg.0
    IL_01be: ldc.r4 0f
    IL_01c3: stfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_01c8: ldarg.0
    IL_01c9: ldc.i4.0
    IL_01ca: stfld bool CommandUnits::switchedToSet  /*0x04000DCD*/
    IL_01cf: ret

  .method CommandUnits::OnGroupButtonUp(TagManager.ETag)  // token 0x06000AFA rva 0x341b4 attrs Private, HideBySig
    // code size 167 (0xa7), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Hp CommandUnits::hpPlayer  /*0x04000DC9*/
    IL_0006: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_000b: ldc.r4 0f
    IL_0010: ble.un IL_00a6
    IL_0015: ldarg.0
    IL_0016: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_001b: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_0020: ldarg.0
    IL_0021: ldfld List<TagManager.ETag> CommandUnits::mayNotHaveTags  /*0x04000DCF*/
    IL_0026: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_002b: ldarg.0
    IL_002c: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_0031: ldc.i4.7
    IL_0032: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0037: ldarg.0
    IL_0038: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_003d: ldarg.1
    IL_003e: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0043: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0048: ldarg.0
    IL_0049: ldfld List<TaggedObject> CommandUnits::results  /*0x04000DD0*/
    IL_004e: ldarg.0
    IL_004f: ldfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_0054: ldarg.0
    IL_0055: ldfld List<TagManager.ETag> CommandUnits::mayNotHaveTags  /*0x04000DCF*/
    IL_005a: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_005f: ldarg.0
    IL_0060: ldarg.0
    IL_0061: ldfld List<TaggedObject> CommandUnits::results  /*0x04000DD0*/
    IL_0066: call void CommandUnits::TryToSelectUnits(System.Collections.Generic.List<TaggedObject>)  /*0x06000B04*/
    IL_006b: ldarg.0
    IL_006c: ldc.r4 0f
    IL_0071: stfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_0076: ldarg.0
    IL_0077: ldc.i4.0
    IL_0078: stfld bool CommandUnits::switchedToSet  /*0x04000DCD*/
    IL_007d: ldsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_0082: ldarg.1
    IL_0083: callvirt bool ControlGroupUIHelper::GroupHasUnits(TagManager.ETag)  /*0x0600000D*/
    IL_0088: brfalse.s IL_009b
    IL_008a: ldsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_008f: ldarg.1
    IL_0090: ldc.r4 1f
    IL_0095: callvirt void ControlGroupUIHelper::SetFillAmount(TagManager.ETag,float)  /*0x06000014*/
    IL_009a: ret
    IL_009b: ldsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_00a0: ldarg.1
    IL_00a1: callvirt void ControlGroupUIHelper::HideFlag(TagManager.ETag)  /*0x06000010*/
    IL_00a6: ret

  .method CommandUnits::OnAllClearGroupButtonHold()  // token 0x06000AFB rva 0x34268 attrs Private, HideBySig
    // code size 186 (0xba), max stack 4, init locals
    IL_0000: ldsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_0005: ldc.i4.s 45
    IL_0007: callvirt bool ControlGroupUIHelper::GroupHasUnits(TagManager.ETag)  /*0x0600000D*/
    IL_000c: brtrue.s IL_002b
    IL_000e: ldsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_0013: ldc.i4.s 46
    IL_0015: callvirt bool ControlGroupUIHelper::GroupHasUnits(TagManager.ETag)  /*0x0600000D*/
    IL_001a: brtrue.s IL_002b
    IL_001c: ldsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_0021: ldc.i4.s 47
    IL_0023: callvirt bool ControlGroupUIHelper::GroupHasUnits(TagManager.ETag)  /*0x0600000D*/
    IL_0028: brtrue.s IL_002b
    IL_002a: ret
    IL_002b: ldarg.0
    IL_002c: ldfld bool CommandUnits::switchedToSet  /*0x04000DCD*/
    IL_0031: brtrue.s IL_0040
    IL_0033: ldarg.0
    IL_0034: ldfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_0039: ldc.r4 0f
    IL_003e: pop
    IL_003f: pop
    IL_0040: ldarg.0
    IL_0041: ldarg.0
    IL_0042: ldfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_0047: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_004c: add
    IL_004d: stfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_0052: ldsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_0057: ldc.r4 1f
    IL_005c: ldarg.0
    IL_005d: ldfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_0062: ldarg.0
    IL_0063: ldfld float CommandUnits::holdToSetUnitGroup  /*0x04000DB9*/
    IL_0068: div
    IL_0069: sub
    IL_006a: callvirt void ControlGroupUIHelper::SetFillAmountForAllGroups(float)  /*0x06000013*/
    IL_006f: ldsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_0074: ldc.r4 1f
    IL_0079: ldarg.0
    IL_007a: ldfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_007f: ldarg.0
    IL_0080: ldfld float CommandUnits::holdToSetUnitGroup  /*0x04000DB9*/
    IL_0085: div
    IL_0086: sub
    IL_0087: callvirt void ControlGroupUIHelper::PlayHoldingSFX(float)  /*0x06000015*/
    IL_008c: ldarg.0
    IL_008d: ldfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_0092: ldarg.0
    IL_0093: ldfld float CommandUnits::holdToSetUnitGroup  /*0x04000DB9*/
    IL_0098: ble.un.s IL_00b9
    IL_009a: ldarg.0
    IL_009b: ldfld bool CommandUnits::switchedToSet  /*0x04000DCD*/
    IL_00a0: brtrue.s IL_00b9
    IL_00a2: ldarg.0
    IL_00a3: call void CommandUnits::RemoveAllUnitsfromAllGroups()  /*0x06000AFE*/
    IL_00a8: ldsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_00ad: callvirt void ControlGroupUIHelper::RemovingPulseAllGroups()  /*0x06000011*/
    IL_00b2: ldarg.0
    IL_00b3: ldc.i4.1
    IL_00b4: stfld bool CommandUnits::switchedToSet  /*0x04000DCD*/
    IL_00b9: ret

  .method CommandUnits::OnGroupButtonHold(TagManager.ETag)  // token 0x06000AFC rva 0x34330 attrs Private, HideBySig
    // code size 145 (0x91), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool CommandUnits::switchedToSet  /*0x04000DCD*/
    IL_0006: brtrue.s IL_0020
    IL_0008: ldarg.0
    IL_0009: ldfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_000e: ldc.r4 0f
    IL_0013: bne.un.s IL_0020
    IL_0015: ldsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_001a: ldarg.1
    IL_001b: callvirt void ControlGroupUIHelper::ShowFlag(TagManager.ETag)  /*0x0600000F*/
    IL_0020: ldarg.0
    IL_0021: ldarg.0
    IL_0022: ldfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_0027: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_002c: add
    IL_002d: stfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_0032: ldsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_0037: ldarg.1
    IL_0038: ldarg.0
    IL_0039: ldfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_003e: ldarg.0
    IL_003f: ldfld float CommandUnits::holdToSetUnitGroup  /*0x04000DB9*/
    IL_0044: div
    IL_0045: callvirt void ControlGroupUIHelper::SetFillAmount(TagManager.ETag,float)  /*0x06000014*/
    IL_004a: ldsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_004f: ldarg.0
    IL_0050: ldfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_0055: ldarg.0
    IL_0056: ldfld float CommandUnits::holdToSetUnitGroup  /*0x04000DB9*/
    IL_005b: div
    IL_005c: callvirt void ControlGroupUIHelper::PlayHoldingSFX(float)  /*0x06000015*/
    IL_0061: ldarg.0
    IL_0062: ldfld float CommandUnits::timeSinceSet  /*0x04000DCB*/
    IL_0067: ldarg.0
    IL_0068: ldfld float CommandUnits::holdToSetUnitGroup  /*0x04000DB9*/
    IL_006d: ble.un.s IL_0090
    IL_006f: ldarg.0
    IL_0070: ldfld bool CommandUnits::switchedToSet  /*0x04000DCD*/
    IL_0075: brtrue.s IL_0090
    IL_0077: ldarg.0
    IL_0078: ldarg.1
    IL_0079: call void CommandUnits::AddUnitsToGroup(TagManager.ETag)  /*0x06000AFD*/
    IL_007e: ldsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_0083: ldarg.1
    IL_0084: callvirt void ControlGroupUIHelper::OnGroupSet(TagManager.ETag)  /*0x06000012*/
    IL_0089: ldarg.0
    IL_008a: ldc.i4.1
    IL_008b: stfld bool CommandUnits::switchedToSet  /*0x04000DCD*/
    IL_0090: ret

  .method CommandUnits::AddUnitsToGroup(TagManager.ETag)  // token 0x06000AFD rva 0x343d0 attrs Public, HideBySig
    // code size 151 (0x97), max stack 2, init locals
    .locals ([0] List<TaggedObject>, [1] List.Enumerator<PathfindMovementPlayerunit>, [2] TaggedObject, [3] IEnumerator<TaggedObject>, [4] TaggedObject)
    IL_0000: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0005: stloc.0
    IL_0006: ldarg.0
    IL_0007: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_000c: callvirt List.Enumerator<!0> System.Collections.Generic.List<PathfindMovementPlayerunit>::GetEnumerator()  /*0x0A000057*/
    IL_0011: stloc.1
    IL_0012: br.s IL_003d
    IL_0014: ldloca.s 1
    IL_0016: call !0 System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>::get_Current()  /*0x0A000058*/
    IL_001b: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0020: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_0025: stloc.2
    IL_0026: ldloc.2
    IL_0027: ldnull
    IL_0028: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002d: brfalse.s IL_003d
    IL_002f: ldloc.0
    IL_0030: ldloc.2
    IL_0031: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_0036: ldloc.2
    IL_0037: ldarg.1
    IL_0038: callvirt void TaggedObject::AddUnitGroupTag(TagManager.ETag)  /*0x06000E4D*/
    IL_003d: ldloca.s 1
    IL_003f: call bool System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>::MoveNext()  /*0x0A00005A*/
    IL_0044: brtrue.s IL_0014
    IL_0046: leave.s IL_0056
    IL_0048: ldloca.s 1
    IL_004a: constrained. System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>  /*0x1B00000D*/
    IL_0050: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0055: endfinally
    IL_0056: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_005b: callvirt IReadOnlyList<TaggedObject> TagManager::get_PlayerUnits()  /*0x06000E52*/
    IL_0060: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<TaggedObject>::GetEnumerator()  /*0x0A000100*/
    IL_0065: stloc.3
    IL_0066: br.s IL_0082
    IL_0068: ldloc.3
    IL_0069: callvirt !0 System.Collections.Generic.IEnumerator<TaggedObject>::get_Current()  /*0x0A000101*/
    IL_006e: stloc.s 4
    IL_0070: ldloc.0
    IL_0071: ldloc.s 4
    IL_0073: callvirt bool System.Collections.Generic.List<TaggedObject>::Contains(!0)  /*0x0A00021D*/
    IL_0078: brtrue.s IL_0082
    IL_007a: ldloc.s 4
    IL_007c: ldarg.1
    IL_007d: callvirt void TaggedObject::RemoveUnitGroupTag(TagManager.ETag)  /*0x06000E4E*/
    IL_0082: ldloc.3
    IL_0083: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0088: brtrue.s IL_0068
    IL_008a: leave.s IL_0096
    IL_008c: ldloc.3
    IL_008d: brfalse.s IL_0095
    IL_008f: ldloc.3
    IL_0090: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0095: endfinally
    IL_0096: ret
    .try IL_0012-IL_0048 finally handler IL_0048-IL_0056
    .try IL_0066-IL_008c finally handler IL_008c-IL_0096

  .method CommandUnits::RemoveAllUnitsfromAllGroups()  // token 0x06000AFE rva 0x34490 attrs Private, HideBySig
    // code size 142 (0x8e), max stack 2, init locals
    .locals ([0] List<TagManager.ETag>, [1] IEnumerator<TaggedObject>, [2] TaggedObject, [3] List.Enumerator<TagManager.ETag>, [4] TagManager.ETag)
    IL_0000: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldc.i4.s 45
    IL_0009: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_000e: ldloc.0
    IL_000f: ldc.i4.s 46
    IL_0011: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0016: ldloc.0
    IL_0017: ldc.i4.s 47
    IL_0019: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_001e: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0023: callvirt IReadOnlyList<TaggedObject> TagManager::get_PlayerUnits()  /*0x06000E52*/
    IL_0028: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<TaggedObject>::GetEnumerator()  /*0x0A000100*/
    IL_002d: stloc.1
    IL_002e: br.s IL_0079
    IL_0030: ldloc.1
    IL_0031: callvirt !0 System.Collections.Generic.IEnumerator<TaggedObject>::get_Current()  /*0x0A000101*/
    IL_0036: stloc.2
    IL_0037: ldloc.0
    IL_0038: callvirt List.Enumerator<!0> System.Collections.Generic.List<TagManager.ETag>::GetEnumerator()  /*0x0A0001D3*/
    IL_003d: stloc.3
    IL_003e: br.s IL_0060
    IL_0040: ldloca.s 3
    IL_0042: call !0 System.Collections.Generic.List.Enumerator<TagManager.ETag>::get_Current()  /*0x0A0001D4*/
    IL_0047: stloc.s 4
    IL_0049: ldloc.2
    IL_004a: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_004f: ldloc.s 4
    IL_0051: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0056: brfalse.s IL_0060
    IL_0058: ldloc.2
    IL_0059: ldloc.s 4
    IL_005b: callvirt void TaggedObject::RemoveUnitGroupTag(TagManager.ETag)  /*0x06000E4E*/
    IL_0060: ldloca.s 3
    IL_0062: call bool System.Collections.Generic.List.Enumerator<TagManager.ETag>::MoveNext()  /*0x0A0001D5*/
    IL_0067: brtrue.s IL_0040
    IL_0069: leave.s IL_0079
    IL_006b: ldloca.s 3
    IL_006d: constrained. System.Collections.Generic.List.Enumerator<TagManager.ETag>  /*0x1B000041*/
    IL_0073: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0078: endfinally
    IL_0079: ldloc.1
    IL_007a: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_007f: brtrue.s IL_0030
    IL_0081: leave.s IL_008d
    IL_0083: ldloc.1
    IL_0084: brfalse.s IL_008c
    IL_0086: ldloc.1
    IL_0087: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_008c: endfinally
    IL_008d: ret
    .try IL_003e-IL_006b finally handler IL_006b-IL_0079
    .try IL_002e-IL_0083 finally handler IL_0083-IL_008d

  .method CommandUnits::MakeUnitsInBufferHoldPosition()  // token 0x06000AFF rva 0x34548 attrs Public, HideBySig
    // code size 135 (0x87), max stack 8, init locals
    .locals ([0] Vector3, [1] List.Enumerator<PathfindMovementPlayerunit>)
    IL_0000: ldarg.0
    IL_0001: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommandingBuffer  /*0x04000DC3*/
    IL_0006: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_000b: ldc.i4.0
    IL_000c: ble.s IL_0052
    IL_000e: ldarg.0
    IL_000f: ldfld ThronefallAudioManager CommandUnits::audioManager  /*0x04000DBE*/
    IL_0014: ldarg.0
    IL_0015: ldfld AudioSet CommandUnits::audioSet  /*0x04000DBF*/
    IL_001a: callvirt AudioSet.ClipArray AudioSet::get_HoldPosition()  /*0x060001D5*/
    IL_001f: ldc.r4 0.45f
    IL_0024: ldc.r4 0.9f
    IL_0029: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_002e: ldc.r4 0.2f
    IL_0033: mul
    IL_0034: add
    IL_0035: ldarg.0
    IL_0036: ldfld ThronefallAudioManager CommandUnits::audioManager  /*0x04000DBE*/
    IL_003b: ldfld AudioMixerGroup ThronefallAudioManager::mgSFX  /*0x04000280*/
    IL_0040: ldc.i4.s 10
    IL_0042: ldc.i4.0
    IL_0043: ldloca.s 0
    IL_0045: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_004b: ldloc.0
    IL_004c: callvirt ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_0051: pop
    IL_0052: ldarg.0
    IL_0053: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommandingBuffer  /*0x04000DC3*/
    IL_0058: callvirt List.Enumerator<!0> System.Collections.Generic.List<PathfindMovementPlayerunit>::GetEnumerator()  /*0x0A000057*/
    IL_005d: stloc.1
    IL_005e: br.s IL_006d
    IL_0060: ldloca.s 1
    IL_0062: call !0 System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>::get_Current()  /*0x0A000058*/
    IL_0067: ldc.i4.1
    IL_0068: callvirt void PathfindMovementPlayerunit::set_HoldPosition(bool)  /*0x06000B34*/
    IL_006d: ldloca.s 1
    IL_006f: call bool System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>::MoveNext()  /*0x0A00005A*/
    IL_0074: brtrue.s IL_0060
    IL_0076: leave.s IL_0086
    IL_0078: ldloca.s 1
    IL_007a: constrained. System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>  /*0x1B00000D*/
    IL_0080: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0085: endfinally
    IL_0086: ret
    .try IL_005e-IL_0078 finally handler IL_0078-IL_0086

  .method CommandUnits::ForceCommandingEnd()  // token 0x06000B00 rva 0x345ec attrs Public, HideBySig
    // code size 16 (0x10), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool CommandUnits::commanding  /*0x04000DC5*/
    IL_0006: brfalse.s IL_000f
    IL_0008: ldarg.0
    IL_0009: ldc.i4.0
    IL_000a: call void CommandUnits::PlaceCommandedUnitsAndCalculateTargetPositions(bool)  /*0x06000B01*/
    IL_000f: ret

  .method CommandUnits::PlaceCommandedUnitsAndCalculateTargetPositions(bool)  // token 0x06000B01 rva 0x34600 attrs Public, HideBySig
    // code size 1077 (0x435), max stack 8, init locals
    .locals ([0] string, [1] Vector3, [2] List.Enumerator<PathfindMovementPlayerunit>, [3] PathfindMovementPlayerunit, [4] PathfindMovementPlayerunit, [5] int, [6] AutoAttack, [7] int, [8] PathfindMovementPlayerunit, [9] Vector3, [10] int, [11] bool, [12] int, [13] PathfindMovementPlayerunit, [14] int, [15] PathfindMovementPlayerunit, [16] Vector3, [17] PathfindMovementPlayerunit)
    IL_0000: ldarg.0
    IL_0001: ldfld bool CommandUnits::commanding  /*0x04000DC5*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_000f: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_0014: ldc.i4.0
    IL_0015: bgt.s IL_0018
    IL_0017: ret
    IL_0018: ldarg.0
    IL_0019: ldc.i4.0
    IL_001a: stfld bool CommandUnits::commandUnitsToggledOn  /*0x04000DD1*/
    IL_001f: ldarg.0
    IL_0020: ldfld ThronefallAudioManager CommandUnits::audioManager  /*0x04000DBE*/
    IL_0025: ldarg.0
    IL_0026: ldfld AudioSet CommandUnits::audioSet  /*0x04000DBF*/
    IL_002b: callvirt AudioSet.ClipArray AudioSet::get_PlaceCommandingUnits()  /*0x060001D4*/
    IL_0030: ldc.r4 0.35f
    IL_0035: ldc.r4 0.9f
    IL_003a: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_003f: ldc.r4 0.2f
    IL_0044: mul
    IL_0045: add
    IL_0046: ldarg.0
    IL_0047: ldfld ThronefallAudioManager CommandUnits::audioManager  /*0x04000DBE*/
    IL_004c: ldfld AudioMixerGroup ThronefallAudioManager::mgSFX  /*0x04000280*/
    IL_0051: ldc.i4.s 10
    IL_0053: ldc.i4.0
    IL_0054: ldloca.s 1
    IL_0056: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_005c: ldloc.1
    IL_005d: callvirt ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_0062: pop
    IL_0063: ldarg.0
    IL_0064: ldfld ParticleSystem CommandUnits::dropWaypointFx  /*0x04000DB0*/
    IL_0069: ldarg.0
    IL_006a: ldfld int CommandUnits::drowWaypointParticleCount  /*0x04000DB1*/
    IL_006f: callvirt void UnityEngine.ParticleSystem::Emit(int)  /*0x0A0004CC*/
    IL_0074: ldarg.0
    IL_0075: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_007a: ldc.i4.0
    IL_007b: callvirt !0 System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Item(int)  /*0x0A0004C9*/
    IL_0080: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0085: stloc.0
    IL_0086: ldarg.0
    IL_0087: ldfld List<PathfindMovementPlayerunit> CommandUnits::toBePlaced  /*0x04000DD7*/
    IL_008c: callvirt void System.Collections.Generic.List<PathfindMovementPlayerunit>::Clear()  /*0x0A0004CD*/
    IL_0091: ldarg.0
    IL_0092: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_0097: callvirt List.Enumerator<!0> System.Collections.Generic.List<PathfindMovementPlayerunit>::GetEnumerator()  /*0x0A000057*/
    IL_009c: stloc.2
    IL_009d: br.s IL_00c4
    IL_009f: ldloca.s 2
    IL_00a1: call !0 System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>::get_Current()  /*0x0A000058*/
    IL_00a6: stloc.3
    IL_00a7: ldarg.1
    IL_00a8: brfalse.s IL_00b8
    IL_00aa: ldloc.3
    IL_00ab: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_00b0: ldloc.0
    IL_00b1: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_00b6: brfalse.s IL_00c4
    IL_00b8: ldarg.0
    IL_00b9: ldfld List<PathfindMovementPlayerunit> CommandUnits::toBePlaced  /*0x04000DD7*/
    IL_00be: ldloc.3
    IL_00bf: callvirt void System.Collections.Generic.List<PathfindMovementPlayerunit>::Add(!0)  /*0x0A0004CE*/
    IL_00c4: ldloca.s 2
    IL_00c6: call bool System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>::MoveNext()  /*0x0A00005A*/
    IL_00cb: brtrue.s IL_009f
    IL_00cd: leave.s IL_00dd
    IL_00cf: ldloca.s 2
    IL_00d1: constrained. System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>  /*0x1B00000D*/
    IL_00d7: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00dc: endfinally
    IL_00dd: ldarg.0
    IL_00de: ldfld List<PathfindMovementPlayerunit> CommandUnits::toBePlaced  /*0x04000DD7*/
    IL_00e3: callvirt List.Enumerator<!0> System.Collections.Generic.List<PathfindMovementPlayerunit>::GetEnumerator()  /*0x0A000057*/
    IL_00e8: stloc.2
    IL_00e9: br.s IL_010a
    IL_00eb: ldloca.s 2
    IL_00ed: call !0 System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>::get_Current()  /*0x0A000058*/
    IL_00f2: stloc.s 4
    IL_00f4: ldarg.0
    IL_00f5: ldloc.s 4
    IL_00f7: call void CommandUnits::OnUnitRemove(PathfindMovementPlayerunit)  /*0x06000B03*/
    IL_00fc: ldarg.0
    IL_00fd: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_0102: ldloc.s 4
    IL_0104: callvirt bool System.Collections.Generic.List<PathfindMovementPlayerunit>::Remove(!0)  /*0x0A0004CF*/
    IL_0109: pop
    IL_010a: ldloca.s 2
    IL_010c: call bool System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>::MoveNext()  /*0x0A00005A*/
    IL_0111: brtrue.s IL_00eb
    IL_0113: leave.s IL_0123
    IL_0115: ldloca.s 2
    IL_0117: constrained. System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>  /*0x1B00000D*/
    IL_011d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0122: endfinally
    IL_0123: ldarg.0
    IL_0124: ldfld List<AutoAttack> CommandUnits::autoAttacksToEnable  /*0x04000DD8*/
    IL_0129: callvirt int System.Collections.Generic.List<AutoAttack>::get_Count()  /*0x0A0004D0*/
    IL_012e: ldc.i4.1
    IL_012f: sub
    IL_0130: stloc.s 5
    IL_0132: br.s IL_0192
    IL_0134: ldarg.0
    IL_0135: ldfld List<AutoAttack> CommandUnits::autoAttacksToEnable  /*0x04000DD8*/
    IL_013a: ldloc.s 5
    IL_013c: callvirt !0 System.Collections.Generic.List<AutoAttack>::get_Item(int)  /*0x0A0004D1*/
    IL_0141: stloc.s 6
    IL_0143: ldloc.s 6
    IL_0145: ldnull
    IL_0146: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_014b: brfalse.s IL_018c
    IL_014d: ldarg.1
    IL_014e: brfalse.s IL_0164
    IL_0150: ldloc.s 6
    IL_0152: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0157: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_015c: ldloc.0
    IL_015d: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0162: brfalse.s IL_018c
    IL_0164: ldloc.s 6
    IL_0166: callvirt !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_016b: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0170: ldc.r4 0f
    IL_0175: ble.un.s IL_018c
    IL_0177: ldloc.s 6
    IL_0179: ldc.i4.1
    IL_017a: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_017f: ldarg.0
    IL_0180: ldfld List<AutoAttack> CommandUnits::autoAttacksToEnable  /*0x04000DD8*/
    IL_0185: ldloc.s 5
    IL_0187: callvirt void System.Collections.Generic.List<AutoAttack>::RemoveAt(int)  /*0x0A0004D2*/
    IL_018c: ldloc.s 5
    IL_018e: ldc.i4.1
    IL_018f: sub
    IL_0190: stloc.s 5
    IL_0192: ldloc.s 5
    IL_0194: ldc.i4.0
    IL_0195: bge.s IL_0134
    IL_0197: ldc.i4.0
    IL_0198: stloc.s 7
    IL_019a: br IL_0264
    IL_019f: ldarg.0
    IL_01a0: ldfld List<PathfindMovementPlayerunit> CommandUnits::toBePlaced  /*0x04000DD7*/
    IL_01a5: ldloc.s 7
    IL_01a7: callvirt !0 System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Item(int)  /*0x0A0004C9*/
    IL_01ac: stloc.s 8
    IL_01ae: ldloc.s 7
    IL_01b0: ldarg.0
    IL_01b1: ldfld List<PathfindMovementPlayerunit> CommandUnits::toBePlaced  /*0x04000DD7*/
    IL_01b6: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_01bb: div
    IL_01bc: conv.r4
    IL_01bd: ldc.r4 360f
    IL_01c2: mul
    IL_01c3: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_01c8: call Quaternion UnityEngine.Quaternion::AngleAxis(float,UnityEngine.Vector3)  /*0x0A0004D3*/
    IL_01cd: call Vector3 UnityEngine.Vector3::get_right()  /*0x0A0004D4*/
    IL_01d2: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_01d7: ldarg.0
    IL_01d8: ldfld float CommandUnits::unitDistanceMoveStep  /*0x04000DB6*/
    IL_01dd: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_01e2: stloc.s 9
    IL_01e4: ldloc.s 8
    IL_01e6: ldarg.0
    IL_01e7: ldfld AstarPath CommandUnits::astarPath  /*0x04000DC7*/
    IL_01ec: ldarg.0
    IL_01ed: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01f2: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01f7: ldloc.s 9
    IL_01f9: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_01fe: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0203: ldc.r4 0.5f
    IL_0208: sub
    IL_0209: ldc.r4 0f
    IL_020e: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0213: ldc.r4 0.5f
    IL_0218: sub
    IL_0219: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_021e: ldarg.0
    IL_021f: ldfld float CommandUnits::unitDistanceMoveStep  /*0x04000DB6*/
    IL_0224: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0229: ldc.r4 0.1f
    IL_022e: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0233: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0238: ldloc.s 8
    IL_023a: callvirt bool PathfindMovementPlayerunit::get_Flying()  /*0x06000B32*/
    IL_023f: brtrue.s IL_0249
    IL_0241: ldarg.0
    IL_0242: ldfld NNConstraint CommandUnits::nearestConstraint  /*0x04000DC0*/
    IL_0247: br.s IL_024f
    IL_0249: ldarg.0
    IL_024a: ldfld NNConstraint CommandUnits::nearestConstraintAir  /*0x04000DC1*/
    IL_024f: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_0254: ldfld Vector3 Pathfinding.NNInfo::position  /*0x0A00028D*/
    IL_0259: callvirt void PathfindMovementPlayerunit::set_HomePosition(UnityEngine.Vector3)  /*0x06000B2B*/
    IL_025e: ldloc.s 7
    IL_0260: ldc.i4.1
    IL_0261: add
    IL_0262: stloc.s 7
    IL_0264: ldloc.s 7
    IL_0266: ldarg.0
    IL_0267: ldfld List<PathfindMovementPlayerunit> CommandUnits::toBePlaced  /*0x04000DD7*/
    IL_026c: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_0271: blt IL_019f
    IL_0276: ldc.i4.0
    IL_0277: stloc.s 10
    IL_0279: br IL_03b5
    IL_027e: ldc.i4.0
    IL_027f: stloc.s 11
    IL_0281: ldc.i4.0
    IL_0282: stloc.s 12
    IL_0284: br IL_0399
    IL_0289: ldarg.0
    IL_028a: ldfld List<PathfindMovementPlayerunit> CommandUnits::toBePlaced  /*0x04000DD7*/
    IL_028f: ldloc.s 12
    IL_0291: callvirt !0 System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Item(int)  /*0x0A0004C9*/
    IL_0296: stloc.s 13
    IL_0298: ldloc.s 12
    IL_029a: ldc.i4.1
    IL_029b: add
    IL_029c: stloc.s 14
    IL_029e: br IL_0381
    IL_02a3: ldarg.0
    IL_02a4: ldfld List<PathfindMovementPlayerunit> CommandUnits::toBePlaced  /*0x04000DD7*/
    IL_02a9: ldloc.s 14
    IL_02ab: callvirt !0 System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Item(int)  /*0x0A0004C9*/
    IL_02b0: stloc.s 15
    IL_02b2: ldloc.s 13
    IL_02b4: callvirt Vector3 PathfindMovementPlayerunit::get_HomePosition()  /*0x06000B2A*/
    IL_02b9: ldloc.s 15
    IL_02bb: callvirt Vector3 PathfindMovementPlayerunit::get_HomePosition()  /*0x06000B2A*/
    IL_02c0: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_02c5: stloc.1
    IL_02c6: ldloca.s 1
    IL_02c8: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_02cd: ldarg.0
    IL_02ce: ldfld float CommandUnits::unitDistanceFromEachOther  /*0x04000DB5*/
    IL_02d3: bgt IL_037b
    IL_02d8: ldloc.s 13
    IL_02da: callvirt Vector3 PathfindMovementPlayerunit::get_HomePosition()  /*0x06000B2A*/
    IL_02df: ldloc.s 15
    IL_02e1: callvirt Vector3 PathfindMovementPlayerunit::get_HomePosition()  /*0x06000B2A*/
    IL_02e6: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_02eb: stloc.1
    IL_02ec: ldloca.s 1
    IL_02ee: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_02f3: ldarg.0
    IL_02f4: ldfld float CommandUnits::unitDistanceMoveStep  /*0x04000DB6*/
    IL_02f9: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_02fe: stloc.s 16
    IL_0300: ldloc.s 13
    IL_0302: ldarg.0
    IL_0303: ldfld AstarPath CommandUnits::astarPath  /*0x04000DC7*/
    IL_0308: ldloc.s 13
    IL_030a: callvirt Vector3 PathfindMovementPlayerunit::get_HomePosition()  /*0x06000B2A*/
    IL_030f: ldloc.s 16
    IL_0311: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0316: ldloc.s 13
    IL_0318: callvirt bool PathfindMovementPlayerunit::get_Flying()  /*0x06000B32*/
    IL_031d: brtrue.s IL_0327
    IL_031f: ldarg.0
    IL_0320: ldfld NNConstraint CommandUnits::nearestConstraint  /*0x04000DC0*/
    IL_0325: br.s IL_032d
    IL_0327: ldarg.0
    IL_0328: ldfld NNConstraint CommandUnits::nearestConstraintAir  /*0x04000DC1*/
    IL_032d: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_0332: ldfld Vector3 Pathfinding.NNInfo::position  /*0x0A00028D*/
    IL_0337: callvirt void PathfindMovementPlayerunit::set_HomePosition(UnityEngine.Vector3)  /*0x06000B2B*/
    IL_033c: ldloc.s 15
    IL_033e: ldarg.0
    IL_033f: ldfld AstarPath CommandUnits::astarPath  /*0x04000DC7*/
    IL_0344: ldloc.s 15
    IL_0346: callvirt Vector3 PathfindMovementPlayerunit::get_HomePosition()  /*0x06000B2A*/
    IL_034b: ldloc.s 16
    IL_034d: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0352: ldloc.s 15
    IL_0354: callvirt bool PathfindMovementPlayerunit::get_Flying()  /*0x06000B32*/
    IL_0359: brtrue.s IL_0363
    IL_035b: ldarg.0
    IL_035c: ldfld NNConstraint CommandUnits::nearestConstraint  /*0x04000DC0*/
    IL_0361: br.s IL_0369
    IL_0363: ldarg.0
    IL_0364: ldfld NNConstraint CommandUnits::nearestConstraintAir  /*0x04000DC1*/
    IL_0369: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_036e: ldfld Vector3 Pathfinding.NNInfo::position  /*0x0A00028D*/
    IL_0373: callvirt void PathfindMovementPlayerunit::set_HomePosition(UnityEngine.Vector3)  /*0x06000B2B*/
    IL_0378: ldc.i4.1
    IL_0379: stloc.s 11
    IL_037b: ldloc.s 14
    IL_037d: ldc.i4.1
    IL_037e: add
    IL_037f: stloc.s 14
    IL_0381: ldloc.s 14
    IL_0383: ldarg.0
    IL_0384: ldfld List<PathfindMovementPlayerunit> CommandUnits::toBePlaced  /*0x04000DD7*/
    IL_0389: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_038e: blt IL_02a3
    IL_0393: ldloc.s 12
    IL_0395: ldc.i4.1
    IL_0396: add
    IL_0397: stloc.s 12
    IL_0399: ldloc.s 12
    IL_039b: ldarg.0
    IL_039c: ldfld List<PathfindMovementPlayerunit> CommandUnits::toBePlaced  /*0x04000DD7*/
    IL_03a1: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_03a6: blt IL_0289
    IL_03ab: ldloc.s 11
    IL_03ad: brfalse.s IL_03c2
    IL_03af: ldloc.s 10
    IL_03b1: ldc.i4.1
    IL_03b2: add
    IL_03b3: stloc.s 10
    IL_03b5: ldloc.s 10
    IL_03b7: ldarg.0
    IL_03b8: ldfld int CommandUnits::maxPositioningRepeats  /*0x04000DB7*/
    IL_03bd: blt IL_027e
    IL_03c2: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_03c7: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_03cc: brtrue.s IL_0418
    IL_03ce: ldarg.0
    IL_03cf: ldfld List<PathfindMovementPlayerunit> CommandUnits::toBePlaced  /*0x04000DD7*/
    IL_03d4: callvirt List.Enumerator<!0> System.Collections.Generic.List<PathfindMovementPlayerunit>::GetEnumerator()  /*0x0A000057*/
    IL_03d9: stloc.2
    IL_03da: br.s IL_03ff
    IL_03dc: ldloca.s 2
    IL_03de: call !0 System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>::get_Current()  /*0x0A000058*/
    IL_03e3: stloc.s 17
    IL_03e5: ldloc.s 17
    IL_03e7: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_03ec: ldloc.s 17
    IL_03ee: callvirt Vector3 PathfindMovementPlayerunit::get_HomePosition()  /*0x06000B2A*/
    IL_03f3: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_03f8: ldloc.s 17
    IL_03fa: callvirt void PathfindMovement::ClearCurrentPath()  /*0x06000B06*/
    IL_03ff: ldloca.s 2
    IL_0401: call bool System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>::MoveNext()  /*0x0A00005A*/
    IL_0406: brtrue.s IL_03dc
    IL_0408: leave.s IL_0418
    IL_040a: ldloca.s 2
    IL_040c: constrained. System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>  /*0x1B00000D*/
    IL_0412: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0417: endfinally
    IL_0418: ldarg.0
    IL_0419: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommandingBuffer  /*0x04000DC3*/
    IL_041e: callvirt void System.Collections.Generic.List<PathfindMovementPlayerunit>::Clear()  /*0x0A0004CD*/
    IL_0423: ldarg.0
    IL_0424: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommandingBuffer  /*0x04000DC3*/
    IL_0429: ldarg.0
    IL_042a: ldfld List<PathfindMovementPlayerunit> CommandUnits::toBePlaced  /*0x04000DD7*/
    IL_042f: callvirt void System.Collections.Generic.List<PathfindMovementPlayerunit>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0004D5*/
    IL_0434: ret
    .try IL_009d-IL_00cf finally handler IL_00cf-IL_00dd
    .try IL_00e9-IL_0115 finally handler IL_0115-IL_0123
    .try IL_03da-IL_040a finally handler IL_040a-IL_0418

  .method CommandUnits::OnUnitAdd(TaggedObject,bool)  // token 0x06000B02 rva 0x34a6c attrs Public, HideBySig
    // code size 388 (0x184), max stack 8, init locals
    .locals ([0] PathfindMovementPlayerunit, [1] MaterialFlasherFX, [2] UnitTypeDisplay, [3] Vector3, [4] AutoAttack[], [5] int, [6] AutoAttack)
    IL_0000: ldarg.1
    IL_0001: ldnull
    IL_0002: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0007: brfalse.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.1
    IL_000b: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0010: ldnull
    IL_0011: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0016: brfalse.s IL_0019
    IL_0018: ret
    IL_0019: ldarg.1
    IL_001a: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_001f: callvirt bool Hp::get_Alive()  /*0x0600081D*/
    IL_0024: brtrue.s IL_0027
    IL_0026: ret
    IL_0027: ldarg.0
    IL_0028: ldfld bool CommandUnits::canCommandUnitsInThisMode  /*0x04000DD2*/
    IL_002d: brtrue.s IL_0030
    IL_002f: ret
    IL_0030: ldarg.1
    IL_0031: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0036: callvirt PathfindMovement Hp::get_PathfindMovement()  /*0x06000818*/
    IL_003b: castclass PathfindMovementPlayerunit  /*0x02000210*/
    IL_0040: stloc.0
    IL_0041: ldarg.0
    IL_0042: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_0047: ldloc.0
    IL_0048: callvirt bool System.Collections.Generic.List<PathfindMovementPlayerunit>::Contains(!0)  /*0x0A0004D6*/
    IL_004d: brfalse.s IL_0050
    IL_004f: ret
    IL_0050: ldarg.2
    IL_0051: brfalse.s IL_0080
    IL_0053: ldarg.0
    IL_0054: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_0059: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_005e: ldc.i4.0
    IL_005f: ble.s IL_0080
    IL_0061: ldarg.0
    IL_0062: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_0067: ldc.i4.0
    IL_0068: callvirt !0 System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Item(int)  /*0x0A0004C9*/
    IL_006d: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0072: ldarg.1
    IL_0073: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0078: call bool System.String::op_Inequality(string,string)  /*0x0A00002D*/
    IL_007d: brfalse.s IL_0080
    IL_007f: ret
    IL_0080: ldarg.0
    IL_0081: ldfld ThronefallAudioManager CommandUnits::audioManager  /*0x04000DBE*/
    IL_0086: ldarg.0
    IL_0087: ldfld AudioSet CommandUnits::audioSet  /*0x04000DBF*/
    IL_008c: callvirt AudioSet.ClipArray AudioSet::get_AddedUnitToCommanding()  /*0x060001D3*/
    IL_0091: ldc.r4 0.55f
    IL_0096: ldc.r4 0.7f
    IL_009b: ldarg.0
    IL_009c: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_00a1: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_00a6: conv.r4
    IL_00a7: ldc.r4 0.025f
    IL_00ac: mul
    IL_00ad: add
    IL_00ae: ldarg.0
    IL_00af: ldfld ThronefallAudioManager CommandUnits::audioManager  /*0x04000DBE*/
    IL_00b4: ldfld AudioMixerGroup ThronefallAudioManager::mgSFX  /*0x04000280*/
    IL_00b9: ldc.i4.s 50
    IL_00bb: ldc.i4.0
    IL_00bc: ldloca.s 3
    IL_00be: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_00c4: ldloc.3
    IL_00c5: callvirt ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_00ca: pop
    IL_00cb: ldarg.0
    IL_00cc: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_00d1: ldloc.0
    IL_00d2: callvirt void System.Collections.Generic.List<PathfindMovementPlayerunit>::Add(!0)  /*0x0A0004CE*/
    IL_00d7: ldloc.0
    IL_00d8: ldc.i4.1
    IL_00d9: callvirt void PathfindMovementPlayerunit::FollowPlayer(bool)  /*0x06000B2E*/
    IL_00de: ldloc.0
    IL_00df: callvirt !!0 UnityEngine.Component::GetComponentInChildren()<MaterialFlasherFX>  /*0x2B0000A6*/
    IL_00e4: stloc.1
    IL_00e5: ldloc.1
    IL_00e6: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00eb: brfalse.s IL_00f4
    IL_00ed: ldloc.1
    IL_00ee: ldc.i4.1
    IL_00ef: callvirt void MaterialFlasherFX::SetSelected(bool)  /*0x06000780*/
    IL_00f4: ldloc.0
    IL_00f5: callvirt !!0 UnityEngine.Component::GetComponent()<UnitTypeDisplay>  /*0x2B0000A7*/
    IL_00fa: stloc.2
    IL_00fb: ldloc.2
    IL_00fc: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0101: brfalse.s IL_010a
    IL_0103: ldloc.2
    IL_0104: ldc.i4.1
    IL_0105: callvirt void UnitTypeDisplay::SetSelected(bool)  /*0x06001327*/
    IL_010a: ldarg.1
    IL_010b: ldc.i4.s 22
    IL_010d: callvirt void TaggedObject::AddTag(TagManager.ETag)  /*0x06000E49*/
    IL_0112: ldarg.0
    IL_0113: ldfld bool CommandUnits::royalProtectionEquipped  /*0x04000DD4*/
    IL_0118: brfalse.s IL_012b
    IL_011a: ldloc.0
    IL_011b: ldfld Hp PathfindMovementPlayerunit::hp  /*0x04000E21*/
    IL_0120: ldarg.0
    IL_0121: ldfld float CommandUnits::royalProtectionHealthMulti  /*0x04000DD3*/
    IL_0126: callvirt void Hp::ScaleHp(float)  /*0x06000824*/
    IL_012b: ldarg.0
    IL_012c: ldfld PlayerUpgradeManager CommandUnits::playerUPgradeManager  /*0x04000DC8*/
    IL_0131: ldfld bool PlayerUpgradeManager::commander  /*0x04000F29*/
    IL_0136: brfalse.s IL_014c
    IL_0138: ldloc.0
    IL_0139: dup
    IL_013a: ldfld float PathfindMovementPlayerunit::movementSpeed  /*0x04000E01*/
    IL_013f: ldarg.0
    IL_0140: ldfld float CommandUnits::commanderUnitMoveSpeedMulti  /*0x04000DBA*/
    IL_0145: mul
    IL_0146: stfld float PathfindMovementPlayerunit::movementSpeed  /*0x04000E01*/
    IL_014b: ret
    IL_014c: ldarg.1
    IL_014d: callvirt !!0[] UnityEngine.Component::GetComponents()<AutoAttack>  /*0x2B00008D*/
    IL_0152: stloc.s 4
    IL_0154: ldc.i4.0
    IL_0155: stloc.s 5
    IL_0157: br.s IL_017b
    IL_0159: ldloc.s 4
    IL_015b: ldloc.s 5
    IL_015d: ldelem.ref
    IL_015e: stloc.s 6
    IL_0160: ldloc.s 6
    IL_0162: ldc.i4.0
    IL_0163: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0168: ldarg.0
    IL_0169: ldfld List<AutoAttack> CommandUnits::autoAttacksToEnable  /*0x04000DD8*/
    IL_016e: ldloc.s 6
    IL_0170: callvirt void System.Collections.Generic.List<AutoAttack>::Add(!0)  /*0x0A0004D7*/
    IL_0175: ldloc.s 5
    IL_0177: ldc.i4.1
    IL_0178: add
    IL_0179: stloc.s 5
    IL_017b: ldloc.s 5
    IL_017d: ldloc.s 4
    IL_017f: ldlen
    IL_0180: conv.i4
    IL_0181: blt.s IL_0159
    IL_0183: ret

  .method CommandUnits::OnUnitRemove(PathfindMovementPlayerunit)  // token 0x06000B03 rva 0x34bfc attrs Public, HideBySig
    // code size 144 (0x90), max stack 3, init locals
    .locals ([0] MaterialFlasherFX, [1] UnitTypeDisplay)
    IL_0000: ldarg.0
    IL_0001: ldfld bool CommandUnits::canCommandUnitsInThisMode  /*0x04000DD2*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.1
    IL_000a: ldc.i4.0
    IL_000b: callvirt void PathfindMovementPlayerunit::set_HasReachedHomePositionAlready(bool)  /*0x06000B31*/
    IL_0010: ldarg.1
    IL_0011: ldc.i4.0
    IL_0012: callvirt void PathfindMovementPlayerunit::FollowPlayer(bool)  /*0x06000B2E*/
    IL_0017: ldarg.1
    IL_0018: callvirt !!0 UnityEngine.Component::GetComponentInChildren()<MaterialFlasherFX>  /*0x2B0000A6*/
    IL_001d: stloc.0
    IL_001e: ldloc.0
    IL_001f: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0024: brfalse.s IL_002d
    IL_0026: ldloc.0
    IL_0027: ldc.i4.0
    IL_0028: callvirt void MaterialFlasherFX::SetSelected(bool)  /*0x06000780*/
    IL_002d: ldarg.1
    IL_002e: callvirt !!0 UnityEngine.Component::GetComponent()<TaggedObject>  /*0x2B000005*/
    IL_0033: ldc.i4.s 22
    IL_0035: callvirt void TaggedObject::RemoveTag(TagManager.ETag)  /*0x06000E4A*/
    IL_003a: ldarg.1
    IL_003b: callvirt !!0 UnityEngine.Component::GetComponent()<UnitTypeDisplay>  /*0x2B0000A7*/
    IL_0040: stloc.1
    IL_0041: ldloc.1
    IL_0042: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0047: brfalse.s IL_0050
    IL_0049: ldloc.1
    IL_004a: ldc.i4.0
    IL_004b: callvirt void UnitTypeDisplay::SetSelected(bool)  /*0x06001327*/
    IL_0050: ldarg.0
    IL_0051: ldfld bool CommandUnits::royalProtectionEquipped  /*0x04000DD4*/
    IL_0056: brfalse.s IL_006f
    IL_0058: ldarg.1
    IL_0059: ldfld Hp PathfindMovementPlayerunit::hp  /*0x04000E21*/
    IL_005e: ldc.r4 1f
    IL_0063: ldarg.0
    IL_0064: ldfld float CommandUnits::royalProtectionHealthMulti  /*0x04000DD3*/
    IL_0069: div
    IL_006a: callvirt void Hp::ScaleHp(float)  /*0x06000824*/
    IL_006f: ldarg.0
    IL_0070: ldfld PlayerUpgradeManager CommandUnits::playerUPgradeManager  /*0x04000DC8*/
    IL_0075: ldfld bool PlayerUpgradeManager::commander  /*0x04000F29*/
    IL_007a: brfalse.s IL_008f
    IL_007c: ldarg.1
    IL_007d: dup
    IL_007e: ldfld float PathfindMovementPlayerunit::movementSpeed  /*0x04000E01*/
    IL_0083: ldarg.0
    IL_0084: ldfld float CommandUnits::commanderUnitMoveSpeedMulti  /*0x04000DBA*/
    IL_0089: div
    IL_008a: stfld float PathfindMovementPlayerunit::movementSpeed  /*0x04000E01*/
    IL_008f: ret

  .method CommandUnits::TryToSelectUnits(System.Collections.Generic.List<TaggedObject>)  // token 0x06000B04 rva 0x34c98 attrs Private, HideBySig
    // code size 94 (0x5e), max stack 3, init locals
    .locals ([0] List.Enumerator<TaggedObject>, [1] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld bool CommandUnits::commanding  /*0x04000DC5*/
    IL_0006: brfalse.s IL_0017
    IL_0008: ldarg.0
    IL_0009: ldc.i4.0
    IL_000a: call void CommandUnits::PlaceCommandedUnitsAndCalculateTargetPositions(bool)  /*0x06000B01*/
    IL_000f: ldarg.0
    IL_0010: ldc.i4.0
    IL_0011: stfld bool CommandUnits::commanding  /*0x04000DC5*/
    IL_0016: ret
    IL_0017: ldarg.1
    IL_0018: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_001d: stloc.0
    IL_001e: br.s IL_0030
    IL_0020: ldloca.s 0
    IL_0022: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_0027: stloc.1
    IL_0028: ldarg.0
    IL_0029: ldloc.1
    IL_002a: ldc.i4.0
    IL_002b: call void CommandUnits::OnUnitAdd(TaggedObject,bool)  /*0x06000B02*/
    IL_0030: ldloca.s 0
    IL_0032: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0037: brtrue.s IL_0020
    IL_0039: leave.s IL_0049
    IL_003b: ldloca.s 0
    IL_003d: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0043: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0048: endfinally
    IL_0049: ldarg.0
    IL_004a: ldarg.0
    IL_004b: ldfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_0050: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_0055: ldc.i4.0
    IL_0056: cgt
    IL_0058: stfld bool CommandUnits::commanding  /*0x04000DC5*/
    IL_005d: ret
    .try IL_001e-IL_003b finally handler IL_003b-IL_0049

  .method CommandUnits::.ctor()  // token 0x06000B05 rva 0x34d14 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 227 (0xe3), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.s 100
    IL_0003: stfld int CommandUnits::drowWaypointParticleCount  /*0x04000DB1*/
    IL_0008: ldarg.0
    IL_0009: ldc.r4 2f
    IL_000e: stfld float CommandUnits::unitDistanceFromEachOther  /*0x04000DB5*/
    IL_0013: ldarg.0
    IL_0014: ldc.r4 0.5f
    IL_0019: stfld float CommandUnits::unitDistanceMoveStep  /*0x04000DB6*/
    IL_001e: ldarg.0
    IL_001f: ldc.i4.5
    IL_0020: stfld int CommandUnits::maxPositioningRepeats  /*0x04000DB7*/
    IL_0025: ldarg.0
    IL_0026: ldc.r4 1f
    IL_002b: stfld float CommandUnits::holdToHoldPositionTime  /*0x04000DB8*/
    IL_0030: ldarg.0
    IL_0031: ldc.r4 1f
    IL_0036: stfld float CommandUnits::holdToSetUnitGroup  /*0x04000DB9*/
    IL_003b: ldarg.0
    IL_003c: ldc.r4 1.6f
    IL_0041: stfld float CommandUnits::commanderUnitMoveSpeedMulti  /*0x04000DBA*/
    IL_0046: ldarg.0
    IL_0047: ldc.r4 1.2f
    IL_004c: stfld float CommandUnits::commanderHoldHealthMulti  /*0x04000DBB*/
    IL_0051: ldarg.0
    IL_0052: ldc.r4 1.2f
    IL_0057: stfld float CommandUnits::commanderHoldDamageMulti  /*0x04000DBC*/
    IL_005c: ldarg.0
    IL_005d: ldc.r4 0.2f
    IL_0062: stfld float CommandUnits::groupHoldDelay  /*0x04000DBD*/
    IL_0067: ldarg.0
    IL_0068: newobj void Pathfinding.NNConstraint::.ctor()  /*0x0A0002AB*/
    IL_006d: stfld NNConstraint CommandUnits::nearestConstraint  /*0x04000DC0*/
    IL_0072: ldarg.0
    IL_0073: newobj void Pathfinding.NNConstraint::.ctor()  /*0x0A0002AB*/
    IL_0078: stfld NNConstraint CommandUnits::nearestConstraintAir  /*0x04000DC1*/
    IL_007d: ldarg.0
    IL_007e: newobj void System.Collections.Generic.List<PathfindMovementPlayerunit>::.ctor()  /*0x0A0004D8*/
    IL_0083: stfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommanding  /*0x04000DC2*/
    IL_0088: ldarg.0
    IL_0089: newobj void System.Collections.Generic.List<PathfindMovementPlayerunit>::.ctor()  /*0x0A0004D8*/
    IL_008e: stfld List<PathfindMovementPlayerunit> CommandUnits::playerUnitsCommandingBuffer  /*0x04000DC3*/
    IL_0093: ldarg.0
    IL_0094: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0099: stfld List<TagManager.ETag> CommandUnits::mustHaveTags  /*0x04000DCE*/
    IL_009e: ldarg.0
    IL_009f: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_00a4: stfld List<TagManager.ETag> CommandUnits::mayNotHaveTags  /*0x04000DCF*/
    IL_00a9: ldarg.0
    IL_00aa: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_00af: stfld List<TaggedObject> CommandUnits::results  /*0x04000DD0*/
    IL_00b4: ldarg.0
    IL_00b5: ldc.i4.1
    IL_00b6: stfld bool CommandUnits::canCommandUnitsInThisMode  /*0x04000DD2*/
    IL_00bb: ldarg.0
    IL_00bc: ldc.r4 1f
    IL_00c1: stfld float CommandUnits::royalProtectionHealthMulti  /*0x04000DD3*/
    IL_00c6: ldarg.0
    IL_00c7: newobj void System.Collections.Generic.List<PathfindMovementPlayerunit>::.ctor()  /*0x0A0004D8*/
    IL_00cc: stfld List<PathfindMovementPlayerunit> CommandUnits::toBePlaced  /*0x04000DD7*/
    IL_00d1: ldarg.0
    IL_00d2: newobj void System.Collections.Generic.List<AutoAttack>::.ctor()  /*0x0A0004D9*/
    IL_00d7: stfld List<AutoAttack> CommandUnits::autoAttacksToEnable  /*0x04000DD8*/
    IL_00dc: ldarg.0
    IL_00dd: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_00e2: ret

