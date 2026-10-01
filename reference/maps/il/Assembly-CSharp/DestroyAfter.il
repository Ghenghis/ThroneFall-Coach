// ===== DestroyAfter  (token 0x020000B6) =====
  .method DestroyAfter::Start()  // token 0x060003E4 rva 0x11159 attrs Private, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float DestroyAfter::destroyAfter  /*0x04000508*/
    IL_0007: stfld float DestroyAfter::resetTimer  /*0x04000509*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: call !!0 UnityEngine.Component::GetComponent()<ReturnGameObjectToPool>  /*0x2B000007*/
    IL_0013: ldnull
    IL_0014: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0019: stfld bool DestroyAfter::isPooledItem  /*0x0400050A*/
    IL_001e: ret

  .method DestroyAfter::Update()  // token 0x060003E5 rva 0x1117c attrs Private, HideBySig
    // code size 75 (0x4b), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float DestroyAfter::destroyAfter  /*0x04000508*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float DestroyAfter::destroyAfter  /*0x04000508*/
    IL_0012: ldarg.0
    IL_0013: ldfld float DestroyAfter::destroyAfter  /*0x04000508*/
    IL_0018: ldc.r4 0f
    IL_001d: bgt.un.s IL_004a
    IL_001f: ldarg.0
    IL_0020: ldfld bool DestroyAfter::isPooledItem  /*0x0400050A*/
    IL_0025: brfalse.s IL_003f
    IL_0027: ldarg.0
    IL_0028: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002d: call void ObjectPools::ReleasePooledItemByObject(UnityEngine.GameObject)  /*0x06000E9B*/
    IL_0032: ldarg.0
    IL_0033: ldarg.0
    IL_0034: ldfld float DestroyAfter::resetTimer  /*0x04000509*/
    IL_0039: stfld float DestroyAfter::destroyAfter  /*0x04000508*/
    IL_003e: ret
    IL_003f: ldarg.0
    IL_0040: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0045: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_004a: ret

  .method DestroyAfter::.ctor()  // token 0x060003E6 rva 0x111d3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 5f
    IL_0006: stfld float DestroyAfter::destroyAfter  /*0x04000508*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

