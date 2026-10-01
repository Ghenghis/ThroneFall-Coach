// ===== SettingsAudioVolume  (token 0x0200026F) =====
  .method SettingsAudioVolume::OnEnable()  // token 0x06000D68 rva 0x3d50b attrs Private, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0028
    IL_000d: ldarg.0
    IL_000e: ldfld TFUISlider SettingsAudioVolume::target  /*0x04000FDF*/
    IL_0013: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0018: ldarg.0
    IL_0019: ldfld SettingsManager.MixerChannel SettingsAudioVolume::channel  /*0x04000FE0*/
    IL_001e: callvirt float SettingsManager::GetAudioVolume(SettingsManager.MixerChannel)  /*0x06000DC2*/
    IL_0023: callvirt void TFUISlider::SetValue(float)  /*0x06001243*/
    IL_0028: ret

  .method SettingsAudioVolume::Start()  // token 0x06000D69 rva 0x3d535 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUISlider SettingsAudioVolume::target  /*0x04000FDF*/
    IL_0006: ldfld UnityEvent TFUISlider::onChange  /*0x040015F8*/
    IL_000b: ldarg.0
    IL_000c: ldftn void SettingsAudioVolume::OnChange()  /*0x06000D6A*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method SettingsAudioVolume::OnChange()  // token 0x06000D6A rva 0x3d553 attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldarg.0
    IL_0006: ldfld TFUISlider SettingsAudioVolume::target  /*0x04000FDF*/
    IL_000b: ldfld float TFUISlider::value  /*0x040015EB*/
    IL_0010: ldarg.0
    IL_0011: ldfld SettingsManager.MixerChannel SettingsAudioVolume::channel  /*0x04000FE0*/
    IL_0016: callvirt void SettingsManager::SetAudioValue(float,SettingsManager.MixerChannel)  /*0x06000DC1*/
    IL_001b: ret

  .method SettingsAudioVolume::.ctor()  // token 0x06000D6B rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

