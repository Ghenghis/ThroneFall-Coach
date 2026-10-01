// ===== DamageIndicatorUI  (token 0x020002EE) =====
  .method DamageIndicatorUI::Start()  // token 0x0600102F rva 0x49f0a attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_000c: stfld Vector3 DamageIndicatorUI::originalPos  /*0x04001316*/
    IL_0011: ret

  .method DamageIndicatorUI::SetStat(float,bool,bool,DamageIndicatorUIHandler)  // token 0x06001030 rva 0x49f20 attrs Public, HideBySig
    // code size 208 (0xd0), max stack 3, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.3
    IL_0001: brfalse.s IL_0014
    IL_0003: ldarg.0
    IL_0004: ldfld TextMeshProUGUI DamageIndicatorUI::UIText  /*0x04001313*/
    IL_0009: ldarg.0
    IL_000a: ldfld float DamageIndicatorUI::buildingFontSize  /*0x04001312*/
    IL_000f: callvirt void TMPro.TMP_Text::set_fontSize(float)  /*0x0A00065F*/
    IL_0014: ldarg.2
    IL_0015: brfalse.s IL_0045
    IL_0017: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_001c: ldfld UnityEvent SettingsManager::onEnableUnitDamageStatsChange  /*0x04000FFB*/
    IL_0021: ldarg.0
    IL_0022: ldftn void DamageIndicatorUI::UnitStatsDisabled()  /*0x06001032*/
    IL_0028: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_002d: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0032: ldarg.0
    IL_0033: ldfld TextMeshProUGUI DamageIndicatorUI::UIText  /*0x04001313*/
    IL_0038: ldarg.0
    IL_0039: ldfld Color DamageIndicatorUI::unitDamageRecievedColor  /*0x04001314*/
    IL_003e: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0043: br.s IL_0071
    IL_0045: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_004a: ldfld UnityEvent SettingsManager::onEnableEnemyDamageUnitStatsChange  /*0x04000FFC*/
    IL_004f: ldarg.0
    IL_0050: ldftn void DamageIndicatorUI::UnitStatsDisabled()  /*0x06001032*/
    IL_0056: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_005b: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0060: ldarg.0
    IL_0061: ldfld TextMeshProUGUI DamageIndicatorUI::UIText  /*0x04001313*/
    IL_0066: ldarg.0
    IL_0067: ldfld Color DamageIndicatorUI::enemyDamageRecievedColor  /*0x04001315*/
    IL_006c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0071: ldarg.0
    IL_0072: ldarg.s 4
    IL_0074: stfld DamageIndicatorUIHandler DamageIndicatorUI::damageIndicatorHandler  /*0x04001317*/
    IL_0079: ldarg.0
    IL_007a: ldfld Vector3 DamageIndicatorUI::originalPos  /*0x04001316*/
    IL_007f: stloc.0
    IL_0080: ldloca.s 0
    IL_0082: ldflda float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0087: dup
    IL_0088: ldind.r4
    IL_0089: ldarg.0
    IL_008a: ldfld float DamageIndicatorUI::offset  /*0x04001311*/
    IL_008f: add
    IL_0090: stind.r4
    IL_0091: ldarg.0
    IL_0092: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0097: ldloc.0
    IL_0098: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_009d: ldarg.0
    IL_009e: ldfld TextMeshProUGUI DamageIndicatorUI::UIText  /*0x04001313*/
    IL_00a3: ldarga.s 1
    IL_00a5: ldstr "F1"
    IL_00aa: call string System.Single::ToString(string)  /*0x0A000623*/
    IL_00af: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00b4: ldarg.0
    IL_00b5: ldfld TextMeshProUGUI DamageIndicatorUI::UIText  /*0x04001313*/
    IL_00ba: ldc.r4 1f
    IL_00bf: callvirt void TMPro.TMP_Text::set_alpha(float)  /*0x0A00046A*/
    IL_00c4: ldarg.0
    IL_00c5: ldc.r4 0f
    IL_00ca: stfld float DamageIndicatorUI::timer  /*0x04001318*/
    IL_00cf: ret

  .method DamageIndicatorUI::Update()  // token 0x06001031 rva 0x49ffc attrs Private, HideBySig
    // code size 125 (0x7d), max stack 4, init locals
    .locals ([0] float, [1] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float DamageIndicatorUI::timer  /*0x04001318*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float DamageIndicatorUI::timer  /*0x04001318*/
    IL_0012: ldarg.0
    IL_0013: ldfld float DamageIndicatorUI::life  /*0x0400130F*/
    IL_0018: ldarg.0
    IL_0019: ldfld float DamageIndicatorUI::timer  /*0x04001318*/
    IL_001e: bge.un.s IL_002d
    IL_0020: ldarg.0
    IL_0021: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0026: ldc.i4.0
    IL_0027: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_002c: ret
    IL_002d: ldarg.0
    IL_002e: ldfld float DamageIndicatorUI::timer  /*0x04001318*/
    IL_0033: ldarg.0
    IL_0034: ldfld float DamageIndicatorUI::life  /*0x0400130F*/
    IL_0039: div
    IL_003a: stloc.0
    IL_003b: ldarg.0
    IL_003c: ldfld TextMeshProUGUI DamageIndicatorUI::UIText  /*0x04001313*/
    IL_0041: ldc.r4 1f
    IL_0046: ldloc.0
    IL_0047: sub
    IL_0048: callvirt void TMPro.TMP_Text::set_alpha(float)  /*0x0A00046A*/
    IL_004d: ldarg.0
    IL_004e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0053: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_0058: stloc.1
    IL_0059: ldloca.s 1
    IL_005b: ldflda float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0060: dup
    IL_0061: ldind.r4
    IL_0062: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0067: ldarg.0
    IL_0068: ldfld float DamageIndicatorUI::speed  /*0x04001310*/
    IL_006d: mul
    IL_006e: add
    IL_006f: stind.r4
    IL_0070: ldarg.0
    IL_0071: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0076: ldloc.1
    IL_0077: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_007c: ret

  .method DamageIndicatorUI::UnitStatsDisabled()  // token 0x06001032 rva 0x4a085 attrs Private, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld DamageIndicatorUIHandler DamageIndicatorUI::damageIndicatorHandler  /*0x04001317*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_001f
    IL_000e: ldarg.0
    IL_000f: ldfld DamageIndicatorUIHandler DamageIndicatorUI::damageIndicatorHandler  /*0x04001317*/
    IL_0014: ldarg.0
    IL_0015: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001a: callvirt void DamageIndicatorUIHandler::RemoveDamageIndicatorFromPool(UnityEngine.GameObject)  /*0x06001037*/
    IL_001f: ret

  .method DamageIndicatorUI::OnDestroy()  // token 0x06001033 rva 0x4a085 attrs Private, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld DamageIndicatorUIHandler DamageIndicatorUI::damageIndicatorHandler  /*0x04001317*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_001f
    IL_000e: ldarg.0
    IL_000f: ldfld DamageIndicatorUIHandler DamageIndicatorUI::damageIndicatorHandler  /*0x04001317*/
    IL_0014: ldarg.0
    IL_0015: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001a: callvirt void DamageIndicatorUIHandler::RemoveDamageIndicatorFromPool(UnityEngine.GameObject)  /*0x06001037*/
    IL_001f: ret

  .method DamageIndicatorUI::.ctor()  // token 0x06001034 rva 0x4a0a6 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 50f
    IL_0006: stfld float DamageIndicatorUI::offset  /*0x04001311*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 90f
    IL_0011: stfld float DamageIndicatorUI::buildingFontSize  /*0x04001312*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

