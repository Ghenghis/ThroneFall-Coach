// ===== AutoAttackRandom  (token 0x0200006D) =====
  .method AutoAttackRandom::FindAutoAttackTarget()  // token 0x06000241 rva 0xa294 attrs Public, Virtual, HideBySig
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
    IL_001d: callvirt TaggedObject TargetPriority::FindRandomObjectInRange(UnityEngine.Vector3)  /*0x06000E78*/
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

  .method AutoAttackRandom::.ctor()  // token 0x06000242 rva 0xa042 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0006: ret

