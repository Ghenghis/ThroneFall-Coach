// ===== PathfindMovementPlayerunitShieldBearer  (token 0x02000113) =====
  .method PathfindMovementPlayerunitShieldBearer::get_HoldPosition()  // token 0x060005B2 rva 0x18419 attrs Public, Virtual, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool PathfindMovementPlayerunit::get_HoldPosition()  /*0x06000B33*/
    IL_0006: ret

  .method PathfindMovementPlayerunitShieldBearer::set_HoldPosition(bool)  // token 0x060005B3 rva 0x18424 attrs Public, Virtual, HideBySig, SpecialName
    // code size 57 (0x39), max stack 2, init locals
    .locals ([0] HpWithDamageReduction)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void PathfindMovementPlayerunit::set_HoldPosition(bool)  /*0x06000B34*/
    IL_0007: ldarg.0
    IL_0008: ldfld Hp PathfindMovementPlayerunit::hp  /*0x04000E21*/
    IL_000d: isinst HpWithDamageReduction  /*0x02000100*/
    IL_0012: stloc.0
    IL_0013: ldloc.0
    IL_0014: ldnull
    IL_0015: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001a: brfalse.s IL_0038
    IL_001c: ldarg.1
    IL_001d: brfalse.s IL_002c
    IL_001f: ldloc.0
    IL_0020: ldarg.0
    IL_0021: ldfld float PathfindMovementPlayerunitShieldBearer::HoldPositionDamageReductionRate  /*0x0400071F*/
    IL_0026: stfld float HpWithDamageReduction::DamageReductionRate  /*0x040006E0*/
    IL_002b: ret
    IL_002c: ldloc.0
    IL_002d: ldarg.0
    IL_002e: ldfld float PathfindMovementPlayerunitShieldBearer::DefaultDamageReductionRate  /*0x04000720*/
    IL_0033: stfld float HpWithDamageReduction::DamageReductionRate  /*0x040006E0*/
    IL_0038: ret

  .method PathfindMovementPlayerunitShieldBearer::.ctor()  // token 0x060005B4 rva 0x18469 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void PathfindMovementPlayerunit::.ctor()  /*0x06000B49*/
    IL_0006: ret

