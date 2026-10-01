// ===== KB.FogRTS.Runtime.FaderContainer  (token 0x02000005) =====
  .method KB.FogRTS.Runtime.FaderContainer::Add(KB.FogRTS.Runtime.Fader)  // token 0x06000015 rva 0x2485 attrs Assembly, Static, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.FaderContainer>::GetInstance()  /*0x0A00002C*/
    IL_0005: ldfld HashSet<Fader> KB.FogRTS.Runtime.FaderContainer::faders  /*0x04000011*/
    IL_000a: ldarg.0
    IL_000b: callvirt bool System.Collections.Generic.HashSet<KB.FogRTS.Runtime.Fader>::Add(!0)  /*0x0A00002D*/
    IL_0010: pop
    IL_0011: ret

  .method KB.FogRTS.Runtime.FaderContainer::Remove(KB.FogRTS.Runtime.Fader)  // token 0x06000016 rva 0x2498 attrs Assembly, Static, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.FaderContainer>::GetInstance()  /*0x0A00002C*/
    IL_0005: ldfld HashSet<Fader> KB.FogRTS.Runtime.FaderContainer::faders  /*0x04000011*/
    IL_000a: ldarg.0
    IL_000b: callvirt bool System.Collections.Generic.HashSet<KB.FogRTS.Runtime.Fader>::Remove(!0)  /*0x0A00002E*/
    IL_0010: pop
    IL_0011: ret

  .method KB.FogRTS.Runtime.FaderContainer::UpdateFaders(float)  // token 0x06000017 rva 0x24ac attrs Assembly, Static, HideBySig
    // code size 101 (0x65), max stack 2, init locals
    .locals ([0] FaderContainer, [1] List.Enumerator<Fader>)
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.FaderContainer>::GetInstance()  /*0x0A00002C*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldfld HashSet<Fader> KB.FogRTS.Runtime.FaderContainer::faders  /*0x04000011*/
    IL_000c: callvirt int System.Collections.Generic.HashSet<KB.FogRTS.Runtime.Fader>::get_Count()  /*0x0A00002F*/
    IL_0011: brtrue.s IL_0014
    IL_0013: ret
    IL_0014: ldloc.0
    IL_0015: ldfld List<Fader> KB.FogRTS.Runtime.FaderContainer::cachedFaders  /*0x04000012*/
    IL_001a: ldloc.0
    IL_001b: ldfld HashSet<Fader> KB.FogRTS.Runtime.FaderContainer::faders  /*0x04000011*/
    IL_0020: callvirt void System.Collections.Generic.List<KB.FogRTS.Runtime.Fader>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000030*/
    IL_0025: ldloc.0
    IL_0026: ldfld List<Fader> KB.FogRTS.Runtime.FaderContainer::cachedFaders  /*0x04000012*/
    IL_002b: callvirt List.Enumerator<!0> System.Collections.Generic.List<KB.FogRTS.Runtime.Fader>::GetEnumerator()  /*0x0A000031*/
    IL_0030: stloc.1
    IL_0031: br.s IL_0040
    IL_0033: ldloca.s 1
    IL_0035: call !0 System.Collections.Generic.List.Enumerator<KB.FogRTS.Runtime.Fader>::get_Current()  /*0x0A000032*/
    IL_003a: ldarg.0
    IL_003b: callvirt void KB.FogRTS.Runtime.Fader::UpdateFade(float)  /*0x06000040*/
    IL_0040: ldloca.s 1
    IL_0042: call bool System.Collections.Generic.List.Enumerator<KB.FogRTS.Runtime.Fader>::MoveNext()  /*0x0A000033*/
    IL_0047: brtrue.s IL_0033
    IL_0049: leave.s IL_0059
    IL_004b: ldloca.s 1
    IL_004d: constrained. System.Collections.Generic.List.Enumerator<KB.FogRTS.Runtime.Fader>  /*0x1B00000C*/
    IL_0053: callvirt void System.IDisposable::Dispose()  /*0x0A000034*/
    IL_0058: endfinally
    IL_0059: ldloc.0
    IL_005a: ldfld List<Fader> KB.FogRTS.Runtime.FaderContainer::cachedFaders  /*0x04000012*/
    IL_005f: callvirt void System.Collections.Generic.List<KB.FogRTS.Runtime.Fader>::Clear()  /*0x0A000035*/
    IL_0064: ret
    .try IL_0031-IL_004b finally handler IL_004b-IL_0059

  .method KB.FogRTS.Runtime.FaderContainer::.ctor()  // token 0x06000018 rva 0x2530 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.HashSet<KB.FogRTS.Runtime.Fader>::.ctor()  /*0x0A000036*/
    IL_0006: stfld HashSet<Fader> KB.FogRTS.Runtime.FaderContainer::faders  /*0x04000011*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<KB.FogRTS.Runtime.Fader>::.ctor()  /*0x0A000037*/
    IL_0011: stfld List<Fader> KB.FogRTS.Runtime.FaderContainer::cachedFaders  /*0x04000012*/
    IL_0016: ldarg.0
    IL_0017: call void KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.FaderContainer>::.ctor()  /*0x0A000038*/
    IL_001c: ret

