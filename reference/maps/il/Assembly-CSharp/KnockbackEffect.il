// ===== KnockbackEffect  (token 0x020001A4) =====
  .method KnockbackEffect::Effect(Hp,TaggedObject,TaggedObject,Weapon,float,bool,float)  // token 0x06000880 rva 0x29274 attrs Public, Virtual, HideBySig
    // code size 43 (0x2b), max stack 2, init locals
    .locals ([0] GameObject)
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: stfld TagManager KnockbackEffect::tagManager  /*0x04000A9A*/
    IL_000b: ldarg.3
    IL_000c: ldnull
    IL_000d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0012: brtrue.s IL_001c
    IL_0014: ldarg.3
    IL_0015: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001a: br.s IL_0022
    IL_001c: ldarg.1
    IL_001d: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0022: stloc.0
    IL_0023: ldarg.0
    IL_0024: ldloc.0
    IL_0025: call void KnockbackEffect::ApplyDamage(UnityEngine.GameObject)  /*0x06000881*/
    IL_002a: ret

  .method KnockbackEffect::ApplyDamage(UnityEngine.GameObject)  // token 0x06000881 rva 0x292ab attrs Private, HideBySig
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TagManager KnockbackEffect::tagManager  /*0x04000A9A*/
    IL_0006: ldarg.0
    IL_0007: ldfld List<TagManager.ETag> KnockbackEffect::mustHaveTags  /*0x04000A98*/
    IL_000c: ldarg.0
    IL_000d: ldfld List<TagManager.ETag> KnockbackEffect::mayNotHaveTags  /*0x04000A99*/
    IL_0012: ldarg.1
    IL_0013: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0018: ldarg.0
    IL_0019: ldfld float KnockbackEffect::maxRange  /*0x04000A96*/
    IL_001e: ldarg.0
    IL_001f: ldfld float KnockbackEffect::maxRange  /*0x04000A96*/
    IL_0024: ldarg.0
    IL_0025: ldfld float KnockbackEffect::maxForce  /*0x04000A95*/
    IL_002a: ldarg.0
    IL_002b: ldfld int KnockbackEffect::areaAngle  /*0x04000A97*/
    IL_0030: call KnockbackUtils.KnockbackData KnockbackUtils.KnockbackData::Radial(TagManager,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,UnityEngine.Transform,float,float,float,int)  /*0x060013BB*/
    IL_0035: ldnull
    IL_0036: ldnull
    IL_0037: call bool KnockbackUtils::ApplyKnockback(KnockbackUtils.KnockbackData,System.Action,System.Action)  /*0x060013B2*/
    IL_003c: pop
    IL_003d: ret

  .method KnockbackEffect::.ctor()  // token 0x06000882 rva 0x292ea attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 10f
    IL_0006: stfld float KnockbackEffect::maxRange  /*0x04000A96*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4 360
    IL_0011: stfld int KnockbackEffect::areaAngle  /*0x04000A97*/
    IL_0016: ldarg.0
    IL_0017: call void AdditionalWeaponEffectScript::.ctor()  /*0x06000028*/
    IL_001c: ret

