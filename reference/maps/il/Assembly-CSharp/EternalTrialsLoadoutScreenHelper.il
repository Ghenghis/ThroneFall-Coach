// ===== EternalTrialsLoadoutScreenHelper  (token 0x02000308) =====
  .method EternalTrialsLoadoutScreenHelper::Play()  // token 0x060010CD rva 0x4d95f attrs Public, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldnull
    IL_0001: call void EternalTrialsRunManager::LoadNextMap(EternalTrialsRun)  /*0x060006F4*/
    IL_0006: ret

  .method EternalTrialsLoadoutScreenHelper::.ctor()  // token 0x060010CE rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

