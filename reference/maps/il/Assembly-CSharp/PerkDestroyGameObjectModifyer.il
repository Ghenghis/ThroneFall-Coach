// ===== PerkDestroyGameObjectModifyer  (token 0x02000221) =====
  .method PerkDestroyGameObjectModifyer::get_IsGoingToBeDestroyed()  // token 0x06000B68 rva 0x366ee attrs Public, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkDestroyGameObjectModifyer::perk  /*0x04000E4B*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brfalse.s IL_0017
    IL_000d: ldarg.0
    IL_000e: ldfld bool PerkDestroyGameObjectModifyer::destroyIfPerkIsEquipped  /*0x04000E4C*/
    IL_0013: brfalse.s IL_0021
    IL_0015: ldc.i4.1
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldfld bool PerkDestroyGameObjectModifyer::destroyIfPerkIsNotEquipped  /*0x04000E4D*/
    IL_001d: brfalse.s IL_0021
    IL_001f: ldc.i4.1
    IL_0020: ret
    IL_0021: ldc.i4.0
    IL_0022: ret

  .method PerkDestroyGameObjectModifyer::Start()  // token 0x06000B69 rva 0x36712 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 53 (0x35), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkDestroyGameObjectModifyer::perk  /*0x04000E4B*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brfalse.s IL_0021
    IL_000d: ldarg.0
    IL_000e: ldfld bool PerkDestroyGameObjectModifyer::destroyIfPerkIsEquipped  /*0x04000E4C*/
    IL_0013: brfalse.s IL_0034
    IL_0015: ldarg.0
    IL_0016: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001b: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0020: ret
    IL_0021: ldarg.0
    IL_0022: ldfld bool PerkDestroyGameObjectModifyer::destroyIfPerkIsNotEquipped  /*0x04000E4D*/
    IL_0027: brfalse.s IL_0034
    IL_0029: ldarg.0
    IL_002a: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002f: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0034: ret

  .method PerkDestroyGameObjectModifyer::.ctor()  // token 0x06000B6A rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

