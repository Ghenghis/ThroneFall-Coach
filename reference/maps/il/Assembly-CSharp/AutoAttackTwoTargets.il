// ===== AutoAttackTwoTargets  (token 0x02000070) =====
  .method AutoAttackTwoTargets::Update()  // token 0x06000247 rva 0xa784 attrs Public, Virtual, HideBySig
    // code size 240 (0xf0), max stack 7, init locals
    .locals ([0] TaggedObject[], [1] int, [2] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0012: ldarg.0
    IL_0013: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0018: ldc.r4 0f
    IL_001d: bgt.un IL_00ef
    IL_0022: ldarg.0
    IL_0023: ldarg.0
    IL_0024: ldfld TaggedObject[] AutoAttackTwoTargets::targets  /*0x0400031D*/
    IL_0029: call void AutoAttackTwoTargets::FindAutoAttackTargets(TaggedObject[])  /*0x06000248*/
    IL_002e: ldarg.0
    IL_002f: ldarg.0
    IL_0030: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0035: ldarg.0
    IL_0036: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_003b: ldc.r4 1f
    IL_0040: ldc.r4 1f
    IL_0045: ldc.r4 2f
    IL_004a: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_004f: mul
    IL_0050: sub
    IL_0051: ldarg.0
    IL_0052: ldfld float AutoAttack::cooldownRandomization  /*0x04000300*/
    IL_0057: mul
    IL_0058: add
    IL_0059: mul
    IL_005a: add
    IL_005b: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0060: ldarg.0
    IL_0061: ldfld TaggedObject[] AutoAttackTwoTargets::targets  /*0x0400031D*/
    IL_0066: stloc.0
    IL_0067: ldc.i4.0
    IL_0068: stloc.1
    IL_0069: br.s IL_00e6
    IL_006b: ldloc.0
    IL_006c: ldloc.1
    IL_006d: ldelem.ref
    IL_006e: stloc.2
    IL_006f: ldloc.2
    IL_0070: ldnull
    IL_0071: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0076: brtrue.s IL_00e2
    IL_0078: ldarg.0
    IL_0079: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_007e: ldarg.0
    IL_007f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0084: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0089: ldarg.0
    IL_008a: ldfld float AutoAttack::spawnAttackHeight  /*0x04000304*/
    IL_008f: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0094: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_0099: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_009e: ldloc.2
    IL_009f: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_00a4: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_00a9: ldarg.0
    IL_00aa: ldfld TaggedObject AutoAttack::taggedObject  /*0x04000305*/
    IL_00af: ldarg.0
    IL_00b0: ldfld float AutoAttack::damageMultiplyer  /*0x04000309*/
    IL_00b5: ldc.r4 1f
    IL_00ba: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_00bf: ldarg.0
    IL_00c0: ldloc.2
    IL_00c1: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00c6: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00cb: stfld Vector3 AutoAttack::lastTargetPosition  /*0x0400030C*/
    IL_00d0: ldarg.0
    IL_00d1: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_00d6: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_00db: ldarg.0
    IL_00dc: ldc.i4.1
    IL_00dd: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_00e2: ldloc.1
    IL_00e3: ldc.i4.1
    IL_00e4: add
    IL_00e5: stloc.1
    IL_00e6: ldloc.1
    IL_00e7: ldloc.0
    IL_00e8: ldlen
    IL_00e9: conv.i4
    IL_00ea: blt IL_006b
    IL_00ef: ret

  .method AutoAttackTwoTargets::FindAutoAttackTargets(TaggedObject[])  // token 0x06000248 rva 0xa880 attrs Private, HideBySig
    // code size 66 (0x42), max stack 3, init locals
    .locals ([0] Vector3, [1] int)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: stloc.0
    IL_000c: ldc.i4.0
    IL_000d: stloc.1
    IL_000e: br.s IL_0033
    IL_0010: ldarg.0
    IL_0011: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0016: ldloc.1
    IL_0017: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_001c: ldloc.0
    IL_001d: ldarg.1
    IL_001e: callvirt void TargetPriority::FindClosestTaggedObjects(UnityEngine.Vector3,TaggedObject[])  /*0x06000E72*/
    IL_0023: ldarg.1
    IL_0024: ldloc.1
    IL_0025: ldelem.ref
    IL_0026: ldnull
    IL_0027: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002c: brfalse.s IL_002f
    IL_002e: ret
    IL_002f: ldloc.1
    IL_0030: ldc.i4.1
    IL_0031: add
    IL_0032: stloc.1
    IL_0033: ldloc.1
    IL_0034: ldarg.0
    IL_0035: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_003a: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_003f: blt.s IL_0010
    IL_0041: ret

  .method AutoAttackTwoTargets::.ctor()  // token 0x06000249 rva 0xa8ce attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.2
    IL_0002: newarr TaggedObject  /*0x02000298*/
    IL_0007: stfld TaggedObject[] AutoAttackTwoTargets::targets  /*0x0400031D*/
    IL_000c: ldarg.0
    IL_000d: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0012: ret

