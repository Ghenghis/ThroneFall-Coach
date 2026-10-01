// ===== InGamePopUpHelper  (token 0x02000313) =====
  .method InGamePopUpHelper::Awake()  // token 0x060010F4 rva 0x4e99f attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld InGamePopUpHelper InGamePopUpHelper::instance  /*0x04001433*/
    IL_0006: ret

  .method InGamePopUpHelper::PopEternalTrials()  // token 0x060010F5 rva 0x4e9a8 attrs Public, HideBySig
    // code size 251 (0xfb), max stack 2, init locals
    .locals ([0] bool, [1] bool)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldc.i4.0
    IL_0003: stloc.1
    IL_0004: call bool EternalTrialsRunManager::get_HasOngoingRun()  /*0x060006EC*/
    IL_0009: brtrue.s IL_0017
    IL_000b: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0010: callvirt int LevelProgressManager::get_EternalTrialsHighscore()  /*0x06000942*/
    IL_0015: brfalse.s IL_0034
    IL_0017: ldc.i4.1
    IL_0018: stloc.0
    IL_0019: ldstr "PopupShown_"
    IL_001e: ldarg.0
    IL_001f: ldfld InGamePopUp InGamePopUpHelper::eternalTrialsFirstTime  /*0x04001435*/
    IL_0024: ldfld string InGamePopUp::identifier  /*0x04001439*/
    IL_0029: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_002e: ldc.i4.1
    IL_002f: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0034: ldstr "PopupShown_"
    IL_0039: ldarg.0
    IL_003a: ldfld InGamePopUp InGamePopUpHelper::eternalTrialsFirstTime  /*0x04001435*/
    IL_003f: ldfld string InGamePopUp::identifier  /*0x04001439*/
    IL_0044: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0049: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_004e: brfalse.s IL_0054
    IL_0050: ldc.i4.1
    IL_0051: stloc.0
    IL_0052: br.s IL_008a
    IL_0054: ldstr "PopupShown_"
    IL_0059: ldarg.0
    IL_005a: ldfld InGamePopUp InGamePopUpHelper::eternalTrialsFirstTime  /*0x04001435*/
    IL_005f: ldfld string InGamePopUp::identifier  /*0x04001439*/
    IL_0064: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0069: ldc.i4.1
    IL_006a: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_006f: ldstr "PopupShown_"
    IL_0074: ldarg.0
    IL_0075: ldfld InGamePopUp InGamePopUpHelper::eternalTrialsNewPatch  /*0x04001436*/
    IL_007a: ldfld string InGamePopUp::identifier  /*0x04001439*/
    IL_007f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0084: ldc.i4.1
    IL_0085: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_008a: ldstr "PopupShown_"
    IL_008f: ldarg.0
    IL_0090: ldfld InGamePopUp InGamePopUpHelper::eternalTrialsNewPatch  /*0x04001436*/
    IL_0095: ldfld string InGamePopUp::identifier  /*0x04001439*/
    IL_009a: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_009f: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_00a4: brfalse.s IL_00aa
    IL_00a6: ldc.i4.1
    IL_00a7: stloc.1
    IL_00a8: br.s IL_00c5
    IL_00aa: ldstr "PopupShown_"
    IL_00af: ldarg.0
    IL_00b0: ldfld InGamePopUp InGamePopUpHelper::eternalTrialsNewPatch  /*0x04001436*/
    IL_00b5: ldfld string InGamePopUp::identifier  /*0x04001439*/
    IL_00ba: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00bf: ldc.i4.1
    IL_00c0: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_00c5: ldloc.0
    IL_00c6: brtrue.s IL_00df
    IL_00c8: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_00cd: ldarg.0
    IL_00ce: ldfld InGamePopUp InGamePopUpHelper::eternalTrialsFirstTime  /*0x04001435*/
    IL_00d3: ldfld UIFrame InGamePopUp::uiFrame  /*0x04001438*/
    IL_00d8: callvirt void UIFrameManager::ChangeActiveFrameKeepOldVisible(UIFrame)  /*0x06001307*/
    IL_00dd: ldc.i4.1
    IL_00de: ret
    IL_00df: ldloc.1
    IL_00e0: brtrue.s IL_00f9
    IL_00e2: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_00e7: ldarg.0
    IL_00e8: ldfld InGamePopUp InGamePopUpHelper::eternalTrialsNewPatch  /*0x04001436*/
    IL_00ed: ldfld UIFrame InGamePopUp::uiFrame  /*0x04001438*/
    IL_00f2: callvirt void UIFrameManager::ChangeActiveFrameKeepOldVisible(UIFrame)  /*0x06001307*/
    IL_00f7: ldc.i4.1
    IL_00f8: ret
    IL_00f9: ldc.i4.0
    IL_00fa: ret

  .method InGamePopUpHelper::PopMiniModes()  // token 0x060010F6 rva 0x4eab0 attrs Public, HideBySig
    // code size 81 (0x51), max stack 2, init locals
    IL_0000: ldstr "PopupShown_"
    IL_0005: ldarg.0
    IL_0006: ldfld InGamePopUp InGamePopUpHelper::minimodesFirstTime  /*0x04001437*/
    IL_000b: ldfld string InGamePopUp::identifier  /*0x04001439*/
    IL_0010: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0015: ldc.i4.0
    IL_0016: call int UnityEngine.PlayerPrefs::GetInt(string,int)  /*0x0A0005A8*/
    IL_001b: brtrue.s IL_004f
    IL_001d: ldstr "PopupShown_"
    IL_0022: ldarg.0
    IL_0023: ldfld InGamePopUp InGamePopUpHelper::minimodesFirstTime  /*0x04001437*/
    IL_0028: ldfld string InGamePopUp::identifier  /*0x04001439*/
    IL_002d: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0032: ldc.i4.1
    IL_0033: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0038: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_003d: ldarg.0
    IL_003e: ldfld InGamePopUp InGamePopUpHelper::minimodesFirstTime  /*0x04001437*/
    IL_0043: ldfld UIFrame InGamePopUp::uiFrame  /*0x04001438*/
    IL_0048: callvirt void UIFrameManager::ChangeActiveFrameKeepOldVisible(UIFrame)  /*0x06001307*/
    IL_004d: ldc.i4.1
    IL_004e: ret
    IL_004f: ldc.i4.0
    IL_0050: ret

  .method InGamePopUpHelper::.ctor()  // token 0x060010F7 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

