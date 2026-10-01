// ===== DamageModifyer  (token 0x020000A8) =====
  .method DamageModifyer::AppliesTo(TaggedObject)  // token 0x0600039A rva 0x101f0 attrs Public, HideBySig
    // code size 51 (0x33), max stack 3, init locals
    .locals ([0] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_0023
    IL_0004: ldarg.1
    IL_0005: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_000a: ldarg.0
    IL_000b: ldfld List<TagManager.ETag> DamageModifyer::requiredTags  /*0x040004A6*/
    IL_0010: ldloc.0
    IL_0011: callvirt !0 System.Collections.Generic.List<TagManager.ETag>::get_Item(int)  /*0x0A00019B*/
    IL_0016: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_001b: brtrue.s IL_001f
    IL_001d: ldc.i4.0
    IL_001e: ret
    IL_001f: ldloc.0
    IL_0020: ldc.i4.1
    IL_0021: add
    IL_0022: stloc.0
    IL_0023: ldloc.0
    IL_0024: ldarg.0
    IL_0025: ldfld List<TagManager.ETag> DamageModifyer::requiredTags  /*0x040004A6*/
    IL_002a: callvirt int System.Collections.Generic.List<TagManager.ETag>::get_Count()  /*0x0A00019C*/
    IL_002f: blt.s IL_0004
    IL_0031: ldc.i4.1
    IL_0032: ret

  .method DamageModifyer::CalculateDamageOnTarget(TaggedObject,System.Collections.Generic.List<DamageModifyer>,float)  // token 0x0600039B rva 0x10230 attrs Public, Static, HideBySig
    // code size 62 (0x3e), max stack 2, init locals
    .locals ([0] float, [1] int, [2] DamageModifyer)
    IL_0000: ldc.r4 0f
    IL_0005: stloc.0
    IL_0006: ldc.i4.0
    IL_0007: stloc.1
    IL_0008: br.s IL_0031
    IL_000a: ldarg.1
    IL_000b: ldloc.1
    IL_000c: callvirt !0 System.Collections.Generic.List<DamageModifyer>::get_Item(int)  /*0x0A00019D*/
    IL_0011: stloc.2
    IL_0012: ldloc.2
    IL_0013: ldarg.0
    IL_0014: callvirt bool DamageModifyer::AppliesTo(TaggedObject)  /*0x0600039A*/
    IL_0019: brfalse.s IL_002d
    IL_001b: ldloc.0
    IL_001c: ldloc.2
    IL_001d: ldfld float DamageModifyer::damageAdded  /*0x040004A7*/
    IL_0022: add
    IL_0023: stloc.0
    IL_0024: ldloc.0
    IL_0025: ldloc.2
    IL_0026: ldfld float DamageModifyer::damageMultiplyer  /*0x040004A8*/
    IL_002b: mul
    IL_002c: stloc.0
    IL_002d: ldloc.1
    IL_002e: ldc.i4.1
    IL_002f: add
    IL_0030: stloc.1
    IL_0031: ldloc.1
    IL_0032: ldarg.1
    IL_0033: callvirt int System.Collections.Generic.List<DamageModifyer>::get_Count()  /*0x0A00019E*/
    IL_0038: blt.s IL_000a
    IL_003a: ldloc.0
    IL_003b: ldarg.2
    IL_003c: mul
    IL_003d: ret

  .method DamageModifyer::.ctor()  // token 0x0600039C rva 0x1027a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0006: stfld List<TagManager.ETag> DamageModifyer::requiredTags  /*0x040004A6*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float DamageModifyer::damageMultiplyer  /*0x040004A8*/
    IL_0016: ldarg.0
    IL_0017: call void System.Object::.ctor()  /*0x0A000038*/
    IL_001c: ret

