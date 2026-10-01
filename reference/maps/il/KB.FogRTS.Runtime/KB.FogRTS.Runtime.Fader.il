// ===== KB.FogRTS.Runtime.Fader  (token 0x0200000B) =====
  .method KB.FogRTS.Runtime.Fader::get_IsFinished()  // token 0x0600003F rva 0x3009 attrs Private, HideBySig, SpecialName
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float KB.FogRTS.Runtime.Fader::fadePercent  /*0x0400003B*/
    IL_0006: ldc.r4 0f
    IL_000b: ble.s IL_001e
    IL_000d: ldarg.0
    IL_000e: ldfld float KB.FogRTS.Runtime.Fader::fadePercent  /*0x0400003B*/
    IL_0013: ldc.r4 1f
    IL_0018: clt.un
    IL_001a: ldc.i4.0
    IL_001b: ceq
    IL_001d: ret
    IL_001e: ldc.i4.1
    IL_001f: ret

  .method KB.FogRTS.Runtime.Fader::UpdateFade(float)  // token 0x06000040 rva 0x302c attrs Assembly, HideBySig
    // code size 122 (0x7a), max stack 4, init locals
    .locals ([0] int, [1] Renderer[], [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld VisibilitySwitch KB.FogRTS.Runtime.Fader::visibilitySwitch  /*0x04000038*/
    IL_0006: callvirt bool KB.FogRTS.Runtime.VisibilitySwitch::get_IsVisible()  /*0x0600006B*/
    IL_000b: brtrue.s IL_0010
    IL_000d: ldc.i4.m1
    IL_000e: br.s IL_0011
    IL_0010: ldc.i4.1
    IL_0011: stloc.0
    IL_0012: ldarg.0
    IL_0013: ldarg.0
    IL_0014: ldfld float KB.FogRTS.Runtime.Fader::fadePercent  /*0x0400003B*/
    IL_0019: ldarg.1
    IL_001a: ldloc.0
    IL_001b: conv.r4
    IL_001c: mul
    IL_001d: ldarg.0
    IL_001e: ldfld float KB.FogRTS.Runtime.Fader::fadeDuration  /*0x04000035*/
    IL_0023: div
    IL_0024: add
    IL_0025: stfld float KB.FogRTS.Runtime.Fader::fadePercent  /*0x0400003B*/
    IL_002a: ldarg.0
    IL_002b: call bool KB.FogRTS.Runtime.Fader::get_IsFinished()  /*0x0600003F*/
    IL_0030: brfalse.s IL_003f
    IL_0032: ldarg.0
    IL_0033: call void KB.FogRTS.Runtime.FaderContainer::Remove(KB.FogRTS.Runtime.Fader)  /*0x06000016*/
    IL_0038: ldarg.0
    IL_0039: call void KB.FogRTS.Runtime.Fader::FinishFade()  /*0x06000044*/
    IL_003e: ret
    IL_003f: ldarg.0
    IL_0040: ldfld MaterialPropertyBlock KB.FogRTS.Runtime.Fader::materialPropertyBlock  /*0x0400003A*/
    IL_0045: ldarg.0
    IL_0046: ldfld int KB.FogRTS.Runtime.Fader::fadePercentID  /*0x04000039*/
    IL_004b: ldarg.0
    IL_004c: ldfld float KB.FogRTS.Runtime.Fader::fadePercent  /*0x0400003B*/
    IL_0051: callvirt void UnityEngine.MaterialPropertyBlock::SetFloat(int,float)  /*0x0A00008C*/
    IL_0056: ldarg.0
    IL_0057: ldfld Renderer[] KB.FogRTS.Runtime.Fader::renderers  /*0x04000037*/
    IL_005c: stloc.1
    IL_005d: ldc.i4.0
    IL_005e: stloc.2
    IL_005f: br.s IL_0073
    IL_0061: ldloc.1
    IL_0062: ldloc.2
    IL_0063: ldelem.ref
    IL_0064: ldarg.0
    IL_0065: ldfld MaterialPropertyBlock KB.FogRTS.Runtime.Fader::materialPropertyBlock  /*0x0400003A*/
    IL_006a: callvirt void UnityEngine.Renderer::SetPropertyBlock(UnityEngine.MaterialPropertyBlock)  /*0x0A00008D*/
    IL_006f: ldloc.2
    IL_0070: ldc.i4.1
    IL_0071: add
    IL_0072: stloc.2
    IL_0073: ldloc.2
    IL_0074: ldloc.1
    IL_0075: ldlen
    IL_0076: conv.i4
    IL_0077: blt.s IL_0061
    IL_0079: ret

  .method KB.FogRTS.Runtime.Fader::Awake()  // token 0x06000041 rva 0x30b2 attrs Private, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<KB.FogRTS.Runtime.VisibilitySwitch>  /*0x2B000007*/
    IL_0007: stfld VisibilitySwitch KB.FogRTS.Runtime.Fader::visibilitySwitch  /*0x04000038*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: ldfld string KB.FogRTS.Runtime.Fader::materialFadePercentName  /*0x04000036*/
    IL_0013: call int UnityEngine.Shader::PropertyToID(string)  /*0x0A000077*/
    IL_0018: stfld int KB.FogRTS.Runtime.Fader::fadePercentID  /*0x04000039*/
    IL_001d: ldarg.0
    IL_001e: newobj void UnityEngine.MaterialPropertyBlock::.ctor()  /*0x0A00008F*/
    IL_0023: stfld MaterialPropertyBlock KB.FogRTS.Runtime.Fader::materialPropertyBlock  /*0x0400003A*/
    IL_0028: ret

  .method KB.FogRTS.Runtime.Fader::OnEnable()  // token 0x06000042 rva 0x30dc attrs Private, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld VisibilitySwitch KB.FogRTS.Runtime.Fader::visibilitySwitch  /*0x04000038*/
    IL_0006: ldarg.0
    IL_0007: ldftn void KB.FogRTS.Runtime.Fader::OnFadeTriggered(bool)  /*0x06000045*/
    IL_000d: newobj void System.Action<bool>::.ctor(object,IntPtr)  /*0x0A000090*/
    IL_0012: callvirt void KB.FogRTS.Runtime.VisibilitySwitch::add_TriggerFader(System.Action<bool>)  /*0x06000069*/
    IL_0017: ret

  .method KB.FogRTS.Runtime.Fader::OnDisable()  // token 0x06000043 rva 0x30f5 attrs Private, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld VisibilitySwitch KB.FogRTS.Runtime.Fader::visibilitySwitch  /*0x04000038*/
    IL_0006: ldarg.0
    IL_0007: ldftn void KB.FogRTS.Runtime.Fader::OnFadeTriggered(bool)  /*0x06000045*/
    IL_000d: newobj void System.Action<bool>::.ctor(object,IntPtr)  /*0x0A000090*/
    IL_0012: callvirt void KB.FogRTS.Runtime.VisibilitySwitch::remove_TriggerFader(System.Action<bool>)  /*0x0600006A*/
    IL_0017: ldarg.0
    IL_0018: call bool KB.FogRTS.Runtime.Fader::get_IsFinished()  /*0x0600003F*/
    IL_001d: brtrue.s IL_002b
    IL_001f: ldarg.0
    IL_0020: call void KB.FogRTS.Runtime.FaderContainer::Remove(KB.FogRTS.Runtime.Fader)  /*0x06000016*/
    IL_0025: ldarg.0
    IL_0026: call void KB.FogRTS.Runtime.Fader::FinishFade()  /*0x06000044*/
    IL_002b: ret

  .method KB.FogRTS.Runtime.Fader::FinishFade()  // token 0x06000044 rva 0x3124 attrs Private, HideBySig
    // code size 100 (0x64), max stack 3, init locals
    .locals ([0] Renderer[], [1] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld VisibilitySwitch KB.FogRTS.Runtime.Fader::visibilitySwitch  /*0x04000038*/
    IL_0007: callvirt bool KB.FogRTS.Runtime.VisibilitySwitch::get_IsVisible()  /*0x0600006B*/
    IL_000c: brtrue.s IL_0011
    IL_000e: ldc.i4.0
    IL_000f: br.s IL_0012
    IL_0011: ldc.i4.1
    IL_0012: conv.r4
    IL_0013: stfld float KB.FogRTS.Runtime.Fader::fadePercent  /*0x0400003B*/
    IL_0018: ldarg.0
    IL_0019: ldfld MaterialPropertyBlock KB.FogRTS.Runtime.Fader::materialPropertyBlock  /*0x0400003A*/
    IL_001e: ldarg.0
    IL_001f: ldfld int KB.FogRTS.Runtime.Fader::fadePercentID  /*0x04000039*/
    IL_0024: ldarg.0
    IL_0025: ldfld float KB.FogRTS.Runtime.Fader::fadePercent  /*0x0400003B*/
    IL_002a: callvirt void UnityEngine.MaterialPropertyBlock::SetFloat(int,float)  /*0x0A00008C*/
    IL_002f: ldarg.0
    IL_0030: ldfld Renderer[] KB.FogRTS.Runtime.Fader::renderers  /*0x04000037*/
    IL_0035: stloc.0
    IL_0036: ldc.i4.0
    IL_0037: stloc.1
    IL_0038: br.s IL_005d
    IL_003a: ldloc.0
    IL_003b: ldloc.1
    IL_003c: ldelem.ref
    IL_003d: dup
    IL_003e: ldarg.0
    IL_003f: ldfld MaterialPropertyBlock KB.FogRTS.Runtime.Fader::materialPropertyBlock  /*0x0400003A*/
    IL_0044: callvirt void UnityEngine.Renderer::SetPropertyBlock(UnityEngine.MaterialPropertyBlock)  /*0x0A00008D*/
    IL_0049: ldarg.0
    IL_004a: ldfld VisibilitySwitch KB.FogRTS.Runtime.Fader::visibilitySwitch  /*0x04000038*/
    IL_004f: callvirt bool KB.FogRTS.Runtime.VisibilitySwitch::get_IsVisible()  /*0x0600006B*/
    IL_0054: callvirt void UnityEngine.Renderer::set_enabled(bool)  /*0x0A000091*/
    IL_0059: ldloc.1
    IL_005a: ldc.i4.1
    IL_005b: add
    IL_005c: stloc.1
    IL_005d: ldloc.1
    IL_005e: ldloc.0
    IL_005f: ldlen
    IL_0060: conv.i4
    IL_0061: blt.s IL_003a
    IL_0063: ret

  .method KB.FogRTS.Runtime.Fader::OnFadeTriggered(bool)  // token 0x06000045 rva 0x3194 attrs Private, HideBySig
    // code size 82 (0x52), max stack 2, init locals
    .locals ([0] Renderer[], [1] int)
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_0018
    IL_0003: ldarg.0
    IL_0004: call bool KB.FogRTS.Runtime.Fader::get_IsFinished()  /*0x0600003F*/
    IL_0009: brtrue.s IL_0011
    IL_000b: ldarg.0
    IL_000c: call void KB.FogRTS.Runtime.FaderContainer::Remove(KB.FogRTS.Runtime.Fader)  /*0x06000016*/
    IL_0011: ldarg.0
    IL_0012: call void KB.FogRTS.Runtime.Fader::FinishFade()  /*0x06000044*/
    IL_0017: ret
    IL_0018: ldarg.0
    IL_0019: call bool KB.FogRTS.Runtime.Fader::get_IsFinished()  /*0x0600003F*/
    IL_001e: brfalse.s IL_0051
    IL_0020: ldarg.0
    IL_0021: ldfld float KB.FogRTS.Runtime.Fader::fadePercent  /*0x0400003B*/
    IL_0026: ldc.r4 0f
    IL_002b: bne.un.s IL_004b
    IL_002d: ldarg.0
    IL_002e: ldfld Renderer[] KB.FogRTS.Runtime.Fader::renderers  /*0x04000037*/
    IL_0033: stloc.0
    IL_0034: ldc.i4.0
    IL_0035: stloc.1
    IL_0036: br.s IL_0045
    IL_0038: ldloc.0
    IL_0039: ldloc.1
    IL_003a: ldelem.ref
    IL_003b: ldc.i4.1
    IL_003c: callvirt void UnityEngine.Renderer::set_enabled(bool)  /*0x0A000091*/
    IL_0041: ldloc.1
    IL_0042: ldc.i4.1
    IL_0043: add
    IL_0044: stloc.1
    IL_0045: ldloc.1
    IL_0046: ldloc.0
    IL_0047: ldlen
    IL_0048: conv.i4
    IL_0049: blt.s IL_0038
    IL_004b: ldarg.0
    IL_004c: call void KB.FogRTS.Runtime.FaderContainer::Add(KB.FogRTS.Runtime.Fader)  /*0x06000015*/
    IL_0051: ret

  .method KB.FogRTS.Runtime.Fader::.ctor()  // token 0x06000046 rva 0x31f2 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.2f
    IL_0006: stfld float KB.FogRTS.Runtime.Fader::fadeDuration  /*0x04000035*/
    IL_000b: ldarg.0
    IL_000c: ldstr "_FadePercent"
    IL_0011: stfld string KB.FogRTS.Runtime.Fader::materialFadePercentName  /*0x04000036*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.1
    IL_0018: newarr UnityEngine.Renderer  /*0x01000035*/
    IL_001d: stfld Renderer[] KB.FogRTS.Runtime.Fader::renderers  /*0x04000037*/
    IL_0022: ldarg.0
    IL_0023: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000092*/
    IL_0028: ret

