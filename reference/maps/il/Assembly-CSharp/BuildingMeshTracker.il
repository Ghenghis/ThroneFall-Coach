// ===== BuildingMeshTracker  (token 0x02000089) =====
  .method BuildingMeshTracker::OnEnable()  // token 0x060002B6 rva 0xbf8e attrs Family, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: callvirt void BuildingMeshTracker::FreezeMeshWithDelay()  /*0x060002B9*/
    IL_0006: ret

  .method BuildingMeshTracker::OnDisable()  // token 0x060002B7 rva 0xbf96 attrs Family, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: callvirt void BuildingMeshTracker::Unfreeze()  /*0x060002B8*/
    IL_0006: ret

  .method BuildingMeshTracker::Unfreeze()  // token 0x060002B8 rva 0xbf9e attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildingMeshTracker::freezeWithDelayCoroRunning  /*0x0400038D*/
    IL_0006: brfalse.s IL_001b
    IL_0008: ldarg.0
    IL_0009: ldarg.0
    IL_000a: ldfld Coroutine BuildingMeshTracker::freezeWithDelay  /*0x0400038C*/
    IL_000f: call void UnityEngine.MonoBehaviour::StopCoroutine(UnityEngine.Coroutine)  /*0x0A000114*/
    IL_0014: ldarg.0
    IL_0015: ldc.i4.0
    IL_0016: stfld bool BuildingMeshTracker::freezeWithDelayCoroRunning  /*0x0400038D*/
    IL_001b: ldarg.0
    IL_001c: ldfld MeshFusionSource BuildingMeshTracker::meshFuser  /*0x0400038B*/
    IL_0021: callvirt void NGS.MeshFusionPro.MeshFusionSource::UndoCombine()  /*0x06001672*/
    IL_0026: ret

  .method BuildingMeshTracker::FreezeMeshWithDelay()  // token 0x060002B9 rva 0xbfc8 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 121 (0x79), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld MeshFusionSource BuildingMeshTracker::meshFuser  /*0x0400038B*/
    IL_0006: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000b: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0010: brtrue.s IL_001d
    IL_0012: ldstr "BuildingMeshTracker.FreezeMeshWithDelay meshFuser.gameObject null"
    IL_0017: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_001c: ret
    IL_001d: ldarg.0
    IL_001e: ldfld MeshFusionSource BuildingMeshTracker::meshFuser  /*0x0400038B*/
    IL_0023: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0028: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_002d: brtrue.s IL_0030
    IL_002f: ret
    IL_0030: ldarg.0
    IL_0031: ldfld Coroutine BuildingMeshTracker::freezeWithDelay  /*0x0400038C*/
    IL_0036: brtrue.s IL_004b
    IL_0038: ldarg.0
    IL_0039: ldarg.0
    IL_003a: ldarg.0
    IL_003b: callvirt IEnumerator BuildingMeshTracker::FreezeMeshWithDelayCoro()  /*0x060002BA*/
    IL_0040: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0045: stfld Coroutine BuildingMeshTracker::freezeWithDelay  /*0x0400038C*/
    IL_004a: ret
    IL_004b: ldarg.0
    IL_004c: ldfld bool BuildingMeshTracker::freezeWithDelayCoroRunning  /*0x0400038D*/
    IL_0051: brfalse.s IL_0066
    IL_0053: ldarg.0
    IL_0054: ldarg.0
    IL_0055: ldfld Coroutine BuildingMeshTracker::freezeWithDelay  /*0x0400038C*/
    IL_005a: call void UnityEngine.MonoBehaviour::StopCoroutine(UnityEngine.Coroutine)  /*0x0A000114*/
    IL_005f: ldarg.0
    IL_0060: ldc.i4.0
    IL_0061: stfld bool BuildingMeshTracker::freezeWithDelayCoroRunning  /*0x0400038D*/
    IL_0066: ldarg.0
    IL_0067: ldarg.0
    IL_0068: ldarg.0
    IL_0069: callvirt IEnumerator BuildingMeshTracker::FreezeMeshWithDelayCoro()  /*0x060002BA*/
    IL_006e: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0073: stfld Coroutine BuildingMeshTracker::freezeWithDelay  /*0x0400038C*/
    IL_0078: ret

  .method BuildingMeshTracker::FreezeMeshWithDelayCoro()  // token 0x060002BA rva 0xc04d attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::.ctor(int)  /*0x060002BC*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld BuildingMeshTracker BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::<>4__this  /*0x04000390*/
    IL_000d: ret

  .method BuildingMeshTracker::.ctor()  // token 0x060002BB rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== BuildingMeshTracker/<FreezeMeshWithDelayCoro>d__7  (token 0x0200008A) =====
  .method BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::.ctor(int)  // token 0x060002BC rva 0xc05c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::<>1__state  /*0x0400038E*/
    IL_000d: ret

  .method BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::System.IDisposable.Dispose()  // token 0x060002BD rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::MoveNext()  // token 0x060002BE rva 0xc06c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 90 (0x5a), max stack 2, init locals
    .locals ([0] int, [1] BuildingMeshTracker)
    IL_0000: ldarg.0
    IL_0001: ldfld int BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::<>1__state  /*0x0400038E*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld BuildingMeshTracker BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::<>4__this  /*0x04000390*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_003e
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::<>1__state  /*0x0400038E*/
    IL_001e: ldloc.1
    IL_001f: ldc.i4.1
    IL_0020: stfld bool BuildingMeshTracker::freezeWithDelayCoroRunning  /*0x0400038D*/
    IL_0025: ldarg.0
    IL_0026: ldc.r4 2f
    IL_002b: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0030: stfld object BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::<>2__current  /*0x0400038F*/
    IL_0035: ldarg.0
    IL_0036: ldc.i4.1
    IL_0037: stfld int BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::<>1__state  /*0x0400038E*/
    IL_003c: ldc.i4.1
    IL_003d: ret
    IL_003e: ldarg.0
    IL_003f: ldc.i4.m1
    IL_0040: stfld int BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::<>1__state  /*0x0400038E*/
    IL_0045: ldloc.1
    IL_0046: ldfld MeshFusionSource BuildingMeshTracker::meshFuser  /*0x0400038B*/
    IL_004b: callvirt bool NGS.MeshFusionPro.MeshFusionSource::AssignToController()  /*0x06001671*/
    IL_0050: pop
    IL_0051: ldloc.1
    IL_0052: ldc.i4.0
    IL_0053: stfld bool BuildingMeshTracker::freezeWithDelayCoroRunning  /*0x0400038D*/
    IL_0058: ldc.i4.0
    IL_0059: ret

  .method BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060002BF rva 0xc0d2 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::<>2__current  /*0x0400038F*/
    IL_0006: ret

  .method BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::System.Collections.IEnumerator.Reset()  // token 0x060002C0 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::System.Collections.IEnumerator.get_Current()  // token 0x060002C1 rva 0xc0d2 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BuildingMeshTracker.<FreezeMeshWithDelayCoro>d__7::<>2__current  /*0x0400038F*/
    IL_0006: ret

