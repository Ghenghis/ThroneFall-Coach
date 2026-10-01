// ===== LastStandPerk  (token 0x020001A6) =====
  .method LastStandPerk::OnEnable()  // token 0x06000889 rva 0x294d8 attrs Private, HideBySig
    // code size 139 (0x8b), max stack 2, init locals
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_0014
    IL_000d: ldarg.0
    IL_000e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0013: ret
    IL_0014: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0019: callvirt bool PerkManager::get_LastStandEquipped()  /*0x0600099F*/
    IL_001e: brtrue.s IL_0027
    IL_0020: ldarg.0
    IL_0021: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0026: ret
    IL_0027: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_002c: ldnull
    IL_002d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0032: brfalse.s IL_003f
    IL_0034: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0039: ldarg.0
    IL_003a: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_003f: ldarg.0
    IL_0040: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0045: ldfld float PerkManager::lastStandHealthThreshhold  /*0x04000C54*/
    IL_004a: stfld float LastStandPerk::threshhold  /*0x04000AA9*/
    IL_004f: ldarg.0
    IL_0050: ldarg.0
    IL_0051: ldfld Hp LastStandPerk::hp  /*0x04000AA7*/
    IL_0056: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_005b: stfld float LastStandPerk::healthLast  /*0x04000AA8*/
    IL_0060: ldarg.0
    IL_0061: ldfld List<TagManager.ETag> LastStandPerk::mustHave  /*0x04000AAA*/
    IL_0066: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_006b: ldarg.0
    IL_006c: ldfld List<TagManager.ETag> LastStandPerk::mustHave  /*0x04000AAA*/
    IL_0071: ldc.i4.s 24
    IL_0073: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0078: ldarg.0
    IL_0079: ldfld List<TagManager.ETag> LastStandPerk::mayNotHave  /*0x04000AAB*/
    IL_007e: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_0083: ldarg.0
    IL_0084: ldc.i4.1
    IL_0085: stfld bool LastStandPerk::canStillBeTriggeredTonight  /*0x04000AAC*/
    IL_008a: ret

  .method LastStandPerk::Update()  // token 0x0600088A rva 0x29570 attrs Private, HideBySig
    // code size 84 (0x54), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld float LastStandPerk::healthLast  /*0x04000AA8*/
    IL_0006: ldarg.0
    IL_0007: ldfld Hp LastStandPerk::hp  /*0x04000AA7*/
    IL_000c: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0011: ble.un.s IL_0042
    IL_0013: ldarg.0
    IL_0014: ldfld Hp LastStandPerk::hp  /*0x04000AA7*/
    IL_0019: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_001e: ldarg.0
    IL_001f: ldfld float LastStandPerk::threshhold  /*0x04000AA9*/
    IL_0024: bgt.un.s IL_0042
    IL_0026: ldarg.0
    IL_0027: ldfld float LastStandPerk::healthLast  /*0x04000AA8*/
    IL_002c: ldarg.0
    IL_002d: ldfld float LastStandPerk::threshhold  /*0x04000AA9*/
    IL_0032: ble.un.s IL_0042
    IL_0034: ldarg.0
    IL_0035: ldfld bool LastStandPerk::canStillBeTriggeredTonight  /*0x04000AAC*/
    IL_003a: brfalse.s IL_0042
    IL_003c: ldarg.0
    IL_003d: call void LastStandPerk::LastStand()  /*0x0600088B*/
    IL_0042: ldarg.0
    IL_0043: ldarg.0
    IL_0044: ldfld Hp LastStandPerk::hp  /*0x04000AA7*/
    IL_0049: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_004e: stfld float LastStandPerk::healthLast  /*0x04000AA8*/
    IL_0053: ret

  .method LastStandPerk::LastStand()  // token 0x0600088B rva 0x295d0 attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<TagManager.ETag> LastStandPerk::mustHave  /*0x04000AAA*/
    IL_0006: ldarg.0
    IL_0007: ldfld List<TagManager.ETag> LastStandPerk::mayNotHave  /*0x04000AAB*/
    IL_000c: ldc.r4 1f
    IL_0011: call void Hp::ReviveAllUnitsWithTag(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,float)  /*0x06000830*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.0
    IL_0018: stfld bool LastStandPerk::canStillBeTriggeredTonight  /*0x04000AAC*/
    IL_001d: ret

  .method LastStandPerk::OnDuskEarly()  // token 0x0600088C rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LastStandPerk::OnDusk()  // token 0x0600088D rva 0x295ef attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool LastStandPerk::canStillBeTriggeredTonight  /*0x04000AAC*/
    IL_0007: ret

  .method LastStandPerk::OnDawn_AfterSunrise()  // token 0x0600088E rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LastStandPerk::OnDawn_BeforeSunrise()  // token 0x0600088F rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LastStandPerk::.ctor()  // token 0x06000890 rva 0x295f8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0006: stfld List<TagManager.ETag> LastStandPerk::mustHave  /*0x04000AAA*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0011: stfld List<TagManager.ETag> LastStandPerk::mayNotHave  /*0x04000AAB*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.1
    IL_0018: stfld bool LastStandPerk::canStillBeTriggeredTonight  /*0x04000AAC*/
    IL_001d: ldarg.0
    IL_001e: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0023: ret

