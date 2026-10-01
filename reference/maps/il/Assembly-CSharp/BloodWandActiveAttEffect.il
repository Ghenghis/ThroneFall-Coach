// ===== BloodWandActiveAttEffect  (token 0x02000082) =====
  .method BloodWandActiveAttEffect::Effect(Hp,TaggedObject,TaggedObject,Weapon,float,bool,float)  // token 0x06000297 rva 0xb960 attrs Public, Virtual, HideBySig
    // code size 127 (0x7f), max stack 5, init locals
    .locals ([0] float, [1] Hp, [2] float, [3] float)
    IL_0000: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_0005: ldarg.0
    IL_0006: ldfld float BloodWandActiveAttEffect::playerSlow  /*0x0400036B*/
    IL_000b: callvirt void PlayerMovement::Slow(float)  /*0x06000C25*/
    IL_0010: ldarg.0
    IL_0011: ldfld float BloodWandActiveAttEffect::healthToDamageRate  /*0x04000369*/
    IL_0016: stloc.0
    IL_0017: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_001c: callvirt Hp PlayerMovement::get_Hp()  /*0x06000C1C*/
    IL_0021: stloc.1
    IL_0022: ldarg.1
    IL_0023: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0028: ldloc.0
    IL_0029: div
    IL_002a: ldloc.1
    IL_002b: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0030: ldloc.1
    IL_0031: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0036: ldarg.0
    IL_0037: ldfld float BloodWandActiveAttEffect::playerMinHp  /*0x0400036A*/
    IL_003c: mul
    IL_003d: sub
    IL_003e: stloc.2
    IL_003f: ldloc.2
    IL_0040: call float UnityEngine.Mathf::Min(float,float)  /*0x0A000109*/
    IL_0045: stloc.3
    IL_0046: ldloc.3
    IL_0047: ldc.r4 0f
    IL_004c: bgt.un.s IL_004f
    IL_004e: ret
    IL_004f: ldloc.1
    IL_0050: ldloc.3
    IL_0051: ldloc.1
    IL_0052: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0057: ldc.r4 0.05f
    IL_005c: mul
    IL_005d: call float UnityEngine.Mathf::Max(float,float)  /*0x0A00004B*/
    IL_0062: ldnull
    IL_0063: ldc.i4.0
    IL_0064: ldc.i4.1
    IL_0065: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_006a: pop
    IL_006b: ldarg.1
    IL_006c: ldloc.3
    IL_006d: ldloc.0
    IL_006e: mul
    IL_006f: ldc.r4 1f
    IL_0074: add
    IL_0075: ldnull
    IL_0076: ldc.i4.0
    IL_0077: ldc.i4.1
    IL_0078: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_007d: pop
    IL_007e: ret

  .method BloodWandActiveAttEffect::.ctor()  // token 0x06000298 rva 0xb9eb attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float BloodWandActiveAttEffect::healthToDamageRate  /*0x04000369*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.1f
    IL_0011: stfld float BloodWandActiveAttEffect::playerMinHp  /*0x0400036A*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 3f
    IL_001c: stfld float BloodWandActiveAttEffect::playerSlow  /*0x0400036B*/
    IL_0021: ldarg.0
    IL_0022: call void AdditionalWeaponEffectScript::.ctor()  /*0x06000028*/
    IL_0027: ret

