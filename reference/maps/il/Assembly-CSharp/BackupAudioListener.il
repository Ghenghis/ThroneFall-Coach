// ===== BackupAudioListener  (token 0x02000079) =====
  .method BackupAudioListener::get_Instance()  // token 0x06000275 rva 0xb110 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld BackupAudioListener BackupAudioListener::<Instance>k__BackingField  /*0x04000346*/
    IL_0005: ret

  .method BackupAudioListener::set_Instance(BackupAudioListener)  // token 0x06000276 rva 0xb117 attrs Private, Static, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld BackupAudioListener BackupAudioListener::<Instance>k__BackingField  /*0x04000346*/
    IL_0006: ret

  .method BackupAudioListener::Awake()  // token 0x06000277 rva 0xb11f attrs Private, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: call BackupAudioListener BackupAudioListener::get_Instance()  /*0x06000275*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_001f
    IL_000d: ldarg.0
    IL_000e: call void BackupAudioListener::set_Instance(BackupAudioListener)  /*0x06000276*/
    IL_0013: ldarg.0
    IL_0014: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0019: call void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)  /*0x0A0000C1*/
    IL_001e: ret
    IL_001f: ldarg.0
    IL_0020: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0025: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_002a: ret

  .method BackupAudioListener::EnableBackupListener(bool)  // token 0x06000278 rva 0xb14b attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.AudioListener>  /*0x2B00001B*/
    IL_0006: ldarg.1
    IL_0007: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_000c: ret

  .method BackupAudioListener::.ctor()  // token 0x06000279 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

