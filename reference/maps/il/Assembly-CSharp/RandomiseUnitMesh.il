// ===== RandomiseUnitMesh  (token 0x02000130) =====
  .method RandomiseUnitMesh::Start()  // token 0x06000655 rva 0x1a910 attrs Private, HideBySig
    // code size 78 (0x4e), max stack 3, init locals
    .locals ([0] int, [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld List<GameObject> RandomiseUnitMesh::ObjectsToRandomise  /*0x040007AC*/
    IL_0006: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_000b: ldc.i4.0
    IL_000c: ble.s IL_004d
    IL_000e: ldc.i4.0
    IL_000f: ldarg.0
    IL_0010: ldfld List<GameObject> RandomiseUnitMesh::ObjectsToRandomise  /*0x040007AC*/
    IL_0015: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_001a: ldc.i4.1
    IL_001b: sub
    IL_001c: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_0021: stloc.0
    IL_0022: ldc.i4.0
    IL_0023: stloc.1
    IL_0024: br.s IL_003f
    IL_0026: ldarg.0
    IL_0027: ldfld List<GameObject> RandomiseUnitMesh::ObjectsToRandomise  /*0x040007AC*/
    IL_002c: ldloc.1
    IL_002d: callvirt !0 System.Collections.Generic.List<UnityEngine.GameObject>::get_Item(int)  /*0x0A0001C5*/
    IL_0032: ldloc.1
    IL_0033: ldloc.0
    IL_0034: ceq
    IL_0036: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003b: ldloc.1
    IL_003c: ldc.i4.1
    IL_003d: add
    IL_003e: stloc.1
    IL_003f: ldloc.1
    IL_0040: ldarg.0
    IL_0041: ldfld List<GameObject> RandomiseUnitMesh::ObjectsToRandomise  /*0x040007AC*/
    IL_0046: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_004b: blt.s IL_0026
    IL_004d: ret

  .method RandomiseUnitMesh::.ctor()  // token 0x06000656 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

