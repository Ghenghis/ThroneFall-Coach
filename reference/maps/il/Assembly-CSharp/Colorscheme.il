// ===== Colorscheme  (token 0x020000A0) =====
  .method Colorscheme::OnValidate()  // token 0x06000379 rva 0xfcf4 attrs Private, HideBySig
    // code size 22 (0x16), max stack 2, init locals
    .locals ([0] ColorAndLightManager)
    IL_0000: call !!0 UnityEngine.Object::FindObjectOfType()<ColorAndLightManager>  /*0x2B00002B*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000c: brfalse.s IL_0015
    IL_000e: ldloc.0
    IL_000f: ldarg.0
    IL_0010: callvirt void ColorAndLightManager::ApplyColorScheme(Colorscheme)  /*0x06000363*/
    IL_0015: ret

  .method Colorscheme::.ctor()  // token 0x0600037A rva 0xfd16 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0006: stfld Color Colorscheme::dayLightColor  /*0x04000458*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: ldc.r4 0.701447f
    IL_0016: ldc.r4 0.1273585f
    IL_001b: newobj void UnityEngine.Color::.ctor(float,float,float)  /*0x0A00018A*/
    IL_0020: stfld Color Colorscheme::bonfireLightColor  /*0x0400045C*/
    IL_0025: ldarg.0
    IL_0026: call void UnityEngine.ScriptableObject::.ctor()  /*0x0A00002B*/
    IL_002b: ret

