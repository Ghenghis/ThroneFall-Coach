// ===== TagManager  (token 0x02000299) =====
  .method TagManager::get_PlayerUnits()  // token 0x06000E52 rva 0x3fd05 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<TaggedObject> TagManager::bufferedPlayerUnits  /*0x0400108F*/
    IL_0006: callvirt ReadOnlyCollection<!0> System.Collections.Generic.List<TaggedObject>::AsReadOnly()  /*0x0A0005C8*/
    IL_000b: ret

  .method TagManager::get_EnemyUnits()  // token 0x06000E53 rva 0x3fd12 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<TaggedObject> TagManager::bufferedEnemyUnits  /*0x04001090*/
    IL_0006: callvirt ReadOnlyCollection<!0> System.Collections.Generic.List<TaggedObject>::AsReadOnly()  /*0x0A0005C8*/
    IL_000b: ret

  .method TagManager::get_Players()  // token 0x06000E54 rva 0x3fd1f attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<TaggedObject> TagManager::bufferedPlayers  /*0x04001091*/
    IL_0006: callvirt ReadOnlyCollection<!0> System.Collections.Generic.List<TaggedObject>::AsReadOnly()  /*0x0A0005C8*/
    IL_000b: ret

  .method TagManager::OnEnable()  // token 0x06000E55 rva 0x3fd2c attrs Private, HideBySig
    // code size 66 (0x42), max stack 3, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: stsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: ldarg.0
    IL_0007: newobj void System.Collections.Generic.Dictionary<TagManager.ETag, System.Collections.Generic.List<TaggedObject>>::.ctor()  /*0x0A0005C9*/
    IL_000c: stfld Dictionary<TagManager.ETag, List<TaggedObject>> TagManager::dictonaryOfListsOfTaggedObjects  /*0x0400108D*/
    IL_0011: ldc.i4.0
    IL_0012: stloc.0
    IL_0013: br.s IL_002a
    IL_0015: ldarg.0
    IL_0016: ldfld Dictionary<TagManager.ETag, List<TaggedObject>> TagManager::dictonaryOfListsOfTaggedObjects  /*0x0400108D*/
    IL_001b: ldloc.0
    IL_001c: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0021: callvirt void System.Collections.Generic.Dictionary<TagManager.ETag, System.Collections.Generic.List<TaggedObject>>::Add(!0,!1)  /*0x0A0005CA*/
    IL_0026: ldloc.0
    IL_0027: ldc.i4.1
    IL_0028: add
    IL_0029: stloc.0
    IL_002a: ldloc.0
    IL_002b: ldtoken TagManager.ETag  /*0x0200029A*/
    IL_0030: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_0035: call Array System.Enum::GetValues(System.Type)  /*0x0A00034E*/
    IL_003a: callvirt int System.Array::get_Length()  /*0x0A00034F*/
    IL_003f: blt.s IL_0015
    IL_0041: ret

  .method TagManager::AddTaggedObject(TaggedObject)  // token 0x06000E56 rva 0x3fd7c attrs Public, HideBySig
    // code size 104 (0x68), max stack 3, init locals
    .locals ([0] List.Enumerator<TagManager.ETag>, [1] TagManager.ETag)
    IL_0000: ldarg.1
    IL_0001: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<TagManager.ETag>::GetEnumerator()  /*0x0A0001D3*/
    IL_000b: stloc.0
    IL_000c: br.s IL_004e
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<TagManager.ETag>::get_Current()  /*0x0A0001D4*/
    IL_0015: stloc.1
    IL_0016: ldarg.0
    IL_0017: ldarg.1
    IL_0018: ldloc.1
    IL_0019: call void TagManager::AddTag(TaggedObject,TagManager.ETag)  /*0x06000E58*/
    IL_001e: ldloc.1
    IL_001f: ldc.i4.1
    IL_0020: bne.un.s IL_002e
    IL_0022: ldarg.0
    IL_0023: ldfld List<TaggedObject> TagManager::bufferedEnemyUnits  /*0x04001090*/
    IL_0028: ldarg.1
    IL_0029: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_002e: ldloc.1
    IL_002f: ldc.i4.7
    IL_0030: bne.un.s IL_003e
    IL_0032: ldarg.0
    IL_0033: ldfld List<TaggedObject> TagManager::bufferedPlayerUnits  /*0x0400108F*/
    IL_0038: ldarg.1
    IL_0039: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_003e: ldloc.1
    IL_003f: ldc.i4.2
    IL_0040: bne.un.s IL_004e
    IL_0042: ldarg.0
    IL_0043: ldfld List<TaggedObject> TagManager::bufferedPlayers  /*0x04001091*/
    IL_0048: ldarg.1
    IL_0049: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_004e: ldloca.s 0
    IL_0050: call bool System.Collections.Generic.List.Enumerator<TagManager.ETag>::MoveNext()  /*0x0A0001D5*/
    IL_0055: brtrue.s IL_000e
    IL_0057: leave.s IL_0067
    IL_0059: ldloca.s 0
    IL_005b: constrained. System.Collections.Generic.List.Enumerator<TagManager.ETag>  /*0x1B000041*/
    IL_0061: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0066: endfinally
    IL_0067: ret
    .try IL_000c-IL_0059 finally handler IL_0059-IL_0067

  .method TagManager::RemoveTaggedObject(TaggedObject)  // token 0x06000E57 rva 0x3fe00 attrs Public, HideBySig
    // code size 110 (0x6e), max stack 3, init locals
    .locals ([0] List.Enumerator<TagManager.ETag>, [1] TagManager.ETag)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TaggedObject> TagManager::bufferedEnemyUnits  /*0x04001090*/
    IL_0006: ldarg.1
    IL_0007: callvirt bool System.Collections.Generic.List<TaggedObject>::Contains(!0)  /*0x0A00021D*/
    IL_000c: brfalse.s IL_001b
    IL_000e: ldarg.0
    IL_000f: ldfld List<TaggedObject> TagManager::bufferedEnemyUnits  /*0x04001090*/
    IL_0014: ldarg.1
    IL_0015: callvirt bool System.Collections.Generic.List<TaggedObject>::Remove(!0)  /*0x0A0005CB*/
    IL_001a: pop
    IL_001b: ldarg.0
    IL_001c: ldfld List<TaggedObject> TagManager::bufferedPlayerUnits  /*0x0400108F*/
    IL_0021: ldarg.1
    IL_0022: callvirt bool System.Collections.Generic.List<TaggedObject>::Contains(!0)  /*0x0A00021D*/
    IL_0027: brfalse.s IL_0036
    IL_0029: ldarg.0
    IL_002a: ldfld List<TaggedObject> TagManager::bufferedPlayerUnits  /*0x0400108F*/
    IL_002f: ldarg.1
    IL_0030: callvirt bool System.Collections.Generic.List<TaggedObject>::Remove(!0)  /*0x0A0005CB*/
    IL_0035: pop
    IL_0036: ldarg.1
    IL_0037: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_003c: callvirt List.Enumerator<!0> System.Collections.Generic.List<TagManager.ETag>::GetEnumerator()  /*0x0A0001D3*/
    IL_0041: stloc.0
    IL_0042: br.s IL_0054
    IL_0044: ldloca.s 0
    IL_0046: call !0 System.Collections.Generic.List.Enumerator<TagManager.ETag>::get_Current()  /*0x0A0001D4*/
    IL_004b: stloc.1
    IL_004c: ldarg.0
    IL_004d: ldarg.1
    IL_004e: ldloc.1
    IL_004f: call void TagManager::RemoveTag(TaggedObject,TagManager.ETag)  /*0x06000E59*/
    IL_0054: ldloca.s 0
    IL_0056: call bool System.Collections.Generic.List.Enumerator<TagManager.ETag>::MoveNext()  /*0x0A0001D5*/
    IL_005b: brtrue.s IL_0044
    IL_005d: leave.s IL_006d
    IL_005f: ldloca.s 0
    IL_0061: constrained. System.Collections.Generic.List.Enumerator<TagManager.ETag>  /*0x1B000041*/
    IL_0067: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_006c: endfinally
    IL_006d: ret
    .try IL_0042-IL_005f finally handler IL_005f-IL_006d

  .method TagManager::AddTag(TaggedObject,TagManager.ETag)  // token 0x06000E58 rva 0x3fe8c attrs Public, HideBySig
    // code size 30 (0x1e), max stack 2, init locals
    .locals ([0] List<TaggedObject>)
    IL_0000: ldarg.0
    IL_0001: ldfld Dictionary<TagManager.ETag, List<TaggedObject>> TagManager::dictonaryOfListsOfTaggedObjects  /*0x0400108D*/
    IL_0006: ldarg.2
    IL_0007: callvirt !1 System.Collections.Generic.Dictionary<TagManager.ETag, System.Collections.Generic.List<TaggedObject>>::get_Item(!0)  /*0x0A0005CC*/
    IL_000c: stloc.0
    IL_000d: ldloc.0
    IL_000e: ldarg.1
    IL_000f: callvirt bool System.Collections.Generic.List<TaggedObject>::Contains(!0)  /*0x0A00021D*/
    IL_0014: brtrue.s IL_001d
    IL_0016: ldloc.0
    IL_0017: ldarg.1
    IL_0018: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_001d: ret

  .method TagManager::RemoveTag(TaggedObject,TagManager.ETag)  // token 0x06000E59 rva 0x3feb8 attrs Public, HideBySig
    // code size 31 (0x1f), max stack 2, init locals
    .locals ([0] List<TaggedObject>)
    IL_0000: ldarg.0
    IL_0001: ldfld Dictionary<TagManager.ETag, List<TaggedObject>> TagManager::dictonaryOfListsOfTaggedObjects  /*0x0400108D*/
    IL_0006: ldarg.2
    IL_0007: callvirt !1 System.Collections.Generic.Dictionary<TagManager.ETag, System.Collections.Generic.List<TaggedObject>>::get_Item(!0)  /*0x0A0005CC*/
    IL_000c: stloc.0
    IL_000d: ldloc.0
    IL_000e: ldarg.1
    IL_000f: callvirt bool System.Collections.Generic.List<TaggedObject>::Contains(!0)  /*0x0A00021D*/
    IL_0014: brfalse.s IL_001e
    IL_0016: ldloc.0
    IL_0017: ldarg.1
    IL_0018: callvirt bool System.Collections.Generic.List<TaggedObject>::Remove(!0)  /*0x0A0005CB*/
    IL_001d: pop
    IL_001e: ret

  .method TagManager::CountObjectsWithTag(TagManager.ETag)  // token 0x06000E5A rva 0x3fee3 attrs Public, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Dictionary<TagManager.ETag, List<TaggedObject>> TagManager::dictonaryOfListsOfTaggedObjects  /*0x0400108D*/
    IL_0006: ldarg.1
    IL_0007: callvirt !1 System.Collections.Generic.Dictionary<TagManager.ETag, System.Collections.Generic.List<TaggedObject>>::get_Item(!0)  /*0x0A0005CC*/
    IL_000c: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0011: ret

  .method TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  // token 0x06000E5B rva 0x3fef8 attrs Public, HideBySig
    // code size 264 (0x108), max stack 4, init locals
    .locals ([0] List<TaggedObject>, [1] int, [2] long, [3] long, [4] bool, [5] int, [6] List<TaggedObject>, [7] TagManager.ETag, [8] int, [9] TagManager.ETag, [10] int, [11] TaggedObject, [12] bool)
    IL_0000: ldarg.1
    IL_0001: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_0006: ldarg.2
    IL_0007: callvirt int System.Collections.Generic.List<TagManager.ETag>::get_Count()  /*0x0A00019C*/
    IL_000c: ldc.i4.0
    IL_000d: bgt.s IL_0010
    IL_000f: ret
    IL_0010: ldnull
    IL_0011: stloc.0
    IL_0012: ldc.i4 2147483647
    IL_0017: stloc.1
    IL_0018: ldc.i4.0
    IL_0019: conv.i8
    IL_001a: stloc.2
    IL_001b: ldc.i4.0
    IL_001c: stloc.s 5
    IL_001e: br.s IL_0065
    IL_0020: ldarg.0
    IL_0021: ldfld Dictionary<TagManager.ETag, List<TaggedObject>> TagManager::dictonaryOfListsOfTaggedObjects  /*0x0400108D*/
    IL_0026: ldarg.2
    IL_0027: ldloc.s 5
    IL_0029: callvirt !0 System.Collections.Generic.List<TagManager.ETag>::get_Item(int)  /*0x0A00019B*/
    IL_002e: callvirt !1 System.Collections.Generic.Dictionary<TagManager.ETag, System.Collections.Generic.List<TaggedObject>>::get_Item(!0)  /*0x0A0005CC*/
    IL_0033: stloc.s 6
    IL_0035: ldloc.s 6
    IL_0037: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_003c: ldloc.1
    IL_003d: bge.s IL_004a
    IL_003f: ldloc.s 6
    IL_0041: stloc.0
    IL_0042: ldloc.s 6
    IL_0044: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0049: stloc.1
    IL_004a: ldarg.2
    IL_004b: ldloc.s 5
    IL_004d: callvirt !0 System.Collections.Generic.List<TagManager.ETag>::get_Item(int)  /*0x0A00019B*/
    IL_0052: stloc.s 7
    IL_0054: ldloc.2
    IL_0055: ldc.i4.1
    IL_0056: conv.i8
    IL_0057: ldloc.s 7
    IL_0059: ldc.i4.s 63
    IL_005b: and
    IL_005c: shl
    IL_005d: or
    IL_005e: stloc.2
    IL_005f: ldloc.s 5
    IL_0061: ldc.i4.1
    IL_0062: add
    IL_0063: stloc.s 5
    IL_0065: ldloc.s 5
    IL_0067: ldarg.2
    IL_0068: callvirt int System.Collections.Generic.List<TagManager.ETag>::get_Count()  /*0x0A00019C*/
    IL_006d: blt.s IL_0020
    IL_006f: ldloc.0
    IL_0070: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0075: brtrue.s IL_0078
    IL_0077: ret
    IL_0078: ldc.i4.0
    IL_0079: conv.i8
    IL_007a: stloc.3
    IL_007b: ldc.i4.0
    IL_007c: stloc.s 4
    IL_007e: ldarg.3
    IL_007f: brfalse.s IL_00b7
    IL_0081: ldarg.3
    IL_0082: callvirt int System.Collections.Generic.List<TagManager.ETag>::get_Count()  /*0x0A00019C*/
    IL_0087: ldc.i4.0
    IL_0088: ble.s IL_00b7
    IL_008a: ldc.i4.1
    IL_008b: stloc.s 4
    IL_008d: ldc.i4.0
    IL_008e: stloc.s 8
    IL_0090: br.s IL_00ad
    IL_0092: ldarg.3
    IL_0093: ldloc.s 8
    IL_0095: callvirt !0 System.Collections.Generic.List<TagManager.ETag>::get_Item(int)  /*0x0A00019B*/
    IL_009a: stloc.s 9
    IL_009c: ldloc.3
    IL_009d: ldc.i4.1
    IL_009e: conv.i8
    IL_009f: ldloc.s 9
    IL_00a1: ldc.i4.s 63
    IL_00a3: and
    IL_00a4: shl
    IL_00a5: or
    IL_00a6: stloc.3
    IL_00a7: ldloc.s 8
    IL_00a9: ldc.i4.1
    IL_00aa: add
    IL_00ab: stloc.s 8
    IL_00ad: ldloc.s 8
    IL_00af: ldarg.3
    IL_00b0: callvirt int System.Collections.Generic.List<TagManager.ETag>::get_Count()  /*0x0A00019C*/
    IL_00b5: blt.s IL_0092
    IL_00b7: ldc.i4.0
    IL_00b8: stloc.s 10
    IL_00ba: br.s IL_00fd
    IL_00bc: ldloc.0
    IL_00bd: ldloc.s 10
    IL_00bf: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_00c4: stloc.s 11
    IL_00c6: ldc.i4.1
    IL_00c7: stloc.s 12
    IL_00c9: ldloc.s 11
    IL_00cb: callvirt long TaggedObject::get_TagBitfield()  /*0x06000E40*/
    IL_00d0: ldloc.2
    IL_00d1: and
    IL_00d2: ldloc.2
    IL_00d3: ceq
    IL_00d5: stloc.s 12
    IL_00d7: ldloc.s 4
    IL_00d9: brfalse.s IL_00eb
    IL_00db: ldloc.s 11
    IL_00dd: callvirt long TaggedObject::get_TagBitfield()  /*0x06000E40*/
    IL_00e2: ldloc.3
    IL_00e3: and
    IL_00e4: ldc.i4.0
    IL_00e5: conv.i8
    IL_00e6: ble.s IL_00eb
    IL_00e8: ldc.i4.0
    IL_00e9: stloc.s 12
    IL_00eb: ldloc.s 12
    IL_00ed: brfalse.s IL_00f7
    IL_00ef: ldarg.1
    IL_00f0: ldloc.s 11
    IL_00f2: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_00f7: ldloc.s 10
    IL_00f9: ldc.i4.1
    IL_00fa: add
    IL_00fb: stloc.s 10
    IL_00fd: ldloc.s 10
    IL_00ff: ldloc.0
    IL_0100: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0105: blt.s IL_00bc
    IL_0107: ret

  .method TagManager::FindAllTaggedObjectsWithTag(System.Collections.Generic.List<TaggedObject>,TagManager.ETag)  // token 0x06000E5C rva 0x4000c attrs Public, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.1
    IL_0001: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_0006: ldarg.1
    IL_0007: ldarg.0
    IL_0008: ldfld Dictionary<TagManager.ETag, List<TaggedObject>> TagManager::dictonaryOfListsOfTaggedObjects  /*0x0400108D*/
    IL_000d: ldarg.2
    IL_000e: callvirt !1 System.Collections.Generic.Dictionary<TagManager.ETag, System.Collections.Generic.List<TaggedObject>>::get_Item(!0)  /*0x0A0005CC*/
    IL_0013: callvirt void System.Collections.Generic.List<TaggedObject>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000285*/
    IL_0018: ret

  .method TagManager::FindAllTaggedObjectsWithTagDirect_UseWithCare(TagManager.ETag)  // token 0x06000E5D rva 0x40026 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Dictionary<TagManager.ETag, List<TaggedObject>> TagManager::dictonaryOfListsOfTaggedObjects  /*0x0400108D*/
    IL_0006: ldarg.1
    IL_0007: callvirt !1 System.Collections.Generic.Dictionary<TagManager.ETag, System.Collections.Generic.List<TaggedObject>>::get_Item(!0)  /*0x0A0005CC*/
    IL_000c: ret

  .method TagManager::FindClosestTaggedObjectWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  // token 0x06000E5E rva 0x40034 attrs Public, HideBySig
    // code size 161 (0xa1), max stack 4, init locals
    .locals ([0] TaggedObject, [1] int, [2] float, [3] float, [4] int, [5] TaggedObject, [6] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0006: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0012: ldarg.2
    IL_0013: ldarg.3
    IL_0014: call void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0019: ldnull
    IL_001a: stloc.0
    IL_001b: ldarg.0
    IL_001c: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0021: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0026: stloc.1
    IL_0027: ldc.r4 3.4028235E+38f
    IL_002c: stloc.2
    IL_002d: ldc.i4.0
    IL_002e: stloc.s 4
    IL_0030: br.s IL_009a
    IL_0032: ldarg.0
    IL_0033: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0038: ldloc.s 4
    IL_003a: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_003f: stloc.s 5
    IL_0041: ldloc.s 5
    IL_0043: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0048: ldnull
    IL_0049: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_004e: brfalse.s IL_006f
    IL_0050: ldloc.s 5
    IL_0052: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0057: ldarg.1
    IL_0058: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_005d: ldarg.1
    IL_005e: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0063: stloc.s 6
    IL_0065: ldloca.s 6
    IL_0067: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_006c: stloc.3
    IL_006d: br.s IL_008b
    IL_006f: ldloc.s 5
    IL_0071: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0076: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_007b: ldarg.1
    IL_007c: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0081: stloc.s 6
    IL_0083: ldloca.s 6
    IL_0085: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_008a: stloc.3
    IL_008b: ldloc.3
    IL_008c: ldloc.2
    IL_008d: bge.un.s IL_0094
    IL_008f: ldloc.3
    IL_0090: stloc.2
    IL_0091: ldloc.s 5
    IL_0093: stloc.0
    IL_0094: ldloc.s 4
    IL_0096: ldc.i4.1
    IL_0097: add
    IL_0098: stloc.s 4
    IL_009a: ldloc.s 4
    IL_009c: ldloc.1
    IL_009d: blt.s IL_0032
    IL_009f: ldloc.0
    IL_00a0: ret

  .method TagManager::FindClosestTaggedObjectsWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,TaggedObject[],float)  // token 0x06000E5F rva 0x400e4 attrs Public, HideBySig
    // code size 229 (0xe5), max stack 4, init locals
    .locals ([0] int, [1] TagManager.DistanceEntry[], [2] int, [3] int, [4] int, [5] int, [6] float, [7] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.s 4
    IL_0003: br.s IL_0011
    IL_0005: ldarg.s 4
    IL_0007: ldloc.s 4
    IL_0009: ldnull
    IL_000a: stelem.ref
    IL_000b: ldloc.s 4
    IL_000d: ldc.i4.1
    IL_000e: add
    IL_000f: stloc.s 4
    IL_0011: ldloc.s 4
    IL_0013: ldarg.s 4
    IL_0015: ldlen
    IL_0016: conv.i4
    IL_0017: blt.s IL_0005
    IL_0019: ldarg.0
    IL_001a: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_001f: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_0024: ldarg.0
    IL_0025: ldarg.0
    IL_0026: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_002b: ldarg.2
    IL_002c: ldarg.3
    IL_002d: call void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0032: ldarg.0
    IL_0033: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0038: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_003d: stloc.0
    IL_003e: ldloc.0
    IL_003f: brtrue.s IL_0042
    IL_0041: ret
    IL_0042: ldloc.0
    IL_0043: call TagManager.DistanceEntry[] TagManager.TempDistanceBuffer::Allocate(int)  /*0x06000E68*/
    IL_0048: stloc.1
    IL_0049: ldc.i4.0
    IL_004a: stloc.2
    IL_004b: ldc.i4.0
    IL_004c: stloc.s 5
    IL_004e: br.s IL_00a0
    IL_0050: ldarg.0
    IL_0051: ldarg.0
    IL_0052: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0057: ldloc.s 5
    IL_0059: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_005e: ldarg.1
    IL_005f: call float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_0064: stloc.s 6
    IL_0066: ldloc.s 6
    IL_0068: ldarg.s 5
    IL_006a: bgt.un.s IL_009a
    IL_006c: ldloc.1
    IL_006d: ldloc.2
    IL_006e: ldelema TagManager.DistanceEntry  /*0x0200029B*/
    IL_0073: ldarg.0
    IL_0074: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0079: ldloc.s 5
    IL_007b: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0080: stfld TaggedObject TagManager.DistanceEntry::taggedObject  /*0x040010CB*/
    IL_0085: ldloc.1
    IL_0086: ldloc.2
    IL_0087: ldelema TagManager.DistanceEntry  /*0x0200029B*/
    IL_008c: ldloc.s 6
    IL_008e: ldloc.s 6
    IL_0090: mul
    IL_0091: stfld float TagManager.DistanceEntry::distanceSqr  /*0x040010CC*/
    IL_0096: ldloc.2
    IL_0097: ldc.i4.1
    IL_0098: add
    IL_0099: stloc.2
    IL_009a: ldloc.s 5
    IL_009c: ldc.i4.1
    IL_009d: add
    IL_009e: stloc.s 5
    IL_00a0: ldloc.s 5
    IL_00a2: ldloc.0
    IL_00a3: blt.s IL_0050
    IL_00a5: ldloc.2
    IL_00a6: ldc.i4.1
    IL_00a7: ble.s IL_00b0
    IL_00a9: ldloc.1
    IL_00aa: ldloc.2
    IL_00ab: call void TagManager.TempDistanceBuffer::Sort(TagManager.DistanceEntry[],int)  /*0x06000E69*/
    IL_00b0: ldarg.s 4
    IL_00b2: ldlen
    IL_00b3: conv.i4
    IL_00b4: ldloc.2
    IL_00b5: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_00ba: stloc.3
    IL_00bb: ldc.i4.0
    IL_00bc: stloc.s 7
    IL_00be: br.s IL_00d8
    IL_00c0: ldarg.s 4
    IL_00c2: ldloc.s 7
    IL_00c4: ldloc.1
    IL_00c5: ldloc.s 7
    IL_00c7: ldelema TagManager.DistanceEntry  /*0x0200029B*/
    IL_00cc: ldfld TaggedObject TagManager.DistanceEntry::taggedObject  /*0x040010CB*/
    IL_00d1: stelem.ref
    IL_00d2: ldloc.s 7
    IL_00d4: ldc.i4.1
    IL_00d5: add
    IL_00d6: stloc.s 7
    IL_00d8: ldloc.s 7
    IL_00da: ldloc.3
    IL_00db: blt.s IL_00c0
    IL_00dd: ldloc.1
    IL_00de: ldloc.0
    IL_00df: call void TagManager.TempDistanceBuffer::Free(TagManager.DistanceEntry[],int)  /*0x06000E6A*/
    IL_00e4: ret

  .method TagManager::FindUnsortedTaggedObjectsInRange(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,float)  // token 0x06000E60 rva 0x401d8 attrs Public, HideBySig
    // code size 155 (0x9b), max stack 4, init locals
    .locals ([0] int, [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0006: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0012: ldarg.2
    IL_0013: ldarg.3
    IL_0014: call void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0019: ldarg.0
    IL_001a: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_001f: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0024: stloc.0
    IL_0025: ldc.i4.0
    IL_0026: stloc.1
    IL_0027: br.s IL_0068
    IL_0029: ldarg.0
    IL_002a: ldarg.0
    IL_002b: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0030: ldloc.1
    IL_0031: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0036: ldarg.1
    IL_0037: call float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_003c: ldarg.s 4
    IL_003e: ble.un.s IL_0064
    IL_0040: ldloc.0
    IL_0041: ldc.i4.1
    IL_0042: sub
    IL_0043: stloc.0
    IL_0044: ldloc.1
    IL_0045: ldloc.0
    IL_0046: bge.s IL_0060
    IL_0048: ldarg.0
    IL_0049: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_004e: ldloc.1
    IL_004f: ldarg.0
    IL_0050: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0055: ldloc.0
    IL_0056: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_005b: callvirt void System.Collections.Generic.List<TaggedObject>::set_Item(int,!0)  /*0x0A0005CD*/
    IL_0060: ldloc.1
    IL_0061: ldc.i4.1
    IL_0062: sub
    IL_0063: stloc.1
    IL_0064: ldloc.1
    IL_0065: ldc.i4.1
    IL_0066: add
    IL_0067: stloc.1
    IL_0068: ldloc.1
    IL_0069: ldloc.0
    IL_006a: blt.s IL_0029
    IL_006c: br.s IL_0086
    IL_006e: ldarg.0
    IL_006f: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0074: ldarg.0
    IL_0075: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_007a: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_007f: ldc.i4.1
    IL_0080: sub
    IL_0081: callvirt void System.Collections.Generic.List<TaggedObject>::RemoveAt(int)  /*0x0A000483*/
    IL_0086: ldarg.0
    IL_0087: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_008c: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0091: ldloc.0
    IL_0092: bgt.s IL_006e
    IL_0094: ldarg.0
    IL_0095: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_009a: ret

  .method TagManager::FindFarthestTaggedObjectWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,float)  // token 0x06000E61 rva 0x40280 attrs Public, HideBySig
    // code size 96 (0x60), max stack 4, init locals
    .locals ([0] TaggedObject, [1] float, [2] int, [3] TaggedObject, [4] float)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0006: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0012: ldarg.2
    IL_0013: ldarg.3
    IL_0014: call void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0019: ldnull
    IL_001a: stloc.0
    IL_001b: ldc.r4 -3.4028235E+38f
    IL_0020: stloc.1
    IL_0021: ldc.i4.0
    IL_0022: stloc.2
    IL_0023: br.s IL_0050
    IL_0025: ldarg.0
    IL_0026: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_002b: ldloc.2
    IL_002c: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0031: stloc.3
    IL_0032: ldarg.0
    IL_0033: ldloc.3
    IL_0034: ldarg.1
    IL_0035: call float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_003a: stloc.s 4
    IL_003c: ldloc.s 4
    IL_003e: ldarg.s 4
    IL_0040: bgt.s IL_004c
    IL_0042: ldloc.s 4
    IL_0044: ldloc.1
    IL_0045: ble.un.s IL_004c
    IL_0047: ldloc.s 4
    IL_0049: stloc.1
    IL_004a: ldloc.3
    IL_004b: stloc.0
    IL_004c: ldloc.2
    IL_004d: ldc.i4.1
    IL_004e: add
    IL_004f: stloc.2
    IL_0050: ldloc.2
    IL_0051: ldarg.0
    IL_0052: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0057: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_005c: blt.s IL_0025
    IL_005e: ldloc.0
    IL_005f: ret

  .method TagManager::FindLowestHealthTaggedObjectsWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,TaggedObject[],float,bool)  // token 0x06000E62 rva 0x402ec attrs Public, HideBySig
    // code size 248 (0xf8), max stack 4, init locals
    .locals ([0] int, [1] List.Enumerator<TaggedObject>, [2] TaggedObject, [3] int, [4] float, [5] int, [6] float)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_000d
    IL_0004: ldarg.s 4
    IL_0006: ldloc.0
    IL_0007: ldnull
    IL_0008: stelem.ref
    IL_0009: ldloc.0
    IL_000a: ldc.i4.1
    IL_000b: add
    IL_000c: stloc.0
    IL_000d: ldloc.0
    IL_000e: ldarg.s 4
    IL_0010: ldlen
    IL_0011: conv.i4
    IL_0012: blt.s IL_0004
    IL_0014: ldarg.0
    IL_0015: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_001a: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_001f: ldarg.0
    IL_0020: ldarg.0
    IL_0021: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0026: ldarg.2
    IL_0027: ldarg.3
    IL_0028: call void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_002d: ldarg.0
    IL_002e: ldfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_0033: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0038: stloc.1
    IL_0039: br IL_00db
    IL_003e: ldloca.s 1
    IL_0040: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_0045: stloc.2
    IL_0046: ldarg.0
    IL_0047: ldloc.2
    IL_0048: ldarg.1
    IL_0049: call float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_004e: ldarg.s 5
    IL_0050: bgt IL_00db
    IL_0055: ldarg.s 6
    IL_0057: brfalse.s IL_006b
    IL_0059: ldloc.2
    IL_005a: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_005f: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_0064: ldc.r4 1f
    IL_0069: bge.s IL_00db
    IL_006b: ldc.i4.m1
    IL_006c: stloc.3
    IL_006d: ldc.r4 3.4028235E+38f
    IL_0072: stloc.s 4
    IL_0074: ldc.i4.0
    IL_0075: stloc.s 5
    IL_0077: br.s IL_00af
    IL_0079: ldarg.s 4
    IL_007b: ldloc.s 5
    IL_007d: ldelem.ref
    IL_007e: ldnull
    IL_007f: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0084: brfalse.s IL_008b
    IL_0086: ldloc.s 5
    IL_0088: stloc.3
    IL_0089: br.s IL_00b7
    IL_008b: ldarg.s 4
    IL_008d: ldloc.s 5
    IL_008f: ldelem.ref
    IL_0090: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0095: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_009a: stloc.s 6
    IL_009c: ldloc.s 6
    IL_009e: ldloc.s 4
    IL_00a0: bge.un.s IL_00a9
    IL_00a2: ldloc.s 5
    IL_00a4: stloc.3
    IL_00a5: ldloc.s 6
    IL_00a7: stloc.s 4
    IL_00a9: ldloc.s 5
    IL_00ab: ldc.i4.1
    IL_00ac: add
    IL_00ad: stloc.s 5
    IL_00af: ldloc.s 5
    IL_00b1: ldarg.s 4
    IL_00b3: ldlen
    IL_00b4: conv.i4
    IL_00b5: blt.s IL_0079
    IL_00b7: ldloc.3
    IL_00b8: ldc.i4.m1
    IL_00b9: beq.s IL_00db
    IL_00bb: ldloc.s 4
    IL_00bd: ldloc.2
    IL_00be: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_00c3: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_00c8: bgt.s IL_00d6
    IL_00ca: ldarg.s 4
    IL_00cc: ldloc.3
    IL_00cd: ldelem.ref
    IL_00ce: ldnull
    IL_00cf: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00d4: brfalse.s IL_00db
    IL_00d6: ldarg.s 4
    IL_00d8: ldloc.3
    IL_00d9: ldloc.2
    IL_00da: stelem.ref
    IL_00db: ldloca.s 1
    IL_00dd: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_00e2: brtrue IL_003e
    IL_00e7: leave.s IL_00f7
    IL_00e9: ldloca.s 1
    IL_00eb: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_00f1: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00f6: endfinally
    IL_00f7: ret
    .try IL_0039-IL_00e9 finally handler IL_00e9-IL_00f7

  .method TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  // token 0x06000E63 rva 0x40400 attrs Public, HideBySig
    // code size 67 (0x43), max stack 2, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.1
    IL_0001: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_0029
    IL_000e: ldarg.1
    IL_000f: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0014: ldarg.2
    IL_0015: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_001a: ldarg.2
    IL_001b: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0020: stloc.0
    IL_0021: ldloca.s 0
    IL_0023: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0028: ret
    IL_0029: ldarg.1
    IL_002a: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0034: ldarg.2
    IL_0035: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_003a: stloc.0
    IL_003b: ldloca.s 0
    IL_003d: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0042: ret

  .method TagManager::MeasureDirectionToTaggedObject(TaggedObject,UnityEngine.Vector3)  // token 0x06000E64 rva 0x4044f attrs Public, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_0021
    IL_000e: ldarg.1
    IL_000f: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0014: ldarg.2
    IL_0015: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_001a: ldarg.2
    IL_001b: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0020: ret
    IL_0021: ldarg.1
    IL_0022: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0027: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002c: ldarg.2
    IL_002d: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0032: ret

  .method TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  // token 0x06000E65 rva 0x3fee3 attrs Public, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Dictionary<TagManager.ETag, List<TaggedObject>> TagManager::dictonaryOfListsOfTaggedObjects  /*0x0400108D*/
    IL_0006: ldarg.1
    IL_0007: callvirt !1 System.Collections.Generic.Dictionary<TagManager.ETag, System.Collections.Generic.List<TaggedObject>>::get_Item(!0)  /*0x0A0005CC*/
    IL_000c: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0011: ret

  .method TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag,TagManager.ETag,TagManager.ETag)  // token 0x06000E66 rva 0x40484 attrs Public, HideBySig
    // code size 115 (0x73), max stack 2, init locals
    .locals ([0] int, [1] List.Enumerator<TaggedObject>, [2] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld Dictionary<TagManager.ETag, List<TaggedObject>> TagManager::dictonaryOfListsOfTaggedObjects  /*0x0400108D*/
    IL_0006: ldarg.1
    IL_0007: callvirt !1 System.Collections.Generic.Dictionary<TagManager.ETag, System.Collections.Generic.List<TaggedObject>>::get_Item(!0)  /*0x0A0005CC*/
    IL_000c: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0011: stloc.0
    IL_0012: ldarg.0
    IL_0013: ldfld Dictionary<TagManager.ETag, List<TaggedObject>> TagManager::dictonaryOfListsOfTaggedObjects  /*0x0400108D*/
    IL_0018: ldarg.1
    IL_0019: callvirt !1 System.Collections.Generic.Dictionary<TagManager.ETag, System.Collections.Generic.List<TaggedObject>>::get_Item(!0)  /*0x0A0005CC*/
    IL_001e: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0023: stloc.1
    IL_0024: br.s IL_0058
    IL_0026: ldloca.s 1
    IL_0028: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_002d: stloc.2
    IL_002e: ldarg.2
    IL_002f: ldc.i4.s 39
    IL_0031: beq.s IL_0041
    IL_0033: ldloc.2
    IL_0034: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0039: ldarg.2
    IL_003a: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_003f: brfalse.s IL_0054
    IL_0041: ldarg.3
    IL_0042: ldc.i4.s 39
    IL_0044: beq.s IL_0058
    IL_0046: ldloc.2
    IL_0047: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_004c: ldarg.3
    IL_004d: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0052: brfalse.s IL_0058
    IL_0054: ldloc.0
    IL_0055: ldc.i4.1
    IL_0056: sub
    IL_0057: stloc.0
    IL_0058: ldloca.s 1
    IL_005a: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_005f: brtrue.s IL_0026
    IL_0061: leave.s IL_0071
    IL_0063: ldloca.s 1
    IL_0065: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_006b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0070: endfinally
    IL_0071: ldloc.0
    IL_0072: ret
    .try IL_0024-IL_0063 finally handler IL_0063-IL_0071

  .method TagManager::.ctor()  // token 0x06000E67 rva 0x40514 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 106 (0x6a), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0006: stfld List<TaggedObject> TagManager::tempTaggedObjectList  /*0x0400108E*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0011: stfld List<TaggedObject> TagManager::bufferedPlayerUnits  /*0x0400108F*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_001c: stfld List<TaggedObject> TagManager::bufferedEnemyUnits  /*0x04001090*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0027: stfld List<TaggedObject> TagManager::bufferedPlayers  /*0x04001091*/
    IL_002c: ldarg.0
    IL_002d: newobj void System.Collections.Generic.List<BuildingInteractor>::.ctor()  /*0x0A0005CE*/
    IL_0032: stfld List<BuildingInteractor> TagManager::playerBuildingInteractors  /*0x04001092*/
    IL_0037: ldarg.0
    IL_0038: newobj void System.Collections.Generic.List<Coin>::.ctor()  /*0x0A0005CF*/
    IL_003d: stfld List<Coin> TagManager::freeCoins  /*0x04001093*/
    IL_0042: ldarg.0
    IL_0043: newobj void System.Collections.Generic.List<Coin>::.ctor()  /*0x0A0005CF*/
    IL_0048: stfld List<Coin> TagManager::coins  /*0x04001094*/
    IL_004d: ldarg.0
    IL_004e: newobj void System.Collections.Generic.List<EnergyCore>::.ctor()  /*0x0A0005D0*/
    IL_0053: stfld List<EnergyCore> TagManager::freeEnergyCores  /*0x04001095*/
    IL_0058: ldarg.0
    IL_0059: newobj void System.Collections.Generic.List<EnergyCore>::.ctor()  /*0x0A0005D0*/
    IL_005e: stfld List<EnergyCore> TagManager::energyCores  /*0x04001096*/
    IL_0063: ldarg.0
    IL_0064: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0069: ret

// ===== TagManager/ETag  (token 0x0200029A) =====
// ===== TagManager/DistanceEntry  (token 0x0200029B) =====
// ===== TagManager/TempDistanceBuffer  (token 0x0200029C) =====
  .method TagManager.TempDistanceBuffer::Allocate(int)  // token 0x06000E68 rva 0x4058c attrs Public, Static, HideBySig
    // code size 56 (0x38), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldsfld TagManager.DistanceEntry[] TagManager.TempDistanceBuffer::buffer  /*0x040010CD*/
    IL_0005: ldlen
    IL_0006: conv.i4
    IL_0007: ldarg.0
    IL_0008: bge.s IL_0032
    IL_000a: ldarg.0
    IL_000b: stloc.0
    IL_000c: br.s IL_0012
    IL_000e: ldloc.0
    IL_000f: ldc.i4.2
    IL_0010: mul
    IL_0011: stloc.0
    IL_0012: ldsfld TagManager.DistanceEntry[] TagManager.TempDistanceBuffer::buffer  /*0x040010CD*/
    IL_0017: ldlen
    IL_0018: conv.i4
    IL_0019: ldloc.0
    IL_001a: blt.s IL_000e
    IL_001c: ldloc.0
    IL_001d: newarr TagManager.DistanceEntry  /*0x0200029B*/
    IL_0022: stsfld TagManager.DistanceEntry[] TagManager.TempDistanceBuffer::buffer  /*0x040010CD*/
    IL_0027: ldloc.0
    IL_0028: newarr TagManager.DistanceEntry  /*0x0200029B*/
    IL_002d: stsfld TagManager.DistanceEntry[] TagManager.TempDistanceBuffer::sortBuffer  /*0x040010CE*/
    IL_0032: ldsfld TagManager.DistanceEntry[] TagManager.TempDistanceBuffer::buffer  /*0x040010CD*/
    IL_0037: ret

  .method TagManager.TempDistanceBuffer::Sort(TagManager.DistanceEntry[],int)  // token 0x06000E69 rva 0x405d0 attrs Public, Static, HideBySig
    // code size 78 (0x4e), max stack 4, init locals
    .locals ([0] int, [1] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_001a
    IL_0004: ldsfld TagManager.DistanceEntry[] TagManager.TempDistanceBuffer::sortBuffer  /*0x040010CE*/
    IL_0009: ldloc.0
    IL_000a: ldarg.0
    IL_000b: ldloc.0
    IL_000c: ldelem TagManager.DistanceEntry  /*0x0200029B*/
    IL_0011: stelem TagManager.DistanceEntry  /*0x0200029B*/
    IL_0016: ldloc.0
    IL_0017: ldc.i4.1
    IL_0018: add
    IL_0019: stloc.0
    IL_001a: ldloc.0
    IL_001b: ldarg.1
    IL_001c: blt.s IL_0004
    IL_001e: ldsfld TagManager.DistanceEntry[] TagManager.TempDistanceBuffer::sortBuffer  /*0x040010CE*/
    IL_0023: ldc.i4.0
    IL_0024: ldarg.1
    IL_0025: ldsfld TagManager.TempDistanceBuffer.DistanceComparer TagManager.TempDistanceBuffer.DistanceComparer::Instance  /*0x040010CF*/
    IL_002a: call void System.Array::Sort(!!0[],int,int,System.Collections.Generic.IComparer<!!0>)<TagManager.DistanceEntry>  /*0x2B0000CD*/
    IL_002f: ldc.i4.0
    IL_0030: stloc.1
    IL_0031: br.s IL_0049
    IL_0033: ldarg.0
    IL_0034: ldloc.1
    IL_0035: ldsfld TagManager.DistanceEntry[] TagManager.TempDistanceBuffer::sortBuffer  /*0x040010CE*/
    IL_003a: ldloc.1
    IL_003b: ldelem TagManager.DistanceEntry  /*0x0200029B*/
    IL_0040: stelem TagManager.DistanceEntry  /*0x0200029B*/
    IL_0045: ldloc.1
    IL_0046: ldc.i4.1
    IL_0047: add
    IL_0048: stloc.1
    IL_0049: ldloc.1
    IL_004a: ldarg.1
    IL_004b: blt.s IL_0033
    IL_004d: ret

  .method TagManager.TempDistanceBuffer::Free(TagManager.DistanceEntry[],int)  // token 0x06000E6A rva 0x25f1 attrs Public, Static, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TagManager.TempDistanceBuffer::.cctor()  // token 0x06000E6B rva 0x4062a attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 31 (0x1f), max stack 8
    IL_0000: ldc.i4 256
    IL_0005: newarr TagManager.DistanceEntry  /*0x0200029B*/
    IL_000a: stsfld TagManager.DistanceEntry[] TagManager.TempDistanceBuffer::buffer  /*0x040010CD*/
    IL_000f: ldc.i4 256
    IL_0014: newarr TagManager.DistanceEntry  /*0x0200029B*/
    IL_0019: stsfld TagManager.DistanceEntry[] TagManager.TempDistanceBuffer::sortBuffer  /*0x040010CE*/
    IL_001e: ret

// ===== TagManager/TempDistanceBuffer/DistanceComparer  (token 0x0200029D) =====
  .method TagManager.TempDistanceBuffer.DistanceComparer::Compare(TagManager.DistanceEntry,TagManager.DistanceEntry)  // token 0x06000E6C rva 0x4064a attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 19 (0x13), max stack 8
    IL_0000: ldarga.s 1
    IL_0002: ldflda float TagManager.DistanceEntry::distanceSqr  /*0x040010CC*/
    IL_0007: ldarg.2
    IL_0008: ldfld float TagManager.DistanceEntry::distanceSqr  /*0x040010CC*/
    IL_000d: call int System.Single::CompareTo(float)  /*0x0A000276*/
    IL_0012: ret

  .method TagManager.TempDistanceBuffer.DistanceComparer::.ctor()  // token 0x06000E6D rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method TagManager.TempDistanceBuffer.DistanceComparer::.cctor()  // token 0x06000E6E rva 0x4065e attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void TagManager.TempDistanceBuffer.DistanceComparer::.ctor()  /*0x06000E6D*/
    IL_0005: stsfld TagManager.TempDistanceBuffer.DistanceComparer TagManager.TempDistanceBuffer.DistanceComparer::Instance  /*0x040010CF*/
    IL_000a: ret

