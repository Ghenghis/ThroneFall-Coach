// ===== PerkRemoveDestroyedAtNightTag  (token 0x02000227) =====
  .method PerkRemoveDestroyedAtNightTag::Start()  // token 0x06000B85 rva 0x36a64 attrs Private, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkRemoveDestroyedAtNightTag::perkRequirement  /*0x04000E5E*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: ldfld BuildingInteractor PerkRemoveDestroyedAtNightTag::buildingInteractor  /*0x04000E5F*/
    IL_0013: ldc.i4.1
    IL_0014: callvirt void BuildingInteractor::SetNeverDenyHarvest(bool)  /*0x06000BAD*/
    IL_0019: ldarg.0
    IL_001a: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_001f: ret

  .method PerkRemoveDestroyedAtNightTag::.ctor()  // token 0x06000B86 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

