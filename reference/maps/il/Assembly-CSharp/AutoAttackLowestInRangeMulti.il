// ===== AutoAttackLowestInRangeMulti  (token 0x0200006C) =====
  .method AutoAttackLowestInRangeMulti::Start()  // token 0x0600023D rva 0xa0af attrs Public, Virtual, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AutoAttack::Start()  /*0x06000233*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: ldfld int AutoAttackLowestInRangeMulti::attackTargets  /*0x0400030E*/
    IL_000d: newarr TaggedObject  /*0x02000298*/
    IL_0012: stfld TaggedObject[] AutoAttackLowestInRangeMulti::targets  /*0x04000312*/
    IL_0017: ret

  .method AutoAttackLowestInRangeMulti::Update()  // token 0x0600023E rva 0xa0c8 attrs Public, Virtual, HideBySig
    // code size 338 (0x152), max stack 7, init locals
    .locals ([0] TaggedObject[], [1] int, [2] TaggedObject, [3] Vector3, [4] float)
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
    IL_002a: bgt.un IL_0151
    IL_002f: ldarg.0
    IL_0030: ldarg.0
    IL_0031: ldfld TaggedObject[] AutoAttackLowestInRangeMulti::targets  /*0x04000312*/
    IL_0036: call void AutoAttackLowestInRangeMulti::FindAutoAttackTargets(TaggedObject[])  /*0x0600023F*/
    IL_003b: ldarg.0
    IL_003c: ldarg.0
    IL_003d: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0042: ldarg.0
    IL_0043: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_0048: ldc.r4 1f
    IL_004d: ldc.r4 1f
    IL_0052: ldc.r4 2f
    IL_0057: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_005c: mul
    IL_005d: sub
    IL_005e: ldarg.0
    IL_005f: ldfld float AutoAttack::cooldownRandomization  /*0x04000300*/
    IL_0064: mul
    IL_0065: add
    IL_0066: mul
    IL_0067: add
    IL_0068: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_006d: ldarg.0
    IL_006e: ldfld TaggedObject[] AutoAttackLowestInRangeMulti::targets  /*0x04000312*/
    IL_0073: stloc.0
    IL_0074: ldc.i4.0
    IL_0075: stloc.1
    IL_0076: br IL_0148
    IL_007b: ldloc.0
    IL_007c: ldloc.1
    IL_007d: ldelem.ref
    IL_007e: stloc.2
    IL_007f: ldloc.2
    IL_0080: ldnull
    IL_0081: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0086: brtrue IL_0144
    IL_008b: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0090: ldc.r4 0.5f
    IL_0095: sub
    IL_0096: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_009b: ldc.r4 0.5f
    IL_00a0: sub
    IL_00a1: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_00a6: ldc.r4 0.5f
    IL_00ab: sub
    IL_00ac: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld float AutoAttackLowestInRangeMulti::randomizeSpawnPosition  /*0x04000310*/
    IL_00b7: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00bc: stloc.3
    IL_00bd: ldc.r4 1f
    IL_00c2: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_00c7: ldc.r4 0.5f
    IL_00cc: sub
    IL_00cd: ldarg.0
    IL_00ce: ldfld float AutoAttackLowestInRangeMulti::randomizeProjectileSpeed  /*0x04000311*/
    IL_00d3: mul
    IL_00d4: add
    IL_00d5: stloc.s 4
    IL_00d7: ldarg.0
    IL_00d8: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_00dd: ldarg.0
    IL_00de: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00e3: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00e8: ldarg.0
    IL_00e9: ldfld float AutoAttack::spawnAttackHeight  /*0x04000304*/
    IL_00ee: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_00f3: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_00f8: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00fd: ldloc.3
    IL_00fe: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0103: ldloc.2
    IL_0104: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0109: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_010e: ldarg.0
    IL_010f: ldfld TaggedObject AutoAttack::taggedObject  /*0x04000305*/
    IL_0114: ldarg.0
    IL_0115: ldfld float AutoAttack::damageMultiplyer  /*0x04000309*/
    IL_011a: ldloc.s 4
    IL_011c: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_0121: ldarg.0
    IL_0122: ldloc.2
    IL_0123: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0128: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_012d: stfld Vector3 AutoAttack::lastTargetPosition  /*0x0400030C*/
    IL_0132: ldarg.0
    IL_0133: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0138: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_013d: ldarg.0
    IL_013e: ldc.i4.1
    IL_013f: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_0144: ldloc.1
    IL_0145: ldc.i4.1
    IL_0146: add
    IL_0147: stloc.1
    IL_0148: ldloc.1
    IL_0149: ldloc.0
    IL_014a: ldlen
    IL_014b: conv.i4
    IL_014c: blt IL_007b
    IL_0151: ret

  .method AutoAttackLowestInRangeMulti::FindAutoAttackTargets(TaggedObject[])  // token 0x0600023F rva 0xa228 attrs Private, HideBySig
    // code size 72 (0x48), max stack 4, init locals
    .locals ([0] Vector3, [1] int)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: stloc.0
    IL_000c: ldc.i4.0
    IL_000d: stloc.1
    IL_000e: br.s IL_0039
    IL_0010: ldarg.0
    IL_0011: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0016: ldloc.1
    IL_0017: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_001c: ldloc.0
    IL_001d: ldarg.1
    IL_001e: ldarg.0
    IL_001f: ldfld bool AutoAttackLowestInRangeMulti::excludeFullHealthTargets  /*0x0400030F*/
    IL_0024: callvirt void TargetPriority::FindLowestHealthTaggedObjects(UnityEngine.Vector3,TaggedObject[],bool)  /*0x06000E74*/
    IL_0029: ldarg.1
    IL_002a: ldloc.1
    IL_002b: ldelem.ref
    IL_002c: ldnull
    IL_002d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0032: brfalse.s IL_0035
    IL_0034: ret
    IL_0035: ldloc.1
    IL_0036: ldc.i4.1
    IL_0037: add
    IL_0038: stloc.1
    IL_0039: ldloc.1
    IL_003a: ldarg.0
    IL_003b: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0040: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_0045: blt.s IL_0010
    IL_0047: ret

  .method AutoAttackLowestInRangeMulti::.ctor()  // token 0x06000240 rva 0xa27c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.3
    IL_0002: stfld int AutoAttackLowestInRangeMulti::attackTargets  /*0x0400030E*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: stfld bool AutoAttackLowestInRangeMulti::excludeFullHealthTargets  /*0x0400030F*/
    IL_000e: ldarg.0
    IL_000f: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0014: ret

