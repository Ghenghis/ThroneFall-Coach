// ===== ChoiceManager  (token 0x020001C4) =====
  .method ChoiceManager::get_ChoiceCoroutineWaiting()  // token 0x0600091D rva 0x2b86f attrs Public, HideBySig, SpecialName
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ChoiceManager::choiceCanceled  /*0x04000B89*/
    IL_0006: brtrue.s IL_0012
    IL_0008: ldarg.0
    IL_0009: ldfld Choice ChoiceManager::choiceToReturn  /*0x04000B8B*/
    IL_000e: ldnull
    IL_000f: ceq
    IL_0011: ret
    IL_0012: ldc.i4.0
    IL_0013: ret

  .method ChoiceManager::get_ChoiceCoroutineRunning()  // token 0x0600091E rva 0x2b884 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ChoiceManager::choiceCoroutineRunning  /*0x04000B88*/
    IL_0006: ret

  .method ChoiceManager::CancelChoice()  // token 0x0600091F rva 0x2b88c attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool ChoiceManager::choiceCanceled  /*0x04000B89*/
    IL_0007: ret

  .method ChoiceManager::Awake()  // token 0x06000920 rva 0x2b895 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_0006: ret

  .method ChoiceManager::PresentChoices(System.Collections.Generic.List<Choice>,BuildSlot,System.Action<Choice>)  // token 0x06000921 rva 0x2b8a0 attrs Public, HideBySig
    // code size 88 (0x58), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool ChoiceManager::choiceCoroutineRunning  /*0x04000B88*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.2
    IL_000b: stfld BuildSlot ChoiceManager::currentOriginBuildSlot  /*0x04000B8C*/
    IL_0010: ldarg.1
    IL_0011: callvirt int System.Collections.Generic.List<Choice>::get_Count()  /*0x0A0003E1*/
    IL_0016: brtrue.s IL_0020
    IL_0018: ldarg.3
    IL_0019: ldnull
    IL_001a: callvirt void System.Action<Choice>::Invoke(!0)  /*0x0A0003E2*/
    IL_001f: ret
    IL_0020: ldarg.1
    IL_0021: callvirt int System.Collections.Generic.List<Choice>::get_Count()  /*0x0A0003E1*/
    IL_0026: ldc.i4.1
    IL_0027: bne.un.s IL_0037
    IL_0029: ldarg.3
    IL_002a: ldarg.1
    IL_002b: ldc.i4.0
    IL_002c: callvirt !0 System.Collections.Generic.List<Choice>::get_Item(int)  /*0x0A0003E3*/
    IL_0031: callvirt void System.Action<Choice>::Invoke(!0)  /*0x0A0003E2*/
    IL_0036: ret
    IL_0037: ldarg.0
    IL_0038: ldarg.1
    IL_0039: stfld List<Choice> ChoiceManager::availableChoices  /*0x04000B8A*/
    IL_003e: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0043: callvirt void UIFrameManager::PresentChoiceFrame()  /*0x06001317*/
    IL_0048: ldarg.0
    IL_0049: ldarg.0
    IL_004a: ldarg.1
    IL_004b: ldarg.3
    IL_004c: call IEnumerator ChoiceManager::Choice(System.Collections.Generic.List<Choice>,System.Action<Choice>)  /*0x06000922*/
    IL_0051: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0056: pop
    IL_0057: ret

  .method ChoiceManager::Choice(System.Collections.Generic.List<Choice>,System.Action<Choice>)  // token 0x06000922 rva 0x2b904 attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void ChoiceManager.<Choice>d__13::.ctor(int)  /*0x06000924*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld ChoiceManager ChoiceManager.<Choice>d__13::<>4__this  /*0x04000B8F*/
    IL_000d: dup
    IL_000e: ldarg.2
    IL_000f: stfld Action<Choice> ChoiceManager.<Choice>d__13::_onCompleteFunction  /*0x04000B90*/
    IL_0014: ret

  .method ChoiceManager::.ctor()  // token 0x06000923 rva 0x2b91a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<Choice>::.ctor()  /*0x0A000134*/
    IL_0006: stfld List<Choice> ChoiceManager::availableChoices  /*0x04000B8A*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== ChoiceManager/<Choice>d__13  (token 0x020001C5) =====
  .method ChoiceManager.<Choice>d__13::.ctor(int)  // token 0x06000924 rva 0x2b92d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int ChoiceManager.<Choice>d__13::<>1__state  /*0x04000B8D*/
    IL_000d: ret

  .method ChoiceManager.<Choice>d__13::System.IDisposable.Dispose()  // token 0x06000925 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ChoiceManager.<Choice>d__13::MoveNext()  // token 0x06000926 rva 0x2b93c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 174 (0xae), max stack 2, init locals
    .locals ([0] int, [1] ChoiceManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int ChoiceManager.<Choice>d__13::<>1__state  /*0x04000B8D*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld ChoiceManager ChoiceManager.<Choice>d__13::<>4__this  /*0x04000B8F*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_005b, IL_008d)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int ChoiceManager.<Choice>d__13::<>1__state  /*0x04000B8D*/
    IL_0029: ldloc.1
    IL_002a: ldnull
    IL_002b: stfld Choice ChoiceManager::choiceToReturn  /*0x04000B8B*/
    IL_0030: ldloc.1
    IL_0031: ldc.i4.1
    IL_0032: stfld bool ChoiceManager::choiceCoroutineRunning  /*0x04000B88*/
    IL_0037: ldloc.1
    IL_0038: ldc.i4.0
    IL_0039: stfld bool ChoiceManager::choiceCanceled  /*0x04000B89*/
    IL_003e: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0043: ldc.i4.1
    IL_0044: callvirt void LocalGamestate::SetPlayerFreezeState(bool)  /*0x06000905*/
    IL_0049: br.s IL_0062
    IL_004b: ldarg.0
    IL_004c: ldnull
    IL_004d: stfld object ChoiceManager.<Choice>d__13::<>2__current  /*0x04000B8E*/
    IL_0052: ldarg.0
    IL_0053: ldc.i4.1
    IL_0054: stfld int ChoiceManager.<Choice>d__13::<>1__state  /*0x04000B8D*/
    IL_0059: ldc.i4.1
    IL_005a: ret
    IL_005b: ldarg.0
    IL_005c: ldc.i4.m1
    IL_005d: stfld int ChoiceManager.<Choice>d__13::<>1__state  /*0x04000B8D*/
    IL_0062: ldloc.1
    IL_0063: ldfld Choice ChoiceManager::choiceToReturn  /*0x04000B8B*/
    IL_0068: brtrue.s IL_0072
    IL_006a: ldloc.1
    IL_006b: ldfld bool ChoiceManager::choiceCanceled  /*0x04000B89*/
    IL_0070: brfalse.s IL_004b
    IL_0072: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0077: ldc.i4.0
    IL_0078: callvirt void LocalGamestate::SetPlayerFreezeState(bool)  /*0x06000905*/
    IL_007d: ldarg.0
    IL_007e: ldnull
    IL_007f: stfld object ChoiceManager.<Choice>d__13::<>2__current  /*0x04000B8E*/
    IL_0084: ldarg.0
    IL_0085: ldc.i4.2
    IL_0086: stfld int ChoiceManager.<Choice>d__13::<>1__state  /*0x04000B8D*/
    IL_008b: ldc.i4.1
    IL_008c: ret
    IL_008d: ldarg.0
    IL_008e: ldc.i4.m1
    IL_008f: stfld int ChoiceManager.<Choice>d__13::<>1__state  /*0x04000B8D*/
    IL_0094: ldarg.0
    IL_0095: ldfld Action<Choice> ChoiceManager.<Choice>d__13::_onCompleteFunction  /*0x04000B90*/
    IL_009a: ldloc.1
    IL_009b: ldfld Choice ChoiceManager::choiceToReturn  /*0x04000B8B*/
    IL_00a0: callvirt void System.Action<Choice>::Invoke(!0)  /*0x0A0003E2*/
    IL_00a5: ldloc.1
    IL_00a6: ldc.i4.0
    IL_00a7: stfld bool ChoiceManager::choiceCoroutineRunning  /*0x04000B88*/
    IL_00ac: ldc.i4.0
    IL_00ad: ret

  .method ChoiceManager.<Choice>d__13::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000927 rva 0x2b9f6 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object ChoiceManager.<Choice>d__13::<>2__current  /*0x04000B8E*/
    IL_0006: ret

  .method ChoiceManager.<Choice>d__13::System.Collections.IEnumerator.Reset()  // token 0x06000928 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method ChoiceManager.<Choice>d__13::System.Collections.IEnumerator.get_Current()  // token 0x06000929 rva 0x2b9f6 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object ChoiceManager.<Choice>d__13::<>2__current  /*0x04000B8E*/
    IL_0006: ret

