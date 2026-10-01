// ===== AutoAttackWithMinRange  (token 0x020000D1) =====
  .method AutoAttackWithMinRange::Update()  // token 0x06000455 rva 0x131d0 attrs Public, Virtual, HideBySig
    // code size 199 (0xc7), max stack 7, init locals
    .locals ([0] bool, [1] List.Enumerator<TaggedObject>, [2] TaggedObject)
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
    IL_002e: call void AutoAttackWithMinRange::FindAutoAttackTargets()  /*0x06000456*/
    IL_0033: ldc.i4.0
    IL_0034: stloc.0
    IL_0035: ldarg.0
    IL_0036: ldfld List<TaggedObject> AutoAttackWithMinRange::attackTargets  /*0x0400057D*/
    IL_003b: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0040: stloc.1
    IL_0041: br.s IL_005d
    IL_0043: ldloca.s 1
    IL_0045: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_004a: stloc.2
    IL_004b: ldloc.2
    IL_004c: ldnull
    IL_004d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0052: brtrue.s IL_005d
    IL_0054: ldarg.0
    IL_0055: ldloc.2
    IL_0056: callvirt void AutoAttack::OnAttack(TaggedObject)  /*0x06000235*/
    IL_005b: ldc.i4.1
    IL_005c: stloc.0
    IL_005d: ldloca.s 1
    IL_005f: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0064: brtrue.s IL_0043
    IL_0066: leave.s IL_0076
    IL_0068: ldloca.s 1
    IL_006a: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0070: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0075: endfinally
    IL_0076: ldloc.0
    IL_0077: brfalse.s IL_00ac
    IL_0079: ldarg.0
    IL_007a: ldarg.0
    IL_007b: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0080: ldarg.0
    IL_0081: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_0086: ldc.r4 1f
    IL_008b: ldc.r4 1f
    IL_0090: ldc.r4 2f
    IL_0095: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_009a: mul
    IL_009b: sub
    IL_009c: ldarg.0
    IL_009d: ldfld float AutoAttack::cooldownRandomization  /*0x04000300*/
    IL_00a2: mul
    IL_00a3: add
    IL_00a4: mul
    IL_00a5: add
    IL_00a6: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_00ab: ret
    IL_00ac: ldarg.0
    IL_00ad: ldarg.0
    IL_00ae: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_00b3: ldarg.0
    IL_00b4: ldfld float AutoAttack::recheckTargetInterval  /*0x04000301*/
    IL_00b9: add
    IL_00ba: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_00bf: ldarg.0
    IL_00c0: ldc.i4.0
    IL_00c1: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_00c6: ret
    .try IL_0041-IL_0068 finally handler IL_0068-IL_0076

  .method AutoAttackWithMinRange::FindAutoAttackTargets()  // token 0x06000456 rva 0x132b4 attrs Public, HideBySig
    // code size 99 (0x63), max stack 2, init locals
    .locals ([0] int, [1] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TaggedObject> AutoAttackWithMinRange::attackTargets  /*0x0400057D*/
    IL_0006: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_000b: ldc.i4.0
    IL_000c: stloc.0
    IL_000d: br.s IL_0054
    IL_000f: ldarg.0
    IL_0010: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0015: ldloc.0
    IL_0016: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_001b: ldarg.0
    IL_001c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0021: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0026: callvirt TaggedObject TargetPriority::FindFarthestTaggedObjectWithRange(UnityEngine.Vector3)  /*0x06000E70*/
    IL_002b: stloc.1
    IL_002c: ldloc.1
    IL_002d: ldnull
    IL_002e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0033: brfalse.s IL_0041
    IL_0035: ldarg.0
    IL_0036: ldfld List<TaggedObject> AutoAttackWithMinRange::attackTargets  /*0x0400057D*/
    IL_003b: ldloc.1
    IL_003c: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_0041: ldarg.0
    IL_0042: ldfld List<TaggedObject> AutoAttackWithMinRange::attackTargets  /*0x0400057D*/
    IL_0047: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_004c: ldc.i4.1
    IL_004d: bne.un.s IL_0050
    IL_004f: ret
    IL_0050: ldloc.0
    IL_0051: ldc.i4.1
    IL_0052: add
    IL_0053: stloc.0
    IL_0054: ldloc.0
    IL_0055: ldarg.0
    IL_0056: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_005b: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_0060: blt.s IL_000f
    IL_0062: ret

  .method AutoAttackWithMinRange::OnAttack(TaggedObject)  // token 0x06000457 rva 0x13324 attrs Public, Virtual, HideBySig
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

  .method AutoAttackWithMinRange::.ctor()  // token 0x06000458 rva 0x133b8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0006: stfld List<TaggedObject> AutoAttackWithMinRange::attackTargets  /*0x0400057D*/
    IL_000b: ldarg.0
    IL_000c: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0011: ret

