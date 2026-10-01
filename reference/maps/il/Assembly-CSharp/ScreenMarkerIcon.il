// ===== ScreenMarkerIcon  (token 0x02000263) =====
  .method ScreenMarkerIcon::get_UnitDescription()  // token 0x06000D40 rva 0x3c52d attrs Public, HideBySig, SpecialName
    // code size 50 (0x32), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ScreenMarkerIcon::isPlayerUnit  /*0x04000FC7*/
    IL_0006: brtrue.s IL_0018
    IL_0008: ldarg.0
    IL_0009: ldfld string ScreenMarkerIcon::locaKey  /*0x04000FC6*/
    IL_000e: ldc.i4.1
    IL_000f: ldc.i4.0
    IL_0010: ldc.i4.1
    IL_0011: ldc.i4.1
    IL_0012: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0017: ret
    IL_0018: ldarg.0
    IL_0019: ldfld string ScreenMarkerIcon::locaKey  /*0x04000FC6*/
    IL_001e: ldstr " Description"
    IL_0023: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0028: ldc.i4.1
    IL_0029: ldc.i4.0
    IL_002a: ldc.i4.1
    IL_002b: ldc.i4.1
    IL_002c: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0031: ret

  .method ScreenMarkerIcon::get_UnitName()  // token 0x06000D41 rva 0x3c560 attrs Public, HideBySig, SpecialName
    // code size 50 (0x32), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ScreenMarkerIcon::isPlayerUnit  /*0x04000FC7*/
    IL_0006: brtrue.s IL_0022
    IL_0008: ldarg.0
    IL_0009: ldfld string ScreenMarkerIcon::locaKey  /*0x04000FC6*/
    IL_000e: ldstr " Name"
    IL_0013: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0018: ldc.i4.1
    IL_0019: ldc.i4.0
    IL_001a: ldc.i4.1
    IL_001b: ldc.i4.1
    IL_001c: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldfld string ScreenMarkerIcon::locaKey  /*0x04000FC6*/
    IL_0028: ldc.i4.1
    IL_0029: ldc.i4.0
    IL_002a: ldc.i4.1
    IL_002b: ldc.i4.1
    IL_002c: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0031: ret

  .method ScreenMarkerIcon::.ctor()  // token 0x06000D42 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

