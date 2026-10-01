// ===== GameProgressResetter  (token 0x0200026B) =====
  .method GameProgressResetter::get_savegameDirectoryPath()  // token 0x06000D5A rva 0x3d215 attrs Private, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: call string UnityEngine.Application::get_persistentDataPath()  /*0x0A00058C*/
    IL_0005: ret

  .method GameProgressResetter::ResetAndBackupAllGameProgress()  // token 0x06000D5B rva 0x3d21c attrs Public, Static, HideBySig
    // code size 268 (0x10c), max stack 4, init locals
    .locals ([0] string, [1] string[], [2] FileInfo[], [3] int, [4] FileInfo, [5] Exception)
    IL_0000: call string GameProgressResetter::get_savegameDirectoryPath()  /*0x06000D5A*/
    IL_0005: ldstr "Before Reset Backup "
    IL_000a: call string GameProgressResetter::GetTimestamp()  /*0x06000D5E*/
    IL_000f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0014: call string System.IO.Path::Combine(string,string)  /*0x0A000521*/
    IL_0019: stloc.0
    IL_001a: ldloc.0
    IL_001b: call DirectoryInfo System.IO.Directory::CreateDirectory(string)  /*0x0A000525*/
    IL_0020: pop
    IL_0021: call string GameProgressResetter::get_savegameDirectoryPath()  /*0x06000D5A*/
    IL_0026: newobj void System.IO.DirectoryInfo::.ctor(string)  /*0x0A00058D*/
    IL_002b: call string[] GameProgressResetter::GetFileNamesToSkip()  /*0x06000D5D*/
    IL_0030: stloc.1
    IL_0031: callvirt FileInfo[] System.IO.DirectoryInfo::GetFiles()  /*0x0A00058E*/
    IL_0036: stloc.2
    IL_0037: ldc.i4.0
    IL_0038: stloc.3
    IL_0039: br.s IL_00b6
    IL_003b: ldloc.2
    IL_003c: ldloc.3
    IL_003d: ldelem.ref
    IL_003e: stloc.s 4
    IL_0040: ldloc.1
    IL_0041: ldloc.s 4
    IL_0043: callvirt string System.IO.FileSystemInfo::get_Name()  /*0x0A00058F*/
    IL_0048: call bool System.Linq.Enumerable::Contains(System.Collections.Generic.IEnumerable<!!0>,!!0)<string>  /*0x2B0000C7*/
    IL_004d: brtrue.s IL_00b2
    IL_004f: nop
    IL_0050: ldloc.s 4
    IL_0052: ldloc.0
    IL_0053: ldloc.s 4
    IL_0055: callvirt string System.IO.FileSystemInfo::get_Name()  /*0x0A00058F*/
    IL_005a: call string System.IO.Path::Combine(string,string)  /*0x0A000521*/
    IL_005f: callvirt FileInfo System.IO.FileInfo::CopyTo(string)  /*0x0A000590*/
    IL_0064: pop
    IL_0065: ldloc.s 4
    IL_0067: callvirt void System.IO.FileSystemInfo::Delete()  /*0x0A000591*/
    IL_006c: leave.s IL_00b2
    IL_006e: stloc.s 5
    IL_0070: ldc.i4.6
    IL_0071: newarr System.String  /*0x0100001D*/
    IL_0076: dup
    IL_0077: ldc.i4.0
    IL_0078: ldstr "The following file could not be copied or deleted: "
    IL_007d: stelem.ref
    IL_007e: dup
    IL_007f: ldc.i4.1
    IL_0080: ldloc.0
    IL_0081: stelem.ref
    IL_0082: dup
    IL_0083: ldc.i4.2
    IL_0084: ldstr "/"
    IL_0089: stelem.ref
    IL_008a: dup
    IL_008b: ldc.i4.3
    IL_008c: ldloc.s 4
    IL_008e: callvirt string System.IO.FileSystemInfo::get_Name()  /*0x0A00058F*/
    IL_0093: stelem.ref
    IL_0094: dup
    IL_0095: ldc.i4.4
    IL_0096: ldstr " because: "
    IL_009b: stelem.ref
    IL_009c: dup
    IL_009d: ldc.i4.5
    IL_009e: ldloc.s 5
    IL_00a0: callvirt string System.Exception::get_Message()  /*0x0A000528*/
    IL_00a5: stelem.ref
    IL_00a6: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_00ab: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_00b0: leave.s IL_00b2
    IL_00b2: ldloc.3
    IL_00b3: ldc.i4.1
    IL_00b4: add
    IL_00b5: stloc.3
    IL_00b6: ldloc.3
    IL_00b7: ldloc.2
    IL_00b8: ldlen
    IL_00b9: conv.i4
    IL_00ba: blt IL_003b
    IL_00bf: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_00c4: callvirt SceneNameToLevelData LevelProgressManager::get_SceneNameToLevelData()  /*0x06000946*/
    IL_00c9: callvirt void System.Collections.Generic.Dictionary<string, LevelData>::Clear()  /*0x0A000466*/
    IL_00ce: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00d3: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00d8: brfalse.s IL_00f5
    IL_00da: call void PerkManager::ClearAllEquipped()  /*0x060009A6*/
    IL_00df: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00e4: ldc.i4.1
    IL_00e5: stfld int PerkManager::level  /*0x04000BEC*/
    IL_00ea: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00ef: ldc.i4.0
    IL_00f0: stfld int PerkManager::xp  /*0x04000BEB*/
    IL_00f5: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_00fa: callvirt SceneTransitionManager.SceneState SceneTransitionManager::get_CurrentSceneState()  /*0x060009BC*/
    IL_00ff: brfalse.s IL_010b
    IL_0101: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0106: callvirt void SceneTransitionManager::TransitionToMainMenu()  /*0x060009D5*/
    IL_010b: ret
    .try IL_0050-IL_006e catch System.Exception handler IL_006e-IL_00b2

  .method GameProgressResetter::GetFileNamesToBackUp()  // token 0x06000D5C rva 0x3d344 attrs Public, Static, HideBySig
    // code size 110 (0x6e), max stack 3, init locals
    .locals ([0] List<string>, [1] string[], [2] int, [3] string)
    IL_0000: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_0005: dup
    IL_0006: ldsfld SaveLoadManager SaveLoadManager::instance  /*0x04000C65*/
    IL_000b: callvirt string SaveLoadManager::get_SaveFileName()  /*0x060009B0*/
    IL_0010: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0015: dup
    IL_0016: ldstr "EternalTrials_V4.json"
    IL_001b: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0020: dup
    IL_0021: ldstr "ET_CurrentLevel.json"
    IL_0026: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_002b: stloc.0
    IL_002c: ldstr "scenes"
    IL_0031: call !!0 UnityEngine.Resources::Load(string)<UnityEngine.TextAsset>  /*0x2B0000C8*/
    IL_0036: callvirt string UnityEngine.TextAsset::get_text()  /*0x0A000464*/
    IL_003b: ldc.i4.s 10
    IL_003d: ldc.i4.0
    IL_003e: callvirt string[] System.String::Split(char,System.StringSplitOptions)  /*0x0A000592*/
    IL_0043: stloc.1
    IL_0044: ldc.i4.0
    IL_0045: stloc.2
    IL_0046: br.s IL_0061
    IL_0048: ldloc.1
    IL_0049: ldloc.2
    IL_004a: ldelem.ref
    IL_004b: stloc.3
    IL_004c: ldloc.0
    IL_004d: ldloc.3
    IL_004e: ldstr ".json"
    IL_0053: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0058: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_005d: ldloc.2
    IL_005e: ldc.i4.1
    IL_005f: add
    IL_0060: stloc.2
    IL_0061: ldloc.2
    IL_0062: ldloc.1
    IL_0063: ldlen
    IL_0064: conv.i4
    IL_0065: blt.s IL_0048
    IL_0067: ldloc.0
    IL_0068: callvirt !0[] System.Collections.Generic.List<string>::ToArray()  /*0x0A000593*/
    IL_006d: ret

  .method GameProgressResetter::GetFileNamesToSkip()  // token 0x06000D5D rva 0x3d3be attrs Public, Static, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_0005: dup
    IL_0006: ldstr "ControlsConfig_v2.json"
    IL_000b: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0010: callvirt !0[] System.Collections.Generic.List<string>::ToArray()  /*0x0A000593*/
    IL_0015: ret

  .method GameProgressResetter::GetTimestamp()  // token 0x06000D5E rva 0x3d3d8 attrs Public, Static, HideBySig
    // code size 19 (0x13), max stack 2, init locals
    .locals ([0] DateTime)
    IL_0000: call DateTime System.DateTime::get_Now()  /*0x0A00051F*/
    IL_0005: stloc.0
    IL_0006: ldloca.s 0
    IL_0008: ldstr "yyyyMMdd_HHmmss"
    IL_000d: call string System.DateTime::ToString(string)  /*0x0A000520*/
    IL_0012: ret

