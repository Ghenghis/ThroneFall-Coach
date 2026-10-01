// ===== DestroyOrDisableOnEnable  (token 0x020000B7) =====
  .method DestroyOrDisableOnEnable::OnEnable()  // token 0x060003E7 rva 0x111e8 attrs Private, HideBySig
    // code size 107 (0x6b), max stack 5, init locals
    .locals ([0] Hp[], [1] int, [2] Hp, [3] GameObject[], [4] GameObject)
    IL_0000: ldarg.0
    IL_0001: ldfld Hp[] DestroyOrDisableOnEnable::destroy  /*0x0400050B*/
    IL_0006: stloc.0
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: br.s IL_0038
    IL_000b: ldloc.0
    IL_000c: ldloc.1
    IL_000d: ldelem.ref
    IL_000e: stloc.2
    IL_000f: ldloc.2
    IL_0010: ldnull
    IL_0011: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0016: brfalse.s IL_0034
    IL_0018: ldloc.2
    IL_0019: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001e: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0023: brfalse.s IL_0034
    IL_0025: ldloc.2
    IL_0026: ldc.r4 1E+09f
    IL_002b: ldnull
    IL_002c: ldc.i4.0
    IL_002d: ldc.i4.1
    IL_002e: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0033: pop
    IL_0034: ldloc.1
    IL_0035: ldc.i4.1
    IL_0036: add
    IL_0037: stloc.1
    IL_0038: ldloc.1
    IL_0039: ldloc.0
    IL_003a: ldlen
    IL_003b: conv.i4
    IL_003c: blt.s IL_000b
    IL_003e: ldarg.0
    IL_003f: ldfld GameObject[] DestroyOrDisableOnEnable::disable  /*0x0400050C*/
    IL_0044: stloc.3
    IL_0045: ldc.i4.0
    IL_0046: stloc.1
    IL_0047: br.s IL_0064
    IL_0049: ldloc.3
    IL_004a: ldloc.1
    IL_004b: ldelem.ref
    IL_004c: stloc.s 4
    IL_004e: ldloc.s 4
    IL_0050: ldnull
    IL_0051: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0056: brfalse.s IL_0060
    IL_0058: ldloc.s 4
    IL_005a: ldc.i4.0
    IL_005b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0060: ldloc.1
    IL_0061: ldc.i4.1
    IL_0062: add
    IL_0063: stloc.1
    IL_0064: ldloc.1
    IL_0065: ldloc.3
    IL_0066: ldlen
    IL_0067: conv.i4
    IL_0068: blt.s IL_0049
    IL_006a: ret

  .method DestroyOrDisableOnEnable::.ctor()  // token 0x060003E8 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

