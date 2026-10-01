// ===== ProductionBar  (token 0x0200024B) =====
  .method ProductionBar::UpdateVisual(float)  // token 0x06000C97 rva 0x39d66 attrs Public, HideBySig
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float ProductionBar::fillAmount  /*0x04000F41*/
    IL_0006: ldarg.1
    IL_0007: bne.un.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldfld GameObject ProductionBar::canvasParent  /*0x04000F3F*/
    IL_0010: ldarg.1
    IL_0011: ldc.r4 0f
    IL_0016: cgt
    IL_0018: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001d: ldarg.0
    IL_001e: ldfld MPImage ProductionBar::fill  /*0x04000F40*/
    IL_0023: ldarg.1
    IL_0024: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_0029: ldarg.0
    IL_002a: ldarg.1
    IL_002b: stfld float ProductionBar::fillAmount  /*0x04000F41*/
    IL_0030: ret

  .method ProductionBar::.ctor()  // token 0x06000C98 rva 0x39d98 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 -1f
    IL_0006: stfld float ProductionBar::fillAmount  /*0x04000F41*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

