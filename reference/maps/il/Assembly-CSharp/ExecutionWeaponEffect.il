// ===== ExecutionWeaponEffect  (token 0x020000F5) =====
  .method ExecutionWeaponEffect::Effect(Hp,TaggedObject,TaggedObject,Weapon,float,bool,float)  // token 0x0600052A rva 0x16b21 attrs Public, Virtual, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.1
    IL_0001: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_0006: ldc.r4 100f
    IL_000b: mul
    IL_000c: ldarg.0
    IL_000d: ldfld float ExecutionWeaponEffect::targetHpThresholdPercentage  /*0x040006B8*/
    IL_0012: bgt.un.s IL_0029
    IL_0014: ldarg.2
    IL_0015: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_001a: ldarg.1
    IL_001b: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0020: ldarg.3
    IL_0021: ldc.i4.1
    IL_0022: ldc.i4.1
    IL_0023: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0028: pop
    IL_0029: ret

  .method ExecutionWeaponEffect::.ctor()  // token 0x0600052B rva 0x16b4c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 15f
    IL_0006: stfld float ExecutionWeaponEffect::targetHpThresholdPercentage  /*0x040006B8*/
    IL_000b: ldarg.0
    IL_000c: call void AdditionalWeaponEffectScript::.ctor()  /*0x06000028*/
    IL_0011: ret

