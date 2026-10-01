// ===== RailgunBeam  (token 0x0200011A) =====
  .method RailgunBeam::.ctor(RailgunBeam.Config)  // token 0x060005D1 rva 0x18b28 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 56 (0x38), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.s 32
    IL_0003: newarr UnityEngine.RaycastHit  /*0x0100006D*/
    IL_0008: stfld RaycastHit[] RailgunBeam::_raycastHits  /*0x0400073B*/
    IL_000d: ldarg.0
    IL_000e: ldsfld Vector3 RailgunBeam::_invalidVec3  /*0x0400073C*/
    IL_0013: stfld Vector3 RailgunBeam::_end  /*0x0400073D*/
    IL_0018: ldarg.0
    IL_0019: call void System.Object::.ctor()  /*0x0A000038*/
    IL_001e: ldarg.1
    IL_001f: callvirt bool RailgunBeam.Config::Validate()  /*0x060005D7*/
    IL_0024: brtrue.s IL_0030
    IL_0026: ldstr "RailgunBeam (RailgunBeam.cs) config is not valid."
    IL_002b: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0030: ldarg.0
    IL_0031: ldarg.1
    IL_0032: stfld RailgunBeam.Config RailgunBeam::_config  /*0x04000738*/
    IL_0037: ret

  .method RailgunBeam::GetRoot(UnityEngine.Transform)  // token 0x060005D2 rva 0x18b64 attrs Private, HideBySig
    // code size 54 (0x36), max stack 2, init locals
    .locals ([0] Component)
    IL_0000: ldarg.1
    IL_0001: callvirt !!0 UnityEngine.Component::GetComponentInParent()<BuildSlot>  /*0x2B000004*/
    IL_0006: dup
    IL_0007: brtrue.s IL_0024
    IL_0009: pop
    IL_000a: ldarg.1
    IL_000b: callvirt !!0 UnityEngine.Component::GetComponentInParent()<Pathfinding.RVO.RVOController>  /*0x2B000041*/
    IL_0010: dup
    IL_0011: brtrue.s IL_0024
    IL_0013: pop
    IL_0014: ldarg.1
    IL_0015: callvirt !!0 UnityEngine.Component::GetComponentInParent()<UnityEngine.MeshCollider>  /*0x2B000042*/
    IL_001a: dup
    IL_001b: brtrue.s IL_0024
    IL_001d: pop
    IL_001e: ldarg.1
    IL_001f: callvirt !!0 UnityEngine.Component::GetComponentInParent()<UnityEngine.Collider>  /*0x2B000043*/
    IL_0024: stloc.0
    IL_0025: ldloc.0
    IL_0026: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002b: brtrue.s IL_002f
    IL_002d: ldnull
    IL_002e: ret
    IL_002f: ldloc.0
    IL_0030: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0035: ret

  .method RailgunBeam::Fire(UnityEngine.Vector3)  // token 0x060005D3 rva 0x18ba8 attrs Public, HideBySig
    // code size 273 (0x111), max stack 5, init locals
    .locals ([0] Vector3, [1] RailgunBeam.BeamState, [2] float, [3] float, [4] Vector3)
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld RailgunBeam.Config RailgunBeam::_config  /*0x04000738*/
    IL_0007: ldfld Vector3 RailgunBeam.Config::origin  /*0x0400073F*/
    IL_000c: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0011: stloc.s 4
    IL_0013: ldloca.s 4
    IL_0015: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_001a: stloc.0
    IL_001b: ldarg.0
    IL_001c: ldarg.0
    IL_001d: ldfld RailgunBeam.Config RailgunBeam::_config  /*0x04000738*/
    IL_0022: ldfld Vector3 RailgunBeam.Config::origin  /*0x0400073F*/
    IL_0027: ldloc.0
    IL_0028: ldarg.0
    IL_0029: ldfld RailgunBeam.Config RailgunBeam::_config  /*0x04000738*/
    IL_002e: ldfld float RailgunBeam.Config::range  /*0x04000741*/
    IL_0033: ldc.i4.1
    IL_0034: call RailgunBeam.BeamState RailgunBeam::FireBeam(UnityEngine.Vector3,UnityEngine.Vector3,float,bool)  /*0x060005D4*/
    IL_0039: stloc.1
    IL_003a: ldloc.1
    IL_003b: ldc.i4.2
    IL_003c: bne.un.s IL_003f
    IL_003e: ret
    IL_003f: ldarg.0
    IL_0040: ldfld RailgunBeam.Config RailgunBeam::_config  /*0x04000738*/
    IL_0045: ldfld LaserBeam RailgunBeam.Config::laserBeam  /*0x04000745*/
    IL_004a: ldarg.0
    IL_004b: ldfld RailgunBeam.Config RailgunBeam::_config  /*0x04000738*/
    IL_0050: ldfld Vector3 RailgunBeam.Config::origin  /*0x0400073F*/
    IL_0055: ldarg.0
    IL_0056: ldfld Vector3 RailgunBeam::_end  /*0x0400073D*/
    IL_005b: callvirt void LaserBeam::DrawFirstPart(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0600054E*/
    IL_0060: ldloc.1
    IL_0061: ldc.i4.1
    IL_0062: bne.un.s IL_0065
    IL_0064: ret
    IL_0065: ldloc.0
    IL_0066: ldloc.0
    IL_0067: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_006c: call float UnityEngine.Vector3::Dot(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0001A1*/
    IL_0071: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0076: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_007b: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0080: stloc.0
    IL_0081: ldarg.1
    IL_0082: ldarg.0
    IL_0083: ldfld RailgunBeam.Config RailgunBeam::_config  /*0x04000738*/
    IL_0088: ldfld Vector3 RailgunBeam.Config::origin  /*0x0400073F*/
    IL_008d: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0092: dup
    IL_0093: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0098: call float UnityEngine.Vector3::Dot(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0001A1*/
    IL_009d: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_00a2: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_00a7: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_00ac: stloc.s 4
    IL_00ae: ldloca.s 4
    IL_00b0: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_00b5: stloc.2
    IL_00b6: ldarg.0
    IL_00b7: ldfld RailgunBeam.Config RailgunBeam::_config  /*0x04000738*/
    IL_00bc: ldfld float RailgunBeam.Config::range  /*0x04000741*/
    IL_00c1: ldloc.2
    IL_00c2: sub
    IL_00c3: stloc.3
    IL_00c4: ldarg.0
    IL_00c5: ldarg.1
    IL_00c6: ldloc.0
    IL_00c7: ldloc.3
    IL_00c8: ldc.i4.0
    IL_00c9: call RailgunBeam.BeamState RailgunBeam::FireBeam(UnityEngine.Vector3,UnityEngine.Vector3,float,bool)  /*0x060005D4*/
    IL_00ce: stloc.1
    IL_00cf: ldloc.1
    IL_00d0: ldc.i4.1
    IL_00d1: beq.s IL_00e6
    IL_00d3: ldarg.0
    IL_00d4: ldarg.1
    IL_00d5: ldloc.0
    IL_00d6: ldloc.3
    IL_00d7: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00dc: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00e1: stfld Vector3 RailgunBeam::_end  /*0x0400073D*/
    IL_00e6: ldarg.0
    IL_00e7: ldfld RailgunBeam.Config RailgunBeam::_config  /*0x04000738*/
    IL_00ec: ldfld LaserBeam RailgunBeam.Config::laserBeam  /*0x04000745*/
    IL_00f1: ldarg.0
    IL_00f2: ldfld Vector3 RailgunBeam::_end  /*0x0400073D*/
    IL_00f7: ldc.r4 0.5f
    IL_00fc: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0101: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_0106: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_010b: callvirt void LaserBeam::DrawSecondPart(UnityEngine.Vector3)  /*0x0600054F*/
    IL_0110: ret

  .method RailgunBeam::FireBeam(UnityEngine.Vector3,UnityEngine.Vector3,float,bool)  // token 0x060005D4 rva 0x18cc8 attrs Private, HideBySig
    // code size 354 (0x162), max stack 7, init locals
    .locals ([0] RailgunBeam.BeamState, [1] int, [2] int, [3] int, [4] RaycastHit, [5] Transform, [6] TaggedObject, [7] float)
    IL_0000: ldc.i4.1
    IL_0001: stloc.0
    IL_0002: ldarg.s 4
    IL_0004: brtrue.s IL_0009
    IL_0006: ldc.i4.1
    IL_0007: br.s IL_000a
    IL_0009: ldc.i4.0
    IL_000a: stloc.1
    IL_000b: ldarg.1
    IL_000c: ldarg.2
    IL_000d: newobj void UnityEngine.Ray::.ctor(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A00016F*/
    IL_0012: ldarg.0
    IL_0013: ldfld RaycastHit[] RailgunBeam::_raycastHits  /*0x0400073B*/
    IL_0018: ldarg.3
    IL_0019: call int UnityEngine.Physics::RaycastNonAlloc(UnityEngine.Ray,UnityEngine.RaycastHit[],float)  /*0x0A000271*/
    IL_001e: stloc.2
    IL_001f: ldloc.2
    IL_0020: ldc.i4.0
    IL_0021: bgt.s IL_0025
    IL_0023: ldc.i4.2
    IL_0024: ret
    IL_0025: ldarg.0
    IL_0026: ldfld RaycastHit[] RailgunBeam::_raycastHits  /*0x0400073B*/
    IL_002b: ldc.i4.0
    IL_002c: ldloc.2
    IL_002d: ldsfld RailgunBeam.RaycastHitComparer RailgunBeam::_hitComparer  /*0x04000739*/
    IL_0032: call void System.Array::Sort(!!0[],int,int,System.Collections.Generic.IComparer<!!0>)<UnityEngine.RaycastHit>  /*0x2B000044*/
    IL_0037: ldc.i4.0
    IL_0038: stloc.3
    IL_0039: br IL_0159
    IL_003e: ldc.i4.1
    IL_003f: stloc.0
    IL_0040: ldarg.0
    IL_0041: ldfld RaycastHit[] RailgunBeam::_raycastHits  /*0x0400073B*/
    IL_0046: ldloc.3
    IL_0047: ldelem UnityEngine.RaycastHit  /*0x0100006D*/
    IL_004c: stloc.s 4
    IL_004e: ldarg.0
    IL_004f: ldloc.s 4
    IL_0051: call bool RailgunBeam::FilterHit(UnityEngine.RaycastHit)  /*0x060005D5*/
    IL_0056: brfalse IL_0155
    IL_005b: ldarg.0
    IL_005c: ldloca.s 4
    IL_005e: call Vector3 UnityEngine.RaycastHit::get_point()  /*0x0A000171*/
    IL_0063: stfld Vector3 RailgunBeam::_end  /*0x0400073D*/
    IL_0068: ldarg.0
    IL_0069: ldloca.s 4
    IL_006b: call Transform UnityEngine.RaycastHit::get_transform()  /*0x0A000273*/
    IL_0070: call Transform RailgunBeam::GetRoot(UnityEngine.Transform)  /*0x060005D2*/
    IL_0075: stloc.s 5
    IL_0077: ldloc.s 5
    IL_0079: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_007e: brfalse IL_0160
    IL_0083: ldloc.s 5
    IL_0085: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_008a: callvirt int UnityEngine.GameObject::get_layer()  /*0x0A00022A*/
    IL_008f: ldc.i4.s 13
    IL_0091: beq IL_0155
    IL_0096: ldloc.s 5
    IL_0098: callvirt !!0 UnityEngine.Component::GetComponentInChildren()<TaggedObject>  /*0x2B000045*/
    IL_009d: stloc.s 6
    IL_009f: ldloc.s 6
    IL_00a1: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00a6: brtrue.s IL_00b1
    IL_00a8: ldloc.s 5
    IL_00aa: callvirt !!0 UnityEngine.Component::GetComponent()<TaggedObject>  /*0x2B000005*/
    IL_00af: stloc.s 6
    IL_00b1: ldloc.s 6
    IL_00b3: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00b8: brfalse IL_0160
    IL_00bd: ldloc.s 6
    IL_00bf: ldarg.0
    IL_00c0: ldfld RailgunBeam.Config RailgunBeam::_config  /*0x04000738*/
    IL_00c5: ldfld TaggedObject RailgunBeam.Config::attacker  /*0x04000744*/
    IL_00ca: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00cf: brtrue IL_0155
    IL_00d4: ldloc.s 6
    IL_00d6: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_00db: ldc.i4.1
    IL_00dc: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_00e1: brfalse.s IL_0138
    IL_00e3: ldarg.0
    IL_00e4: ldfld RailgunBeam.Config RailgunBeam::_config  /*0x04000738*/
    IL_00e9: ldfld float RailgunBeam.Config::demageDecayCoeff  /*0x04000742*/
    IL_00ee: ldloc.1
    IL_00ef: conv.r4
    IL_00f0: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_00f5: stloc.s 7
    IL_00f7: ldarg.0
    IL_00f8: ldfld RailgunBeam.Config RailgunBeam::_config  /*0x04000738*/
    IL_00fd: ldfld Weapon RailgunBeam.Config::weapon  /*0x04000743*/
    IL_0102: ldarg.0
    IL_0103: ldfld RailgunBeam.Config RailgunBeam::_config  /*0x04000738*/
    IL_0108: ldfld Vector3 RailgunBeam.Config::origin  /*0x0400073F*/
    IL_010d: ldloc.s 6
    IL_010f: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0114: ldarg.2
    IL_0115: ldarg.0
    IL_0116: ldfld RailgunBeam.Config RailgunBeam::_config  /*0x04000738*/
    IL_011b: ldfld TaggedObject RailgunBeam.Config::attacker  /*0x04000744*/
    IL_0120: ldloc.s 7
    IL_0122: ldc.r4 1f
    IL_0127: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_012c: ldc.i4.0
    IL_012d: stloc.0
    IL_012e: ldloc.1
    IL_012f: ldc.i4.1
    IL_0130: add
    IL_0131: stloc.1
    IL_0132: ldarg.s 4
    IL_0134: brfalse.s IL_0155
    IL_0136: br.s IL_0160
    IL_0138: ldloc.s 6
    IL_013a: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_013f: ldc.i4.8
    IL_0140: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0145: brfalse.s IL_0160
    IL_0147: ldloc.s 6
    IL_0149: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_014e: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_0153: brfalse.s IL_0160
    IL_0155: ldloc.3
    IL_0156: ldc.i4.1
    IL_0157: add
    IL_0158: stloc.3
    IL_0159: ldloc.3
    IL_015a: ldloc.2
    IL_015b: blt IL_003e
    IL_0160: ldloc.0
    IL_0161: ret

  .method RailgunBeam::FilterHit(UnityEngine.RaycastHit)  // token 0x060005D5 rva 0x18e38 attrs Private, HideBySig
    // code size 36 (0x24), max stack 2, init locals
    .locals ([0] GameObject)
    IL_0000: ldarga.s 1
    IL_0002: call Transform UnityEngine.RaycastHit::get_transform()  /*0x0A000273*/
    IL_0007: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000c: stloc.0
    IL_000d: ldsfld int[] RailgunBeam::ignoredColliders  /*0x0400073E*/
    IL_0012: ldloc.0
    IL_0013: callvirt int UnityEngine.GameObject::get_layer()  /*0x0A00022A*/
    IL_0018: call int System.Array::IndexOf(!!0[],!!0)<int>  /*0x2B000046*/
    IL_001d: ldc.i4.0
    IL_001e: blt.s IL_0022
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldc.i4.1
    IL_0023: ret

  .method RailgunBeam::.cctor()  // token 0x060005D6 rva 0x18e68 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 57 (0x39), max stack 8
    IL_0000: newobj void RailgunBeam.RaycastHitComparer::.ctor()  /*0x060005DA*/
    IL_0005: stsfld RailgunBeam.RaycastHitComparer RailgunBeam::_hitComparer  /*0x04000739*/
    IL_000a: ldc.r4 -Infinityf
    IL_000f: ldc.r4 0f
    IL_0014: ldc.r4 0f
    IL_0019: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_001e: stsfld Vector3 RailgunBeam::_invalidVec3  /*0x0400073C*/
    IL_0023: ldc.i4.2
    IL_0024: newarr System.Int32  /*0x01000026*/
    IL_0029: dup
    IL_002a: ldc.i4.0
    IL_002b: ldc.i4.s 12
    IL_002d: stelem.i4
    IL_002e: dup
    IL_002f: ldc.i4.1
    IL_0030: ldc.i4.s 30
    IL_0032: stelem.i4
    IL_0033: stsfld int[] RailgunBeam::ignoredColliders  /*0x0400073E*/
    IL_0038: ret

// ===== RailgunBeam/Config  (token 0x0200011B) =====
  .method RailgunBeam.Config::Validate()  // token 0x060005D7 rva 0x18ea4 attrs Public, HideBySig
    // code size 124 (0x7c), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Weapon RailgunBeam.Config::weapon  /*0x04000743*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_001a
    IL_000e: ldstr "RailgunBeam Config (RailgunBeam.cs): weapon is not set"
    IL_0013: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldfld float RailgunBeam.Config::range  /*0x04000741*/
    IL_0020: ldc.r4 0f
    IL_0025: bne.un.s IL_0033
    IL_0027: ldstr "RailgunBeam Config (RailgunBeam.cs): range is 0"
    IL_002c: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0031: ldc.i4.0
    IL_0032: ret
    IL_0033: ldarg.0
    IL_0034: ldfld TaggedObject RailgunBeam.Config::attacker  /*0x04000744*/
    IL_0039: ldnull
    IL_003a: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_003f: brfalse.s IL_004b
    IL_0041: ldstr "RailgunBeam Config (RailgunBeam.cs): attacker is not set"
    IL_0046: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_004b: ldarg.0
    IL_004c: ldfld float RailgunBeam.Config::demageDecayCoeff  /*0x04000742*/
    IL_0051: ldc.r4 0f
    IL_0056: bne.un.s IL_0062
    IL_0058: ldstr "RailgunBeam Config (RailgunBeam.cs): demageDecayCoeff is 0"
    IL_005d: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_0062: ldarg.0
    IL_0063: ldfld LaserBeam RailgunBeam.Config::laserBeam  /*0x04000745*/
    IL_0068: ldnull
    IL_0069: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_006e: brfalse.s IL_007a
    IL_0070: ldstr "RailgunBeam Config (RailgunBeam.cs): laserBeam is null"
    IL_0075: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_007a: ldc.i4.1
    IL_007b: ret

  .method RailgunBeam.Config::.ctor()  // token 0x060005D8 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

// ===== RailgunBeam/RaycastHitComparer  (token 0x0200011C) =====
  .method RailgunBeam.RaycastHitComparer::Compare(UnityEngine.RaycastHit,UnityEngine.RaycastHit)  // token 0x060005D9 rva 0x18f2c attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 23 (0x17), max stack 2, init locals
    .locals ([0] float)
    IL_0000: ldarga.s 1
    IL_0002: call float UnityEngine.RaycastHit::get_distance()  /*0x0A000275*/
    IL_0007: stloc.0
    IL_0008: ldloca.s 0
    IL_000a: ldarga.s 2
    IL_000c: call float UnityEngine.RaycastHit::get_distance()  /*0x0A000275*/
    IL_0011: call int System.Single::CompareTo(float)  /*0x0A000276*/
    IL_0016: ret

  .method RailgunBeam.RaycastHitComparer::.ctor()  // token 0x060005DA rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

// ===== RailgunBeam/BeamState  (token 0x0200011D) =====
