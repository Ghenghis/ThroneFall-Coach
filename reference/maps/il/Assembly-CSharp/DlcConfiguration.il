// ===== DlcConfiguration  (token 0x02000005) =====
  .method DlcConfiguration::get_Instance()  // token 0x06000018 rva 0x2598 attrs Private, Static, HideBySig, SpecialName
    // code size 65 (0x41), max stack 3, init locals
    IL_0000: ldsfld DlcConfiguration DlcConfiguration::_instance  /*0x0400001C*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_003b
    IL_000d: ldstr "Dlc Configuration"
    IL_0012: call !!0 UnityEngine.Resources::Load(string)<DlcConfiguration>  /*0x2B000001*/
    IL_0017: stsfld DlcConfiguration DlcConfiguration::_instance  /*0x0400001C*/
    IL_001c: ldsfld DlcConfiguration DlcConfiguration::_instance  /*0x0400001C*/
    IL_0021: ldsfld string DlcConfiguration::CraaghelmMarkerPath  /*0x0400001D*/
    IL_0026: call !!0 UnityEngine.Resources::Load(string)<UnityEngine.GameObject>  /*0x2B000002*/
    IL_002b: ldnull
    IL_002c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0031: stfld bool DlcConfiguration::forceCraaghelm  /*0x04000015*/
    IL_0036: call void DlcConfiguration::InitializeDlcProvider()  /*0x06000019*/
    IL_003b: ldsfld DlcConfiguration DlcConfiguration::_instance  /*0x0400001C*/
    IL_0040: ret

  .method DlcConfiguration::InitializeDlcProvider()  // token 0x06000019 rva 0x25e5 attrs Private, Static, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void SteamDlcProvider::.ctor()  /*0x060003EE*/
    IL_0005: stsfld IDlcProvider DlcConfiguration::dlcProvider  /*0x0400001B*/
    IL_000a: ret

  .method DlcConfiguration::OnValidate()  // token 0x0600001A rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method DlcConfiguration::SetupMapList(System.Collections.Generic.List<UnityEngine.Object>,ref System.Collections.Generic.List<string>)  // token 0x0600001B rva 0x25f4 attrs Private, HideBySig
    // code size 63 (0x3f), max stack 2, init locals
    .locals ([0] List.Enumerator<Object>, [1] Object)
    IL_0000: ldarg.2
    IL_0001: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_0006: stind.ref
    IL_0007: ldarg.1
    IL_0008: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.Object>::GetEnumerator()  /*0x0A000024*/
    IL_000d: stloc.0
    IL_000e: br.s IL_0025
    IL_0010: ldloca.s 0
    IL_0012: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.Object>::get_Current()  /*0x0A000025*/
    IL_0017: stloc.1
    IL_0018: ldarg.2
    IL_0019: ldind.ref
    IL_001a: ldloc.1
    IL_001b: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0020: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0025: ldloca.s 0
    IL_0027: call bool System.Collections.Generic.List.Enumerator<UnityEngine.Object>::MoveNext()  /*0x0A000028*/
    IL_002c: brtrue.s IL_0010
    IL_002e: leave.s IL_003e
    IL_0030: ldloca.s 0
    IL_0032: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.Object>  /*0x1B000006*/
    IL_0038: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_003d: endfinally
    IL_003e: ret
    .try IL_000e-IL_0030 finally handler IL_0030-IL_003e

  .method DlcConfiguration::IsDlcAvailable(IDlcProvider.DlcId)  // token 0x0600001C rva 0x2650 attrs Public, Static, HideBySig
    // code size 71 (0x47), max stack 2, init locals
    .locals ([0] bool)
    IL_0000: ldarg.0
    IL_0001: brfalse.s IL_0009
    IL_0003: ldarg.0
    IL_0004: ldc.i4.1
    IL_0005: beq.s IL_0026
    IL_0007: br.s IL_0043
    IL_0009: call DlcConfiguration DlcConfiguration::get_Instance()  /*0x06000018*/
    IL_000e: ldfld bool DlcConfiguration::forceCraaghelm  /*0x04000015*/
    IL_0013: brtrue.s IL_0022
    IL_0015: ldsfld IDlcProvider DlcConfiguration::dlcProvider  /*0x0400001B*/
    IL_001a: ldarg.0
    IL_001b: callvirt bool IDlcProvider::IsDlcAvailable(IDlcProvider.DlcId)  /*0x06000838*/
    IL_0020: br.s IL_0023
    IL_0022: ldc.i4.1
    IL_0023: stloc.0
    IL_0024: br.s IL_0045
    IL_0026: call DlcConfiguration DlcConfiguration::get_Instance()  /*0x06000018*/
    IL_002b: ldfld bool DlcConfiguration::forceFangmoor  /*0x04000016*/
    IL_0030: brtrue.s IL_003f
    IL_0032: ldsfld IDlcProvider DlcConfiguration::dlcProvider  /*0x0400001B*/
    IL_0037: ldarg.0
    IL_0038: callvirt bool IDlcProvider::IsDlcAvailable(IDlcProvider.DlcId)  /*0x06000838*/
    IL_003d: br.s IL_0040
    IL_003f: ldc.i4.1
    IL_0040: stloc.0
    IL_0041: br.s IL_0045
    IL_0043: ldc.i4.0
    IL_0044: stloc.0
    IL_0045: ldloc.0
    IL_0046: ret

  .method DlcConfiguration::IsDlcMap(IDlcProvider.DlcId,string)  // token 0x0600001D rva 0x26a4 attrs Public, Static, HideBySig
    // code size 51 (0x33), max stack 2, init locals
    .locals ([0] List<string>)
    IL_0000: ldarg.0
    IL_0001: brfalse.s IL_0009
    IL_0003: ldarg.0
    IL_0004: ldc.i4.1
    IL_0005: beq.s IL_0016
    IL_0007: br.s IL_0023
    IL_0009: call DlcConfiguration DlcConfiguration::get_Instance()  /*0x06000018*/
    IL_000e: ldfld List<string> DlcConfiguration::_craaghelmMapNames  /*0x04000019*/
    IL_0013: stloc.0
    IL_0014: br.s IL_0025
    IL_0016: call DlcConfiguration DlcConfiguration::get_Instance()  /*0x06000018*/
    IL_001b: ldfld List<string> DlcConfiguration::_fangmoorMapnames  /*0x0400001A*/
    IL_0020: stloc.0
    IL_0021: br.s IL_0025
    IL_0023: ldnull
    IL_0024: stloc.0
    IL_0025: ldloc.0
    IL_0026: dup
    IL_0027: brtrue.s IL_002c
    IL_0029: pop
    IL_002a: ldc.i4.0
    IL_002b: ret
    IL_002c: ldarg.1
    IL_002d: call bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_0032: ret

  .method DlcConfiguration::.ctor()  // token 0x0600001E rva 0x26e3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.ScriptableObject::.ctor()  /*0x0A00002B*/
    IL_0006: ret

  .method DlcConfiguration::.cctor()  // token 0x0600001F rva 0x26eb attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 23 (0x17), max stack 8
    IL_0000: ldnull
    IL_0001: stsfld IDlcProvider DlcConfiguration::dlcProvider  /*0x0400001B*/
    IL_0006: ldnull
    IL_0007: stsfld DlcConfiguration DlcConfiguration::_instance  /*0x0400001C*/
    IL_000c: ldstr "CraaghelmMarker"
    IL_0011: stsfld string DlcConfiguration::CraaghelmMarkerPath  /*0x0400001D*/
    IL_0016: ret

