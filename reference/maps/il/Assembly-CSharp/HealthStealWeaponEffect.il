// ===== HealthStealWeaponEffect  (token 0x02000190) =====
  .method HealthStealWeaponEffect::Effect(Hp,TaggedObject,TaggedObject,Weapon,float,bool,float)  // token 0x06000809 rva 0x278f3 attrs Public, Virtual, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.3
    IL_0001: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0006: ldarg.0
    IL_0007: ldfld float HealthStealWeaponEffect::regenTargetHp  /*0x04000A1B*/
    IL_000c: callvirt void Hp::Heal(float)  /*0x0600082E*/
    IL_0011: ret

  .method HealthStealWeaponEffect::.ctor()  // token 0x0600080A rva 0x27906 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 2f
    IL_0006: stfld float HealthStealWeaponEffect::regenTargetHp  /*0x04000A1B*/
    IL_000b: ldarg.0
    IL_000c: call void AdditionalWeaponEffectScript::.ctor()  /*0x06000028*/
    IL_0011: ret

