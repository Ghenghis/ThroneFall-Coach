// ===== EmergencyRepairs  (token 0x02000132) =====
  .method EmergencyRepairs::Start()  // token 0x0600065F rva 0x1aae3 attrs Private, HideBySig
    // code size 57 (0x39), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable EmergencyRepairs::requiredEquippable  /*0x040007B2*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brtrue.s IL_0013
    IL_000d: ldarg.0
    IL_000e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0013: ldarg.0
    IL_0014: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0019: stfld TagManager EmergencyRepairs::tagManager  /*0x040007B6*/
    IL_001e: ldarg.0
    IL_001f: ldfld List<TagManager.ETag> EmergencyRepairs::mustHaveTags  /*0x040007B4*/
    IL_0024: ldc.i4.s 12
    IL_0026: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_002b: ldarg.0
    IL_002c: ldfld List<TagManager.ETag> EmergencyRepairs::mustHaveTags  /*0x040007B4*/
    IL_0031: ldc.i4.s 10
    IL_0033: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0038: ret

  .method EmergencyRepairs::Update()  // token 0x06000660 rva 0x1ab20 attrs Private, HideBySig
    // code size 283 (0x11b), max stack 5, init locals
    .locals ([0] float, [1] List.Enumerator<TaggedObject>, [2] TaggedObject, [3] TaggedObject, [4] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float EmergencyRepairs::nextTickIn  /*0x040007B0*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float EmergencyRepairs::nextTickIn  /*0x040007B0*/
    IL_0012: ldarg.0
    IL_0013: ldfld float EmergencyRepairs::nextTickIn  /*0x040007B0*/
    IL_0018: ldc.r4 0f
    IL_001d: bgt.un IL_011a
    IL_0022: ldarg.0
    IL_0023: ldc.r4 2f
    IL_0028: stfld float EmergencyRepairs::nextTickIn  /*0x040007B0*/
    IL_002d: ldarg.0
    IL_002e: ldfld TagManager EmergencyRepairs::tagManager  /*0x040007B6*/
    IL_0033: ldarg.0
    IL_0034: ldfld List<TaggedObject> EmergencyRepairs::walls  /*0x040007B1*/
    IL_0039: ldarg.0
    IL_003a: ldfld List<TagManager.ETag> EmergencyRepairs::mustHaveTags  /*0x040007B4*/
    IL_003f: ldarg.0
    IL_0040: ldfld List<TagManager.ETag> EmergencyRepairs::mayNotHaveTags  /*0x040007B5*/
    IL_0045: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_004a: ldarg.0
    IL_004b: ldfld List<TaggedObject> EmergencyRepairs::walls  /*0x040007B1*/
    IL_0050: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0055: ldc.i4.0
    IL_0056: bgt.s IL_0059
    IL_0058: ret
    IL_0059: ldc.r4 0f
    IL_005e: stloc.0
    IL_005f: ldarg.0
    IL_0060: ldfld List<TaggedObject> EmergencyRepairs::walls  /*0x040007B1*/
    IL_0065: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_006a: stloc.1
    IL_006b: br.s IL_008f
    IL_006d: ldloca.s 1
    IL_006f: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_0074: stloc.2
    IL_0075: ldloc.0
    IL_0076: ldloc.2
    IL_0077: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_007c: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0081: ldloc.2
    IL_0082: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0087: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_008c: sub
    IL_008d: add
    IL_008e: stloc.0
    IL_008f: ldloca.s 1
    IL_0091: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0096: brtrue.s IL_006d
    IL_0098: leave.s IL_00a8
    IL_009a: ldloca.s 1
    IL_009c: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_00a2: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00a7: endfinally
    IL_00a8: ldloc.0
    IL_00a9: ldarg.0
    IL_00aa: ldfld List<TaggedObject> EmergencyRepairs::walls  /*0x040007B1*/
    IL_00af: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_00b4: conv.r4
    IL_00b5: div
    IL_00b6: stloc.0
    IL_00b7: ldarg.0
    IL_00b8: ldfld List<TaggedObject> EmergencyRepairs::walls  /*0x040007B1*/
    IL_00bd: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_00c2: stloc.1
    IL_00c3: br.s IL_0101
    IL_00c5: ldloca.s 1
    IL_00c7: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_00cc: stloc.3
    IL_00cd: ldloc.3
    IL_00ce: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_00d3: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_00d8: ldloc.3
    IL_00d9: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_00de: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_00e3: sub
    IL_00e4: ldloc.0
    IL_00e5: sub
    IL_00e6: ldarg.0
    IL_00e7: ldfld float EmergencyRepairs::healthTransfer  /*0x040007B3*/
    IL_00ec: mul
    IL_00ed: stloc.s 4
    IL_00ef: ldloc.3
    IL_00f0: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_00f5: ldloc.s 4
    IL_00f7: neg
    IL_00f8: ldnull
    IL_00f9: ldc.i4.0
    IL_00fa: ldc.i4.1
    IL_00fb: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0100: pop
    IL_0101: ldloca.s 1
    IL_0103: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0108: brtrue.s IL_00c5
    IL_010a: leave.s IL_011a
    IL_010c: ldloca.s 1
    IL_010e: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0114: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0119: endfinally
    IL_011a: ret
    .try IL_006b-IL_009a finally handler IL_009a-IL_00a8
    .try IL_00c3-IL_010c finally handler IL_010c-IL_011a

  .method EmergencyRepairs::.ctor()  // token 0x06000661 rva 0x1ac64 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1.72f
    IL_0006: stfld float EmergencyRepairs::nextTickIn  /*0x040007B0*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0011: stfld List<TaggedObject> EmergencyRepairs::walls  /*0x040007B1*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.2f
    IL_001c: stfld float EmergencyRepairs::healthTransfer  /*0x040007B3*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0027: stfld List<TagManager.ETag> EmergencyRepairs::mustHaveTags  /*0x040007B4*/
    IL_002c: ldarg.0
    IL_002d: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0032: stfld List<TagManager.ETag> EmergencyRepairs::mayNotHaveTags  /*0x040007B5*/
    IL_0037: ldarg.0
    IL_0038: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_003d: ret

