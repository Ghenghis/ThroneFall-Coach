// ===== BloodWandPassiveAttEffect  (token 0x02000083) =====
  .method BloodWandPassiveAttEffect::Effect(Hp,TaggedObject,TaggedObject,Weapon,float,bool,float)  // token 0x06000299 rva 0xba14 attrs Public, Virtual, HideBySig
    // code size 157 (0x9d), max stack 5, init locals
    .locals ([0] float)
    IL_0000: ldarg.1
    IL_0001: ldsfld Hp BloodWandPassiveAttEffect::lastHit  /*0x0400036C*/
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_0081
    IL_000d: call float UnityEngine.Time::get_time()  /*0x0A00010A*/
    IL_0012: ldarg.0
    IL_0013: ldfld float BloodWandPassiveAttEffect::lastHitTiming  /*0x0400036E*/
    IL_0018: sub
    IL_0019: ldc.r4 0f
    IL_001e: ldc.r4 0.22f
    IL_0023: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_0028: stloc.0
    IL_0029: ldarg.0
    IL_002a: call float UnityEngine.Time::get_time()  /*0x0A00010A*/
    IL_002f: stfld float BloodWandPassiveAttEffect::lastHitTiming  /*0x0400036E*/
    IL_0034: ldsfld float BloodWandPassiveAttEffect::dmgMulti  /*0x0400036D*/
    IL_0039: ldarg.0
    IL_003a: ldfld float BloodWandPassiveAttEffect::dmgIncreasePerSecond  /*0x0400036F*/
    IL_003f: ldloc.0
    IL_0040: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0045: mul
    IL_0046: stsfld float BloodWandPassiveAttEffect::dmgMulti  /*0x0400036D*/
    IL_004b: ldsfld float BloodWandPassiveAttEffect::dmgMulti  /*0x0400036D*/
    IL_0050: ldc.r4 1f
    IL_0055: ldarg.0
    IL_0056: ldfld float BloodWandPassiveAttEffect::maxDmgMulti  /*0x04000370*/
    IL_005b: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_0060: stsfld float BloodWandPassiveAttEffect::dmgMulti  /*0x0400036D*/
    IL_0065: ldarg.1
    IL_0066: ldarg.s 7
    IL_0068: ldarg.s 5
    IL_006a: mul
    IL_006b: ldsfld float BloodWandPassiveAttEffect::dmgMulti  /*0x0400036D*/
    IL_0070: ldc.r4 1f
    IL_0075: sub
    IL_0076: mul
    IL_0077: ldnull
    IL_0078: ldc.i4.0
    IL_0079: ldc.i4.1
    IL_007a: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_007f: pop
    IL_0080: ret
    IL_0081: ldarg.1
    IL_0082: stsfld Hp BloodWandPassiveAttEffect::lastHit  /*0x0400036C*/
    IL_0087: ldc.r4 1f
    IL_008c: stsfld float BloodWandPassiveAttEffect::dmgMulti  /*0x0400036D*/
    IL_0091: ldarg.0
    IL_0092: call float UnityEngine.Time::get_time()  /*0x0A00010A*/
    IL_0097: stfld float BloodWandPassiveAttEffect::lastHitTiming  /*0x0400036E*/
    IL_009c: ret

  .method BloodWandPassiveAttEffect::.ctor()  // token 0x0600029A rva 0xbabd attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1.05f
    IL_0006: stfld float BloodWandPassiveAttEffect::dmgIncreasePerSecond  /*0x0400036F*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 10f
    IL_0011: stfld float BloodWandPassiveAttEffect::maxDmgMulti  /*0x04000370*/
    IL_0016: ldarg.0
    IL_0017: call void AdditionalWeaponEffectScript::.ctor()  /*0x06000028*/
    IL_001c: ret

  .method BloodWandPassiveAttEffect::.cctor()  // token 0x0600029B rva 0xbadb attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 17 (0x11), max stack 8
    IL_0000: ldnull
    IL_0001: stsfld Hp BloodWandPassiveAttEffect::lastHit  /*0x0400036C*/
    IL_0006: ldc.r4 1f
    IL_000b: stsfld float BloodWandPassiveAttEffect::dmgMulti  /*0x0400036D*/
    IL_0010: ret

