// ===== PlayOneShotAfterSeconds  (token 0x02000059) =====
  .method PlayOneShotAfterSeconds::Update()  // token 0x06000201 rva 0x876c attrs Private, HideBySig
    // code size 69 (0x45), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld float PlayOneShotAfterSeconds::timer  /*0x0400026C*/
    IL_0006: ldarg.0
    IL_0007: ldfld float PlayOneShotAfterSeconds::initialDelay  /*0x0400026A*/
    IL_000c: bgt.un.s IL_0044
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: ldfld float PlayOneShotAfterSeconds::timer  /*0x0400026C*/
    IL_0015: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_001a: add
    IL_001b: stfld float PlayOneShotAfterSeconds::timer  /*0x0400026C*/
    IL_0020: ldarg.0
    IL_0021: ldfld float PlayOneShotAfterSeconds::timer  /*0x0400026C*/
    IL_0026: ldarg.0
    IL_0027: ldfld float PlayOneShotAfterSeconds::initialDelay  /*0x0400026A*/
    IL_002c: ble.un.s IL_0044
    IL_002e: ldarg.0
    IL_002f: ldfld ThronefallAudioManager.AudioOneShot PlayOneShotAfterSeconds::type  /*0x0400026B*/
    IL_0034: ldarg.0
    IL_0035: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_003f: call void ThronefallAudioManager::WorldSpaceOneShot(ThronefallAudioManager.AudioOneShot,UnityEngine.Vector3)  /*0x0600021A*/
    IL_0044: ret

  .method PlayOneShotAfterSeconds::.ctor()  // token 0x06000202 rva 0x87bd attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float PlayOneShotAfterSeconds::initialDelay  /*0x0400026A*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

