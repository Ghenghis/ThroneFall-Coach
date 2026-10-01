// ===== TempleWisdom  (token 0x020002B6) =====
  .method TempleWisdom::EnableEffectAtDusk()  // token 0x06000EE8 rva 0x42ee0 attrs Public, Virtual, HideBySig
    // code size 137 (0x89), max stack 4, init locals
    .locals ([0] List.Enumerator<TaggedObject>)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool TempleWisdom::effectRunning  /*0x04001139*/
    IL_0007: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_000c: ldarg.0
    IL_000d: ldfld List<TaggedObject> TempleWisdom::buildings  /*0x04001137*/
    IL_0012: ldc.i4.8
    IL_0013: callvirt void TagManager::FindAllTaggedObjectsWithTag(System.Collections.Generic.List<TaggedObject>,TagManager.ETag)  /*0x06000E5C*/
    IL_0018: ldarg.0
    IL_0019: ldfld List<TaggedObject> TempleWisdom::buildings  /*0x04001137*/
    IL_001e: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0023: stloc.0
    IL_0024: br.s IL_006f
    IL_0026: ldloca.s 0
    IL_0028: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_002d: ldstr "Applied Gold Effect To Building!"
    IL_0032: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_0037: dup
    IL_0038: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_003d: ldarg.0
    IL_003e: ldfld GameObject TempleWisdom::pickupCoin  /*0x04001134*/
    IL_0043: stfld GameObject Hp::coin  /*0x04000A49*/
    IL_0048: dup
    IL_0049: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_004e: dup
    IL_004f: ldfld int Hp::coinCount  /*0x04000A4B*/
    IL_0054: ldarg.0
    IL_0055: ldfld int TempleWisdom::goldForDestroyedBuilding  /*0x04001135*/
    IL_005a: add
    IL_005b: stfld int Hp::coinCount  /*0x04000A4B*/
    IL_0060: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0065: ldc.r4 0.5f
    IL_006a: stfld float Hp::coinSpawnOffset  /*0x04000A4A*/
    IL_006f: ldloca.s 0
    IL_0071: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0076: brtrue.s IL_0026
    IL_0078: leave.s IL_0088
    IL_007a: ldloca.s 0
    IL_007c: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0082: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0087: endfinally
    IL_0088: ret
    .try IL_0024-IL_007a finally handler IL_007a-IL_0088

  .method TempleWisdom::DisableEffectAtDawn()  // token 0x06000EE9 rva 0x42f88 attrs Public, Virtual, HideBySig
    // code size 89 (0x59), max stack 4, init locals
    .locals ([0] List.Enumerator<TaggedObject>)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool TempleWisdom::effectRunning  /*0x04001139*/
    IL_0007: ldarg.0
    IL_0008: ldfld List<TaggedObject> TempleWisdom::buildings  /*0x04001137*/
    IL_000d: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0012: stloc.0
    IL_0013: br.s IL_003f
    IL_0015: ldloca.s 0
    IL_0017: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_001c: dup
    IL_001d: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0022: dup
    IL_0023: ldfld int Hp::coinCount  /*0x04000A4B*/
    IL_0028: ldarg.0
    IL_0029: ldfld int TempleWisdom::goldForDestroyedBuilding  /*0x04001135*/
    IL_002e: sub
    IL_002f: stfld int Hp::coinCount  /*0x04000A4B*/
    IL_0034: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0039: ldnull
    IL_003a: stfld GameObject Hp::coin  /*0x04000A49*/
    IL_003f: ldloca.s 0
    IL_0041: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0046: brtrue.s IL_0015
    IL_0048: leave.s IL_0058
    IL_004a: ldloca.s 0
    IL_004c: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0052: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0057: endfinally
    IL_0058: ret
    .try IL_0013-IL_004a finally handler IL_004a-IL_0058

  .method TempleWisdom::Update()  // token 0x06000EEA rva 0x43000 attrs Private, HideBySig
    // code size 153 (0x99), max stack 5, init locals
    .locals ([0] List.Enumerator<TaggedObject>, [1] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld bool TempleWisdom::effectRunning  /*0x04001139*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: ldfld float TempleWisdom::timeTillNextTick  /*0x04001138*/
    IL_0010: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0015: sub
    IL_0016: stfld float TempleWisdom::timeTillNextTick  /*0x04001138*/
    IL_001b: ldarg.0
    IL_001c: ldfld float TempleWisdom::timeTillNextTick  /*0x04001138*/
    IL_0021: ldc.r4 0f
    IL_0026: bgt.un.s IL_0098
    IL_0028: ldarg.0
    IL_0029: ldc.r4 2f
    IL_002e: stfld float TempleWisdom::timeTillNextTick  /*0x04001138*/
    IL_0033: ldarg.0
    IL_0034: ldfld List<TaggedObject> TempleWisdom::buildings  /*0x04001137*/
    IL_0039: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_003e: stloc.0
    IL_003f: br.s IL_007f
    IL_0041: ldloca.s 0
    IL_0043: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_0048: stloc.1
    IL_0049: ldloc.1
    IL_004a: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_004f: ldc.i4.s 35
    IL_0051: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0056: brtrue.s IL_007f
    IL_0058: ldloc.1
    IL_0059: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_005e: ldarg.0
    IL_005f: ldfld float TempleWisdom::healthPercentageLossPerSec  /*0x04001136*/
    IL_0064: ldc.r4 2f
    IL_0069: mul
    IL_006a: ldloc.1
    IL_006b: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0070: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0075: mul
    IL_0076: ldnull
    IL_0077: ldc.i4.0
    IL_0078: ldc.i4.1
    IL_0079: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_007e: pop
    IL_007f: ldloca.s 0
    IL_0081: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0086: brtrue.s IL_0041
    IL_0088: leave.s IL_0098
    IL_008a: ldloca.s 0
    IL_008c: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0092: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0097: endfinally
    IL_0098: ret
    .try IL_003f-IL_008a finally handler IL_008a-IL_0098

  .method TempleWisdom::.ctor()  // token 0x06000EEB rva 0x430b8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0006: stfld List<TaggedObject> TempleWisdom::buildings  /*0x04001137*/
    IL_000b: ldarg.0
    IL_000c: call void TempleUpgrade::.ctor()  /*0x06000EE7*/
    IL_0011: ret

