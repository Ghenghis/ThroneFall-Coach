// ===== BlacksmithUpgrade  (token 0x02000080) =====
  .method BlacksmithUpgrade::Start()  // token 0x06000285 rva 0xb4ef attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BlacksmithUpgrade::hasLoadedDataFromSave  /*0x04000360*/
    IL_0006: brfalse.s IL_0011
    IL_0008: ldarg.0
    IL_0009: ldfld int BlacksmithUpgrade::researchTimeLeft  /*0x0400035E*/
    IL_000e: ldc.i4.0
    IL_000f: ble.s IL_001c
    IL_0011: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0016: ldarg.0
    IL_0017: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_001c: ret

  .method BlacksmithUpgrade::OnDawn_AfterSunrise()  // token 0x06000286 rva 0xb510 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 151 (0x97), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_000b: brfalse.s IL_0015
    IL_000d: ldarg.0
    IL_000e: ldfld bool BlacksmithUpgrade::bumpedResearchThisDawn  /*0x04000361*/
    IL_0013: brfalse.s IL_0016
    IL_0015: ret
    IL_0016: ldarg.0
    IL_0017: ldc.i4.1
    IL_0018: stfld bool BlacksmithUpgrade::bumpedResearchThisDawn  /*0x04000361*/
    IL_001d: ldarg.0
    IL_001e: ldc.i4.1
    IL_001f: stfld bool BlacksmithUpgrade::isInitializedForSaving  /*0x0400035F*/
    IL_0024: ldarg.0
    IL_0025: ldfld BuildingInteractor BlacksmithUpgrade::buildingInteractor  /*0x04000358*/
    IL_002a: callvirt bool BuildingInteractor::get_KnockedOutTonight()  /*0x06000BA2*/
    IL_002f: brfalse.s IL_0032
    IL_0031: ret
    IL_0032: ldarg.0
    IL_0033: ldarg.0
    IL_0034: ldfld int BlacksmithUpgrade::researchTimeLeft  /*0x0400035E*/
    IL_0039: ldc.i4.1
    IL_003a: sub
    IL_003b: stfld int BlacksmithUpgrade::researchTimeLeft  /*0x0400035E*/
    IL_0040: ldarg.0
    IL_0041: call void BlacksmithUpgrade::UpdateProgressBar()  /*0x0600028B*/
    IL_0046: ldarg.0
    IL_0047: ldfld int BlacksmithUpgrade::researchTimeLeft  /*0x0400035E*/
    IL_004c: ldc.i4.0
    IL_004d: bgt.s IL_0096
    IL_004f: ldarg.0
    IL_0050: ldfld ProductionBar BlacksmithUpgrade::productionBar  /*0x04000359*/
    IL_0055: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_005a: ldc.i4.0
    IL_005b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0060: ldarg.0
    IL_0061: ldfld BuildingInteractor BlacksmithUpgrade::buildingInteractor  /*0x04000358*/
    IL_0066: ldc.i4.0
    IL_0067: stfld bool BuildingInteractor::showsHarvestDeniedCueEvenWithNoIncome  /*0x04000E92*/
    IL_006c: ldarg.0
    IL_006d: call void BlacksmithUpgrade::ApplyUpgrade()  /*0x06000288*/
    IL_0072: ldarg.0
    IL_0073: ldfld BuildingInteractor BlacksmithUpgrade::buildingInteractor  /*0x04000358*/
    IL_0078: ldc.i4.0
    IL_0079: stfld bool BuildingInteractor::buildingIsCurrentlyBusyAndCantBeUpgraded  /*0x04000E9F*/
    IL_007e: ldarg.0
    IL_007f: ldfld BuildingInteractor BlacksmithUpgrade::buildingInteractor  /*0x04000358*/
    IL_0084: ldc.i4.0
    IL_0085: ldc.i4.0
    IL_0086: callvirt void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_008b: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0090: ldarg.0
    IL_0091: callvirt void DayNightCycle::UnregisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B4*/
    IL_0096: ret

  .method BlacksmithUpgrade::OnDawn_BeforeSunrise()  // token 0x06000287 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BlacksmithUpgrade::ApplyUpgrade()  // token 0x06000288 rva 0xb5b4 attrs Private, HideBySig
    // code size 128 (0x80), max stack 3, init locals
    .locals ([0] Weapon.EDamageAffectedByBlacksmithUpgrade)
    IL_0000: ldarg.0
    IL_0001: ldfld Weapon.EDamageAffectedByBlacksmithUpgrade BlacksmithUpgrade::upgrade  /*0x0400035A*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: ldc.i4.1
    IL_0009: sub
    IL_000a: switch (IL_0020, IL_0038, IL_0050, IL_0068)
    IL_001f: ret
    IL_0020: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0025: dup
    IL_0026: ldfld float BlacksmithUpgrades::meleeDamage  /*0x04000B80*/
    IL_002b: ldarg.0
    IL_002c: ldfld float BlacksmithUpgrade::multiplyer  /*0x0400035B*/
    IL_0031: mul
    IL_0032: stfld float BlacksmithUpgrades::meleeDamage  /*0x04000B80*/
    IL_0037: ret
    IL_0038: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_003d: dup
    IL_003e: ldfld float BlacksmithUpgrades::rangedDamage  /*0x04000B81*/
    IL_0043: ldarg.0
    IL_0044: ldfld float BlacksmithUpgrade::multiplyer  /*0x0400035B*/
    IL_0049: mul
    IL_004a: stfld float BlacksmithUpgrades::rangedDamage  /*0x04000B81*/
    IL_004f: ret
    IL_0050: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0055: dup
    IL_0056: ldfld float BlacksmithUpgrades::meleeResistance  /*0x04000B82*/
    IL_005b: ldarg.0
    IL_005c: ldfld float BlacksmithUpgrade::multiplyer  /*0x0400035B*/
    IL_0061: mul
    IL_0062: stfld float BlacksmithUpgrades::meleeResistance  /*0x04000B82*/
    IL_0067: ret
    IL_0068: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_006d: dup
    IL_006e: ldfld float BlacksmithUpgrades::rangedResistance  /*0x04000B83*/
    IL_0073: ldarg.0
    IL_0074: ldfld float BlacksmithUpgrade::multiplyer  /*0x0400035B*/
    IL_0079: mul
    IL_007a: stfld float BlacksmithUpgrades::rangedResistance  /*0x04000B83*/
    IL_007f: ret

  .method BlacksmithUpgrade::OnDusk()  // token 0x06000289 rva 0xb640 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool BlacksmithUpgrade::bumpedResearchThisDawn  /*0x04000361*/
    IL_0007: ret

  .method BlacksmithUpgrade::OnEnable()  // token 0x0600028A rva 0xb64c attrs Private, HideBySig
    // code size 96 (0x60), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponentInParent()<SaveLoadEntity>  /*0x2B00001E*/
    IL_0007: callvirt string SaveLoadEntity::get_GUID()  /*0x06000D09*/
    IL_000c: call void BlacksmithUpgrade::ManualLoad(string)  /*0x06000291*/
    IL_0011: ldarg.0
    IL_0012: ldfld bool BlacksmithUpgrade::hasLoadedDataFromSave  /*0x04000360*/
    IL_0017: brtrue.s IL_005f
    IL_0019: ldarg.0
    IL_001a: ldarg.0
    IL_001b: ldfld int BlacksmithUpgrade::researchTime  /*0x0400035C*/
    IL_0020: stfld int BlacksmithUpgrade::researchTimeLeft  /*0x0400035E*/
    IL_0025: ldarg.0
    IL_0026: ldfld Equippable BlacksmithUpgrade::researchSpeedPerk  /*0x0400035D*/
    IL_002b: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0030: brfalse.s IL_0040
    IL_0032: ldarg.0
    IL_0033: ldarg.0
    IL_0034: ldfld int BlacksmithUpgrade::researchTimeLeft  /*0x0400035E*/
    IL_0039: ldc.i4.1
    IL_003a: sub
    IL_003b: stfld int BlacksmithUpgrade::researchTimeLeft  /*0x0400035E*/
    IL_0040: ldarg.0
    IL_0041: call void BlacksmithUpgrade::UpdateProgressBar()  /*0x0600028B*/
    IL_0046: ldarg.0
    IL_0047: ldfld BuildingInteractor BlacksmithUpgrade::buildingInteractor  /*0x04000358*/
    IL_004c: ldc.i4.1
    IL_004d: stfld bool BuildingInteractor::buildingIsCurrentlyBusyAndCantBeUpgraded  /*0x04000E9F*/
    IL_0052: ldarg.0
    IL_0053: ldfld BuildingInteractor BlacksmithUpgrade::buildingInteractor  /*0x04000358*/
    IL_0058: ldc.i4.0
    IL_0059: ldc.i4.0
    IL_005a: callvirt void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_005f: ret

  .method BlacksmithUpgrade::UpdateProgressBar()  // token 0x0600028B rva 0xb6b8 attrs Private, HideBySig
    // code size 68 (0x44), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld ProductionBar BlacksmithUpgrade::productionBar  /*0x04000359*/
    IL_0006: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000b: ldc.i4.1
    IL_000c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0011: ldarg.0
    IL_0012: ldfld ProductionBar BlacksmithUpgrade::productionBar  /*0x04000359*/
    IL_0017: ldc.r4 1f
    IL_001c: ldarg.0
    IL_001d: ldfld int BlacksmithUpgrade::researchTimeLeft  /*0x0400035E*/
    IL_0022: conv.r4
    IL_0023: ldarg.0
    IL_0024: ldfld int BlacksmithUpgrade::researchTime  /*0x0400035C*/
    IL_0029: conv.r4
    IL_002a: div
    IL_002b: sub
    IL_002c: ldc.r4 0.075f
    IL_0031: add
    IL_0032: callvirt void ProductionBar::UpdateVisual(float)  /*0x06000C97*/
    IL_0037: ldarg.0
    IL_0038: ldfld BuildingInteractor BlacksmithUpgrade::buildingInteractor  /*0x04000358*/
    IL_003d: ldc.i4.1
    IL_003e: stfld bool BuildingInteractor::showsHarvestDeniedCueEvenWithNoIncome  /*0x04000E92*/
    IL_0043: ret

  .method BlacksmithUpgrade::OnDuskEarly()  // token 0x0600028C rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BlacksmithUpgrade::OnBeforeMainLoadPass(string)  // token 0x0600028D rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BlacksmithUpgrade::OnLoad(string)  // token 0x0600028E rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BlacksmithUpgrade::OnAfterMainLoadPass(string)  // token 0x0600028F rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BlacksmithUpgrade::OnSave(string)  // token 0x06000290 rva 0xb708 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 69 (0x45), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool BlacksmithUpgrade::isInitializedForSaving  /*0x0400035F*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.1
    IL_000a: ldarg.0
    IL_000b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0010: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_0015: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001a: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_001f: ldstr "_"
    IL_0024: ldarg.0
    IL_0025: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002a: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_002f: ldstr "_researchTimeLeft"
    IL_0034: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0039: ldarg.0
    IL_003a: ldfld int BlacksmithUpgrade::researchTimeLeft  /*0x0400035E*/
    IL_003f: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_0044: ret

  .method BlacksmithUpgrade::ManualLoad(string)  // token 0x06000291 rva 0xb75c attrs Private, HideBySig
    // code size 150 (0x96), max stack 6, init locals
    IL_0000: call bool MatchSaveLoadHandler::get_IsLoadingPermitted()  /*0x06000CF2*/
    IL_0005: brtrue.s IL_0008
    IL_0007: ret
    IL_0008: ldarg.0
    IL_0009: ldarg.1
    IL_000a: ldarg.0
    IL_000b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0010: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_0015: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001a: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_001f: ldstr "_"
    IL_0024: ldarg.0
    IL_0025: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002a: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_002f: ldstr "_researchTimeLeft"
    IL_0034: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0039: ldarg.0
    IL_003a: ldflda int BlacksmithUpgrade::researchTimeLeft  /*0x0400035E*/
    IL_003f: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_0044: stfld bool BlacksmithUpgrade::hasLoadedDataFromSave  /*0x04000360*/
    IL_0049: ldarg.0
    IL_004a: ldfld bool BlacksmithUpgrade::hasLoadedDataFromSave  /*0x04000360*/
    IL_004f: brfalse.s IL_0095
    IL_0051: ldarg.0
    IL_0052: ldfld int BlacksmithUpgrade::researchTimeLeft  /*0x0400035E*/
    IL_0057: ldc.i4.0
    IL_0058: ble.s IL_007a
    IL_005a: ldarg.0
    IL_005b: call void BlacksmithUpgrade::UpdateProgressBar()  /*0x0600028B*/
    IL_0060: ldarg.0
    IL_0061: ldfld BuildingInteractor BlacksmithUpgrade::buildingInteractor  /*0x04000358*/
    IL_0066: ldc.i4.1
    IL_0067: stfld bool BuildingInteractor::buildingIsCurrentlyBusyAndCantBeUpgraded  /*0x04000E9F*/
    IL_006c: ldarg.0
    IL_006d: ldfld BuildingInteractor BlacksmithUpgrade::buildingInteractor  /*0x04000358*/
    IL_0072: ldc.i4.0
    IL_0073: ldc.i4.0
    IL_0074: callvirt void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_0079: ret
    IL_007a: ldarg.0
    IL_007b: call void BlacksmithUpgrade::ApplyUpgrade()  /*0x06000288*/
    IL_0080: ldarg.0
    IL_0081: ldfld BuildingInteractor BlacksmithUpgrade::buildingInteractor  /*0x04000358*/
    IL_0086: ldc.i4.0
    IL_0087: ldc.i4.0
    IL_0088: callvirt void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_008d: ldarg.0
    IL_008e: ldc.i4.s -10
    IL_0090: stfld int BlacksmithUpgrade::researchTimeLeft  /*0x0400035E*/
    IL_0095: ret

  .method BlacksmithUpgrade::.ctor()  // token 0x06000292 rva 0xb7fe attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1.2f
    IL_0006: stfld float BlacksmithUpgrade::multiplyer  /*0x0400035B*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.2
    IL_000d: stfld int BlacksmithUpgrade::researchTime  /*0x0400035C*/
    IL_0012: ldarg.0
    IL_0013: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0018: ret

