// ===== ProjectileSpawnAudio  (token 0x0200005E) =====
  .method ProjectileSpawnAudio::Start()  // token 0x0600020D rva 0x88f0 attrs Private, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallAudioManager.AudioOneShot ProjectileSpawnAudio::oneShotType  /*0x04000277*/
    IL_0006: ldarg.0
    IL_0007: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0011: call void ThronefallAudioManager::WorldSpaceOneShot(ThronefallAudioManager.AudioOneShot,UnityEngine.Vector3)  /*0x0600021A*/
    IL_0016: ret

  .method ProjectileSpawnAudio::.ctor()  // token 0x0600020E rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

