// ===== KnockbackBehavior  (token 0x020001A2) =====
  .method KnockbackBehavior::Update()  // token 0x06000874 rva 0x28cb8 attrs Private, HideBySig
    // code size 69 (0x45), max stack 2, init locals
    .locals ([0] KnockbackBehavior.KnockbackPhase)
    IL_0000: ldarg.0
    IL_0001: ldfld bool KnockbackBehavior::knockingBack  /*0x04000A7E*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld KnockbackBehavior.KnockbackPhase KnockbackBehavior::phase  /*0x04000A7A*/
    IL_000f: stloc.0
    IL_0010: ldloc.0
    IL_0011: ldc.i4.1
    IL_0012: sub
    IL_0013: switch (IL_0029, IL_0030, IL_0037, IL_003e)
    IL_0028: ret
    IL_0029: ldarg.0
    IL_002a: call void KnockbackBehavior::UpdateArc()  /*0x06000876*/
    IL_002f: ret
    IL_0030: ldarg.0
    IL_0031: call void KnockbackBehavior::UpdateDrop()  /*0x06000877*/
    IL_0036: ret
    IL_0037: ldarg.0
    IL_0038: call void KnockbackBehavior::UpdateStagger()  /*0x06000878*/
    IL_003d: ret
    IL_003e: ldarg.0
    IL_003f: call void KnockbackBehavior::UpdateCorrection()  /*0x06000879*/
    IL_0044: ret

  .method KnockbackBehavior::ApplyKnockback(UnityEngine.Vector3,float,float,float,PathfindMovement,Pathfinding.RVO.RVOController,AutoAttack[])  // token 0x06000875 rva 0x28d0c attrs Public, HideBySig
    // code size 263 (0x107), max stack 5, init locals
    .locals ([0] float, [1] AutoAttack[], [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld bool KnockbackBehavior::knockingBack  /*0x04000A7E*/
    IL_0006: brtrue.s IL_001c
    IL_0008: ldarg.s 5
    IL_000a: ldnull
    IL_000b: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0010: brtrue.s IL_001c
    IL_0012: ldarg.s 6
    IL_0014: ldnull
    IL_0015: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_001a: brfalse.s IL_001d
    IL_001c: ret
    IL_001d: ldarg.0
    IL_001e: ldarg.s 5
    IL_0020: stfld PathfindMovement KnockbackBehavior::behPathfind  /*0x04000A8A*/
    IL_0025: ldarg.0
    IL_0026: ldarg.s 6
    IL_0028: stfld RVOController KnockbackBehavior::behRvo  /*0x04000A8B*/
    IL_002d: ldarg.0
    IL_002e: ldarg.s 7
    IL_0030: stfld AutoAttack[] KnockbackBehavior::behAutoAttacks  /*0x04000A8C*/
    IL_0035: ldarg.0
    IL_0036: ldarg.s 5
    IL_0038: isinst PathfindMovementEnemy  /*0x0200020F*/
    IL_003d: stfld PathfindMovementEnemy KnockbackBehavior::enemyPathfind  /*0x04000A8D*/
    IL_0042: ldarg.0
    IL_0043: ldarg.s 5
    IL_0045: isinst PathfindMovementPlayerunit  /*0x02000210*/
    IL_004a: stfld PathfindMovementPlayerunit KnockbackBehavior::unitPathfind  /*0x04000A8E*/
    IL_004f: ldarg.0
    IL_0050: ldfld PathfindMovementEnemy KnockbackBehavior::enemyPathfind  /*0x04000A8D*/
    IL_0055: ldnull
    IL_0056: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_005b: brfalse.s IL_006c
    IL_005d: ldarg.0
    IL_005e: ldfld PathfindMovementPlayerunit KnockbackBehavior::unitPathfind  /*0x04000A8E*/
    IL_0063: ldnull
    IL_0064: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0069: brfalse.s IL_006c
    IL_006b: ret
    IL_006c: ldarg.0
    IL_006d: ldarg.0
    IL_006e: ldarg.0
    IL_006f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0074: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0079: ldarg.1
    IL_007a: ldarg.3
    IL_007b: call Vector3 KnockbackBehavior::CalculateEndpoint(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0600087A*/
    IL_0080: stfld Vector3 KnockbackBehavior::endpoint  /*0x04000A81*/
    IL_0085: ldarg.3
    IL_0086: ldarg.s 4
    IL_0088: div
    IL_0089: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_008e: stloc.0
    IL_008f: ldarg.0
    IL_0090: ldarg.0
    IL_0091: ldfld float KnockbackBehavior::knockbackDuration  /*0x04000A77*/
    IL_0096: ldloc.0
    IL_0097: mul
    IL_0098: stfld float KnockbackBehavior::calculatedDuration  /*0x04000A80*/
    IL_009d: ldarg.s 5
    IL_009f: ldc.i4.0
    IL_00a0: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_00a5: ldarg.s 7
    IL_00a7: brfalse.s IL_00c8
    IL_00a9: ldarg.s 7
    IL_00ab: ldlen
    IL_00ac: brfalse.s IL_00c8
    IL_00ae: ldarg.s 7
    IL_00b0: stloc.1
    IL_00b1: ldc.i4.0
    IL_00b2: stloc.2
    IL_00b3: br.s IL_00c2
    IL_00b5: ldloc.1
    IL_00b6: ldloc.2
    IL_00b7: ldelem.ref
    IL_00b8: ldc.i4.0
    IL_00b9: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_00be: ldloc.2
    IL_00bf: ldc.i4.1
    IL_00c0: add
    IL_00c1: stloc.2
    IL_00c2: ldloc.2
    IL_00c3: ldloc.1
    IL_00c4: ldlen
    IL_00c5: conv.i4
    IL_00c6: blt.s IL_00b5
    IL_00c8: ldarg.0
    IL_00c9: ldc.i4.1
    IL_00ca: stfld bool KnockbackBehavior::knockingBack  /*0x04000A7E*/
    IL_00cf: ldarg.0
    IL_00d0: ldarg.0
    IL_00d1: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00d6: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00db: stfld Vector3 KnockbackBehavior::arcStart  /*0x04000A7C*/
    IL_00e0: ldarg.0
    IL_00e1: ldarg.0
    IL_00e2: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00e7: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00ec: stfld Vector3 KnockbackBehavior::lastValidXZ  /*0x04000A87*/
    IL_00f1: ldarg.0
    IL_00f2: ldc.i4.0
    IL_00f3: stfld bool KnockbackBehavior::xzLocked  /*0x04000A7D*/
    IL_00f8: ldarg.0
    IL_00f9: ldc.i4.1
    IL_00fa: stfld bool KnockbackBehavior::firstFramePassed  /*0x04000A82*/
    IL_00ff: ldarg.0
    IL_0100: ldc.i4.1
    IL_0101: stfld KnockbackBehavior.KnockbackPhase KnockbackBehavior::phase  /*0x04000A7A*/
    IL_0106: ret

  .method KnockbackBehavior::UpdateArc()  // token 0x06000876 rva 0x28e20 attrs Private, HideBySig
    // code size 328 (0x148), max stack 6, init locals
    .locals ([0] float, [1] float, [2] Vector3, [3] Vector3, [4] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float KnockbackBehavior::flyTimer  /*0x04000A7B*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float KnockbackBehavior::flyTimer  /*0x04000A7B*/
    IL_0012: ldarg.0
    IL_0013: ldfld float KnockbackBehavior::flyTimer  /*0x04000A7B*/
    IL_0018: ldarg.0
    IL_0019: ldfld float KnockbackBehavior::calculatedDuration  /*0x04000A80*/
    IL_001e: div
    IL_001f: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_0024: stloc.0
    IL_0025: ldarg.0
    IL_0026: ldfld AnimationCurve KnockbackBehavior::knockbackCurve  /*0x04000A76*/
    IL_002b: ldloc.0
    IL_002c: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0031: stloc.1
    IL_0032: ldarg.0
    IL_0033: ldfld float KnockbackBehavior::knockbackForce  /*0x04000A7F*/
    IL_0038: pop
    IL_0039: ldarg.0
    IL_003a: ldarg.0
    IL_003b: ldfld Vector3 KnockbackBehavior::arcStart  /*0x04000A7C*/
    IL_0040: ldarg.0
    IL_0041: ldfld Vector3 KnockbackBehavior::endpoint  /*0x04000A81*/
    IL_0046: ldloc.1
    IL_0047: ldloc.0
    IL_0048: ldarg.0
    IL_0049: ldfld float KnockbackBehavior::arcHeight  /*0x04000A75*/
    IL_004e: call Vector3 KnockbackBehavior::EvaluateArc(UnityEngine.Vector3,UnityEngine.Vector3,float,float,float)  /*0x0600087D*/
    IL_0053: stloc.2
    IL_0054: ldarg.0
    IL_0055: ldfld bool KnockbackBehavior::fakeFly  /*0x04000A83*/
    IL_005a: brtrue.s IL_00ba
    IL_005c: ldloca.s 3
    IL_005e: ldloc.2
    IL_005f: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0064: ldarg.0
    IL_0065: ldflda Vector3 KnockbackBehavior::endpoint  /*0x04000A81*/
    IL_006a: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_006f: ldloc.2
    IL_0070: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0075: call void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_007a: ldarg.0
    IL_007b: ldfld PathfindMovementEnemy KnockbackBehavior::enemyPathfind  /*0x04000A8D*/
    IL_0080: ldnull
    IL_0081: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0086: brtrue.s IL_0096
    IL_0088: ldarg.0
    IL_0089: ldfld PathfindMovementPlayerunit KnockbackBehavior::unitPathfind  /*0x04000A8E*/
    IL_008e: ldloc.3
    IL_008f: callvirt Vector3 PathfindMovementPlayerunit::GetNearestGroundPosition(UnityEngine.Vector3)  /*0x06000B48*/
    IL_0094: br.s IL_00a2
    IL_0096: ldarg.0
    IL_0097: ldfld PathfindMovementEnemy KnockbackBehavior::enemyPathfind  /*0x04000A8D*/
    IL_009c: ldloc.3
    IL_009d: callvirt Vector3 PathfindMovementEnemy::GetNearestGroundPosition(UnityEngine.Vector3)  /*0x06000B1B*/
    IL_00a2: stloc.s 4
    IL_00a4: ldarg.0
    IL_00a5: ldarg.0
    IL_00a6: ldarg.0
    IL_00a7: ldflda Vector3 KnockbackBehavior::lastValidXZ  /*0x04000A87*/
    IL_00ac: ldloc.3
    IL_00ad: ldloc.2
    IL_00ae: ldloc.s 4
    IL_00b0: call bool KnockbackBehavior::CheckIfLocked(ref UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0600087C*/
    IL_00b5: stfld bool KnockbackBehavior::xzLocked  /*0x04000A7D*/
    IL_00ba: ldarg.0
    IL_00bb: ldfld bool KnockbackBehavior::xzLocked  /*0x04000A7D*/
    IL_00c0: brfalse.s IL_00d1
    IL_00c2: ldarg.0
    IL_00c3: ldfld bool KnockbackBehavior::firstFramePassed  /*0x04000A82*/
    IL_00c8: brfalse.s IL_00d1
    IL_00ca: ldarg.0
    IL_00cb: ldc.i4.1
    IL_00cc: stfld bool KnockbackBehavior::fakeFly  /*0x04000A83*/
    IL_00d1: ldarg.0
    IL_00d2: ldfld bool KnockbackBehavior::xzLocked  /*0x04000A7D*/
    IL_00d7: brfalse.s IL_00f4
    IL_00d9: ldarg.0
    IL_00da: ldfld bool KnockbackBehavior::fakeFly  /*0x04000A83*/
    IL_00df: brtrue.s IL_00f4
    IL_00e1: ldarg.0
    IL_00e2: ldc.r4 0f
    IL_00e7: stfld float KnockbackBehavior::flyTimer  /*0x04000A7B*/
    IL_00ec: ldarg.0
    IL_00ed: ldc.i4.2
    IL_00ee: stfld KnockbackBehavior.KnockbackPhase KnockbackBehavior::phase  /*0x04000A7A*/
    IL_00f3: ret
    IL_00f4: ldarg.0
    IL_00f5: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00fa: ldarg.0
    IL_00fb: ldflda Vector3 KnockbackBehavior::lastValidXZ  /*0x04000A87*/
    IL_0100: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0105: ldloc.2
    IL_0106: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_010b: ldarg.0
    IL_010c: ldflda Vector3 KnockbackBehavior::lastValidXZ  /*0x04000A87*/
    IL_0111: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0116: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_011b: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0120: ldarg.0
    IL_0121: ldfld float KnockbackBehavior::flyTimer  /*0x04000A7B*/
    IL_0126: ldarg.0
    IL_0127: ldfld float KnockbackBehavior::calculatedDuration  /*0x04000A80*/
    IL_012c: blt.un.s IL_0140
    IL_012e: ldarg.0
    IL_012f: ldc.r4 0f
    IL_0134: stfld float KnockbackBehavior::flyTimer  /*0x04000A7B*/
    IL_0139: ldarg.0
    IL_013a: ldc.i4.3
    IL_013b: stfld KnockbackBehavior.KnockbackPhase KnockbackBehavior::phase  /*0x04000A7A*/
    IL_0140: ldarg.0
    IL_0141: ldc.i4.0
    IL_0142: stfld bool KnockbackBehavior::firstFramePassed  /*0x04000A82*/
    IL_0147: ret

  .method KnockbackBehavior::UpdateDrop()  // token 0x06000877 rva 0x28f74 attrs Private, HideBySig
    // code size 131 (0x83), max stack 4, init locals
    .locals ([0] float, [1] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float KnockbackBehavior::dropTimer  /*0x04000A85*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float KnockbackBehavior::dropTimer  /*0x04000A85*/
    IL_0012: ldarg.0
    IL_0013: ldfld float KnockbackBehavior::dropTimer  /*0x04000A85*/
    IL_0018: ldarg.0
    IL_0019: ldfld float KnockbackBehavior::dropDuration  /*0x04000A88*/
    IL_001e: div
    IL_001f: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_0024: dup
    IL_0025: mul
    IL_0026: stloc.0
    IL_0027: ldarg.0
    IL_0028: ldfld float KnockbackBehavior::yAtLockTime  /*0x04000A84*/
    IL_002d: ldarg.0
    IL_002e: ldfld float KnockbackBehavior::lastvalidNearestY  /*0x04000A86*/
    IL_0033: ldloc.0
    IL_0034: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0039: stloc.1
    IL_003a: ldarg.0
    IL_003b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0040: ldarg.0
    IL_0041: ldflda Vector3 KnockbackBehavior::lastValidXZ  /*0x04000A87*/
    IL_0046: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_004b: ldloc.1
    IL_004c: ldarg.0
    IL_004d: ldflda Vector3 KnockbackBehavior::lastValidXZ  /*0x04000A87*/
    IL_0052: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0057: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_005c: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0061: ldarg.0
    IL_0062: ldfld float KnockbackBehavior::dropTimer  /*0x04000A85*/
    IL_0067: ldarg.0
    IL_0068: ldfld float KnockbackBehavior::dropDuration  /*0x04000A88*/
    IL_006d: blt.un.s IL_0082
    IL_006f: ldarg.0
    IL_0070: ldc.r4 0f
    IL_0075: stfld float KnockbackBehavior::dropTimer  /*0x04000A85*/
    IL_007a: ldarg.0
    IL_007b: ldc.i4.3
    IL_007c: stfld KnockbackBehavior.KnockbackPhase KnockbackBehavior::phase  /*0x04000A7A*/
    IL_0081: ret
    IL_0082: ret

  .method KnockbackBehavior::UpdateStagger()  // token 0x06000878 rva 0x29003 attrs Private, HideBySig
    // code size 58 (0x3a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float KnockbackBehavior::staggerTimer  /*0x04000A89*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float KnockbackBehavior::staggerTimer  /*0x04000A89*/
    IL_0012: ldarg.0
    IL_0013: ldfld float KnockbackBehavior::staggerTimer  /*0x04000A89*/
    IL_0018: ldarg.0
    IL_0019: ldfld float KnockbackBehavior::staggerDuration  /*0x04000A79*/
    IL_001e: blt.un.s IL_0032
    IL_0020: ldarg.0
    IL_0021: ldc.r4 0f
    IL_0026: stfld float KnockbackBehavior::staggerTimer  /*0x04000A89*/
    IL_002b: ldarg.0
    IL_002c: ldc.i4.4
    IL_002d: stfld KnockbackBehavior.KnockbackPhase KnockbackBehavior::phase  /*0x04000A7A*/
    IL_0032: ldarg.0
    IL_0033: ldc.i4.0
    IL_0034: stfld bool KnockbackBehavior::fakeFly  /*0x04000A83*/
    IL_0039: ret

  .method KnockbackBehavior::UpdateCorrection()  // token 0x06000879 rva 0x2903e attrs Private, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld PathfindMovement KnockbackBehavior::behPathfind  /*0x04000A8A*/
    IL_0007: ldarg.0
    IL_0008: ldfld RVOController KnockbackBehavior::behRvo  /*0x04000A8B*/
    IL_000d: ldarg.0
    IL_000e: ldfld Vector3 KnockbackBehavior::lastValidXZ  /*0x04000A87*/
    IL_0013: call void KnockbackBehavior::RecoverOnPath(PathfindMovement,Pathfinding.RVO.RVOController,UnityEngine.Vector3)  /*0x0600087E*/
    IL_0018: ldarg.0
    IL_0019: ldc.i4.0
    IL_001a: stfld KnockbackBehavior.KnockbackPhase KnockbackBehavior::phase  /*0x04000A7A*/
    IL_001f: ret

  .method KnockbackBehavior::CalculateEndpoint(UnityEngine.Vector3,UnityEngine.Vector3,float)  // token 0x0600087A rva 0x29060 attrs Private, HideBySig
    // code size 57 (0x39), max stack 3, init locals
    .locals ([0] Vector3, [1] Vector3)
    IL_0000: ldarg.1
    IL_0001: ldarg.2
    IL_0002: ldarg.3
    IL_0003: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0008: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_000d: stloc.0
    IL_000e: ldarg.0
    IL_000f: ldfld PathfindMovementEnemy KnockbackBehavior::enemyPathfind  /*0x04000A8D*/
    IL_0014: ldnull
    IL_0015: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001a: brtrue.s IL_002a
    IL_001c: ldarg.0
    IL_001d: ldfld PathfindMovementPlayerunit KnockbackBehavior::unitPathfind  /*0x04000A8E*/
    IL_0022: ldloc.0
    IL_0023: callvirt Vector3 PathfindMovementPlayerunit::GetNearestGroundPosition(UnityEngine.Vector3)  /*0x06000B48*/
    IL_0028: br.s IL_0036
    IL_002a: ldarg.0
    IL_002b: ldfld PathfindMovementEnemy KnockbackBehavior::enemyPathfind  /*0x04000A8D*/
    IL_0030: ldloc.0
    IL_0031: callvirt Vector3 PathfindMovementEnemy::GetNearestGroundPosition(UnityEngine.Vector3)  /*0x06000B1B*/
    IL_0036: stloc.1
    IL_0037: ldloc.1
    IL_0038: ret

  .method KnockbackBehavior::CalculateDropDuration(float)  // token 0x0600087B rva 0x290a5 attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldc.r4 0f
    IL_0006: bgt.un.s IL_000e
    IL_0008: ldc.r4 0f
    IL_000d: ret
    IL_000e: ldc.r4 2f
    IL_0013: ldarg.1
    IL_0014: mul
    IL_0015: ldarg.0
    IL_0016: ldfld float KnockbackBehavior::gravity  /*0x04000A78*/
    IL_001b: div
    IL_001c: call float UnityEngine.Mathf::Sqrt(float)  /*0x0A000332*/
    IL_0021: ret

  .method KnockbackBehavior::CheckIfLocked(ref UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Vector3)  // token 0x0600087C rva 0x290c8 attrs Private, HideBySig
    // code size 124 (0x7c), max stack 4, init locals
    IL_0000: ldarg.s 4
    IL_0002: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0007: ldarg.s 4
    IL_0009: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_000e: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0013: ldarg.3
    IL_0014: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0019: ldarg.3
    IL_001a: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_001f: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0024: call float UnityEngine.Vector2::Distance(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000157*/
    IL_0029: ldc.r4 0.1f
    IL_002e: bge.un.s IL_004f
    IL_0030: ldarg.1
    IL_0031: ldarg.3
    IL_0032: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0037: ldarg.1
    IL_0038: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_003d: ldarg.3
    IL_003e: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0043: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0048: stobj UnityEngine.Vector3  /*0x01000028*/
    IL_004d: ldc.i4.0
    IL_004e: ret
    IL_004f: ldarg.0
    IL_0050: ldarg.3
    IL_0051: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0056: stfld float KnockbackBehavior::yAtLockTime  /*0x04000A84*/
    IL_005b: ldarg.0
    IL_005c: ldarg.s 4
    IL_005e: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0063: stfld float KnockbackBehavior::lastvalidNearestY  /*0x04000A86*/
    IL_0068: ldarg.0
    IL_0069: ldarg.0
    IL_006a: ldarg.0
    IL_006b: ldfld float KnockbackBehavior::yAtLockTime  /*0x04000A84*/
    IL_0070: call float KnockbackBehavior::CalculateDropDuration(float)  /*0x0600087B*/
    IL_0075: stfld float KnockbackBehavior::dropDuration  /*0x04000A88*/
    IL_007a: ldc.i4.1
    IL_007b: ret

  .method KnockbackBehavior::EvaluateArc(UnityEngine.Vector3,UnityEngine.Vector3,float,float,float)  // token 0x0600087D rva 0x29150 attrs Private, HideBySig
    // code size 82 (0x52), max stack 5, init locals
    .locals ([0] float, [1] float)
    IL_0000: ldarg.1
    IL_0001: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0006: ldarg.2
    IL_0007: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_000c: ldarg.3
    IL_000d: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0012: ldarg.1
    IL_0013: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0018: ldarg.2
    IL_0019: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_001e: ldarg.3
    IL_001f: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0024: stloc.0
    IL_0025: ldarg.1
    IL_0026: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_002b: ldarg.2
    IL_002c: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0031: ldarg.s 4
    IL_0033: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0038: ldarg.s 5
    IL_003a: ldarg.s 4
    IL_003c: ldc.r4 3.1415927f
    IL_0041: mul
    IL_0042: call float UnityEngine.Mathf::Sin(float)  /*0x0A0000AB*/
    IL_0047: mul
    IL_0048: add
    IL_0049: stloc.1
    IL_004a: ldloc.1
    IL_004b: ldloc.0
    IL_004c: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0051: ret

  .method KnockbackBehavior::RecoverOnPath(PathfindMovement,Pathfinding.RVO.RVOController,UnityEngine.Vector3)  // token 0x0600087E rva 0x291b0 attrs Private, HideBySig
    // code size 74 (0x4a), max stack 2, init locals
    .locals ([0] AutoAttack[], [1] int)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: ldarg.3
    IL_0007: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_000c: ldarg.1
    IL_000d: ldc.i4.1
    IL_000e: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0013: ldarg.0
    IL_0014: ldc.i4.0
    IL_0015: stfld bool KnockbackBehavior::knockingBack  /*0x04000A7E*/
    IL_001a: ldarg.0
    IL_001b: ldfld AutoAttack[] KnockbackBehavior::behAutoAttacks  /*0x04000A8C*/
    IL_0020: brfalse.s IL_0049
    IL_0022: ldarg.0
    IL_0023: ldfld AutoAttack[] KnockbackBehavior::behAutoAttacks  /*0x04000A8C*/
    IL_0028: ldlen
    IL_0029: brfalse.s IL_0049
    IL_002b: ldarg.0
    IL_002c: ldfld AutoAttack[] KnockbackBehavior::behAutoAttacks  /*0x04000A8C*/
    IL_0031: stloc.0
    IL_0032: ldc.i4.0
    IL_0033: stloc.1
    IL_0034: br.s IL_0043
    IL_0036: ldloc.0
    IL_0037: ldloc.1
    IL_0038: ldelem.ref
    IL_0039: ldc.i4.1
    IL_003a: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_003f: ldloc.1
    IL_0040: ldc.i4.1
    IL_0041: add
    IL_0042: stloc.1
    IL_0043: ldloc.1
    IL_0044: ldloc.0
    IL_0045: ldlen
    IL_0046: conv.i4
    IL_0047: blt.s IL_0036
    IL_0049: ret

  .method KnockbackBehavior::.ctor()  // token 0x0600087F rva 0x29208 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 93 (0x5d), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1.5f
    IL_0006: stfld float KnockbackBehavior::arcHeight  /*0x04000A75*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0f
    IL_0011: ldc.r4 0f
    IL_0016: ldc.r4 1f
    IL_001b: ldc.r4 1f
    IL_0020: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_0025: stfld AnimationCurve KnockbackBehavior::knockbackCurve  /*0x04000A76*/
    IL_002a: ldarg.0
    IL_002b: ldc.r4 0.4f
    IL_0030: stfld float KnockbackBehavior::knockbackDuration  /*0x04000A77*/
    IL_0035: ldarg.0
    IL_0036: ldc.r4 20f
    IL_003b: stfld float KnockbackBehavior::gravity  /*0x04000A78*/
    IL_0040: ldarg.0
    IL_0041: ldc.r4 0.2f
    IL_0046: stfld float KnockbackBehavior::staggerDuration  /*0x04000A79*/
    IL_004b: ldarg.0
    IL_004c: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0051: stfld Vector3 KnockbackBehavior::lastValidXZ  /*0x04000A87*/
    IL_0056: ldarg.0
    IL_0057: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_005c: ret

// ===== KnockbackBehavior/KnockbackPhase  (token 0x020001A3) =====
