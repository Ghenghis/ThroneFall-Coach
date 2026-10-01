// ===== AssignVisibleAreaToPlayer  (token 0x0200012D) =====
  .method AssignVisibleAreaToPlayer::Start()  // token 0x0600064E rva 0x1a7b8 attrs Private, HideBySig
    // code size 108 (0x6c), max stack 3, init locals
    .locals ([0] TaggedObject, [1] VisionSource)
    IL_0000: call !!0[] UnityEngine.Object::FindObjectsOfType()<TaggedObject>  /*0x2B00004D*/
    IL_0005: ldsfld Func<TaggedObject, bool> AssignVisibleAreaToPlayer.<>c::<>9__1_0  /*0x040007AA*/
    IL_000a: dup
    IL_000b: brtrue.s IL_0024
    IL_000d: pop
    IL_000e: ldsfld AssignVisibleAreaToPlayer.<>c AssignVisibleAreaToPlayer.<>c::<>9  /*0x040007A9*/
    IL_0013: ldftn bool AssignVisibleAreaToPlayer.<>c::<Start>b__1_0(TaggedObject)  /*0x06000652*/
    IL_0019: newobj void System.Func<TaggedObject, bool>::.ctor(object,IntPtr)  /*0x0A000287*/
    IL_001e: dup
    IL_001f: stsfld Func<TaggedObject, bool> AssignVisibleAreaToPlayer.<>c::<>9__1_0  /*0x040007AA*/
    IL_0024: call !!0 System.Linq.Enumerable::FirstOrDefault(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, bool>)<TaggedObject>  /*0x2B00004E*/
    IL_0029: stloc.0
    IL_002a: ldloc.0
    IL_002b: ldnull
    IL_002c: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0031: brfalse.s IL_003e
    IL_0033: ldstr "No object with ETag.Player found in scene."
    IL_0038: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_003d: ret
    IL_003e: ldloc.0
    IL_003f: ldloca.s 1
    IL_0041: callvirt bool UnityEngine.Component::TryGetComponent(ref !!0)<KB.FogRTS.Runtime.VisionSource>  /*0x2B00004F*/
    IL_0046: brtrue.s IL_0054
    IL_0048: ldloc.0
    IL_0049: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_004e: callvirt !!0 UnityEngine.GameObject::AddComponent()<KB.FogRTS.Runtime.VisionSource>  /*0x2B000050*/
    IL_0053: stloc.1
    IL_0054: ldloc.1
    IL_0055: ldarg.0
    IL_0056: ldfld float AssignVisibleAreaToPlayer::radius  /*0x040007A8*/
    IL_005b: ldarg.0
    IL_005c: ldfld float AssignVisibleAreaToPlayer::radius  /*0x040007A8*/
    IL_0061: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0066: callvirt void KB.FogRTS.Runtime.VisionSource::set_Scale(UnityEngine.Vector2)  /*0x0A000289*/
    IL_006b: ret

  .method AssignVisibleAreaToPlayer::.ctor()  // token 0x0600064F rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== AssignVisibleAreaToPlayer/<>c  (token 0x0200012E) =====
  .method AssignVisibleAreaToPlayer.<>c::.cctor()  // token 0x06000650 rva 0x1a830 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void AssignVisibleAreaToPlayer.<>c::.ctor()  /*0x06000651*/
    IL_0005: stsfld AssignVisibleAreaToPlayer.<>c AssignVisibleAreaToPlayer.<>c::<>9  /*0x040007A9*/
    IL_000a: ret

  .method AssignVisibleAreaToPlayer.<>c::.ctor()  // token 0x06000651 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method AssignVisibleAreaToPlayer.<>c::<Start>b__1_0(TaggedObject)  // token 0x06000652 rva 0x1a83c attrs Assembly, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.1
    IL_0001: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0006: brfalse.s IL_0015
    IL_0008: ldarg.1
    IL_0009: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_000e: ldc.i4.2
    IL_000f: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0014: ret
    IL_0015: ldc.i4.0
    IL_0016: ret

