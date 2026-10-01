// ===== PerkSpeedModifyer  (token 0x02000229) =====
  .method PerkSpeedModifyer::Start()  // token 0x06000B89 rva 0x36aab attrs Private, HideBySig
    // code size 57 (0x39), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkSpeedModifyer::requiredPerk  /*0x04000E63*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brfalse.s IL_0032
    IL_000d: ldarg.0
    IL_000e: ldfld PathfindMovementPlayerunit PerkSpeedModifyer::pathfindMovement  /*0x04000E65*/
    IL_0013: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0018: brfalse.s IL_0032
    IL_001a: ldarg.0
    IL_001b: ldfld PathfindMovementPlayerunit PerkSpeedModifyer::pathfindMovement  /*0x04000E65*/
    IL_0020: dup
    IL_0021: ldfld float PathfindMovementPlayerunit::movementSpeed  /*0x04000E01*/
    IL_0026: ldarg.0
    IL_0027: ldfld float PerkSpeedModifyer::speedMultiplyer  /*0x04000E64*/
    IL_002c: mul
    IL_002d: stfld float PathfindMovementPlayerunit::movementSpeed  /*0x04000E01*/
    IL_0032: ldarg.0
    IL_0033: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0038: ret

  .method PerkSpeedModifyer::.ctor()  // token 0x06000B8A rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

