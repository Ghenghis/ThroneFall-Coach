// ===== EnableObjects  (token 0x02000135) =====
  .method EnableObjects::OnEnable()  // token 0x0600066A rva 0x1ae98 attrs Private, HideBySig
    // code size 91 (0x5b), max stack 2, init locals
    .locals ([0] GameObject[], [1] int, [2] MonoBehaviour[], [3] Animator[])
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject[] EnableObjects::gameObjectsToEnable  /*0x040007BD*/
    IL_0006: stloc.0
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: br.s IL_0018
    IL_000b: ldloc.0
    IL_000c: ldloc.1
    IL_000d: ldelem.ref
    IL_000e: ldc.i4.1
    IL_000f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0014: ldloc.1
    IL_0015: ldc.i4.1
    IL_0016: add
    IL_0017: stloc.1
    IL_0018: ldloc.1
    IL_0019: ldloc.0
    IL_001a: ldlen
    IL_001b: conv.i4
    IL_001c: blt.s IL_000b
    IL_001e: ldarg.0
    IL_001f: ldfld MonoBehaviour[] EnableObjects::componentsToEnable  /*0x040007BE*/
    IL_0024: stloc.2
    IL_0025: ldc.i4.0
    IL_0026: stloc.1
    IL_0027: br.s IL_0036
    IL_0029: ldloc.2
    IL_002a: ldloc.1
    IL_002b: ldelem.ref
    IL_002c: ldc.i4.1
    IL_002d: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0032: ldloc.1
    IL_0033: ldc.i4.1
    IL_0034: add
    IL_0035: stloc.1
    IL_0036: ldloc.1
    IL_0037: ldloc.2
    IL_0038: ldlen
    IL_0039: conv.i4
    IL_003a: blt.s IL_0029
    IL_003c: ldarg.0
    IL_003d: ldfld Animator[] EnableObjects::animationsToEnable  /*0x040007BF*/
    IL_0042: stloc.3
    IL_0043: ldc.i4.0
    IL_0044: stloc.1
    IL_0045: br.s IL_0054
    IL_0047: ldloc.3
    IL_0048: ldloc.1
    IL_0049: ldelem.ref
    IL_004a: ldc.i4.1
    IL_004b: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0050: ldloc.1
    IL_0051: ldc.i4.1
    IL_0052: add
    IL_0053: stloc.1
    IL_0054: ldloc.1
    IL_0055: ldloc.3
    IL_0056: ldlen
    IL_0057: conv.i4
    IL_0058: blt.s IL_0047
    IL_005a: ret

  .method EnableObjects::.ctor()  // token 0x0600066B rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

