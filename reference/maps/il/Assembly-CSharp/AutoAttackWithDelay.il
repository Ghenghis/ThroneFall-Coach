// ===== AutoAttackWithDelay  (token 0x020000D0) =====
  .method AutoAttackWithDelay::Update()  // token 0x06000453 rva 0x130cc attrs Public, Virtual, HideBySig
    // code size 226 (0xe2), max stack 7, init locals
    .locals ([0] TaggedObject)
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_000a: brtrue.s IL_000d
    IL_000c: ret
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0014: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0019: sub
    IL_001a: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_001f: ldarg.0
    IL_0020: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0025: ldc.r4 0f
    IL_002a: ble.un.s IL_002d
    IL_002c: ret
    IL_002d: ldarg.0
    IL_002e: callvirt TaggedObject AutoAttack::FindAutoAttackTarget()  /*0x06000236*/
    IL_0033: stloc.0
    IL_0034: ldloc.0
    IL_0035: ldnull
    IL_0036: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_003b: brfalse.s IL_0058
    IL_003d: ldarg.0
    IL_003e: ldarg.0
    IL_003f: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0044: ldarg.0
    IL_0045: ldfld float AutoAttack::recheckTargetInterval  /*0x04000301*/
    IL_004a: add
    IL_004b: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0050: ldarg.0
    IL_0051: ldc.i4.0
    IL_0052: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_0057: ret
    IL_0058: ldarg.0
    IL_0059: ldarg.0
    IL_005a: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_005f: ldarg.0
    IL_0060: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_0065: ldarg.0
    IL_0066: ldfld float AutoAttackWithDelay::actualAttackDelay  /*0x0400057B*/
    IL_006b: add
    IL_006c: ldc.r4 1f
    IL_0071: ldc.r4 1f
    IL_0076: ldc.r4 2f
    IL_007b: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0080: mul
    IL_0081: sub
    IL_0082: ldarg.0
    IL_0083: ldfld float AutoAttack::cooldownRandomization  /*0x04000300*/
    IL_0088: mul
    IL_0089: add
    IL_008a: mul
    IL_008b: add
    IL_008c: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0091: ldarg.0
    IL_0092: ldfld float AutoAttackWithDelay::delayTimer  /*0x0400057C*/
    IL_0097: ldc.r4 0f
    IL_009c: bne.un.s IL_00af
    IL_009e: ldarg.0
    IL_009f: ldfld UnityEvent AutoAttackWithDelay::BeforeDelayedAttackTrigger  /*0x0400057A*/
    IL_00a4: dup
    IL_00a5: brtrue.s IL_00aa
    IL_00a7: pop
    IL_00a8: br.s IL_00af
    IL_00aa: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_00af: ldarg.0
    IL_00b0: ldarg.0
    IL_00b1: ldfld float AutoAttackWithDelay::delayTimer  /*0x0400057C*/
    IL_00b6: ldc.r4 1f
    IL_00bb: add
    IL_00bc: stfld float AutoAttackWithDelay::delayTimer  /*0x0400057C*/
    IL_00c1: ldarg.0
    IL_00c2: ldfld float AutoAttackWithDelay::delayTimer  /*0x0400057C*/
    IL_00c7: ldarg.0
    IL_00c8: ldfld float AutoAttackWithDelay::actualAttackDelay  /*0x0400057B*/
    IL_00cd: blt.un.s IL_00e1
    IL_00cf: ldarg.0
    IL_00d0: ldloc.0
    IL_00d1: callvirt void AutoAttack::OnAttack(TaggedObject)  /*0x06000235*/
    IL_00d6: ldarg.0
    IL_00d7: ldc.r4 0f
    IL_00dc: stfld float AutoAttackWithDelay::delayTimer  /*0x0400057C*/
    IL_00e1: ret

  .method AutoAttackWithDelay::.ctor()  // token 0x06000454 rva 0x131ba attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float AutoAttackWithDelay::actualAttackDelay  /*0x0400057B*/
    IL_000b: ldarg.0
    IL_000c: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0011: ret

