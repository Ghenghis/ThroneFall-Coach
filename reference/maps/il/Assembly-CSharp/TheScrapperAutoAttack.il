// ===== TheScrapperAutoAttack  (token 0x020000E9) =====
  .method TheScrapperAutoAttack::get_CurrentAttackSource()  // token 0x060004F4 rva 0x1589f attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TheScrapperAttackOrigin.AttackSource TheScrapperAutoAttack::currentAttackSource  /*0x0400066B*/
    IL_0006: ret

  .method TheScrapperAutoAttack::Start()  // token 0x060004F5 rva 0x158a7 attrs Public, Virtual, HideBySig
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AutoAttack::Start()  /*0x06000233*/
    IL_0006: ldarg.0
    IL_0007: ldfld ExplosionWeapon TheScrapperAutoAttack::spurt  /*0x04000668*/
    IL_000c: ldnull
    IL_000d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0012: brfalse.s IL_001f
    IL_0014: ldstr "[TheScrapperAutoAttack] requires ExplosionWeapon to be set."
    IL_0019: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_001e: ret
    IL_001f: ldarg.0
    IL_0020: ldc.i4.1
    IL_0021: stfld bool TheScrapperAutoAttack::inited  /*0x0400066A*/
    IL_0026: ret

  .method TheScrapperAutoAttack::SetAttackOrigin(int)  // token 0x060004F6 rva 0x158d0 attrs Public, HideBySig
    // code size 71 (0x47), max stack 2, init locals
    .locals ([0] TheScrapperAttackOrigin)
    IL_0000: ldarg.1
    IL_0001: ldc.i4.0
    IL_0002: blt.s IL_0038
    IL_0004: ldarg.1
    IL_0005: ldarg.0
    IL_0006: ldfld List<TheScrapperAttackOrigin> TheScrapperAutoAttack::attackOrigins  /*0x04000667*/
    IL_000b: callvirt int System.Collections.Generic.List<TheScrapperAttackOrigin>::get_Count()  /*0x0A000216*/
    IL_0010: bge.s IL_0038
    IL_0012: ldarg.0
    IL_0013: ldfld List<TheScrapperAttackOrigin> TheScrapperAutoAttack::attackOrigins  /*0x04000667*/
    IL_0018: ldarg.1
    IL_0019: callvirt !0 System.Collections.Generic.List<TheScrapperAttackOrigin>::get_Item(int)  /*0x0A000217*/
    IL_001e: stloc.0
    IL_001f: ldarg.0
    IL_0020: ldloc.0
    IL_0021: ldfld Transform TheScrapperAttackOrigin::Origin  /*0x04000686*/
    IL_0026: stfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_002b: ldarg.0
    IL_002c: ldloc.0
    IL_002d: ldfld TheScrapperAttackOrigin.AttackSource TheScrapperAttackOrigin::Source  /*0x04000685*/
    IL_0032: stfld TheScrapperAttackOrigin.AttackSource TheScrapperAutoAttack::currentAttackSource  /*0x0400066B*/
    IL_0037: ret
    IL_0038: ldarg.0
    IL_0039: ldnull
    IL_003a: stfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_003f: ldarg.0
    IL_0040: ldc.i4.0
    IL_0041: stfld TheScrapperAttackOrigin.AttackSource TheScrapperAutoAttack::currentAttackSource  /*0x0400066B*/
    IL_0046: ret

  .method TheScrapperAutoAttack::SetRandomAttackOrigin()  // token 0x060004F7 rva 0x15924 attrs Public, HideBySig
    // code size 101 (0x65), max stack 3, init locals
    .locals ([0] int, [1] TheScrapperAttackOrigin)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TheScrapperAttackOrigin> TheScrapperAutoAttack::attackOrigins  /*0x04000667*/
    IL_0006: callvirt int System.Collections.Generic.List<TheScrapperAttackOrigin>::get_Count()  /*0x0A000216*/
    IL_000b: ldc.i4.0
    IL_000c: ble.s IL_0056
    IL_000e: ldc.r4 0f
    IL_0013: ldarg.0
    IL_0014: ldfld List<TheScrapperAttackOrigin> TheScrapperAutoAttack::attackOrigins  /*0x04000667*/
    IL_0019: callvirt int System.Collections.Generic.List<TheScrapperAttackOrigin>::get_Count()  /*0x0A000216*/
    IL_001e: conv.r4
    IL_001f: ldc.r4 0.001f
    IL_0024: sub
    IL_0025: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_002a: call int UnityEngine.Mathf::FloorToInt(float)  /*0x0A000144*/
    IL_002f: stloc.0
    IL_0030: ldarg.0
    IL_0031: ldfld List<TheScrapperAttackOrigin> TheScrapperAutoAttack::attackOrigins  /*0x04000667*/
    IL_0036: ldloc.0
    IL_0037: callvirt !0 System.Collections.Generic.List<TheScrapperAttackOrigin>::get_Item(int)  /*0x0A000217*/
    IL_003c: stloc.1
    IL_003d: ldarg.0
    IL_003e: ldloc.1
    IL_003f: ldfld Transform TheScrapperAttackOrigin::Origin  /*0x04000686*/
    IL_0044: stfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_0049: ldarg.0
    IL_004a: ldloc.1
    IL_004b: ldfld TheScrapperAttackOrigin.AttackSource TheScrapperAttackOrigin::Source  /*0x04000685*/
    IL_0050: stfld TheScrapperAttackOrigin.AttackSource TheScrapperAutoAttack::currentAttackSource  /*0x0400066B*/
    IL_0055: ret
    IL_0056: ldarg.0
    IL_0057: ldnull
    IL_0058: stfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_005d: ldarg.0
    IL_005e: ldc.i4.0
    IL_005f: stfld TheScrapperAttackOrigin.AttackSource TheScrapperAutoAttack::currentAttackSource  /*0x0400066B*/
    IL_0064: ret

  .method TheScrapperAutoAttack::OnAttack(TaggedObject)  // token 0x060004F8 rva 0x15995 attrs Public, Virtual, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool TheScrapperAutoAttack::inited  /*0x0400066A*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld bool TheScrapperAutoAttack::randomOrigin  /*0x04000666*/
    IL_000f: brfalse.s IL_0017
    IL_0011: ldarg.0
    IL_0012: call void TheScrapperAutoAttack::SetRandomAttackOrigin()  /*0x060004F7*/
    IL_0017: ldarg.0
    IL_0018: ldarg.1
    IL_0019: call void AutoAttack::OnAttack(TaggedObject)  /*0x06000235*/
    IL_001e: ret

  .method TheScrapperAutoAttack::Explode(UnityEngine.Transform)  // token 0x060004F9 rva 0x159b5 attrs Public, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool TheScrapperAutoAttack::inited  /*0x0400066A*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld ExplosionWeapon TheScrapperAutoAttack::spurt  /*0x04000668*/
    IL_000f: ldarg.1
    IL_0010: ldarg.0
    IL_0011: ldftn void TheScrapperAutoAttack::PlaySpurtEffect()  /*0x060004FA*/
    IL_0017: newobj void System.Action::.ctor(object,IntPtr)  /*0x0A0000E8*/
    IL_001c: ldnull
    IL_001d: callvirt void ExplosionWeapon::Explode(UnityEngine.Transform,System.Action,System.Action)  /*0x06000530*/
    IL_0022: ret

  .method TheScrapperAutoAttack::PlaySpurtEffect()  // token 0x060004FA rva 0x159d9 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent TheScrapperAutoAttack::spurtKnockBackAttempt  /*0x04000669*/
    IL_0006: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_000b: ret

  .method TheScrapperAutoAttack::.ctor()  // token 0x060004FB rva 0x159e6 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool TheScrapperAutoAttack::randomOrigin  /*0x04000666*/
    IL_0007: ldarg.0
    IL_0008: newobj void System.Collections.Generic.List<TheScrapperAttackOrigin>::.ctor()  /*0x0A000218*/
    IL_000d: stfld List<TheScrapperAttackOrigin> TheScrapperAutoAttack::attackOrigins  /*0x04000667*/
    IL_0012: ldarg.0
    IL_0013: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0018: stfld UnityEvent TheScrapperAutoAttack::spurtKnockBackAttempt  /*0x04000669*/
    IL_001d: ldarg.0
    IL_001e: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0023: ret

