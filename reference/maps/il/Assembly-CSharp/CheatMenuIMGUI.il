// ===== CheatMenuIMGUI  (token 0x020002DE) =====
  .method CheatMenuIMGUI::Awake()  // token 0x06000FC7 rva 0x47f65 attrs Private, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0006: ldarg.0
    IL_0007: ldfld int CheatMenuIMGUI::playerId  /*0x040012A1*/
    IL_000c: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_0011: stfld Player CheatMenuIMGUI::player  /*0x040012A3*/
    IL_0016: ret

  .method CheatMenuIMGUI::Init(System.Collections.Generic.IEnumerable<CheatCategory>)  // token 0x06000FC8 rva 0x47f7d attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: newobj void System.Collections.Generic.List<CheatCategory>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A00060E*/
    IL_0007: stfld List<CheatCategory> CheatMenuIMGUI::categories  /*0x040012A4*/
    IL_000c: ret

  .method CheatMenuIMGUI::Update()  // token 0x06000FC9 rva 0x47f8b attrs Private, HideBySig
    // code size 16 (0x10), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool CheatMenuIMGUI::visible  /*0x040012A2*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: call void CheatMenuIMGUI::HandleInput()  /*0x06000FCC*/
    IL_000f: ret

  .method CheatMenuIMGUI::OnGUI()  // token 0x06000FCA rva 0x47f9c attrs Private, HideBySig
    // code size 205 (0xcd), max stack 5, init locals
    .locals ([0] GUIStyle)
    IL_0000: ldarg.0
    IL_0001: ldfld bool CheatMenuIMGUI::visible  /*0x040012A2*/
    IL_0006: brfalse.s IL_001d
    IL_0008: ldarg.0
    IL_0009: ldfld List<CheatCategory> CheatMenuIMGUI::categories  /*0x040012A4*/
    IL_000e: brfalse.s IL_001d
    IL_0010: ldarg.0
    IL_0011: ldfld List<CheatCategory> CheatMenuIMGUI::categories  /*0x040012A4*/
    IL_0016: callvirt int System.Collections.Generic.List<CheatCategory>::get_Count()  /*0x0A00060F*/
    IL_001b: brtrue.s IL_001e
    IL_001d: ret
    IL_001e: ldc.r4 20f
    IL_0023: ldc.r4 20f
    IL_0028: ldc.r4 350f
    IL_002d: call int UnityEngine.Screen::get_height()  /*0x0A0003B8*/
    IL_0032: ldc.i4.s 40
    IL_0034: sub
    IL_0035: conv.r4
    IL_0036: newobj void UnityEngine.Rect::.ctor(float,float,float,float)  /*0x0A000610*/
    IL_003b: ldstr ""
    IL_0040: call void UnityEngine.GUI::Box(UnityEngine.Rect,string)  /*0x0A000611*/
    IL_0045: ldc.r4 30f
    IL_004a: ldc.r4 30f
    IL_004f: ldc.r4 330f
    IL_0054: call int UnityEngine.Screen::get_height()  /*0x0A0003B8*/
    IL_0059: ldc.i4.s 60
    IL_005b: sub
    IL_005c: conv.r4
    IL_005d: newobj void UnityEngine.Rect::.ctor(float,float,float,float)  /*0x0A000610*/
    IL_0062: call void UnityEngine.GUILayout::BeginArea(UnityEngine.Rect)  /*0x0A000612*/
    IL_0067: call GUISkin UnityEngine.GUI::get_skin()  /*0x0A000613*/
    IL_006c: callvirt GUIStyle UnityEngine.GUISkin::get_label()  /*0x0A000614*/
    IL_0071: newobj void UnityEngine.GUIStyle::.ctor(UnityEngine.GUIStyle)  /*0x0A000615*/
    IL_0076: stloc.0
    IL_0077: ldloc.0
    IL_0078: ldc.i4.s 18
    IL_007a: callvirt void UnityEngine.GUIStyle::set_fontSize(int)  /*0x0A000616*/
    IL_007f: ldloc.0
    IL_0080: ldc.i4.4
    IL_0081: callvirt void UnityEngine.GUIStyle::set_alignment(UnityEngine.TextAnchor)  /*0x0A000617*/
    IL_0086: ldloc.0
    IL_0087: callvirt GUIStyleState UnityEngine.GUIStyle::get_normal()  /*0x0A000618*/
    IL_008c: call Color UnityEngine.Color::get_yellow()  /*0x0A000181*/
    IL_0091: callvirt void UnityEngine.GUIStyleState::set_textColor(UnityEngine.Color)  /*0x0A000619*/
    IL_0096: ldarg.0
    IL_0097: ldfld List<CheatCategory> CheatMenuIMGUI::categories  /*0x040012A4*/
    IL_009c: ldarg.0
    IL_009d: ldfld int CheatMenuIMGUI::selectedCategory  /*0x040012A5*/
    IL_00a2: callvirt !0 System.Collections.Generic.List<CheatCategory>::get_Item(int)  /*0x0A00061A*/
    IL_00a7: ldfld string CheatCategory::Name  /*0x0400128B*/
    IL_00ac: ldloc.0
    IL_00ad: call !!0[] System.Array::Empty()<UnityEngine.GUILayoutOption>  /*0x2B0000DF*/
    IL_00b2: call void UnityEngine.GUILayout::Label(string,UnityEngine.GUIStyle,UnityEngine.GUILayoutOption[])  /*0x0A00061C*/
    IL_00b7: ldc.r4 10f
    IL_00bc: call void UnityEngine.GUILayout::Space(float)  /*0x0A00061D*/
    IL_00c1: ldarg.0
    IL_00c2: call void CheatMenuIMGUI::DrawCategoryContents()  /*0x06000FCB*/
    IL_00c7: call void UnityEngine.GUILayout::EndArea()  /*0x0A00061E*/
    IL_00cc: ret

  .method CheatMenuIMGUI::DrawCategoryContents()  // token 0x06000FCB rva 0x48078 attrs Private, HideBySig
    // code size 299 (0x12b), max stack 6, init locals
    .locals ([0] CheatCategory, [1] int, [2] CheatEntry, [3] GUIStyle, [4] CheatType)
    IL_0000: ldarg.0
    IL_0001: ldfld List<CheatCategory> CheatMenuIMGUI::categories  /*0x040012A4*/
    IL_0006: ldarg.0
    IL_0007: ldfld int CheatMenuIMGUI::selectedCategory  /*0x040012A5*/
    IL_000c: callvirt !0 System.Collections.Generic.List<CheatCategory>::get_Item(int)  /*0x0A00061A*/
    IL_0011: stloc.0
    IL_0012: ldarg.0
    IL_0013: ldarg.0
    IL_0014: ldfld Vector2 CheatMenuIMGUI::scrollPos  /*0x040012A7*/
    IL_0019: call !!0[] System.Array::Empty()<UnityEngine.GUILayoutOption>  /*0x2B0000DF*/
    IL_001e: call Vector2 UnityEngine.GUILayout::BeginScrollView(UnityEngine.Vector2,UnityEngine.GUILayoutOption[])  /*0x0A00061F*/
    IL_0023: stfld Vector2 CheatMenuIMGUI::scrollPos  /*0x040012A7*/
    IL_0028: ldc.i4.0
    IL_0029: stloc.1
    IL_002a: br IL_0114
    IL_002f: ldloc.0
    IL_0030: ldfld List<CheatEntry> CheatCategory::Cheats  /*0x0400128C*/
    IL_0035: ldloc.1
    IL_0036: callvirt !0 System.Collections.Generic.List<CheatEntry>::get_Item(int)  /*0x0A000620*/
    IL_003b: stloc.2
    IL_003c: call !!0[] System.Array::Empty()<UnityEngine.GUILayoutOption>  /*0x2B0000DF*/
    IL_0041: call void UnityEngine.GUILayout::BeginHorizontal(UnityEngine.GUILayoutOption[])  /*0x0A000621*/
    IL_0046: call GUISkin UnityEngine.GUI::get_skin()  /*0x0A000613*/
    IL_004b: callvirt GUIStyle UnityEngine.GUISkin::get_label()  /*0x0A000614*/
    IL_0050: newobj void UnityEngine.GUIStyle::.ctor(UnityEngine.GUIStyle)  /*0x0A000615*/
    IL_0055: stloc.3
    IL_0056: ldloc.3
    IL_0057: callvirt GUIStyleState UnityEngine.GUIStyle::get_normal()  /*0x0A000618*/
    IL_005c: ldloc.1
    IL_005d: ldarg.0
    IL_005e: ldfld int CheatMenuIMGUI::selectedCheat  /*0x040012A6*/
    IL_0063: beq.s IL_006c
    IL_0065: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_006a: br.s IL_0071
    IL_006c: call Color UnityEngine.Color::get_yellow()  /*0x0A000181*/
    IL_0071: callvirt void UnityEngine.GUIStyleState::set_textColor(UnityEngine.Color)  /*0x0A000619*/
    IL_0076: ldloc.2
    IL_0077: ldfld string CheatEntry::Name  /*0x04001291*/
    IL_007c: ldloc.3
    IL_007d: ldc.i4.1
    IL_007e: newarr UnityEngine.GUILayoutOption  /*0x01000125*/
    IL_0083: dup
    IL_0084: ldc.i4.0
    IL_0085: ldc.r4 180f
    IL_008a: call GUILayoutOption UnityEngine.GUILayout::Width(float)  /*0x0A000622*/
    IL_008f: stelem.ref
    IL_0090: call void UnityEngine.GUILayout::Label(string,UnityEngine.GUIStyle,UnityEngine.GUILayoutOption[])  /*0x0A00061C*/
    IL_0095: ldloc.2
    IL_0096: ldfld CheatType CheatEntry::Type  /*0x04001292*/
    IL_009b: stloc.s 4
    IL_009d: ldloc.s 4
    IL_009f: ldc.i4.1
    IL_00a0: beq.s IL_00a9
    IL_00a2: ldloc.s 4
    IL_00a4: ldc.i4.2
    IL_00a5: beq.s IL_00d8
    IL_00a7: br.s IL_0101
    IL_00a9: ldloc.2
    IL_00aa: ldfld bool CheatEntry::ToggleValue  /*0x04001294*/
    IL_00af: brtrue.s IL_00b8
    IL_00b1: ldstr "OFF"
    IL_00b6: br.s IL_00bd
    IL_00b8: ldstr "ON"
    IL_00bd: ldloc.3
    IL_00be: ldc.i4.1
    IL_00bf: newarr UnityEngine.GUILayoutOption  /*0x01000125*/
    IL_00c4: dup
    IL_00c5: ldc.i4.0
    IL_00c6: ldc.r4 60f
    IL_00cb: call GUILayoutOption UnityEngine.GUILayout::Width(float)  /*0x0A000622*/
    IL_00d0: stelem.ref
    IL_00d1: call void UnityEngine.GUILayout::Label(string,UnityEngine.GUIStyle,UnityEngine.GUILayoutOption[])  /*0x0A00061C*/
    IL_00d6: br.s IL_0101
    IL_00d8: ldloc.2
    IL_00d9: ldflda float CheatEntry::SliderValue  /*0x04001296*/
    IL_00de: ldstr "0.00"
    IL_00e3: call string System.Single::ToString(string)  /*0x0A000623*/
    IL_00e8: ldloc.3
    IL_00e9: ldc.i4.1
    IL_00ea: newarr UnityEngine.GUILayoutOption  /*0x01000125*/
    IL_00ef: dup
    IL_00f0: ldc.i4.0
    IL_00f1: ldc.r4 60f
    IL_00f6: call GUILayoutOption UnityEngine.GUILayout::Width(float)  /*0x0A000622*/
    IL_00fb: stelem.ref
    IL_00fc: call void UnityEngine.GUILayout::Label(string,UnityEngine.GUIStyle,UnityEngine.GUILayoutOption[])  /*0x0A00061C*/
    IL_0101: call void UnityEngine.GUILayout::EndHorizontal()  /*0x0A000624*/
    IL_0106: ldc.r4 2f
    IL_010b: call void UnityEngine.GUILayout::Space(float)  /*0x0A00061D*/
    IL_0110: ldloc.1
    IL_0111: ldc.i4.1
    IL_0112: add
    IL_0113: stloc.1
    IL_0114: ldloc.1
    IL_0115: ldloc.0
    IL_0116: ldfld List<CheatEntry> CheatCategory::Cheats  /*0x0400128C*/
    IL_011b: callvirt int System.Collections.Generic.List<CheatEntry>::get_Count()  /*0x0A000625*/
    IL_0120: blt IL_002f
    IL_0125: call void UnityEngine.GUILayout::EndScrollView()  /*0x0A000626*/
    IL_012a: ret

  .method CheatMenuIMGUI::HandleInput()  // token 0x06000FCC rva 0x481b0 attrs Private, HideBySig
    // code size 541 (0x21d), max stack 4, init locals
    .locals ([0] CheatCategory, [1] CheatEntry)
    IL_0000: ldarg.0
    IL_0001: ldfld List<CheatCategory> CheatMenuIMGUI::categories  /*0x040012A4*/
    IL_0006: ldarg.0
    IL_0007: ldfld int CheatMenuIMGUI::selectedCategory  /*0x040012A5*/
    IL_000c: callvirt !0 System.Collections.Generic.List<CheatCategory>::get_Item(int)  /*0x0A00061A*/
    IL_0011: stloc.0
    IL_0012: ldarg.0
    IL_0013: ldfld Player CheatMenuIMGUI::player  /*0x040012A3*/
    IL_0018: ldstr "UIUp"
    IL_001d: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0022: brfalse.s IL_0038
    IL_0024: ldarg.0
    IL_0025: ldc.i4.0
    IL_0026: ldarg.0
    IL_0027: ldfld int CheatMenuIMGUI::selectedCheat  /*0x040012A6*/
    IL_002c: ldc.i4.1
    IL_002d: sub
    IL_002e: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_0033: stfld int CheatMenuIMGUI::selectedCheat  /*0x040012A6*/
    IL_0038: ldarg.0
    IL_0039: ldfld Player CheatMenuIMGUI::player  /*0x040012A3*/
    IL_003e: ldstr "UIDown"
    IL_0043: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0048: brfalse.s IL_006a
    IL_004a: ldarg.0
    IL_004b: ldloc.0
    IL_004c: ldfld List<CheatEntry> CheatCategory::Cheats  /*0x0400128C*/
    IL_0051: callvirt int System.Collections.Generic.List<CheatEntry>::get_Count()  /*0x0A000625*/
    IL_0056: ldc.i4.1
    IL_0057: sub
    IL_0058: ldarg.0
    IL_0059: ldfld int CheatMenuIMGUI::selectedCheat  /*0x040012A6*/
    IL_005e: ldc.i4.1
    IL_005f: add
    IL_0060: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_0065: stfld int CheatMenuIMGUI::selectedCheat  /*0x040012A6*/
    IL_006a: ldarg.0
    IL_006b: ldfld Player CheatMenuIMGUI::player  /*0x040012A3*/
    IL_0070: ldstr "PrevCategory"
    IL_0075: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_007a: brfalse.s IL_00b4
    IL_007c: ldarg.0
    IL_007d: ldarg.0
    IL_007e: ldfld int CheatMenuIMGUI::selectedCategory  /*0x040012A5*/
    IL_0083: ldc.i4.1
    IL_0084: sub
    IL_0085: ldarg.0
    IL_0086: ldfld List<CheatCategory> CheatMenuIMGUI::categories  /*0x040012A4*/
    IL_008b: callvirt int System.Collections.Generic.List<CheatCategory>::get_Count()  /*0x0A00060F*/
    IL_0090: add
    IL_0091: ldarg.0
    IL_0092: ldfld List<CheatCategory> CheatMenuIMGUI::categories  /*0x040012A4*/
    IL_0097: callvirt int System.Collections.Generic.List<CheatCategory>::get_Count()  /*0x0A00060F*/
    IL_009c: rem
    IL_009d: stfld int CheatMenuIMGUI::selectedCategory  /*0x040012A5*/
    IL_00a2: ldarg.0
    IL_00a3: ldc.i4.0
    IL_00a4: stfld int CheatMenuIMGUI::selectedCheat  /*0x040012A6*/
    IL_00a9: ldarg.0
    IL_00aa: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0004B6*/
    IL_00af: stfld Vector2 CheatMenuIMGUI::scrollPos  /*0x040012A7*/
    IL_00b4: ldarg.0
    IL_00b5: ldfld Player CheatMenuIMGUI::player  /*0x040012A3*/
    IL_00ba: ldstr "NextCategory"
    IL_00bf: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_00c4: brfalse.s IL_00f2
    IL_00c6: ldarg.0
    IL_00c7: ldarg.0
    IL_00c8: ldfld int CheatMenuIMGUI::selectedCategory  /*0x040012A5*/
    IL_00cd: ldc.i4.1
    IL_00ce: add
    IL_00cf: ldarg.0
    IL_00d0: ldfld List<CheatCategory> CheatMenuIMGUI::categories  /*0x040012A4*/
    IL_00d5: callvirt int System.Collections.Generic.List<CheatCategory>::get_Count()  /*0x0A00060F*/
    IL_00da: rem
    IL_00db: stfld int CheatMenuIMGUI::selectedCategory  /*0x040012A5*/
    IL_00e0: ldarg.0
    IL_00e1: ldc.i4.0
    IL_00e2: stfld int CheatMenuIMGUI::selectedCheat  /*0x040012A6*/
    IL_00e7: ldarg.0
    IL_00e8: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0004B6*/
    IL_00ed: stfld Vector2 CheatMenuIMGUI::scrollPos  /*0x040012A7*/
    IL_00f2: ldloc.0
    IL_00f3: ldfld List<CheatEntry> CheatCategory::Cheats  /*0x0400128C*/
    IL_00f8: ldarg.0
    IL_00f9: ldfld int CheatMenuIMGUI::selectedCheat  /*0x040012A6*/
    IL_00fe: callvirt !0 System.Collections.Generic.List<CheatEntry>::get_Item(int)  /*0x0A000620*/
    IL_0103: stloc.1
    IL_0104: ldarg.0
    IL_0105: ldfld Player CheatMenuIMGUI::player  /*0x040012A3*/
    IL_010a: ldstr "UISubmit"
    IL_010f: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0114: brfalse.s IL_015e
    IL_0116: ldloc.1
    IL_0117: ldfld CheatType CheatEntry::Type  /*0x04001292*/
    IL_011c: brtrue.s IL_012f
    IL_011e: ldloc.1
    IL_011f: ldfld Action CheatEntry::OnActivate  /*0x04001293*/
    IL_0124: dup
    IL_0125: brtrue.s IL_012a
    IL_0127: pop
    IL_0128: br.s IL_012f
    IL_012a: callvirt void System.Action::Invoke()  /*0x0A00037F*/
    IL_012f: ldloc.1
    IL_0130: ldfld CheatType CheatEntry::Type  /*0x04001292*/
    IL_0135: ldc.i4.1
    IL_0136: bne.un.s IL_015e
    IL_0138: ldloc.1
    IL_0139: ldloc.1
    IL_013a: ldfld bool CheatEntry::ToggleValue  /*0x04001294*/
    IL_013f: ldc.i4.0
    IL_0140: ceq
    IL_0142: stfld bool CheatEntry::ToggleValue  /*0x04001294*/
    IL_0147: ldloc.1
    IL_0148: ldfld Action<bool> CheatEntry::OnToggleChanged  /*0x04001295*/
    IL_014d: dup
    IL_014e: brtrue.s IL_0153
    IL_0150: pop
    IL_0151: br.s IL_015e
    IL_0153: ldloc.1
    IL_0154: ldfld bool CheatEntry::ToggleValue  /*0x04001294*/
    IL_0159: callvirt void System.Action<bool>::Invoke(!0)  /*0x0A000627*/
    IL_015e: ldloc.1
    IL_015f: ldfld CheatType CheatEntry::Type  /*0x04001292*/
    IL_0164: ldc.i4.2
    IL_0165: bne.un IL_0204
    IL_016a: ldarg.0
    IL_016b: ldfld Player CheatMenuIMGUI::player  /*0x040012A3*/
    IL_0170: ldstr "UILeft"
    IL_0175: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_017a: brfalse.s IL_01b7
    IL_017c: ldloc.1
    IL_017d: ldloc.1
    IL_017e: ldfld float CheatEntry::SliderValue  /*0x04001296*/
    IL_0183: ldloc.1
    IL_0184: ldfld float CheatEntry::SliderStep  /*0x04001299*/
    IL_0189: sub
    IL_018a: ldloc.1
    IL_018b: ldfld float CheatEntry::SliderMin  /*0x04001297*/
    IL_0190: ldloc.1
    IL_0191: ldfld float CheatEntry::SliderMax  /*0x04001298*/
    IL_0196: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_019b: stfld float CheatEntry::SliderValue  /*0x04001296*/
    IL_01a0: ldloc.1
    IL_01a1: ldfld Action<float> CheatEntry::OnSliderChanged  /*0x0400129A*/
    IL_01a6: dup
    IL_01a7: brtrue.s IL_01ac
    IL_01a9: pop
    IL_01aa: br.s IL_01b7
    IL_01ac: ldloc.1
    IL_01ad: ldfld float CheatEntry::SliderValue  /*0x04001296*/
    IL_01b2: callvirt void System.Action<float>::Invoke(!0)  /*0x0A000628*/
    IL_01b7: ldarg.0
    IL_01b8: ldfld Player CheatMenuIMGUI::player  /*0x040012A3*/
    IL_01bd: ldstr "UIRight"
    IL_01c2: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_01c7: brfalse.s IL_0204
    IL_01c9: ldloc.1
    IL_01ca: ldloc.1
    IL_01cb: ldfld float CheatEntry::SliderValue  /*0x04001296*/
    IL_01d0: ldloc.1
    IL_01d1: ldfld float CheatEntry::SliderStep  /*0x04001299*/
    IL_01d6: add
    IL_01d7: ldloc.1
    IL_01d8: ldfld float CheatEntry::SliderMin  /*0x04001297*/
    IL_01dd: ldloc.1
    IL_01de: ldfld float CheatEntry::SliderMax  /*0x04001298*/
    IL_01e3: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_01e8: stfld float CheatEntry::SliderValue  /*0x04001296*/
    IL_01ed: ldloc.1
    IL_01ee: ldfld Action<float> CheatEntry::OnSliderChanged  /*0x0400129A*/
    IL_01f3: dup
    IL_01f4: brtrue.s IL_01f9
    IL_01f6: pop
    IL_01f7: br.s IL_0204
    IL_01f9: ldloc.1
    IL_01fa: ldfld float CheatEntry::SliderValue  /*0x04001296*/
    IL_01ff: callvirt void System.Action<float>::Invoke(!0)  /*0x0A000628*/
    IL_0204: ldarg.0
    IL_0205: ldfld Player CheatMenuIMGUI::player  /*0x040012A3*/
    IL_020a: ldstr "UICancel"
    IL_020f: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0214: brfalse.s IL_021c
    IL_0216: ldarg.0
    IL_0217: call void CheatMenuIMGUI::Close()  /*0x06000FCE*/
    IL_021c: ret

  .method CheatMenuIMGUI::Open()  // token 0x06000FCD rva 0x483dc attrs Public, HideBySig
    // code size 149 (0x95), max stack 3, init locals
    .locals ([0] IEnumerator<ControllerMap>, [1] ControllerMap)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool CheatMenuIMGUI::visible  /*0x040012A2*/
    IL_0007: ldarg.0
    IL_0008: ldfld Dictionary<int, bool> CheatMenuIMGUI::previousMapStates  /*0x040012A8*/
    IL_000d: callvirt void System.Collections.Generic.Dictionary<int, bool>::Clear()  /*0x0A000629*/
    IL_0012: ldarg.0
    IL_0013: ldfld Player CheatMenuIMGUI::player  /*0x040012A3*/
    IL_0018: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_001d: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_0022: callvirt IEnumerable<ControllerMap> Rewired.Player.ControllerHelper.MapHelper::GetAllMaps()  /*0x0A0003E5*/
    IL_0027: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<Rewired.ControllerMap>::GetEnumerator()  /*0x0A00062A*/
    IL_002c: stloc.0
    IL_002d: br.s IL_004d
    IL_002f: ldloc.0
    IL_0030: callvirt !0 System.Collections.Generic.IEnumerator<Rewired.ControllerMap>::get_Current()  /*0x0A00062B*/
    IL_0035: stloc.1
    IL_0036: ldarg.0
    IL_0037: ldfld Dictionary<int, bool> CheatMenuIMGUI::previousMapStates  /*0x040012A8*/
    IL_003c: ldloc.1
    IL_003d: callvirt int Rewired.ControllerMap::get_categoryId()  /*0x0A0003F5*/
    IL_0042: ldloc.1
    IL_0043: callvirt bool Rewired.ControllerMap::get_enabled()  /*0x0A00062C*/
    IL_0048: callvirt void System.Collections.Generic.Dictionary<int, bool>::set_Item(!0,!1)  /*0x0A00062D*/
    IL_004d: ldloc.0
    IL_004e: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0053: brtrue.s IL_002f
    IL_0055: leave.s IL_0061
    IL_0057: ldloc.0
    IL_0058: brfalse.s IL_0060
    IL_005a: ldloc.0
    IL_005b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0060: endfinally
    IL_0061: ldarg.0
    IL_0062: ldfld Player CheatMenuIMGUI::player  /*0x040012A3*/
    IL_0067: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_006c: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_0071: ldc.i4.0
    IL_0072: callvirt int Rewired.Player.ControllerHelper.MapHelper::SetAllMapsEnabled(bool)  /*0x0A00062E*/
    IL_0077: pop
    IL_0078: ldarg.0
    IL_0079: ldfld Player CheatMenuIMGUI::player  /*0x040012A3*/
    IL_007e: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0083: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_0088: ldc.i4.1
    IL_0089: ldstr "CheatMenu"
    IL_008e: callvirt int Rewired.Player.ControllerHelper.MapHelper::SetMapsEnabled(bool,string)  /*0x0A00062F*/
    IL_0093: pop
    IL_0094: ret
    .try IL_002d-IL_0057 finally handler IL_0057-IL_0061

  .method CheatMenuIMGUI::Close()  // token 0x06000FCE rva 0x48490 attrs Public, HideBySig
    // code size 142 (0x8e), max stack 3, init locals
    .locals ([0] Dictionary.Enumerator<int, bool>, [1] KeyValuePair<int, bool>)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool CheatMenuIMGUI::visible  /*0x040012A2*/
    IL_0007: ldarg.0
    IL_0008: ldfld Player CheatMenuIMGUI::player  /*0x040012A3*/
    IL_000d: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0012: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_0017: ldc.i4.0
    IL_0018: callvirt int Rewired.Player.ControllerHelper.MapHelper::SetAllMapsEnabled(bool)  /*0x0A00062E*/
    IL_001d: pop
    IL_001e: ldarg.0
    IL_001f: ldfld Dictionary<int, bool> CheatMenuIMGUI::previousMapStates  /*0x040012A8*/
    IL_0024: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<int, bool>::GetEnumerator()  /*0x0A000630*/
    IL_0029: stloc.0
    IL_002a: br.s IL_0058
    IL_002c: ldloca.s 0
    IL_002e: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<int, bool>::get_Current()  /*0x0A000631*/
    IL_0033: stloc.1
    IL_0034: ldarg.0
    IL_0035: ldfld Player CheatMenuIMGUI::player  /*0x040012A3*/
    IL_003a: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_003f: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_0044: ldloca.s 1
    IL_0046: call !1 System.Collections.Generic.KeyValuePair<int, bool>::get_Value()  /*0x0A000632*/
    IL_004b: ldloca.s 1
    IL_004d: call !0 System.Collections.Generic.KeyValuePair<int, bool>::get_Key()  /*0x0A000633*/
    IL_0052: callvirt int Rewired.Player.ControllerHelper.MapHelper::SetMapsEnabled(bool,int)  /*0x0A000634*/
    IL_0057: pop
    IL_0058: ldloca.s 0
    IL_005a: call bool System.Collections.Generic.Dictionary.Enumerator<int, bool>::MoveNext()  /*0x0A000635*/
    IL_005f: brtrue.s IL_002c
    IL_0061: leave.s IL_0071
    IL_0063: ldloca.s 0
    IL_0065: constrained. System.Collections.Generic.Dictionary.Enumerator<int, bool>  /*0x1B00011C*/
    IL_006b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0070: endfinally
    IL_0071: ldarg.0
    IL_0072: ldfld Player CheatMenuIMGUI::player  /*0x040012A3*/
    IL_0077: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_007c: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_0081: ldc.i4.0
    IL_0082: ldstr "CheatMenu"
    IL_0087: callvirt int Rewired.Player.ControllerHelper.MapHelper::SetMapsEnabled(bool,string)  /*0x0A00062F*/
    IL_008c: pop
    IL_008d: ret
    .try IL_002a-IL_0063 finally handler IL_0063-IL_0071

  .method CheatMenuIMGUI::.ctor()  // token 0x06000FCF rva 0x4853c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.Dictionary<int, bool>::.ctor()  /*0x0A000636*/
    IL_0006: stfld Dictionary<int, bool> CheatMenuIMGUI::previousMapStates  /*0x040012A8*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

