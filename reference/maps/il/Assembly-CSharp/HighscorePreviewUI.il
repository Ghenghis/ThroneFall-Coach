// ===== HighscorePreviewUI  (token 0x02000311) =====
  .method HighscorePreviewUI::OnEnable()  // token 0x060010E9 rva 0x4e3b8 attrs Private, HideBySig
    // code size 166 (0xa6), max stack 6, init locals
    .locals ([0] int, [1] string)
    IL_0000: ldc.i4.0
    IL_0001: stsfld bool HighscoreTable::ETERNAL_TRIALS  /*0x04001429*/
    IL_0006: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_000b: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_0010: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0015: callvirt LevelData LevelProgressManager::GetLevelDataForScene(string)  /*0x0600094A*/
    IL_001a: ldfld int LevelData::highscoreBest  /*0x04000BC2*/
    IL_001f: stloc.0
    IL_0020: ldloc.0
    IL_0021: brtrue.s IL_002b
    IL_0023: ldstr "-"
    IL_0028: stloc.1
    IL_0029: br.s IL_0033
    IL_002b: ldloca.s 0
    IL_002d: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0032: stloc.1
    IL_0033: ldarg.0
    IL_0034: ldfld TMP_Text HighscorePreviewUI::highscore  /*0x04001425*/
    IL_0039: ldstr "Menu/Highscore"
    IL_003e: ldc.i4.1
    IL_003f: ldc.i4.0
    IL_0040: ldc.i4.1
    IL_0041: ldc.i4.1
    IL_0042: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0047: ldstr ": "
    IL_004c: ldarg.0
    IL_004d: ldfld string HighscorePreviewUI::lightTextCue  /*0x04001428*/
    IL_0052: ldloc.1
    IL_0053: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0058: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_005d: ldarg.0
    IL_005e: ldfld TMP_Text HighscorePreviewUI::friendsRank  /*0x04001426*/
    IL_0063: ldstr "Menu/Friends Rank"
    IL_0068: ldc.i4.1
    IL_0069: ldc.i4.0
    IL_006a: ldc.i4.1
    IL_006b: ldc.i4.1
    IL_006c: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0071: ldstr ": "
    IL_0076: ldarg.0
    IL_0077: ldfld string HighscorePreviewUI::lightTextCue  /*0x04001428*/
    IL_007c: ldstr "-"
    IL_0081: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0086: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_008b: ldarg.0
    IL_008c: call void HighscorePreviewUI::SubscribeToGameServices()  /*0x060010EA*/
    IL_0091: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_0096: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_009b: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_00a0: callvirt void Thronefall.GameServices.IGameServices::DownloadFriendsHighscores(string)  /*0x06003DFC*/
    IL_00a5: ret

  .method HighscorePreviewUI::SubscribeToGameServices()  // token 0x060010EA rva 0x4e46a attrs Private, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool HighscorePreviewUI::subscribedToSteamManager  /*0x04001427*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_000e: callvirt UnityEvent Thronefall.GameServices.IGameServices::get_OnLeaderboardDownloadComplete()  /*0x06003DF8*/
    IL_0013: ldarg.0
    IL_0014: ldftn void HighscorePreviewUI::RefreshUI()  /*0x060010EB*/
    IL_001a: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_001f: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0024: ldarg.0
    IL_0025: ldc.i4.1
    IL_0026: stfld bool HighscorePreviewUI::subscribedToSteamManager  /*0x04001427*/
    IL_002b: ret

  .method HighscorePreviewUI::RefreshUI()  // token 0x060010EB rva 0x4e498 attrs Public, HideBySig
    // code size 233 (0xe9), max stack 6, init locals
    .locals ([0] List<LeaderboardEntry>, [1] int, [2] int, [3] List.Enumerator<LeaderboardEntry>)
    IL_0000: ldarg.0
    IL_0001: ldfld TMP_Text HighscorePreviewUI::friendsRank  /*0x04001426*/
    IL_0006: ldstr "Menu/Friends Rank"
    IL_000b: ldc.i4.1
    IL_000c: ldc.i4.0
    IL_000d: ldc.i4.1
    IL_000e: ldc.i4.1
    IL_000f: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0014: ldstr ": "
    IL_0019: ldarg.0
    IL_001a: ldfld string HighscorePreviewUI::lightTextCue  /*0x04001428*/
    IL_001f: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0024: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0029: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_002e: callvirt List<LeaderboardEntry> Thronefall.GameServices.IGameServices::get_LastDownloadedLeaderboardEntries()  /*0x06003DFA*/
    IL_0033: stloc.0
    IL_0034: ldloc.0
    IL_0035: callvirt int System.Collections.Generic.List<Thronefall.GameServices.LeaderboardEntry>::get_Count()  /*0x0A00066A*/
    IL_003a: ldc.i4.0
    IL_003b: ble IL_00cd
    IL_0040: ldc.i4.0
    IL_0041: stloc.1
    IL_0042: ldc.i4.1
    IL_0043: stloc.2
    IL_0044: ldloc.0
    IL_0045: callvirt List.Enumerator<!0> System.Collections.Generic.List<Thronefall.GameServices.LeaderboardEntry>::GetEnumerator()  /*0x0A00066B*/
    IL_004a: stloc.3
    IL_004b: br.s IL_0072
    IL_004d: ldloca.s 3
    IL_004f: call !0 System.Collections.Generic.List.Enumerator<Thronefall.GameServices.LeaderboardEntry>::get_Current()  /*0x0A00066C*/
    IL_0054: ldfld string Thronefall.GameServices.LeaderboardEntry::username  /*0x04003401*/
    IL_0059: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_005e: callvirt string Thronefall.GameServices.IGameServices::GetPersonaName()  /*0x06003DFB*/
    IL_0063: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0068: brfalse.s IL_006e
    IL_006a: ldloc.2
    IL_006b: stloc.1
    IL_006c: leave.s IL_008b
    IL_006e: ldloc.2
    IL_006f: ldc.i4.1
    IL_0070: add
    IL_0071: stloc.2
    IL_0072: ldloca.s 3
    IL_0074: call bool System.Collections.Generic.List.Enumerator<Thronefall.GameServices.LeaderboardEntry>::MoveNext()  /*0x0A00066D*/
    IL_0079: brtrue.s IL_004d
    IL_007b: leave.s IL_008b
    IL_007d: ldloca.s 3
    IL_007f: constrained. System.Collections.Generic.List.Enumerator<Thronefall.GameServices.LeaderboardEntry>  /*0x1B000127*/
    IL_0085: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_008a: endfinally
    IL_008b: ldloc.1
    IL_008c: brtrue.s IL_00aa
    IL_008e: ldarg.0
    IL_008f: ldfld TMP_Text HighscorePreviewUI::friendsRank  /*0x04001426*/
    IL_0094: dup
    IL_0095: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_009a: ldstr "-"
    IL_009f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00a4: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00a9: ret
    IL_00aa: ldarg.0
    IL_00ab: ldfld TMP_Text HighscorePreviewUI::friendsRank  /*0x04001426*/
    IL_00b0: dup
    IL_00b1: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_00b6: ldstr "#"
    IL_00bb: ldloca.s 1
    IL_00bd: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00c2: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_00c7: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00cc: ret
    IL_00cd: ldarg.0
    IL_00ce: ldfld TMP_Text HighscorePreviewUI::friendsRank  /*0x04001426*/
    IL_00d3: dup
    IL_00d4: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_00d9: ldstr "-"
    IL_00de: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00e3: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00e8: ret
    .try IL_004b-IL_007d finally handler IL_007d-IL_008b

  .method HighscorePreviewUI::.ctor()  // token 0x060010EC rva 0x4e5a0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldstr "<style=Body Light>"
    IL_0006: stfld string HighscorePreviewUI::lightTextCue  /*0x04001428*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

