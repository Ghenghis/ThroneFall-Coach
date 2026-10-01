// ===== AutoAttackLowestHealth  (token 0x0200006B) =====
  .method AutoAttackLowestHealth::FindAutoAttackTarget()  // token 0x0600023B rva 0xa04c attrs Public, Virtual, HideBySig
    // code size 72 (0x48), max stack 3, init locals
    .locals ([0] Vector3, [1] int, [2] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: stloc.0
    IL_000c: ldc.i4.0
    IL_000d: stloc.1
    IL_000e: br.s IL_0038
    IL_0010: ldarg.0
    IL_0011: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0016: ldloc.1
    IL_0017: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_001c: ldloc.0
    IL_001d: ldarg.0
    IL_001e: ldfld bool AutoAttackLowestHealth::excludeFullHealthTargets  /*0x0400030D*/
    IL_0023: callvirt TaggedObject TargetPriority::FindLowestHealthObjectInRange(UnityEngine.Vector3,bool)  /*0x06000E7A*/
    IL_0028: stloc.2
    IL_0029: ldloc.2
    IL_002a: ldnull
    IL_002b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0030: brfalse.s IL_0034
    IL_0032: ldloc.2
    IL_0033: ret
    IL_0034: ldloc.1
    IL_0035: ldc.i4.1
    IL_0036: add
    IL_0037: stloc.1
    IL_0038: ldloc.1
    IL_0039: ldarg.0
    IL_003a: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_003f: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_0044: blt.s IL_0010
    IL_0046: ldnull
    IL_0047: ret

  .method AutoAttackLowestHealth::.ctor()  // token 0x0600023C rva 0xa0a0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool AutoAttackLowestHealth::excludeFullHealthTargets  /*0x0400030D*/
    IL_0007: ldarg.0
    IL_0008: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_000d: ret

