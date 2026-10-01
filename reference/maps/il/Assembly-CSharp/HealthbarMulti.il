// ===== HealthbarMulti  (token 0x0200018F) =====
  .method HealthbarMulti::UpdateDisplay()  // token 0x06000807 rva 0x277a4 attrs Public, Virtual, HideBySig
    // code size 307 (0x133), max stack 3, init locals
    .locals ([0] float, [1] int, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld Hp Healthbar::target  /*0x04000A06*/
    IL_0006: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_000b: ldarg.0
    IL_000c: ldfld int HealthbarMulti::segments  /*0x04000A19*/
    IL_0011: conv.r4
    IL_0012: mul
    IL_0013: ldc.r4 1f
    IL_0018: rem
    IL_0019: stloc.0
    IL_001a: ldarg.0
    IL_001b: ldfld Hp Healthbar::target  /*0x04000A06*/
    IL_0020: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_0025: ldarg.0
    IL_0026: ldfld int HealthbarMulti::segments  /*0x04000A19*/
    IL_002b: conv.r4
    IL_002c: mul
    IL_002d: ldc.r4 1f
    IL_0032: rem
    IL_0033: pop
    IL_0034: ldarg.0
    IL_0035: ldfld Hp Healthbar::target  /*0x04000A06*/
    IL_003a: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_003f: ldc.r4 1f
    IL_0044: ldarg.0
    IL_0045: ldfld int HealthbarMulti::segments  /*0x04000A19*/
    IL_004a: conv.r4
    IL_004b: div
    IL_004c: div
    IL_004d: call int UnityEngine.Mathf::FloorToInt(float)  /*0x0A000144*/
    IL_0052: stloc.1
    IL_0053: ldc.i4.0
    IL_0054: stloc.2
    IL_0055: br.s IL_0075
    IL_0057: ldarg.0
    IL_0058: ldfld Transform HealthbarMulti::lifes  /*0x04000A1A*/
    IL_005d: ldloc.2
    IL_005e: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0063: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0068: ldloc.1
    IL_0069: ldloc.2
    IL_006a: cgt
    IL_006c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0071: ldloc.2
    IL_0072: ldc.i4.1
    IL_0073: add
    IL_0074: stloc.2
    IL_0075: ldloc.2
    IL_0076: ldarg.0
    IL_0077: ldfld Transform HealthbarMulti::lifes  /*0x04000A1A*/
    IL_007c: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0081: blt.s IL_0057
    IL_0083: ldarg.0
    IL_0084: ldfld Hp Healthbar::target  /*0x04000A06*/
    IL_0089: ldfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_008e: brfalse.s IL_0096
    IL_0090: ldc.r4 1f
    IL_0095: stloc.0
    IL_0096: ldarg.0
    IL_0097: ldfld Hp Healthbar::target  /*0x04000A06*/
    IL_009c: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_00a1: ldc.r4 1f
    IL_00a6: bne.un.s IL_00d9
    IL_00a8: ldarg.0
    IL_00a9: ldfld GameObject Healthbar::canvasParent  /*0x04000A03*/
    IL_00ae: ldc.i4.0
    IL_00af: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00b4: ldarg.0
    IL_00b5: ldc.i4.0
    IL_00b6: call void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_00bb: ldarg.0
    IL_00bc: ldc.r4 1f
    IL_00c1: stfld float Healthbar::hpLast  /*0x04000A10*/
    IL_00c6: ldarg.0
    IL_00c7: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_00cc: ldarg.0
    IL_00cd: ldfld float Healthbar::hpLast  /*0x04000A10*/
    IL_00d2: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_00d7: br.s IL_00ec
    IL_00d9: ldarg.0
    IL_00da: ldfld GameObject Healthbar::canvasParent  /*0x04000A03*/
    IL_00df: ldc.i4.1
    IL_00e0: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00e5: ldarg.0
    IL_00e6: ldc.i4.1
    IL_00e7: call void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_00ec: ldarg.0
    IL_00ed: ldfld MPImageBasic Healthbar::fill  /*0x04000A04*/
    IL_00f2: ldloc.0
    IL_00f3: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_00f8: ldarg.0
    IL_00f9: ldfld MPImageBasic Healthbar::fill  /*0x04000A04*/
    IL_00fe: callvirt float UnityEngine.UI.Image::get_fillAmount()  /*0x0A0003B1*/
    IL_0103: ldc.r4 0f
    IL_0108: call bool UnityEngine.Mathf::Approximately(float,float)  /*0x0A0000F9*/
    IL_010d: brfalse.s IL_0121
    IL_010f: ldarg.0
    IL_0110: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_0115: ldarg.0
    IL_0116: ldfld Color Healthbar::deathFillColor  /*0x04000A07*/
    IL_011b: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0120: ret
    IL_0121: ldarg.0
    IL_0122: ldfld MPImageBasic Healthbar::delayedFill  /*0x04000A05*/
    IL_0127: ldarg.0
    IL_0128: ldfld Color Healthbar::defaultDelayedFillColor  /*0x04000A0F*/
    IL_012d: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0132: ret

  .method HealthbarMulti::.ctor()  // token 0x06000808 rva 0x278e3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.s 10
    IL_0003: stfld int HealthbarMulti::segments  /*0x04000A19*/
    IL_0008: ldarg.0
    IL_0009: call void Healthbar::.ctor()  /*0x06000806*/
    IL_000e: ret

