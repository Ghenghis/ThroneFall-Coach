// ===== RoyalForgeUpgrade  (token 0x02000255) =====
  .method RoyalForgeUpgrade::Start()  // token 0x06000CB8 rva 0x3a7fb attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool RoyalForgeUpgrade::hasLoadedDataFromSave  /*0x04000F77*/
    IL_0006: brfalse.s IL_0011
    IL_0008: ldarg.0
    IL_0009: ldfld int RoyalForgeUpgrade::researchTimeLeft  /*0x04000F75*/
    IL_000e: ldc.i4.0
    IL_000f: ble.s IL_001c
    IL_0011: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0016: ldarg.0
    IL_0017: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_001c: ret

  .method RoyalForgeUpgrade::OnDawn_AfterSunrise()  // token 0x06000CB9 rva 0x3a81c attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 151 (0x97), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_000b: brfalse.s IL_0015
    IL_000d: ldarg.0
    IL_000e: ldfld bool RoyalForgeUpgrade::bumpedResearchThisDawn  /*0x04000F78*/
    IL_0013: brfalse.s IL_0016
    IL_0015: ret
    IL_0016: ldarg.0
    IL_0017: ldc.i4.1
    IL_0018: stfld bool RoyalForgeUpgrade::bumpedResearchThisDawn  /*0x04000F78*/
    IL_001d: ldarg.0
    IL_001e: ldc.i4.1
    IL_001f: stfld bool RoyalForgeUpgrade::isInitializedForSaving  /*0x04000F76*/
    IL_0024: ldarg.0
    IL_0025: ldfld BuildingInteractor RoyalForgeUpgrade::buildingInteractor  /*0x04000F6F*/
    IL_002a: callvirt bool BuildingInteractor::get_KnockedOutTonight()  /*0x06000BA2*/
    IL_002f: brfalse.s IL_0032
    IL_0031: ret
    IL_0032: ldarg.0
    IL_0033: ldarg.0
    IL_0034: ldfld int RoyalForgeUpgrade::researchTimeLeft  /*0x04000F75*/
    IL_0039: ldc.i4.1
    IL_003a: sub
    IL_003b: stfld int RoyalForgeUpgrade::researchTimeLeft  /*0x04000F75*/
    IL_0040: ldarg.0
    IL_0041: call void RoyalForgeUpgrade::UpdateProgressBar()  /*0x06000CC1*/
    IL_0046: ldarg.0
    IL_0047: ldfld int RoyalForgeUpgrade::researchTimeLeft  /*0x04000F75*/
    IL_004c: ldc.i4.0
    IL_004d: bgt.s IL_0096
    IL_004f: ldarg.0
    IL_0050: ldfld ProductionBar RoyalForgeUpgrade::productionBar  /*0x04000F70*/
    IL_0055: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_005a: ldc.i4.0
    IL_005b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0060: ldarg.0
    IL_0061: ldfld BuildingInteractor RoyalForgeUpgrade::buildingInteractor  /*0x04000F6F*/
    IL_0066: ldc.i4.0
    IL_0067: stfld bool BuildingInteractor::showsHarvestDeniedCueEvenWithNoIncome  /*0x04000E92*/
    IL_006c: ldarg.0
    IL_006d: call void RoyalForgeUpgrade::ApplyUpgrade()  /*0x06000CBB*/
    IL_0072: ldarg.0
    IL_0073: ldfld BuildingInteractor RoyalForgeUpgrade::buildingInteractor  /*0x04000F6F*/
    IL_0078: ldc.i4.0
    IL_0079: stfld bool BuildingInteractor::buildingIsCurrentlyBusyAndCantBeUpgraded  /*0x04000E9F*/
    IL_007e: ldarg.0
    IL_007f: ldfld BuildingInteractor RoyalForgeUpgrade::buildingInteractor  /*0x04000F6F*/
    IL_0084: ldc.i4.0
    IL_0085: ldc.i4.0
    IL_0086: callvirt void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_008b: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0090: ldarg.0
    IL_0091: callvirt void DayNightCycle::UnregisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B4*/
    IL_0096: ret

  .method RoyalForgeUpgrade::OnDawn_BeforeSunrise()  // token 0x06000CBA rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method RoyalForgeUpgrade::ApplyUpgrade()  // token 0x06000CBB rva 0x3a8c0 attrs Private, HideBySig
    // code size 90 (0x5a), max stack 3, init locals
    .locals ([0] RoyalForgeUpgrade.ERoyalForgeUpgrades)
    IL_0000: ldarg.0
    IL_0001: ldfld RoyalForgeUpgrade.ERoyalForgeUpgrades RoyalForgeUpgrade::upgrade  /*0x04000F71*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: switch (IL_001e, IL_002a, IL_0036, IL_0042)
    IL_001d: ret
    IL_001e: ldarg.0
    IL_001f: ldfld float RoyalForgeUpgrade::multiplyer  /*0x04000F72*/
    IL_0024: call void RoyalForgeUpgrade::AutoAttackMulti(float)  /*0x06000CBE*/
    IL_0029: ret
    IL_002a: ldarg.0
    IL_002b: ldfld float RoyalForgeUpgrade::multiplyer  /*0x04000F72*/
    IL_0030: call void RoyalForgeUpgrade::PlayerHealthMulti(float)  /*0x06000CBC*/
    IL_0035: ret
    IL_0036: ldarg.0
    IL_0037: ldfld float RoyalForgeUpgrade::multiplyer  /*0x04000F72*/
    IL_003c: call void RoyalForgeUpgrade::ManualAttackMulti(float)  /*0x06000CBD*/
    IL_0041: ret
    IL_0042: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0047: dup
    IL_0048: callvirt float PlayerUpgradeManager::get_PlayerDamageMultiplyer()  /*0x06000C67*/
    IL_004d: ldarg.0
    IL_004e: ldfld float RoyalForgeUpgrade::multiplyer  /*0x04000F72*/
    IL_0053: mul
    IL_0054: callvirt void PlayerUpgradeManager::set_PlayerDamageMultiplyer(float)  /*0x06000C68*/
    IL_0059: ret

  .method RoyalForgeUpgrade::PlayerHealthMulti(float)  // token 0x06000CBC rva 0x3a928 attrs Public, Static, HideBySig
    // code size 76 (0x4c), max stack 4, init locals
    .locals ([0] PlayerMovement[], [1] int)
    IL_0000: call PlayerManager PlayerManager::get_Instance()  /*0x06000C14*/
    IL_0005: callvirt PlayerMovement[] PlayerManager::get_RegisteredPlayers()  /*0x06000C15*/
    IL_000a: stloc.0
    IL_000b: ldc.i4.0
    IL_000c: stloc.1
    IL_000d: br.s IL_0033
    IL_000f: ldloc.0
    IL_0010: ldloc.1
    IL_0011: ldelem.ref
    IL_0012: callvirt !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_0017: dup
    IL_0018: dup
    IL_0019: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_001e: ldarg.0
    IL_001f: mul
    IL_0020: stfld float Hp::maxHp  /*0x04000A2C*/
    IL_0025: ldc.r4 3.4028235E+38f
    IL_002a: callvirt void Hp::Heal(float)  /*0x0600082E*/
    IL_002f: ldloc.1
    IL_0030: ldc.i4.1
    IL_0031: add
    IL_0032: stloc.1
    IL_0033: ldloc.1
    IL_0034: ldloc.0
    IL_0035: ldlen
    IL_0036: conv.i4
    IL_0037: blt.s IL_000f
    IL_0039: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_003e: dup
    IL_003f: callvirt float PlayerUpgradeManager::get_PlayerHealthRegenerationMultiplyer()  /*0x06000C69*/
    IL_0044: ldarg.0
    IL_0045: mul
    IL_0046: callvirt void PlayerUpgradeManager::set_PlayerHealthRegenerationMultiplyer(float)  /*0x06000C6A*/
    IL_004b: ret

  .method RoyalForgeUpgrade::ManualAttackMulti(float)  // token 0x06000CBD rva 0x3a980 attrs Public, Static, HideBySig
    // code size 102 (0x66), max stack 3, init locals
    IL_0000: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0005: callvirt ManualAttack PlayerInteraction::get_ManualAttack()  /*0x06000BFB*/
    IL_000a: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000f: brfalse.s IL_0065
    IL_0011: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0016: callvirt ManualAttack PlayerInteraction::get_ManualAttack()  /*0x06000BFB*/
    IL_001b: callvirt Type System.Object::GetType()  /*0x0A0002B4*/
    IL_0020: ldtoken StabMA  /*0x020001EE*/
    IL_0025: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_002a: call bool System.Type::op_Equality(System.Type,System.Type)  /*0x0A0002B6*/
    IL_002f: brfalse.s IL_004e
    IL_0031: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0036: callvirt ManualAttack PlayerInteraction::get_ManualAttack()  /*0x06000BFB*/
    IL_003b: castclass StabMA  /*0x020001EE*/
    IL_0040: dup
    IL_0041: ldfld float StabMA::maximumCooldownTime  /*0x04000CFA*/
    IL_0046: ldarg.0
    IL_0047: mul
    IL_0048: stfld float StabMA::maximumCooldownTime  /*0x04000CFA*/
    IL_004d: ret
    IL_004e: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0053: callvirt ManualAttack PlayerInteraction::get_ManualAttack()  /*0x06000BFB*/
    IL_0058: dup
    IL_0059: ldfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_005e: ldarg.0
    IL_005f: mul
    IL_0060: stfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_0065: ret

  .method RoyalForgeUpgrade::AutoAttackMulti(float)  // token 0x06000CBE rva 0x3a9f2 attrs Public, Static, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0005: callvirt ManualAttack PlayerInteraction::get_AutoAttack()  /*0x06000BFC*/
    IL_000a: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000f: brfalse.s IL_0028
    IL_0011: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0016: callvirt ManualAttack PlayerInteraction::get_AutoAttack()  /*0x06000BFC*/
    IL_001b: dup
    IL_001c: ldfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_0021: ldarg.0
    IL_0022: mul
    IL_0023: stfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_0028: ret

  .method RoyalForgeUpgrade::OnDusk()  // token 0x06000CBF rva 0x3aa1c attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool RoyalForgeUpgrade::bumpedResearchThisDawn  /*0x04000F78*/
    IL_0007: ret

  .method RoyalForgeUpgrade::OnEnable()  // token 0x06000CC0 rva 0x3aa28 attrs Private, HideBySig
    // code size 96 (0x60), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponentInParent()<SaveLoadEntity>  /*0x2B00001E*/
    IL_0007: callvirt string SaveLoadEntity::get_GUID()  /*0x06000D09*/
    IL_000c: call void RoyalForgeUpgrade::ManualLoad(string)  /*0x06000CC7*/
    IL_0011: ldarg.0
    IL_0012: ldfld bool RoyalForgeUpgrade::hasLoadedDataFromSave  /*0x04000F77*/
    IL_0017: brtrue.s IL_005f
    IL_0019: ldarg.0
    IL_001a: ldarg.0
    IL_001b: ldfld int RoyalForgeUpgrade::researchTime  /*0x04000F73*/
    IL_0020: stfld int RoyalForgeUpgrade::researchTimeLeft  /*0x04000F75*/
    IL_0025: ldarg.0
    IL_0026: ldfld Equippable RoyalForgeUpgrade::researchSpeedPerk  /*0x04000F74*/
    IL_002b: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0030: brfalse.s IL_0040
    IL_0032: ldarg.0
    IL_0033: ldarg.0
    IL_0034: ldfld int RoyalForgeUpgrade::researchTimeLeft  /*0x04000F75*/
    IL_0039: ldc.i4.1
    IL_003a: sub
    IL_003b: stfld int RoyalForgeUpgrade::researchTimeLeft  /*0x04000F75*/
    IL_0040: ldarg.0
    IL_0041: call void RoyalForgeUpgrade::UpdateProgressBar()  /*0x06000CC1*/
    IL_0046: ldarg.0
    IL_0047: ldfld BuildingInteractor RoyalForgeUpgrade::buildingInteractor  /*0x04000F6F*/
    IL_004c: ldc.i4.1
    IL_004d: stfld bool BuildingInteractor::buildingIsCurrentlyBusyAndCantBeUpgraded  /*0x04000E9F*/
    IL_0052: ldarg.0
    IL_0053: ldfld BuildingInteractor RoyalForgeUpgrade::buildingInteractor  /*0x04000F6F*/
    IL_0058: ldc.i4.0
    IL_0059: ldc.i4.0
    IL_005a: callvirt void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_005f: ret

  .method RoyalForgeUpgrade::UpdateProgressBar()  // token 0x06000CC1 rva 0x3aa94 attrs Private, HideBySig
    // code size 68 (0x44), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld ProductionBar RoyalForgeUpgrade::productionBar  /*0x04000F70*/
    IL_0006: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000b: ldc.i4.1
    IL_000c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0011: ldarg.0
    IL_0012: ldfld ProductionBar RoyalForgeUpgrade::productionBar  /*0x04000F70*/
    IL_0017: ldc.r4 1f
    IL_001c: ldarg.0
    IL_001d: ldfld int RoyalForgeUpgrade::researchTimeLeft  /*0x04000F75*/
    IL_0022: conv.r4
    IL_0023: ldarg.0
    IL_0024: ldfld int RoyalForgeUpgrade::researchTime  /*0x04000F73*/
    IL_0029: conv.r4
    IL_002a: div
    IL_002b: sub
    IL_002c: ldc.r4 0.075f
    IL_0031: add
    IL_0032: callvirt void ProductionBar::UpdateVisual(float)  /*0x06000C97*/
    IL_0037: ldarg.0
    IL_0038: ldfld BuildingInteractor RoyalForgeUpgrade::buildingInteractor  /*0x04000F6F*/
    IL_003d: ldc.i4.1
    IL_003e: stfld bool BuildingInteractor::showsHarvestDeniedCueEvenWithNoIncome  /*0x04000E92*/
    IL_0043: ret

  .method RoyalForgeUpgrade::OnDuskEarly()  // token 0x06000CC2 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method RoyalForgeUpgrade::OnBeforeMainLoadPass(string)  // token 0x06000CC3 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method RoyalForgeUpgrade::OnLoad(string)  // token 0x06000CC4 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method RoyalForgeUpgrade::OnAfterMainLoadPass(string)  // token 0x06000CC5 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method RoyalForgeUpgrade::OnSave(string)  // token 0x06000CC6 rva 0x3aae4 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 69 (0x45), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool RoyalForgeUpgrade::isInitializedForSaving  /*0x04000F76*/
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
    IL_003a: ldfld int RoyalForgeUpgrade::researchTimeLeft  /*0x04000F75*/
    IL_003f: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_0044: ret

  .method RoyalForgeUpgrade::ManualLoad(string)  // token 0x06000CC7 rva 0x3ab38 attrs Private, HideBySig
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
    IL_003a: ldflda int RoyalForgeUpgrade::researchTimeLeft  /*0x04000F75*/
    IL_003f: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_0044: stfld bool RoyalForgeUpgrade::hasLoadedDataFromSave  /*0x04000F77*/
    IL_0049: ldarg.0
    IL_004a: ldfld bool RoyalForgeUpgrade::hasLoadedDataFromSave  /*0x04000F77*/
    IL_004f: brfalse.s IL_0095
    IL_0051: ldarg.0
    IL_0052: ldfld int RoyalForgeUpgrade::researchTimeLeft  /*0x04000F75*/
    IL_0057: ldc.i4.0
    IL_0058: ble.s IL_007a
    IL_005a: ldarg.0
    IL_005b: call void RoyalForgeUpgrade::UpdateProgressBar()  /*0x06000CC1*/
    IL_0060: ldarg.0
    IL_0061: ldfld BuildingInteractor RoyalForgeUpgrade::buildingInteractor  /*0x04000F6F*/
    IL_0066: ldc.i4.1
    IL_0067: stfld bool BuildingInteractor::buildingIsCurrentlyBusyAndCantBeUpgraded  /*0x04000E9F*/
    IL_006c: ldarg.0
    IL_006d: ldfld BuildingInteractor RoyalForgeUpgrade::buildingInteractor  /*0x04000F6F*/
    IL_0072: ldc.i4.0
    IL_0073: ldc.i4.0
    IL_0074: callvirt void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_0079: ret
    IL_007a: ldarg.0
    IL_007b: call void RoyalForgeUpgrade::ApplyUpgrade()  /*0x06000CBB*/
    IL_0080: ldarg.0
    IL_0081: ldfld BuildingInteractor RoyalForgeUpgrade::buildingInteractor  /*0x04000F6F*/
    IL_0086: ldc.i4.0
    IL_0087: ldc.i4.0
    IL_0088: callvirt void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_008d: ldarg.0
    IL_008e: ldc.i4.s -10
    IL_0090: stfld int RoyalForgeUpgrade::researchTimeLeft  /*0x04000F75*/
    IL_0095: ret

  .method RoyalForgeUpgrade::.ctor()  // token 0x06000CC8 rva 0x3abda attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1.2f
    IL_0006: stfld float RoyalForgeUpgrade::multiplyer  /*0x04000F72*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.2
    IL_000d: stfld int RoyalForgeUpgrade::researchTime  /*0x04000F73*/
    IL_0012: ldarg.0
    IL_0013: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0018: ret

// ===== RoyalForgeUpgrade/ERoyalForgeUpgrades  (token 0x02000256) =====
