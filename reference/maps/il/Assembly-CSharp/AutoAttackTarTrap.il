// ===== AutoAttackTarTrap  (token 0x020000CF) =====
  .method AutoAttackTarTrap::Start()  // token 0x06000450 rva 0x9da3 attrs Public, Virtual, HideBySig
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

  .method AutoAttackTarTrap::Update()  // token 0x06000451 rva 0x13008 attrs Public, Virtual, HideBySig
    // code size 163 (0xa3), max stack 3, init locals
    .locals ([0] int, [1] TaggedObject[], [2] int, [3] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0012: ldarg.0
    IL_0013: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0018: ldc.r4 0f
    IL_001d: ble.un.s IL_0020
    IL_001f: ret
    IL_0020: ldarg.0
    IL_0021: ldfld TaggedObject[] AutoAttackTarTrap::_targets  /*0x04000579*/
    IL_0026: ldnull
    IL_0027: call void System.Array::Fill(!!0[],!!0)<TaggedObject>  /*0x2B000037*/
    IL_002c: ldc.i4.0
    IL_002d: stloc.0
    IL_002e: br.s IL_0088
    IL_0030: ldarg.0
    IL_0031: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0036: ldloc.0
    IL_0037: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_003c: ldarg.0
    IL_003d: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0042: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0047: ldarg.0
    IL_0048: ldfld TaggedObject[] AutoAttackTarTrap::_targets  /*0x04000579*/
    IL_004d: callvirt void TargetPriority::FindRandomObjectsInRange(UnityEngine.Vector3,TaggedObject[])  /*0x06000E79*/
    IL_0052: ldarg.0
    IL_0053: ldfld TaggedObject[] AutoAttackTarTrap::_targets  /*0x04000579*/
    IL_0058: stloc.1
    IL_0059: ldc.i4.0
    IL_005a: stloc.2
    IL_005b: br.s IL_007e
    IL_005d: ldloc.1
    IL_005e: ldloc.2
    IL_005f: ldelem.ref
    IL_0060: stloc.3
    IL_0061: ldloc.3
    IL_0062: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0067: brfalse.s IL_007a
    IL_0069: ldloc.3
    IL_006a: callvirt !!0 UnityEngine.Component::GetComponent()<PathfindMovementEnemy>  /*0x2B00000E*/
    IL_006f: ldarg.0
    IL_0070: ldfld float AutoAttack::recheckTargetInterval  /*0x04000301*/
    IL_0075: callvirt void PathfindMovement::Slow(float)  /*0x06000B07*/
    IL_007a: ldloc.2
    IL_007b: ldc.i4.1
    IL_007c: add
    IL_007d: stloc.2
    IL_007e: ldloc.2
    IL_007f: ldloc.1
    IL_0080: ldlen
    IL_0081: conv.i4
    IL_0082: blt.s IL_005d
    IL_0084: ldloc.0
    IL_0085: ldc.i4.1
    IL_0086: add
    IL_0087: stloc.0
    IL_0088: ldloc.0
    IL_0089: ldarg.0
    IL_008a: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_008f: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_0094: blt.s IL_0030
    IL_0096: ldarg.0
    IL_0097: ldarg.0
    IL_0098: ldfld float AutoAttack::recheckTargetInterval  /*0x04000301*/
    IL_009d: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_00a2: ret

  .method AutoAttackTarTrap::.ctor()  // token 0x06000452 rva 0x130b7 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.s 64
    IL_0003: newarr TaggedObject  /*0x02000298*/
    IL_0008: stfld TaggedObject[] AutoAttackTarTrap::_targets  /*0x04000579*/
    IL_000d: ldarg.0
    IL_000e: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0013: ret

