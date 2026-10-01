// ===== TitleScreenPopUpHelper  (token 0x02000367) =====
  .method TitleScreenPopUpHelper::PopNext()  // token 0x060012BB rva 0x591a2 attrs Public, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call IEnumerator TitleScreenPopUpHelper::DelayedPopUp()  /*0x060012BC*/
    IL_0007: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_000c: pop
    IL_000d: ret

  .method TitleScreenPopUpHelper::DelayedPopUp()  // token 0x060012BC rva 0x591b1 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void TitleScreenPopUpHelper.<DelayedPopUp>d__4::.ctor(int)  /*0x060012BE*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld TitleScreenPopUpHelper TitleScreenPopUpHelper.<DelayedPopUp>d__4::<>4__this  /*0x04001697*/
    IL_000d: ret

  .method TitleScreenPopUpHelper::.ctor()  // token 0x060012BD rva 0x591c0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<BeforeGamePopUp>::.ctor()  /*0x0A000723*/
    IL_0006: stfld List<BeforeGamePopUp> TitleScreenPopUpHelper::popUpOrder  /*0x04001694*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== TitleScreenPopUpHelper/<DelayedPopUp>d__4  (token 0x02000368) =====
  .method TitleScreenPopUpHelper.<DelayedPopUp>d__4::.ctor(int)  // token 0x060012BE rva 0x591d3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int TitleScreenPopUpHelper.<DelayedPopUp>d__4::<>1__state  /*0x04001695*/
    IL_000d: ret

  .method TitleScreenPopUpHelper.<DelayedPopUp>d__4::System.IDisposable.Dispose()  // token 0x060012BF rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TitleScreenPopUpHelper.<DelayedPopUp>d__4::MoveNext()  // token 0x060012C0 rva 0x591e4 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 272 (0x110), max stack 3, init locals
    .locals ([0] int, [1] TitleScreenPopUpHelper, [2] bool)
    IL_0000: ldarg.0
    IL_0001: ldfld int TitleScreenPopUpHelper.<DelayedPopUp>d__4::<>1__state  /*0x04001695*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld TitleScreenPopUpHelper TitleScreenPopUpHelper.<DelayedPopUp>d__4::<>4__this  /*0x04001697*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_002e
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int TitleScreenPopUpHelper.<DelayedPopUp>d__4::<>1__state  /*0x04001695*/
    IL_001e: ldarg.0
    IL_001f: ldnull
    IL_0020: stfld object TitleScreenPopUpHelper.<DelayedPopUp>d__4::<>2__current  /*0x04001696*/
    IL_0025: ldarg.0
    IL_0026: ldc.i4.1
    IL_0027: stfld int TitleScreenPopUpHelper.<DelayedPopUp>d__4::<>1__state  /*0x04001695*/
    IL_002c: ldc.i4.1
    IL_002d: ret
    IL_002e: ldarg.0
    IL_002f: ldc.i4.m1
    IL_0030: stfld int TitleScreenPopUpHelper.<DelayedPopUp>d__4::<>1__state  /*0x04001695*/
    IL_0035: ldloc.1
    IL_0036: ldfld int TitleScreenPopUpHelper::currentIndex  /*0x04001693*/
    IL_003b: ldloc.1
    IL_003c: ldfld List<BeforeGamePopUp> TitleScreenPopUpHelper::popUpOrder  /*0x04001694*/
    IL_0041: callvirt int System.Collections.Generic.List<BeforeGamePopUp>::get_Count()  /*0x0A000724*/
    IL_0046: bge IL_00ff
    IL_004b: ldc.i4.1
    IL_004c: stloc.2
    IL_004d: ldloc.1
    IL_004e: ldfld List<BeforeGamePopUp> TitleScreenPopUpHelper::popUpOrder  /*0x04001694*/
    IL_0053: ldloc.1
    IL_0054: ldfld int TitleScreenPopUpHelper::currentIndex  /*0x04001693*/
    IL_0059: callvirt !0 System.Collections.Generic.List<BeforeGamePopUp>::get_Item(int)  /*0x0A000725*/
    IL_005e: ldfld bool BeforeGamePopUp::onlyShowOnce  /*0x0400169B*/
    IL_0063: brfalse.s IL_00b6
    IL_0065: ldstr "PopupShown_"
    IL_006a: ldloc.1
    IL_006b: ldfld List<BeforeGamePopUp> TitleScreenPopUpHelper::popUpOrder  /*0x04001694*/
    IL_0070: ldloc.1
    IL_0071: ldfld int TitleScreenPopUpHelper::currentIndex  /*0x04001693*/
    IL_0076: callvirt !0 System.Collections.Generic.List<BeforeGamePopUp>::get_Item(int)  /*0x0A000725*/
    IL_007b: ldfld string BeforeGamePopUp::identifier  /*0x0400169C*/
    IL_0080: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0085: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_008a: brfalse.s IL_0090
    IL_008c: ldc.i4.0
    IL_008d: stloc.2
    IL_008e: br.s IL_00b6
    IL_0090: ldstr "PopupShown_"
    IL_0095: ldloc.1
    IL_0096: ldfld List<BeforeGamePopUp> TitleScreenPopUpHelper::popUpOrder  /*0x04001694*/
    IL_009b: ldloc.1
    IL_009c: ldfld int TitleScreenPopUpHelper::currentIndex  /*0x04001693*/
    IL_00a1: callvirt !0 System.Collections.Generic.List<BeforeGamePopUp>::get_Item(int)  /*0x0A000725*/
    IL_00a6: ldfld string BeforeGamePopUp::identifier  /*0x0400169C*/
    IL_00ab: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00b0: ldc.i4.1
    IL_00b1: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_00b6: ldloc.2
    IL_00b7: brfalse.s IL_00f1
    IL_00b9: ldloc.1
    IL_00ba: ldfld List<BeforeGamePopUp> TitleScreenPopUpHelper::popUpOrder  /*0x04001694*/
    IL_00bf: ldloc.1
    IL_00c0: ldfld int TitleScreenPopUpHelper::currentIndex  /*0x04001693*/
    IL_00c5: callvirt !0 System.Collections.Generic.List<BeforeGamePopUp>::get_Item(int)  /*0x0A000725*/
    IL_00ca: ldfld bool BeforeGamePopUp::showInFullVersion  /*0x0400169A*/
    IL_00cf: brfalse.s IL_00f1
    IL_00d1: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_00d6: ldloc.1
    IL_00d7: ldfld List<BeforeGamePopUp> TitleScreenPopUpHelper::popUpOrder  /*0x04001694*/
    IL_00dc: ldloc.1
    IL_00dd: ldfld int TitleScreenPopUpHelper::currentIndex  /*0x04001693*/
    IL_00e2: callvirt !0 System.Collections.Generic.List<BeforeGamePopUp>::get_Item(int)  /*0x0A000725*/
    IL_00e7: ldfld UIFrame BeforeGamePopUp::uiFrame  /*0x04001698*/
    IL_00ec: callvirt void UIFrameManager::ChangeActiveFrameKeepOldVisible(UIFrame)  /*0x06001307*/
    IL_00f1: ldloc.1
    IL_00f2: ldloc.1
    IL_00f3: ldfld int TitleScreenPopUpHelper::currentIndex  /*0x04001693*/
    IL_00f8: ldc.i4.1
    IL_00f9: add
    IL_00fa: stfld int TitleScreenPopUpHelper::currentIndex  /*0x04001693*/
    IL_00ff: leave.s IL_010e
    IL_0101: pop
    IL_0102: ldstr "There was a problem with the pop-ups in TitleScreenPopUpHelper.cs"
    IL_0107: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_010c: leave.s IL_010e
    IL_010e: ldc.i4.0
    IL_010f: ret
    .try IL_0035-IL_0101 catch System.Object handler IL_0101-IL_010e

  .method TitleScreenPopUpHelper.<DelayedPopUp>d__4::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060012C1 rva 0x59310 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object TitleScreenPopUpHelper.<DelayedPopUp>d__4::<>2__current  /*0x04001696*/
    IL_0006: ret

  .method TitleScreenPopUpHelper.<DelayedPopUp>d__4::System.Collections.IEnumerator.Reset()  // token 0x060012C2 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method TitleScreenPopUpHelper.<DelayedPopUp>d__4::System.Collections.IEnumerator.get_Current()  // token 0x060012C3 rva 0x59310 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object TitleScreenPopUpHelper.<DelayedPopUp>d__4::<>2__current  /*0x04001696*/
    IL_0006: ret

