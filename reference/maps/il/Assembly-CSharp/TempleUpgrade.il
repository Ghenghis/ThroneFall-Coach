// ===== TempleUpgrade  (token 0x020002B4) =====
  .method TempleUpgrade::Start()  // token 0x06000ED9 rva 0xad0b attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: ret

  .method TempleUpgrade::OnDawn_AfterSunrise()  // token 0x06000EDA rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TempleUpgrade::OnDawn_BeforeSunrise()  // token 0x06000EDB rva 0x42d58 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 71 (0x47), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool TempleUpgrade::effectCurrentlyEnabled  /*0x0400112E*/
    IL_0006: brfalse.s IL_0046
    IL_0008: ldarg.0
    IL_0009: callvirt void TempleUpgrade::DisableEffectAtDawn()  /*0x06000EE5*/
    IL_000e: ldarg.0
    IL_000f: ldc.i4.2
    IL_0010: stfld TempleUpgrade.State TempleUpgrade::state  /*0x0400112D*/
    IL_0015: ldarg.0
    IL_0016: ldfld GameObject TempleUpgrade::activeIndicator  /*0x0400112C*/
    IL_001b: callvirt GameObject UnityEngine.GameObject::get_gameObject()  /*0x0A0005FE*/
    IL_0020: ldc.i4.0
    IL_0021: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0026: ldarg.0
    IL_0027: ldfld BuildingInteractor TempleUpgrade::buildingInteractor  /*0x0400112B*/
    IL_002c: ldc.i4.0
    IL_002d: stfld bool BuildingInteractor::buildingIsCurrentlyBusyAndCantBeUpgraded  /*0x04000E9F*/
    IL_0032: ldarg.0
    IL_0033: ldfld BuildingInteractor TempleUpgrade::buildingInteractor  /*0x0400112B*/
    IL_0038: ldc.i4.0
    IL_0039: ldc.i4.0
    IL_003a: callvirt void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_003f: ldarg.0
    IL_0040: ldc.i4.0
    IL_0041: stfld bool TempleUpgrade::effectCurrentlyEnabled  /*0x0400112E*/
    IL_0046: ret

  .method TempleUpgrade::OnDusk()  // token 0x06000EDC rva 0x42dab attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TempleUpgrade.State TempleUpgrade::state  /*0x0400112D*/
    IL_0006: ldc.i4.1
    IL_0007: bne.un.s IL_0016
    IL_0009: ldarg.0
    IL_000a: ldc.i4.1
    IL_000b: stfld bool TempleUpgrade::effectCurrentlyEnabled  /*0x0400112E*/
    IL_0010: ldarg.0
    IL_0011: callvirt void TempleUpgrade::EnableEffectAtDusk()  /*0x06000EE4*/
    IL_0016: ret

  .method TempleUpgrade::OnEnable()  // token 0x06000EDD rva 0x42dc4 attrs Private, HideBySig
    // code size 92 (0x5c), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponentInParent()<SaveLoadEntity>  /*0x2B00001E*/
    IL_0007: callvirt string SaveLoadEntity::get_GUID()  /*0x06000D09*/
    IL_000c: call void TempleUpgrade::ManualLoad(string)  /*0x06000EDF*/
    IL_0011: ldarg.0
    IL_0012: ldfld bool TempleUpgrade::hasLoadedDataFromSave  /*0x0400112F*/
    IL_0017: brtrue.s IL_0054
    IL_0019: ldarg.0
    IL_001a: ldfld TempleUpgrade.State TempleUpgrade::state  /*0x0400112D*/
    IL_001f: brtrue.s IL_0054
    IL_0021: ldarg.0
    IL_0022: ldfld GameObject TempleUpgrade::activeIndicator  /*0x0400112C*/
    IL_0027: ldc.i4.1
    IL_0028: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_002d: ldarg.0
    IL_002e: ldfld BuildingInteractor TempleUpgrade::buildingInteractor  /*0x0400112B*/
    IL_0033: ldc.i4.1
    IL_0034: stfld bool BuildingInteractor::buildingIsCurrentlyBusyAndCantBeUpgraded  /*0x04000E9F*/
    IL_0039: ldarg.0
    IL_003a: ldfld BuildingInteractor TempleUpgrade::buildingInteractor  /*0x0400112B*/
    IL_003f: ldc.i4.0
    IL_0040: ldc.i4.0
    IL_0041: callvirt void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_0046: ldarg.0
    IL_0047: ldc.i4.1
    IL_0048: stfld TempleUpgrade.State TempleUpgrade::state  /*0x0400112D*/
    IL_004d: ldarg.0
    IL_004e: callvirt void TempleUpgrade::EnableEffectAtPurchase()  /*0x06000EE6*/
    IL_0053: ret
    IL_0054: ldarg.0
    IL_0055: ldc.i4.2
    IL_0056: stfld TempleUpgrade.State TempleUpgrade::state  /*0x0400112D*/
    IL_005b: ret

  .method TempleUpgrade::OnSave(string)  // token 0x06000EDE rva 0x42e2c attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 68 (0x44), max stack 5, init locals
    .locals ([0] TempleUpgrade.State)
    IL_0000: ldarg.0
    IL_0001: ldfld TempleUpgrade.State TempleUpgrade::state  /*0x0400112D*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: ldc.i4.1
    IL_0009: bne.un.s IL_000d
    IL_000b: ldc.i4.2
    IL_000c: stloc.0
    IL_000d: ldarg.1
    IL_000e: ldarg.0
    IL_000f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0014: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_0019: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001e: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0023: ldstr "_"
    IL_0028: ldarg.0
    IL_0029: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002e: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0033: ldstr "_state"
    IL_0038: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_003d: ldloc.0
    IL_003e: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_0043: ret

  .method TempleUpgrade::ManualLoad(string)  // token 0x06000EDF rva 0x42e7c attrs Private, HideBySig
    // code size 87 (0x57), max stack 6, init locals
    .locals ([0] int)
    IL_0000: call bool MatchSaveLoadHandler::get_IsLoadingPermitted()  /*0x06000CF2*/
    IL_0005: brtrue.s IL_0008
    IL_0007: ret
    IL_0008: ldc.i4.m1
    IL_0009: stloc.0
    IL_000a: ldarg.0
    IL_000b: ldarg.1
    IL_000c: ldarg.0
    IL_000d: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0012: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_0017: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001c: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0021: ldstr "_"
    IL_0026: ldarg.0
    IL_0027: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002c: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0031: ldstr "_state"
    IL_0036: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_003b: ldloca.s 0
    IL_003d: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_0042: stfld bool TempleUpgrade::hasLoadedDataFromSave  /*0x0400112F*/
    IL_0047: ldarg.0
    IL_0048: ldfld bool TempleUpgrade::hasLoadedDataFromSave  /*0x0400112F*/
    IL_004d: brfalse.s IL_0056
    IL_004f: ldarg.0
    IL_0050: ldloc.0
    IL_0051: stfld TempleUpgrade.State TempleUpgrade::state  /*0x0400112D*/
    IL_0056: ret

  .method TempleUpgrade::OnDuskEarly()  // token 0x06000EE0 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TempleUpgrade::OnBeforeMainLoadPass(string)  // token 0x06000EE1 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TempleUpgrade::OnLoad(string)  // token 0x06000EE2 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TempleUpgrade::OnAfterMainLoadPass(string)  // token 0x06000EE3 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TempleUpgrade::EnableEffectAtDusk()  // token 0x06000EE4 rva 0x25f1 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TempleUpgrade::DisableEffectAtDawn()  // token 0x06000EE5 rva 0x25f1 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TempleUpgrade::EnableEffectAtPurchase()  // token 0x06000EE6 rva 0x25f1 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TempleUpgrade::.ctor()  // token 0x06000EE7 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== TempleUpgrade/State  (token 0x020002B5) =====
