// ===== AutoAttackWithKnockback  (token 0x02000071) =====
  .method AutoAttackWithKnockback::get_KnockbackData()  // token 0x0600024A rva 0xa8e2 attrs Private, HideBySig, SpecialName
    // code size 53 (0x35), max stack 8
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: ldarg.0
    IL_0006: ldfld List<TagManager.ETag> AutoAttackWithKnockback::mustHaveTags  /*0x04000323*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<TagManager.ETag> AutoAttackWithKnockback::mayNotHaveTags  /*0x04000324*/
    IL_0011: ldarg.0
    IL_0012: ldfld Transform AutoAttackWithKnockback::facer  /*0x04000322*/
    IL_0017: ldarg.0
    IL_0018: ldfld float AutoAttackWithKnockback::maxRange  /*0x0400031F*/
    IL_001d: ldarg.0
    IL_001e: ldfld float AutoAttackWithKnockback::maxRange  /*0x0400031F*/
    IL_0023: ldarg.0
    IL_0024: ldfld float AutoAttackWithKnockback::maxForce  /*0x0400031E*/
    IL_0029: ldarg.0
    IL_002a: ldfld int AutoAttackWithKnockback::areaAngle  /*0x04000321*/
    IL_002f: call KnockbackUtils.KnockbackData KnockbackUtils.KnockbackData::Radial(TagManager,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,UnityEngine.Transform,float,float,float,int)  /*0x060013BB*/
    IL_0034: ret

  .method AutoAttackWithKnockback::OnAttack(TaggedObject)  // token 0x0600024B rva 0xa918 attrs Public, Virtual, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void AutoAttack::OnAttack(TaggedObject)  /*0x06000235*/
    IL_0007: ldarg.0
    IL_0008: call KnockbackUtils.KnockbackData AutoAttackWithKnockback::get_KnockbackData()  /*0x0600024A*/
    IL_000d: ldarg.0
    IL_000e: ldftn void AutoAttackWithKnockback::PlayEffect()  /*0x0600024C*/
    IL_0014: newobj void System.Action::.ctor(object,IntPtr)  /*0x0A0000E8*/
    IL_0019: ldnull
    IL_001a: call bool KnockbackUtils::ApplyKnockback(KnockbackUtils.KnockbackData,System.Action,System.Action)  /*0x060013B2*/
    IL_001f: pop
    IL_0020: ret

  .method AutoAttackWithKnockback::PlayEffect()  // token 0x0600024C rva 0xa93c attrs Private, HideBySig
    // code size 90 (0x5a), max stack 5, init locals
    .locals ([0] ParticleSystem.ShapeModule)
    IL_0000: ldarg.0
    IL_0001: ldfld ParticleSystem AutoAttackWithKnockback::knockbackEffect  /*0x04000320*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld ParticleSystem AutoAttackWithKnockback::knockbackEffect  /*0x04000320*/
    IL_0015: callvirt ParticleSystem.ShapeModule UnityEngine.ParticleSystem::get_shape()  /*0x0A0000E9*/
    IL_001a: stloc.0
    IL_001b: ldloca.s 0
    IL_001d: ldarg.0
    IL_001e: ldfld int AutoAttackWithKnockback::areaAngle  /*0x04000321*/
    IL_0023: conv.r4
    IL_0024: call void UnityEngine.ParticleSystem.ShapeModule::set_arc(float)  /*0x0A0000EA*/
    IL_0029: ldloca.s 0
    IL_002b: ldc.r4 -90f
    IL_0030: ldc.r4 -90f
    IL_0035: ldarg.0
    IL_0036: ldfld int AutoAttackWithKnockback::areaAngle  /*0x04000321*/
    IL_003b: ldc.i4.2
    IL_003c: div
    IL_003d: conv.r4
    IL_003e: sub
    IL_003f: ldc.r4 0f
    IL_0044: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0049: call void UnityEngine.ParticleSystem.ShapeModule::set_rotation(UnityEngine.Vector3)  /*0x0A0000EB*/
    IL_004e: ldarg.0
    IL_004f: ldfld ParticleSystem AutoAttackWithKnockback::knockbackEffect  /*0x04000320*/
    IL_0054: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_0059: ret

  .method AutoAttackWithKnockback::.ctor()  // token 0x0600024D rva 0xa9a2 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 10f
    IL_0006: stfld float AutoAttackWithKnockback::maxRange  /*0x0400031F*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4 360
    IL_0011: stfld int AutoAttackWithKnockback::areaAngle  /*0x04000321*/
    IL_0016: ldarg.0
    IL_0017: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_001c: ret

