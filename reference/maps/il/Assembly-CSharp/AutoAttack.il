// ===== AutoAttack  (token 0x02000069) =====
  .method AutoAttack::get_DamageMultiplyer()  // token 0x0600022C rva 0x9d59 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float AutoAttack::damageMultiplyer  /*0x04000309*/
    IL_0006: ret

  .method AutoAttack::set_DamageMultiplyer(float)  // token 0x0600022D rva 0x9d61 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float AutoAttack::damageMultiplyer  /*0x04000309*/
    IL_0007: ret

  .method AutoAttack::get_ProjectileSpeedMultiplyer()  // token 0x0600022E rva 0x9d6a attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float AutoAttack::projectileSpeedMultiplyer  /*0x0400030A*/
    IL_0006: ret

  .method AutoAttack::set_ProjectileSpeedMultiplyer(float)  // token 0x0600022F rva 0x9d72 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float AutoAttack::projectileSpeedMultiplyer  /*0x0400030A*/
    IL_0007: ret

  .method AutoAttack::get_LastTargetPosition()  // token 0x06000230 rva 0x9d7b attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector3 AutoAttack::lastTargetPosition  /*0x0400030C*/
    IL_0006: ret

  .method AutoAttack::ReduceCooldownBy(float)  // token 0x06000231 rva 0x9d83 attrs Public, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0007: ldarg.1
    IL_0008: sub
    IL_0009: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_000e: ret

  .method AutoAttack::SetCooldownTo(float)  // token 0x06000232 rva 0x9d93 attrs Public, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0007: ldarg.0
    IL_0008: ldarg.1
    IL_0009: stfld float AutoAttack::cooldownAfterSpawn  /*0x040002FF*/
    IL_000e: ret

  .method AutoAttack::Start()  // token 0x06000233 rva 0x9da3 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float AutoAttack::cooldownAfterSpawn  /*0x040002FF*/
    IL_0007: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: call !!0 UnityEngine.Component::GetComponent()<TaggedObject>  /*0x2B000005*/
    IL_0013: stfld TaggedObject AutoAttack::taggedObject  /*0x04000305*/
    IL_0018: ret

  .method AutoAttack::Update()  // token 0x06000234 rva 0x9dc0 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 146 (0x92), max stack 7, init locals
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
    IL_0065: ldc.r4 1f
    IL_006a: ldc.r4 1f
    IL_006f: ldc.r4 2f
    IL_0074: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0079: mul
    IL_007a: sub
    IL_007b: ldarg.0
    IL_007c: ldfld float AutoAttack::cooldownRandomization  /*0x04000300*/
    IL_0081: mul
    IL_0082: add
    IL_0083: mul
    IL_0084: add
    IL_0085: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_008a: ldarg.0
    IL_008b: ldloc.0
    IL_008c: callvirt void AutoAttack::OnAttack(TaggedObject)  /*0x06000235*/
    IL_0091: ret

  .method AutoAttack::OnAttack(TaggedObject)  // token 0x06000235 rva 0x9e60 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 136 (0x88), max stack 7, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: ldarg.0
    IL_000c: ldfld float AutoAttack::spawnAttackHeight  /*0x04000304*/
    IL_0011: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0016: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_001b: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0020: stloc.0
    IL_0021: ldarg.0
    IL_0022: ldfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_0027: ldnull
    IL_0028: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002d: brfalse.s IL_003b
    IL_002f: ldarg.0
    IL_0030: ldfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_0035: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_003a: stloc.0
    IL_003b: ldarg.0
    IL_003c: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_0041: ldloc.0
    IL_0042: ldarg.1
    IL_0043: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0048: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_004d: ldarg.0
    IL_004e: ldfld TaggedObject AutoAttack::taggedObject  /*0x04000305*/
    IL_0053: ldarg.0
    IL_0054: ldfld float AutoAttack::damageMultiplyer  /*0x04000309*/
    IL_0059: ldarg.0
    IL_005a: ldfld float AutoAttack::projectileSpeedMultiplyer  /*0x0400030A*/
    IL_005f: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_0064: ldarg.0
    IL_0065: ldarg.1
    IL_0066: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_006b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0070: stfld Vector3 AutoAttack::lastTargetPosition  /*0x0400030C*/
    IL_0075: ldarg.0
    IL_0076: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_007b: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0080: ldarg.0
    IL_0081: ldc.i4.1
    IL_0082: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_0087: ret

  .method AutoAttack::FindAutoAttackTarget()  // token 0x06000236 rva 0x9ef4 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 66 (0x42), max stack 2, init locals
    .locals ([0] Vector3, [1] int, [2] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: stloc.0
    IL_000c: ldc.i4.0
    IL_000d: stloc.1
    IL_000e: br.s IL_0032
    IL_0010: ldarg.0
    IL_0011: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0016: ldloc.1
    IL_0017: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_001c: ldloc.0
    IL_001d: callvirt TaggedObject TargetPriority::FindClosestTaggedObject(UnityEngine.Vector3)  /*0x06000E6F*/
    IL_0022: stloc.2
    IL_0023: ldloc.2
    IL_0024: ldnull
    IL_0025: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002a: brfalse.s IL_002e
    IL_002c: ldloc.2
    IL_002d: ret
    IL_002e: ldloc.1
    IL_002f: ldc.i4.1
    IL_0030: add
    IL_0031: stloc.1
    IL_0032: ldloc.1
    IL_0033: ldarg.0
    IL_0034: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0039: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_003e: blt.s IL_0010
    IL_0040: ldnull
    IL_0041: ret

  .method AutoAttack::FindAutoAttackTarget(System.Collections.Generic.List<TargetPriority>,UnityEngine.Vector3)  // token 0x06000237 rva 0x9f44 attrs Public, Static, HideBySig
    // code size 44 (0x2c), max stack 2, init locals
    .locals ([0] int, [1] TaggedObject)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_0021
    IL_0004: ldarg.0
    IL_0005: ldloc.0
    IL_0006: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_000b: ldarg.1
    IL_000c: callvirt TaggedObject TargetPriority::FindClosestTaggedObject(UnityEngine.Vector3)  /*0x06000E6F*/
    IL_0011: stloc.1
    IL_0012: ldloc.1
    IL_0013: ldnull
    IL_0014: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0019: brfalse.s IL_001d
    IL_001b: ldloc.1
    IL_001c: ret
    IL_001d: ldloc.0
    IL_001e: ldc.i4.1
    IL_001f: add
    IL_0020: stloc.0
    IL_0021: ldloc.0
    IL_0022: ldarg.0
    IL_0023: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_0028: blt.s IL_0004
    IL_002a: ldnull
    IL_002b: ret

  .method AutoAttack::.ctor()  // token 0x06000238 rva 0x9f7c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 106 (0x6a), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 -1f
    IL_0011: stfld float AutoAttack::cooldownAfterSpawn  /*0x040002FF*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.5f
    IL_001c: stfld float AutoAttack::recheckTargetInterval  /*0x04000301*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<TargetPriority>::.ctor()  /*0x0A0000E5*/
    IL_0027: stfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 0.5f
    IL_0032: stfld float AutoAttack::spawnAttackHeight  /*0x04000304*/
    IL_0037: ldarg.0
    IL_0038: ldc.r4 -1f
    IL_003d: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0042: ldarg.0
    IL_0043: ldc.r4 1f
    IL_0048: stfld float AutoAttack::damageMultiplyer  /*0x04000309*/
    IL_004d: ldarg.0
    IL_004e: ldc.r4 1f
    IL_0053: stfld float AutoAttack::projectileSpeedMultiplyer  /*0x0400030A*/
    IL_0058: ldarg.0
    IL_0059: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_005e: stfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0063: ldarg.0
    IL_0064: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0069: ret

