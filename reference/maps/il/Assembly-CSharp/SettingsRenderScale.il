// ===== SettingsRenderScale  (token 0x02000285) =====
  .method SettingsRenderScale::OnEnable()  // token 0x06000DE9 rva 0x3e914 attrs Private, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0022
    IL_000d: ldarg.0
    IL_000e: ldfld TFUISlider SettingsRenderScale::target  /*0x04001044*/
    IL_0013: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0018: callvirt float SettingsManager::get_Renderscale()  /*0x06000DA0*/
    IL_001d: callvirt void TFUISlider::SetValue(float)  /*0x06001243*/
    IL_0022: ret

  .method SettingsRenderScale::Start()  // token 0x06000DEA rva 0x3e938 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUISlider SettingsRenderScale::target  /*0x04001044*/
    IL_0006: ldfld UnityEvent TFUISlider::onChange  /*0x040015F8*/
    IL_000b: ldarg.0
    IL_000c: ldftn void SettingsRenderScale::OnChange()  /*0x06000DEB*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method SettingsRenderScale::OnChange()  // token 0x06000DEB rva 0x3e956 attrs Private, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldarg.0
    IL_0006: ldfld TFUISlider SettingsRenderScale::target  /*0x04001044*/
    IL_000b: ldfld float TFUISlider::value  /*0x040015EB*/
    IL_0010: callvirt void SettingsManager::SetRenderscale(float)  /*0x06000DBF*/
    IL_0015: ret

  .method SettingsRenderScale::.ctor()  // token 0x06000DEC rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

