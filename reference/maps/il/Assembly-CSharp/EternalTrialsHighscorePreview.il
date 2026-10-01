// ===== EternalTrialsHighscorePreview  (token 0x02000307) =====
  .method EternalTrialsHighscorePreview::OnEnable()  // token 0x060010C9 rva 0x4d778 attrs Private, HideBySig
    // code size 146 (0x92), max stack 6, init locals
    .locals ([0] int, [1] string)
    IL_0000: ldc.i4.1
    IL_0001: stsfld bool HighscoreTable::ETERNAL_TRIALS  /*0x04001429*/
    IL_0006: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_000b: callvirt int LevelProgressManager::get_EternalTrialsHighscore()  /*0x06000942*/
    IL_0010: stloc.0
    IL_0011: ldloc.0
    IL_0012: brtrue.s IL_001c
    IL_0014: ldstr "-"
    IL_0019: stloc.1
    IL_001a: br.s IL_0024
    IL_001c: ldloca.s 0
    IL_001e: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0023: stloc.1
    IL_0024: ldarg.0
    IL_0025: ldfld TMP_Text EternalTrialsHighscorePreview::highscore  /*0x040013E7*/
    IL_002a: ldstr "Menu/Highscore"
    IL_002f: ldc.i4.1
    IL_0030: ldc.i4.0
    IL_0031: ldc.i4.1
    IL_0032: ldc.i4.1
    IL_0033: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0038: ldstr ": "
    IL_003d: ldarg.0
    IL_003e: ldfld string EternalTrialsHighscorePreview::lightTextCue  /*0x040013EA*/
    IL_0043: ldloc.1
    IL_0044: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0049: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_004e: ldarg.0
    IL_004f: ldfld TMP_Text EternalTrialsHighscorePreview::friendsRank  /*0x040013E8*/
    IL_0054: ldstr "Menu/Friends Rank"
    IL_0059: ldc.i4.1
    IL_005a: ldc.i4.0
    IL_005b: ldc.i4.1
    IL_005c: ldc.i4.1
    IL_005d: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0062: ldstr ": "
    IL_0067: ldarg.0
    IL_0068: ldfld string EternalTrialsHighscorePreview::lightTextCue  /*0x040013EA*/
    IL_006d: ldstr "-"
    IL_0072: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0077: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_007c: ldarg.0
    IL_007d: call void EternalTrialsHighscorePreview::SubscribeToGameServices()  /*0x060010CA*/
    IL_0082: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_0087: ldstr "Eternal Trials Season 4"
    IL_008c: callvirt void Thronefall.GameServices.IGameServices::DownloadFriendsHighscores(string)  /*0x06003DFC*/
    IL_0091: ret

  .method EternalTrialsHighscorePreview::SubscribeToGameServices()  // token 0x060010CA rva 0x4d816 attrs Private, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool EternalTrialsHighscorePreview::subscribedToSteamManager  /*0x040013E9*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_000e: callvirt UnityEvent Thronefall.GameServices.IGameServices::get_OnLeaderboardDownloadComplete()  /*0x06003DF8*/
    IL_0013: ldarg.0
    IL_0014: ldftn void EternalTrialsHighscorePreview::RefreshUI()  /*0x060010CB*/
    IL_001a: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_001f: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0024: ldarg.0
    IL_0025: ldc.i4.1
    IL_0026: stfld bool EternalTrialsHighscorePreview::subscribedToSteamManager  /*0x040013E9*/
    IL_002b: ret

  .method EternalTrialsHighscorePreview::RefreshUI()  // token 0x060010CB rva 0x4d844 attrs Public, HideBySig
    // code size 233 (0xe9), max stack 6, init locals
    .locals ([0] List<LeaderboardEntry>, [1] int, [2] int, [3] List.Enumerator<LeaderboardEntry>)
    IL_0000: ldarg.0
    IL_0001: ldfld TMP_Text EternalTrialsHighscorePreview::friendsRank  /*0x040013E8*/
    IL_0006: ldstr "Menu/Friends Rank"
    IL_000b: ldc.i4.1
    IL_000c: ldc.i4.0
    IL_000d: ldc.i4.1
    IL_000e: ldc.i4.1
    IL_000f: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0014: ldstr ": "
    IL_0019: ldarg.0
    IL_001a: ldfld string EternalTrialsHighscorePreview::lightTextCue  /*0x040013EA*/
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
    IL_008f: ldfld TMP_Text EternalTrialsHighscorePreview::friendsRank  /*0x040013E8*/
    IL_0094: dup
    IL_0095: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_009a: ldstr "-"
    IL_009f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00a4: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00a9: ret
    IL_00aa: ldarg.0
    IL_00ab: ldfld TMP_Text EternalTrialsHighscorePreview::friendsRank  /*0x040013E8*/
    IL_00b0: dup
    IL_00b1: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_00b6: ldstr "#"
    IL_00bb: ldloca.s 1
    IL_00bd: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00c2: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_00c7: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00cc: ret
    IL_00cd: ldarg.0
    IL_00ce: ldfld TMP_Text EternalTrialsHighscorePreview::friendsRank  /*0x040013E8*/
    IL_00d3: dup
    IL_00d4: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_00d9: ldstr "-"
    IL_00de: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00e3: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00e8: ret
    .try IL_004b-IL_007d finally handler IL_007d-IL_008b

  .method EternalTrialsHighscorePreview::.ctor()  // token 0x060010CC rva 0x4d94c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldstr "<style=Body Light>"
    IL_0006: stfld string EternalTrialsHighscorePreview::lightTextCue  /*0x040013EA*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

