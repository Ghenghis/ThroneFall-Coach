// ===== CostDisplay  (token 0x020002EB) =====
  .method CostDisplay::get_CompletelyFilled()  // token 0x06001011 rva 0x49500 attrs Public, HideBySig, SpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int CostDisplay::currentlyFilledCoins  /*0x040012FC*/
    IL_0006: ldarg.0
    IL_0007: ldfld int CostDisplay::currentAmount  /*0x040012FB*/
    IL_000c: clt
    IL_000e: ldc.i4.0
    IL_000f: ceq
    IL_0011: ret

  .method CostDisplay::get_CompletelyEmpty()  // token 0x06001012 rva 0x49513 attrs Public, HideBySig, SpecialName
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int CostDisplay::currentlyFilledCoins  /*0x040012FC*/
    IL_0006: ldc.i4.0
    IL_0007: cgt
    IL_0009: ldc.i4.0
    IL_000a: ceq
    IL_000c: ret

  .method CostDisplay::Start()  // token 0x06001013 rva 0x49524 attrs Private, HideBySig
    // code size 113 (0x71), max stack 4, init locals
    .locals ([0] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Coinslot CostDisplay::coinslotPrefab  /*0x040012E9*/
    IL_0007: callvirt !!0 UnityEngine.Component::GetComponent()<UnityEngine.RectTransform>  /*0x2B0000D8*/
    IL_000c: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0011: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0016: stfld float CostDisplay::elementWidth  /*0x040012F7*/
    IL_001b: ldarg.0
    IL_001c: ldfld int CostDisplay::maxElementsPerRow  /*0x040012ED*/
    IL_0021: conv.r4
    IL_0022: ldarg.0
    IL_0023: ldfld float CostDisplay::elementWidth  /*0x040012F7*/
    IL_0028: mul
    IL_0029: ldarg.0
    IL_002a: ldfld int CostDisplay::maxElementsPerRow  /*0x040012ED*/
    IL_002f: ldc.i4.1
    IL_0030: sub
    IL_0031: conv.r4
    IL_0032: ldarg.0
    IL_0033: ldfld float CostDisplay::horizontalSpacing  /*0x040012EC*/
    IL_0038: mul
    IL_0039: add
    IL_003a: stloc.0
    IL_003b: ldarg.0
    IL_003c: ldloc.0
    IL_003d: neg
    IL_003e: ldc.r4 2f
    IL_0043: div
    IL_0044: ldarg.0
    IL_0045: ldfld float CostDisplay::elementWidth  /*0x040012F7*/
    IL_004a: ldc.r4 2f
    IL_004f: div
    IL_0050: add
    IL_0051: stfld float CostDisplay::yCurveLeftAnchor  /*0x040012F8*/
    IL_0056: ldarg.0
    IL_0057: ldloc.0
    IL_0058: ldc.r4 2f
    IL_005d: div
    IL_005e: ldarg.0
    IL_005f: ldfld float CostDisplay::elementWidth  /*0x040012F7*/
    IL_0064: ldc.r4 2f
    IL_0069: div
    IL_006a: sub
    IL_006b: stfld float CostDisplay::yCurveRightAnchor  /*0x040012F9*/
    IL_0070: ret

  .method CostDisplay::Update()  // token 0x06001014 rva 0x495a1 attrs Private, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool CostDisplay::reUpdateBecauseFuckUnityCanvas  /*0x040012FA*/
    IL_0006: brfalse.s IL_0015
    IL_0008: ldarg.0
    IL_0009: ldarg.0
    IL_000a: ldfld int CostDisplay::currentAmount  /*0x040012FB*/
    IL_000f: ldc.i4.0
    IL_0010: call void CostDisplay::UpdateDisplay(int,bool)  /*0x06001017*/
    IL_0015: ret

  .method CostDisplay::SetClearCoinPoolFlag()  // token 0x06001015 rva 0x495b8 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool CostDisplay::clearCoinPoolFlag  /*0x04001303*/
    IL_0007: ret

  .method CostDisplay::ClearCoinPool()  // token 0x06001016 rva 0x495c4 attrs Private, HideBySig
    // code size 94 (0x5e), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld List<Coinslot> CostDisplay::currentlyActiveCoinslots  /*0x040012F6*/
    IL_0006: callvirt int System.Collections.Generic.List<Coinslot>::get_Count()  /*0x0A000656*/
    IL_000b: ldc.i4.0
    IL_000c: ble.s IL_001a
    IL_000e: ldstr "Cannot clear coin slot pool, because instances are in use"
    IL_0013: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldc.i4.0
    IL_001b: stloc.0
    IL_001c: br.s IL_0038
    IL_001e: ldarg.0
    IL_001f: ldfld List<Coinslot> CostDisplay::coinslotPool  /*0x040012F5*/
    IL_0024: ldloc.0
    IL_0025: callvirt !0 System.Collections.Generic.List<Coinslot>::get_Item(int)  /*0x0A000657*/
    IL_002a: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002f: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0034: ldloc.0
    IL_0035: ldc.i4.1
    IL_0036: add
    IL_0037: stloc.0
    IL_0038: ldloc.0
    IL_0039: ldarg.0
    IL_003a: ldfld List<Coinslot> CostDisplay::coinslotPool  /*0x040012F5*/
    IL_003f: callvirt int System.Collections.Generic.List<Coinslot>::get_Count()  /*0x0A000656*/
    IL_0044: blt.s IL_001e
    IL_0046: ldarg.0
    IL_0047: ldfld List<Coinslot> CostDisplay::coinslotPool  /*0x040012F5*/
    IL_004c: callvirt void System.Collections.Generic.List<Coinslot>::Clear()  /*0x0A000658*/
    IL_0051: ldarg.0
    IL_0052: ldfld List<Coinslot> CostDisplay::currentlyActiveCoinslots  /*0x040012F6*/
    IL_0057: callvirt void System.Collections.Generic.List<Coinslot>::Clear()  /*0x0A000658*/
    IL_005c: ldc.i4.1
    IL_005d: ret

  .method CostDisplay::UpdateDisplay(int,bool)  // token 0x06001017 rva 0x49630 attrs Public, HideBySig
    // code size 712 (0x2c8), max stack 5, init locals
    .locals ([0] int, [1] int, [2] int, [3] int, [4] int, [5] float, [6] Coinslot, [7] List.Enumerator<Coinslot>, [8] int, [9] int, [10] float, [11] float)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_000b: ldc.r4 0.01f
    IL_0010: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0015: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_001a: ldarg.0
    IL_001b: ldc.i4.0
    IL_001c: stfld bool CostDisplay::inDisappearAnimation  /*0x04001300*/
    IL_0021: ldarg.0
    IL_0022: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0027: ldc.i4.1
    IL_0028: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_002d: ldarg.0
    IL_002e: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0033: ldarg.0
    IL_0034: ldarg.1
    IL_0035: stfld int CostDisplay::currentAmount  /*0x040012FB*/
    IL_003a: ldarg.0
    IL_003b: ldarg.2
    IL_003c: stfld bool CostDisplay::reUpdateBecauseFuckUnityCanvas  /*0x040012FA*/
    IL_0041: ldarg.0
    IL_0042: ldfld List<Coinslot> CostDisplay::currentlyActiveCoinslots  /*0x040012F6*/
    IL_0047: callvirt void System.Collections.Generic.List<Coinslot>::Clear()  /*0x0A000658*/
    IL_004c: ldarg.0
    IL_004d: ldc.i4.0
    IL_004e: stfld int CostDisplay::currentlyFilledCoins  /*0x040012FC*/
    IL_0053: ldarg.0
    IL_0054: ldc.i4.0
    IL_0055: stfld bool CostDisplay::denied  /*0x040012FF*/
    IL_005a: ldarg.0
    IL_005b: ldfld Transform CostDisplay::amountDisplayParent  /*0x040012F1*/
    IL_0060: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0065: ldc.i4.0
    IL_0066: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_006b: ldarg.0
    IL_006c: ldfld bool CostDisplay::clearCoinPoolFlag  /*0x04001303*/
    IL_0071: brfalse.s IL_0081
    IL_0073: ldarg.0
    IL_0074: call bool CostDisplay::ClearCoinPool()  /*0x06001016*/
    IL_0079: pop
    IL_007a: ldarg.0
    IL_007b: ldc.i4.0
    IL_007c: stfld bool CostDisplay::clearCoinPoolFlag  /*0x04001303*/
    IL_0081: ldarg.1
    IL_0082: ldc.i4.1
    IL_0083: bge.s IL_00c0
    IL_0085: ldarg.0
    IL_0086: ldfld List<Coinslot> CostDisplay::coinslotPool  /*0x040012F5*/
    IL_008b: callvirt List.Enumerator<!0> System.Collections.Generic.List<Coinslot>::GetEnumerator()  /*0x0A000659*/
    IL_0090: stloc.s 7
    IL_0092: br.s IL_00a6
    IL_0094: ldloca.s 7
    IL_0096: call !0 System.Collections.Generic.List.Enumerator<Coinslot>::get_Current()  /*0x0A00065A*/
    IL_009b: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00a0: ldc.i4.0
    IL_00a1: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00a6: ldloca.s 7
    IL_00a8: call bool System.Collections.Generic.List.Enumerator<Coinslot>::MoveNext()  /*0x0A00065B*/
    IL_00ad: brtrue.s IL_0094
    IL_00af: leave.s IL_00bf
    IL_00b1: ldloca.s 7
    IL_00b3: constrained. System.Collections.Generic.List.Enumerator<Coinslot>  /*0x1B000123*/
    IL_00b9: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00be: endfinally
    IL_00bf: ret
    IL_00c0: ldarg.1
    IL_00c1: ldarg.0
    IL_00c2: ldfld List<Coinslot> CostDisplay::coinslotPool  /*0x040012F5*/
    IL_00c7: callvirt int System.Collections.Generic.List<Coinslot>::get_Count()  /*0x0A000656*/
    IL_00cc: sub
    IL_00cd: stloc.0
    IL_00ce: ldc.i4.0
    IL_00cf: stloc.s 8
    IL_00d1: br.s IL_00ff
    IL_00d3: ldarg.0
    IL_00d4: ldfld List<Coinslot> CostDisplay::coinslotPool  /*0x040012F5*/
    IL_00d9: ldarg.0
    IL_00da: ldfld Coinslot CostDisplay::coinslotPrefab  /*0x040012E9*/
    IL_00df: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00e4: ldarg.0
    IL_00e5: ldfld RectTransform CostDisplay::gridParent  /*0x040012EB*/
    IL_00ea: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_00ef: callvirt !!0 UnityEngine.GameObject::GetComponent()<Coinslot>  /*0x2B0000E3*/
    IL_00f4: callvirt void System.Collections.Generic.List<Coinslot>::Add(!0)  /*0x0A00065C*/
    IL_00f9: ldloc.s 8
    IL_00fb: ldc.i4.1
    IL_00fc: add
    IL_00fd: stloc.s 8
    IL_00ff: ldloc.s 8
    IL_0101: ldloc.0
    IL_0102: blt.s IL_00d3
    IL_0104: ldarg.1
    IL_0105: stloc.1
    IL_0106: ldloc.1
    IL_0107: stloc.2
    IL_0108: ldloc.2
    IL_0109: ldarg.0
    IL_010a: ldfld int CostDisplay::maxElementsPerRow  /*0x040012ED*/
    IL_010f: ble.s IL_0118
    IL_0111: ldarg.0
    IL_0112: ldfld int CostDisplay::maxElementsPerRow  /*0x040012ED*/
    IL_0117: stloc.2
    IL_0118: ldc.i4.0
    IL_0119: stloc.3
    IL_011a: ldc.i4.0
    IL_011b: stloc.s 4
    IL_011d: ldloc.2
    IL_011e: conv.r4
    IL_011f: ldarg.0
    IL_0120: ldfld float CostDisplay::elementWidth  /*0x040012F7*/
    IL_0125: mul
    IL_0126: ldloc.2
    IL_0127: ldc.i4.1
    IL_0128: sub
    IL_0129: conv.r4
    IL_012a: ldarg.0
    IL_012b: ldfld float CostDisplay::horizontalSpacing  /*0x040012EC*/
    IL_0130: mul
    IL_0131: add
    IL_0132: neg
    IL_0133: ldc.r4 2f
    IL_0138: div
    IL_0139: ldarg.0
    IL_013a: ldfld float CostDisplay::elementWidth  /*0x040012F7*/
    IL_013f: ldc.r4 2f
    IL_0144: div
    IL_0145: add
    IL_0146: stloc.s 5
    IL_0148: ldc.i4.0
    IL_0149: stloc.s 9
    IL_014b: br IL_0269
    IL_0150: ldarg.0
    IL_0151: ldfld List<Coinslot> CostDisplay::coinslotPool  /*0x040012F5*/
    IL_0156: ldloc.s 9
    IL_0158: callvirt !0 System.Collections.Generic.List<Coinslot>::get_Item(int)  /*0x0A000657*/
    IL_015d: stloc.s 6
    IL_015f: ldloc.s 9
    IL_0161: ldarg.1
    IL_0162: bge.s IL_0191
    IL_0164: ldloc.s 6
    IL_0166: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_016b: ldc.i4.1
    IL_016c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0171: ldarg.0
    IL_0172: ldfld List<Coinslot> CostDisplay::currentlyActiveCoinslots  /*0x040012F6*/
    IL_0177: ldloc.s 6
    IL_0179: callvirt void System.Collections.Generic.List<Coinslot>::Add(!0)  /*0x0A00065C*/
    IL_017e: ldloc.s 6
    IL_0180: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0185: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_018a: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_018f: br.s IL_01a3
    IL_0191: ldloc.s 6
    IL_0193: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0198: ldc.i4.0
    IL_0199: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_019e: br IL_0263
    IL_01a3: ldloc.s 5
    IL_01a5: ldloc.3
    IL_01a6: conv.r4
    IL_01a7: ldarg.0
    IL_01a8: ldfld float CostDisplay::elementWidth  /*0x040012F7*/
    IL_01ad: mul
    IL_01ae: ldloc.3
    IL_01af: conv.r4
    IL_01b0: ldarg.0
    IL_01b1: ldfld float CostDisplay::horizontalSpacing  /*0x040012EC*/
    IL_01b6: mul
    IL_01b7: add
    IL_01b8: add
    IL_01b9: stloc.s 10
    IL_01bb: ldarg.0
    IL_01bc: ldfld float CostDisplay::peakYOffset  /*0x040012EF*/
    IL_01c1: ldarg.0
    IL_01c2: ldfld AnimationCurve CostDisplay::yDistribution  /*0x040012EE*/
    IL_01c7: ldarg.0
    IL_01c8: ldfld float CostDisplay::yCurveLeftAnchor  /*0x040012F8*/
    IL_01cd: ldarg.0
    IL_01ce: ldfld float CostDisplay::yCurveRightAnchor  /*0x040012F9*/
    IL_01d3: ldloc.s 10
    IL_01d5: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_01da: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_01df: mul
    IL_01e0: ldarg.0
    IL_01e1: ldfld float CostDisplay::rowYSpacing  /*0x040012F0*/
    IL_01e6: ldloc.s 4
    IL_01e8: conv.r4
    IL_01e9: mul
    IL_01ea: add
    IL_01eb: stloc.s 11
    IL_01ed: ldarg.0
    IL_01ee: ldfld List<Coinslot> CostDisplay::coinslotPool  /*0x040012F5*/
    IL_01f3: ldloc.s 9
    IL_01f5: callvirt !0 System.Collections.Generic.List<Coinslot>::get_Item(int)  /*0x0A000657*/
    IL_01fa: callvirt !!0 UnityEngine.Component::GetComponent()<UnityEngine.RectTransform>  /*0x2B0000D8*/
    IL_01ff: ldloc.s 10
    IL_0201: ldloc.s 11
    IL_0203: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0208: callvirt void UnityEngine.RectTransform::set_anchoredPosition(UnityEngine.Vector2)  /*0x0A000607*/
    IL_020d: ldloc.3
    IL_020e: ldc.i4.1
    IL_020f: add
    IL_0210: stloc.3
    IL_0211: ldloc.1
    IL_0212: ldc.i4.1
    IL_0213: sub
    IL_0214: stloc.1
    IL_0215: ldloc.3
    IL_0216: ldarg.0
    IL_0217: ldfld int CostDisplay::maxElementsPerRow  /*0x040012ED*/
    IL_021c: blt.s IL_0263
    IL_021e: ldloc.1
    IL_021f: stloc.2
    IL_0220: ldloc.2
    IL_0221: ldarg.0
    IL_0222: ldfld int CostDisplay::maxElementsPerRow  /*0x040012ED*/
    IL_0227: ble.s IL_0230
    IL_0229: ldarg.0
    IL_022a: ldfld int CostDisplay::maxElementsPerRow  /*0x040012ED*/
    IL_022f: stloc.2
    IL_0230: ldc.i4.0
    IL_0231: stloc.3
    IL_0232: ldloc.s 4
    IL_0234: ldc.i4.1
    IL_0235: add
    IL_0236: stloc.s 4
    IL_0238: ldloc.2
    IL_0239: conv.r4
    IL_023a: ldarg.0
    IL_023b: ldfld float CostDisplay::elementWidth  /*0x040012F7*/
    IL_0240: mul
    IL_0241: ldloc.2
    IL_0242: ldc.i4.1
    IL_0243: sub
    IL_0244: conv.r4
    IL_0245: ldarg.0
    IL_0246: ldfld float CostDisplay::horizontalSpacing  /*0x040012EC*/
    IL_024b: mul
    IL_024c: add
    IL_024d: neg
    IL_024e: ldc.r4 2f
    IL_0253: div
    IL_0254: ldarg.0
    IL_0255: ldfld float CostDisplay::elementWidth  /*0x040012F7*/
    IL_025a: ldc.r4 2f
    IL_025f: div
    IL_0260: add
    IL_0261: stloc.s 5
    IL_0263: ldloc.s 9
    IL_0265: ldc.i4.1
    IL_0266: add
    IL_0267: stloc.s 9
    IL_0269: ldloc.s 9
    IL_026b: ldarg.0
    IL_026c: ldfld List<Coinslot> CostDisplay::coinslotPool  /*0x040012F5*/
    IL_0271: callvirt int System.Collections.Generic.List<Coinslot>::get_Count()  /*0x0A000656*/
    IL_0276: blt IL_0150
    IL_027b: ldarg.0
    IL_027c: ldfld List<Coinslot> CostDisplay::currentlyActiveCoinslots  /*0x040012F6*/
    IL_0281: callvirt List.Enumerator<!0> System.Collections.Generic.List<Coinslot>::GetEnumerator()  /*0x0A000659*/
    IL_0286: stloc.s 7
    IL_0288: br.s IL_0296
    IL_028a: ldloca.s 7
    IL_028c: call !0 System.Collections.Generic.List.Enumerator<Coinslot>::get_Current()  /*0x0A00065A*/
    IL_0291: callvirt void Coinslot::SetEmpty()  /*0x06000FE7*/
    IL_0296: ldloca.s 7
    IL_0298: call bool System.Collections.Generic.List.Enumerator<Coinslot>::MoveNext()  /*0x0A00065B*/
    IL_029d: brtrue.s IL_028a
    IL_029f: leave.s IL_02af
    IL_02a1: ldloca.s 7
    IL_02a3: constrained. System.Collections.Generic.List.Enumerator<Coinslot>  /*0x1B000123*/
    IL_02a9: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_02ae: endfinally
    IL_02af: ldarg.0
    IL_02b0: call float CostDisplay::get_TotalFillTime()  /*0x06001018*/
    IL_02b5: call void ThronefallAudioManager::SetCoinDisplayFillTime(float)  /*0x0600021D*/
    IL_02ba: ldarg.0
    IL_02bb: ldarg.0
    IL_02bc: call IEnumerator CostDisplay::AnimateShowSlots()  /*0x0600101D*/
    IL_02c1: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_02c6: pop
    IL_02c7: ret
    .try IL_0092-IL_00b1 finally handler IL_00b1-IL_00bf
    .try IL_0288-IL_02a1 finally handler IL_02a1-IL_02af

  .method CostDisplay::get_TotalFillTime()  // token 0x06001018 rva 0x49920 attrs Private, HideBySig, SpecialName
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<Coinslot> CostDisplay::currentlyActiveCoinslots  /*0x040012F6*/
    IL_0006: callvirt int System.Collections.Generic.List<Coinslot>::get_Count()  /*0x0A000656*/
    IL_000b: conv.r4
    IL_000c: ldarg.0
    IL_000d: ldfld float CostDisplay::minFillDurationPerCoin  /*0x040012FE*/
    IL_0012: mul
    IL_0013: ldc.r4 0.9f
    IL_0018: mul
    IL_0019: ldc.r4 0.8f
    IL_001e: ldc.r4 1.75f
    IL_0023: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_0028: ret

  .method CostDisplay::FillUp()  // token 0x06001019 rva 0x4994c attrs Public, HideBySig
    // code size 137 (0x89), max stack 4, init locals
    .locals ([0] float)
    IL_0000: ldarg.0
    IL_0001: ldfld int CostDisplay::currentlyFilledCoins  /*0x040012FC*/
    IL_0006: stsfld int CostDisplay::currentlyFilledCoinsFromLastActiveDisplay  /*0x04001304*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<Coinslot> CostDisplay::currentlyActiveCoinslots  /*0x040012F6*/
    IL_0011: callvirt int System.Collections.Generic.List<Coinslot>::get_Count()  /*0x0A000656*/
    IL_0016: ldarg.0
    IL_0017: ldfld int CostDisplay::currentlyFilledCoins  /*0x040012FC*/
    IL_001c: ble.s IL_0087
    IL_001e: ldc.r4 1f
    IL_0023: ldarg.0
    IL_0024: call float CostDisplay::get_TotalFillTime()  /*0x06001018*/
    IL_0029: ldarg.0
    IL_002a: ldfld List<Coinslot> CostDisplay::currentlyActiveCoinslots  /*0x040012F6*/
    IL_002f: callvirt int System.Collections.Generic.List<Coinslot>::get_Count()  /*0x0A000656*/
    IL_0034: conv.r4
    IL_0035: div
    IL_0036: div
    IL_0037: stloc.0
    IL_0038: ldarg.0
    IL_0039: ldfld List<Coinslot> CostDisplay::currentlyActiveCoinslots  /*0x040012F6*/
    IL_003e: ldarg.0
    IL_003f: ldfld int CostDisplay::currentlyFilledCoins  /*0x040012FC*/
    IL_0044: callvirt !0 System.Collections.Generic.List<Coinslot>::get_Item(int)  /*0x0A000657*/
    IL_0049: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_004e: ldloc.0
    IL_004f: mul
    IL_0050: ldarg.0
    IL_0051: ldfld List<Coinslot> CostDisplay::currentlyActiveCoinslots  /*0x040012F6*/
    IL_0056: callvirt int System.Collections.Generic.List<Coinslot>::get_Count()  /*0x0A000656*/
    IL_005b: ldc.i4.1
    IL_005c: sub
    IL_005d: ldarg.0
    IL_005e: ldfld int CostDisplay::currentlyFilledCoins  /*0x040012FC*/
    IL_0063: ceq
    IL_0065: callvirt bool Coinslot::AddFill(float,bool)  /*0x06000FE6*/
    IL_006a: brfalse.s IL_0087
    IL_006c: ldarg.0
    IL_006d: ldarg.0
    IL_006e: ldfld int CostDisplay::currentlyFilledCoins  /*0x040012FC*/
    IL_0073: ldc.i4.1
    IL_0074: add
    IL_0075: stfld int CostDisplay::currentlyFilledCoins  /*0x040012FC*/
    IL_007a: ldarg.0
    IL_007b: ldfld int CostDisplay::currentlyFilledCoins  /*0x040012FC*/
    IL_0080: stsfld int CostDisplay::currentlyFilledCoinsFromLastActiveDisplay  /*0x04001304*/
    IL_0085: ldc.i4.1
    IL_0086: ret
    IL_0087: ldc.i4.0
    IL_0088: ret

  .method CostDisplay::Deny()  // token 0x0600101A rva 0x499e1 attrs Public, HideBySig
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool CostDisplay::denied  /*0x040012FF*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld List<Coinslot> CostDisplay::currentlyActiveCoinslots  /*0x040012F6*/
    IL_000f: ldarg.0
    IL_0010: ldfld int CostDisplay::currentlyFilledCoins  /*0x040012FC*/
    IL_0015: callvirt !0 System.Collections.Generic.List<Coinslot>::get_Item(int)  /*0x0A000657*/
    IL_001a: callvirt void Coinslot::PlayDeny()  /*0x06000FE8*/
    IL_001f: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0024: callvirt void ThronefallAudioManager::MakeSureCoinFillSoundIsNotPlayingAnymore()  /*0x06000218*/
    IL_0029: ldarg.0
    IL_002a: ldc.i4.1
    IL_002b: stfld bool CostDisplay::denied  /*0x040012FF*/
    IL_0030: ret

  .method CostDisplay::OnCompletion()  // token 0x0600101B rva 0x49a13 attrs Public, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld int CostDisplay::currentlyFilledCoins  /*0x040012FC*/
    IL_0007: ldc.i4.0
    IL_0008: stsfld int CostDisplay::currentlyFilledCoinsFromLastActiveDisplay  /*0x04001304*/
    IL_000d: ldarg.0
    IL_000e: ldc.i4.0
    IL_000f: stfld bool CostDisplay::denied  /*0x040012FF*/
    IL_0014: ret

  .method CostDisplay::CancelFill(PlayerInteraction)  // token 0x0600101C rva 0x49a2c attrs Public, HideBySig
    // code size 127 (0x7f), max stack 3, init locals
    .locals ([0] List.Enumerator<Coinslot>, [1] Coinslot)
    IL_0000: ldarg.0
    IL_0001: ldfld List<Coinslot> CostDisplay::currentlyActiveCoinslots  /*0x040012F6*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<Coinslot>::GetEnumerator()  /*0x0A000659*/
    IL_000b: stloc.0
    IL_000c: br.s IL_004b
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<Coinslot>::get_Current()  /*0x0A00065A*/
    IL_0015: stloc.1
    IL_0016: ldloc.1
    IL_0017: callvirt bool Coinslot::get_isFull()  /*0x06000FE4*/
    IL_001c: brfalse.s IL_0045
    IL_001e: ldarg.0
    IL_001f: ldfld Coin CostDisplay::coinPrefab  /*0x040012EA*/
    IL_0024: ldloc.1
    IL_0025: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002f: ldloc.1
    IL_0030: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0035: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_003a: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<Coin>  /*0x2B0000E4*/
    IL_003f: ldarg.1
    IL_0040: callvirt void Coin::SetTarget(PlayerInteraction)  /*0x06000340*/
    IL_0045: ldloc.1
    IL_0046: callvirt void Coinslot::SetEmpty()  /*0x06000FE7*/
    IL_004b: ldloca.s 0
    IL_004d: call bool System.Collections.Generic.List.Enumerator<Coinslot>::MoveNext()  /*0x0A00065B*/
    IL_0052: brtrue.s IL_000e
    IL_0054: leave.s IL_0064
    IL_0056: ldloca.s 0
    IL_0058: constrained. System.Collections.Generic.List.Enumerator<Coinslot>  /*0x1B000123*/
    IL_005e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0063: endfinally
    IL_0064: ldc.i4.5
    IL_0065: call void ThronefallAudioManager::Oneshot(ThronefallAudioManager.AudioOneShot)  /*0x06000219*/
    IL_006a: ldarg.0
    IL_006b: ldc.i4.0
    IL_006c: stfld int CostDisplay::currentlyFilledCoins  /*0x040012FC*/
    IL_0071: ldc.i4.0
    IL_0072: stsfld int CostDisplay::currentlyFilledCoinsFromLastActiveDisplay  /*0x04001304*/
    IL_0077: ldarg.0
    IL_0078: ldc.i4.0
    IL_0079: stfld bool CostDisplay::denied  /*0x040012FF*/
    IL_007e: ret
    .try IL_000c-IL_0056 finally handler IL_0056-IL_0064

  .method CostDisplay::AnimateShowSlots()  // token 0x0600101D rva 0x49ac8 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void CostDisplay.<AnimateShowSlots>d__43::.ctor(int)  /*0x06001028*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld CostDisplay CostDisplay.<AnimateShowSlots>d__43::<>4__this  /*0x0400130C*/
    IL_000d: ret

  .method CostDisplay::Hide()  // token 0x0600101E rva 0x49ad7 attrs Public, HideBySig
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_000b: brfalse.s IL_0015
    IL_000d: ldarg.0
    IL_000e: ldfld bool CostDisplay::inDisappearAnimation  /*0x04001300*/
    IL_0013: brfalse.s IL_0016
    IL_0015: ret
    IL_0016: ldarg.0
    IL_0017: ldc.i4.1
    IL_0018: stfld bool CostDisplay::inDisappearAnimation  /*0x04001300*/
    IL_001d: ldarg.0
    IL_001e: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0023: ldarg.0
    IL_0024: ldarg.0
    IL_0025: call IEnumerator CostDisplay::AnimateHideSlots()  /*0x0600101F*/
    IL_002a: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_002f: pop
    IL_0030: ret

  .method CostDisplay::AnimateHideSlots()  // token 0x0600101F rva 0x49b09 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void CostDisplay.<AnimateHideSlots>d__45::.ctor(int)  /*0x06001021*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld CostDisplay CostDisplay.<AnimateHideSlots>d__45::<>4__this  /*0x04001307*/
    IL_000d: ret

  .method CostDisplay::.ctor()  // token 0x06001020 rva 0x49b18 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 91 (0x5b), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.5
    IL_0002: stfld int CostDisplay::maxElementsPerRow  /*0x040012ED*/
    IL_0007: ldarg.0
    IL_0008: newobj void UnityEngine.AnimationCurve::.ctor()  /*0x0A00065D*/
    IL_000d: stfld AnimationCurve CostDisplay::yDistribution  /*0x040012EE*/
    IL_0012: ldarg.0
    IL_0013: ldc.r4 50f
    IL_0018: stfld float CostDisplay::peakYOffset  /*0x040012EF*/
    IL_001d: ldarg.0
    IL_001e: ldc.r4 100f
    IL_0023: stfld float CostDisplay::rowYSpacing  /*0x040012F0*/
    IL_0028: ldarg.0
    IL_0029: newobj void System.Collections.Generic.List<Coinslot>::.ctor()  /*0x0A00065E*/
    IL_002e: stfld List<Coinslot> CostDisplay::coinslotPool  /*0x040012F5*/
    IL_0033: ldarg.0
    IL_0034: newobj void System.Collections.Generic.List<Coinslot>::.ctor()  /*0x0A00065E*/
    IL_0039: stfld List<Coinslot> CostDisplay::currentlyActiveCoinslots  /*0x040012F6*/
    IL_003e: ldarg.0
    IL_003f: ldc.r4 1f
    IL_0044: stfld float CostDisplay::completeFillDuration  /*0x040012FD*/
    IL_0049: ldarg.0
    IL_004a: ldc.r4 0.15f
    IL_004f: stfld float CostDisplay::minFillDurationPerCoin  /*0x040012FE*/
    IL_0054: ldarg.0
    IL_0055: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_005a: ret

// ===== CostDisplay/<AnimateHideSlots>d__45  (token 0x020002EC) =====
  .method CostDisplay.<AnimateHideSlots>d__45::.ctor(int)  // token 0x06001021 rva 0x49b7f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int CostDisplay.<AnimateHideSlots>d__45::<>1__state  /*0x04001305*/
    IL_000d: ret

  .method CostDisplay.<AnimateHideSlots>d__45::System.IDisposable.Dispose()  // token 0x06001022 rva 0x49b90 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 27 (0x1b), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int CostDisplay.<AnimateHideSlots>d__45::<>1__state  /*0x04001305*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: ldc.i4.s -3
    IL_000a: beq.s IL_0010
    IL_000c: ldloc.0
    IL_000d: ldc.i4.2
    IL_000e: bne.un.s IL_001a
    IL_0010: nop
    IL_0011: leave.s IL_001a
    IL_0013: ldarg.0
    IL_0014: call void CostDisplay.<AnimateHideSlots>d__45::<>m__Finally1()  /*0x06001024*/
    IL_0019: endfinally
    IL_001a: ret
    .try IL_0011-IL_0013 finally handler IL_0013-IL_001a

  .method CostDisplay.<AnimateHideSlots>d__45::MoveNext()  // token 0x06001023 rva 0x49bc8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 312 (0x138), max stack 3, init locals
    .locals ([0] bool, [1] int, [2] CostDisplay)
    IL_0000: ldarg.0
    IL_0001: ldfld int CostDisplay.<AnimateHideSlots>d__45::<>1__state  /*0x04001305*/
    IL_0006: stloc.1
    IL_0007: ldarg.0
    IL_0008: ldfld CostDisplay CostDisplay.<AnimateHideSlots>d__45::<>4__this  /*0x04001307*/
    IL_000d: stloc.2
    IL_000e: ldloc.1
    IL_000f: switch (IL_002b, IL_0081, IL_00cf, IL_0111)
    IL_0024: ldc.i4.0
    IL_0025: stloc.0
    IL_0026: leave IL_0136
    IL_002b: ldarg.0
    IL_002c: ldc.i4.m1
    IL_002d: stfld int CostDisplay.<AnimateHideSlots>d__45::<>1__state  /*0x04001305*/
    IL_0032: ldarg.0
    IL_0033: ldc.r4 0.2f
    IL_0038: ldloc.2
    IL_0039: ldfld int CostDisplay::currentAmount  /*0x040012FB*/
    IL_003e: conv.r4
    IL_003f: div
    IL_0040: stfld float CostDisplay.<AnimateHideSlots>d__45::<waitTime>5__2  /*0x04001308*/
    IL_0045: ldloc.2
    IL_0046: ldfld TextMeshProUGUI CostDisplay::amountDisplay  /*0x040012F2*/
    IL_004b: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0050: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0055: brfalse.s IL_0088
    IL_0057: ldloc.2
    IL_0058: ldfld MMF_Player CostDisplay::displayCostAmountHide  /*0x040012F4*/
    IL_005d: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0062: ldarg.0
    IL_0063: ldarg.0
    IL_0064: ldfld float CostDisplay.<AnimateHideSlots>d__45::<waitTime>5__2  /*0x04001308*/
    IL_0069: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_006e: stfld object CostDisplay.<AnimateHideSlots>d__45::<>2__current  /*0x04001306*/
    IL_0073: ldarg.0
    IL_0074: ldc.i4.1
    IL_0075: stfld int CostDisplay.<AnimateHideSlots>d__45::<>1__state  /*0x04001305*/
    IL_007a: ldc.i4.1
    IL_007b: stloc.0
    IL_007c: leave IL_0136
    IL_0081: ldarg.0
    IL_0082: ldc.i4.m1
    IL_0083: stfld int CostDisplay.<AnimateHideSlots>d__45::<>1__state  /*0x04001305*/
    IL_0088: ldarg.0
    IL_0089: ldloc.2
    IL_008a: ldfld List<Coinslot> CostDisplay::currentlyActiveCoinslots  /*0x040012F6*/
    IL_008f: callvirt List.Enumerator<!0> System.Collections.Generic.List<Coinslot>::GetEnumerator()  /*0x0A000659*/
    IL_0094: stfld List.Enumerator<Coinslot> CostDisplay.<AnimateHideSlots>d__45::<>7__wrap2  /*0x04001309*/
    IL_0099: ldarg.0
    IL_009a: ldc.i4.s -3
    IL_009c: stfld int CostDisplay.<AnimateHideSlots>d__45::<>1__state  /*0x04001305*/
    IL_00a1: br.s IL_00d7
    IL_00a3: ldarg.0
    IL_00a4: ldflda List.Enumerator<Coinslot> CostDisplay.<AnimateHideSlots>d__45::<>7__wrap2  /*0x04001309*/
    IL_00a9: call !0 System.Collections.Generic.List.Enumerator<Coinslot>::get_Current()  /*0x0A00065A*/
    IL_00ae: callvirt void Coinslot::Disappear()  /*0x06000FEA*/
    IL_00b3: ldarg.0
    IL_00b4: ldarg.0
    IL_00b5: ldfld float CostDisplay.<AnimateHideSlots>d__45::<waitTime>5__2  /*0x04001308*/
    IL_00ba: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_00bf: stfld object CostDisplay.<AnimateHideSlots>d__45::<>2__current  /*0x04001306*/
    IL_00c4: ldarg.0
    IL_00c5: ldc.i4.2
    IL_00c6: stfld int CostDisplay.<AnimateHideSlots>d__45::<>1__state  /*0x04001305*/
    IL_00cb: ldc.i4.1
    IL_00cc: stloc.0
    IL_00cd: leave.s IL_0136
    IL_00cf: ldarg.0
    IL_00d0: ldc.i4.s -3
    IL_00d2: stfld int CostDisplay.<AnimateHideSlots>d__45::<>1__state  /*0x04001305*/
    IL_00d7: ldarg.0
    IL_00d8: ldflda List.Enumerator<Coinslot> CostDisplay.<AnimateHideSlots>d__45::<>7__wrap2  /*0x04001309*/
    IL_00dd: call bool System.Collections.Generic.List.Enumerator<Coinslot>::MoveNext()  /*0x0A00065B*/
    IL_00e2: brtrue.s IL_00a3
    IL_00e4: ldarg.0
    IL_00e5: call void CostDisplay.<AnimateHideSlots>d__45::<>m__Finally1()  /*0x06001024*/
    IL_00ea: ldarg.0
    IL_00eb: ldflda List.Enumerator<Coinslot> CostDisplay.<AnimateHideSlots>d__45::<>7__wrap2  /*0x04001309*/
    IL_00f0: initobj System.Collections.Generic.List.Enumerator<Coinslot>  /*0x1B000123*/
    IL_00f6: ldarg.0
    IL_00f7: ldc.r4 1f
    IL_00fc: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0101: stfld object CostDisplay.<AnimateHideSlots>d__45::<>2__current  /*0x04001306*/
    IL_0106: ldarg.0
    IL_0107: ldc.i4.3
    IL_0108: stfld int CostDisplay.<AnimateHideSlots>d__45::<>1__state  /*0x04001305*/
    IL_010d: ldc.i4.1
    IL_010e: stloc.0
    IL_010f: leave.s IL_0136
    IL_0111: ldarg.0
    IL_0112: ldc.i4.m1
    IL_0113: stfld int CostDisplay.<AnimateHideSlots>d__45::<>1__state  /*0x04001305*/
    IL_0118: ldloc.2
    IL_0119: ldc.i4.0
    IL_011a: stfld bool CostDisplay::inDisappearAnimation  /*0x04001300*/
    IL_011f: ldloc.2
    IL_0120: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0125: ldc.i4.0
    IL_0126: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_012b: ldc.i4.0
    IL_012c: stloc.0
    IL_012d: leave.s IL_0136
    IL_012f: ldarg.0
    IL_0130: call void CostDisplay.<AnimateHideSlots>d__45::System.IDisposable.Dispose()  /*0x06001022*/
    IL_0135: endfinally
    IL_0136: ldloc.0
    IL_0137: ret
    .try IL_0000-IL_012f fault handler IL_012f-IL_0136

  .method CostDisplay.<AnimateHideSlots>d__45::<>m__Finally1()  // token 0x06001024 rva 0x49d28 attrs Private, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.m1
    IL_0002: stfld int CostDisplay.<AnimateHideSlots>d__45::<>1__state  /*0x04001305*/
    IL_0007: ldarg.0
    IL_0008: ldflda List.Enumerator<Coinslot> CostDisplay.<AnimateHideSlots>d__45::<>7__wrap2  /*0x04001309*/
    IL_000d: constrained. System.Collections.Generic.List.Enumerator<Coinslot>  /*0x1B000123*/
    IL_0013: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0018: ret

  .method CostDisplay.<AnimateHideSlots>d__45::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06001025 rva 0x49d42 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object CostDisplay.<AnimateHideSlots>d__45::<>2__current  /*0x04001306*/
    IL_0006: ret

  .method CostDisplay.<AnimateHideSlots>d__45::System.Collections.IEnumerator.Reset()  // token 0x06001026 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method CostDisplay.<AnimateHideSlots>d__45::System.Collections.IEnumerator.get_Current()  // token 0x06001027 rva 0x49d42 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object CostDisplay.<AnimateHideSlots>d__45::<>2__current  /*0x04001306*/
    IL_0006: ret

// ===== CostDisplay/<AnimateShowSlots>d__43  (token 0x020002ED) =====
  .method CostDisplay.<AnimateShowSlots>d__43::.ctor(int)  // token 0x06001028 rva 0x49d4a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int CostDisplay.<AnimateShowSlots>d__43::<>1__state  /*0x0400130A*/
    IL_000d: ret

  .method CostDisplay.<AnimateShowSlots>d__43::System.IDisposable.Dispose()  // token 0x06001029 rva 0x49d5c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 27 (0x1b), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int CostDisplay.<AnimateShowSlots>d__43::<>1__state  /*0x0400130A*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: ldc.i4.s -3
    IL_000a: beq.s IL_0010
    IL_000c: ldloc.0
    IL_000d: ldc.i4.2
    IL_000e: bne.un.s IL_001a
    IL_0010: nop
    IL_0011: leave.s IL_001a
    IL_0013: ldarg.0
    IL_0014: call void CostDisplay.<AnimateShowSlots>d__43::<>m__Finally1()  /*0x0600102B*/
    IL_0019: endfinally
    IL_001a: ret
    .try IL_0011-IL_0013 finally handler IL_0013-IL_001a

  .method CostDisplay.<AnimateShowSlots>d__43::MoveNext()  // token 0x0600102A rva 0x49d94 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 300 (0x12c), max stack 3, init locals
    .locals ([0] bool, [1] int, [2] CostDisplay)
    IL_0000: ldarg.0
    IL_0001: ldfld int CostDisplay.<AnimateShowSlots>d__43::<>1__state  /*0x0400130A*/
    IL_0006: stloc.1
    IL_0007: ldarg.0
    IL_0008: ldfld CostDisplay CostDisplay.<AnimateShowSlots>d__43::<>4__this  /*0x0400130C*/
    IL_000d: stloc.2
    IL_000e: ldloc.1
    IL_000f: switch (IL_0027, IL_00aa, IL_00f8)
    IL_0020: ldc.i4.0
    IL_0021: stloc.0
    IL_0022: leave IL_012a
    IL_0027: ldarg.0
    IL_0028: ldc.i4.m1
    IL_0029: stfld int CostDisplay.<AnimateShowSlots>d__43::<>1__state  /*0x0400130A*/
    IL_002e: ldarg.0
    IL_002f: ldc.r4 0.2f
    IL_0034: ldloc.2
    IL_0035: ldfld int CostDisplay::currentAmount  /*0x040012FB*/
    IL_003a: conv.r4
    IL_003b: div
    IL_003c: stfld float CostDisplay.<AnimateShowSlots>d__43::<waitTime>5__2  /*0x0400130D*/
    IL_0041: ldloc.2
    IL_0042: ldfld int CostDisplay::currentAmount  /*0x040012FB*/
    IL_0047: ldloc.2
    IL_0048: ldfld int CostDisplay::maxElementsPerRow  /*0x040012ED*/
    IL_004d: ble.s IL_00b1
    IL_004f: ldloc.2
    IL_0050: ldfld Transform CostDisplay::amountDisplayParent  /*0x040012F1*/
    IL_0055: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_005a: ldc.i4.1
    IL_005b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0060: ldloc.2
    IL_0061: ldfld TextMeshProUGUI CostDisplay::amountDisplay  /*0x040012F2*/
    IL_0066: ldstr "x"
    IL_006b: ldloc.2
    IL_006c: ldflda int CostDisplay::currentAmount  /*0x040012FB*/
    IL_0071: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0076: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_007b: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0080: ldloc.2
    IL_0081: ldfld MMF_Player CostDisplay::displayCostAmountShow  /*0x040012F3*/
    IL_0086: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_008b: ldarg.0
    IL_008c: ldarg.0
    IL_008d: ldfld float CostDisplay.<AnimateShowSlots>d__43::<waitTime>5__2  /*0x0400130D*/
    IL_0092: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0097: stfld object CostDisplay.<AnimateShowSlots>d__43::<>2__current  /*0x0400130B*/
    IL_009c: ldarg.0
    IL_009d: ldc.i4.1
    IL_009e: stfld int CostDisplay.<AnimateShowSlots>d__43::<>1__state  /*0x0400130A*/
    IL_00a3: ldc.i4.1
    IL_00a4: stloc.0
    IL_00a5: leave IL_012a
    IL_00aa: ldarg.0
    IL_00ab: ldc.i4.m1
    IL_00ac: stfld int CostDisplay.<AnimateShowSlots>d__43::<>1__state  /*0x0400130A*/
    IL_00b1: ldarg.0
    IL_00b2: ldloc.2
    IL_00b3: ldfld List<Coinslot> CostDisplay::currentlyActiveCoinslots  /*0x040012F6*/
    IL_00b8: callvirt List.Enumerator<!0> System.Collections.Generic.List<Coinslot>::GetEnumerator()  /*0x0A000659*/
    IL_00bd: stfld List.Enumerator<Coinslot> CostDisplay.<AnimateShowSlots>d__43::<>7__wrap2  /*0x0400130E*/
    IL_00c2: ldarg.0
    IL_00c3: ldc.i4.s -3
    IL_00c5: stfld int CostDisplay.<AnimateShowSlots>d__43::<>1__state  /*0x0400130A*/
    IL_00ca: br.s IL_0100
    IL_00cc: ldarg.0
    IL_00cd: ldflda List.Enumerator<Coinslot> CostDisplay.<AnimateShowSlots>d__43::<>7__wrap2  /*0x0400130E*/
    IL_00d2: call !0 System.Collections.Generic.List.Enumerator<Coinslot>::get_Current()  /*0x0A00065A*/
    IL_00d7: callvirt void Coinslot::Appear()  /*0x06000FE9*/
    IL_00dc: ldarg.0
    IL_00dd: ldarg.0
    IL_00de: ldfld float CostDisplay.<AnimateShowSlots>d__43::<waitTime>5__2  /*0x0400130D*/
    IL_00e3: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_00e8: stfld object CostDisplay.<AnimateShowSlots>d__43::<>2__current  /*0x0400130B*/
    IL_00ed: ldarg.0
    IL_00ee: ldc.i4.2
    IL_00ef: stfld int CostDisplay.<AnimateShowSlots>d__43::<>1__state  /*0x0400130A*/
    IL_00f4: ldc.i4.1
    IL_00f5: stloc.0
    IL_00f6: leave.s IL_012a
    IL_00f8: ldarg.0
    IL_00f9: ldc.i4.s -3
    IL_00fb: stfld int CostDisplay.<AnimateShowSlots>d__43::<>1__state  /*0x0400130A*/
    IL_0100: ldarg.0
    IL_0101: ldflda List.Enumerator<Coinslot> CostDisplay.<AnimateShowSlots>d__43::<>7__wrap2  /*0x0400130E*/
    IL_0106: call bool System.Collections.Generic.List.Enumerator<Coinslot>::MoveNext()  /*0x0A00065B*/
    IL_010b: brtrue.s IL_00cc
    IL_010d: ldarg.0
    IL_010e: call void CostDisplay.<AnimateShowSlots>d__43::<>m__Finally1()  /*0x0600102B*/
    IL_0113: ldarg.0
    IL_0114: ldflda List.Enumerator<Coinslot> CostDisplay.<AnimateShowSlots>d__43::<>7__wrap2  /*0x0400130E*/
    IL_0119: initobj System.Collections.Generic.List.Enumerator<Coinslot>  /*0x1B000123*/
    IL_011f: ldc.i4.0
    IL_0120: stloc.0
    IL_0121: leave.s IL_012a
    IL_0123: ldarg.0
    IL_0124: call void CostDisplay.<AnimateShowSlots>d__43::System.IDisposable.Dispose()  /*0x06001029*/
    IL_0129: endfinally
    IL_012a: ldloc.0
    IL_012b: ret
    .try IL_0000-IL_0123 fault handler IL_0123-IL_012a

  .method CostDisplay.<AnimateShowSlots>d__43::<>m__Finally1()  // token 0x0600102B rva 0x49ee8 attrs Private, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.m1
    IL_0002: stfld int CostDisplay.<AnimateShowSlots>d__43::<>1__state  /*0x0400130A*/
    IL_0007: ldarg.0
    IL_0008: ldflda List.Enumerator<Coinslot> CostDisplay.<AnimateShowSlots>d__43::<>7__wrap2  /*0x0400130E*/
    IL_000d: constrained. System.Collections.Generic.List.Enumerator<Coinslot>  /*0x1B000123*/
    IL_0013: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0018: ret

  .method CostDisplay.<AnimateShowSlots>d__43::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600102C rva 0x49f02 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object CostDisplay.<AnimateShowSlots>d__43::<>2__current  /*0x0400130B*/
    IL_0006: ret

  .method CostDisplay.<AnimateShowSlots>d__43::System.Collections.IEnumerator.Reset()  // token 0x0600102D rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method CostDisplay.<AnimateShowSlots>d__43::System.Collections.IEnumerator.get_Current()  // token 0x0600102E rva 0x49f02 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object CostDisplay.<AnimateShowSlots>d__43::<>2__current  /*0x0400130B*/
    IL_0006: ret

