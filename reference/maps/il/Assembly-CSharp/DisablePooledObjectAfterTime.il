// ===== DisablePooledObjectAfterTime  (token 0x020002A3) =====
  .method DisablePooledObjectAfterTime::ResetDisabledObject()  // token 0x06000E8C rva 0x4124e attrs Public, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void DisablePooledObjectAfterTime::InterruptDisableCoroutine()  /*0x06000E8D*/
    IL_0006: ldarg.0
    IL_0007: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000c: ldc.i4.1
    IL_000d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0012: ret

  .method DisablePooledObjectAfterTime::InterruptDisableCoroutine()  // token 0x06000E8D rva 0x41262 attrs Private, HideBySig
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Coroutine DisablePooledObjectAfterTime::disableCoroutine  /*0x040010DD*/
    IL_0006: brfalse.s IL_0027
    IL_0008: ldarg.0
    IL_0009: ldarg.0
    IL_000a: ldfld Coroutine DisablePooledObjectAfterTime::disableCoroutine  /*0x040010DD*/
    IL_000f: call void UnityEngine.MonoBehaviour::StopCoroutine(UnityEngine.Coroutine)  /*0x0A000114*/
    IL_0014: ldarg.0
    IL_0015: ldnull
    IL_0016: stfld Coroutine DisablePooledObjectAfterTime::disableCoroutine  /*0x040010DD*/
    IL_001b: ldarg.0
    IL_001c: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0021: ldc.i4.0
    IL_0022: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0027: ret

  .method DisablePooledObjectAfterTime::DisableAfter(float)  // token 0x06000E8E rva 0x4128b attrs Public, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_000b: brfalse.s IL_0020
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: ldarg.1
    IL_0011: call IEnumerator DisablePooledObjectAfterTime::CoroutineDisableAfter(float)  /*0x06000E8F*/
    IL_0016: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_001b: stfld Coroutine DisablePooledObjectAfterTime::disableCoroutine  /*0x040010DD*/
    IL_0020: ret

  .method DisablePooledObjectAfterTime::CoroutineDisableAfter(float)  // token 0x06000E8F rva 0x412ad attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::.ctor(int)  /*0x06000E91*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld DisablePooledObjectAfterTime DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::<>4__this  /*0x040010E1*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::seconds  /*0x040010E0*/
    IL_0014: ret

  .method DisablePooledObjectAfterTime::.ctor()  // token 0x06000E90 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== DisablePooledObjectAfterTime/<CoroutineDisableAfter>d__4  (token 0x020002A4) =====
  .method DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::.ctor(int)  // token 0x06000E91 rva 0x412c3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::<>1__state  /*0x040010DE*/
    IL_000d: ret

  .method DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::System.IDisposable.Dispose()  // token 0x06000E92 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::MoveNext()  // token 0x06000E93 rva 0x412d4 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 77 (0x4d), max stack 2, init locals
    .locals ([0] int, [1] DisablePooledObjectAfterTime)
    IL_0000: ldarg.0
    IL_0001: ldfld int DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::<>1__state  /*0x040010DE*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld DisablePooledObjectAfterTime DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::<>4__this  /*0x040010E1*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0038
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::<>1__state  /*0x040010DE*/
    IL_001e: ldarg.0
    IL_001f: ldarg.0
    IL_0020: ldfld float DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::seconds  /*0x040010E0*/
    IL_0025: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_002a: stfld object DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::<>2__current  /*0x040010DF*/
    IL_002f: ldarg.0
    IL_0030: ldc.i4.1
    IL_0031: stfld int DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::<>1__state  /*0x040010DE*/
    IL_0036: ldc.i4.1
    IL_0037: ret
    IL_0038: ldarg.0
    IL_0039: ldc.i4.m1
    IL_003a: stfld int DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::<>1__state  /*0x040010DE*/
    IL_003f: ldloc.1
    IL_0040: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0045: ldc.i4.0
    IL_0046: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_004b: ldc.i4.0
    IL_004c: ret

  .method DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000E94 rva 0x4132d attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::<>2__current  /*0x040010DF*/
    IL_0006: ret

  .method DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::System.Collections.IEnumerator.Reset()  // token 0x06000E95 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::System.Collections.IEnumerator.get_Current()  // token 0x06000E96 rva 0x4132d attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object DisablePooledObjectAfterTime.<CoroutineDisableAfter>d__4::<>2__current  /*0x040010DF*/
    IL_0006: ret

