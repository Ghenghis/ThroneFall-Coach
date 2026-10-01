// ===== ETMapChoiceDisplay  (token 0x0200030C) =====
  .method ETMapChoiceDisplay::get_Data()  // token 0x060010D8 rva 0x4dbd9 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MapChoice ETMapChoiceDisplay::data  /*0x04001409*/
    IL_0006: ret

  .method ETMapChoiceDisplay::SetData(MapChoice,ETChoicePickScreen)  // token 0x060010D9 rva 0x4dbe4 attrs Public, HideBySig
    // code size 332 (0x14c), max stack 5, init locals
    .locals ([0] IEnumerator, [1] IDisposable, [2] int, [3] List.Enumerator<ETMapChoiceDisplay.MapIcon>, [4] ETMapChoiceDisplay.MapIcon)
    IL_0000: ldarg.0
    IL_0001: ldarg.2
    IL_0002: stfld ETChoicePickScreen ETMapChoiceDisplay::target  /*0x0400140A*/
    IL_0007: ldarg.0
    IL_0008: ldarg.1
    IL_0009: stfld MapChoice ETMapChoiceDisplay::data  /*0x04001409*/
    IL_000e: ldarg.0
    IL_000f: ldfld Transform ETMapChoiceDisplay::perkGroup  /*0x04001400*/
    IL_0014: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_0019: stloc.0
    IL_001a: br.s IL_0031
    IL_001c: ldloc.0
    IL_001d: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_0022: castclass UnityEngine.Transform  /*0x01000015*/
    IL_0027: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002c: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0031: ldloc.0
    IL_0032: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0037: brtrue.s IL_001c
    IL_0039: leave.s IL_004c
    IL_003b: ldloc.0
    IL_003c: isinst System.IDisposable  /*0x0100001B*/
    IL_0041: stloc.1
    IL_0042: ldloc.1
    IL_0043: brfalse.s IL_004b
    IL_0045: ldloc.1
    IL_0046: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_004b: endfinally
    IL_004c: ldarg.0
    IL_004d: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_0052: ldarg.0
    IL_0053: ldfld MapChoice ETMapChoiceDisplay::data  /*0x04001409*/
    IL_0058: ldfld EquippableWeapon MapChoice::containedWeapon  /*0x0400085B*/
    IL_005d: ldc.i4.0
    IL_005e: ldc.i4.1
    IL_005f: ldnull
    IL_0060: callvirt void TFUIEquippable::SetData(Equippable,bool,bool,LevelInfo)  /*0x06001209*/
    IL_0065: ldarg.0
    IL_0066: ldarg.0
    IL_0067: ldfld MapChoice ETMapChoiceDisplay::data  /*0x04001409*/
    IL_006c: ldfld List<EquippablePerk> MapChoice::containedPerks  /*0x0400085C*/
    IL_0071: callvirt int System.Collections.Generic.List<EquippablePerk>::get_Count()  /*0x0A0002EE*/
    IL_0076: newarr TFUIEquippable  /*0x0200034D*/
    IL_007b: stfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_0080: ldc.i4.0
    IL_0081: stloc.2
    IL_0082: br.s IL_00bf
    IL_0084: ldarg.0
    IL_0085: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_008a: ldloc.2
    IL_008b: ldarg.0
    IL_008c: ldfld TFUIEquippable ETMapChoiceDisplay::perkTFUIPrefab  /*0x040013FF*/
    IL_0091: ldarg.0
    IL_0092: ldfld Transform ETMapChoiceDisplay::perkGroup  /*0x04001400*/
    IL_0097: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<TFUIEquippable>  /*0x2B0000EB*/
    IL_009c: stelem.ref
    IL_009d: ldarg.0
    IL_009e: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_00a3: ldloc.2
    IL_00a4: ldelem.ref
    IL_00a5: ldarg.0
    IL_00a6: ldfld MapChoice ETMapChoiceDisplay::data  /*0x04001409*/
    IL_00ab: ldfld List<EquippablePerk> MapChoice::containedPerks  /*0x0400085C*/
    IL_00b0: ldloc.2
    IL_00b1: callvirt !0 System.Collections.Generic.List<EquippablePerk>::get_Item(int)  /*0x0A0002EF*/
    IL_00b6: callvirt void TFUIEquippable::SetDataEternalTrials(Equippable)  /*0x0600120A*/
    IL_00bb: ldloc.2
    IL_00bc: ldc.i4.1
    IL_00bd: add
    IL_00be: stloc.2
    IL_00bf: ldloc.2
    IL_00c0: ldarg.0
    IL_00c1: ldfld MapChoice ETMapChoiceDisplay::data  /*0x04001409*/
    IL_00c6: ldfld List<EquippablePerk> MapChoice::containedPerks  /*0x0400085C*/
    IL_00cb: callvirt int System.Collections.Generic.List<EquippablePerk>::get_Count()  /*0x0A0002EE*/
    IL_00d0: blt.s IL_0084
    IL_00d2: ldarg.0
    IL_00d3: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_00d8: ldfld UnityEvent ThronefallUIElement::onApply  /*0x04001686*/
    IL_00dd: ldarg.0
    IL_00de: ldftn void ETMapChoiceDisplay::Confirm()  /*0x060010DA*/
    IL_00e4: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00e9: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00ee: ldarg.0
    IL_00ef: ldfld List<ETMapChoiceDisplay.MapIcon> ETMapChoiceDisplay::mapIcons  /*0x04001402*/
    IL_00f4: callvirt List.Enumerator<!0> System.Collections.Generic.List<ETMapChoiceDisplay.MapIcon>::GetEnumerator()  /*0x0A000677*/
    IL_00f9: stloc.3
    IL_00fa: br.s IL_0132
    IL_00fc: ldloca.s 3
    IL_00fe: call !0 System.Collections.Generic.List.Enumerator<ETMapChoiceDisplay.MapIcon>::get_Current()  /*0x0A000678*/
    IL_0103: stloc.s 4
    IL_0105: ldloc.s 4
    IL_0107: ldfld string ETMapChoiceDisplay.MapIcon::mapName  /*0x0400140C*/
    IL_010c: ldarg.0
    IL_010d: ldfld MapChoice ETMapChoiceDisplay::data  /*0x04001409*/
    IL_0112: ldfld string MapChoice::mapName  /*0x0400085A*/
    IL_0117: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_011c: brfalse.s IL_0132
    IL_011e: ldarg.0
    IL_011f: ldfld MPImage ETMapChoiceDisplay::mapPreviewImage  /*0x04001401*/
    IL_0124: ldloc.s 4
    IL_0126: ldfld Sprite ETMapChoiceDisplay.MapIcon::icon  /*0x0400140D*/
    IL_012b: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0130: leave.s IL_014b
    IL_0132: ldloca.s 3
    IL_0134: call bool System.Collections.Generic.List.Enumerator<ETMapChoiceDisplay.MapIcon>::MoveNext()  /*0x0A000679*/
    IL_0139: brtrue.s IL_00fc
    IL_013b: leave.s IL_014b
    IL_013d: ldloca.s 3
    IL_013f: constrained. System.Collections.Generic.List.Enumerator<ETMapChoiceDisplay.MapIcon>  /*0x1B00012B*/
    IL_0145: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_014a: endfinally
    IL_014b: ret
    .try IL_001a-IL_003b finally handler IL_003b-IL_004c
    .try IL_00fa-IL_013d finally handler IL_013d-IL_014b

  .method ETMapChoiceDisplay::Confirm()  // token 0x060010DA rva 0x4dd58 attrs Public, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ETChoicePickScreen ETMapChoiceDisplay::target  /*0x0400140A*/
    IL_0006: ldarg.0
    IL_0007: ldfld MapChoice ETMapChoiceDisplay::data  /*0x04001409*/
    IL_000c: callvirt void ETChoicePickScreen::ConfirmChoice(MapChoice)  /*0x060010C1*/
    IL_0011: ret

  .method ETMapChoiceDisplay::Select()  // token 0x060010DB rva 0x4dd6c attrs Public, HideBySig
    // code size 143 (0x8f), max stack 5, init locals
    .locals ([0] TFUIEquippable[], [1] int)
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000e: callvirt Vector3 UnityEngine.Transform::get_localScale()  /*0x0A00007A*/
    IL_0013: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0018: ldarg.0
    IL_0019: ldfld float ETMapChoiceDisplay::targetScale  /*0x04001408*/
    IL_001e: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0023: ldarg.0
    IL_0024: ldfld float ETMapChoiceDisplay::animationTime  /*0x04001407*/
    IL_0029: call IEnumerator ETMapChoiceDisplay::ScaleAnimation(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x060010DD*/
    IL_002e: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0033: pop
    IL_0034: ldarg.0
    IL_0035: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_003a: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_003f: ldc.i4.1
    IL_0040: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0045: ldarg.0
    IL_0046: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_004b: callvirt void TFUIEquippable::Pick()  /*0x0600120C*/
    IL_0050: ldarg.0
    IL_0051: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_0056: stloc.0
    IL_0057: ldc.i4.0
    IL_0058: stloc.1
    IL_0059: br.s IL_0067
    IL_005b: ldloc.0
    IL_005c: ldloc.1
    IL_005d: ldelem.ref
    IL_005e: callvirt void TFUIEquippable::Pick()  /*0x0600120C*/
    IL_0063: ldloc.1
    IL_0064: ldc.i4.1
    IL_0065: add
    IL_0066: stloc.1
    IL_0067: ldloc.1
    IL_0068: ldloc.0
    IL_0069: ldlen
    IL_006a: conv.i4
    IL_006b: blt.s IL_005b
    IL_006d: ldarg.0
    IL_006e: ldfld MPImage ETMapChoiceDisplay::mapPreviewImage  /*0x04001401*/
    IL_0073: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0078: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_007d: ldarg.0
    IL_007e: ldfld MPImage ETMapChoiceDisplay::mapPreviewImage  /*0x04001401*/
    IL_0083: ldarg.0
    IL_0084: ldfld Color ETMapChoiceDisplay::outlineSelectedCol  /*0x04001404*/
    IL_0089: callvirt void MPUIKIT.MPImage::set_OutlineColor(UnityEngine.Color)  /*0x0A00067A*/
    IL_008e: ret

  .method ETMapChoiceDisplay::Unselect()  // token 0x060010DC rva 0x4de08 attrs Public, HideBySig
    // code size 161 (0xa1), max stack 5, init locals
    .locals ([0] TFUIEquippable[], [1] int)
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000e: callvirt Vector3 UnityEngine.Transform::get_localScale()  /*0x0A00007A*/
    IL_0013: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0018: ldarg.0
    IL_0019: ldfld float ETMapChoiceDisplay::animationTime  /*0x04001407*/
    IL_001e: call IEnumerator ETMapChoiceDisplay::ScaleAnimation(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x060010DD*/
    IL_0023: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0028: pop
    IL_0029: ldarg.0
    IL_002a: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002f: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0034: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0039: ldarg.0
    IL_003a: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_003f: ldc.i4.0
    IL_0040: callvirt void ThronefallUIElement::HardStateSet(ThronefallUIElement.SelectionState)  /*0x060012AE*/
    IL_0045: ldarg.0
    IL_0046: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_004b: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0050: ldc.i4.0
    IL_0051: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0056: ldarg.0
    IL_0057: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_005c: callvirt void TFUIEquippable::UnPick()  /*0x0600120D*/
    IL_0061: ldarg.0
    IL_0062: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_0067: stloc.0
    IL_0068: ldc.i4.0
    IL_0069: stloc.1
    IL_006a: br.s IL_0078
    IL_006c: ldloc.0
    IL_006d: ldloc.1
    IL_006e: ldelem.ref
    IL_006f: callvirt void TFUIEquippable::UnPick()  /*0x0600120D*/
    IL_0074: ldloc.1
    IL_0075: ldc.i4.1
    IL_0076: add
    IL_0077: stloc.1
    IL_0078: ldloc.1
    IL_0079: ldloc.0
    IL_007a: ldlen
    IL_007b: conv.i4
    IL_007c: blt.s IL_006c
    IL_007e: ldarg.0
    IL_007f: ldfld MPImage ETMapChoiceDisplay::mapPreviewImage  /*0x04001401*/
    IL_0084: ldarg.0
    IL_0085: ldfld Color ETMapChoiceDisplay::imageUnselectedCol  /*0x04001403*/
    IL_008a: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_008f: ldarg.0
    IL_0090: ldfld MPImage ETMapChoiceDisplay::mapPreviewImage  /*0x04001401*/
    IL_0095: ldarg.0
    IL_0096: ldfld Color ETMapChoiceDisplay::outlineUnselectedCol  /*0x04001405*/
    IL_009b: callvirt void MPUIKIT.MPImage::set_OutlineColor(UnityEngine.Color)  /*0x0A00067A*/
    IL_00a0: ret

  .method ETMapChoiceDisplay::ScaleAnimation(UnityEngine.Vector3,UnityEngine.Vector3,float)  // token 0x060010DD rva 0x4deb5 attrs Private, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void ETMapChoiceDisplay.<ScaleAnimation>d__22::.ctor(int)  /*0x060010E0*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld ETMapChoiceDisplay ETMapChoiceDisplay.<ScaleAnimation>d__22::<>4__this  /*0x04001410*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld Vector3 ETMapChoiceDisplay.<ScaleAnimation>d__22::startScale  /*0x04001411*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld Vector3 ETMapChoiceDisplay.<ScaleAnimation>d__22::targetScale  /*0x04001412*/
    IL_001b: dup
    IL_001c: ldarg.3
    IL_001d: stfld float ETMapChoiceDisplay.<ScaleAnimation>d__22::time  /*0x04001413*/
    IL_0022: ret

  .method ETMapChoiceDisplay::.ctor()  // token 0x060010DE rva 0x4ded9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<ETMapChoiceDisplay.MapIcon>::.ctor()  /*0x0A00067B*/
    IL_0006: stfld List<ETMapChoiceDisplay.MapIcon> ETMapChoiceDisplay::mapIcons  /*0x04001402*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.3f
    IL_0011: stfld float ETMapChoiceDisplay::animationTime  /*0x04001407*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1.15f
    IL_001c: stfld float ETMapChoiceDisplay::targetScale  /*0x04001408*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

// ===== ETMapChoiceDisplay/MapIcon  (token 0x0200030D) =====
  .method ETMapChoiceDisplay.MapIcon::.ctor()  // token 0x060010DF rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

// ===== ETMapChoiceDisplay/<ScaleAnimation>d__22  (token 0x0200030E) =====
  .method ETMapChoiceDisplay.<ScaleAnimation>d__22::.ctor(int)  // token 0x060010E0 rva 0x4df02 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int ETMapChoiceDisplay.<ScaleAnimation>d__22::<>1__state  /*0x0400140E*/
    IL_000d: ret

  .method ETMapChoiceDisplay.<ScaleAnimation>d__22::System.IDisposable.Dispose()  // token 0x060010E1 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ETMapChoiceDisplay.<ScaleAnimation>d__22::MoveNext()  // token 0x060010E2 rva 0x4df14 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 198 (0xc6), max stack 7, init locals
    .locals ([0] int, [1] ETMapChoiceDisplay)
    IL_0000: ldarg.0
    IL_0001: ldfld int ETMapChoiceDisplay.<ScaleAnimation>d__22::<>1__state  /*0x0400140E*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld ETMapChoiceDisplay ETMapChoiceDisplay.<ScaleAnimation>d__22::<>4__this  /*0x04001410*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_009e
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int ETMapChoiceDisplay.<ScaleAnimation>d__22::<>1__state  /*0x0400140E*/
    IL_0021: ldloc.1
    IL_0022: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0027: ldarg.0
    IL_0028: ldfld Vector3 ETMapChoiceDisplay.<ScaleAnimation>d__22::startScale  /*0x04001411*/
    IL_002d: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0032: ldarg.0
    IL_0033: ldc.r4 0f
    IL_0038: stfld float ETMapChoiceDisplay.<ScaleAnimation>d__22::<clock>5__2  /*0x04001414*/
    IL_003d: br.s IL_00a5
    IL_003f: ldarg.0
    IL_0040: ldarg.0
    IL_0041: ldfld float ETMapChoiceDisplay.<ScaleAnimation>d__22::<clock>5__2  /*0x04001414*/
    IL_0046: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_004b: add
    IL_004c: stfld float ETMapChoiceDisplay.<ScaleAnimation>d__22::<clock>5__2  /*0x04001414*/
    IL_0051: ldloc.1
    IL_0052: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0057: ldarg.0
    IL_0058: ldfld Vector3 ETMapChoiceDisplay.<ScaleAnimation>d__22::startScale  /*0x04001411*/
    IL_005d: ldarg.0
    IL_005e: ldfld Vector3 ETMapChoiceDisplay.<ScaleAnimation>d__22::targetScale  /*0x04001412*/
    IL_0063: ldloc.1
    IL_0064: ldfld AnimationCurve ETMapChoiceDisplay::scaleAnimationCurve  /*0x04001406*/
    IL_0069: ldc.r4 0f
    IL_006e: ldarg.0
    IL_006f: ldfld float ETMapChoiceDisplay.<ScaleAnimation>d__22::time  /*0x04001413*/
    IL_0074: ldarg.0
    IL_0075: ldfld float ETMapChoiceDisplay.<ScaleAnimation>d__22::<clock>5__2  /*0x04001414*/
    IL_007a: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_007f: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0084: call Vector3 UnityEngine.Vector3::LerpUnclamped(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A0001BB*/
    IL_0089: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_008e: ldarg.0
    IL_008f: ldnull
    IL_0090: stfld object ETMapChoiceDisplay.<ScaleAnimation>d__22::<>2__current  /*0x0400140F*/
    IL_0095: ldarg.0
    IL_0096: ldc.i4.1
    IL_0097: stfld int ETMapChoiceDisplay.<ScaleAnimation>d__22::<>1__state  /*0x0400140E*/
    IL_009c: ldc.i4.1
    IL_009d: ret
    IL_009e: ldarg.0
    IL_009f: ldc.i4.m1
    IL_00a0: stfld int ETMapChoiceDisplay.<ScaleAnimation>d__22::<>1__state  /*0x0400140E*/
    IL_00a5: ldarg.0
    IL_00a6: ldfld float ETMapChoiceDisplay.<ScaleAnimation>d__22::<clock>5__2  /*0x04001414*/
    IL_00ab: ldarg.0
    IL_00ac: ldfld float ETMapChoiceDisplay.<ScaleAnimation>d__22::time  /*0x04001413*/
    IL_00b1: ble.s IL_003f
    IL_00b3: ldloc.1
    IL_00b4: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00b9: ldarg.0
    IL_00ba: ldfld Vector3 ETMapChoiceDisplay.<ScaleAnimation>d__22::targetScale  /*0x04001412*/
    IL_00bf: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00c4: ldc.i4.0
    IL_00c5: ret

  .method ETMapChoiceDisplay.<ScaleAnimation>d__22::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060010E3 rva 0x4dfe6 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object ETMapChoiceDisplay.<ScaleAnimation>d__22::<>2__current  /*0x0400140F*/
    IL_0006: ret

  .method ETMapChoiceDisplay.<ScaleAnimation>d__22::System.Collections.IEnumerator.Reset()  // token 0x060010E4 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method ETMapChoiceDisplay.<ScaleAnimation>d__22::System.Collections.IEnumerator.get_Current()  // token 0x060010E5 rva 0x4dfe6 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object ETMapChoiceDisplay.<ScaleAnimation>d__22::<>2__current  /*0x0400140F*/
    IL_0006: ret

