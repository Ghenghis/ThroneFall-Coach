// ===== PlayOneShotOnProjectileHit  (token 0x0200005A) =====
  .method PlayOneShotOnProjectileHit::Start()  // token 0x06000203 rva 0x87d0 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AimbotProjectile PlayOneShotOnProjectileHit::target  /*0x0400026D*/
    IL_0006: ldfld UnityEvent AimbotProjectile::onHit  /*0x0400008A*/
    IL_000b: ldarg.0
    IL_000c: ldftn void PlayOneShotOnProjectileHit::Play()  /*0x06000204*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method PlayOneShotOnProjectileHit::Play()  // token 0x06000204 rva 0x87ee attrs Private, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallAudioManager.AudioOneShot PlayOneShotOnProjectileHit::oneshot  /*0x0400026E*/
    IL_0006: ldarg.0
    IL_0007: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0011: call void ThronefallAudioManager::WorldSpaceOneShot(ThronefallAudioManager.AudioOneShot,UnityEngine.Vector3)  /*0x0600021A*/
    IL_0016: ret

  .method PlayOneShotOnProjectileHit::.ctor()  // token 0x06000205 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

