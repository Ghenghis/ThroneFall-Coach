// ===== TaggedObject  (token 0x02000298) =====
  .method TaggedObject::get_Tags()  // token 0x06000E3F rva 0x3f973 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_0006: ret

  .method TaggedObject::get_TagBitfield()  // token 0x06000E40 rva 0x3f97b attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld long TaggedObject::tagBitfield  /*0x04001087*/
    IL_0006: ret

  .method TaggedObject::get_Hp()  // token 0x06000E41 rva 0x3f983 attrs Public, HideBySig, SpecialName
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Hp TaggedObject::hp  /*0x04001089*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_0019
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: call !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_0014: stfld Hp TaggedObject::hp  /*0x04001089*/
    IL_0019: ldarg.0
    IL_001a: ldfld Hp TaggedObject::hp  /*0x04001089*/
    IL_001f: ret

  .method TaggedObject::get_Shrine()  // token 0x06000E42 rva 0x3f9a4 attrs Public, HideBySig, SpecialName
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Shrine TaggedObject::shrineCache  /*0x0400108B*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0014
    IL_000d: ldarg.0
    IL_000e: ldfld Shrine TaggedObject::shrineCache  /*0x0400108B*/
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: call !!0 UnityEngine.Component::GetComponent()<Shrine>  /*0x2B0000C9*/
    IL_001a: ret

  .method TaggedObject::OnBeforeMainLoadPass(string)  // token 0x06000E43 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TaggedObject::OnAfterMainLoadPass(string)  // token 0x06000E44 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TaggedObject::OnLoad(string)  // token 0x06000E45 rva 0x3f9c0 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 102 (0x66), max stack 3, init locals
    .locals ([0] TagManager.ETag[])
    IL_0000: ldc.i4.0
    IL_0001: newarr TagManager.ETag  /*0x0200029A*/
    IL_0006: stloc.0
    IL_0007: ldarg.1
    IL_0008: ldarg.0
    IL_0009: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000e: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0013: ldstr "_tags"
    IL_0018: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_001d: ldloca.s 0
    IL_001f: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<TagManager.ETag[]>  /*0x2B0000CC*/
    IL_0024: pop
    IL_0025: ldloc.0
    IL_0026: ldlen
    IL_0027: brfalse.s IL_0065
    IL_0029: ldarg.0
    IL_002a: ldloc.0
    IL_002b: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0003AD*/
    IL_0030: stfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_0035: ldarg.0
    IL_0036: ldfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_003b: ldc.i4.s 45
    IL_003d: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Remove(!0)  /*0x0A0003BA*/
    IL_0042: pop
    IL_0043: ldarg.0
    IL_0044: ldfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_0049: ldc.i4.s 46
    IL_004b: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Remove(!0)  /*0x0A0003BA*/
    IL_0050: pop
    IL_0051: ldarg.0
    IL_0052: ldfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_0057: ldc.i4.s 47
    IL_0059: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Remove(!0)  /*0x0A0003BA*/
    IL_005e: pop
    IL_005f: ldarg.0
    IL_0060: call void TaggedObject::SetTagBitfieldFromTags()  /*0x06000E4B*/
    IL_0065: ret

  .method TaggedObject::OnSave(string)  // token 0x06000E46 rva 0x3fa32 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0007: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_000c: ldstr "_tags"
    IL_0011: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0016: ldarg.0
    IL_0017: ldfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_001c: callvirt !0[] System.Collections.Generic.List<TagManager.ETag>::ToArray()  /*0x0A0005C4*/
    IL_0021: call void MatchSaveLoadHandler::SaveValue(string,string,TagManager.ETag[])  /*0x06000CFA*/
    IL_0026: ret

  .method TaggedObject::OnEnable()  // token 0x06000E47 rva 0x3fa5a attrs Private, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TagManager TaggedObject::tagManager  /*0x04001088*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_0019
    IL_000e: ldarg.0
    IL_000f: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0014: stfld TagManager TaggedObject::tagManager  /*0x04001088*/
    IL_0019: ldarg.0
    IL_001a: call void TaggedObject::SetTagBitfieldFromTags()  /*0x06000E4B*/
    IL_001f: ldarg.0
    IL_0020: ldfld TagManager TaggedObject::tagManager  /*0x04001088*/
    IL_0025: ldarg.0
    IL_0026: callvirt void TagManager::AddTaggedObject(TaggedObject)  /*0x06000E56*/
    IL_002b: ret

  .method TaggedObject::OnDisable()  // token 0x06000E48 rva 0x3fa87 attrs Private, HideBySig
    // code size 38 (0x26), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TagManager TaggedObject::tagManager  /*0x04001088*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_0019
    IL_000e: ldarg.0
    IL_000f: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0014: stfld TagManager TaggedObject::tagManager  /*0x04001088*/
    IL_0019: ldarg.0
    IL_001a: ldfld TagManager TaggedObject::tagManager  /*0x04001088*/
    IL_001f: ldarg.0
    IL_0020: callvirt void TagManager::RemoveTaggedObject(TaggedObject)  /*0x06000E57*/
    IL_0025: ret

  .method TaggedObject::AddTag(TagManager.ETag)  // token 0x06000E49 rva 0x3faae attrs Public, HideBySig
    // code size 61 (0x3d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_0006: ldarg.1
    IL_0007: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_0015: ldarg.1
    IL_0016: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_001b: ldarg.0
    IL_001c: ldarg.0
    IL_001d: ldfld long TaggedObject::tagBitfield  /*0x04001087*/
    IL_0022: ldc.i4.1
    IL_0023: conv.i8
    IL_0024: ldarg.1
    IL_0025: ldc.i4.s 63
    IL_0027: and
    IL_0028: shl
    IL_0029: or
    IL_002a: stfld long TaggedObject::tagBitfield  /*0x04001087*/
    IL_002f: ldarg.0
    IL_0030: ldfld TagManager TaggedObject::tagManager  /*0x04001088*/
    IL_0035: ldarg.0
    IL_0036: ldarg.1
    IL_0037: callvirt void TagManager::AddTag(TaggedObject,TagManager.ETag)  /*0x06000E58*/
    IL_003c: ret

  .method TaggedObject::RemoveTag(TagManager.ETag)  // token 0x06000E4A rva 0x3faec attrs Public, HideBySig
    // code size 63 (0x3f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_0006: ldarg.1
    IL_0007: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_000c: brtrue.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_0015: ldarg.1
    IL_0016: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Remove(!0)  /*0x0A0003BA*/
    IL_001b: pop
    IL_001c: ldarg.0
    IL_001d: ldarg.0
    IL_001e: ldfld long TaggedObject::tagBitfield  /*0x04001087*/
    IL_0023: ldc.i4.1
    IL_0024: conv.i8
    IL_0025: ldarg.1
    IL_0026: ldc.i4.s 63
    IL_0028: and
    IL_0029: shl
    IL_002a: not
    IL_002b: and
    IL_002c: stfld long TaggedObject::tagBitfield  /*0x04001087*/
    IL_0031: ldarg.0
    IL_0032: ldfld TagManager TaggedObject::tagManager  /*0x04001088*/
    IL_0037: ldarg.0
    IL_0038: ldarg.1
    IL_0039: callvirt void TagManager::RemoveTag(TaggedObject,TagManager.ETag)  /*0x06000E59*/
    IL_003e: ret

  .method TaggedObject::SetTagBitfieldFromTags()  // token 0x06000E4B rva 0x3fb2c attrs Private, HideBySig
    // code size 56 (0x38), max stack 5, init locals
    .locals ([0] int, [1] TagManager.ETag)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_0029
    IL_0004: ldarg.0
    IL_0005: ldfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_000a: ldloc.0
    IL_000b: callvirt !0 System.Collections.Generic.List<TagManager.ETag>::get_Item(int)  /*0x0A00019B*/
    IL_0010: stloc.1
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: ldfld long TaggedObject::tagBitfield  /*0x04001087*/
    IL_0018: ldc.i4.1
    IL_0019: conv.i8
    IL_001a: ldloc.1
    IL_001b: ldc.i4.s 63
    IL_001d: and
    IL_001e: shl
    IL_001f: or
    IL_0020: stfld long TaggedObject::tagBitfield  /*0x04001087*/
    IL_0025: ldloc.0
    IL_0026: ldc.i4.1
    IL_0027: add
    IL_0028: stloc.0
    IL_0029: ldloc.0
    IL_002a: ldarg.0
    IL_002b: ldfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_0030: callvirt int System.Collections.Generic.List<TagManager.ETag>::get_Count()  /*0x0A00019C*/
    IL_0035: blt.s IL_0004
    IL_0037: ret

  .method TaggedObject::Contains(TagManager.ETag)  // token 0x06000E4C rva 0x3fb70 attrs Public, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld long TaggedObject::tagBitfield  /*0x04001087*/
    IL_0006: ldc.i4.1
    IL_0007: conv.i8
    IL_0008: ldarg.1
    IL_0009: ldc.i4.s 63
    IL_000b: and
    IL_000c: shl
    IL_000d: and
    IL_000e: ldc.i4.0
    IL_000f: conv.i8
    IL_0010: cgt.un
    IL_0012: ret

  .method TaggedObject::AddUnitGroupTag(TagManager.ETag)  // token 0x06000E4D rva 0x3fb84 attrs Public, HideBySig
    // code size 73 (0x49), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_0006: ldarg.1
    IL_0007: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.1
    IL_0010: ldc.i4.s 45
    IL_0012: beq.s IL_001c
    IL_0014: ldarg.0
    IL_0015: ldc.i4.s 45
    IL_0017: call void TaggedObject::RemoveTag(TagManager.ETag)  /*0x06000E4A*/
    IL_001c: ldarg.1
    IL_001d: ldc.i4.s 46
    IL_001f: beq.s IL_0029
    IL_0021: ldarg.0
    IL_0022: ldc.i4.s 46
    IL_0024: call void TaggedObject::RemoveTag(TagManager.ETag)  /*0x06000E4A*/
    IL_0029: ldarg.1
    IL_002a: ldc.i4.s 47
    IL_002c: beq.s IL_0036
    IL_002e: ldarg.0
    IL_002f: ldc.i4.s 47
    IL_0031: call void TaggedObject::RemoveTag(TagManager.ETag)  /*0x06000E4A*/
    IL_0036: ldarg.0
    IL_0037: ldarg.1
    IL_0038: call void TaggedObject::AddTag(TagManager.ETag)  /*0x06000E49*/
    IL_003d: ldarg.0
    IL_003e: ldfld UnityEvent TaggedObject::onUnitGroupChanged  /*0x04001086*/
    IL_0043: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0048: ret

  .method TaggedObject::RemoveUnitGroupTag(TagManager.ETag)  // token 0x06000E4E rva 0x3fbd9 attrs Public, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void TaggedObject::RemoveTag(TagManager.ETag)  /*0x06000E4A*/
    IL_0007: ldarg.0
    IL_0008: ldfld UnityEvent TaggedObject::onUnitGroupChanged  /*0x04001086*/
    IL_000d: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0012: ret

  .method TaggedObject::Match(System.Collections.Generic.HashSet<TagManager.ETag>,System.Collections.Generic.HashSet<TagManager.ETag>)  // token 0x06000E4F rva 0x3fbf0 attrs Public, HideBySig
    // code size 126 (0x7e), max stack 2, init locals
    .locals ([0] List.Enumerator<TagManager.ETag>, [1] TagManager.ETag, [2] bool, [3] HashSet.Enumerator<TagManager.ETag>, [4] TagManager.ETag)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<TagManager.ETag>::GetEnumerator()  /*0x0A0001D3*/
    IL_000b: stloc.0
    IL_000c: br.s IL_0023
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<TagManager.ETag>::get_Current()  /*0x0A0001D4*/
    IL_0015: stloc.1
    IL_0016: ldarg.2
    IL_0017: ldloc.1
    IL_0018: callvirt bool System.Collections.Generic.HashSet<TagManager.ETag>::Contains(!0)  /*0x0A000203*/
    IL_001d: brfalse.s IL_0023
    IL_001f: ldc.i4.0
    IL_0020: stloc.2
    IL_0021: leave.s IL_007c
    IL_0023: ldloca.s 0
    IL_0025: call bool System.Collections.Generic.List.Enumerator<TagManager.ETag>::MoveNext()  /*0x0A0001D5*/
    IL_002a: brtrue.s IL_000e
    IL_002c: leave.s IL_003c
    IL_002e: ldloca.s 0
    IL_0030: constrained. System.Collections.Generic.List.Enumerator<TagManager.ETag>  /*0x1B000041*/
    IL_0036: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_003b: endfinally
    IL_003c: ldarg.1
    IL_003d: callvirt HashSet.Enumerator<!0> System.Collections.Generic.HashSet<TagManager.ETag>::GetEnumerator()  /*0x0A0005C5*/
    IL_0042: stloc.3
    IL_0043: br.s IL_0061
    IL_0045: ldloca.s 3
    IL_0047: call !0 System.Collections.Generic.HashSet.Enumerator<TagManager.ETag>::get_Current()  /*0x0A0005C6*/
    IL_004c: stloc.s 4
    IL_004e: ldarg.0
    IL_004f: ldfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_0054: ldloc.s 4
    IL_0056: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_005b: brtrue.s IL_0061
    IL_005d: ldc.i4.0
    IL_005e: stloc.2
    IL_005f: leave.s IL_007c
    IL_0061: ldloca.s 3
    IL_0063: call bool System.Collections.Generic.HashSet.Enumerator<TagManager.ETag>::MoveNext()  /*0x0A0005C7*/
    IL_0068: brtrue.s IL_0045
    IL_006a: leave.s IL_007a
    IL_006c: ldloca.s 3
    IL_006e: constrained. System.Collections.Generic.HashSet.Enumerator<TagManager.ETag>  /*0x1B000106*/
    IL_0074: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0079: endfinally
    IL_007a: ldc.i4.1
    IL_007b: ret
    IL_007c: ldloc.2
    IL_007d: ret
    .try IL_000c-IL_002e finally handler IL_002e-IL_003c
    .try IL_0043-IL_006c finally handler IL_006c-IL_007a

  .method TaggedObject::GetSqrDistance(UnityEngine.Vector3)  // token 0x06000E50 rva 0x3fc98 attrs Public, HideBySig
    // code size 67 (0x43), max stack 2, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_0029
    IL_000e: ldarg.0
    IL_000f: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0014: ldarg.1
    IL_0015: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_001a: ldarg.1
    IL_001b: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0020: stloc.0
    IL_0021: ldloca.s 0
    IL_0023: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_0028: ret
    IL_0029: ldarg.0
    IL_002a: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0034: ldarg.1
    IL_0035: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_003a: stloc.0
    IL_003b: ldloca.s 0
    IL_003d: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_0042: ret

  .method TaggedObject::.ctor()  // token 0x06000E51 rva 0x3fce7 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0006: stfld List<TagManager.ETag> TaggedObject::tags  /*0x04001085*/
    IL_000b: ldarg.0
    IL_000c: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0011: stfld UnityEvent TaggedObject::onUnitGroupChanged  /*0x04001086*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

