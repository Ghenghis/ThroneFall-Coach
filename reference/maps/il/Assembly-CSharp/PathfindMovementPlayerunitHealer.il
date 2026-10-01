// ===== PathfindMovementPlayerunitHealer  (token 0x02000112) =====
  .method PathfindMovementPlayerunitHealer::get_HealingTarget()  // token 0x060005AE rva 0x18229 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TaggedObject PathfindMovementPlayerunitHealer::healingTarget  /*0x0400071D*/
    IL_0006: ret

  .method PathfindMovementPlayerunitHealer::Start()  // token 0x060005AF rva 0x18234 attrs Family, Virtual, HideBySig
    // code size 65 (0x41), max stack 3, init locals
    .locals ([0] int, [1] TargetPriority)
    IL_0000: ldarg.0
    IL_0001: call void PathfindMovementPlayerunit::Start()  /*0x06000B3C*/
    IL_0006: ldc.i4.0
    IL_0007: stloc.0
    IL_0008: br.s IL_0032
    IL_000a: ldarg.0
    IL_000b: ldfld List<TargetPriority> PathfindMovementPlayerunit::targetPriorities  /*0x04000DFE*/
    IL_0010: ldloc.0
    IL_0011: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0016: stloc.1
    IL_0017: ldarg.0
    IL_0018: ldfld List<bool> PathfindMovementPlayerunitHealer::targetIsEnemy  /*0x0400071E*/
    IL_001d: ldloc.1
    IL_001e: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_0023: ldc.i4.1
    IL_0024: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0029: callvirt void System.Collections.Generic.List<bool>::Add(!0)  /*0x0A00025B*/
    IL_002e: ldloc.0
    IL_002f: ldc.i4.1
    IL_0030: add
    IL_0031: stloc.0
    IL_0032: ldloc.0
    IL_0033: ldarg.0
    IL_0034: ldfld List<TargetPriority> PathfindMovementPlayerunit::targetPriorities  /*0x04000DFE*/
    IL_0039: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_003e: blt.s IL_000a
    IL_0040: ret

  .method PathfindMovementPlayerunitHealer::FindTargetPosition()  // token 0x060005B0 rva 0x18284 attrs Public, Virtual, HideBySig
    // code size 363 (0x16b), max stack 5, init locals
    .locals ([0] int, [1] float, [2] TaggedObject, [3] int, [4] TaggedObject, [5] Hp, [6] float, [7] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldnull
    IL_0002: stfld TaggedObject PathfindMovementPlayerunitHealer::healingTarget  /*0x0400071D*/
    IL_0007: ldc.i4.0
    IL_0008: stloc.0
    IL_0009: br IL_014e
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: ldfld List<TargetPriority> PathfindMovementPlayerunit::targetPriorities  /*0x04000DFE*/
    IL_0015: ldloc.0
    IL_0016: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_001b: stfld TargetPriority PathfindMovementPlayerunit::targetPrio  /*0x04000E12*/
    IL_0020: ldarg.0
    IL_0021: ldfld bool PathfindMovementPlayerunit::holdPosition  /*0x04000E1C*/
    IL_0026: brfalse.s IL_0051
    IL_0028: ldarg.0
    IL_0029: ldfld TargetPriority PathfindMovementPlayerunit::targetPrio  /*0x04000E12*/
    IL_002e: ldarg.0
    IL_002f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0034: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0039: ldarg.0
    IL_003a: ldfld Vector3 PathfindMovementPlayerunit::homePosition  /*0x04000E0F*/
    IL_003f: ldc.r4 7f
    IL_0044: ldarg.0
    IL_0045: ldflda List<TaggedObject> PathfindMovementPlayerunitHealer::targets  /*0x0400071C*/
    IL_004a: callvirt void TargetPriority::FindTaggedObjectsCloseToHomeInRange(UnityEngine.Vector3,UnityEngine.Vector3,float,ref System.Collections.Generic.List<TaggedObject>)  /*0x06000E7F*/
    IL_004f: br.s IL_0079
    IL_0051: ldarg.0
    IL_0052: ldfld TargetPriority PathfindMovementPlayerunit::targetPrio  /*0x04000E12*/
    IL_0057: ldarg.0
    IL_0058: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0062: ldarg.0
    IL_0063: ldfld Vector3 PathfindMovementPlayerunit::homePosition  /*0x04000E0F*/
    IL_0068: ldarg.0
    IL_0069: ldfld float PathfindMovementPlayerunit::maximumDistanceFromHome  /*0x04000E00*/
    IL_006e: ldarg.0
    IL_006f: ldflda List<TaggedObject> PathfindMovementPlayerunitHealer::targets  /*0x0400071C*/
    IL_0074: callvirt void TargetPriority::FindTaggedObjectsCloseToHomeInRange(UnityEngine.Vector3,UnityEngine.Vector3,float,ref System.Collections.Generic.List<TaggedObject>)  /*0x06000E7F*/
    IL_0079: ldc.r4 3.4028235E+38f
    IL_007e: stloc.1
    IL_007f: ldnull
    IL_0080: stloc.2
    IL_0081: ldc.i4.0
    IL_0082: stloc.3
    IL_0083: br.s IL_0102
    IL_0085: ldarg.0
    IL_0086: ldfld List<TaggedObject> PathfindMovementPlayerunitHealer::targets  /*0x0400071C*/
    IL_008b: ldloc.3
    IL_008c: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0091: stloc.s 4
    IL_0093: ldloc.s 4
    IL_0095: ldnull
    IL_0096: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_009b: brtrue.s IL_00fe
    IL_009d: ldloc.s 4
    IL_009f: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_00a4: stloc.s 5
    IL_00a6: ldloc.s 5
    IL_00a8: ldnull
    IL_00a9: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00ae: brtrue.s IL_00fe
    IL_00b0: ldloc.s 5
    IL_00b2: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_00b7: ldc.r4 1f
    IL_00bc: blt.un.s IL_00cc
    IL_00be: ldarg.0
    IL_00bf: ldfld List<bool> PathfindMovementPlayerunitHealer::targetIsEnemy  /*0x0400071E*/
    IL_00c4: ldloc.0
    IL_00c5: callvirt !0 System.Collections.Generic.List<bool>::get_Item(int)  /*0x0A00025C*/
    IL_00ca: brfalse.s IL_00fe
    IL_00cc: ldloc.s 4
    IL_00ce: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00d3: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00d8: ldarg.0
    IL_00d9: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00de: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00e3: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_00e8: stloc.s 7
    IL_00ea: ldloca.s 7
    IL_00ec: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_00f1: stloc.s 6
    IL_00f3: ldloc.s 6
    IL_00f5: ldloc.1
    IL_00f6: bge.un.s IL_00fe
    IL_00f8: ldloc.s 6
    IL_00fa: stloc.1
    IL_00fb: ldloc.s 4
    IL_00fd: stloc.2
    IL_00fe: ldloc.3
    IL_00ff: ldc.i4.1
    IL_0100: add
    IL_0101: stloc.3
    IL_0102: ldloc.3
    IL_0103: ldarg.0
    IL_0104: ldfld List<TaggedObject> PathfindMovementPlayerunitHealer::targets  /*0x0400071C*/
    IL_0109: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_010e: blt IL_0085
    IL_0113: ldloc.2
    IL_0114: ldnull
    IL_0115: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_011a: brtrue.s IL_014a
    IL_011c: ldarg.0
    IL_011d: ldloc.2
    IL_011e: stfld TaggedObject PathfindMovementPlayerunit::seekToTaggedObj  /*0x04000E0B*/
    IL_0123: ldarg.0
    IL_0124: ldfld List<bool> PathfindMovementPlayerunitHealer::targetIsEnemy  /*0x0400071E*/
    IL_0129: ldloc.0
    IL_012a: callvirt !0 System.Collections.Generic.List<bool>::get_Item(int)  /*0x0A00025C*/
    IL_012f: brtrue.s IL_0138
    IL_0131: ldarg.0
    IL_0132: ldloc.2
    IL_0133: stfld TaggedObject PathfindMovementPlayerunitHealer::healingTarget  /*0x0400071D*/
    IL_0138: ldloc.2
    IL_0139: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_013e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0143: ldc.i4.1
    IL_0144: newobj void System.ValueTuple<UnityEngine.Vector3, bool>::.ctor(!0,!1)  /*0x0A00025D*/
    IL_0149: ret
    IL_014a: ldloc.0
    IL_014b: ldc.i4.1
    IL_014c: add
    IL_014d: stloc.0
    IL_014e: ldloc.0
    IL_014f: ldarg.0
    IL_0150: ldfld List<TargetPriority> PathfindMovementPlayerunit::targetPriorities  /*0x04000DFE*/
    IL_0155: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_015a: blt IL_000e
    IL_015f: call Vector3 UnityEngine.Vector3::get_negativeInfinity()  /*0x0A00025E*/
    IL_0164: ldc.i4.0
    IL_0165: newobj void System.ValueTuple<UnityEngine.Vector3, bool>::.ctor(!0,!1)  /*0x0A00025D*/
    IL_016a: ret

  .method PathfindMovementPlayerunitHealer::.ctor()  // token 0x060005B1 rva 0x183fb attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0006: stfld List<TaggedObject> PathfindMovementPlayerunitHealer::targets  /*0x0400071C*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<bool>::.ctor()  /*0x0A00025F*/
    IL_0011: stfld List<bool> PathfindMovementPlayerunitHealer::targetIsEnemy  /*0x0400071E*/
    IL_0016: ldarg.0
    IL_0017: call void PathfindMovementPlayerunit::.ctor()  /*0x06000B49*/
    IL_001c: ret

