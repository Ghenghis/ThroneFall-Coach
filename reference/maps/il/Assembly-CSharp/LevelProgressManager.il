// ===== LevelProgressManager  (token 0x020001CF) =====
  .method LevelProgressManager::get_EternalTrialsHighscore()  // token 0x06000942 rva 0x2c3b6 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int LevelProgressManager::<EternalTrialsHighscore>k__BackingField  /*0x04000BB7*/
    IL_0006: ret

  .method LevelProgressManager::set_EternalTrialsHighscore(int)  // token 0x06000943 rva 0x2c3be attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld int LevelProgressManager::<EternalTrialsHighscore>k__BackingField  /*0x04000BB7*/
    IL_0007: ret

  .method LevelProgressManager::GetLevelInfoFromSceneName(string)  // token 0x06000944 rva 0x2c3c8 attrs Public, HideBySig
    // code size 51 (0x33), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_0026
    IL_0004: ldarg.0
    IL_0005: ldfld LevelInfo[] LevelProgressManager::levelInfos  /*0x04000BB8*/
    IL_000a: ldloc.0
    IL_000b: ldelem.ref
    IL_000c: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0011: ldarg.1
    IL_0012: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0017: brfalse.s IL_0022
    IL_0019: ldarg.0
    IL_001a: ldfld LevelInfo[] LevelProgressManager::levelInfos  /*0x04000BB8*/
    IL_001f: ldloc.0
    IL_0020: ldelem.ref
    IL_0021: ret
    IL_0022: ldloc.0
    IL_0023: ldc.i4.1
    IL_0024: add
    IL_0025: stloc.0
    IL_0026: ldloc.0
    IL_0027: ldarg.0
    IL_0028: ldfld LevelInfo[] LevelProgressManager::levelInfos  /*0x04000BB8*/
    IL_002d: ldlen
    IL_002e: conv.i4
    IL_002f: blt.s IL_0004
    IL_0031: ldnull
    IL_0032: ret

  .method LevelProgressManager::GetLevelInfoFromCurrentSceneName()  // token 0x06000945 rva 0x2c408 attrs Public, HideBySig
    // code size 59 (0x3b), max stack 2, init locals
    .locals ([0] int, [1] Scene, [2] LevelInfo)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_0031
    IL_0004: ldloc.0
    IL_0005: call Scene UnityEngine.SceneManagement.SceneManager::GetSceneAt(int)  /*0x0A000424*/
    IL_000a: stloc.1
    IL_000b: ldloca.s 1
    IL_000d: call bool UnityEngine.SceneManagement.Scene::get_isLoaded()  /*0x0A0002A2*/
    IL_0012: brfalse.s IL_002d
    IL_0014: ldarg.0
    IL_0015: ldloca.s 1
    IL_0017: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_001c: call LevelInfo LevelProgressManager::GetLevelInfoFromSceneName(string)  /*0x06000944*/
    IL_0021: stloc.2
    IL_0022: ldloc.2
    IL_0023: ldnull
    IL_0024: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0029: brfalse.s IL_002d
    IL_002b: ldloc.2
    IL_002c: ret
    IL_002d: ldloc.0
    IL_002e: ldc.i4.1
    IL_002f: add
    IL_0030: stloc.0
    IL_0031: ldloc.0
    IL_0032: call int UnityEngine.SceneManagement.SceneManager::get_sceneCount()  /*0x0A000425*/
    IL_0037: blt.s IL_0004
    IL_0039: ldnull
    IL_003a: ret

  .method LevelProgressManager::get_SceneNameToLevelData()  // token 0x06000946 rva 0x2c44f attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld SceneNameToLevelData LevelProgressManager::sceneNameToLevelData  /*0x04000BB9*/
    IL_0006: ret

  .method LevelProgressManager::StartsWithUnderscore(string)  // token 0x06000947 rva 0x2c457 attrs Public, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.1
    IL_0001: call bool System.String::IsNullOrEmpty(string)  /*0x0A000141*/
    IL_0006: brfalse.s IL_000a
    IL_0008: ldc.i4.0
    IL_0009: ret
    IL_000a: ldarg.1
    IL_000b: ldc.i4.0
    IL_000c: callvirt char System.String::get_Chars(int)  /*0x0A000146*/
    IL_0011: ldc.i4.s 95
    IL_0013: ceq
    IL_0015: ret

  .method LevelProgressManager::AreAllBuildOptionsUnlockedInThisLevel()  // token 0x06000948 rva 0x2c470 attrs Public, HideBySig
    // code size 35 (0x23), max stack 2, init locals
    .locals ([0] LevelInfo)
    IL_0000: ldarg.0
    IL_0001: call LevelInfo LevelProgressManager::GetLevelInfoFromCurrentSceneName()  /*0x06000945*/
    IL_0006: stloc.0
    IL_0007: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_000c: ldc.i4.1
    IL_000d: bne.un.s IL_0011
    IL_000f: ldc.i4.1
    IL_0010: ret
    IL_0011: ldloc.0
    IL_0012: ldnull
    IL_0013: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0018: brfalse.s IL_001c
    IL_001a: ldc.i4.0
    IL_001b: ret
    IL_001c: ldloc.0
    IL_001d: ldfld bool LevelInfo::allBuildingChoicesUnlocked  /*0x04000B23*/
    IL_0022: ret

  .method LevelProgressManager::Awake()  // token 0x06000949 rva 0x2c49f attrs Private, HideBySig
    // code size 52 (0x34), max stack 8
    IL_0000: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_0018
    IL_000c: ldarg.0
    IL_000d: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0012: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0017: ret
    IL_0018: ldarg.0
    IL_0019: stsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_001e: ldarg.0
    IL_001f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0024: callvirt Transform UnityEngine.Transform::get_root()  /*0x0A00037A*/
    IL_0029: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002e: call void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)  /*0x0A0000C1*/
    IL_0033: ret

  .method LevelProgressManager::GetLevelDataForScene(string)  // token 0x0600094A rva 0x2c4d4 attrs Public, HideBySig
    // code size 79 (0x4f), max stack 3, init locals
    .locals ([0] LevelData)
    IL_0000: ldarg.1
    IL_0001: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0006: ldfld string SceneTransitionManager::levelSelectScene  /*0x04000C72*/
    IL_000b: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0010: brfalse.s IL_0014
    IL_0012: ldnull
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: ldarg.1
    IL_0016: call bool LevelProgressManager::StartsWithUnderscore(string)  /*0x06000947*/
    IL_001b: brfalse.s IL_001f
    IL_001d: ldnull
    IL_001e: ret
    IL_001f: ldarg.0
    IL_0020: ldfld SceneNameToLevelData LevelProgressManager::sceneNameToLevelData  /*0x04000BB9*/
    IL_0025: ldarg.1
    IL_0026: callvirt bool System.Collections.Generic.Dictionary<string, LevelData>::ContainsKey(!0)  /*0x0A000426*/
    IL_002b: brfalse.s IL_003a
    IL_002d: ldarg.0
    IL_002e: ldfld SceneNameToLevelData LevelProgressManager::sceneNameToLevelData  /*0x04000BB9*/
    IL_0033: ldarg.1
    IL_0034: callvirt !1 System.Collections.Generic.Dictionary<string, LevelData>::get_Item(!0)  /*0x0A000427*/
    IL_0039: ret
    IL_003a: newobj void LevelData::.ctor()  /*0x06000952*/
    IL_003f: stloc.0
    IL_0040: ldarg.0
    IL_0041: ldfld SceneNameToLevelData LevelProgressManager::sceneNameToLevelData  /*0x04000BB9*/
    IL_0046: ldarg.1
    IL_0047: ldloc.0
    IL_0048: callvirt void System.Collections.Generic.Dictionary<string, LevelData>::Add(!0,!1)  /*0x0A000428*/
    IL_004d: ldloc.0
    IL_004e: ret

  .method LevelProgressManager::GetLevelDataForActiveScene()  // token 0x0600094B rva 0x2c530 attrs Public, HideBySig
    // code size 22 (0x16), max stack 2, init locals
    .locals ([0] string, [1] Scene)
    IL_0000: call Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()  /*0x0A000292*/
    IL_0005: stloc.1
    IL_0006: ldloca.s 1
    IL_0008: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_000d: stloc.0
    IL_000e: ldarg.0
    IL_000f: ldloc.0
    IL_0010: call LevelData LevelProgressManager::GetLevelDataForScene(string)  /*0x0600094A*/
    IL_0015: ret

  .method LevelProgressManager::SceneExists(string)  // token 0x0600094C rva 0x2c554 attrs Public, Static, HideBySig
    // code size 75 (0x4b), max stack 3, init locals
    .locals ([0] bool, [1] int, [2] int)
    IL_0000: ldsfld Dictionary<string, bool> LevelProgressManager::sceneExistsCache  /*0x04000BBB*/
    IL_0005: ldarg.0
    IL_0006: ldloca.s 0
    IL_0008: callvirt bool System.Collections.Generic.Dictionary<string, bool>::TryGetValue(!0,ref !1)  /*0x0A000429*/
    IL_000d: brfalse.s IL_0011
    IL_000f: ldloc.0
    IL_0010: ret
    IL_0011: ldc.i4.0
    IL_0012: stloc.0
    IL_0013: call int UnityEngine.SceneManagement.SceneManager::get_sceneCountInBuildSettings()  /*0x0A00042A*/
    IL_0018: stloc.1
    IL_0019: ldc.i4.0
    IL_001a: stloc.2
    IL_001b: br.s IL_0039
    IL_001d: ldloc.2
    IL_001e: call string UnityEngine.SceneManagement.SceneUtility::GetScenePathByBuildIndex(int)  /*0x0A00042B*/
    IL_0023: call string System.IO.Path::GetFileNameWithoutExtension(string)  /*0x0A00042C*/
    IL_0028: ldarg.0
    IL_0029: ldc.i4.5
    IL_002a: callvirt bool System.String::Equals(string,System.StringComparison)  /*0x0A00042D*/
    IL_002f: brfalse.s IL_0035
    IL_0031: ldc.i4.1
    IL_0032: stloc.0
    IL_0033: br.s IL_003d
    IL_0035: ldloc.2
    IL_0036: ldc.i4.1
    IL_0037: add
    IL_0038: stloc.2
    IL_0039: ldloc.2
    IL_003a: ldloc.1
    IL_003b: blt.s IL_001d
    IL_003d: ldsfld Dictionary<string, bool> LevelProgressManager::sceneExistsCache  /*0x04000BBB*/
    IL_0042: ldarg.0
    IL_0043: ldloc.0
    IL_0044: callvirt void System.Collections.Generic.Dictionary<string, bool>::set_Item(!0,!1)  /*0x0A00042E*/
    IL_0049: ldloc.0
    IL_004a: ret

  .method LevelProgressManager::CrownsAvailabe()  // token 0x0600094D rva 0x2c5ac attrs Public, HideBySig
    // code size 78 (0x4e), max stack 2, init locals
    .locals ([0] int, [1] LevelInfo[], [2] int, [3] LevelInfo)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldarg.0
    IL_0003: ldfld LevelInfo[] LevelProgressManager::levelInfos  /*0x04000BB8*/
    IL_0008: brtrue.s IL_000c
    IL_000a: ldc.i4.m1
    IL_000b: ret
    IL_000c: ldarg.0
    IL_000d: ldfld LevelInfo[] LevelProgressManager::levelInfos  /*0x04000BB8*/
    IL_0012: stloc.1
    IL_0013: ldc.i4.0
    IL_0014: stloc.2
    IL_0015: br.s IL_0046
    IL_0017: ldloc.1
    IL_0018: ldloc.2
    IL_0019: ldelem.ref
    IL_001a: stloc.3
    IL_001b: ldloc.3
    IL_001c: ldnull
    IL_001d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0022: brtrue.s IL_0042
    IL_0024: ldloc.3
    IL_0025: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_002a: call bool LevelProgressManager::SceneExists(string)  /*0x0600094C*/
    IL_002f: brfalse.s IL_0042
    IL_0031: ldloc.3
    IL_0032: ldfld LevelInfo.ProgressionContribution LevelInfo::contribution  /*0x04000B26*/
    IL_0037: brtrue.s IL_0042
    IL_0039: ldloc.0
    IL_003a: ldloc.3
    IL_003b: callvirt int LevelInfo::QuestsTotal()  /*0x060008E5*/
    IL_0040: add
    IL_0041: stloc.0
    IL_0042: ldloc.2
    IL_0043: ldc.i4.1
    IL_0044: add
    IL_0045: stloc.2
    IL_0046: ldloc.2
    IL_0047: ldloc.1
    IL_0048: ldlen
    IL_0049: conv.i4
    IL_004a: blt.s IL_0017
    IL_004c: ldloc.0
    IL_004d: ret

  .method LevelProgressManager::CrownsAchieved()  // token 0x0600094E rva 0x2c608 attrs Public, HideBySig
    // code size 78 (0x4e), max stack 2, init locals
    .locals ([0] int, [1] LevelInfo[], [2] int, [3] LevelInfo)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldarg.0
    IL_0003: ldfld LevelInfo[] LevelProgressManager::levelInfos  /*0x04000BB8*/
    IL_0008: brtrue.s IL_000c
    IL_000a: ldc.i4.m1
    IL_000b: ret
    IL_000c: ldarg.0
    IL_000d: ldfld LevelInfo[] LevelProgressManager::levelInfos  /*0x04000BB8*/
    IL_0012: stloc.1
    IL_0013: ldc.i4.0
    IL_0014: stloc.2
    IL_0015: br.s IL_0046
    IL_0017: ldloc.1
    IL_0018: ldloc.2
    IL_0019: ldelem.ref
    IL_001a: stloc.3
    IL_001b: ldloc.3
    IL_001c: ldnull
    IL_001d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0022: brtrue.s IL_0042
    IL_0024: ldloc.3
    IL_0025: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_002a: call bool LevelProgressManager::SceneExists(string)  /*0x0600094C*/
    IL_002f: brfalse.s IL_0042
    IL_0031: ldloc.3
    IL_0032: ldfld LevelInfo.ProgressionContribution LevelInfo::contribution  /*0x04000B26*/
    IL_0037: brtrue.s IL_0042
    IL_0039: ldloc.0
    IL_003a: ldloc.3
    IL_003b: callvirt int LevelInfo::QuestsComplete()  /*0x060008E4*/
    IL_0040: add
    IL_0041: stloc.0
    IL_0042: ldloc.2
    IL_0043: ldc.i4.1
    IL_0044: add
    IL_0045: stloc.2
    IL_0046: ldloc.2
    IL_0047: ldloc.1
    IL_0048: ldlen
    IL_0049: conv.i4
    IL_004a: blt.s IL_0017
    IL_004c: ldloc.0
    IL_004d: ret

  .method LevelProgressManager::.ctor()  // token 0x0600094F rva 0x2c662 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void SceneNameToLevelData::.ctor()  /*0x06000956*/
    IL_0006: stfld SceneNameToLevelData LevelProgressManager::sceneNameToLevelData  /*0x04000BB9*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

  .method LevelProgressManager::.cctor()  // token 0x06000950 rva 0x2c675 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void System.Collections.Generic.Dictionary<string, bool>::.ctor()  /*0x0A00042F*/
    IL_0005: stsfld Dictionary<string, bool> LevelProgressManager::sceneExistsCache  /*0x04000BBB*/
    IL_000a: ret

