// ===== TempleSacrifice  (token 0x020002B3) =====
  .method TempleSacrifice::EnableEffectAtDusk()  // token 0x06000ED6 rva 0x42cb8 attrs Public, Virtual, HideBySig
    // code size 87 (0x57), max stack 5, init locals
    .locals ([0] IEnumerator<TaggedObject>)
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: callvirt IReadOnlyList<TaggedObject> TagManager::get_PlayerUnits()  /*0x06000E52*/
    IL_000a: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<TaggedObject>::GetEnumerator()  /*0x0A000100*/
    IL_000f: stloc.0
    IL_0010: br.s IL_002b
    IL_0012: ldloc.0
    IL_0013: callvirt !0 System.Collections.Generic.IEnumerator<TaggedObject>::get_Current()  /*0x0A000101*/
    IL_0018: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_001d: ldc.r4 1E+09f
    IL_0022: ldnull
    IL_0023: ldc.i4.0
    IL_0024: ldc.i4.1
    IL_0025: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_002a: pop
    IL_002b: ldloc.0
    IL_002c: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0031: brtrue.s IL_0012
    IL_0033: leave.s IL_003f
    IL_0035: ldloc.0
    IL_0036: brfalse.s IL_003e
    IL_0038: ldloc.0
    IL_0039: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_003e: endfinally
    IL_003f: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0044: dup
    IL_0045: ldfld float BlacksmithUpgrades::unitRespawnSpeedMulti  /*0x04000B84*/
    IL_004a: ldarg.0
    IL_004b: ldfld float TempleSacrifice::unitRespawnSpeedMulti  /*0x0400112A*/
    IL_0050: mul
    IL_0051: stfld float BlacksmithUpgrades::unitRespawnSpeedMulti  /*0x04000B84*/
    IL_0056: ret
    .try IL_0010-IL_0035 finally handler IL_0035-IL_003f

  .method TempleSacrifice::DisableEffectAtDawn()  // token 0x06000ED7 rva 0x42d2c attrs Public, Virtual, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0005: dup
    IL_0006: ldfld float BlacksmithUpgrades::unitRespawnSpeedMulti  /*0x04000B84*/
    IL_000b: ldarg.0
    IL_000c: ldfld float TempleSacrifice::unitRespawnSpeedMulti  /*0x0400112A*/
    IL_0011: div
    IL_0012: stfld float BlacksmithUpgrades::unitRespawnSpeedMulti  /*0x04000B84*/
    IL_0017: ret

  .method TempleSacrifice::.ctor()  // token 0x06000ED8 rva 0x42d45 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 3f
    IL_0006: stfld float TempleSacrifice::unitRespawnSpeedMulti  /*0x0400112A*/
    IL_000b: ldarg.0
    IL_000c: call void TempleUpgrade::.ctor()  /*0x06000EE7*/
    IL_0011: ret

