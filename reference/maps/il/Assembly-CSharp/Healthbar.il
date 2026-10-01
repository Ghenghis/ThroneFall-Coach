// ===== Healthbar  (token 0x0200018E) =====
  .method Healthbar::get_Target()  // token 0x06000800 rva 0x2734b attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Hp Healthbar::target  /*0x04000A06*/
    IL_0006: ret

  .method Healthbar::Start()  // token 0x06000801 rva 0x27354 attrs Private, HideBySig
    // code size 173 (0xad), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Hp Healthbar::target  /*0x04000A06*/
    IL_0006: ldfld UnityEvent Hp::OnHpChange  /*0x04000A3A*/
    IL_000b: ldarg.0
    IL_000c: dup
    IL_000d: ldvirtftn void Healthbar::UpdateDisplay()  /*0x06000804*/
    IL_0013: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0018: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001d: ldarg.0
    IL_001e: ldarg.0
    IL_001f: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_0024: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0029: stfld Color Healthbar::defaultDelayedFillColor  /*0x04000A0F*/
    IL_002e: ldarg.0
    IL_002f: callvirt void Healthbar::UpdateDisplay()  /*0x06000804*/
    IL_0034: ldarg.0
    IL_0035: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_003a: ldarg.0
    IL_003b: ldfld MPImageBasic Healthbar::fill  /*0x04000A04*/
    IL_0040: callvirt float UnityEngine.UI.Image::get_fillAmount()  /*0x0A0003B1*/
    IL_0045: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_004a: ldarg.0
    IL_004b: ldc.r4 1f
    IL_0050: stfld float Healthbar::hpLast  /*0x04000A10*/
    IL_0055: ldarg.0
    IL_0056: ldarg.0
    IL_0057: ldfld Hp Healthbar::target  /*0x04000A06*/
    IL_005c: ldfld bool Hp::getsKnockedOutInsteadOfDying  /*0x04000A2D*/
    IL_0061: ldc.i4.0
    IL_0062: ceq
    IL_0064: stfld bool Healthbar::shouldUnparentAndDestroyOnDeath  /*0x04000A13*/
    IL_0069: ldarg.0
    IL_006a: ldfld bool Healthbar::shouldUnparentAndDestroyOnDeath  /*0x04000A13*/
    IL_006f: brfalse.s IL_008d
    IL_0071: ldarg.0
    IL_0072: ldfld Hp Healthbar::target  /*0x04000A06*/
    IL_0077: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_007c: ldarg.0
    IL_007d: ldftn void Healthbar::UnparentItself()  /*0x06000805*/
    IL_0083: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0088: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_008d: ldarg.0
    IL_008e: ldfld bool Healthbar::flashWhenBelowThreshold  /*0x04000A08*/
    IL_0093: brfalse.s IL_00a6
    IL_0095: ldarg.0
    IL_0096: ldarg.0
    IL_0097: ldfld MPImageBasic Healthbar::flashTarget  /*0x04000A0C*/
    IL_009c: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_00a1: stfld Color Healthbar::flashDefaultColor  /*0x04000A14*/
    IL_00a6: ldarg.0
    IL_00a7: call void Healthbar::UpdateColor()  /*0x06000802*/
    IL_00ac: ret

  .method Healthbar::UpdateColor()  // token 0x06000802 rva 0x2740d attrs Public, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool Healthbar::isenemy  /*0x04000A0E*/
    IL_0006: brfalse.s IL_001d
    IL_0008: ldarg.0
    IL_0009: ldfld MPImageBasic Healthbar::fill  /*0x04000A04*/
    IL_000e: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_0013: ldfld Color ColorAndLightManager::enemyHealthBarColor  /*0x0400044C*/
    IL_0018: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_001d: ret

  .method Healthbar::Update()  // token 0x06000803 rva 0x2742c attrs Private, HideBySig
    // code size 620 (0x26c), max stack 7, init locals
    .locals ([0] bool, [1] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld MPImageBasic Healthbar::fill  /*0x04000A04*/
    IL_0007: callvirt float UnityEngine.UI.Image::get_fillAmount()  /*0x0A0003B1*/
    IL_000c: stfld float Healthbar::hpNow  /*0x04000A11*/
    IL_0011: ldarg.0
    IL_0012: ldfld float Healthbar::hpNow  /*0x04000A11*/
    IL_0017: ldc.r4 0f
    IL_001c: call bool UnityEngine.Mathf::Approximately(float,float)  /*0x0A0000F9*/
    IL_0021: stloc.0
    IL_0022: ldarg.0
    IL_0023: ldfld float Healthbar::hpNow  /*0x04000A11*/
    IL_0028: ldarg.0
    IL_0029: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_002e: callvirt float UnityEngine.UI.Image::get_fillAmount()  /*0x0A0003B1*/
    IL_0033: call bool UnityEngine.Mathf::Approximately(float,float)  /*0x0A0000F9*/
    IL_0038: brtrue IL_00ea
    IL_003d: ldloc.0
    IL_003e: brtrue.s IL_0096
    IL_0040: ldarg.0
    IL_0041: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_0046: ldarg.0
    IL_0047: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_004c: callvirt float UnityEngine.UI.Image::get_fillAmount()  /*0x0A0003B1*/
    IL_0051: ldarg.0
    IL_0052: ldfld MPImageBasic Healthbar::fill  /*0x04000A04*/
    IL_0057: callvirt float UnityEngine.UI.Image::get_fillAmount()  /*0x0A0003B1*/
    IL_005c: ldarg.0
    IL_005d: ldfld float Healthbar::minDrainSpeed  /*0x04000A18*/
    IL_0062: ldarg.0
    IL_0063: ldfld float Healthbar::maxDrainSpeed  /*0x04000A17*/
    IL_0068: ldarg.0
    IL_0069: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_006e: callvirt float UnityEngine.UI.Image::get_fillAmount()  /*0x0A0003B1*/
    IL_0073: ldarg.0
    IL_0074: ldfld MPImageBasic Healthbar::fill  /*0x04000A04*/
    IL_0079: callvirt float UnityEngine.UI.Image::get_fillAmount()  /*0x0A0003B1*/
    IL_007e: sub
    IL_007f: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0084: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0089: mul
    IL_008a: call float UnityEngine.Mathf::MoveTowards(float,float,float)  /*0x0A0000CF*/
    IL_008f: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_0094: br.s IL_00ea
    IL_0096: ldarg.0
    IL_0097: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_009c: ldarg.0
    IL_009d: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_00a2: callvirt float UnityEngine.UI.Image::get_fillAmount()  /*0x0A0003B1*/
    IL_00a7: ldarg.0
    IL_00a8: ldfld MPImageBasic Healthbar::fill  /*0x04000A04*/
    IL_00ad: callvirt float UnityEngine.UI.Image::get_fillAmount()  /*0x0A0003B1*/
    IL_00b2: ldarg.0
    IL_00b3: ldfld float Healthbar::finalDrainSpeed  /*0x04000A16*/
    IL_00b8: ldarg.0
    IL_00b9: ldfld float Healthbar::maxDrainSpeed  /*0x04000A17*/
    IL_00be: ldarg.0
    IL_00bf: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_00c4: callvirt float UnityEngine.UI.Image::get_fillAmount()  /*0x0A0003B1*/
    IL_00c9: ldarg.0
    IL_00ca: ldfld MPImageBasic Healthbar::fill  /*0x04000A04*/
    IL_00cf: callvirt float UnityEngine.UI.Image::get_fillAmount()  /*0x0A0003B1*/
    IL_00d4: sub
    IL_00d5: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_00da: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00df: mul
    IL_00e0: call float UnityEngine.Mathf::MoveTowards(float,float,float)  /*0x0A0000CF*/
    IL_00e5: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_00ea: ldarg.0
    IL_00eb: ldfld float Healthbar::hpNow  /*0x04000A11*/
    IL_00f0: ldarg.0
    IL_00f1: ldfld float Healthbar::hpLast  /*0x04000A10*/
    IL_00f6: bge.un.s IL_0103
    IL_00f8: ldarg.0
    IL_00f9: ldc.r4 2f
    IL_00fe: stfld float Healthbar::damageFlash  /*0x04000A12*/
    IL_0103: ldloc.0
    IL_0104: brfalse.s IL_0140
    IL_0106: ldarg.0
    IL_0107: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_010c: callvirt float UnityEngine.UI.Image::get_fillAmount()  /*0x0A0003B1*/
    IL_0111: ldc.r4 0.01f
    IL_0116: bge.un.s IL_0140
    IL_0118: ldarg.0
    IL_0119: ldfld bool Healthbar::shouldUnparentAndDestroyOnDeath  /*0x04000A13*/
    IL_011e: brfalse.s IL_012d
    IL_0120: ldarg.0
    IL_0121: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0126: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_012b: br.s IL_0140
    IL_012d: ldarg.0
    IL_012e: ldfld GameObject Healthbar::canvasParent  /*0x04000A03*/
    IL_0133: ldc.i4.0
    IL_0134: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0139: ldarg.0
    IL_013a: ldc.i4.0
    IL_013b: call void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0140: ldarg.0
    IL_0141: ldfld bool Healthbar::flashWhenBelowThreshold  /*0x04000A08*/
    IL_0146: brfalse IL_0213
    IL_014b: ldarg.0
    IL_014c: ldfld float Healthbar::hpNow  /*0x04000A11*/
    IL_0151: ldarg.0
    IL_0152: ldfld float Healthbar::flashThreshhold  /*0x04000A09*/
    IL_0157: bgt.un.s IL_01d2
    IL_0159: ldarg.0
    IL_015a: ldfld float Healthbar::hpNow  /*0x04000A11*/
    IL_015f: ldc.r4 0f
    IL_0164: ble.un.s IL_01d2
    IL_0166: ldarg.0
    IL_0167: ldarg.0
    IL_0168: ldfld float Healthbar::flashClock  /*0x04000A15*/
    IL_016d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0172: sub
    IL_0173: stfld float Healthbar::flashClock  /*0x04000A15*/
    IL_0178: ldarg.0
    IL_0179: ldfld float Healthbar::flashClock  /*0x04000A15*/
    IL_017e: ldc.r4 0f
    IL_0183: bgt.un IL_0213
    IL_0188: ldarg.0
    IL_0189: ldarg.0
    IL_018a: ldfld float Healthbar::flashInterval  /*0x04000A0A*/
    IL_018f: stfld float Healthbar::flashClock  /*0x04000A15*/
    IL_0194: ldarg.0
    IL_0195: ldfld MPImageBasic Healthbar::flashTarget  /*0x04000A0C*/
    IL_019a: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_019f: ldarg.0
    IL_01a0: ldfld Color Healthbar::flashColor  /*0x04000A0B*/
    IL_01a5: call bool UnityEngine.Color::op_Equality(UnityEngine.Color,UnityEngine.Color)  /*0x0A0003B3*/
    IL_01aa: brfalse.s IL_01bf
    IL_01ac: ldarg.0
    IL_01ad: ldfld MPImageBasic Healthbar::flashTarget  /*0x04000A0C*/
    IL_01b2: ldarg.0
    IL_01b3: ldfld Color Healthbar::flashDefaultColor  /*0x04000A14*/
    IL_01b8: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_01bd: br.s IL_0213
    IL_01bf: ldarg.0
    IL_01c0: ldfld MPImageBasic Healthbar::flashTarget  /*0x04000A0C*/
    IL_01c5: ldarg.0
    IL_01c6: ldfld Color Healthbar::flashColor  /*0x04000A0B*/
    IL_01cb: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_01d0: br.s IL_0213
    IL_01d2: ldarg.0
    IL_01d3: ldfld MPImageBasic Healthbar::flashTarget  /*0x04000A0C*/
    IL_01d8: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_01dd: ldarg.0
    IL_01de: ldfld Color Healthbar::flashDefaultColor  /*0x04000A14*/
    IL_01e3: call bool UnityEngine.Color::op_Inequality(UnityEngine.Color,UnityEngine.Color)  /*0x0A0003B4*/
    IL_01e8: brfalse.s IL_0208
    IL_01ea: ldarg.0
    IL_01eb: ldfld MPImageBasic Healthbar::flashTarget  /*0x04000A0C*/
    IL_01f0: ldarg.0
    IL_01f1: ldfld Color Healthbar::flashDefaultColor  /*0x04000A14*/
    IL_01f6: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_01fb: ldarg.0
    IL_01fc: ldc.r4 0f
    IL_0201: stfld float Healthbar::flashClock  /*0x04000A15*/
    IL_0206: br.s IL_0213
    IL_0208: ldarg.0
    IL_0209: ldc.r4 0f
    IL_020e: stfld float Healthbar::flashClock  /*0x04000A15*/
    IL_0213: ldc.r4 1f
    IL_0218: ldarg.0
    IL_0219: ldfld float Healthbar::damageFlashSize  /*0x04000A0D*/
    IL_021e: ldarg.0
    IL_021f: ldfld float Healthbar::damageFlash  /*0x04000A12*/
    IL_0224: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0229: stloc.1
    IL_022a: ldarg.0
    IL_022b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0230: ldloc.1
    IL_0231: ldloc.1
    IL_0232: ldloc.1
    IL_0233: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0238: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_023d: ldarg.0
    IL_023e: ldarg.0
    IL_023f: ldfld float Healthbar::damageFlash  /*0x04000A12*/
    IL_0244: ldc.r4 0.1f
    IL_0249: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_024e: ldc.r4 3f
    IL_0253: mul
    IL_0254: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0259: mul
    IL_025a: stfld float Healthbar::damageFlash  /*0x04000A12*/
    IL_025f: ldarg.0
    IL_0260: ldarg.0
    IL_0261: ldfld float Healthbar::hpNow  /*0x04000A11*/
    IL_0266: stfld float Healthbar::hpLast  /*0x04000A10*/
    IL_026b: ret

  .method Healthbar::UpdateDisplay()  // token 0x06000804 rva 0x276a4 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 167 (0xa7), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Hp Healthbar::target  /*0x04000A06*/
    IL_0006: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_000b: ldc.r4 1f
    IL_0010: bne.un.s IL_0043
    IL_0012: ldarg.0
    IL_0013: ldfld GameObject Healthbar::canvasParent  /*0x04000A03*/
    IL_0018: ldc.i4.0
    IL_0019: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001e: ldarg.0
    IL_001f: ldc.i4.0
    IL_0020: call void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0025: ldarg.0
    IL_0026: ldc.r4 1f
    IL_002b: stfld float Healthbar::hpLast  /*0x04000A10*/
    IL_0030: ldarg.0
    IL_0031: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_0036: ldarg.0
    IL_0037: ldfld float Healthbar::hpLast  /*0x04000A10*/
    IL_003c: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_0041: br.s IL_0056
    IL_0043: ldarg.0
    IL_0044: ldfld GameObject Healthbar::canvasParent  /*0x04000A03*/
    IL_0049: ldc.i4.1
    IL_004a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_004f: ldarg.0
    IL_0050: ldc.i4.1
    IL_0051: call void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0056: ldarg.0
    IL_0057: ldfld MPImageBasic Healthbar::fill  /*0x04000A04*/
    IL_005c: ldarg.0
    IL_005d: ldfld Hp Healthbar::target  /*0x04000A06*/
    IL_0062: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_0067: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_006c: ldarg.0
    IL_006d: ldfld MPImageBasic Healthbar::fill  /*0x04000A04*/
    IL_0072: callvirt float UnityEngine.UI.Image::get_fillAmount()  /*0x0A0003B1*/
    IL_0077: ldc.r4 0f
    IL_007c: call bool UnityEngine.Mathf::Approximately(float,float)  /*0x0A0000F9*/
    IL_0081: brfalse.s IL_0095
    IL_0083: ldarg.0
    IL_0084: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_0089: ldarg.0
    IL_008a: ldfld Color Healthbar::deathFillColor  /*0x04000A07*/
    IL_008f: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0094: ret
    IL_0095: ldarg.0
    IL_0096: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_009b: ldarg.0
    IL_009c: ldfld Color Healthbar::defaultDelayedFillColor  /*0x04000A0F*/
    IL_00a1: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00a6: ret

  .method Healthbar::UnparentItself()  // token 0x06000805 rva 0x27757 attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: ldnull
    IL_0007: callvirt void UnityEngine.Transform::SetParent(UnityEngine.Transform)  /*0x0A000065*/
    IL_000c: ret

  .method Healthbar::.ctor()  // token 0x06000806 rva 0x27765 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.25f
    IL_0006: stfld float Healthbar::flashInterval  /*0x04000A0A*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1.2f
    IL_0011: stfld float Healthbar::damageFlashSize  /*0x04000A0D*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.5f
    IL_001c: stfld float Healthbar::finalDrainSpeed  /*0x04000A16*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 1f
    IL_0027: stfld float Healthbar::maxDrainSpeed  /*0x04000A17*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 0.1f
    IL_0032: stfld float Healthbar::minDrainSpeed  /*0x04000A18*/
    IL_0037: ldarg.0
    IL_0038: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_003d: ret

