// ===== ControlConfig  (token 0x020001C8) =====
  .method ControlConfig::Initialize(System.Collections.Generic.List<Rewired.ControllerMap>)  // token 0x06000931 rva 0x2bda4 attrs Public, HideBySig
    // code size 95 (0x5f), max stack 4, init locals
    .locals ([0] List.Enumerator<ControllerMap>, [1] ControllerMap)
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<ControlConfig.ControllerData>::.ctor()  /*0x0A000407*/
    IL_0006: stfld List<ControlConfig.ControllerData> ControlConfig::controllerDataSet  /*0x04000B99*/
    IL_000b: ldarg.1
    IL_000c: callvirt List.Enumerator<!0> System.Collections.Generic.List<Rewired.ControllerMap>::GetEnumerator()  /*0x0A000408*/
    IL_0011: stloc.0
    IL_0012: br.s IL_003e
    IL_0014: ldloca.s 0
    IL_0016: call !0 System.Collections.Generic.List.Enumerator<Rewired.ControllerMap>::get_Current()  /*0x0A000409*/
    IL_001b: stloc.1
    IL_001c: ldarg.0
    IL_001d: ldfld List<ControlConfig.ControllerData> ControlConfig::controllerDataSet  /*0x04000B99*/
    IL_0022: ldloc.1
    IL_0023: callvirt ControllerType Rewired.ControllerMap::get_controllerType()  /*0x0A0003FD*/
    IL_0028: ldloc.1
    IL_0029: callvirt int Rewired.ControllerMap::get_controllerId()  /*0x0A00040A*/
    IL_002e: ldloc.1
    IL_002f: callvirt string Rewired.ControllerMap::ToJsonString()  /*0x0A00040B*/
    IL_0034: newobj void ControlConfig.ControllerData::.ctor(Rewired.ControllerType,int,string)  /*0x06000933*/
    IL_0039: callvirt void System.Collections.Generic.List<ControlConfig.ControllerData>::Add(!0)  /*0x0A00040C*/
    IL_003e: ldloca.s 0
    IL_0040: call bool System.Collections.Generic.List.Enumerator<Rewired.ControllerMap>::MoveNext()  /*0x0A00040D*/
    IL_0045: brtrue.s IL_0014
    IL_0047: leave.s IL_0057
    IL_0049: ldloca.s 0
    IL_004b: constrained. System.Collections.Generic.List.Enumerator<Rewired.ControllerMap>  /*0x1B0000BA*/
    IL_0051: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0056: endfinally
    IL_0057: ldarg.0
    IL_0058: ldc.i4.1
    IL_0059: stfld bool ControlConfig::initialized  /*0x04000B98*/
    IL_005e: ret
    .try IL_0012-IL_0049 finally handler IL_0049-IL_0057

  .method ControlConfig::.ctor()  // token 0x06000932 rva 0x2be20 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<ControlConfig.ControllerData>::.ctor()  /*0x0A000407*/
    IL_0006: stfld List<ControlConfig.ControllerData> ControlConfig::controllerDataSet  /*0x04000B99*/
    IL_000b: ldarg.0
    IL_000c: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0011: ret

// ===== ControlConfig/ControllerData  (token 0x020001C9) =====
  .method ControlConfig.ControllerData::.ctor(Rewired.ControllerType,int,string)  // token 0x06000933 rva 0x2be33 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 50 (0x32), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0006: stfld List<int> ControlConfig.ControllerData::knownActionIds  /*0x04000B9D*/
    IL_000b: ldarg.0
    IL_000c: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0011: ldarg.0
    IL_0012: ldarg.1
    IL_0013: stfld ControllerType ControlConfig.ControllerData::controllerType  /*0x04000B9A*/
    IL_0018: ldarg.0
    IL_0019: ldarg.2
    IL_001a: stfld int ControlConfig.ControllerData::controllerId  /*0x04000B9B*/
    IL_001f: ldarg.0
    IL_0020: ldarg.3
    IL_0021: stfld string ControlConfig.ControllerData::jsonMap  /*0x04000B9C*/
    IL_0026: ldarg.0
    IL_0027: call List<int> ControlConfigSaveLoad::GetAllKnownActionIDs()  /*0x0600092F*/
    IL_002c: stfld List<int> ControlConfig.ControllerData::knownActionIds  /*0x04000B9D*/
    IL_0031: ret

