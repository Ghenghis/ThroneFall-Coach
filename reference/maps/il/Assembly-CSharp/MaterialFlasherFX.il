// ===== MaterialFlasherFX  (token 0x02000173) =====
  .method MaterialFlasherFX::SetSelected(bool)  // token 0x06000780 rva 0x25520 attrs Public, HideBySig
    // code size 88 (0x58), max stack 2, init locals
    .locals ([0] List.Enumerator<MaterialFlasherFX.RendererMaterialPair>, [1] MaterialFlasherFX.RendererMaterialPair)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool MaterialFlasherFX::unitSelected  /*0x04000969*/
    IL_0007: ldarg.0
    IL_0008: ldfld List<MaterialFlasherFX.RendererMaterialPair> MaterialFlasherFX::targetRendererMaterialPairs  /*0x0400096A*/
    IL_000d: callvirt List.Enumerator<!0> System.Collections.Generic.List<MaterialFlasherFX.RendererMaterialPair>::GetEnumerator()  /*0x0A000368*/
    IL_0012: stloc.0
    IL_0013: br.s IL_003e
    IL_0015: ldloca.s 0
    IL_0017: call !0 System.Collections.Generic.List.Enumerator<MaterialFlasherFX.RendererMaterialPair>::get_Current()  /*0x0A000369*/
    IL_001c: stloc.1
    IL_001d: ldloc.1
    IL_001e: ldfld Renderer MaterialFlasherFX.RendererMaterialPair::renderer  /*0x0400096B*/
    IL_0023: ldarg.0
    IL_0024: ldfld bool MaterialFlasherFX::unitSelected  /*0x04000969*/
    IL_0029: brtrue.s IL_0033
    IL_002b: ldloc.1
    IL_002c: ldfld Material MaterialFlasherFX.RendererMaterialPair::originalMaterial  /*0x0400096C*/
    IL_0031: br.s IL_0039
    IL_0033: ldarg.0
    IL_0034: ldfld Material MaterialFlasherFX::unitSelectedMaterial  /*0x04000968*/
    IL_0039: callvirt void UnityEngine.Renderer::set_sharedMaterial(UnityEngine.Material)  /*0x0A000229*/
    IL_003e: ldloca.s 0
    IL_0040: call bool System.Collections.Generic.List.Enumerator<MaterialFlasherFX.RendererMaterialPair>::MoveNext()  /*0x0A00036A*/
    IL_0045: brtrue.s IL_0015
    IL_0047: leave.s IL_0057
    IL_0049: ldloca.s 0
    IL_004b: constrained. System.Collections.Generic.List.Enumerator<MaterialFlasherFX.RendererMaterialPair>  /*0x1B0000A4*/
    IL_0051: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0056: endfinally
    IL_0057: ret
    .try IL_0013-IL_0049 finally handler IL_0049-IL_0057

  .method MaterialFlasherFX::Start()  // token 0x06000781 rva 0x25594 attrs Private, HideBySig
    // code size 74 (0x4a), max stack 2, init locals
    .locals ([0] List.Enumerator<Renderer>, [1] Renderer)
    IL_0000: ldarg.0
    IL_0001: ldfld List<Renderer> MaterialFlasherFX::targetRenderers  /*0x04000965*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.Renderer>::GetEnumerator()  /*0x0A00036B*/
    IL_000b: stloc.0
    IL_000c: br.s IL_0030
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.Renderer>::get_Current()  /*0x0A00036C*/
    IL_0015: stloc.1
    IL_0016: ldloc.1
    IL_0017: ldnull
    IL_0018: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_001d: brtrue.s IL_0030
    IL_001f: ldarg.0
    IL_0020: ldfld List<MaterialFlasherFX.RendererMaterialPair> MaterialFlasherFX::targetRendererMaterialPairs  /*0x0400096A*/
    IL_0025: ldloc.1
    IL_0026: newobj void MaterialFlasherFX.RendererMaterialPair::.ctor(UnityEngine.Renderer)  /*0x06000785*/
    IL_002b: callvirt void System.Collections.Generic.List<MaterialFlasherFX.RendererMaterialPair>::Add(!0)  /*0x0A00036D*/
    IL_0030: ldloca.s 0
    IL_0032: call bool System.Collections.Generic.List.Enumerator<UnityEngine.Renderer>::MoveNext()  /*0x0A00036E*/
    IL_0037: brtrue.s IL_000e
    IL_0039: leave.s IL_0049
    IL_003b: ldloca.s 0
    IL_003d: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.Renderer>  /*0x1B0000A6*/
    IL_0043: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0048: endfinally
    IL_0049: ret
    .try IL_000c-IL_003b finally handler IL_003b-IL_0049

  .method MaterialFlasherFX::FlashAnimation(float,UnityEngine.Material)  // token 0x06000782 rva 0x255fc attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void MaterialFlasherFX.<FlashAnimation>d__9::.ctor(int)  /*0x06000786*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld MaterialFlasherFX MaterialFlasherFX.<FlashAnimation>d__9::<>4__this  /*0x0400096F*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float MaterialFlasherFX.<FlashAnimation>d__9::flashTime  /*0x04000971*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld Material MaterialFlasherFX.<FlashAnimation>d__9::mat  /*0x04000970*/
    IL_001b: ret

  .method MaterialFlasherFX::TriggerFlash(bool,float)  // token 0x06000783 rva 0x25619 attrs Public, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.1
    IL_0007: brfalse.s IL_001e
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: ldarg.2
    IL_000c: ldarg.0
    IL_000d: ldfld Material MaterialFlasherFX::specialFlashMaterial  /*0x04000967*/
    IL_0012: call IEnumerator MaterialFlasherFX::FlashAnimation(float,UnityEngine.Material)  /*0x06000782*/
    IL_0017: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_001c: pop
    IL_001d: ret
    IL_001e: ldarg.0
    IL_001f: ldarg.0
    IL_0020: ldarg.2
    IL_0021: ldarg.0
    IL_0022: ldfld Material MaterialFlasherFX::flashMaterial  /*0x04000966*/
    IL_0027: call IEnumerator MaterialFlasherFX::FlashAnimation(float,UnityEngine.Material)  /*0x06000782*/
    IL_002c: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0031: pop
    IL_0032: ret

  .method MaterialFlasherFX::.ctor()  // token 0x06000784 rva 0x2564d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<MaterialFlasherFX.RendererMaterialPair>::.ctor()  /*0x0A00036F*/
    IL_0006: stfld List<MaterialFlasherFX.RendererMaterialPair> MaterialFlasherFX::targetRendererMaterialPairs  /*0x0400096A*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== MaterialFlasherFX/RendererMaterialPair  (token 0x02000174) =====
  .method MaterialFlasherFX.RendererMaterialPair::.ctor(UnityEngine.Renderer)  // token 0x06000785 rva 0x25660 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld Renderer MaterialFlasherFX.RendererMaterialPair::renderer  /*0x0400096B*/
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld Renderer MaterialFlasherFX.RendererMaterialPair::renderer  /*0x0400096B*/
    IL_0014: callvirt Material UnityEngine.Renderer::get_sharedMaterial()  /*0x0A0002B3*/
    IL_0019: stfld Material MaterialFlasherFX.RendererMaterialPair::originalMaterial  /*0x0400096C*/
    IL_001e: ret

