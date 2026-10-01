// ===== LoadSceneOnTop  (token 0x020001BA) =====
  .method LoadSceneOnTop::Start()  // token 0x060008F7 rva 0x2b077 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void LoadSceneOnTop::LoadScene()  /*0x060008F8*/
    IL_0006: ret

  .method LoadSceneOnTop::LoadScene()  // token 0x060008F8 rva 0x2b07f attrs Public, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld string LoadSceneOnTop::sceneNameToLoad  /*0x04000B42*/
    IL_0006: call bool System.String::IsNullOrEmpty(string)  /*0x0A000141*/
    IL_000b: brtrue.s IL_001a
    IL_000d: ldarg.0
    IL_000e: ldfld string LoadSceneOnTop::sceneNameToLoad  /*0x04000B42*/
    IL_0013: ldc.i4.1
    IL_0014: call void UnityEngine.SceneManagement.SceneManager::LoadScene(string,UnityEngine.SceneManagement.LoadSceneMode)  /*0x0A0003DB*/
    IL_0019: ret
    IL_001a: ldstr "Scene name is not specified. Please provide a valid scene name."
    IL_001f: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0024: ret

  .method LoadSceneOnTop::.ctor()  // token 0x060008F9 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

