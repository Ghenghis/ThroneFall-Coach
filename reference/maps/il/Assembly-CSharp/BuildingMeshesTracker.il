// ===== BuildingMeshesTracker  (token 0x02000087) =====
  .method BuildingMeshesTracker::Unfreeze()  // token 0x060002AC rva 0xbe38 attrs Public, Virtual, HideBySig
    // code size 57 (0x39), max stack 2, init locals
    .locals ([0] MeshFusionSource[], [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildingMeshesTracker::freezeWithDelayCoroRunning2  /*0x04000387*/
    IL_0006: brfalse.s IL_001b
    IL_0008: ldarg.0
    IL_0009: ldarg.0
    IL_000a: ldfld Coroutine BuildingMeshesTracker::freezeWithDelay2  /*0x04000386*/
    IL_000f: call void UnityEngine.MonoBehaviour::StopCoroutine(UnityEngine.Coroutine)  /*0x0A000114*/
    IL_0014: ldarg.0
    IL_0015: ldc.i4.0
    IL_0016: stfld bool BuildingMeshesTracker::freezeWithDelayCoroRunning2  /*0x04000387*/
    IL_001b: ldarg.0
    IL_001c: ldfld MeshFusionSource[] BuildingMeshesTracker::meshFusers  /*0x04000385*/
    IL_0021: stloc.0
    IL_0022: ldc.i4.0
    IL_0023: stloc.1
    IL_0024: br.s IL_0032
    IL_0026: ldloc.0
    IL_0027: ldloc.1
    IL_0028: ldelem.ref
    IL_0029: callvirt void NGS.MeshFusionPro.MeshFusionSource::UndoCombine()  /*0x06001672*/
    IL_002e: ldloc.1
    IL_002f: ldc.i4.1
    IL_0030: add
    IL_0031: stloc.1
    IL_0032: ldloc.1
    IL_0033: ldloc.0
    IL_0034: ldlen
    IL_0035: conv.i4
    IL_0036: blt.s IL_0026
    IL_0038: ret

  .method BuildingMeshesTracker::FreezeMeshWithDelay()  // token 0x060002AD rva 0xbe80 attrs Public, Virtual, HideBySig
    // code size 73 (0x49), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Coroutine BuildingMeshesTracker::freezeWithDelay2  /*0x04000386*/
    IL_0006: brtrue.s IL_001b
    IL_0008: ldarg.0
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: callvirt IEnumerator BuildingMeshTracker::FreezeMeshWithDelayCoro()  /*0x060002BA*/
    IL_0010: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0015: stfld Coroutine BuildingMeshesTracker::freezeWithDelay2  /*0x04000386*/
    IL_001a: ret
    IL_001b: ldarg.0
    IL_001c: ldfld bool BuildingMeshesTracker::freezeWithDelayCoroRunning2  /*0x04000387*/
    IL_0021: brfalse.s IL_0036
    IL_0023: ldarg.0
    IL_0024: ldarg.0
    IL_0025: ldfld Coroutine BuildingMeshesTracker::freezeWithDelay2  /*0x04000386*/
    IL_002a: call void UnityEngine.MonoBehaviour::StopCoroutine(UnityEngine.Coroutine)  /*0x0A000114*/
    IL_002f: ldarg.0
    IL_0030: ldc.i4.0
    IL_0031: stfld bool BuildingMeshesTracker::freezeWithDelayCoroRunning2  /*0x04000387*/
    IL_0036: ldarg.0
    IL_0037: ldarg.0
    IL_0038: ldarg.0
    IL_0039: callvirt IEnumerator BuildingMeshTracker::FreezeMeshWithDelayCoro()  /*0x060002BA*/
    IL_003e: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0043: stfld Coroutine BuildingMeshesTracker::freezeWithDelay2  /*0x04000386*/
    IL_0048: ret

  .method BuildingMeshesTracker::FreezeMeshWithDelayCoro()  // token 0x060002AE rva 0xbed5 attrs Public, Virtual, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::.ctor(int)  /*0x060002B0*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld BuildingMeshesTracker BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::<>4__this  /*0x0400038A*/
    IL_000d: ret

  .method BuildingMeshesTracker::.ctor()  // token 0x060002AF rva 0xbee4 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void BuildingMeshTracker::.ctor()  /*0x060002BB*/
    IL_0006: ret

// ===== BuildingMeshesTracker/<FreezeMeshWithDelayCoro>d__5  (token 0x02000088) =====
  .method BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::.ctor(int)  // token 0x060002B0 rva 0xbeec attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::<>1__state  /*0x04000388*/
    IL_000d: ret

  .method BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::System.IDisposable.Dispose()  // token 0x060002B1 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::MoveNext()  // token 0x060002B2 rva 0xbefc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 126 (0x7e), max stack 2, init locals
    .locals ([0] int, [1] BuildingMeshesTracker, [2] MeshFusionSource[], [3] int, [4] MeshFusionSource)
    IL_0000: ldarg.0
    IL_0001: ldfld int BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::<>1__state  /*0x04000388*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld BuildingMeshesTracker BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::<>4__this  /*0x0400038A*/
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
    IL_0019: stfld int BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::<>1__state  /*0x04000388*/
    IL_001e: ldloc.1
    IL_001f: ldc.i4.1
    IL_0020: stfld bool BuildingMeshesTracker::freezeWithDelayCoroRunning2  /*0x04000387*/
    IL_0025: ldarg.0
    IL_0026: ldc.r4 2f
    IL_002b: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0030: stfld object BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::<>2__current  /*0x04000389*/
    IL_0035: ldarg.0
    IL_0036: ldc.i4.1
    IL_0037: stfld int BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::<>1__state  /*0x04000388*/
    IL_003c: ldc.i4.1
    IL_003d: ret
    IL_003e: ldarg.0
    IL_003f: ldc.i4.m1
    IL_0040: stfld int BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::<>1__state  /*0x04000388*/
    IL_0045: ldloc.1
    IL_0046: ldfld MeshFusionSource[] BuildingMeshesTracker::meshFusers  /*0x04000385*/
    IL_004b: stloc.2
    IL_004c: ldc.i4.0
    IL_004d: stloc.3
    IL_004e: br.s IL_006f
    IL_0050: ldloc.2
    IL_0051: ldloc.3
    IL_0052: ldelem.ref
    IL_0053: stloc.s 4
    IL_0055: ldloc.s 4
    IL_0057: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_005c: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0061: brfalse.s IL_006b
    IL_0063: ldloc.s 4
    IL_0065: callvirt bool NGS.MeshFusionPro.MeshFusionSource::AssignToController()  /*0x06001671*/
    IL_006a: pop
    IL_006b: ldloc.3
    IL_006c: ldc.i4.1
    IL_006d: add
    IL_006e: stloc.3
    IL_006f: ldloc.3
    IL_0070: ldloc.2
    IL_0071: ldlen
    IL_0072: conv.i4
    IL_0073: blt.s IL_0050
    IL_0075: ldloc.1
    IL_0076: ldc.i4.0
    IL_0077: stfld bool BuildingMeshesTracker::freezeWithDelayCoroRunning2  /*0x04000387*/
    IL_007c: ldc.i4.0
    IL_007d: ret

  .method BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060002B3 rva 0xbf86 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::<>2__current  /*0x04000389*/
    IL_0006: ret

  .method BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::System.Collections.IEnumerator.Reset()  // token 0x060002B4 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::System.Collections.IEnumerator.get_Current()  // token 0x060002B5 rva 0xbf86 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BuildingMeshesTracker.<FreezeMeshWithDelayCoro>d__5::<>2__current  /*0x04000389*/
    IL_0006: ret

