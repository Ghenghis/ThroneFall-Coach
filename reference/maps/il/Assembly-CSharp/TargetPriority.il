// ===== TargetPriority  (token 0x0200029E) =====
  .method TargetPriority::FindClosestTaggedObject(UnityEngine.Vector3)  // token 0x06000E6F rva 0x4066c attrs Public, HideBySig
    // code size 117 (0x75), max stack 4, init locals
    .locals ([0] TaggedObject, [1] float, [2] Vector3)
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: ldarg.1
    IL_0006: ldarg.0
    IL_0007: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_000c: ldarg.0
    IL_000d: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_0012: callvirt TaggedObject TagManager::FindClosestTaggedObjectWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5E*/
    IL_0017: stloc.0
    IL_0018: ldloc.0
    IL_0019: ldnull
    IL_001a: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_001f: brfalse.s IL_0023
    IL_0021: ldnull
    IL_0022: ret
    IL_0023: ldloc.0
    IL_0024: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0029: ldnull
    IL_002a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002f: brfalse.s IL_004e
    IL_0031: ldloc.0
    IL_0032: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0037: ldarg.1
    IL_0038: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_003d: ldarg.1
    IL_003e: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0043: stloc.2
    IL_0044: ldloca.s 2
    IL_0046: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_004b: stloc.1
    IL_004c: br.s IL_0068
    IL_004e: ldloc.0
    IL_004f: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0054: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0059: ldarg.1
    IL_005a: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_005f: stloc.2
    IL_0060: ldloca.s 2
    IL_0062: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0067: stloc.1
    IL_0068: ldloc.1
    IL_0069: ldarg.0
    IL_006a: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_006f: bgt.un.s IL_0073
    IL_0071: ldloc.0
    IL_0072: ret
    IL_0073: ldnull
    IL_0074: ret

  .method TargetPriority::FindFarthestTaggedObjectWithRange(UnityEngine.Vector3)  // token 0x06000E70 rva 0x406f0 attrs Public, HideBySig
    // code size 132 (0x84), max stack 5, init locals
    .locals ([0] TaggedObject, [1] float, [2] Vector3)
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: ldarg.1
    IL_0006: ldarg.0
    IL_0007: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_000c: ldarg.0
    IL_000d: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_0012: ldarg.0
    IL_0013: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0018: callvirt TaggedObject TagManager::FindFarthestTaggedObjectWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,float)  /*0x06000E61*/
    IL_001d: stloc.0
    IL_001e: ldloc.0
    IL_001f: ldnull
    IL_0020: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0025: brfalse.s IL_0029
    IL_0027: ldnull
    IL_0028: ret
    IL_0029: ldloc.0
    IL_002a: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_002f: ldnull
    IL_0030: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0035: brfalse.s IL_0054
    IL_0037: ldloc.0
    IL_0038: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_003d: ldarg.1
    IL_003e: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_0043: ldarg.1
    IL_0044: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0049: stloc.2
    IL_004a: ldloca.s 2
    IL_004c: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0051: stloc.1
    IL_0052: br.s IL_006e
    IL_0054: ldloc.0
    IL_0055: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_005f: ldarg.1
    IL_0060: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0065: stloc.2
    IL_0066: ldloca.s 2
    IL_0068: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_006d: stloc.1
    IL_006e: ldloc.1
    IL_006f: ldarg.0
    IL_0070: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0075: bgt.un.s IL_0082
    IL_0077: ldloc.1
    IL_0078: ldarg.0
    IL_0079: ldfld float TargetPriority::minRange  /*0x040010D3*/
    IL_007e: blt.un.s IL_0082
    IL_0080: ldloc.0
    IL_0081: ret
    IL_0082: ldnull
    IL_0083: ret

  .method TargetPriority::FindClosestTaggedObjectWithoutMaxDistanceCheck(UnityEngine.Vector3)  // token 0x06000E71 rva 0x40780 attrs Public, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: ldarg.1
    IL_0006: ldarg.0
    IL_0007: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_000c: ldarg.0
    IL_000d: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_0012: callvirt TaggedObject TagManager::FindClosestTaggedObjectWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5E*/
    IL_0017: ret

  .method TargetPriority::FindClosestTaggedObjects(UnityEngine.Vector3,TaggedObject[])  // token 0x06000E72 rva 0x40799 attrs Public, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: ldarg.1
    IL_0006: ldarg.0
    IL_0007: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_000c: ldarg.0
    IL_000d: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_0012: ldarg.2
    IL_0013: ldarg.0
    IL_0014: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0019: callvirt void TagManager::FindClosestTaggedObjectsWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,TaggedObject[],float)  /*0x06000E5F*/
    IL_001e: ret

  .method TargetPriority::FindUnsortedTaggedObjectsInRange(UnityEngine.Vector3)  // token 0x06000E73 rva 0x407b9 attrs Public, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: ldarg.1
    IL_0006: ldarg.0
    IL_0007: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_000c: ldarg.0
    IL_000d: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_0012: ldarg.0
    IL_0013: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0018: callvirt List<TaggedObject> TagManager::FindUnsortedTaggedObjectsInRange(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,float)  /*0x06000E60*/
    IL_001d: ret

  .method TargetPriority::FindLowestHealthTaggedObjects(UnityEngine.Vector3,TaggedObject[],bool)  // token 0x06000E74 rva 0x407d8 attrs Public, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: ldarg.1
    IL_0006: ldarg.0
    IL_0007: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_000c: ldarg.0
    IL_000d: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_0012: ldarg.2
    IL_0013: ldarg.0
    IL_0014: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0019: ldarg.3
    IL_001a: callvirt void TagManager::FindLowestHealthTaggedObjectsWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,TaggedObject[],float,bool)  /*0x06000E62*/
    IL_001f: ret

  .method TargetPriority::FindHighestHealthObjectInRange(UnityEngine.Vector3)  // token 0x06000E75 rva 0x407fc attrs Public, HideBySig
    // code size 162 (0xa2), max stack 4, init locals
    .locals ([0] TaggedObject, [1] float, [2] int, [3] Hp)
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: stfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0011: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_0016: ldarg.0
    IL_0017: ldfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_001c: ldarg.0
    IL_001d: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0022: ldarg.0
    IL_0023: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_0028: ldarg.0
    IL_0029: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_002e: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0033: ldnull
    IL_0034: stloc.0
    IL_0035: ldc.r4 0f
    IL_003a: stloc.1
    IL_003b: ldc.i4.0
    IL_003c: stloc.2
    IL_003d: br.s IL_0092
    IL_003f: ldarg.0
    IL_0040: ldfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_0045: ldarg.0
    IL_0046: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_004b: ldloc.2
    IL_004c: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0051: ldarg.1
    IL_0052: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_0057: ldarg.0
    IL_0058: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_005d: bgt.s IL_008e
    IL_005f: ldarg.0
    IL_0060: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0065: ldloc.2
    IL_0066: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_006b: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0070: stloc.3
    IL_0071: ldloc.3
    IL_0072: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0077: ldloc.1
    IL_0078: ble.un.s IL_008e
    IL_007a: ldloc.3
    IL_007b: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0080: stloc.1
    IL_0081: ldarg.0
    IL_0082: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0087: ldloc.2
    IL_0088: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_008d: stloc.0
    IL_008e: ldloc.2
    IL_008f: ldc.i4.1
    IL_0090: add
    IL_0091: stloc.2
    IL_0092: ldloc.2
    IL_0093: ldarg.0
    IL_0094: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0099: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_009e: blt.s IL_003f
    IL_00a0: ldloc.0
    IL_00a1: ret

  .method TargetPriority::FindHighestHealthObjectsInRange(UnityEngine.Vector3,TaggedObject[])  // token 0x06000E76 rva 0x408ac attrs Public, HideBySig
    // code size 265 (0x109), max stack 4, init locals
    .locals ([0] int, [1] HealthEntry[], [2] int, [3] int, [4] int, [5] Hp, [6] int)
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: stfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0011: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_0016: ldarg.0
    IL_0017: ldfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_001c: ldarg.0
    IL_001d: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0022: ldarg.0
    IL_0023: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_0028: ldarg.0
    IL_0029: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_002e: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0033: ldarg.0
    IL_0034: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0039: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_003e: stloc.0
    IL_003f: ldloc.0
    IL_0040: brtrue.s IL_0043
    IL_0042: ret
    IL_0043: ldloc.0
    IL_0044: call HealthEntry[] HealthSortBuffer::Allocate(int)  /*0x06000E81*/
    IL_0049: stloc.1
    IL_004a: ldc.i4.0
    IL_004b: stloc.2
    IL_004c: ldc.i4.0
    IL_004d: stloc.s 4
    IL_004f: br.s IL_00c6
    IL_0051: ldarg.0
    IL_0052: ldfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_0057: ldarg.0
    IL_0058: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_005d: ldloc.s 4
    IL_005f: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0064: ldarg.1
    IL_0065: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_006a: ldarg.0
    IL_006b: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0070: bgt.un.s IL_00c0
    IL_0072: ldarg.0
    IL_0073: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0078: ldloc.s 4
    IL_007a: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_007f: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0084: stloc.s 5
    IL_0086: ldloc.s 5
    IL_0088: ldnull
    IL_0089: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_008e: brfalse.s IL_00c0
    IL_0090: ldloc.1
    IL_0091: ldloc.2
    IL_0092: ldelema HealthEntry  /*0x0200029F*/
    IL_0097: ldarg.0
    IL_0098: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_009d: ldloc.s 4
    IL_009f: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_00a4: stfld TaggedObject HealthEntry::obj  /*0x040010D7*/
    IL_00a9: ldloc.1
    IL_00aa: ldloc.2
    IL_00ab: ldelema HealthEntry  /*0x0200029F*/
    IL_00b0: ldloc.s 5
    IL_00b2: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_00b7: stfld float HealthEntry::value  /*0x040010D8*/
    IL_00bc: ldloc.2
    IL_00bd: ldc.i4.1
    IL_00be: add
    IL_00bf: stloc.2
    IL_00c0: ldloc.s 4
    IL_00c2: ldc.i4.1
    IL_00c3: add
    IL_00c4: stloc.s 4
    IL_00c6: ldloc.s 4
    IL_00c8: ldloc.0
    IL_00c9: blt.s IL_0051
    IL_00cb: ldloc.2
    IL_00cc: ldc.i4.1
    IL_00cd: ble.s IL_00d6
    IL_00cf: ldloc.1
    IL_00d0: ldloc.2
    IL_00d1: call void HealthSortBuffer::SortDesc(HealthEntry[],int)  /*0x06000E83*/
    IL_00d6: ldarg.2
    IL_00d7: ldlen
    IL_00d8: conv.i4
    IL_00d9: ldloc.2
    IL_00da: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_00df: stloc.3
    IL_00e0: ldc.i4.0
    IL_00e1: stloc.s 6
    IL_00e3: br.s IL_00fc
    IL_00e5: ldarg.2
    IL_00e6: ldloc.s 6
    IL_00e8: ldloc.1
    IL_00e9: ldloc.s 6
    IL_00eb: ldelema HealthEntry  /*0x0200029F*/
    IL_00f0: ldfld TaggedObject HealthEntry::obj  /*0x040010D7*/
    IL_00f5: stelem.ref
    IL_00f6: ldloc.s 6
    IL_00f8: ldc.i4.1
    IL_00f9: add
    IL_00fa: stloc.s 6
    IL_00fc: ldloc.s 6
    IL_00fe: ldloc.3
    IL_00ff: blt.s IL_00e5
    IL_0101: ldloc.1
    IL_0102: ldloc.0
    IL_0103: call void HealthSortBuffer::Free(HealthEntry[],int)  /*0x06000E82*/
    IL_0108: ret

  .method TargetPriority::FindHighestMaxHealthObjectsInRange(UnityEngine.Vector3,TaggedObject[])  // token 0x06000E77 rva 0x409c4 attrs Public, HideBySig
    // code size 265 (0x109), max stack 4, init locals
    .locals ([0] int, [1] HealthEntry[], [2] int, [3] int, [4] int, [5] Hp, [6] int)
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: stfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0011: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_0016: ldarg.0
    IL_0017: ldfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_001c: ldarg.0
    IL_001d: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0022: ldarg.0
    IL_0023: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_0028: ldarg.0
    IL_0029: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_002e: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0033: ldarg.0
    IL_0034: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0039: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_003e: stloc.0
    IL_003f: ldloc.0
    IL_0040: brtrue.s IL_0043
    IL_0042: ret
    IL_0043: ldloc.0
    IL_0044: call HealthEntry[] HealthSortBuffer::Allocate(int)  /*0x06000E81*/
    IL_0049: stloc.1
    IL_004a: ldc.i4.0
    IL_004b: stloc.2
    IL_004c: ldc.i4.0
    IL_004d: stloc.s 4
    IL_004f: br.s IL_00c6
    IL_0051: ldarg.0
    IL_0052: ldfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_0057: ldarg.0
    IL_0058: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_005d: ldloc.s 4
    IL_005f: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0064: ldarg.1
    IL_0065: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_006a: ldarg.0
    IL_006b: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0070: bgt.un.s IL_00c0
    IL_0072: ldarg.0
    IL_0073: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0078: ldloc.s 4
    IL_007a: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_007f: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0084: stloc.s 5
    IL_0086: ldloc.s 5
    IL_0088: ldnull
    IL_0089: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_008e: brfalse.s IL_00c0
    IL_0090: ldloc.1
    IL_0091: ldloc.2
    IL_0092: ldelema HealthEntry  /*0x0200029F*/
    IL_0097: ldarg.0
    IL_0098: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_009d: ldloc.s 4
    IL_009f: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_00a4: stfld TaggedObject HealthEntry::obj  /*0x040010D7*/
    IL_00a9: ldloc.1
    IL_00aa: ldloc.2
    IL_00ab: ldelema HealthEntry  /*0x0200029F*/
    IL_00b0: ldloc.s 5
    IL_00b2: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_00b7: stfld float HealthEntry::value  /*0x040010D8*/
    IL_00bc: ldloc.2
    IL_00bd: ldc.i4.1
    IL_00be: add
    IL_00bf: stloc.2
    IL_00c0: ldloc.s 4
    IL_00c2: ldc.i4.1
    IL_00c3: add
    IL_00c4: stloc.s 4
    IL_00c6: ldloc.s 4
    IL_00c8: ldloc.0
    IL_00c9: blt.s IL_0051
    IL_00cb: ldloc.2
    IL_00cc: ldc.i4.1
    IL_00cd: ble.s IL_00d6
    IL_00cf: ldloc.1
    IL_00d0: ldloc.2
    IL_00d1: call void HealthSortBuffer::SortDesc(HealthEntry[],int)  /*0x06000E83*/
    IL_00d6: ldarg.2
    IL_00d7: ldlen
    IL_00d8: conv.i4
    IL_00d9: ldloc.2
    IL_00da: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_00df: stloc.3
    IL_00e0: ldc.i4.0
    IL_00e1: stloc.s 6
    IL_00e3: br.s IL_00fc
    IL_00e5: ldarg.2
    IL_00e6: ldloc.s 6
    IL_00e8: ldloc.1
    IL_00e9: ldloc.s 6
    IL_00eb: ldelema HealthEntry  /*0x0200029F*/
    IL_00f0: ldfld TaggedObject HealthEntry::obj  /*0x040010D7*/
    IL_00f5: stelem.ref
    IL_00f6: ldloc.s 6
    IL_00f8: ldc.i4.1
    IL_00f9: add
    IL_00fa: stloc.s 6
    IL_00fc: ldloc.s 6
    IL_00fe: ldloc.3
    IL_00ff: blt.s IL_00e5
    IL_0101: ldloc.1
    IL_0102: ldloc.0
    IL_0103: call void HealthSortBuffer::Free(HealthEntry[],int)  /*0x06000E82*/
    IL_0108: ret

  .method TargetPriority::FindRandomObjectInRange(UnityEngine.Vector3)  // token 0x06000E78 rva 0x40adc attrs Public, HideBySig
    // code size 140 (0x8c), max stack 4, init locals
    .locals ([0] TaggedObject, [1] float, [2] int, [3] float)
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: stfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0011: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_0016: ldarg.0
    IL_0017: ldfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_001c: ldarg.0
    IL_001d: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0022: ldarg.0
    IL_0023: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_0028: ldarg.0
    IL_0029: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_002e: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0033: ldnull
    IL_0034: stloc.0
    IL_0035: ldc.r4 0f
    IL_003a: stloc.1
    IL_003b: ldc.i4.0
    IL_003c: stloc.2
    IL_003d: br.s IL_007c
    IL_003f: ldarg.0
    IL_0040: ldfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_0045: ldarg.0
    IL_0046: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_004b: ldloc.2
    IL_004c: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0051: ldarg.1
    IL_0052: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_0057: ldarg.0
    IL_0058: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_005d: bgt.s IL_0078
    IL_005f: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0064: stloc.3
    IL_0065: ldloc.3
    IL_0066: ldloc.1
    IL_0067: ble.un.s IL_0078
    IL_0069: ldloc.3
    IL_006a: stloc.1
    IL_006b: ldarg.0
    IL_006c: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0071: ldloc.2
    IL_0072: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0077: stloc.0
    IL_0078: ldloc.2
    IL_0079: ldc.i4.1
    IL_007a: add
    IL_007b: stloc.2
    IL_007c: ldloc.2
    IL_007d: ldarg.0
    IL_007e: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0083: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0088: blt.s IL_003f
    IL_008a: ldloc.0
    IL_008b: ret

  .method TargetPriority::FindRandomObjectsInRange(UnityEngine.Vector3,TaggedObject[])  // token 0x06000E79 rva 0x40b74 attrs Public, HideBySig
    // code size 143 (0x8f), max stack 4, init locals
    .locals ([0] int, [1] List.Enumerator<TaggedObject>, [2] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: stfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_000b: ldarg.0
    IL_000c: ldfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_0011: ldarg.0
    IL_0012: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0017: ldarg.0
    IL_0018: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_001d: ldarg.0
    IL_001e: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_0023: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0028: ldarg.0
    IL_0029: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_002e: newobj void System.Random::.ctor()  /*0x0A0002D7*/
    IL_0033: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<TaggedObject>  /*0x2B0000CE*/
    IL_0038: ldc.i4.0
    IL_0039: stloc.0
    IL_003a: ldarg.0
    IL_003b: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0040: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0045: stloc.1
    IL_0046: br.s IL_0075
    IL_0048: ldloca.s 1
    IL_004a: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_004f: stloc.2
    IL_0050: ldarg.0
    IL_0051: ldfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_0056: ldloc.2
    IL_0057: ldarg.1
    IL_0058: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_005d: ldarg.0
    IL_005e: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0063: bgt.un.s IL_0075
    IL_0065: ldarg.2
    IL_0066: ldloc.0
    IL_0067: ldloc.2
    IL_0068: stelem.ref
    IL_0069: ldloc.0
    IL_006a: ldc.i4.1
    IL_006b: add
    IL_006c: stloc.0
    IL_006d: ldloc.0
    IL_006e: ldarg.2
    IL_006f: ldlen
    IL_0070: conv.i4
    IL_0071: blt.s IL_0075
    IL_0073: leave.s IL_008e
    IL_0075: ldloca.s 1
    IL_0077: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_007c: brtrue.s IL_0048
    IL_007e: leave.s IL_008e
    IL_0080: ldloca.s 1
    IL_0082: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0088: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_008d: endfinally
    IL_008e: ret
    .try IL_0046-IL_0080 finally handler IL_0080-IL_008e

  .method TargetPriority::FindLowestHealthObjectInRange(UnityEngine.Vector3,bool)  // token 0x06000E7A rva 0x40c20 attrs Public, HideBySig
    // code size 178 (0xb2), max stack 4, init locals
    .locals ([0] TaggedObject, [1] float, [2] int, [3] Hp)
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: stfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0011: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_0016: ldarg.0
    IL_0017: ldfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_001c: ldarg.0
    IL_001d: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0022: ldarg.0
    IL_0023: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_0028: ldarg.0
    IL_0029: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_002e: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0033: ldnull
    IL_0034: stloc.0
    IL_0035: ldc.r4 100f
    IL_003a: stloc.1
    IL_003b: ldc.i4.0
    IL_003c: stloc.2
    IL_003d: br.s IL_00a2
    IL_003f: ldarg.0
    IL_0040: ldfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_0045: ldarg.0
    IL_0046: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_004b: ldloc.2
    IL_004c: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0051: ldarg.1
    IL_0052: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_0057: ldarg.0
    IL_0058: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_005d: bgt.s IL_009e
    IL_005f: ldarg.0
    IL_0060: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0065: ldloc.2
    IL_0066: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_006b: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0070: stloc.3
    IL_0071: ldarg.2
    IL_0072: brfalse.s IL_0081
    IL_0074: ldloc.3
    IL_0075: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_007a: ldc.r4 1f
    IL_007f: bge.s IL_009e
    IL_0081: ldloc.3
    IL_0082: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_0087: ldloc.1
    IL_0088: bge.un.s IL_009e
    IL_008a: ldloc.3
    IL_008b: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_0090: stloc.1
    IL_0091: ldarg.0
    IL_0092: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0097: ldloc.2
    IL_0098: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_009d: stloc.0
    IL_009e: ldloc.2
    IL_009f: ldc.i4.1
    IL_00a0: add
    IL_00a1: stloc.2
    IL_00a2: ldloc.2
    IL_00a3: ldarg.0
    IL_00a4: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_00a9: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_00ae: blt.s IL_003f
    IL_00b0: ldloc.0
    IL_00b1: ret

  .method TargetPriority::FindLowestHealthObjectsInRange(UnityEngine.Vector3,TaggedObject[],bool)  // token 0x06000E7B rva 0x40ce0 attrs Public, HideBySig
    // code size 288 (0x120), max stack 4, init locals
    .locals ([0] int, [1] HealthEntry[], [2] int, [3] int, [4] int, [5] Hp, [6] int)
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: stfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0011: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_0016: ldarg.0
    IL_0017: ldfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_001c: ldarg.0
    IL_001d: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0022: ldarg.0
    IL_0023: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_0028: ldarg.0
    IL_0029: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_002e: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0033: ldarg.0
    IL_0034: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0039: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_003e: stloc.0
    IL_003f: ldloc.0
    IL_0040: brtrue.s IL_0043
    IL_0042: ret
    IL_0043: ldloc.0
    IL_0044: call HealthEntry[] HealthSortBuffer::Allocate(int)  /*0x06000E81*/
    IL_0049: stloc.1
    IL_004a: ldc.i4.0
    IL_004b: stloc.2
    IL_004c: ldc.i4.0
    IL_004d: stloc.s 4
    IL_004f: br IL_00da
    IL_0054: ldarg.0
    IL_0055: ldfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_005a: ldarg.0
    IL_005b: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0060: ldloc.s 4
    IL_0062: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0067: ldarg.1
    IL_0068: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_006d: ldarg.0
    IL_006e: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0073: bgt.s IL_00d4
    IL_0075: ldarg.0
    IL_0076: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_007b: ldloc.s 4
    IL_007d: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0082: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0087: stloc.s 5
    IL_0089: ldloc.s 5
    IL_008b: ldnull
    IL_008c: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0091: brtrue.s IL_00d4
    IL_0093: ldarg.3
    IL_0094: brfalse.s IL_00a4
    IL_0096: ldloc.s 5
    IL_0098: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_009d: ldc.r4 1f
    IL_00a2: bge.s IL_00d4
    IL_00a4: ldloc.1
    IL_00a5: ldloc.2
    IL_00a6: ldelema HealthEntry  /*0x0200029F*/
    IL_00ab: ldarg.0
    IL_00ac: ldfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_00b1: ldloc.s 4
    IL_00b3: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_00b8: stfld TaggedObject HealthEntry::obj  /*0x040010D7*/
    IL_00bd: ldloc.1
    IL_00be: ldloc.2
    IL_00bf: ldelema HealthEntry  /*0x0200029F*/
    IL_00c4: ldloc.s 5
    IL_00c6: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_00cb: stfld float HealthEntry::value  /*0x040010D8*/
    IL_00d0: ldloc.2
    IL_00d1: ldc.i4.1
    IL_00d2: add
    IL_00d3: stloc.2
    IL_00d4: ldloc.s 4
    IL_00d6: ldc.i4.1
    IL_00d7: add
    IL_00d8: stloc.s 4
    IL_00da: ldloc.s 4
    IL_00dc: ldloc.0
    IL_00dd: blt IL_0054
    IL_00e2: ldloc.2
    IL_00e3: ldc.i4.1
    IL_00e4: ble.s IL_00ed
    IL_00e6: ldloc.1
    IL_00e7: ldloc.2
    IL_00e8: call void HealthSortBuffer::SortAsc(HealthEntry[],int)  /*0x06000E84*/
    IL_00ed: ldarg.2
    IL_00ee: ldlen
    IL_00ef: conv.i4
    IL_00f0: ldloc.2
    IL_00f1: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_00f6: stloc.3
    IL_00f7: ldc.i4.0
    IL_00f8: stloc.s 6
    IL_00fa: br.s IL_0113
    IL_00fc: ldarg.2
    IL_00fd: ldloc.s 6
    IL_00ff: ldloc.1
    IL_0100: ldloc.s 6
    IL_0102: ldelema HealthEntry  /*0x0200029F*/
    IL_0107: ldfld TaggedObject HealthEntry::obj  /*0x040010D7*/
    IL_010c: stelem.ref
    IL_010d: ldloc.s 6
    IL_010f: ldc.i4.1
    IL_0110: add
    IL_0111: stloc.s 6
    IL_0113: ldloc.s 6
    IL_0115: ldloc.3
    IL_0116: blt.s IL_00fc
    IL_0118: ldloc.1
    IL_0119: ldloc.0
    IL_011a: call void HealthSortBuffer::Free(HealthEntry[],int)  /*0x06000E82*/
    IL_011f: ret

  .method TargetPriority::FindTaggedObject(UnityEngine.Vector3,ref UnityEngine.Vector3)  // token 0x06000E7C rva 0x40e0c attrs Public, HideBySig
    // code size 152 (0x98), max stack 4, init locals
    .locals ([0] TaggedObject, [1] float, [2] Vector3)
    IL_0000: ldarg.2
    IL_0001: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0006: stobj UnityEngine.Vector3  /*0x01000028*/
    IL_000b: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0010: ldarg.1
    IL_0011: ldarg.0
    IL_0012: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_0017: ldarg.0
    IL_0018: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_001d: callvirt TaggedObject TagManager::FindClosestTaggedObjectWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5E*/
    IL_0022: stloc.0
    IL_0023: ldloc.0
    IL_0024: ldnull
    IL_0025: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_002a: brfalse.s IL_002e
    IL_002c: ldnull
    IL_002d: ret
    IL_002e: ldloc.0
    IL_002f: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0034: ldnull
    IL_0035: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_003a: brfalse.s IL_0065
    IL_003c: ldarg.2
    IL_003d: ldloc.0
    IL_003e: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0043: ldarg.1
    IL_0044: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_0049: stobj UnityEngine.Vector3  /*0x01000028*/
    IL_004e: ldarg.2
    IL_004f: ldobj UnityEngine.Vector3  /*0x01000028*/
    IL_0054: ldarg.1
    IL_0055: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_005a: stloc.2
    IL_005b: ldloca.s 2
    IL_005d: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0062: stloc.1
    IL_0063: br.s IL_008b
    IL_0065: ldarg.2
    IL_0066: ldloc.0
    IL_0067: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_006c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0071: stobj UnityEngine.Vector3  /*0x01000028*/
    IL_0076: ldarg.2
    IL_0077: ldobj UnityEngine.Vector3  /*0x01000028*/
    IL_007c: ldarg.1
    IL_007d: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0082: stloc.2
    IL_0083: ldloca.s 2
    IL_0085: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_008a: stloc.1
    IL_008b: ldloc.1
    IL_008c: ldarg.0
    IL_008d: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0092: bgt.un.s IL_0096
    IL_0094: ldloc.0
    IL_0095: ret
    IL_0096: ldnull
    IL_0097: ret

  .method TargetPriority::FindTaggedObjectCloseToHome(UnityEngine.Vector3,UnityEngine.Vector3,float,ref UnityEngine.Vector3)  // token 0x06000E7D rva 0x40eb0 attrs Public, HideBySig
    // code size 155 (0x9b), max stack 4, init locals
    .locals ([0] TaggedObject, [1] Vector3)
    IL_0000: ldarg.s 4
    IL_0002: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0007: stobj UnityEngine.Vector3  /*0x01000028*/
    IL_000c: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0011: ldarg.1
    IL_0012: ldarg.0
    IL_0013: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_0018: ldarg.0
    IL_0019: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_001e: callvirt TaggedObject TagManager::FindClosestTaggedObjectWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5E*/
    IL_0023: stloc.0
    IL_0024: ldloc.0
    IL_0025: ldnull
    IL_0026: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_002b: brfalse.s IL_002f
    IL_002d: ldnull
    IL_002e: ret
    IL_002f: ldloc.0
    IL_0030: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0035: ldnull
    IL_0036: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_003b: brfalse.s IL_0052
    IL_003d: ldarg.s 4
    IL_003f: ldloc.0
    IL_0040: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0045: ldarg.1
    IL_0046: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_004b: stobj UnityEngine.Vector3  /*0x01000028*/
    IL_0050: br.s IL_0064
    IL_0052: ldarg.s 4
    IL_0054: ldloc.0
    IL_0055: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_005f: stobj UnityEngine.Vector3  /*0x01000028*/
    IL_0064: ldarg.s 4
    IL_0066: ldobj UnityEngine.Vector3  /*0x01000028*/
    IL_006b: ldarg.1
    IL_006c: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0071: stloc.1
    IL_0072: ldloca.s 1
    IL_0074: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0079: ldarg.s 4
    IL_007b: ldobj UnityEngine.Vector3  /*0x01000028*/
    IL_0080: ldarg.2
    IL_0081: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0086: stloc.1
    IL_0087: ldloca.s 1
    IL_0089: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_008e: pop
    IL_008f: ldarg.0
    IL_0090: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0095: bgt.un.s IL_0099
    IL_0097: ldloc.0
    IL_0098: ret
    IL_0099: ldnull
    IL_009a: ret

  .method TargetPriority::FindTaggedObjectCloseToHomeInHomeRange(UnityEngine.Vector3,UnityEngine.Vector3,float,ref UnityEngine.Vector3)  // token 0x06000E7E rva 0x40f58 attrs Public, HideBySig
    // code size 159 (0x9f), max stack 4, init locals
    .locals ([0] TaggedObject, [1] float, [2] Vector3)
    IL_0000: ldarg.s 4
    IL_0002: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0007: stobj UnityEngine.Vector3  /*0x01000028*/
    IL_000c: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0011: ldarg.1
    IL_0012: ldarg.0
    IL_0013: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_0018: ldarg.0
    IL_0019: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_001e: callvirt TaggedObject TagManager::FindClosestTaggedObjectWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5E*/
    IL_0023: stloc.0
    IL_0024: ldloc.0
    IL_0025: ldnull
    IL_0026: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_002b: brfalse.s IL_002f
    IL_002d: ldnull
    IL_002e: ret
    IL_002f: ldloc.0
    IL_0030: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0035: ldnull
    IL_0036: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_003b: brfalse.s IL_0052
    IL_003d: ldarg.s 4
    IL_003f: ldloc.0
    IL_0040: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0045: ldarg.1
    IL_0046: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_004b: stobj UnityEngine.Vector3  /*0x01000028*/
    IL_0050: br.s IL_0064
    IL_0052: ldarg.s 4
    IL_0054: ldloc.0
    IL_0055: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_005f: stobj UnityEngine.Vector3  /*0x01000028*/
    IL_0064: ldarg.s 4
    IL_0066: ldobj UnityEngine.Vector3  /*0x01000028*/
    IL_006b: ldarg.1
    IL_006c: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0071: stloc.2
    IL_0072: ldloca.s 2
    IL_0074: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0079: ldarg.s 4
    IL_007b: ldobj UnityEngine.Vector3  /*0x01000028*/
    IL_0080: ldarg.2
    IL_0081: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0086: stloc.2
    IL_0087: ldloca.s 2
    IL_0089: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_008e: stloc.1
    IL_008f: ldarg.0
    IL_0090: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0095: bgt.un.s IL_009d
    IL_0097: ldloc.1
    IL_0098: ldarg.3
    IL_0099: bgt.un.s IL_009d
    IL_009b: ldloc.0
    IL_009c: ret
    IL_009d: ldnull
    IL_009e: ret

  .method TargetPriority::FindTaggedObjectsCloseToHomeInRange(UnityEngine.Vector3,UnityEngine.Vector3,float,ref System.Collections.Generic.List<TaggedObject>)  // token 0x06000E7F rva 0x41004 attrs Public, HideBySig
    // code size 270 (0x10e), max stack 4, init locals
    .locals ([0] int, [1] int, [2] float, [3] float, [4] float, [5] TaggedObject, [6] float, [7] float, [8] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: stfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_000b: ldarg.s 4
    IL_000d: ldind.ref
    IL_000e: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_0013: ldarg.0
    IL_0014: ldfld TagManager TargetPriority::tagManager  /*0x040010D6*/
    IL_0019: ldarg.s 4
    IL_001b: ldind.ref
    IL_001c: ldarg.0
    IL_001d: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_0022: ldarg.0
    IL_0023: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_0028: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_002d: ldc.i4.0
    IL_002e: stloc.0
    IL_002f: ldarg.s 4
    IL_0031: ldind.ref
    IL_0032: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0037: ldc.i4.1
    IL_0038: sub
    IL_0039: stloc.1
    IL_003a: ldarg.3
    IL_003b: ldarg.3
    IL_003c: mul
    IL_003d: stloc.2
    IL_003e: ldarg.0
    IL_003f: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0044: ldarg.0
    IL_0045: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_004a: mul
    IL_004b: stloc.3
    IL_004c: ldarg.0
    IL_004d: ldfld float TargetPriority::minRange  /*0x040010D3*/
    IL_0052: ldarg.0
    IL_0053: ldfld float TargetPriority::minRange  /*0x040010D3*/
    IL_0058: mul
    IL_0059: stloc.s 4
    IL_005b: br IL_00e8
    IL_0060: ldarg.s 4
    IL_0062: ldind.ref
    IL_0063: ldloc.0
    IL_0064: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0069: stloc.s 5
    IL_006b: ldloc.s 5
    IL_006d: ldnull
    IL_006e: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0073: brfalse.s IL_008d
    IL_0075: ldarg.s 4
    IL_0077: ldind.ref
    IL_0078: ldloc.0
    IL_0079: ldarg.s 4
    IL_007b: ldind.ref
    IL_007c: ldloc.1
    IL_007d: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0082: callvirt void System.Collections.Generic.List<TaggedObject>::set_Item(int,!0)  /*0x0A0005CD*/
    IL_0087: ldloc.1
    IL_0088: ldc.i4.1
    IL_0089: sub
    IL_008a: stloc.1
    IL_008b: br.s IL_00e8
    IL_008d: ldloc.s 5
    IL_008f: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0094: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0099: dup
    IL_009a: ldarg.1
    IL_009b: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_00a0: stloc.s 8
    IL_00a2: ldloca.s 8
    IL_00a4: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_00a9: stloc.s 6
    IL_00ab: ldarg.2
    IL_00ac: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_00b1: stloc.s 8
    IL_00b3: ldloca.s 8
    IL_00b5: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_00ba: stloc.s 7
    IL_00bc: ldloc.s 6
    IL_00be: ldloc.3
    IL_00bf: bgt.un.s IL_00d2
    IL_00c1: ldloc.s 6
    IL_00c3: ldloc.s 4
    IL_00c5: blt.un.s IL_00d2
    IL_00c7: ldloc.s 7
    IL_00c9: ldloc.2
    IL_00ca: bgt.un.s IL_00d2
    IL_00cc: ldloc.0
    IL_00cd: ldc.i4.1
    IL_00ce: add
    IL_00cf: stloc.0
    IL_00d0: br.s IL_00e8
    IL_00d2: ldarg.s 4
    IL_00d4: ldind.ref
    IL_00d5: ldloc.0
    IL_00d6: ldarg.s 4
    IL_00d8: ldind.ref
    IL_00d9: ldloc.1
    IL_00da: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_00df: callvirt void System.Collections.Generic.List<TaggedObject>::set_Item(int,!0)  /*0x0A0005CD*/
    IL_00e4: ldloc.1
    IL_00e5: ldc.i4.1
    IL_00e6: sub
    IL_00e7: stloc.1
    IL_00e8: ldloc.0
    IL_00e9: ldloc.1
    IL_00ea: ble IL_0060
    IL_00ef: ldarg.s 4
    IL_00f1: ldind.ref
    IL_00f2: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_00f7: ldc.i4.0
    IL_00f8: ble.s IL_010d
    IL_00fa: ldarg.s 4
    IL_00fc: ldind.ref
    IL_00fd: ldloc.0
    IL_00fe: ldarg.s 4
    IL_0100: ldind.ref
    IL_0101: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0106: ldloc.0
    IL_0107: sub
    IL_0108: callvirt void System.Collections.Generic.List<TaggedObject>::RemoveRange(int,int)  /*0x0A0005D1*/
    IL_010d: ret

  .method TargetPriority::.ctor()  // token 0x06000E80 rva 0x4111e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0006: stfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0011: stfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_001c: stfld List<TaggedObject> TargetPriority::allTaggedObjects  /*0x040010D4*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0027: stfld List<TaggedObject> TargetPriority::objectsInRange  /*0x040010D5*/
    IL_002c: ldarg.0
    IL_002d: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0032: ret

