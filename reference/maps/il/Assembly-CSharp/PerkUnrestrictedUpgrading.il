// ===== PerkUnrestrictedUpgrading  (token 0x0200022A) =====
  .method PerkUnrestrictedUpgrading::Start()  // token 0x06000B8B rva 0x36ae5 attrs Private, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkUnrestrictedUpgrading::requiredEquippable  /*0x04000E66*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brfalse.s IL_001a
    IL_000d: ldarg.0
    IL_000e: ldfld BuildSlot PerkUnrestrictedUpgrading::buildSlot  /*0x04000E67*/
    IL_0013: ldc.i4.s -100
    IL_0015: callvirt void BuildSlot::SetRequiredRootLevelDifference(int)  /*0x060002C7*/
    IL_001a: ldarg.0
    IL_001b: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0020: ret

  .method PerkUnrestrictedUpgrading::.ctor()  // token 0x06000B8C rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