// ===== MaterialFlasherFX/<FlashAnimation>d__9  (token 0x02000175) =====
  .method MaterialFlasherFX.<FlashAnimation>d__9::.ctor(int)  // token 0x06000786 rva 0x25680 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int MaterialFlasherFX.<FlashAnimation>d__9::<>1__state  /*0x0400096D*/
    IL_000d: ret

  .method MaterialFlasherFX.<FlashAnimation>d__9::System.IDisposable.Dispose()  // token 0x06000787 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method MaterialFlasherFX.<FlashAnimation>d__9::MoveNext()  // token 0x06000788 rva 0x25690 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 207 (0xcf), max stack 2, init locals
    .locals ([0] int, [1] MaterialFlasherFX, [2] List.Enumerator<MaterialFlasherFX.RendererMaterialPair>, [3] MaterialFlasherFX.RendererMaterialPair)
    IL_0000: ldarg.0
    IL_0001: ldfld int MaterialFlasherFX.<FlashAnimation>d__9::<>1__state  /*0x0400096D*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld MaterialFlasherFX MaterialFlasherFX.<FlashAnimation>d__9::<>4__this  /*0x0400096F*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0076
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int MaterialFlasherFX.<FlashAnimation>d__9::<>1__state  /*0x0400096D*/
    IL_001e: ldloc.1
    IL_001f: ldfld List<MaterialFlasherFX.RendererMaterialPair> MaterialFlasherFX::targetRendererMaterialPairs  /*0x0400096A*/
    IL_0024: callvirt List.Enumerator<!0> System.Collections.Generic.List<MaterialFlasherFX.RendererMaterialPair>::GetEnumerator()  /*0x0A000368*/
    IL_0029: stloc.2
    IL_002a: br.s IL_0043
    IL_002c: ldloca.s 2
    IL_002e: call !0 System.Collections.Generic.List.Enumerator<MaterialFlasherFX.RendererMaterialPair>::get_Current()  /*0x0A000369*/
    IL_0033: ldfld Renderer MaterialFlasherFX.RendererMaterialPair::renderer  /*0x0400096B*/
    IL_0038: ldarg.0
    IL_0039: ldfld Material MaterialFlasherFX.<FlashAnimation>d__9::mat  /*0x04000970*/
    IL_003e: callvirt void UnityEngine.Renderer::set_sharedMaterial(UnityEngine.Material)  /*0x0A000229*/
    IL_0043: ldloca.s 2
    IL_0045: call bool System.Collections.Generic.List.Enumerator<MaterialFlasherFX.RendererMaterialPair>::MoveNext()  /*0x0A00036A*/
    IL_004a: brtrue.s IL_002c
    IL_004c: leave.s IL_005c
    IL_004e: ldloca.s 2
    IL_0050: constrained. System.Collections.Generic.List.Enumerator<MaterialFlasherFX.RendererMaterialPair>  /*0x1B0000A4*/
    IL_0056: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_005b: endfinally
    IL_005c: ldarg.0
    IL_005d: ldarg.0
    IL_005e: ldfld float MaterialFlasherFX.<FlashAnimation>d__9::flashTime  /*0x04000971*/
    IL_0063: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0068: stfld object MaterialFlasherFX.<FlashAnimation>d__9::<>2__current  /*0x0400096E*/
    IL_006d: ldarg.0
    IL_006e: ldc.i4.1
    IL_006f: stfld int MaterialFlasherFX.<FlashAnimation>d__9::<>1__state  /*0x0400096D*/
    IL_0074: ldc.i4.1
    IL_0075: ret
    IL_0076: ldarg.0
    IL_0077: ldc.i4.m1
    IL_0078: stfld int MaterialFlasherFX.<FlashAnimation>d__9::<>1__state  /*0x0400096D*/
    IL_007d: ldloc.1
    IL_007e: ldfld List<MaterialFlasherFX.RendererMaterialPair> MaterialFlasherFX::targetRendererMaterialPairs  /*0x0400096A*/
    IL_0083: callvirt List.Enumerator<!0> System.Collections.Generic.List<MaterialFlasherFX.RendererMaterialPair>::GetEnumerator()  /*0x0A000368*/
    IL_0088: stloc.2
    IL_0089: br.s IL_00b4
    IL_008b: ldloca.s 2
    IL_008d: call !0 System.Collections.Generic.List.Enumerator<MaterialFlasherFX.RendererMaterialPair>::get_Current()  /*0x0A000369*/
    IL_0092: stloc.3
    IL_0093: ldloc.3
    IL_0094: ldfld Renderer MaterialFlasherFX.RendererMaterialPair::renderer  /*0x0400096B*/
    IL_0099: ldloc.1
    IL_009a: ldfld bool MaterialFlasherFX::unitSelected  /*0x04000969*/
    IL_009f: brtrue.s IL_00a9
    IL_00a1: ldloc.3
    IL_00a2: ldfld Material MaterialFlasherFX.RendererMaterialPair::originalMaterial  /*0x0400096C*/
    IL_00a7: br.s IL_00af
    IL_00a9: ldloc.1
    IL_00aa: ldfld Material MaterialFlasherFX::unitSelectedMaterial  /*0x04000968*/
    IL_00af: callvirt void UnityEngine.Renderer::set_sharedMaterial(UnityEngine.Material)  /*0x0A000229*/
    IL_00b4: ldloca.s 2
    IL_00b6: call bool System.Collections.Generic.List.Enumerator<MaterialFlasherFX.RendererMaterialPair>::MoveNext()  /*0x0A00036A*/
    IL_00bb: brtrue.s IL_008b
    IL_00bd: leave.s IL_00cd
    IL_00bf: ldloca.s 2
    IL_00c1: constrained. System.Collections.Generic.List.Enumerator<MaterialFlasherFX.RendererMaterialPair>  /*0x1B0000A4*/
    IL_00c7: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00cc: endfinally
    IL_00cd: ldc.i4.0
    IL_00ce: ret
    .try IL_002a-IL_004e finally handler IL_004e-IL_005c
    .try IL_0089-IL_00bf finally handler IL_00bf-IL_00cd

  .method MaterialFlasherFX.<FlashAnimation>d__9::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000789 rva 0x25788 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object MaterialFlasherFX.<FlashAnimation>d__9::<>2__current  /*0x0400096E*/
    IL_0006: ret

  .method MaterialFlasherFX.<FlashAnimation>d__9::System.Collections.IEnumerator.Reset()  // token 0x0600078A rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method MaterialFlasherFX.<FlashAnimation>d__9::System.Collections.IEnumerator.get_Current()  // token 0x0600078B rva 0x25788 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object MaterialFlasherFX.<FlashAnimation>d__9::<>2__current  /*0x0400096E*/
    IL_0006: ret

