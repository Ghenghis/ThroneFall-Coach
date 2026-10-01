// ===== TutorialManager  (token 0x020002BF) =====
  .method TutorialManager::get_AllowStartingTheNight()  // token 0x06000F1C rva 0x43c09 attrs Public, Static, HideBySig, SpecialName
    // code size 25 (0x19), max stack 8
    IL_0000: ldsfld TutorialManager TutorialManager::instance  /*0x0400117F*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brtrue.s IL_000e
    IL_000c: ldc.i4.1
    IL_000d: ret
    IL_000e: ldsfld TutorialManager TutorialManager::instance  /*0x0400117F*/
    IL_0013: ldfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_0018: ret

  .method TutorialManager::get_MayShowEnemySpawn()  // token 0x06000F1D rva 0x43c23 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool TutorialManager::mayShowEnemySpawn  /*0x04001194*/
    IL_0006: ret

  .method TutorialManager::SetArrowMarker(bool,UnityEngine.Vector3,bool)  // token 0x06000F1E rva 0x43c2c attrs Private, HideBySig
    // code size 79 (0x4f), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld ScreenMarker TutorialManager::arrowMarker  /*0x04001188*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: ldfld Transform TutorialManager::arrowMarkerTransform  /*0x04001187*/
    IL_0014: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0019: ldarg.1
    IL_001a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001f: ldarg.0
    IL_0020: ldfld Transform TutorialManager::arrowMarkerTransform  /*0x04001187*/
    IL_0025: ldarg.2
    IL_0026: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_002b: ldc.r4 10f
    IL_0030: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0035: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_003a: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_003f: ldarg.0
    IL_0040: ldfld ScreenMarker TutorialManager::arrowMarker  /*0x04001188*/
    IL_0045: ldarg.3
    IL_0046: ldc.i4.0
    IL_0047: ceq
    IL_0049: stfld bool ScreenMarker::showWhenOnScreen  /*0x04000FC1*/
    IL_004e: ret

  .method TutorialManager::MarkNearestObjectWithTag(TagManager.ETag,bool)  // token 0x06000F1F rva 0x43c88 attrs Private, HideBySig
    // code size 209 (0xd1), max stack 4, init locals
    .locals ([0] TaggedObject, [1] float, [2] int, [3] float, [4] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TaggedObject> TutorialManager::findTaggedObjects  /*0x040011A8*/
    IL_0006: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<TagManager.ETag> TutorialManager::mustHaveTag  /*0x040011A9*/
    IL_0011: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_0016: ldarg.0
    IL_0017: ldfld List<TagManager.ETag> TutorialManager::mayNotHaveTag  /*0x040011AA*/
    IL_001c: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_0021: ldarg.0
    IL_0022: ldfld List<TagManager.ETag> TutorialManager::mustHaveTag  /*0x040011A9*/
    IL_0027: ldarg.1
    IL_0028: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_002d: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0032: ldarg.0
    IL_0033: ldfld List<TaggedObject> TutorialManager::findTaggedObjects  /*0x040011A8*/
    IL_0038: ldarg.0
    IL_0039: ldfld List<TagManager.ETag> TutorialManager::mustHaveTag  /*0x040011A9*/
    IL_003e: ldarg.0
    IL_003f: ldfld List<TagManager.ETag> TutorialManager::mayNotHaveTag  /*0x040011AA*/
    IL_0044: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0049: ldarg.0
    IL_004a: ldfld List<TaggedObject> TutorialManager::findTaggedObjects  /*0x040011A8*/
    IL_004f: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0054: ldc.i4.0
    IL_0055: ble.s IL_00d0
    IL_0057: ldnull
    IL_0058: stloc.0
    IL_0059: ldc.r4 3.4028235E+38f
    IL_005e: stloc.1
    IL_005f: ldc.i4.0
    IL_0060: stloc.2
    IL_0061: br.s IL_00af
    IL_0063: ldarg.0
    IL_0064: ldfld Transform TutorialManager::player  /*0x04001189*/
    IL_0069: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_006e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0073: ldarg.0
    IL_0074: ldfld List<TaggedObject> TutorialManager::findTaggedObjects  /*0x040011A8*/
    IL_0079: ldloc.2
    IL_007a: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_007f: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0084: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0089: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_008e: stloc.s 4
    IL_0090: ldloca.s 4
    IL_0092: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0097: stloc.3
    IL_0098: ldloc.3
    IL_0099: ldloc.1
    IL_009a: bge.un.s IL_00ab
    IL_009c: ldloc.3
    IL_009d: stloc.1
    IL_009e: ldarg.0
    IL_009f: ldfld List<TaggedObject> TutorialManager::findTaggedObjects  /*0x040011A8*/
    IL_00a4: ldloc.2
    IL_00a5: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_00aa: stloc.0
    IL_00ab: ldloc.2
    IL_00ac: ldc.i4.1
    IL_00ad: add
    IL_00ae: stloc.2
    IL_00af: ldloc.2
    IL_00b0: ldarg.0
    IL_00b1: ldfld List<TaggedObject> TutorialManager::findTaggedObjects  /*0x040011A8*/
    IL_00b6: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_00bb: blt.s IL_0063
    IL_00bd: ldarg.0
    IL_00be: ldc.i4.1
    IL_00bf: ldloc.0
    IL_00c0: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00c5: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00ca: ldarg.2
    IL_00cb: call void TutorialManager::SetArrowMarker(bool,UnityEngine.Vector3,bool)  /*0x06000F1E*/
    IL_00d0: ret

  .method TutorialManager::MarkNearestUnbuiltBuilding(System.Collections.Generic.List<BuildSlot>)  // token 0x06000F20 rva 0x43d68 attrs Private, HideBySig
    // code size 201 (0xc9), max stack 4, init locals
    .locals ([0] List<BuildSlot>, [1] int, [2] BuildSlot, [3] float, [4] int, [5] float, [6] Vector3)
    IL_0000: ldarg.1
    IL_0001: newobj void System.Collections.Generic.List<BuildSlot>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000601*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: callvirt int System.Collections.Generic.List<BuildSlot>::get_Count()  /*0x0A000053*/
    IL_000d: ldc.i4.1
    IL_000e: sub
    IL_000f: stloc.1
    IL_0010: br.s IL_0048
    IL_0012: ldloc.0
    IL_0013: ldloc.1
    IL_0014: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_0019: callvirt BuildSlot.BuildingState BuildSlot::get_State()  /*0x060002D9*/
    IL_001e: ldc.i4.1
    IL_001f: bne.un.s IL_002a
    IL_0021: ldloc.0
    IL_0022: ldloc.1
    IL_0023: callvirt void System.Collections.Generic.List<BuildSlot>::RemoveAt(int)  /*0x0A000602*/
    IL_0028: br.s IL_0044
    IL_002a: ldloc.0
    IL_002b: ldloc.1
    IL_002c: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_0031: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0036: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_003b: brtrue.s IL_0044
    IL_003d: ldloc.0
    IL_003e: ldloc.1
    IL_003f: callvirt void System.Collections.Generic.List<BuildSlot>::RemoveAt(int)  /*0x0A000602*/
    IL_0044: ldloc.1
    IL_0045: ldc.i4.1
    IL_0046: sub
    IL_0047: stloc.1
    IL_0048: ldloc.1
    IL_0049: ldc.i4.0
    IL_004a: bge.s IL_0012
    IL_004c: ldloc.0
    IL_004d: callvirt int System.Collections.Generic.List<BuildSlot>::get_Count()  /*0x0A000053*/
    IL_0052: ldc.i4.0
    IL_0053: ble.s IL_00c8
    IL_0055: ldnull
    IL_0056: stloc.2
    IL_0057: ldc.r4 3.4028235E+38f
    IL_005c: stloc.3
    IL_005d: ldc.i4.0
    IL_005e: stloc.s 4
    IL_0060: br.s IL_00ab
    IL_0062: ldarg.0
    IL_0063: ldfld Transform TutorialManager::player  /*0x04001189*/
    IL_0068: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_006d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0072: ldloc.0
    IL_0073: ldloc.s 4
    IL_0075: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_007a: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_007f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0084: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0089: stloc.s 6
    IL_008b: ldloca.s 6
    IL_008d: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0092: stloc.s 5
    IL_0094: ldloc.s 5
    IL_0096: ldloc.3
    IL_0097: bge.un.s IL_00a5
    IL_0099: ldloc.s 5
    IL_009b: stloc.3
    IL_009c: ldloc.0
    IL_009d: ldloc.s 4
    IL_009f: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_00a4: stloc.2
    IL_00a5: ldloc.s 4
    IL_00a7: ldc.i4.1
    IL_00a8: add
    IL_00a9: stloc.s 4
    IL_00ab: ldloc.s 4
    IL_00ad: ldloc.0
    IL_00ae: callvirt int System.Collections.Generic.List<BuildSlot>::get_Count()  /*0x0A000053*/
    IL_00b3: blt.s IL_0062
    IL_00b5: ldarg.0
    IL_00b6: ldc.i4.1
    IL_00b7: ldloc.2
    IL_00b8: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00bd: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00c2: ldc.i4.0
    IL_00c3: call void TutorialManager::SetArrowMarker(bool,UnityEngine.Vector3,bool)  /*0x06000F1E*/
    IL_00c8: ret

  .method TutorialManager::MarkNearestGoldCoin()  // token 0x06000F21 rva 0x43e40 attrs Private, HideBySig
    // code size 130 (0x82), max stack 4, init locals
    .locals ([0] List<Coin>, [1] Coin, [2] float, [3] int, [4] float, [5] Vector3)
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: ldfld List<Coin> TagManager::freeCoins  /*0x04001093*/
    IL_000a: stloc.0
    IL_000b: ldloc.0
    IL_000c: callvirt int System.Collections.Generic.List<Coin>::get_Count()  /*0x0A0001A8*/
    IL_0011: ldc.i4.0
    IL_0012: ble.s IL_0081
    IL_0014: ldnull
    IL_0015: stloc.1
    IL_0016: ldc.r4 3.4028235E+38f
    IL_001b: stloc.2
    IL_001c: ldc.i4.0
    IL_001d: stloc.3
    IL_001e: br.s IL_0065
    IL_0020: ldarg.0
    IL_0021: ldfld Transform TutorialManager::player  /*0x04001189*/
    IL_0026: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0030: ldloc.0
    IL_0031: ldloc.3
    IL_0032: callvirt !0 System.Collections.Generic.List<Coin>::get_Item(int)  /*0x0A000603*/
    IL_0037: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0041: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0046: stloc.s 5
    IL_0048: ldloca.s 5
    IL_004a: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_004f: stloc.s 4
    IL_0051: ldloc.s 4
    IL_0053: ldloc.2
    IL_0054: bge.un.s IL_0061
    IL_0056: ldloc.s 4
    IL_0058: stloc.2
    IL_0059: ldloc.0
    IL_005a: ldloc.3
    IL_005b: callvirt !0 System.Collections.Generic.List<Coin>::get_Item(int)  /*0x0A000603*/
    IL_0060: stloc.1
    IL_0061: ldloc.3
    IL_0062: ldc.i4.1
    IL_0063: add
    IL_0064: stloc.3
    IL_0065: ldloc.3
    IL_0066: ldloc.0
    IL_0067: callvirt int System.Collections.Generic.List<Coin>::get_Count()  /*0x0A0001A8*/
    IL_006c: blt.s IL_0020
    IL_006e: ldarg.0
    IL_006f: ldc.i4.1
    IL_0070: ldloc.1
    IL_0071: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0076: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_007b: ldc.i4.0
    IL_007c: call void TutorialManager::SetArrowMarker(bool,UnityEngine.Vector3,bool)  /*0x06000F1E*/
    IL_0081: ret

  .method TutorialManager::Awake()  // token 0x06000F22 rva 0x43ece attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld TutorialManager TutorialManager::instance  /*0x0400117F*/
    IL_0006: ret

  .method TutorialManager::Start()  // token 0x06000F23 rva 0x43ed8 attrs Private, HideBySig
    // code size 96 (0x60), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0006: stfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_000b: ldarg.0
    IL_000c: ldsfld TooltipManager TooltipManager::instance  /*0x04001167*/
    IL_0011: stfld TooltipManager TutorialManager::tooltipManager  /*0x04001182*/
    IL_0016: ldarg.0
    IL_0017: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_001c: stfld TagManager TutorialManager::tagManager  /*0x04001183*/
    IL_0021: ldarg.0
    IL_0022: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0027: stfld PlayerInteraction TutorialManager::playerInteraction  /*0x04001180*/
    IL_002c: ldarg.0
    IL_002d: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0032: stfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_0037: ldarg.0
    IL_0038: ldfld GameObject TutorialManager::treasureChest  /*0x0400118D*/
    IL_003d: ldc.i4.0
    IL_003e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0043: ldsfld TreasureChestUIHelper TreasureChestUIHelper::instance  /*0x040016A5*/
    IL_0048: ldc.i4.0
    IL_0049: stfld bool TreasureChestUIHelper::overrideActiveState  /*0x040016A6*/
    IL_004e: ldarg.0
    IL_004f: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0054: ldc.i4.0
    IL_0055: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_005a: stfld Player TutorialManager::input  /*0x040011AB*/
    IL_005f: ret

  .method TutorialManager::SetTutorialTipLocalize(string,string)  // token 0x06000F24 rva 0x43f44 attrs Private, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld string TutorialManager::tipHeader  /*0x040011AC*/
    IL_0007: ldarg.0
    IL_0008: ldarg.2
    IL_0009: stfld string TutorialManager::tipBody  /*0x040011AD*/
    IL_000e: ldarg.0
    IL_000f: ldc.i4.1
    IL_0010: stfld bool TutorialManager::localize  /*0x040011AE*/
    IL_0015: ret

  .method TutorialManager::SetTutorialTip(string,string)  // token 0x06000F25 rva 0x43f5b attrs Private, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld string TutorialManager::tipHeader  /*0x040011AC*/
    IL_0007: ldarg.0
    IL_0008: ldarg.2
    IL_0009: stfld string TutorialManager::tipBody  /*0x040011AD*/
    IL_000e: ldarg.0
    IL_000f: ldc.i4.0
    IL_0010: stfld bool TutorialManager::localize  /*0x040011AE*/
    IL_0015: ret

  .method TutorialManager::Update()  // token 0x06000F26 rva 0x43f74 attrs Private, HideBySig
    // code size 142 (0x8e), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldstr ""
    IL_0006: stfld string TutorialManager::tipHeader  /*0x040011AC*/
    IL_000b: ldarg.0
    IL_000c: ldstr ""
    IL_0011: stfld string TutorialManager::tipBody  /*0x040011AD*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.0
    IL_0018: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_001d: ldc.i4.0
    IL_001e: call void TutorialManager::SetArrowMarker(bool,UnityEngine.Vector3,bool)  /*0x06000F1E*/
    IL_0023: ldarg.0
    IL_0024: ldfld TooltipManager TutorialManager::tooltipManager  /*0x04001182*/
    IL_0029: ldstr ""
    IL_002e: ldc.i4.1
    IL_002f: callvirt void TooltipManager::SetTutorialOverride(string,bool)  /*0x06000F0F*/
    IL_0034: ldarg.0
    IL_0035: ldfld TooltipManager TutorialManager::tooltipManager  /*0x04001182*/
    IL_003a: ldstr ""
    IL_003f: ldc.i4.0
    IL_0040: callvirt void TooltipManager::SetTutorialOverride(string,bool)  /*0x06000F0F*/
    IL_0045: ldsfld TooltipManager TooltipManager::instance  /*0x04001167*/
    IL_004a: ldc.i4.1
    IL_004b: stfld bool TooltipManager::hideAllTooltips  /*0x04001168*/
    IL_0050: ldarg.0
    IL_0051: call void TutorialManager::TutorialUpdate()  /*0x06000F28*/
    IL_0056: ldarg.0
    IL_0057: ldfld bool TutorialManager::localize  /*0x040011AE*/
    IL_005c: brfalse.s IL_0076
    IL_005e: ldsfld TipManager TipManager::instance  /*0x04001155*/
    IL_0063: ldarg.0
    IL_0064: ldfld string TutorialManager::tipHeader  /*0x040011AC*/
    IL_0069: ldarg.0
    IL_006a: ldfld string TutorialManager::tipBody  /*0x040011AD*/
    IL_006f: ldc.i4.1
    IL_0070: callvirt void TipManager::UpdateTipLocalized(string,string,bool)  /*0x06000F0C*/
    IL_0075: ret
    IL_0076: ldsfld TipManager TipManager::instance  /*0x04001155*/
    IL_007b: ldarg.0
    IL_007c: ldfld string TutorialManager::tipHeader  /*0x040011AC*/
    IL_0081: ldarg.0
    IL_0082: ldfld string TutorialManager::tipBody  /*0x040011AD*/
    IL_0087: ldc.i4.1
    IL_0088: callvirt void TipManager::UpdateTipRaw(string,string,bool)  /*0x06000F0B*/
    IL_008d: ret

  .method TutorialManager::OnDisable()  // token 0x06000F27 rva 0x4400e attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldsfld TooltipManager TooltipManager::instance  /*0x04001167*/
    IL_0005: ldc.i4.0
    IL_0006: stfld bool TooltipManager::hideAllTooltips  /*0x04001168*/
    IL_000b: ret

  .method TutorialManager::TutorialUpdate()  // token 0x06000F28 rva 0x4401c attrs Private, HideBySig
    // code size 3197 (0xc7d), max stack 10, init locals
    .locals ([0] Vector3, [1] BuildingInteractor, [2] int, [3] int, [4] int, [5] int, [6] List<TaggedObject>, [7] bool, [8] List.Enumerator<TaggedObject>)
    IL_0000: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0005: callvirt bool SceneTransitionManager::get_SceneTransitionIsRunning()  /*0x060009C6*/
    IL_000a: brfalse.s IL_000d
    IL_000c: ret
    IL_000d: ldarg.0
    IL_000e: ldfld PlayerInteraction TutorialManager::playerInteraction  /*0x04001180*/
    IL_0013: callvirt int PlayerInteraction::get_Balance()  /*0x06000C04*/
    IL_0018: ldc.i4.0
    IL_0019: ble.s IL_003f
    IL_001b: ldarg.0
    IL_001c: ldfld GameObject TutorialManager::treasureChest  /*0x0400118D*/
    IL_0021: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_0026: brtrue.s IL_003f
    IL_0028: ldarg.0
    IL_0029: ldfld GameObject TutorialManager::treasureChest  /*0x0400118D*/
    IL_002e: ldc.i4.1
    IL_002f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0034: ldsfld TreasureChestUIHelper TreasureChestUIHelper::instance  /*0x040016A5*/
    IL_0039: ldc.i4.1
    IL_003a: stfld bool TreasureChestUIHelper::overrideActiveState  /*0x040016A6*/
    IL_003f: ldarg.0
    IL_0040: ldfld Hp TutorialManager::playerHp  /*0x0400118A*/
    IL_0045: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_004a: brfalse.s IL_005d
    IL_004c: ldarg.0
    IL_004d: ldstr ""
    IL_0052: ldstr "NewTutorial/dead"
    IL_0057: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_005c: ret
    IL_005d: ldarg.0
    IL_005e: ldfld bool TutorialManager::playerHasLearnedHowToMove  /*0x0400118E*/
    IL_0063: brtrue.s IL_00b9
    IL_0065: ldarg.0
    IL_0066: ldc.i4.s 15
    IL_0068: ldc.i4.0
    IL_0069: call void TutorialManager::MarkNearestObjectWithTag(TagManager.ETag,bool)  /*0x06000F1F*/
    IL_006e: ldarg.0
    IL_006f: ldstr "NewTutorial/move"
    IL_0074: ldstr ""
    IL_0079: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_007e: ldarg.0
    IL_007f: ldarg.0
    IL_0080: ldfld float TutorialManager::requiredMoveDist  /*0x0400118C*/
    IL_0085: ldarg.0
    IL_0086: ldfld RVOController TutorialManager::playerRvo  /*0x0400118B*/
    IL_008b: callvirt Vector3 Pathfinding.RVO.RVOController::get_velocity()  /*0x0A000604*/
    IL_0090: stloc.0
    IL_0091: ldloca.s 0
    IL_0093: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0098: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_009d: mul
    IL_009e: sub
    IL_009f: stfld float TutorialManager::requiredMoveDist  /*0x0400118C*/
    IL_00a4: ldarg.0
    IL_00a5: ldfld float TutorialManager::requiredMoveDist  /*0x0400118C*/
    IL_00aa: ldc.r4 0f
    IL_00af: bge.un.s IL_00b8
    IL_00b1: ldarg.0
    IL_00b2: ldc.i4.1
    IL_00b3: stfld bool TutorialManager::playerHasLearnedHowToMove  /*0x0400118E*/
    IL_00b8: ret
    IL_00b9: ldarg.0
    IL_00ba: ldfld bool TutorialManager::destroyedPracticeTargets  /*0x0400118F*/
    IL_00bf: brtrue.s IL_00e2
    IL_00c1: ldarg.0
    IL_00c2: ldc.i4.s 15
    IL_00c4: ldc.i4.0
    IL_00c5: call void TutorialManager::MarkNearestObjectWithTag(TagManager.ETag,bool)  /*0x06000F1F*/
    IL_00ca: ldarg.0
    IL_00cb: ldfld TagManager TutorialManager::tagManager  /*0x04001183*/
    IL_00d0: ldc.i4.s 15
    IL_00d2: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_00d7: ldc.i4.0
    IL_00d8: bgt.s IL_00e1
    IL_00da: ldarg.0
    IL_00db: ldc.i4.1
    IL_00dc: stfld bool TutorialManager::destroyedPracticeTargets  /*0x0400118F*/
    IL_00e1: ret
    IL_00e2: ldarg.0
    IL_00e3: ldfld TagManager TutorialManager::tagManager  /*0x04001183*/
    IL_00e8: ldfld List<Coin> TagManager::freeCoins  /*0x04001093*/
    IL_00ed: callvirt int System.Collections.Generic.List<Coin>::get_Count()  /*0x0A0001A8*/
    IL_00f2: ldc.i4.0
    IL_00f3: ble.s IL_0125
    IL_00f5: ldarg.0
    IL_00f6: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_00fb: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0100: brtrue.s IL_0125
    IL_0102: ldarg.0
    IL_0103: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_0108: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_010d: ldc.i4.m1
    IL_010e: bne.un.s IL_0125
    IL_0110: ldarg.0
    IL_0111: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_0116: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_011b: ldc.i4.3
    IL_011c: bgt.s IL_0125
    IL_011e: ldarg.0
    IL_011f: call void TutorialManager::MarkNearestGoldCoin()  /*0x06000F21*/
    IL_0124: ret
    IL_0125: ldarg.0
    IL_0126: ldfld bool TutorialManager::castleCenterBuilt  /*0x04001193*/
    IL_012b: brtrue IL_01e8
    IL_0130: call PlayerManager PlayerManager::get_Instance()  /*0x06000C14*/
    IL_0135: callvirt PlayerMovement[] PlayerManager::get_RegisteredPlayers()  /*0x06000C15*/
    IL_013a: ldc.i4.0
    IL_013b: ldelem.ref
    IL_013c: callvirt bool PlayerMovement::get_Sprinting()  /*0x06000C1E*/
    IL_0141: brfalse.s IL_014a
    IL_0143: ldarg.0
    IL_0144: ldc.i4.1
    IL_0145: stfld bool TutorialManager::playerDidSprint  /*0x04001190*/
    IL_014a: ldarg.0
    IL_014b: ldfld PlayerInteraction TutorialManager::playerInteraction  /*0x04001180*/
    IL_0150: callvirt InteractorBase PlayerInteraction::get_FocussedInteractor()  /*0x06000C08*/
    IL_0155: ldarg.0
    IL_0156: ldfld BuildingInteractor TutorialManager::caslteBuildInteractor  /*0x04001192*/
    IL_015b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0160: brfalse.s IL_01a4
    IL_0162: ldarg.0
    IL_0163: ldstr "NewTutorial/sprintA"
    IL_0168: ldstr "NewTutorial/sprintB"
    IL_016d: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0172: ldarg.0
    IL_0173: ldfld bool TutorialManager::playerDidSprint  /*0x04001190*/
    IL_0178: brfalse.s IL_01bf
    IL_017a: ldarg.0
    IL_017b: ldc.i4.1
    IL_017c: ldarg.0
    IL_017d: ldfld BuildingInteractor TutorialManager::caslteBuildInteractor  /*0x04001192*/
    IL_0182: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0187: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_018c: ldc.i4.0
    IL_018d: call void TutorialManager::SetArrowMarker(bool,UnityEngine.Vector3,bool)  /*0x06000F1E*/
    IL_0192: ldarg.0
    IL_0193: ldstr ""
    IL_0198: ldstr "NewTutorial/sprintB"
    IL_019d: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_01a2: br.s IL_01bf
    IL_01a4: ldarg.0
    IL_01a5: ldfld TooltipManager TutorialManager::tooltipManager  /*0x04001182*/
    IL_01aa: callvirt void TooltipManager::SetTutorialOverrideToNone()  /*0x06000F0E*/
    IL_01af: ldarg.0
    IL_01b0: ldstr "NewTutorial/build"
    IL_01b5: ldstr ""
    IL_01ba: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_01bf: ldarg.0
    IL_01c0: ldfld TagManager TutorialManager::tagManager  /*0x04001183*/
    IL_01c5: ldc.i4.8
    IL_01c6: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_01cb: ldc.i4.0
    IL_01cc: ble.s IL_01e7
    IL_01ce: ldarg.0
    IL_01cf: ldc.i4.1
    IL_01d0: stfld bool TutorialManager::castleCenterBuilt  /*0x04001193*/
    IL_01d5: ldarg.0
    IL_01d6: ldc.i4.1
    IL_01d7: stfld bool TutorialManager::mayShowEnemySpawn  /*0x04001194*/
    IL_01dc: ldarg.0
    IL_01dd: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_01e2: callvirt void EnemySpawner::EnemySpawnersHornUnFocussed()  /*0x06000681*/
    IL_01e7: ret
    IL_01e8: ldarg.0
    IL_01e9: ldfld PlayerInteraction TutorialManager::playerInteraction  /*0x04001180*/
    IL_01ee: callvirt InteractorBase PlayerInteraction::get_FocussedInteractor()  /*0x06000C08*/
    IL_01f3: ldnull
    IL_01f4: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_01f9: brfalse IL_02f1
    IL_01fe: ldarg.0
    IL_01ff: ldfld PlayerInteraction TutorialManager::playerInteraction  /*0x04001180*/
    IL_0204: callvirt InteractorBase PlayerInteraction::get_FocussedInteractor()  /*0x06000C08*/
    IL_0209: callvirt Type System.Object::GetType()  /*0x0A0002B4*/
    IL_020e: ldtoken BuildingInteractor  /*0x02000230*/
    IL_0213: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_0218: call bool System.Type::op_Equality(System.Type,System.Type)  /*0x0A0002B6*/
    IL_021d: brfalse IL_02f1
    IL_0222: ldarg.0
    IL_0223: ldfld PlayerInteraction TutorialManager::playerInteraction  /*0x04001180*/
    IL_0228: callvirt InteractorBase PlayerInteraction::get_FocussedInteractor()  /*0x06000C08*/
    IL_022d: castclass BuildingInteractor  /*0x02000230*/
    IL_0232: stloc.1
    IL_0233: ldloc.1
    IL_0234: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0239: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_023e: brfalse IL_02f1
    IL_0243: ldarg.0
    IL_0244: ldfld PlayerInteraction TutorialManager::playerInteraction  /*0x04001180*/
    IL_0249: callvirt int PlayerInteraction::get_Balance()  /*0x06000C04*/
    IL_024e: ldsfld int CostDisplay::currentlyFilledCoinsFromLastActiveDisplay  /*0x04001304*/
    IL_0253: add
    IL_0254: ldloc.1
    IL_0255: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_025a: callvirt int BuildSlot::get_NextUpgradeOrBuildCost()  /*0x060002E6*/
    IL_025f: bge IL_02f1
    IL_0264: ldloc.1
    IL_0265: callvirt bool BuildingInteractor::get_UpgradeCueVisible()  /*0x06000BAA*/
    IL_026a: brtrue IL_02f1
    IL_026f: ldloc.1
    IL_0270: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0275: callvirt BuildSlot.BuildingState BuildSlot::get_State()  /*0x060002D9*/
    IL_027a: brtrue.s IL_028d
    IL_027c: ldarg.0
    IL_027d: ldstr ""
    IL_0282: ldstr "NewTutorial/noGoldToBuild"
    IL_0287: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_028c: ret
    IL_028d: ldloc.1
    IL_028e: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0293: callvirt !!0 UnityEngine.Component::GetComponentInChildren()<TaggedObject>  /*0x2B000045*/
    IL_0298: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_029d: ldc.i4.3
    IL_029e: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_02a3: brfalse.s IL_02e0
    IL_02a5: ldarg.0
    IL_02a6: ldfld TooltipManager TutorialManager::tooltipManager  /*0x04001182*/
    IL_02ab: callvirt void TooltipManager::SetTutorialOverrideToNone()  /*0x06000F0E*/
    IL_02b0: ldarg.0
    IL_02b1: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_02b6: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_02bb: ldc.i4.2
    IL_02bc: bne.un.s IL_02cf
    IL_02be: ldarg.0
    IL_02bf: ldstr ""
    IL_02c4: ldstr ""
    IL_02c9: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_02ce: ret
    IL_02cf: ldarg.0
    IL_02d0: ldstr ""
    IL_02d5: ldstr "NewTutorial/castleCenter"
    IL_02da: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_02df: ret
    IL_02e0: ldarg.0
    IL_02e1: ldstr ""
    IL_02e6: ldstr "NewTutorial/noGoldToUpgrade"
    IL_02eb: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_02f0: ret
    IL_02f1: ldarg.0
    IL_02f2: ldfld bool TutorialManager::firstNightStarted  /*0x04001195*/
    IL_02f7: brtrue.s IL_031f
    IL_02f9: ldarg.0
    IL_02fa: ldstr "NewTutorial/callNight"
    IL_02ff: ldstr "NewTutorial/enemiesAttack"
    IL_0304: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0309: ldarg.0
    IL_030a: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_030f: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0314: ldc.i4.1
    IL_0315: bne.un.s IL_031e
    IL_0317: ldarg.0
    IL_0318: ldc.i4.1
    IL_0319: stfld bool TutorialManager::firstNightStarted  /*0x04001195*/
    IL_031e: ret
    IL_031f: ldarg.0
    IL_0320: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_0325: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_032a: brtrue IL_03fb
    IL_032f: ldarg.0
    IL_0330: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_0335: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_033a: ldc.i4.1
    IL_033b: bne.un IL_03fb
    IL_0340: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0345: ldc.i4.1
    IL_0346: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_034b: ldc.i4.2
    IL_034c: bgt.s IL_0367
    IL_034e: ldarg.0
    IL_034f: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_0354: callvirt float EnemySpawner::get_LastSpawnPeriodClock()  /*0x06000676*/
    IL_0359: ldc.r4 4.5f
    IL_035e: ble.un.s IL_0367
    IL_0360: ldarg.0
    IL_0361: ldc.i4.1
    IL_0362: stfld bool TutorialManager::timeToShowSpecialAttackPrompt  /*0x04001191*/
    IL_0367: ldarg.0
    IL_0368: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_036d: ldarg.0
    IL_036e: ldfld StabMA TutorialManager::activeStabAttack  /*0x04001196*/
    IL_0373: callvirt int StabMA::get_TargetsStabeed()  /*0x06000A34*/
    IL_0378: ldc.i4.3
    IL_0379: clt
    IL_037b: callvirt void EnemySpawner::set_InfinitelySpawning(bool)  /*0x06000678*/
    IL_0380: ldarg.0
    IL_0381: ldc.i4.1
    IL_0382: ldc.i4.1
    IL_0383: call void TutorialManager::MarkNearestObjectWithTag(TagManager.ETag,bool)  /*0x06000F1F*/
    IL_0388: ldarg.0
    IL_0389: ldc.i4.0
    IL_038a: stfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_038f: ldarg.0
    IL_0390: ldfld bool TutorialManager::timeToShowSpecialAttackPrompt  /*0x04001191*/
    IL_0395: brfalse.s IL_03fa
    IL_0397: ldarg.0
    IL_0398: ldfld StabMA TutorialManager::activeStabAttack  /*0x04001196*/
    IL_039d: callvirt int StabMA::get_TargetsStabeed()  /*0x06000A34*/
    IL_03a2: ldc.i4.3
    IL_03a3: bge.s IL_03ea
    IL_03a5: ldarg.0
    IL_03a6: ldstr "NewTutorial/attack"
    IL_03ab: ldc.i4.1
    IL_03ac: ldc.i4.0
    IL_03ad: ldc.i4.1
    IL_03ae: ldc.i4.1
    IL_03af: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_03b4: ldstr "<style=highlighted>"
    IL_03b9: ldarg.0
    IL_03ba: ldfld StabMA TutorialManager::activeStabAttack  /*0x04001196*/
    IL_03bf: callvirt int StabMA::get_TargetsStabeed()  /*0x06000A34*/
    IL_03c4: stloc.2
    IL_03c5: ldloca.s 2
    IL_03c7: call string System.Int32::ToString()  /*0x0A000031*/
    IL_03cc: ldstr "/3</style> "
    IL_03d1: ldstr "NewTutorial/attackCount"
    IL_03d6: ldc.i4.1
    IL_03d7: ldc.i4.0
    IL_03d8: ldc.i4.1
    IL_03d9: ldc.i4.1
    IL_03da: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_03df: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_03e4: call void TutorialManager::SetTutorialTip(string,string)  /*0x06000F25*/
    IL_03e9: ret
    IL_03ea: ldarg.0
    IL_03eb: ldstr ""
    IL_03f0: ldstr "NewTutorial/wellDone"
    IL_03f5: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_03fa: ret
    IL_03fb: ldarg.0
    IL_03fc: ldfld bool TutorialManager::housesBuilt  /*0x04001198*/
    IL_0401: brtrue IL_0550
    IL_0406: ldarg.0
    IL_0407: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_040c: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0411: brtrue IL_0550
    IL_0416: ldarg.0
    IL_0417: ldarg.0
    IL_0418: ldfld List<BuildSlot> TutorialManager::houses  /*0x04001197*/
    IL_041d: call void TutorialManager::MarkNearestUnbuiltBuilding(System.Collections.Generic.List<BuildSlot>)  /*0x06000F20*/
    IL_0422: ldarg.0
    IL_0423: ldfld TagManager TutorialManager::tagManager  /*0x04001183*/
    IL_0428: ldc.i4.8
    IL_0429: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_042e: stloc.3
    IL_042f: ldloc.3
    IL_0430: ldc.i4.1
    IL_0431: sub
    IL_0432: stloc.s 4
    IL_0434: ldarg.0
    IL_0435: ldstr ""
    IL_043a: ldc.i4.6
    IL_043b: newarr System.String  /*0x0100001D*/
    IL_0440: dup
    IL_0441: ldc.i4.0
    IL_0442: ldstr "NewTutorial/buildHousesA"
    IL_0447: ldc.i4.1
    IL_0448: ldc.i4.0
    IL_0449: ldc.i4.1
    IL_044a: ldc.i4.1
    IL_044b: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0450: stelem.ref
    IL_0451: dup
    IL_0452: ldc.i4.1
    IL_0453: ldstr "\n<style=highlighted>"
    IL_0458: stelem.ref
    IL_0459: dup
    IL_045a: ldc.i4.2
    IL_045b: ldloca.s 4
    IL_045d: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0462: stelem.ref
    IL_0463: dup
    IL_0464: ldc.i4.3
    IL_0465: ldstr "/3 "
    IL_046a: stelem.ref
    IL_046b: dup
    IL_046c: ldc.i4.4
    IL_046d: ldstr "NewTutorial/buildHousesB"
    IL_0472: ldc.i4.1
    IL_0473: ldc.i4.0
    IL_0474: ldc.i4.1
    IL_0475: ldc.i4.1
    IL_0476: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_047b: stelem.ref
    IL_047c: dup
    IL_047d: ldc.i4.5
    IL_047e: ldstr "</style>"
    IL_0483: stelem.ref
    IL_0484: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_0489: call void TutorialManager::SetTutorialTip(string,string)  /*0x06000F25*/
    IL_048e: ldarg.0
    IL_048f: ldfld PlayerInteraction TutorialManager::playerInteraction  /*0x04001180*/
    IL_0494: callvirt InteractorBase PlayerInteraction::get_FocussedInteractor()  /*0x06000C08*/
    IL_0499: ldnull
    IL_049a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_049f: brfalse IL_0544
    IL_04a4: ldarg.0
    IL_04a5: ldfld PlayerInteraction TutorialManager::playerInteraction  /*0x04001180*/
    IL_04aa: callvirt InteractorBase PlayerInteraction::get_FocussedInteractor()  /*0x06000C08*/
    IL_04af: callvirt Type System.Object::GetType()  /*0x0A0002B4*/
    IL_04b4: ldtoken BuildingInteractor  /*0x02000230*/
    IL_04b9: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_04be: call bool System.Type::op_Equality(System.Type,System.Type)  /*0x0A0002B6*/
    IL_04c3: brfalse.s IL_0544
    IL_04c5: ldarg.0
    IL_04c6: ldc.i4.0
    IL_04c7: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_04cc: ldc.i4.0
    IL_04cd: call void TutorialManager::SetArrowMarker(bool,UnityEngine.Vector3,bool)  /*0x06000F1E*/
    IL_04d2: ldloc.s 4
    IL_04d4: brtrue.s IL_0544
    IL_04d6: ldarg.0
    IL_04d7: ldfld TooltipManager TutorialManager::tooltipManager  /*0x04001182*/
    IL_04dc: callvirt void TooltipManager::SetTutorialOverrideToNone()  /*0x06000F0E*/
    IL_04e1: ldarg.0
    IL_04e2: ldstr "NewTutorial/build"
    IL_04e7: ldc.i4.1
    IL_04e8: ldc.i4.0
    IL_04e9: ldc.i4.1
    IL_04ea: ldc.i4.1
    IL_04eb: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_04f0: ldc.i4.6
    IL_04f1: newarr System.String  /*0x0100001D*/
    IL_04f6: dup
    IL_04f7: ldc.i4.0
    IL_04f8: ldstr "NewTutorial/buildHousesA"
    IL_04fd: ldc.i4.1
    IL_04fe: ldc.i4.0
    IL_04ff: ldc.i4.1
    IL_0500: ldc.i4.1
    IL_0501: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0506: stelem.ref
    IL_0507: dup
    IL_0508: ldc.i4.1
    IL_0509: ldstr "\n<style=highlighted>"
    IL_050e: stelem.ref
    IL_050f: dup
    IL_0510: ldc.i4.2
    IL_0511: ldloca.s 4
    IL_0513: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0518: stelem.ref
    IL_0519: dup
    IL_051a: ldc.i4.3
    IL_051b: ldstr "/3 "
    IL_0520: stelem.ref
    IL_0521: dup
    IL_0522: ldc.i4.4
    IL_0523: ldstr "NewTutorial/buildHousesB"
    IL_0528: ldc.i4.1
    IL_0529: ldc.i4.0
    IL_052a: ldc.i4.1
    IL_052b: ldc.i4.1
    IL_052c: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0531: stelem.ref
    IL_0532: dup
    IL_0533: ldc.i4.5
    IL_0534: ldstr "</style>"
    IL_0539: stelem.ref
    IL_053a: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_053f: call void TutorialManager::SetTutorialTip(string,string)  /*0x06000F25*/
    IL_0544: ldloc.3
    IL_0545: ldc.i4.4
    IL_0546: blt.s IL_054f
    IL_0548: ldarg.0
    IL_0549: ldc.i4.1
    IL_054a: stfld bool TutorialManager::housesBuilt  /*0x04001198*/
    IL_054f: ret
    IL_0550: ldarg.0
    IL_0551: ldfld bool TutorialManager::secondNightStarted  /*0x04001199*/
    IL_0556: brtrue.s IL_058d
    IL_0558: ldarg.0
    IL_0559: ldfld bool TutorialManager::housesBuilt  /*0x04001198*/
    IL_055e: brfalse.s IL_058d
    IL_0560: ldarg.0
    IL_0561: ldc.i4.1
    IL_0562: stfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_0567: ldarg.0
    IL_0568: ldstr ""
    IL_056d: ldstr "NewTutorial/startNightAfterHouses"
    IL_0572: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0577: ldarg.0
    IL_0578: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_057d: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0582: ldc.i4.1
    IL_0583: bne.un.s IL_058c
    IL_0585: ldarg.0
    IL_0586: ldc.i4.1
    IL_0587: stfld bool TutorialManager::secondNightStarted  /*0x04001199*/
    IL_058c: ret
    IL_058d: ldarg.0
    IL_058e: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_0593: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0598: ldc.i4.1
    IL_0599: bne.un.s IL_05db
    IL_059b: ldarg.0
    IL_059c: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_05a1: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_05a6: ldc.i4.1
    IL_05a7: bne.un.s IL_05db
    IL_05a9: ldarg.0
    IL_05aa: ldc.i4.1
    IL_05ab: ldc.i4.1
    IL_05ac: call void TutorialManager::MarkNearestObjectWithTag(TagManager.ETag,bool)  /*0x06000F1F*/
    IL_05b1: ldarg.0
    IL_05b2: ldc.i4.0
    IL_05b3: stfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_05b8: ldarg.0
    IL_05b9: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_05be: callvirt float EnemySpawner::get_LastSpawnPeriodClock()  /*0x06000676*/
    IL_05c3: ldc.r4 4.5f
    IL_05c8: ble.un.s IL_05da
    IL_05ca: ldarg.0
    IL_05cb: ldstr ""
    IL_05d0: ldstr "NewTutorial/rememberMeleeAttack"
    IL_05d5: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_05da: ret
    IL_05db: ldarg.0
    IL_05dc: ldfld bool TutorialManager::towersBuilt  /*0x0400119B*/
    IL_05e1: brtrue IL_069d
    IL_05e6: ldarg.0
    IL_05e7: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_05ec: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_05f1: brtrue IL_069d
    IL_05f6: ldarg.0
    IL_05f7: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_05fc: callvirt bool DayNightCycle::get_AfterSunrise()  /*0x060003A4*/
    IL_0601: brtrue.s IL_0604
    IL_0603: ret
    IL_0604: ldarg.0
    IL_0605: ldarg.0
    IL_0606: ldfld List<BuildSlot> TutorialManager::towers  /*0x0400119A*/
    IL_060b: call void TutorialManager::MarkNearestUnbuiltBuilding(System.Collections.Generic.List<BuildSlot>)  /*0x06000F20*/
    IL_0610: ldarg.0
    IL_0611: ldfld PlayerInteraction TutorialManager::playerInteraction  /*0x04001180*/
    IL_0616: callvirt InteractorBase PlayerInteraction::get_FocussedInteractor()  /*0x06000C08*/
    IL_061b: ldnull
    IL_061c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0621: brfalse.s IL_0651
    IL_0623: ldarg.0
    IL_0624: ldfld PlayerInteraction TutorialManager::playerInteraction  /*0x04001180*/
    IL_0629: callvirt InteractorBase PlayerInteraction::get_FocussedInteractor()  /*0x06000C08*/
    IL_062e: callvirt Type System.Object::GetType()  /*0x0A0002B4*/
    IL_0633: ldtoken BuildingInteractor  /*0x02000230*/
    IL_0638: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_063d: call bool System.Type::op_Equality(System.Type,System.Type)  /*0x0A0002B6*/
    IL_0642: brfalse.s IL_0651
    IL_0644: ldarg.0
    IL_0645: ldc.i4.0
    IL_0646: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_064b: ldc.i4.0
    IL_064c: call void TutorialManager::SetArrowMarker(bool,UnityEngine.Vector3,bool)  /*0x06000F1E*/
    IL_0651: ldarg.0
    IL_0652: ldfld TagManager TutorialManager::tagManager  /*0x04001183*/
    IL_0657: ldc.i4.8
    IL_0658: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_065d: ldc.i4.4
    IL_065e: sub
    IL_065f: stloc.s 5
    IL_0661: ldarg.0
    IL_0662: ldstr ""
    IL_0667: ldstr "NewTutorial/buildDefenses"
    IL_066c: ldc.i4.1
    IL_066d: ldc.i4.0
    IL_066e: ldc.i4.1
    IL_066f: ldc.i4.1
    IL_0670: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0675: ldstr " <style=highlighted>("
    IL_067a: ldloca.s 5
    IL_067c: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0681: ldstr "/2)</style>"
    IL_0686: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_068b: call void TutorialManager::SetTutorialTip(string,string)  /*0x06000F25*/
    IL_0690: ldloc.s 5
    IL_0692: ldc.i4.2
    IL_0693: blt.s IL_069c
    IL_0695: ldarg.0
    IL_0696: ldc.i4.1
    IL_0697: stfld bool TutorialManager::towersBuilt  /*0x0400119B*/
    IL_069c: ret
    IL_069d: ldarg.0
    IL_069e: ldfld bool TutorialManager::thirdNightStarted  /*0x0400119D*/
    IL_06a3: brtrue.s IL_06da
    IL_06a5: ldarg.0
    IL_06a6: ldfld bool TutorialManager::towersBuilt  /*0x0400119B*/
    IL_06ab: brfalse.s IL_06da
    IL_06ad: ldarg.0
    IL_06ae: ldc.i4.1
    IL_06af: stfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_06b4: ldarg.0
    IL_06b5: ldstr ""
    IL_06ba: ldstr "NewTutorial/defensesDone"
    IL_06bf: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_06c4: ldarg.0
    IL_06c5: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_06ca: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_06cf: ldc.i4.1
    IL_06d0: bne.un.s IL_06d9
    IL_06d2: ldarg.0
    IL_06d3: ldc.i4.1
    IL_06d4: stfld bool TutorialManager::thirdNightStarted  /*0x0400119D*/
    IL_06d9: ret
    IL_06da: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_06df: callvirt bool ChoiceManager::get_ChoiceCoroutineRunning()  /*0x0600091E*/
    IL_06e4: brfalse.s IL_0702
    IL_06e6: ldarg.0
    IL_06e7: ldc.r4 0f
    IL_06ec: stfld float TutorialManager::showCastleCenterTimer  /*0x040011A5*/
    IL_06f1: ldarg.0
    IL_06f2: ldstr ""
    IL_06f7: ldstr "NewTutorial/chooseAnUpgrade"
    IL_06fc: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0701: ret
    IL_0702: ldarg.0
    IL_0703: ldfld bool TutorialManager::thirdNightStarted  /*0x0400119D*/
    IL_0708: brfalse IL_07cf
    IL_070d: ldarg.0
    IL_070e: ldfld bool TutorialManager::castleCenterUpgraded  /*0x040011A1*/
    IL_0713: brtrue IL_07cf
    IL_0718: ldarg.0
    IL_0719: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_071e: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0723: brtrue IL_07cf
    IL_0728: ldarg.0
    IL_0729: ldc.i4.0
    IL_072a: stfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_072f: ldarg.0
    IL_0730: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_0735: callvirt bool DayNightCycle::get_AfterSunrise()  /*0x060003A4*/
    IL_073a: brtrue.s IL_073d
    IL_073c: ret
    IL_073d: ldarg.0
    IL_073e: ldfld float TutorialManager::showCastleCenterTimer  /*0x040011A5*/
    IL_0743: ldc.r4 0.5f
    IL_0748: ble.un.s IL_079d
    IL_074a: ldarg.0
    IL_074b: ldfld PlayerInteraction TutorialManager::playerInteraction  /*0x04001180*/
    IL_0750: callvirt InteractorBase PlayerInteraction::get_FocussedInteractor()  /*0x06000C08*/
    IL_0755: ldarg.0
    IL_0756: ldfld BuildingInteractor TutorialManager::caslteBuildInteractor  /*0x04001192*/
    IL_075b: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0760: brfalse.s IL_0773
    IL_0762: ldarg.0
    IL_0763: ldstr "NewTutorial/howToUpgrade"
    IL_0768: ldstr "NewTutorial/letsUpgradeCastleCenter"
    IL_076d: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0772: ret
    IL_0773: ldarg.0
    IL_0774: ldc.i4.1
    IL_0775: ldarg.0
    IL_0776: ldfld BuildingInteractor TutorialManager::caslteBuildInteractor  /*0x04001192*/
    IL_077b: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0780: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0785: ldc.i4.0
    IL_0786: call void TutorialManager::SetArrowMarker(bool,UnityEngine.Vector3,bool)  /*0x06000F1E*/
    IL_078b: ldarg.0
    IL_078c: ldstr ""
    IL_0791: ldstr "NewTutorial/letsUpgradeCastleCenter"
    IL_0796: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_079b: br.s IL_07b0
    IL_079d: ldarg.0
    IL_079e: ldarg.0
    IL_079f: ldfld float TutorialManager::showCastleCenterTimer  /*0x040011A5*/
    IL_07a4: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_07a9: add
    IL_07aa: stfld float TutorialManager::showCastleCenterTimer  /*0x040011A5*/
    IL_07af: ret
    IL_07b0: ldarg.0
    IL_07b1: ldfld BuildSlot TutorialManager::caslteBuilSlot  /*0x0400119E*/
    IL_07b6: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_07bb: ldc.i4.2
    IL_07bc: bne.un.s IL_07ce
    IL_07be: ldarg.0
    IL_07bf: ldc.i4.1
    IL_07c0: stfld bool TutorialManager::castleCenterUpgraded  /*0x040011A1*/
    IL_07c5: ldarg.0
    IL_07c6: ldc.i4.1
    IL_07c7: stfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_07cc: br.s IL_07cf
    IL_07ce: ret
    IL_07cf: ldarg.0
    IL_07d0: ldfld bool TutorialManager::fourthNightStarted  /*0x040011A2*/
    IL_07d5: brtrue.s IL_084a
    IL_07d7: ldarg.0
    IL_07d8: ldfld bool TutorialManager::castleCenterUpgraded  /*0x040011A1*/
    IL_07dd: brfalse.s IL_084a
    IL_07df: ldarg.0
    IL_07e0: ldc.i4.1
    IL_07e1: stfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_07e6: ldarg.0
    IL_07e7: ldfld GameObject TutorialManager::royalTraining  /*0x0400119F*/
    IL_07ec: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_07f1: brfalse.s IL_0805
    IL_07f3: ldarg.0
    IL_07f4: ldstr ""
    IL_07f9: ldstr "NewTutorial/ccUpgrade1"
    IL_07fe: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0803: br.s IL_0834
    IL_0805: ldarg.0
    IL_0806: ldfld GameObject TutorialManager::buildersGuild  /*0x040011A0*/
    IL_080b: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0810: brfalse.s IL_0824
    IL_0812: ldarg.0
    IL_0813: ldstr ""
    IL_0818: ldstr "NewTutorial/ccUpgrade2"
    IL_081d: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0822: br.s IL_0834
    IL_0824: ldarg.0
    IL_0825: ldstr ""
    IL_082a: ldstr "NewTutorial/ccUpgrade3"
    IL_082f: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0834: ldarg.0
    IL_0835: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_083a: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_083f: ldc.i4.1
    IL_0840: bne.un.s IL_0849
    IL_0842: ldarg.0
    IL_0843: ldc.i4.1
    IL_0844: stfld bool TutorialManager::fourthNightStarted  /*0x040011A2*/
    IL_0849: ret
    IL_084a: ldarg.0
    IL_084b: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_0850: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0855: ldc.i4.3
    IL_0856: bne.un.s IL_086e
    IL_0858: ldarg.0
    IL_0859: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_085e: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0863: ldc.i4.1
    IL_0864: bne.un.s IL_086e
    IL_0866: ldarg.0
    IL_0867: ldc.i4.0
    IL_0868: stfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_086d: ret
    IL_086e: ldarg.0
    IL_086f: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_0874: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0879: ldc.i4.3
    IL_087a: blt.s IL_0887
    IL_087c: ldsfld TooltipManager TooltipManager::instance  /*0x04001167*/
    IL_0881: ldc.i4.0
    IL_0882: stfld bool TooltipManager::hideAllTooltips  /*0x04001168*/
    IL_0887: ldarg.0
    IL_0888: ldfld BuildSlot TutorialManager::barracks  /*0x040011A3*/
    IL_088d: callvirt BuildSlot.BuildingState BuildSlot::get_State()  /*0x060002D9*/
    IL_0892: ldc.i4.1
    IL_0893: bne.un IL_0a50
    IL_0898: ldarg.0
    IL_0899: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_089e: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_08a3: brtrue IL_0a50
    IL_08a8: ldarg.0
    IL_08a9: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_08ae: callvirt bool DayNightCycle::get_AfterSunrise()  /*0x060003A4*/
    IL_08b3: brtrue.s IL_08b6
    IL_08b5: ret
    IL_08b6: ldarg.0
    IL_08b7: ldc.i4.0
    IL_08b8: stfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_08bd: ldarg.0
    IL_08be: ldfld int TutorialManager::unitSelectionTutorialProgress  /*0x040011A7*/
    IL_08c3: brtrue.s IL_0909
    IL_08c5: ldarg.0
    IL_08c6: ldfld CommandUnits TutorialManager::command  /*0x040011A4*/
    IL_08cb: callvirt List<PathfindMovementPlayerunit> CommandUnits::get_PlayerUnitsCommanding()  /*0x06000AF5*/
    IL_08d0: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_08d5: ldc.i4.0
    IL_08d6: ble.s IL_08ea
    IL_08d8: ldarg.0
    IL_08d9: ldfld Player TutorialManager::input  /*0x040011AB*/
    IL_08de: ldstr "Command Units"
    IL_08e3: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_08e8: brfalse.s IL_08fb
    IL_08ea: ldarg.0
    IL_08eb: ldstr "NewTutorial/unitCommandA"
    IL_08f0: ldstr "NewTutorial/unitCommandB"
    IL_08f5: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_08fa: ret
    IL_08fb: ldarg.0
    IL_08fc: ldarg.0
    IL_08fd: ldfld int TutorialManager::unitSelectionTutorialProgress  /*0x040011A7*/
    IL_0902: ldc.i4.1
    IL_0903: add
    IL_0904: stfld int TutorialManager::unitSelectionTutorialProgress  /*0x040011A7*/
    IL_0909: ldarg.0
    IL_090a: ldfld int TutorialManager::unitSelectionTutorialProgress  /*0x040011A7*/
    IL_090f: ldc.i4.1
    IL_0910: bne.un.s IL_0944
    IL_0912: ldarg.0
    IL_0913: ldfld CommandUnits TutorialManager::command  /*0x040011A4*/
    IL_0918: callvirt List<PathfindMovementPlayerunit> CommandUnits::get_PlayerUnitsCommanding()  /*0x06000AF5*/
    IL_091d: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_0922: ldc.i4.0
    IL_0923: ble.s IL_0936
    IL_0925: ldarg.0
    IL_0926: ldstr "NewTutorial/unitCommandC"
    IL_092b: ldstr "NewTutorial/unitCommandD"
    IL_0930: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0935: ret
    IL_0936: ldarg.0
    IL_0937: ldarg.0
    IL_0938: ldfld int TutorialManager::unitSelectionTutorialProgress  /*0x040011A7*/
    IL_093d: ldc.i4.1
    IL_093e: add
    IL_093f: stfld int TutorialManager::unitSelectionTutorialProgress  /*0x040011A7*/
    IL_0944: ldarg.0
    IL_0945: ldfld int TutorialManager::unitSelectionTutorialProgress  /*0x040011A7*/
    IL_094a: ldc.i4.2
    IL_094b: bne.un.s IL_0991
    IL_094d: ldarg.0
    IL_094e: ldfld CommandUnits TutorialManager::command  /*0x040011A4*/
    IL_0953: callvirt List<PathfindMovementPlayerunit> CommandUnits::get_PlayerUnitsCommanding()  /*0x06000AF5*/
    IL_0958: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_095d: ldc.i4.0
    IL_095e: ble.s IL_0972
    IL_0960: ldarg.0
    IL_0961: ldfld Player TutorialManager::input  /*0x040011AB*/
    IL_0966: ldstr "Command Units"
    IL_096b: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_0970: brfalse.s IL_0983
    IL_0972: ldarg.0
    IL_0973: ldstr "NewTutorial/unitCommandE"
    IL_0978: ldstr "NewTutorial/unitCommandF"
    IL_097d: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0982: ret
    IL_0983: ldarg.0
    IL_0984: ldarg.0
    IL_0985: ldfld int TutorialManager::unitSelectionTutorialProgress  /*0x040011A7*/
    IL_098a: ldc.i4.1
    IL_098b: add
    IL_098c: stfld int TutorialManager::unitSelectionTutorialProgress  /*0x040011A7*/
    IL_0991: ldarg.0
    IL_0992: ldfld int TutorialManager::unitSelectionTutorialProgress  /*0x040011A7*/
    IL_0997: ldc.i4.3
    IL_0998: bne.un.s IL_09cc
    IL_099a: ldarg.0
    IL_099b: ldfld CommandUnits TutorialManager::command  /*0x040011A4*/
    IL_09a0: callvirt List<PathfindMovementPlayerunit> CommandUnits::get_PlayerUnitsCommanding()  /*0x06000AF5*/
    IL_09a5: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_09aa: ldc.i4.0
    IL_09ab: ble.s IL_09be
    IL_09ad: ldarg.0
    IL_09ae: ldstr "NewTutorial/unitCommandG"
    IL_09b3: ldstr "NewTutorial/unitCommandH"
    IL_09b8: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_09bd: ret
    IL_09be: ldarg.0
    IL_09bf: ldarg.0
    IL_09c0: ldfld int TutorialManager::unitSelectionTutorialProgress  /*0x040011A7*/
    IL_09c5: ldc.i4.1
    IL_09c6: add
    IL_09c7: stfld int TutorialManager::unitSelectionTutorialProgress  /*0x040011A7*/
    IL_09cc: ldarg.0
    IL_09cd: ldfld int TutorialManager::unitSelectionTutorialProgress  /*0x040011A7*/
    IL_09d2: ldc.i4.4
    IL_09d3: bne.un.s IL_0a49
    IL_09d5: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_09da: stloc.s 6
    IL_09dc: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_09e1: ldloc.s 6
    IL_09e3: ldc.i4.7
    IL_09e4: callvirt void TagManager::FindAllTaggedObjectsWithTag(System.Collections.Generic.List<TaggedObject>,TagManager.ETag)  /*0x06000E5C*/
    IL_09e9: ldc.i4.0
    IL_09ea: stloc.s 7
    IL_09ec: ldloc.s 6
    IL_09ee: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_09f3: stloc.s 8
    IL_09f5: br.s IL_0a0d
    IL_09f7: ldloca.s 8
    IL_09f9: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_09fe: callvirt !!0 UnityEngine.Component::GetComponentInChildren()<PathfindMovementPlayerunit>  /*0x2B000006*/
    IL_0a03: callvirt bool PathfindMovementPlayerunit::get_HoldPosition()  /*0x06000B33*/
    IL_0a08: brfalse.s IL_0a0d
    IL_0a0a: ldc.i4.1
    IL_0a0b: stloc.s 7
    IL_0a0d: ldloca.s 8
    IL_0a0f: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0a14: brtrue.s IL_09f7
    IL_0a16: leave.s IL_0a26
    IL_0a18: ldloca.s 8
    IL_0a1a: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0a20: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0a25: endfinally
    IL_0a26: ldloc.s 7
    IL_0a28: brtrue.s IL_0a3b
    IL_0a2a: ldarg.0
    IL_0a2b: ldstr ""
    IL_0a30: ldstr "NewTutorial/unitCommandI"
    IL_0a35: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0a3a: ret
    IL_0a3b: ldarg.0
    IL_0a3c: ldarg.0
    IL_0a3d: ldfld int TutorialManager::unitSelectionTutorialProgress  /*0x040011A7*/
    IL_0a42: ldc.i4.1
    IL_0a43: add
    IL_0a44: stfld int TutorialManager::unitSelectionTutorialProgress  /*0x040011A7*/
    IL_0a49: ldarg.0
    IL_0a4a: ldc.i4.1
    IL_0a4b: stfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_0a50: ldarg.0
    IL_0a51: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_0a56: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0a5b: ldc.i4.3
    IL_0a5c: bne.un IL_0af8
    IL_0a61: ldarg.0
    IL_0a62: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_0a67: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0a6c: brtrue IL_0af8
    IL_0a71: ldarg.0
    IL_0a72: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_0a77: callvirt bool DayNightCycle::get_AfterSunrise()  /*0x060003A4*/
    IL_0a7c: brtrue.s IL_0a7f
    IL_0a7e: ret
    IL_0a7f: ldarg.0
    IL_0a80: ldc.i4.1
    IL_0a81: stfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_0a86: ldarg.0
    IL_0a87: ldfld bool TutorialManager::previewBuildingsUsed  /*0x0400119C*/
    IL_0a8c: brtrue.s IL_0abf
    IL_0a8e: ldarg.0
    IL_0a8f: ldfld Player TutorialManager::input  /*0x040011AB*/
    IL_0a94: ldstr "Preview Build Options"
    IL_0a99: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0a9e: brfalse.s IL_0aa7
    IL_0aa0: ldarg.0
    IL_0aa1: ldc.i4.1
    IL_0aa2: stfld bool TutorialManager::previewBuildingsUsed  /*0x0400119C*/
    IL_0aa7: ldarg.0
    IL_0aa8: ldstr "NewTutorial/previewBuildOptionsA"
    IL_0aad: ldstr "NewTutorial/previewBuildOptionsB"
    IL_0ab2: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0ab7: ldarg.0
    IL_0ab8: ldc.i4.0
    IL_0ab9: stfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_0abe: ret
    IL_0abf: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0ac4: callvirt int PlayerInteraction::get_Balance()  /*0x06000C04*/
    IL_0ac9: ldc.i4.1
    IL_0aca: ble.s IL_0ae7
    IL_0acc: ldarg.0
    IL_0acd: ldfld TooltipManager TutorialManager::tooltipManager  /*0x04001182*/
    IL_0ad2: ldstr "NewTutorial/upToYouNow"
    IL_0ad7: ldc.i4.1
    IL_0ad8: ldc.i4.0
    IL_0ad9: ldc.i4.1
    IL_0ada: ldc.i4.1
    IL_0adb: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0ae0: ldc.i4.0
    IL_0ae1: callvirt void TooltipManager::SetTutorialOverride(string,bool)  /*0x06000F0F*/
    IL_0ae6: ret
    IL_0ae7: ldarg.0
    IL_0ae8: ldstr ""
    IL_0aed: ldstr "NewTutorial/lateStartNightTip"
    IL_0af2: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0af7: ret
    IL_0af8: ldarg.0
    IL_0af9: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_0afe: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0b03: ldc.i4.4
    IL_0b04: bne.un.s IL_0b37
    IL_0b06: ldarg.0
    IL_0b07: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_0b0c: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0b11: ldc.i4.1
    IL_0b12: bne.un.s IL_0b37
    IL_0b14: ldarg.0
    IL_0b15: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_0b1a: callvirt float EnemySpawner::get_LastSpawnPeriodClock()  /*0x06000676*/
    IL_0b1f: ldc.r4 4.5f
    IL_0b24: ble.un.s IL_0b36
    IL_0b26: ldarg.0
    IL_0b27: ldstr ""
    IL_0b2c: ldstr "NewTutorial/healthRegen"
    IL_0b31: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0b36: ret
    IL_0b37: ldarg.0
    IL_0b38: ldc.i4.0
    IL_0b39: stfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_0b3e: ldarg.0
    IL_0b3f: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_0b44: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0b49: ldc.i4.4
    IL_0b4a: blt IL_0bdf
    IL_0b4f: ldarg.0
    IL_0b50: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_0b55: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0b5a: brtrue IL_0bdf
    IL_0b5f: ldarg.0
    IL_0b60: ldfld BuildSlot TutorialManager::barracks  /*0x040011A3*/
    IL_0b65: callvirt BuildSlot.BuildingState BuildSlot::get_State()  /*0x060002D9*/
    IL_0b6a: ldc.i4.1
    IL_0b6b: beq.s IL_0bdf
    IL_0b6d: ldarg.0
    IL_0b6e: ldfld PlayerInteraction TutorialManager::playerInteraction  /*0x04001180*/
    IL_0b73: callvirt int PlayerInteraction::get_Balance()  /*0x06000C04*/
    IL_0b78: ldsfld int CostDisplay::currentlyFilledCoinsFromLastActiveDisplay  /*0x04001304*/
    IL_0b7d: add
    IL_0b7e: ldc.i4.4
    IL_0b7f: blt.s IL_0bdf
    IL_0b81: ldarg.0
    IL_0b82: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_0b87: callvirt bool DayNightCycle::get_AfterSunrise()  /*0x060003A4*/
    IL_0b8c: brtrue.s IL_0b8f
    IL_0b8e: ret
    IL_0b8f: ldarg.0
    IL_0b90: ldstr ""
    IL_0b95: ldstr "NewTutorial/buildBarracks"
    IL_0b9a: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0b9f: ldarg.0
    IL_0ba0: ldfld PlayerInteraction TutorialManager::playerInteraction  /*0x04001180*/
    IL_0ba5: callvirt InteractorBase PlayerInteraction::get_FocussedInteractor()  /*0x06000C08*/
    IL_0baa: ldnull
    IL_0bab: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0bb0: brfalse.s IL_0bde
    IL_0bb2: ldarg.0
    IL_0bb3: ldc.i4.1
    IL_0bb4: ldarg.0
    IL_0bb5: ldfld BuildSlot TutorialManager::barracks  /*0x040011A3*/
    IL_0bba: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0bbf: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0bc4: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0bc9: ldc.r4 3f
    IL_0bce: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0bd3: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0bd8: ldc.i4.0
    IL_0bd9: call void TutorialManager::SetArrowMarker(bool,UnityEngine.Vector3,bool)  /*0x06000F1E*/
    IL_0bde: ret
    IL_0bdf: ldarg.0
    IL_0be0: ldc.i4.1
    IL_0be1: stfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_0be6: ldarg.0
    IL_0be7: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_0bec: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0bf1: ldc.i4.6
    IL_0bf2: bne.un.s IL_0c1c
    IL_0bf4: ldarg.0
    IL_0bf5: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_0bfa: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0bff: brtrue.s IL_0c1c
    IL_0c01: ldarg.0
    IL_0c02: ldfld TooltipManager TutorialManager::tooltipManager  /*0x04001182*/
    IL_0c07: ldstr "NewTutorial/lastDay"
    IL_0c0c: ldc.i4.1
    IL_0c0d: ldc.i4.0
    IL_0c0e: ldc.i4.1
    IL_0c0f: ldc.i4.1
    IL_0c10: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0c15: ldc.i4.0
    IL_0c16: callvirt void TooltipManager::SetTutorialOverride(string,bool)  /*0x06000F0F*/
    IL_0c1b: ret
    IL_0c1c: ldarg.0
    IL_0c1d: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_0c22: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0c27: ldc.i4.7
    IL_0c28: bne.un.s IL_0c7c
    IL_0c2a: ldarg.0
    IL_0c2b: ldfld DayNightCycle TutorialManager::dayNightCycle  /*0x04001181*/
    IL_0c30: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0c35: ldc.i4.1
    IL_0c36: bne.un.s IL_0c7c
    IL_0c38: ldarg.0
    IL_0c39: ldfld bool TutorialManager::lockTargetTried  /*0x040011A6*/
    IL_0c3e: brtrue.s IL_0c7c
    IL_0c40: ldarg.0
    IL_0c41: ldfld Player TutorialManager::input  /*0x040011AB*/
    IL_0c46: ldstr "Lock Target"
    IL_0c4b: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_0c50: brfalse.s IL_0c59
    IL_0c52: ldarg.0
    IL_0c53: ldc.i4.1
    IL_0c54: stfld bool TutorialManager::lockTargetTried  /*0x040011A6*/
    IL_0c59: ldarg.0
    IL_0c5a: ldfld EnemySpawner TutorialManager::enemySpawner  /*0x04001184*/
    IL_0c5f: callvirt float EnemySpawner::get_LastSpawnPeriodClock()  /*0x06000676*/
    IL_0c64: ldc.r4 4.5f
    IL_0c69: ble.un.s IL_0c7b
    IL_0c6b: ldarg.0
    IL_0c6c: ldstr "NewTutorial/lockTarget"
    IL_0c71: ldstr ""
    IL_0c76: call void TutorialManager::SetTutorialTipLocalize(string,string)  /*0x06000F24*/
    IL_0c7b: ret
    IL_0c7c: ret
    .try IL_09f5-IL_0a18 finally handler IL_0a18-IL_0a26

  .method TutorialManager::.ctor()  // token 0x06000F29 rva 0x44cb8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 69 (0x45), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool TutorialManager::allowStartingTheNight  /*0x04001185*/
    IL_0007: ldarg.0
    IL_0008: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_000d: stfld List<TaggedObject> TutorialManager::findTaggedObjects  /*0x040011A8*/
    IL_0012: ldarg.0
    IL_0013: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0018: stfld List<TagManager.ETag> TutorialManager::mustHaveTag  /*0x040011A9*/
    IL_001d: ldarg.0
    IL_001e: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0023: stfld List<TagManager.ETag> TutorialManager::mayNotHaveTag  /*0x040011AA*/
    IL_0028: ldarg.0
    IL_0029: ldstr ""
    IL_002e: stfld string TutorialManager::tipHeader  /*0x040011AC*/
    IL_0033: ldarg.0
    IL_0034: ldstr ""
    IL_0039: stfld string TutorialManager::tipBody  /*0x040011AD*/
    IL_003e: ldarg.0
    IL_003f: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0044: ret

  .method TutorialManager::.cctor()  // token 0x06000F2A rva 0x44d09 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: ldstr "Tutorial/"
    IL_0005: stsfld string TutorialManager::LOCIDENTIFIER  /*0x04001186*/
    IL_000a: ret

