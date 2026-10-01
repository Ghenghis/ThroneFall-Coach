// ===== ForceCameraPosOnEnable  (token 0x0200016C) =====
  .method ForceCameraPosOnEnable::Update()  // token 0x0600076A rva 0x25164 attrs Private, HideBySig
    // code size 101 (0x65), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld float ForceCameraPosOnEnable::duration  /*0x04000950*/
    IL_0006: ldc.r4 0f
    IL_000b: blt.un.s IL_0042
    IL_000d: ldarg.0
    IL_000e: ldfld CameraRig ForceCameraPosOnEnable::cameraRig  /*0x0400094E*/
    IL_0013: ldarg.0
    IL_0014: ldfld Transform ForceCameraPosOnEnable::forcedPosition  /*0x0400094F*/
    IL_0019: stfld Transform CameraRig::overrideCameraTarget  /*0x040003DF*/
    IL_001e: ldarg.0
    IL_001f: ldarg.0
    IL_0020: ldfld float ForceCameraPosOnEnable::duration  /*0x04000950*/
    IL_0025: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_002a: sub
    IL_002b: stfld float ForceCameraPosOnEnable::duration  /*0x04000950*/
    IL_0030: ldarg.0
    IL_0031: ldfld CameraRig ForceCameraPosOnEnable::cameraRig  /*0x0400094E*/
    IL_0036: ldarg.0
    IL_0037: ldfld float ForceCameraPosOnEnable::forceZoom  /*0x04000951*/
    IL_003c: stfld float CameraRig::overrideZoom  /*0x040003E0*/
    IL_0041: ret
    IL_0042: ldarg.0
    IL_0043: ldfld CameraRig ForceCameraPosOnEnable::cameraRig  /*0x0400094E*/
    IL_0048: ldc.r4 -1f
    IL_004d: stfld float CameraRig::overrideZoom  /*0x040003E0*/
    IL_0052: ldarg.0
    IL_0053: ldfld CameraRig ForceCameraPosOnEnable::cameraRig  /*0x0400094E*/
    IL_0058: ldnull
    IL_0059: stfld Transform CameraRig::overrideCameraTarget  /*0x040003DF*/
    IL_005e: ldarg.0
    IL_005f: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0064: ret

  .method ForceCameraPosOnEnable::.ctor()  // token 0x0600076B rva 0x251d5 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float ForceCameraPosOnEnable::forceZoom  /*0x04000951*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

