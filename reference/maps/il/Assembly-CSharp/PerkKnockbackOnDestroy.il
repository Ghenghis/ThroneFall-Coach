// ===== PerkKnockbackOnDestroy  (token 0x02000115) =====
  .method PerkKnockbackOnDestroy::OnEnable()  // token 0x060005BC rva 0x187a1 attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Hp PerkKnockbackOnDestroy::hp  /*0x04000725*/
    IL_0006: dup
    IL_0007: brtrue.s IL_000b
    IL_0009: pop
    IL_000a: ret
    IL_000b: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_0010: ldarg.0
    IL_0011: ldftn void PerkKnockbackOnDestroy::ApplyKnockback()  /*0x060005BF*/
    IL_0017: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_001c: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0021: ret

  .method PerkKnockbackOnDestroy::Start()  // token 0x060005BD rva 0x187c4 attrs Private, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkKnockbackOnDestroy::requiredEquippable  /*0x04000724*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brtrue.s IL_0013
    IL_000d: ldarg.0
    IL_000e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0013: ret

  .method PerkKnockbackOnDestroy::OnDisable()  // token 0x060005BE rva 0x187d9 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Hp PerkKnockbackOnDestroy::hp  /*0x04000725*/
    IL_0006: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_000b: ldarg.0
    IL_000c: ldftn void PerkKnockbackOnDestroy::ApplyKnockback()  /*0x060005BF*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)  /*0x0A0000B2*/
    IL_001c: ret

  .method PerkKnockbackOnDestroy::ApplyKnockback()  // token 0x060005BF rva 0x187f8 attrs Private, HideBySig
    // code size 97 (0x61), max stack 12, init locals
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: ldarg.0
    IL_0006: ldfld List<TagManager.ETag> PerkKnockbackOnDestroy::mustHaveTags  /*0x0400072E*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<TagManager.ETag> PerkKnockbackOnDestroy::mayNotHaveTags  /*0x0400072F*/
    IL_0011: ldarg.0
    IL_0012: ldfld Transform PerkKnockbackOnDestroy::facer  /*0x0400072C*/
    IL_0017: ldarg.0
    IL_0018: ldfld float PerkKnockbackOnDestroy::depth  /*0x04000728*/
    IL_001d: ldarg.0
    IL_001e: ldfld float PerkKnockbackOnDestroy::depth  /*0x04000728*/
    IL_0023: ldarg.0
    IL_0024: ldfld float PerkKnockbackOnDestroy::maxForce  /*0x04000726*/
    IL_0029: ldarg.0
    IL_002a: ldfld float PerkKnockbackOnDestroy::width  /*0x04000729*/
    IL_002f: ldarg.0
    IL_0030: ldfld float PerkKnockbackOnDestroy::depth  /*0x04000728*/
    IL_0035: ldarg.0
    IL_0036: ldfld float PerkKnockbackOnDestroy::offset  /*0x0400072A*/
    IL_003b: ldarg.0
    IL_003c: ldfld int PerkKnockbackOnDestroy::maxEdgeAngle  /*0x0400072B*/
    IL_0041: conv.r4
    IL_0042: ldarg.0
    IL_0043: ldfld bool PerkKnockbackOnDestroy::invertedForward  /*0x04000727*/
    IL_0048: call KnockbackUtils.KnockbackData KnockbackUtils.KnockbackData::Linear(TagManager,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,UnityEngine.Transform,float,float,float,float,float,float,float,bool)  /*0x060013BD*/
    IL_004d: ldnull
    IL_004e: ldarg.0
    IL_004f: ldftn void PerkKnockbackOnDestroy::ApplyEffects()  /*0x060005C0*/
    IL_0055: newobj void System.Action::.ctor(object,IntPtr)  /*0x0A0000E8*/
    IL_005a: call bool KnockbackUtils::ApplyKnockback(KnockbackUtils.KnockbackData,System.Action,System.Action)  /*0x060013B2*/
    IL_005f: pop
    IL_0060: ret

  .method PerkKnockbackOnDestroy::ApplyEffects()  // token 0x060005C0 rva 0x18868 attrs Private, HideBySig
    // code size 149 (0x95), max stack 4, init locals
    .locals ([0] ParticleSystem.ShapeModule)
    IL_0000: ldarg.0
    IL_0001: ldfld ParticleSystem PerkKnockbackOnDestroy::knockbackEffect  /*0x0400072D*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld ParticleSystem PerkKnockbackOnDestroy::knockbackEffect  /*0x0400072D*/
    IL_0015: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001a: ldc.r4 0f
    IL_001f: ldarg.0
    IL_0020: ldfld Transform PerkKnockbackOnDestroy::facer  /*0x0400072C*/
    IL_0025: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002a: callvirt Vector3 UnityEngine.Transform::get_eulerAngles()  /*0x0A000265*/
    IL_002f: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0034: ldc.r4 0f
    IL_0039: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_003e: callvirt void UnityEngine.Transform::set_eulerAngles(UnityEngine.Vector3)  /*0x0A000266*/
    IL_0043: ldarg.0
    IL_0044: ldfld ParticleSystem PerkKnockbackOnDestroy::knockbackEffect  /*0x0400072D*/
    IL_0049: callvirt ParticleSystem.ShapeModule UnityEngine.ParticleSystem::get_shape()  /*0x0A0000E9*/
    IL_004e: stloc.0
    IL_004f: ldloca.s 0
    IL_0051: ldarg.0
    IL_0052: ldfld float PerkKnockbackOnDestroy::width  /*0x04000729*/
    IL_0057: ldc.r4 2f
    IL_005c: div
    IL_005d: call void UnityEngine.ParticleSystem.ShapeModule::set_radius(float)  /*0x0A000267*/
    IL_0062: ldloca.s 0
    IL_0064: ldc.r4 90f
    IL_0069: ldarg.0
    IL_006a: ldfld bool PerkKnockbackOnDestroy::invertedForward  /*0x04000727*/
    IL_006f: brtrue.s IL_0074
    IL_0071: ldc.i4.0
    IL_0072: br.s IL_0079
    IL_0074: ldc.i4 180
    IL_0079: conv.r4
    IL_007a: ldc.r4 0f
    IL_007f: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0084: call void UnityEngine.ParticleSystem.ShapeModule::set_rotation(UnityEngine.Vector3)  /*0x0A0000EB*/
    IL_0089: ldarg.0
    IL_008a: ldfld ParticleSystem PerkKnockbackOnDestroy::knockbackEffect  /*0x0400072D*/
    IL_008f: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_0094: ret

  .method PerkKnockbackOnDestroy::.ctor()  // token 0x060005C1 rva 0x18909 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 48 (0x30), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 30f
    IL_0006: stfld float PerkKnockbackOnDestroy::depth  /*0x04000728*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 30f
    IL_0011: stfld float PerkKnockbackOnDestroy::width  /*0x04000729*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 10f
    IL_001c: stfld float PerkKnockbackOnDestroy::offset  /*0x0400072A*/
    IL_0021: ldarg.0
    IL_0022: ldc.i4.s 10
    IL_0024: stfld int PerkKnockbackOnDestroy::maxEdgeAngle  /*0x0400072B*/
    IL_0029: ldarg.0
    IL_002a: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_002f: ret

