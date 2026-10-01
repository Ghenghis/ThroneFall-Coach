// ===== AutoAttackPlayerUnitAdaptiveWeapons  (token 0x020000CD) =====
  .method AutoAttackPlayerUnitAdaptiveWeapons::Start()  // token 0x0600044A rva 0x12cc8 attrs Public, Virtual, HideBySig
    // code size 64 (0x40), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: call void AutoAttack::Start()  /*0x06000233*/
    IL_0006: ldarg.0
    IL_0007: ldfld PathfindMovementPlayerunit AutoAttackPlayerUnitAdaptiveWeapons::pathfindMovementUnit  /*0x04000574*/
    IL_000c: ldnull
    IL_000d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0012: brfalse.s IL_001f
    IL_0014: ldstr "Player Unit with Adaptive Weapons Auto Attack requires PathfindMovementPlayerunit to be set."
    IL_0019: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_001e: ret
    IL_001f: ldarg.0
    IL_0020: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_0025: ldnull
    IL_0026: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_002b: brfalse.s IL_0038
    IL_002d: ldstr "Player Unit with Adaptive Weapons Auto Attack requires primary weapon to be set."
    IL_0032: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0037: ret
    IL_0038: ldarg.0
    IL_0039: ldc.i4.1
    IL_003a: stfld bool AutoAttackPlayerUnitAdaptiveWeapons::inited  /*0x04000575*/
    IL_003f: ret

  .method AutoAttackPlayerUnitAdaptiveWeapons::Update()  // token 0x0600044B rva 0x12d14 attrs Public, Virtual, HideBySig
    // code size 481 (0x1e1), max stack 7, init locals
    .locals ([0] float, [1] TaggedObject, [2] int, [3] int, [4] TargetPriorityExt, [5] TaggedObject, [6] float, [7] float, [8] TargetPriorityExt, [9] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld bool AutoAttackPlayerUnitAdaptiveWeapons::inited  /*0x04000575*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0010: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0015: sub
    IL_0016: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_001b: ldarg.0
    IL_001c: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0021: ldc.r4 0f
    IL_0026: bgt.un IL_01e0
    IL_002b: ldarg.0
    IL_002c: ldc.i4.0
    IL_002d: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_0032: ldc.r4 3.4028235E+38f
    IL_0037: stloc.0
    IL_0038: ldnull
    IL_0039: stloc.1
    IL_003a: ldc.i4.m1
    IL_003b: stloc.2
    IL_003c: ldc.i4.0
    IL_003d: stloc.3
    IL_003e: br.s IL_00ac
    IL_0040: ldarg.0
    IL_0041: ldfld List<TargetPriorityExt> AutoAttackPlayerUnitAdaptiveWeapons::targetPriorityExts  /*0x04000573*/
    IL_0046: ldloc.3
    IL_0047: callvirt !0 System.Collections.Generic.List<TargetPriorityExt>::get_Item(int)  /*0x0A0001F5*/
    IL_004c: stloc.s 4
    IL_004e: ldloc.s 4
    IL_0050: brfalse.s IL_00a8
    IL_0052: ldloc.s 4
    IL_0054: ldarg.0
    IL_0055: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_005f: callvirt TaggedObject TargetPriority::FindClosestTaggedObject(UnityEngine.Vector3)  /*0x06000E6F*/
    IL_0064: stloc.s 5
    IL_0066: ldloc.s 5
    IL_0068: ldnull
    IL_0069: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_006e: brfalse.s IL_00a8
    IL_0070: ldloc.s 5
    IL_0072: ldarg.0
    IL_0073: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0078: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_007d: callvirt float TaggedObject::GetSqrDistance(UnityEngine.Vector3)  /*0x06000E50*/
    IL_0082: stloc.s 6
    IL_0084: ldloc.s 4
    IL_0086: ldfld float TargetPriorityExt::attackDistance  /*0x04000767*/
    IL_008b: ldloc.s 4
    IL_008d: ldfld float TargetPriorityExt::attackDistance  /*0x04000767*/
    IL_0092: mul
    IL_0093: stloc.s 7
    IL_0095: ldloc.s 6
    IL_0097: ldloc.0
    IL_0098: bge.un.s IL_00a8
    IL_009a: ldloc.s 7
    IL_009c: ldloc.s 6
    IL_009e: blt.un.s IL_00a8
    IL_00a0: ldloc.s 6
    IL_00a2: stloc.0
    IL_00a3: ldloc.s 5
    IL_00a5: stloc.1
    IL_00a6: ldloc.3
    IL_00a7: stloc.2
    IL_00a8: ldloc.3
    IL_00a9: ldc.i4.1
    IL_00aa: add
    IL_00ab: stloc.3
    IL_00ac: ldloc.3
    IL_00ad: ldarg.0
    IL_00ae: ldfld List<TargetPriorityExt> AutoAttackPlayerUnitAdaptiveWeapons::targetPriorityExts  /*0x04000573*/
    IL_00b3: callvirt int System.Collections.Generic.List<TargetPriorityExt>::get_Count()  /*0x0A0001F6*/
    IL_00b8: blt.s IL_0040
    IL_00ba: ldloc.2
    IL_00bb: ldc.i4.m1
    IL_00bc: ble IL_01c5
    IL_00c1: ldarg.0
    IL_00c2: ldfld List<TargetPriorityExt> AutoAttackPlayerUnitAdaptiveWeapons::targetPriorityExts  /*0x04000573*/
    IL_00c7: ldloc.2
    IL_00c8: callvirt !0 System.Collections.Generic.List<TargetPriorityExt>::get_Item(int)  /*0x0A0001F5*/
    IL_00cd: stloc.s 8
    IL_00cf: ldarg.0
    IL_00d0: ldfld PathfindMovementPlayerunit AutoAttackPlayerUnitAdaptiveWeapons::pathfindMovementUnit  /*0x04000574*/
    IL_00d5: ldloc.s 8
    IL_00d7: ldfld float TargetPriorityExt::attackDistance  /*0x04000767*/
    IL_00dc: ldc.r4 0.05f
    IL_00e1: sub
    IL_00e2: stfld float PathfindMovementPlayerunit::keepDistanceOf  /*0x04000DFF*/
    IL_00e7: ldarg.0
    IL_00e8: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00ed: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00f2: ldarg.0
    IL_00f3: ldfld float AutoAttack::spawnAttackHeight  /*0x04000304*/
    IL_00f8: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_00fd: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_0102: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0107: stloc.s 9
    IL_0109: ldloc.s 8
    IL_010b: ldfld Weapon TargetPriorityExt::secondaryWeapon  /*0x04000768*/
    IL_0110: ldnull
    IL_0111: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0116: brfalse.s IL_0165
    IL_0118: ldloc.s 8
    IL_011a: ldfld Weapon TargetPriorityExt::secondaryWeapon  /*0x04000768*/
    IL_011f: ldloc.s 9
    IL_0121: ldloc.1
    IL_0122: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0127: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_012c: ldarg.0
    IL_012d: ldfld TaggedObject AutoAttack::taggedObject  /*0x04000305*/
    IL_0132: ldarg.0
    IL_0133: ldfld float AutoAttack::damageMultiplyer  /*0x04000309*/
    IL_0138: ldarg.0
    IL_0139: ldfld float AutoAttack::projectileSpeedMultiplyer  /*0x0400030A*/
    IL_013e: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_0143: ldloc.s 8
    IL_0145: ldfld UnityEvent TargetPriorityExt::secondaryWeaponOnAttack  /*0x0400076A*/
    IL_014a: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_014f: ldarg.0
    IL_0150: ldarg.0
    IL_0151: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0156: ldloc.s 8
    IL_0158: ldfld float TargetPriorityExt::secondaryWeaponCooldownDuration  /*0x04000769*/
    IL_015d: add
    IL_015e: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0163: br.s IL_01ad
    IL_0165: ldarg.0
    IL_0166: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_016b: ldloc.s 9
    IL_016d: ldloc.1
    IL_016e: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0173: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0178: ldarg.0
    IL_0179: ldfld TaggedObject AutoAttack::taggedObject  /*0x04000305*/
    IL_017e: ldarg.0
    IL_017f: ldfld float AutoAttack::damageMultiplyer  /*0x04000309*/
    IL_0184: ldarg.0
    IL_0185: ldfld float AutoAttack::projectileSpeedMultiplyer  /*0x0400030A*/
    IL_018a: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_018f: ldarg.0
    IL_0190: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0195: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_019a: ldarg.0
    IL_019b: ldarg.0
    IL_019c: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_01a1: ldarg.0
    IL_01a2: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_01a7: add
    IL_01a8: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_01ad: ldarg.0
    IL_01ae: ldloc.1
    IL_01af: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01b4: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01b9: stfld Vector3 AutoAttack::lastTargetPosition  /*0x0400030C*/
    IL_01be: ldarg.0
    IL_01bf: ldc.i4.1
    IL_01c0: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_01c5: ldarg.0
    IL_01c6: ldfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_01cb: brtrue.s IL_01e0
    IL_01cd: ldarg.0
    IL_01ce: ldarg.0
    IL_01cf: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_01d4: ldarg.0
    IL_01d5: ldfld float AutoAttack::recheckTargetInterval  /*0x04000301*/
    IL_01da: add
    IL_01db: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_01e0: ret

  .method AutoAttackPlayerUnitAdaptiveWeapons::.ctor()  // token 0x0600044C rva 0xa042 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0006: ret

