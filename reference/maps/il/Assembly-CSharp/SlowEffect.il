// ===== SlowEffect  (token 0x02000292) =====
  .method SlowEffect::Effect(Hp,TaggedObject,TaggedObject,Weapon,float,bool,float)  // token 0x06000E2B rva 0x3f4d8 attrs Public, Virtual, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.1
    IL_0001: callvirt PathfindMovement Hp::get_PathfindMovement()  /*0x06000818*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_001e
    IL_000d: ldarg.1
    IL_000e: callvirt PathfindMovement Hp::get_PathfindMovement()  /*0x06000818*/
    IL_0013: ldarg.0
    IL_0014: ldfld float SlowEffect::slowDuration  /*0x04001071*/
    IL_0019: callvirt void PathfindMovement::Slow(float)  /*0x06000B07*/
    IL_001e: ret

  .method SlowEffect::.ctor()  // token 0x06000E2C rva 0x3f4f8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 2f
    IL_0006: stfld float SlowEffect::slowDuration  /*0x04001071*/
    IL_000b: ldarg.0
    IL_000c: call void AdditionalWeaponEffectScript::.ctor()  /*0x06000028*/
    IL_0011: ret

