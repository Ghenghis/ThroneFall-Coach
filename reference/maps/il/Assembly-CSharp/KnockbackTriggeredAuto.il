// ===== KnockbackTriggeredAuto  (token 0x020001A5) =====
  .method KnockbackTriggeredAuto::get_KnockbackData()  // token 0x06000883 rva 0x29308 attrs Private, HideBySig, SpecialName
    // code size 54 (0x36), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TagManager KnockbackTriggeredAuto::tagManager  /*0x04000AA6*/
    IL_0006: ldarg.0
    IL_0007: ldfld List<TagManager.ETag> KnockbackTriggeredAuto::mustHaveTags  /*0x04000AA3*/
    IL_000c: ldarg.0
    IL_000d: ldfld List<TagManager.ETag> KnockbackTriggeredAuto::mayNotHaveTags  /*0x04000AA4*/
    IL_0012: ldarg.0
    IL_0013: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0018: ldarg.0
    IL_0019: ldfld float KnockbackTriggeredAuto::minRange  /*0x04000A9C*/
    IL_001e: ldarg.0
    IL_001f: ldfld float KnockbackTriggeredAuto::maxRange  /*0x04000A9D*/
    IL_0024: ldarg.0
    IL_0025: ldfld float KnockbackTriggeredAuto::maxForce  /*0x04000A9B*/
    IL_002a: ldarg.0
    IL_002b: ldfld int KnockbackTriggeredAuto::areaAngle  /*0x04000AA1*/
    IL_0030: call KnockbackUtils.KnockbackData KnockbackUtils.KnockbackData::Radial(TagManager,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,UnityEngine.Transform,float,float,float,int)  /*0x060013BB*/
    IL_0035: ret

  .method KnockbackTriggeredAuto::Start()  // token 0x06000884 rva 0x29340 attrs Private, HideBySig
    // code size 86 (0x56), max stack 5, init locals
    .locals ([0] ParticleSystem.ShapeModule)
    IL_0000: ldarg.0
    IL_0001: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0006: stfld float KnockbackTriggeredAuto::cooldown  /*0x04000AA5*/
    IL_000b: ldarg.0
    IL_000c: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0011: stfld TagManager KnockbackTriggeredAuto::tagManager  /*0x04000AA6*/
    IL_0016: ldarg.0
    IL_0017: ldfld ParticleSystem KnockbackTriggeredAuto::knockbackEffect  /*0x04000A9E*/
    IL_001c: callvirt ParticleSystem.ShapeModule UnityEngine.ParticleSystem::get_shape()  /*0x0A0000E9*/
    IL_0021: stloc.0
    IL_0022: ldloca.s 0
    IL_0024: ldarg.0
    IL_0025: ldfld int KnockbackTriggeredAuto::areaAngle  /*0x04000AA1*/
    IL_002a: conv.r4
    IL_002b: call void UnityEngine.ParticleSystem.ShapeModule::set_arc(float)  /*0x0A0000EA*/
    IL_0030: ldloca.s 0
    IL_0032: ldc.r4 -90f
    IL_0037: ldc.r4 -90f
    IL_003c: ldarg.0
    IL_003d: ldfld int KnockbackTriggeredAuto::areaAngle  /*0x04000AA1*/
    IL_0042: ldc.i4.2
    IL_0043: div
    IL_0044: conv.r4
    IL_0045: sub
    IL_0046: ldc.r4 0f
    IL_004b: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0050: call void UnityEngine.ParticleSystem.ShapeModule::set_rotation(UnityEngine.Vector3)  /*0x0A0000EB*/
    IL_0055: ret

  .method KnockbackTriggeredAuto::Update()  // token 0x06000885 rva 0x293a4 attrs Private, HideBySig
    // code size 65 (0x41), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float KnockbackTriggeredAuto::cooldown  /*0x04000AA5*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float KnockbackTriggeredAuto::cooldown  /*0x04000AA5*/
    IL_0012: ldarg.0
    IL_0013: ldfld float KnockbackTriggeredAuto::cooldown  /*0x04000AA5*/
    IL_0018: ldc.r4 0f
    IL_001d: bgt.un.s IL_0040
    IL_001f: ldarg.0
    IL_0020: call bool KnockbackTriggeredAuto::ApplyKnockback()  /*0x06000886*/
    IL_0025: brfalse.s IL_0034
    IL_0027: ldarg.0
    IL_0028: ldarg.0
    IL_0029: ldfld float KnockbackTriggeredAuto::defaultCooldown  /*0x04000A9F*/
    IL_002e: stfld float KnockbackTriggeredAuto::cooldown  /*0x04000AA5*/
    IL_0033: ret
    IL_0034: ldarg.0
    IL_0035: ldarg.0
    IL_0036: ldfld float KnockbackTriggeredAuto::checkRate  /*0x04000AA0*/
    IL_003b: stfld float KnockbackTriggeredAuto::cooldown  /*0x04000AA5*/
    IL_0040: ret

  .method KnockbackTriggeredAuto::ApplyKnockback()  // token 0x06000886 rva 0x293f1 attrs Private, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: call KnockbackUtils.KnockbackData KnockbackTriggeredAuto::get_KnockbackData()  /*0x06000883*/
    IL_0006: ldnull
    IL_0007: ldarg.0
    IL_0008: ldftn void KnockbackTriggeredAuto::ApplyEffects()  /*0x06000887*/
    IL_000e: newobj void System.Action::.ctor(object,IntPtr)  /*0x0A0000E8*/
    IL_0013: call bool KnockbackUtils::ApplyKnockback(KnockbackUtils.KnockbackData,System.Action,System.Action)  /*0x060013B2*/
    IL_0018: ret

  .method KnockbackTriggeredAuto::ApplyEffects()  // token 0x06000887 rva 0x2940c attrs Private, HideBySig
    // code size 128 (0x80), max stack 5, init locals
    .locals ([0] ParticleSystem.ShapeModule)
    IL_0000: ldarg.0
    IL_0001: ldfld ParticleSystem KnockbackTriggeredAuto::knockbackEffect  /*0x04000A9E*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld ParticleSystem KnockbackTriggeredAuto::knockbackEffect  /*0x04000A9E*/
    IL_0015: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001a: ldc.r4 0f
    IL_001f: ldarg.0
    IL_0020: ldfld Transform KnockbackTriggeredAuto::facer  /*0x04000AA2*/
    IL_0025: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002a: callvirt Vector3 UnityEngine.Transform::get_eulerAngles()  /*0x0A000265*/
    IL_002f: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0034: ldc.r4 0f
    IL_0039: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_003e: callvirt void UnityEngine.Transform::set_eulerAngles(UnityEngine.Vector3)  /*0x0A000266*/
    IL_0043: ldarg.0
    IL_0044: ldfld ParticleSystem KnockbackTriggeredAuto::knockbackEffect  /*0x04000A9E*/
    IL_0049: callvirt ParticleSystem.ShapeModule UnityEngine.ParticleSystem::get_shape()  /*0x0A0000E9*/
    IL_004e: stloc.0
    IL_004f: ldloca.s 0
    IL_0051: ldc.r4 -90f
    IL_0056: ldc.r4 -90f
    IL_005b: ldarg.0
    IL_005c: ldfld int KnockbackTriggeredAuto::areaAngle  /*0x04000AA1*/
    IL_0061: ldc.i4.2
    IL_0062: div
    IL_0063: conv.r4
    IL_0064: sub
    IL_0065: ldc.r4 0f
    IL_006a: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_006f: call void UnityEngine.ParticleSystem.ShapeModule::set_rotation(UnityEngine.Vector3)  /*0x0A0000EB*/
    IL_0074: ldarg.0
    IL_0075: ldfld ParticleSystem KnockbackTriggeredAuto::knockbackEffect  /*0x04000A9E*/
    IL_007a: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_007f: ret

  .method KnockbackTriggeredAuto::.ctor()  // token 0x06000888 rva 0x29498 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 3.5f
    IL_0006: stfld float KnockbackTriggeredAuto::minRange  /*0x04000A9C*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 10f
    IL_0011: stfld float KnockbackTriggeredAuto::maxRange  /*0x04000A9D*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 5f
    IL_001c: stfld float KnockbackTriggeredAuto::defaultCooldown  /*0x04000A9F*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 1f
    IL_0027: stfld float KnockbackTriggeredAuto::checkRate  /*0x04000AA0*/
    IL_002c: ldarg.0
    IL_002d: ldc.i4 360
    IL_0032: stfld int KnockbackTriggeredAuto::areaAngle  /*0x04000AA1*/
    IL_0037: ldarg.0
    IL_0038: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_003d: ret

