// ===== ArachnophobiaSettings  (token 0x0200004D) =====
  .method ArachnophobiaSettings::Start()  // token 0x0600016C rva 0x784a attrs Private, HideBySig
    // code size 58 (0x3a), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_001e
    IL_000c: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0011: callvirt bool SettingsManager::get_ArachnophobiaMode()  /*0x06000DAA*/
    IL_0016: brfalse.s IL_001e
    IL_0018: ldarg.0
    IL_0019: call void ArachnophobiaSettings::Refresh()  /*0x0600016D*/
    IL_001e: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0023: ldfld UnityEvent SettingsManager::onArachnophobiaModeChange  /*0x04000FF8*/
    IL_0028: ldarg.0
    IL_0029: ldftn void ArachnophobiaSettings::Refresh()  /*0x0600016D*/
    IL_002f: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0034: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0039: ret

  .method ArachnophobiaSettings::Refresh()  // token 0x0600016D rva 0x7888 attrs Public, HideBySig
    // code size 60 (0x3c), max stack 2, init locals
    .locals ([0] bool)
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_003b
    IL_000c: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0011: callvirt bool SettingsManager::get_ArachnophobiaMode()  /*0x06000DAA*/
    IL_0016: ldc.i4.0
    IL_0017: ceq
    IL_0019: stloc.0
    IL_001a: ldarg.0
    IL_001b: ldfld GameObject ArachnophobiaSettings::defaultMesh  /*0x040001C6*/
    IL_0020: ldloc.0
    IL_0021: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0026: ldarg.0
    IL_0027: ldfld GameObject ArachnophobiaSettings::arachnophobiaMesh  /*0x040001C7*/
    IL_002c: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0031: callvirt bool SettingsManager::get_ArachnophobiaMode()  /*0x06000DAA*/
    IL_0036: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003b: ret

  .method ArachnophobiaSettings::.ctor()  // token 0x0600016E rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

