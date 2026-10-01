// ===== PotionVialAutoCast  (token 0x020001E9) =====
  .method PotionVialAutoCast::FindAttackTarget(bool)  // token 0x06000A14 rva 0x2fca0 attrs Public, Virtual, HideBySig
    // code size 168 (0xa8), max stack 3, init locals
    .locals ([0] int, [1] TaggedObject)
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_0045
    IL_0003: ldarg.0
    IL_0004: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_0009: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000e: brfalse.s IL_0045
    IL_0010: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0015: ldarg.0
    IL_0016: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_001b: ldarg.0
    IL_001c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0021: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0026: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_002b: ldarg.0
    IL_002c: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_0031: ldc.i4.0
    IL_0032: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0037: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_003c: bgt.un.s IL_0045
    IL_003e: ldarg.0
    IL_003f: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_0044: ret
    IL_0045: ldc.i4.0
    IL_0046: stloc.0
    IL_0047: br.s IL_0098
    IL_0049: ldloc.0
    IL_004a: brtrue.s IL_006c
    IL_004c: ldarg.0
    IL_004d: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_0052: ldloc.0
    IL_0053: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0058: ldarg.0
    IL_0059: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0063: ldc.i4.1
    IL_0064: callvirt TaggedObject TargetPriority::FindLowestHealthObjectInRange(UnityEngine.Vector3,bool)  /*0x06000E7A*/
    IL_0069: stloc.1
    IL_006a: br.s IL_0089
    IL_006c: ldarg.0
    IL_006d: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_0072: ldloc.0
    IL_0073: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0078: ldarg.0
    IL_0079: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_007e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0083: callvirt TaggedObject TargetPriority::FindClosestTaggedObject(UnityEngine.Vector3)  /*0x06000E6F*/
    IL_0088: stloc.1
    IL_0089: ldloc.1
    IL_008a: ldnull
    IL_008b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0090: brfalse.s IL_0094
    IL_0092: ldloc.1
    IL_0093: ret
    IL_0094: ldloc.0
    IL_0095: ldc.i4.1
    IL_0096: add
    IL_0097: stloc.0
    IL_0098: ldloc.0
    IL_0099: ldarg.0
    IL_009a: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_009f: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_00a4: blt.s IL_0049
    IL_00a6: ldnull
    IL_00a7: ret

  .method PotionVialAutoCast::FindAttackTargetWithInfiniteRange(bool)  // token 0x06000A15 rva 0x2fd54 attrs Public, Virtual, HideBySig
    // code size 64 (0x40), max stack 2, init locals
    .locals ([0] int, [1] TaggedObject)
    IL_0000: ldc.i4.1
    IL_0001: stloc.0
    IL_0002: br.s IL_0030
    IL_0004: ldarg.0
    IL_0005: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_000a: ldloc.0
    IL_000b: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0010: ldarg.0
    IL_0011: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0016: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_001b: callvirt TaggedObject TargetPriority::FindClosestTaggedObjectWithoutMaxDistanceCheck(UnityEngine.Vector3)  /*0x06000E71*/
    IL_0020: stloc.1
    IL_0021: ldloc.1
    IL_0022: ldnull
    IL_0023: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0028: brfalse.s IL_002c
    IL_002a: ldloc.1
    IL_002b: ret
    IL_002c: ldloc.0
    IL_002d: ldc.i4.1
    IL_002e: add
    IL_002f: stloc.0
    IL_0030: ldloc.0
    IL_0031: ldarg.0
    IL_0032: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_0037: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_003c: blt.s IL_0004
    IL_003e: ldnull
    IL_003f: ret

  .method PotionVialAutoCast::.ctor()  // token 0x06000A16 rva 0x2fda0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ManualAttack::.ctor()  /*0x06000A0A*/
    IL_0006: ret

