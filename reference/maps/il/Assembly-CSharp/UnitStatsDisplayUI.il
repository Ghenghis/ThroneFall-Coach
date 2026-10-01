// ===== UnitStatsDisplayUI  (token 0x02000378) =====
  .method UnitStatsDisplayUI::SetStats(UnitInfo)  // token 0x06001322 rva 0x5b1b0 attrs Public, HideBySig
    // code size 79 (0x4f), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: ldfld float UnitInfo::maxHP  /*0x040017F1*/
    IL_0007: stfld float UnitStatsDisplayUI::maxHP  /*0x04001721*/
    IL_000c: ldarg.0
    IL_000d: ldarg.1
    IL_000e: ldfld float UnitInfo::speed  /*0x040017F2*/
    IL_0013: stfld float UnitStatsDisplayUI::speed  /*0x04001722*/
    IL_0018: ldarg.0
    IL_0019: ldarg.1
    IL_001a: ldfld float UnitInfo::range  /*0x040017F3*/
    IL_001f: stfld float UnitStatsDisplayUI::range  /*0x04001723*/
    IL_0024: ldarg.0
    IL_0025: ldarg.1
    IL_0026: ldfld float UnitInfo::attackDamage  /*0x040017F4*/
    IL_002b: stfld float UnitStatsDisplayUI::attackDamage  /*0x04001724*/
    IL_0030: ldarg.0
    IL_0031: ldarg.1
    IL_0032: ldfld float UnitInfo::attackCooldown  /*0x040017F5*/
    IL_0037: stfld float UnitStatsDisplayUI::attackCooldown  /*0x04001725*/
    IL_003c: ldarg.0
    IL_003d: ldarg.1
    IL_003e: ldfld float UnitInfo::projectileSpeed  /*0x040017F6*/
    IL_0043: stfld float UnitStatsDisplayUI::projectileSpeed  /*0x04001726*/
    IL_0048: ldarg.0
    IL_0049: call void UnitStatsDisplayUI::RefreshUI()  /*0x06001324*/
    IL_004e: ret

  .method UnitStatsDisplayUI::SetStats(WaveEnemyInfo)  // token 0x06001323 rva 0x5b20c attrs Public, HideBySig
    // code size 79 (0x4f), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: ldfld float WaveEnemyInfo::maxHP  /*0x04000806*/
    IL_0007: stfld float UnitStatsDisplayUI::maxHP  /*0x04001721*/
    IL_000c: ldarg.0
    IL_000d: ldarg.1
    IL_000e: ldfld float WaveEnemyInfo::speed  /*0x04000807*/
    IL_0013: stfld float UnitStatsDisplayUI::speed  /*0x04001722*/
    IL_0018: ldarg.0
    IL_0019: ldarg.1
    IL_001a: ldfld float WaveEnemyInfo::range  /*0x04000808*/
    IL_001f: stfld float UnitStatsDisplayUI::range  /*0x04001723*/
    IL_0024: ldarg.0
    IL_0025: ldarg.1
    IL_0026: ldfld float WaveEnemyInfo::attackDamage  /*0x04000809*/
    IL_002b: stfld float UnitStatsDisplayUI::attackDamage  /*0x04001724*/
    IL_0030: ldarg.0
    IL_0031: ldarg.1
    IL_0032: ldfld float WaveEnemyInfo::attackCooldown  /*0x0400080A*/
    IL_0037: stfld float UnitStatsDisplayUI::attackCooldown  /*0x04001725*/
    IL_003c: ldarg.0
    IL_003d: ldarg.1
    IL_003e: ldfld float WaveEnemyInfo::projectileSpeed  /*0x0400080B*/
    IL_0043: stfld float UnitStatsDisplayUI::projectileSpeed  /*0x04001726*/
    IL_0048: ldarg.0
    IL_0049: call void UnitStatsDisplayUI::RefreshUI()  /*0x06001324*/
    IL_004e: ret

  .method UnitStatsDisplayUI::RefreshUI()  // token 0x06001324 rva 0x5b268 attrs Private, HideBySig
    // code size 109 (0x6d), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld TextMeshProUGUI UnitStatsDisplayUI::maxHPValueText  /*0x0400171B*/
    IL_0007: ldarg.0
    IL_0008: ldfld float UnitStatsDisplayUI::maxHP  /*0x04001721*/
    IL_000d: call void UnitStatsDisplayUI::SetText(TMPro.TextMeshProUGUI,float)  /*0x06001325*/
    IL_0012: ldarg.0
    IL_0013: ldarg.0
    IL_0014: ldfld TextMeshProUGUI UnitStatsDisplayUI::speedValueText  /*0x0400171C*/
    IL_0019: ldarg.0
    IL_001a: ldfld float UnitStatsDisplayUI::speed  /*0x04001722*/
    IL_001f: call void UnitStatsDisplayUI::SetText(TMPro.TextMeshProUGUI,float)  /*0x06001325*/
    IL_0024: ldarg.0
    IL_0025: ldarg.0
    IL_0026: ldfld TextMeshProUGUI UnitStatsDisplayUI::rangeValueText  /*0x0400171D*/
    IL_002b: ldarg.0
    IL_002c: ldfld float UnitStatsDisplayUI::range  /*0x04001723*/
    IL_0031: call void UnitStatsDisplayUI::SetText(TMPro.TextMeshProUGUI,float)  /*0x06001325*/
    IL_0036: ldarg.0
    IL_0037: ldarg.0
    IL_0038: ldfld TextMeshProUGUI UnitStatsDisplayUI::attackDamageValueText  /*0x0400171E*/
    IL_003d: ldarg.0
    IL_003e: ldfld float UnitStatsDisplayUI::attackDamage  /*0x04001724*/
    IL_0043: call void UnitStatsDisplayUI::SetText(TMPro.TextMeshProUGUI,float)  /*0x06001325*/
    IL_0048: ldarg.0
    IL_0049: ldarg.0
    IL_004a: ldfld TextMeshProUGUI UnitStatsDisplayUI::attackCooldownValueText  /*0x0400171F*/
    IL_004f: ldarg.0
    IL_0050: ldfld float UnitStatsDisplayUI::attackCooldown  /*0x04001725*/
    IL_0055: call void UnitStatsDisplayUI::SetText(TMPro.TextMeshProUGUI,float)  /*0x06001325*/
    IL_005a: ldarg.0
    IL_005b: ldarg.0
    IL_005c: ldfld TextMeshProUGUI UnitStatsDisplayUI::projectileSpeedValueText  /*0x04001720*/
    IL_0061: ldarg.0
    IL_0062: ldfld float UnitStatsDisplayUI::projectileSpeed  /*0x04001726*/
    IL_0067: call void UnitStatsDisplayUI::SetText(TMPro.TextMeshProUGUI,float)  /*0x06001325*/
    IL_006c: ret

  .method UnitStatsDisplayUI::SetText(TMPro.TextMeshProUGUI,float)  // token 0x06001325 rva 0x5b2e4 attrs Private, HideBySig
    // code size 120 (0x78), max stack 3, init locals
    IL_0000: ldarg.1
    IL_0001: ldnull
    IL_0002: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0007: brfalse.s IL_0077
    IL_0009: ldarg.2
    IL_000a: ldc.r4 0f
    IL_000f: bne.un.s IL_0028
    IL_0011: ldarg.1
    IL_0012: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_0017: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_001c: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0021: ldc.i4.0
    IL_0022: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0027: ret
    IL_0028: ldarg.1
    IL_0029: callvirt Transform TMPro.TMP_Text::get_transform()  /*0x0A0003C6*/
    IL_002e: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_0033: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0038: ldc.i4.1
    IL_0039: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003e: ldarg.2
    IL_003f: ldc.r4 10f
    IL_0044: mul
    IL_0045: ldc.r4 10f
    IL_004a: rem
    IL_004b: ldc.r4 0f
    IL_0050: bne.un.s IL_0065
    IL_0052: ldarg.1
    IL_0053: ldarga.s 2
    IL_0055: ldstr "F0"
    IL_005a: call string System.Single::ToString(string)  /*0x0A000623*/
    IL_005f: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0064: ret
    IL_0065: ldarg.1
    IL_0066: ldarga.s 2
    IL_0068: ldstr "F1"
    IL_006d: call string System.Single::ToString(string)  /*0x0A000623*/
    IL_0072: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0077: ret

  .method UnitStatsDisplayUI::.ctor()  // token 0x06001326 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

