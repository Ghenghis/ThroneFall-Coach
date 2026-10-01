// ===== AutoAttackHealer  (token 0x020000CB) =====
  .method AutoAttackHealer::FindAutoAttackTarget()  // token 0x0600043C rva 0x127fc attrs Public, Virtual, HideBySig
    // code size 109 (0x6d), max stack 2, init locals
    .locals ([0] float, [1] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld PathfindMovementPlayerunitHealer AutoAttackHealer::pathfind  /*0x0400056C*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_006b
    IL_000e: ldarg.0
    IL_000f: ldfld PathfindMovementPlayerunitHealer AutoAttackHealer::pathfind  /*0x0400056C*/
    IL_0014: callvirt TaggedObject PathfindMovementPlayerunitHealer::get_HealingTarget()  /*0x060005AE*/
    IL_0019: ldnull
    IL_001a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001f: brfalse.s IL_006b
    IL_0021: ldarg.0
    IL_0022: ldfld float AutoAttackHealer::range  /*0x0400056B*/
    IL_0027: ldarg.0
    IL_0028: ldfld float AutoAttackHealer::range  /*0x0400056B*/
    IL_002d: mul
    IL_002e: stloc.0
    IL_002f: ldarg.0
    IL_0030: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0035: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_003a: ldarg.0
    IL_003b: ldfld PathfindMovementPlayerunitHealer AutoAttackHealer::pathfind  /*0x0400056C*/
    IL_0040: callvirt TaggedObject PathfindMovementPlayerunitHealer::get_HealingTarget()  /*0x060005AE*/
    IL_0045: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_004a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_004f: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0054: stloc.1
    IL_0055: ldloca.s 1
    IL_0057: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_005c: ldloc.0
    IL_005d: bgt.un.s IL_006b
    IL_005f: ldarg.0
    IL_0060: ldfld PathfindMovementPlayerunitHealer AutoAttackHealer::pathfind  /*0x0400056C*/
    IL_0065: callvirt TaggedObject PathfindMovementPlayerunitHealer::get_HealingTarget()  /*0x060005AE*/
    IL_006a: ret
    IL_006b: ldnull
    IL_006c: ret

  .method AutoAttackHealer::.ctor()  // token 0x0600043D rva 0x12875 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float AutoAttackHealer::range  /*0x0400056B*/
    IL_000b: ldarg.0
    IL_000c: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0011: ret

