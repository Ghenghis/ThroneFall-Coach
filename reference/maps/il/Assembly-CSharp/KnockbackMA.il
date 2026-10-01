// ===== KnockbackMA  (token 0x020001E5) =====
  .method KnockbackMA::get_KnockbackData()  // token 0x060009F3 rva 0x2efa3 attrs Private, HideBySig, SpecialName
    // code size 54 (0x36), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TagManager KnockbackMA::tagManager  /*0x04000CB3*/
    IL_0006: ldarg.0
    IL_0007: ldfld List<TagManager.ETag> KnockbackMA::mustHaveTags  /*0x04000CB1*/
    IL_000c: ldarg.0
    IL_000d: ldfld List<TagManager.ETag> KnockbackMA::mayNotHaveTags  /*0x04000CB2*/
    IL_0012: ldarg.0
    IL_0013: ldfld Transform KnockbackMA::facer  /*0x04000CB0*/
    IL_0018: ldarg.0
    IL_0019: ldfld float KnockbackMA::maxRange  /*0x04000CAE*/
    IL_001e: ldarg.0
    IL_001f: ldfld float KnockbackMA::maxRange  /*0x04000CAE*/
    IL_0024: ldarg.0
    IL_0025: ldfld float KnockbackMA::maxForce  /*0x04000CAD*/
    IL_002a: ldarg.0
    IL_002b: ldfld int KnockbackMA::areaAngle  /*0x04000CAF*/
    IL_0030: call KnockbackUtils.KnockbackData KnockbackUtils.KnockbackData::Radial(TagManager,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,UnityEngine.Transform,float,float,float,int)  /*0x060013BB*/
    IL_0035: ret

  .method KnockbackMA::Start()  // token 0x060009F4 rva 0x2efdc attrs Public, Virtual, HideBySig
    // code size 96 (0x60), max stack 5, init locals
    .locals ([0] ParticleSystem.ShapeModule)
    IL_0000: ldarg.0
    IL_0001: call void ManualAttack::Start()  /*0x06000A00*/
    IL_0006: ldarg.0
    IL_0007: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_000c: stfld TagManager KnockbackMA::tagManager  /*0x04000CB3*/
    IL_0011: ldarg.0
    IL_0012: ldfld ParticleSystem ManualAttack::particlesOnAttack  /*0x04000CBF*/
    IL_0017: ldnull
    IL_0018: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_001d: brfalse.s IL_0020
    IL_001f: ret
    IL_0020: ldarg.0
    IL_0021: ldfld ParticleSystem ManualAttack::particlesOnAttack  /*0x04000CBF*/
    IL_0026: callvirt ParticleSystem.ShapeModule UnityEngine.ParticleSystem::get_shape()  /*0x0A0000E9*/
    IL_002b: stloc.0
    IL_002c: ldloca.s 0
    IL_002e: ldarg.0
    IL_002f: ldfld int KnockbackMA::areaAngle  /*0x04000CAF*/
    IL_0034: conv.r4
    IL_0035: call void UnityEngine.ParticleSystem.ShapeModule::set_arc(float)  /*0x0A0000EA*/
    IL_003a: ldloca.s 0
    IL_003c: ldc.r4 -90f
    IL_0041: ldc.r4 -90f
    IL_0046: ldarg.0
    IL_0047: ldfld int KnockbackMA::areaAngle  /*0x04000CAF*/
    IL_004c: ldc.i4.2
    IL_004d: div
    IL_004e: conv.r4
    IL_004f: sub
    IL_0050: ldc.r4 0f
    IL_0055: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_005a: call void UnityEngine.ParticleSystem.ShapeModule::set_rotation(UnityEngine.Vector3)  /*0x0A0000EB*/
    IL_005f: ret

  .method KnockbackMA::Attack()  // token 0x060009F5 rva 0x2f048 attrs Public, Virtual, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ManualAttack::Attack()  /*0x06000A07*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: ldfld Transform KnockbackMA::facer  /*0x04000CB0*/
    IL_000d: call bool KnockbackMA::ApplyDamage(UnityEngine.Transform)  /*0x060009F6*/
    IL_0012: pop
    IL_0013: ret

  .method KnockbackMA::ApplyDamage(UnityEngine.Transform)  // token 0x060009F6 rva 0x2f05d attrs Private, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: call KnockbackUtils.KnockbackData KnockbackMA::get_KnockbackData()  /*0x060009F3*/
    IL_0006: ldarg.0
    IL_0007: ldftn void KnockbackMA::ApplyEffects()  /*0x060009F7*/
    IL_000d: newobj void System.Action::.ctor(object,IntPtr)  /*0x0A0000E8*/
    IL_0012: ldnull
    IL_0013: call bool KnockbackUtils::ApplyKnockback(KnockbackUtils.KnockbackData,System.Action,System.Action)  /*0x060013B2*/
    IL_0018: ret

  .method KnockbackMA::ApplyEffects()  // token 0x060009F7 rva 0x2f078 attrs Private, HideBySig
    // code size 117 (0x75), max stack 5, init locals
    .locals ([0] ParticleSystem.ShapeModule)
    IL_0000: ldarg.0
    IL_0001: ldfld ParticleSystem ManualAttack::particlesOnAttack  /*0x04000CBF*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld ParticleSystem ManualAttack::particlesOnAttack  /*0x04000CBF*/
    IL_0015: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001a: ldc.r4 0f
    IL_001f: ldarg.0
    IL_0020: ldfld Transform KnockbackMA::facer  /*0x04000CB0*/
    IL_0025: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002a: callvirt Vector3 UnityEngine.Transform::get_eulerAngles()  /*0x0A000265*/
    IL_002f: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0034: ldc.r4 0f
    IL_0039: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_003e: callvirt void UnityEngine.Transform::set_eulerAngles(UnityEngine.Vector3)  /*0x0A000266*/
    IL_0043: ldarg.0
    IL_0044: ldfld ParticleSystem ManualAttack::particlesOnAttack  /*0x04000CBF*/
    IL_0049: callvirt ParticleSystem.ShapeModule UnityEngine.ParticleSystem::get_shape()  /*0x0A0000E9*/
    IL_004e: stloc.0
    IL_004f: ldloca.s 0
    IL_0051: ldc.r4 -90f
    IL_0056: ldc.r4 -90f
    IL_005b: ldarg.0
    IL_005c: ldfld int KnockbackMA::areaAngle  /*0x04000CAF*/
    IL_0061: ldc.i4.2
    IL_0062: div
    IL_0063: conv.r4
    IL_0064: sub
    IL_0065: ldc.r4 0f
    IL_006a: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_006f: call void UnityEngine.ParticleSystem.ShapeModule::set_rotation(UnityEngine.Vector3)  /*0x0A0000EB*/
    IL_0074: ret

  .method KnockbackMA::.ctor()  // token 0x060009F8 rva 0x2f0f9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 10f
    IL_0006: stfld float KnockbackMA::maxRange  /*0x04000CAE*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4 360
    IL_0011: stfld int KnockbackMA::areaAngle  /*0x04000CAF*/
    IL_0016: ldarg.0
    IL_0017: call void ManualAttack::.ctor()  /*0x06000A0A*/
    IL_001c: ret

