// ===== AutoAttackTower  (token 0x0200006E) =====
  .method AutoAttackTower::Update()  // token 0x06000243 rva 0xa2e4 attrs Public, Virtual, HideBySig
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
    IL_002e: call void AutoAttackTower::FindAutoAttackTargets()  /*0x06000244*/
    IL_0033: ldc.i4.0
    IL_0034: stloc.0
    IL_0035: ldarg.0
    IL_0036: ldfld List<TaggedObject> AutoAttackTower::attackTargets  /*0x04000315*/
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

  .method AutoAttackTower::FindAutoAttackTargets()  // token 0x06000244 rva 0xa3c8 attrs Public, HideBySig
    // code size 762 (0x2fa), max stack 4, init locals
    .locals ([0] int, [1] AutoAttackTower.ETargetingMode, [2] int, [3] TaggedObject[], [4] int, [5] TaggedObject, [6] int, [7] TaggedObject, [8] int, [9] TaggedObject, [10] int, [11] TaggedObject, [12] int, [13] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TaggedObject> AutoAttackTower::attackTargets  /*0x04000315*/
    IL_0006: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_000b: ldc.i4.0
    IL_000c: stloc.0
    IL_000d: br.s IL_001c
    IL_000f: ldarg.0
    IL_0010: ldfld TaggedObject[] AutoAttackTower::tempCollectionArray  /*0x04000316*/
    IL_0015: ldloc.0
    IL_0016: ldnull
    IL_0017: stelem.ref
    IL_0018: ldloc.0
    IL_0019: ldc.i4.1
    IL_001a: add
    IL_001b: stloc.0
    IL_001c: ldloc.0
    IL_001d: ldarg.0
    IL_001e: ldfld TaggedObject[] AutoAttackTower::tempCollectionArray  /*0x04000316*/
    IL_0023: ldlen
    IL_0024: conv.i4
    IL_0025: blt.s IL_000f
    IL_0027: ldarg.0
    IL_0028: ldfld AutoAttackTower.ETargetingMode AutoAttackTower::targetingMode  /*0x04000313*/
    IL_002d: stloc.1
    IL_002e: ldloc.1
    IL_002f: switch (IL_0049, IL_00cc, IL_0157, IL_01e2, IL_026e)
    IL_0048: ret
    IL_0049: ldc.i4.0
    IL_004a: stloc.2
    IL_004b: br.s IL_00bd
    IL_004d: ldarg.0
    IL_004e: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0053: ldloc.2
    IL_0054: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0059: ldarg.0
    IL_005a: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0064: ldarg.0
    IL_0065: ldfld TaggedObject[] AutoAttackTower::tempCollectionArray  /*0x04000316*/
    IL_006a: callvirt void TargetPriority::FindClosestTaggedObjects(UnityEngine.Vector3,TaggedObject[])  /*0x06000E72*/
    IL_006f: ldarg.0
    IL_0070: ldfld TaggedObject[] AutoAttackTower::tempCollectionArray  /*0x04000316*/
    IL_0075: stloc.3
    IL_0076: ldc.i4.0
    IL_0077: stloc.s 4
    IL_0079: br.s IL_00b2
    IL_007b: ldloc.3
    IL_007c: ldloc.s 4
    IL_007e: ldelem.ref
    IL_007f: stloc.s 5
    IL_0081: ldloc.s 5
    IL_0083: ldnull
    IL_0084: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0089: brtrue.s IL_00b9
    IL_008b: ldarg.0
    IL_008c: ldfld List<TaggedObject> AutoAttackTower::attackTargets  /*0x04000315*/
    IL_0091: ldloc.s 5
    IL_0093: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_0098: ldarg.0
    IL_0099: ldfld List<TaggedObject> AutoAttackTower::attackTargets  /*0x04000315*/
    IL_009e: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_00a3: ldarg.0
    IL_00a4: ldfld int AutoAttackTower::simultaneousProjectiles  /*0x04000314*/
    IL_00a9: blt.s IL_00ac
    IL_00ab: ret
    IL_00ac: ldloc.s 4
    IL_00ae: ldc.i4.1
    IL_00af: add
    IL_00b0: stloc.s 4
    IL_00b2: ldloc.s 4
    IL_00b4: ldloc.3
    IL_00b5: ldlen
    IL_00b6: conv.i4
    IL_00b7: blt.s IL_007b
    IL_00b9: ldloc.2
    IL_00ba: ldc.i4.1
    IL_00bb: add
    IL_00bc: stloc.2
    IL_00bd: ldloc.2
    IL_00be: ldarg.0
    IL_00bf: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_00c4: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_00c9: blt.s IL_004d
    IL_00cb: ret
    IL_00cc: ldc.i4.0
    IL_00cd: stloc.s 6
    IL_00cf: br.s IL_0144
    IL_00d1: ldarg.0
    IL_00d2: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_00d7: ldloc.s 6
    IL_00d9: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_00de: ldarg.0
    IL_00df: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00e4: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00e9: ldarg.0
    IL_00ea: ldfld TaggedObject[] AutoAttackTower::tempCollectionArray  /*0x04000316*/
    IL_00ef: callvirt void TargetPriority::FindRandomObjectsInRange(UnityEngine.Vector3,TaggedObject[])  /*0x06000E79*/
    IL_00f4: ldarg.0
    IL_00f5: ldfld TaggedObject[] AutoAttackTower::tempCollectionArray  /*0x04000316*/
    IL_00fa: stloc.3
    IL_00fb: ldc.i4.0
    IL_00fc: stloc.s 4
    IL_00fe: br.s IL_0137
    IL_0100: ldloc.3
    IL_0101: ldloc.s 4
    IL_0103: ldelem.ref
    IL_0104: stloc.s 7
    IL_0106: ldloc.s 7
    IL_0108: ldnull
    IL_0109: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_010e: brtrue.s IL_013e
    IL_0110: ldarg.0
    IL_0111: ldfld List<TaggedObject> AutoAttackTower::attackTargets  /*0x04000315*/
    IL_0116: ldloc.s 7
    IL_0118: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_011d: ldarg.0
    IL_011e: ldfld List<TaggedObject> AutoAttackTower::attackTargets  /*0x04000315*/
    IL_0123: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0128: ldarg.0
    IL_0129: ldfld int AutoAttackTower::simultaneousProjectiles  /*0x04000314*/
    IL_012e: blt.s IL_0131
    IL_0130: ret
    IL_0131: ldloc.s 4
    IL_0133: ldc.i4.1
    IL_0134: add
    IL_0135: stloc.s 4
    IL_0137: ldloc.s 4
    IL_0139: ldloc.3
    IL_013a: ldlen
    IL_013b: conv.i4
    IL_013c: blt.s IL_0100
    IL_013e: ldloc.s 6
    IL_0140: ldc.i4.1
    IL_0141: add
    IL_0142: stloc.s 6
    IL_0144: ldloc.s 6
    IL_0146: ldarg.0
    IL_0147: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_014c: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_0151: blt IL_00d1
    IL_0156: ret
    IL_0157: ldc.i4.0
    IL_0158: stloc.s 8
    IL_015a: br.s IL_01cf
    IL_015c: ldarg.0
    IL_015d: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0162: ldloc.s 8
    IL_0164: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0169: ldarg.0
    IL_016a: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_016f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0174: ldarg.0
    IL_0175: ldfld TaggedObject[] AutoAttackTower::tempCollectionArray  /*0x04000316*/
    IL_017a: callvirt void TargetPriority::FindHighestMaxHealthObjectsInRange(UnityEngine.Vector3,TaggedObject[])  /*0x06000E77*/
    IL_017f: ldarg.0
    IL_0180: ldfld TaggedObject[] AutoAttackTower::tempCollectionArray  /*0x04000316*/
    IL_0185: stloc.3
    IL_0186: ldc.i4.0
    IL_0187: stloc.s 4
    IL_0189: br.s IL_01c2
    IL_018b: ldloc.3
    IL_018c: ldloc.s 4
    IL_018e: ldelem.ref
    IL_018f: stloc.s 9
    IL_0191: ldloc.s 9
    IL_0193: ldnull
    IL_0194: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0199: brtrue.s IL_01c9
    IL_019b: ldarg.0
    IL_019c: ldfld List<TaggedObject> AutoAttackTower::attackTargets  /*0x04000315*/
    IL_01a1: ldloc.s 9
    IL_01a3: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_01a8: ldarg.0
    IL_01a9: ldfld List<TaggedObject> AutoAttackTower::attackTargets  /*0x04000315*/
    IL_01ae: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_01b3: ldarg.0
    IL_01b4: ldfld int AutoAttackTower::simultaneousProjectiles  /*0x04000314*/
    IL_01b9: blt.s IL_01bc
    IL_01bb: ret
    IL_01bc: ldloc.s 4
    IL_01be: ldc.i4.1
    IL_01bf: add
    IL_01c0: stloc.s 4
    IL_01c2: ldloc.s 4
    IL_01c4: ldloc.3
    IL_01c5: ldlen
    IL_01c6: conv.i4
    IL_01c7: blt.s IL_018b
    IL_01c9: ldloc.s 8
    IL_01cb: ldc.i4.1
    IL_01cc: add
    IL_01cd: stloc.s 8
    IL_01cf: ldloc.s 8
    IL_01d1: ldarg.0
    IL_01d2: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_01d7: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_01dc: blt IL_015c
    IL_01e1: ret
    IL_01e2: ldc.i4.0
    IL_01e3: stloc.s 10
    IL_01e5: br.s IL_025b
    IL_01e7: ldarg.0
    IL_01e8: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_01ed: ldloc.s 10
    IL_01ef: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_01f4: ldarg.0
    IL_01f5: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01fa: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01ff: ldarg.0
    IL_0200: ldfld TaggedObject[] AutoAttackTower::tempCollectionArray  /*0x04000316*/
    IL_0205: ldc.i4.0
    IL_0206: callvirt void TargetPriority::FindLowestHealthObjectsInRange(UnityEngine.Vector3,TaggedObject[],bool)  /*0x06000E7B*/
    IL_020b: ldarg.0
    IL_020c: ldfld TaggedObject[] AutoAttackTower::tempCollectionArray  /*0x04000316*/
    IL_0211: stloc.3
    IL_0212: ldc.i4.0
    IL_0213: stloc.s 4
    IL_0215: br.s IL_024e
    IL_0217: ldloc.3
    IL_0218: ldloc.s 4
    IL_021a: ldelem.ref
    IL_021b: stloc.s 11
    IL_021d: ldloc.s 11
    IL_021f: ldnull
    IL_0220: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0225: brtrue.s IL_0255
    IL_0227: ldarg.0
    IL_0228: ldfld List<TaggedObject> AutoAttackTower::attackTargets  /*0x04000315*/
    IL_022d: ldloc.s 11
    IL_022f: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_0234: ldarg.0
    IL_0235: ldfld List<TaggedObject> AutoAttackTower::attackTargets  /*0x04000315*/
    IL_023a: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_023f: ldarg.0
    IL_0240: ldfld int AutoAttackTower::simultaneousProjectiles  /*0x04000314*/
    IL_0245: blt.s IL_0248
    IL_0247: ret
    IL_0248: ldloc.s 4
    IL_024a: ldc.i4.1
    IL_024b: add
    IL_024c: stloc.s 4
    IL_024e: ldloc.s 4
    IL_0250: ldloc.3
    IL_0251: ldlen
    IL_0252: conv.i4
    IL_0253: blt.s IL_0217
    IL_0255: ldloc.s 10
    IL_0257: ldc.i4.1
    IL_0258: add
    IL_0259: stloc.s 10
    IL_025b: ldloc.s 10
    IL_025d: ldarg.0
    IL_025e: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0263: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_0268: blt IL_01e7
    IL_026d: ret
    IL_026e: ldc.i4.0
    IL_026f: stloc.s 12
    IL_0271: br.s IL_02e7
    IL_0273: ldarg.0
    IL_0274: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0279: ldloc.s 12
    IL_027b: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0280: ldarg.0
    IL_0281: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0286: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_028b: ldarg.0
    IL_028c: ldfld TaggedObject[] AutoAttackTower::tempCollectionArray  /*0x04000316*/
    IL_0291: ldc.i4.1
    IL_0292: callvirt void TargetPriority::FindLowestHealthObjectsInRange(UnityEngine.Vector3,TaggedObject[],bool)  /*0x06000E7B*/
    IL_0297: ldarg.0
    IL_0298: ldfld TaggedObject[] AutoAttackTower::tempCollectionArray  /*0x04000316*/
    IL_029d: stloc.3
    IL_029e: ldc.i4.0
    IL_029f: stloc.s 4
    IL_02a1: br.s IL_02da
    IL_02a3: ldloc.3
    IL_02a4: ldloc.s 4
    IL_02a6: ldelem.ref
    IL_02a7: stloc.s 13
    IL_02a9: ldloc.s 13
    IL_02ab: ldnull
    IL_02ac: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_02b1: brtrue.s IL_02e1
    IL_02b3: ldarg.0
    IL_02b4: ldfld List<TaggedObject> AutoAttackTower::attackTargets  /*0x04000315*/
    IL_02b9: ldloc.s 13
    IL_02bb: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_02c0: ldarg.0
    IL_02c1: ldfld List<TaggedObject> AutoAttackTower::attackTargets  /*0x04000315*/
    IL_02c6: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_02cb: ldarg.0
    IL_02cc: ldfld int AutoAttackTower::simultaneousProjectiles  /*0x04000314*/
    IL_02d1: blt.s IL_02d4
    IL_02d3: ret
    IL_02d4: ldloc.s 4
    IL_02d6: ldc.i4.1
    IL_02d7: add
    IL_02d8: stloc.s 4
    IL_02da: ldloc.s 4
    IL_02dc: ldloc.3
    IL_02dd: ldlen
    IL_02de: conv.i4
    IL_02df: blt.s IL_02a3
    IL_02e1: ldloc.s 12
    IL_02e3: ldc.i4.1
    IL_02e4: add
    IL_02e5: stloc.s 12
    IL_02e7: ldloc.s 12
    IL_02e9: ldarg.0
    IL_02ea: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_02ef: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_02f4: blt IL_0273
    IL_02f9: ret

  .method AutoAttackTower::OnAttack(TaggedObject)  // token 0x06000245 rva 0xa6d0 attrs Public, Virtual, HideBySig
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

  .method AutoAttackTower::.ctor()  // token 0x06000246 rva 0xa764 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0006: stfld List<TaggedObject> AutoAttackTower::attackTargets  /*0x04000315*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.1
    IL_000d: newarr TaggedObject  /*0x02000298*/
    IL_0012: stfld TaggedObject[] AutoAttackTower::tempCollectionArray  /*0x04000316*/
    IL_0017: ldarg.0
    IL_0018: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_001d: ret

// ===== AutoAttackTower/ETargetingMode  (token 0x0200006F) =====
