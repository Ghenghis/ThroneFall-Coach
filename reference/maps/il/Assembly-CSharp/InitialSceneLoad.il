// ===== InitialSceneLoad  (token 0x02000198) =====
  .method InitialSceneLoad::Start()  // token 0x0600084C rva 0x2888e attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call IEnumerator InitialSceneLoad::LoadFirstScene()  /*0x0600084D*/
    IL_0007: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_000c: pop
    IL_000d: ret

  .method InitialSceneLoad::LoadFirstScene()  // token 0x0600084D rva 0x2889d attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void InitialSceneLoad.<LoadFirstScene>d__1::.ctor(int)  /*0x0600084F*/
    IL_0006: ret

  .method InitialSceneLoad::.ctor()  // token 0x0600084E rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== InitialSceneLoad/<LoadFirstScene>d__1  (token 0x02000199) =====
  .method InitialSceneLoad.<LoadFirstScene>d__1::.ctor(int)  // token 0x0600084F rva 0x288a5 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int InitialSceneLoad.<LoadFirstScene>d__1::<>1__state  /*0x04000A60*/
    IL_000d: ret

  .method InitialSceneLoad.<LoadFirstScene>d__1::System.IDisposable.Dispose()  // token 0x06000850 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method InitialSceneLoad.<LoadFirstScene>d__1::MoveNext()  // token 0x06000851 rva 0x288b4 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 151 (0x97), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int InitialSceneLoad.<LoadFirstScene>d__1::<>1__state  /*0x04000A60*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: switch (IL_001b, IL_0032, IL_0081)
    IL_0019: ldc.i4.0
    IL_001a: ret
    IL_001b: ldarg.0
    IL_001c: ldc.i4.m1
    IL_001d: stfld int InitialSceneLoad.<LoadFirstScene>d__1::<>1__state  /*0x04000A60*/
    IL_0022: ldarg.0
    IL_0023: ldnull
    IL_0024: stfld object InitialSceneLoad.<LoadFirstScene>d__1::<>2__current  /*0x04000A61*/
    IL_0029: ldarg.0
    IL_002a: ldc.i4.1
    IL_002b: stfld int InitialSceneLoad.<LoadFirstScene>d__1::<>1__state  /*0x04000A60*/
    IL_0030: ldc.i4.1
    IL_0031: ret
    IL_0032: ldarg.0
    IL_0033: ldc.i4.m1
    IL_0034: stfld int InitialSceneLoad.<LoadFirstScene>d__1::<>1__state  /*0x04000A60*/
    IL_0039: ldarg.0
    IL_003a: ldc.i4.1
    IL_003b: call AsyncOperation UnityEngine.SceneManagement.SceneManager::LoadSceneAsync(int)  /*0x0A0003BD*/
    IL_0040: stfld AsyncOperation InitialSceneLoad.<LoadFirstScene>d__1::<LoadFirstSceneAsync>5__2  /*0x04000A62*/
    IL_0045: ldarg.0
    IL_0046: ldfld AsyncOperation InitialSceneLoad.<LoadFirstScene>d__1::<LoadFirstSceneAsync>5__2  /*0x04000A62*/
    IL_004b: ldc.i4.0
    IL_004c: callvirt void UnityEngine.AsyncOperation::set_allowSceneActivation(bool)  /*0x0A0003BE*/
    IL_0051: br.s IL_0088
    IL_0053: ldarg.0
    IL_0054: ldfld AsyncOperation InitialSceneLoad.<LoadFirstScene>d__1::<LoadFirstSceneAsync>5__2  /*0x04000A62*/
    IL_0059: callvirt float UnityEngine.AsyncOperation::get_progress()  /*0x0A0003BF*/
    IL_005e: ldc.r4 0.9f
    IL_0063: blt.un.s IL_0071
    IL_0065: ldarg.0
    IL_0066: ldfld AsyncOperation InitialSceneLoad.<LoadFirstScene>d__1::<LoadFirstSceneAsync>5__2  /*0x04000A62*/
    IL_006b: ldc.i4.1
    IL_006c: callvirt void UnityEngine.AsyncOperation::set_allowSceneActivation(bool)  /*0x0A0003BE*/
    IL_0071: ldarg.0
    IL_0072: ldnull
    IL_0073: stfld object InitialSceneLoad.<LoadFirstScene>d__1::<>2__current  /*0x04000A61*/
    IL_0078: ldarg.0
    IL_0079: ldc.i4.2
    IL_007a: stfld int InitialSceneLoad.<LoadFirstScene>d__1::<>1__state  /*0x04000A60*/
    IL_007f: ldc.i4.1
    IL_0080: ret
    IL_0081: ldarg.0
    IL_0082: ldc.i4.m1
    IL_0083: stfld int InitialSceneLoad.<LoadFirstScene>d__1::<>1__state  /*0x04000A60*/
    IL_0088: ldarg.0
    IL_0089: ldfld AsyncOperation InitialSceneLoad.<LoadFirstScene>d__1::<LoadFirstSceneAsync>5__2  /*0x04000A62*/
    IL_008e: callvirt bool UnityEngine.AsyncOperation::get_isDone()  /*0x0A0003C0*/
    IL_0093: brfalse.s IL_0053
    IL_0095: ldc.i4.0
    IL_0096: ret

  .method InitialSceneLoad.<LoadFirstScene>d__1::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000852 rva 0x28957 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object InitialSceneLoad.<LoadFirstScene>d__1::<>2__current  /*0x04000A61*/
    IL_0006: ret

  .method InitialSceneLoad.<LoadFirstScene>d__1::System.Collections.IEnumerator.Reset()  // token 0x06000853 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method InitialSceneLoad.<LoadFirstScene>d__1::System.Collections.IEnumerator.get_Current()  // token 0x06000854 rva 0x28957 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object InitialSceneLoad.<LoadFirstScene>d__1::<>2__current  /*0x04000A61*/
    IL_0006: ret

