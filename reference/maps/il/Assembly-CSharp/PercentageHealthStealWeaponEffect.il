// ===== PercentageHealthStealWeaponEffect  (token 0x02000211) =====
  .method PercentageHealthStealWeaponEffect::Effect(Hp,TaggedObject,TaggedObject,Weapon,float,bool,float)  // token 0x06000B4A rva 0x361c5 attrs Public, Virtual, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.3
    IL_0001: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0006: ldarg.s 7
    IL_0008: ldarg.0
    IL_0009: ldfld float PercentageHealthStealWeaponEffect::regenPercentage  /*0x04000E24*/
    IL_000e: mul
    IL_000f: callvirt void Hp::Heal(float)  /*0x0600082E*/
    IL_0014: ret

  .method PercentageHealthStealWeaponEffect::.ctor()  // token 0x06000B4B rva 0x361db attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.5f
    IL_0006: stfld float PercentageHealthStealWeaponEffect::regenPercentage  /*0x04000E24*/
    IL_000b: ldarg.0
    IL_000c: call void AdditionalWeaponEffectScript::.ctor()  /*0x06000028*/
    IL_0011: ret

