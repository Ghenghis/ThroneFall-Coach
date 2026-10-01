// ===== AimbotProjectileExt  (token 0x020000BC) =====
  .method AimbotProjectileExt::Update()  // token 0x060003F3 rva 0x1139d attrs Family, Virtual, HideBySig
    // code size 48 (0x30), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ProjectileBlock.ProjectileTag AimbotProjectileExt::ptag  /*0x04000516*/
    IL_0006: ldc.i4.1
    IL_0007: beq.s IL_0029
    IL_0009: ldarg.0
    IL_000a: ldfld bool AimbotProjectileExt::firstStepMade  /*0x04000517*/
    IL_000f: brtrue.s IL_0029
    IL_0011: ldarg.0
    IL_0012: ldc.i4.1
    IL_0013: stfld bool AimbotProjectileExt::firstStepMade  /*0x04000517*/
    IL_0018: ldarg.0
    IL_0019: ldarg.0
    IL_001a: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001f: call Transform ProjectileBlock::Inside(UnityEngine.Transform)  /*0x060005CE*/
    IL_0024: stfld Transform AimbotProjectileExt::initialArea  /*0x04000518*/
    IL_0029: ldarg.0
    IL_002a: call void AimbotProjectile::Update()  /*0x06000082*/
    IL_002f: ret

  .method AimbotProjectileExt::ShouldBeDestroyedAheadOfTime()  // token 0x060003F4 rva 0x113ce attrs Family, Virtual, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ProjectileBlock.ProjectileTag AimbotProjectileExt::ptag  /*0x04000516*/
    IL_0006: ldc.i4.1
    IL_0007: bne.un.s IL_000b
    IL_0009: ldc.i4.0
    IL_000a: ret
    IL_000b: ldarg.0
    IL_000c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0011: call Transform ProjectileBlock::Inside(UnityEngine.Transform)  /*0x060005CE*/
    IL_0016: ldarg.0
    IL_0017: ldfld Transform AimbotProjectileExt::initialArea  /*0x04000518*/
    IL_001c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0021: ret

  .method AimbotProjectileExt::.ctor()  // token 0x060003F5 rva 0x113f1 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld ProjectileBlock.ProjectileTag AimbotProjectileExt::ptag  /*0x04000516*/
    IL_0007: ldarg.0
    IL_0008: call void AimbotProjectile::.ctor()  /*0x06000089*/
    IL_000d: ret

