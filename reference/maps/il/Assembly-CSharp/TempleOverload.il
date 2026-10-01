// ===== TempleOverload  (token 0x020002B0) =====
  .method TempleOverload::EnableEffectAtDusk()  // token 0x06000EC7 rva 0x428c8 attrs Public, Virtual, HideBySig
    // code size 143 (0x8f), max stack 4, init locals
    .locals ([0] List.Enumerator<TaggedObject>)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TagManager.ETag> TempleOverload::mustHaveTags  /*0x04001121*/
    IL_0006: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<TagManager.ETag> TempleOverload::mustHaveTags  /*0x04001121*/
    IL_0011: ldc.i4.s 24
    IL_0013: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0018: ldarg.0
    IL_0019: ldfld List<TagManager.ETag> TempleOverload::mustHaveTags  /*0x04001121*/
    IL_001e: ldc.i4.s 10
    IL_0020: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0025: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_002a: ldarg.0
    IL_002b: ldfld List<TaggedObject> TempleOverload::taggedObjectsTemp  /*0x04001120*/
    IL_0030: ldarg.0
    IL_0031: ldfld List<TagManager.ETag> TempleOverload::mustHaveTags  /*0x04001121*/
    IL_0036: ldarg.0
    IL_0037: ldfld List<TagManager.ETag> TempleOverload::mayNotHaveTags  /*0x04001122*/
    IL_003c: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0041: ldarg.0
    IL_0042: ldc.i4.1
    IL_0043: stfld bool TempleOverload::effectRunning  /*0x04001123*/
    IL_0048: ldarg.0
    IL_0049: ldfld List<TaggedObject> TempleOverload::taggedObjectsTemp  /*0x04001120*/
    IL_004e: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0053: stloc.0
    IL_0054: br.s IL_0075
    IL_0056: ldloca.s 0
    IL_0058: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_005d: ldc.i4.1
    IL_005e: callvirt !!0 UnityEngine.Component::GetComponentInChildren(bool)<AutoAttackTower>  /*0x2B0000D4*/
    IL_0063: dup
    IL_0064: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_0069: ldarg.0
    IL_006a: ldfld float TempleOverload::towerDamageMulti  /*0x0400111F*/
    IL_006f: mul
    IL_0070: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_0075: ldloca.s 0
    IL_0077: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_007c: brtrue.s IL_0056
    IL_007e: leave.s IL_008e
    IL_0080: ldloca.s 0
    IL_0082: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0088: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_008d: endfinally
    IL_008e: ret
    .try IL_0054-IL_0080 finally handler IL_0080-IL_008e

  .method TempleOverload::Update()  // token 0x06000EC8 rva 0x42974 attrs Private, HideBySig
    // code size 138 (0x8a), max stack 5, init locals
    .locals ([0] List.Enumerator<TaggedObject>, [1] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld bool TempleOverload::effectRunning  /*0x04001123*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: ldfld float TempleOverload::timeTillNextTick  /*0x04001124*/
    IL_0010: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0015: sub
    IL_0016: stfld float TempleOverload::timeTillNextTick  /*0x04001124*/
    IL_001b: ldarg.0
    IL_001c: ldfld float TempleOverload::timeTillNextTick  /*0x04001124*/
    IL_0021: ldc.r4 0f
    IL_0026: bgt.un.s IL_0089
    IL_0028: ldarg.0
    IL_0029: ldc.r4 2f
    IL_002e: stfld float TempleOverload::timeTillNextTick  /*0x04001124*/
    IL_0033: ldarg.0
    IL_0034: ldfld List<TaggedObject> TempleOverload::taggedObjectsTemp  /*0x04001120*/
    IL_0039: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_003e: stloc.0
    IL_003f: br.s IL_0070
    IL_0041: ldloca.s 0
    IL_0043: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_0048: stloc.1
    IL_0049: ldloc.1
    IL_004a: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_004f: ldarg.0
    IL_0050: ldfld float TempleOverload::healthPercentageLossPerSec  /*0x0400111E*/
    IL_0055: ldc.r4 2f
    IL_005a: mul
    IL_005b: ldloc.1
    IL_005c: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0061: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0066: mul
    IL_0067: ldnull
    IL_0068: ldc.i4.0
    IL_0069: ldc.i4.1
    IL_006a: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_006f: pop
    IL_0070: ldloca.s 0
    IL_0072: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0077: brtrue.s IL_0041
    IL_0079: leave.s IL_0089
    IL_007b: ldloca.s 0
    IL_007d: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0083: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0088: endfinally
    IL_0089: ret
    .try IL_003f-IL_007b finally handler IL_007b-IL_0089

  .method TempleOverload::DisableEffectAtDawn()  // token 0x06000EC9 rva 0x42a1c attrs Public, Virtual, HideBySig
    // code size 85 (0x55), max stack 3, init locals
    .locals ([0] List.Enumerator<TaggedObject>)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool TempleOverload::effectRunning  /*0x04001123*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.0
    IL_0009: call void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_000e: ldarg.0
    IL_000f: ldfld List<TaggedObject> TempleOverload::taggedObjectsTemp  /*0x04001120*/
    IL_0014: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0019: stloc.0
    IL_001a: br.s IL_003b
    IL_001c: ldloca.s 0
    IL_001e: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_0023: ldc.i4.1
    IL_0024: callvirt !!0 UnityEngine.Component::GetComponentInChildren(bool)<AutoAttackTower>  /*0x2B0000D4*/
    IL_0029: dup
    IL_002a: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_002f: ldarg.0
    IL_0030: ldfld float TempleOverload::towerDamageMulti  /*0x0400111F*/
    IL_0035: div
    IL_0036: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_003b: ldloca.s 0
    IL_003d: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0042: brtrue.s IL_001c
    IL_0044: leave.s IL_0054
    IL_0046: ldloca.s 0
    IL_0048: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_004e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0053: endfinally
    IL_0054: ret
    .try IL_001a-IL_0046 finally handler IL_0046-IL_0054

  .method TempleOverload::.ctor()  // token 0x06000ECA rva 0x42a90 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.01f
    IL_0006: stfld float TempleOverload::healthPercentageLossPerSec  /*0x0400111E*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1.5f
    IL_0011: stfld float TempleOverload::towerDamageMulti  /*0x0400111F*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_001c: stfld List<TaggedObject> TempleOverload::taggedObjectsTemp  /*0x04001120*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0027: stfld List<TagManager.ETag> TempleOverload::mustHaveTags  /*0x04001121*/
    IL_002c: ldarg.0
    IL_002d: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0032: stfld List<TagManager.ETag> TempleOverload::mayNotHaveTags  /*0x04001122*/
    IL_0037: ldarg.0
    IL_0038: call void TempleUpgrade::.ctor()  /*0x06000EE7*/
    IL_003d: ret

