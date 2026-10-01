// ===== HighscoreTable  (token 0x02000312) =====
  .method HighscoreTable::UpdateLevelTitle()  // token 0x060010ED rva 0x4e5b4 attrs Public, HideBySig
    // code size 188 (0xbc), max stack 6, init locals
    .locals ([0] LevelInfo, [1] TextMeshProUGUI, [2] int)
    IL_0000: ldsfld bool HighscoreTable::ETERNAL_TRIALS  /*0x04001429*/
    IL_0005: brfalse.s IL_0021
    IL_0007: ldarg.0
    IL_0008: ldfld TextMeshProUGUI HighscoreTable::levelTitle  /*0x04001431*/
    IL_000d: ldstr "Menu/Eternal Trials"
    IL_0012: ldc.i4.1
    IL_0013: ldc.i4.0
    IL_0014: ldc.i4.1
    IL_0015: ldc.i4.1
    IL_0016: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_001b: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0020: ret
    IL_0021: ldnull
    IL_0022: stloc.0
    IL_0023: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_0028: ldnull
    IL_0029: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002e: brfalse.s IL_0038
    IL_0030: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_0035: stloc.0
    IL_0036: br.s IL_0043
    IL_0038: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_003d: callvirt LevelInfo LevelProgressManager::GetLevelInfoFromCurrentSceneName()  /*0x06000945*/
    IL_0042: stloc.0
    IL_0043: ldloc.0
    IL_0044: ldnull
    IL_0045: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_004a: brfalse.s IL_004d
    IL_004c: ret
    IL_004d: ldarg.0
    IL_004e: ldfld TextMeshProUGUI HighscoreTable::levelTitle  /*0x04001431*/
    IL_0053: ldloc.0
    IL_0054: callvirt string LevelInfo::get_LocalizedDisplayName()  /*0x060008DF*/
    IL_0059: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_005e: ldloc.0
    IL_005f: callvirt string LevelInfo::get_displaySubtitle()  /*0x060008E0*/
    IL_0064: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_0069: ldc.i4.0
    IL_006a: ble.s IL_00bb
    IL_006c: ldarg.0
    IL_006d: ldfld TextMeshProUGUI HighscoreTable::levelTitle  /*0x04001431*/
    IL_0072: stloc.1
    IL_0073: ldloc.1
    IL_0074: ldc.i4.6
    IL_0075: newarr System.String  /*0x0100001D*/
    IL_007a: dup
    IL_007b: ldc.i4.0
    IL_007c: ldloc.1
    IL_007d: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_0082: stelem.ref
    IL_0083: dup
    IL_0084: ldc.i4.1
    IL_0085: ldstr "\n<size="
    IL_008a: stelem.ref
    IL_008b: dup
    IL_008c: ldc.i4.2
    IL_008d: ldc.i4.s 20
    IL_008f: stloc.2
    IL_0090: ldloca.s 2
    IL_0092: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0097: stelem.ref
    IL_0098: dup
    IL_0099: ldc.i4.3
    IL_009a: ldstr "><style=Subheader>"
    IL_009f: stelem.ref
    IL_00a0: dup
    IL_00a1: ldc.i4.4
    IL_00a2: ldloc.0
    IL_00a3: callvirt string LevelInfo::get_displaySubtitle()  /*0x060008E0*/
    IL_00a8: stelem.ref
    IL_00a9: dup
    IL_00aa: ldc.i4.5
    IL_00ab: ldstr "</size></style>"
    IL_00b0: stelem.ref
    IL_00b1: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_00b6: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00bb: ret

  .method HighscoreTable::SetAndDownloadHighscoreTable(string)  // token 0x060010EE rva 0x4e67c attrs Public, HideBySig
    // code size 207 (0xcf), max stack 4, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject HighscoreTable::noScore  /*0x0400142F*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: ldfld GameObject HighscoreTable::noFriends  /*0x04001430*/
    IL_0012: ldc.i4.0
    IL_0013: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0018: ldarg.0
    IL_0019: ldarg.1
    IL_001a: stfld string HighscoreTable::currentHighscoreTableToCall  /*0x0400142B*/
    IL_001f: ldarg.0
    IL_0020: ldarg.0
    IL_0021: ldfld Transform HighscoreTable::scoreTagParent  /*0x0400142C*/
    IL_0026: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_002b: newarr ScoreTag  /*0x0200033B*/
    IL_0030: stfld ScoreTag[] HighscoreTable::scoreTags  /*0x0400142A*/
    IL_0035: ldc.i4.0
    IL_0036: stloc.0
    IL_0037: br.s IL_006d
    IL_0039: ldarg.0
    IL_003a: ldfld ScoreTag[] HighscoreTable::scoreTags  /*0x0400142A*/
    IL_003f: ldloc.0
    IL_0040: ldarg.0
    IL_0041: ldfld Transform HighscoreTable::scoreTagParent  /*0x0400142C*/
    IL_0046: ldloc.0
    IL_0047: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_004c: callvirt !!0 UnityEngine.Component::GetComponent()<ScoreTag>  /*0x2B0000F1*/
    IL_0051: stelem.ref
    IL_0052: ldarg.0
    IL_0053: ldfld Transform HighscoreTable::scoreTagParent  /*0x0400142C*/
    IL_0058: ldloc.0
    IL_0059: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_005e: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0063: ldc.i4.0
    IL_0064: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0069: ldloc.0
    IL_006a: ldc.i4.1
    IL_006b: add
    IL_006c: stloc.0
    IL_006d: ldloc.0
    IL_006e: ldarg.0
    IL_006f: ldfld Transform HighscoreTable::scoreTagParent  /*0x0400142C*/
    IL_0074: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0079: blt.s IL_0039
    IL_007b: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_0080: callvirt bool Thronefall.GameServices.IGameServices::get_Initialized()  /*0x06003DF7*/
    IL_0085: brfalse.s IL_00b6
    IL_0087: ldarg.0
    IL_0088: call void HighscoreTable::SubscribeToGameServices()  /*0x060010F0*/
    IL_008d: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_0092: ldarg.0
    IL_0093: ldfld string HighscoreTable::currentHighscoreTableToCall  /*0x0400142B*/
    IL_0098: callvirt void Thronefall.GameServices.IGameServices::DownloadFriendsHighscores(string)  /*0x06003DFC*/
    IL_009d: ldarg.0
    IL_009e: ldfld GameObject HighscoreTable::loading  /*0x0400142D*/
    IL_00a3: ldc.i4.1
    IL_00a4: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00a9: ldarg.0
    IL_00aa: ldfld GameObject HighscoreTable::notConnectedToSteam  /*0x0400142E*/
    IL_00af: ldc.i4.0
    IL_00b0: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00b5: ret
    IL_00b6: ldarg.0
    IL_00b7: ldfld GameObject HighscoreTable::loading  /*0x0400142D*/
    IL_00bc: ldc.i4.0
    IL_00bd: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00c2: ldarg.0
    IL_00c3: ldfld GameObject HighscoreTable::notConnectedToSteam  /*0x0400142E*/
    IL_00c8: ldc.i4.1
    IL_00c9: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00ce: ret

  .method HighscoreTable::OnEnable()  // token 0x060010EF rva 0x4e757 attrs Private, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void HighscoreTable::UpdateLevelTitle()  /*0x060010ED*/
    IL_0006: ldsfld bool HighscoreTable::ETERNAL_TRIALS  /*0x04001429*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: ldstr "Eternal Trials Season 4"
    IL_0013: call void HighscoreTable::SetAndDownloadHighscoreTable(string)  /*0x060010EE*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_001f: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0024: call void HighscoreTable::SetAndDownloadHighscoreTable(string)  /*0x060010EE*/
    IL_0029: ret

  .method HighscoreTable::SubscribeToGameServices()  // token 0x060010F0 rva 0x4e784 attrs Private, HideBySig
    // code size 71 (0x47), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool HighscoreTable::subscribedToSteamManager  /*0x04001432*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_000e: callvirt UnityEvent Thronefall.GameServices.IGameServices::get_OnLeaderboardDownloadComplete()  /*0x06003DF8*/
    IL_0013: ldarg.0
    IL_0014: ldftn void HighscoreTable::RefreshUI()  /*0x060010F2*/
    IL_001a: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_001f: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0024: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_0029: callvirt UnityEvent Thronefall.GameServices.IGameServices::get_OnLeaderboardError()  /*0x06003DF9*/
    IL_002e: ldarg.0
    IL_002f: ldftn void HighscoreTable::LeaderboardError()  /*0x060010F1*/
    IL_0035: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_003a: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_003f: ldarg.0
    IL_0040: ldc.i4.1
    IL_0041: stfld bool HighscoreTable::subscribedToSteamManager  /*0x04001432*/
    IL_0046: ret

  .method HighscoreTable::LeaderboardError()  // token 0x060010F1 rva 0x4e7d7 attrs Private, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool UnityEngine.Behaviour::get_isActiveAndEnabled()  /*0x0A000234*/
    IL_0006: brfalse.s IL_0012
    IL_0008: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_000d: callvirt void UIFrameManager::CloseActiveFrame()  /*0x06001309*/
    IL_0012: ret

  .method HighscoreTable::RefreshUI()  // token 0x060010F2 rva 0x4e7ec attrs Private, HideBySig
    // code size 373 (0x175), max stack 5, init locals
    .locals ([0] List<LeaderboardEntry>, [1] int, [2] bool, [3] List.Enumerator<LeaderboardEntry>, [4] int, [5] bool)
    IL_0000: ldc.i4.0
    IL_0001: stloc.1
    IL_0002: br.s IL_001b
    IL_0004: ldarg.0
    IL_0005: ldfld ScoreTag[] HighscoreTable::scoreTags  /*0x0400142A*/
    IL_000a: ldloc.1
    IL_000b: ldelem.ref
    IL_000c: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0011: ldc.i4.0
    IL_0012: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0017: ldloc.1
    IL_0018: ldc.i4.1
    IL_0019: add
    IL_001a: stloc.1
    IL_001b: ldloc.1
    IL_001c: ldarg.0
    IL_001d: ldfld ScoreTag[] HighscoreTable::scoreTags  /*0x0400142A*/
    IL_0022: ldlen
    IL_0023: conv.i4
    IL_0024: blt.s IL_0004
    IL_0026: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_002b: callvirt List<LeaderboardEntry> Thronefall.GameServices.IGameServices::get_LastDownloadedLeaderboardEntries()  /*0x06003DFA*/
    IL_0030: stloc.0
    IL_0031: ldloc.0
    IL_0032: callvirt int System.Collections.Generic.List<Thronefall.GameServices.LeaderboardEntry>::get_Count()  /*0x0A00066A*/
    IL_0037: ldc.i4.0
    IL_0038: ble IL_00c1
    IL_003d: ldarg.0
    IL_003e: ldfld GameObject HighscoreTable::loading  /*0x0400142D*/
    IL_0043: ldc.i4.0
    IL_0044: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0049: ldarg.0
    IL_004a: ldfld GameObject HighscoreTable::notConnectedToSteam  /*0x0400142E*/
    IL_004f: ldc.i4.0
    IL_0050: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0055: ldc.i4.0
    IL_0056: stloc.2
    IL_0057: ldloc.0
    IL_0058: callvirt List.Enumerator<!0> System.Collections.Generic.List<Thronefall.GameServices.LeaderboardEntry>::GetEnumerator()  /*0x0A00066B*/
    IL_005d: stloc.3
    IL_005e: br.s IL_0081
    IL_0060: ldloca.s 3
    IL_0062: call !0 System.Collections.Generic.List.Enumerator<Thronefall.GameServices.LeaderboardEntry>::get_Current()  /*0x0A00066C*/
    IL_0067: ldfld string Thronefall.GameServices.LeaderboardEntry::username  /*0x04003401*/
    IL_006c: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_0071: callvirt string Thronefall.GameServices.IGameServices::GetPersonaName()  /*0x06003DFB*/
    IL_0076: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_007b: brfalse.s IL_0081
    IL_007d: ldc.i4.1
    IL_007e: stloc.2
    IL_007f: leave.s IL_009a
    IL_0081: ldloca.s 3
    IL_0083: call bool System.Collections.Generic.List.Enumerator<Thronefall.GameServices.LeaderboardEntry>::MoveNext()  /*0x0A00066D*/
    IL_0088: brtrue.s IL_0060
    IL_008a: leave.s IL_009a
    IL_008c: ldloca.s 3
    IL_008e: constrained. System.Collections.Generic.List.Enumerator<Thronefall.GameServices.LeaderboardEntry>  /*0x1B000127*/
    IL_0094: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0099: endfinally
    IL_009a: ldarg.0
    IL_009b: ldfld GameObject HighscoreTable::noScore  /*0x0400142F*/
    IL_00a0: ldloc.2
    IL_00a1: ldc.i4.0
    IL_00a2: ceq
    IL_00a4: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00a9: ldarg.0
    IL_00aa: ldfld GameObject HighscoreTable::noFriends  /*0x04001430*/
    IL_00af: ldloc.0
    IL_00b0: callvirt int System.Collections.Generic.List<Thronefall.GameServices.LeaderboardEntry>::get_Count()  /*0x0A00066A*/
    IL_00b5: ldc.i4.1
    IL_00b6: ceq
    IL_00b8: ldloc.2
    IL_00b9: and
    IL_00ba: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00bf: br.s IL_00f1
    IL_00c1: ldarg.0
    IL_00c2: ldfld GameObject HighscoreTable::loading  /*0x0400142D*/
    IL_00c7: ldc.i4.0
    IL_00c8: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00cd: ldarg.0
    IL_00ce: ldfld GameObject HighscoreTable::notConnectedToSteam  /*0x0400142E*/
    IL_00d3: ldc.i4.0
    IL_00d4: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00d9: ldarg.0
    IL_00da: ldfld GameObject HighscoreTable::noScore  /*0x0400142F*/
    IL_00df: ldc.i4.1
    IL_00e0: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00e5: ldarg.0
    IL_00e6: ldfld GameObject HighscoreTable::noFriends  /*0x04001430*/
    IL_00eb: ldc.i4.1
    IL_00ec: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00f1: ldc.i4.0
    IL_00f2: stloc.s 4
    IL_00f4: br.s IL_016a
    IL_00f6: ldloc.s 4
    IL_00f8: ldarg.0
    IL_00f9: ldfld ScoreTag[] HighscoreTable::scoreTags  /*0x0400142A*/
    IL_00fe: ldlen
    IL_00ff: conv.i4
    IL_0100: ldc.i4.1
    IL_0101: sub
    IL_0102: bgt.s IL_0174
    IL_0104: ldloc.0
    IL_0105: ldloc.s 4
    IL_0107: callvirt !0 System.Collections.Generic.List<Thronefall.GameServices.LeaderboardEntry>::get_Item(int)  /*0x0A00067D*/
    IL_010c: ldfld string Thronefall.GameServices.LeaderboardEntry::username  /*0x04003401*/
    IL_0111: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_0116: callvirt string Thronefall.GameServices.IGameServices::GetPersonaName()  /*0x06003DFB*/
    IL_011b: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0120: stloc.s 5
    IL_0122: ldarg.0
    IL_0123: ldfld ScoreTag[] HighscoreTable::scoreTags  /*0x0400142A*/
    IL_0128: ldloc.s 4
    IL_012a: ldelem.ref
    IL_012b: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0130: ldc.i4.1
    IL_0131: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0136: ldarg.0
    IL_0137: ldfld ScoreTag[] HighscoreTable::scoreTags  /*0x0400142A*/
    IL_013c: ldloc.s 4
    IL_013e: ldelem.ref
    IL_013f: ldloc.0
    IL_0140: ldloc.s 4
    IL_0142: callvirt !0 System.Collections.Generic.List<Thronefall.GameServices.LeaderboardEntry>::get_Item(int)  /*0x0A00067D*/
    IL_0147: ldfld string Thronefall.GameServices.LeaderboardEntry::username  /*0x04003401*/
    IL_014c: ldloc.0
    IL_014d: ldloc.s 4
    IL_014f: callvirt !0 System.Collections.Generic.List<Thronefall.GameServices.LeaderboardEntry>::get_Item(int)  /*0x0A00067D*/
    IL_0154: ldfld int Thronefall.GameServices.LeaderboardEntry::score  /*0x04003402*/
    IL_0159: ldloc.s 4
    IL_015b: ldc.i4.1
    IL_015c: add
    IL_015d: ldloc.s 5
    IL_015f: callvirt void ScoreTag::SetNameAndScore(string,int,int,bool)  /*0x060011AA*/
    IL_0164: ldloc.s 4
    IL_0166: ldc.i4.1
    IL_0167: add
    IL_0168: stloc.s 4
    IL_016a: ldloc.s 4
    IL_016c: ldloc.0
    IL_016d: callvirt int System.Collections.Generic.List<Thronefall.GameServices.LeaderboardEntry>::get_Count()  /*0x0A00066A*/
    IL_0172: blt.s IL_00f6
    IL_0174: ret
    .try IL_005e-IL_008c finally handler IL_008c-IL_009a

  .method HighscoreTable::.ctor()  // token 0x060010F3 rva 0x4e980 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: newarr ScoreTag  /*0x0200033B*/
    IL_0007: stfld ScoreTag[] HighscoreTable::scoreTags  /*0x0400142A*/
    IL_000c: ldarg.0
    IL_000d: ldstr ""
    IL_0012: stfld string HighscoreTable::currentHighscoreTableToCall  /*0x0400142B*/
    IL_0017: ldarg.0
    IL_0018: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001d: ret

