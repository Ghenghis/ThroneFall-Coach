// ===== InputActionGlyph  (token 0x02000317) =====
  .method InputActionGlyph::.cctor()  // token 0x06001100 rva 0x4ebe4 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 114 (0x72), max stack 4, init locals
    IL_0000: ldc.i4.4
    IL_0001: newarr System.String  /*0x0100001D*/
    IL_0006: dup
    IL_0007: ldc.i4.0
    IL_0008: ldstr "c3ad3cad-c7cf-4ca8-8c2e-e3df8d9960bb"
    IL_000d: stelem.ref
    IL_000e: dup
    IL_000f: ldc.i4.1
    IL_0010: ldstr "71dfe6c8-9e81-428f-a58e-c7e664b7fbed"
    IL_0015: stelem.ref
    IL_0016: dup
    IL_0017: ldc.i4.2
    IL_0018: ldstr "cd9718bf-a87a-44bc-8716-60a0def28a9f"
    IL_001d: stelem.ref
    IL_001e: dup
    IL_001f: ldc.i4.3
    IL_0020: ldstr "5286706d-19b4-4a45-b635-207ce78d8394"
    IL_0025: stelem.ref
    IL_0026: stsfld string[] InputActionGlyph::playstation_controllers  /*0x0400143F*/
    IL_002b: ldc.i4.2
    IL_002c: newarr System.String  /*0x0100001D*/
    IL_0031: dup
    IL_0032: ldc.i4.0
    IL_0033: ldstr "d74a350e-fe8b-4e9e-bbcd-efff16d34115"
    IL_0038: stelem.ref
    IL_0039: dup
    IL_003a: ldc.i4.1
    IL_003b: ldstr "19002688-7406-4f4a-8340-8d25335406c8"
    IL_0040: stelem.ref
    IL_0041: stsfld string[] InputActionGlyph::xbox_controllers  /*0x04001440*/
    IL_0046: ldc.i4.2
    IL_0047: newarr System.String  /*0x0100001D*/
    IL_004c: dup
    IL_004d: ldc.i4.0
    IL_004e: ldstr "521b808c-0248-4526-bc10-f1d16ee76bf1"
    IL_0053: stelem.ref
    IL_0054: dup
    IL_0055: ldc.i4.1
    IL_0056: ldstr "1fbdd13b-0795-4173-8a95-a2a75de9d204"
    IL_005b: stelem.ref
    IL_005c: stsfld string[] InputActionGlyph::switch_controllers  /*0x04001441*/
    IL_0061: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0066: ldc.i4.0
    IL_0067: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_006c: stsfld Player InputActionGlyph::player  /*0x04001444*/
    IL_0071: ret

  .method InputActionGlyph::GetActionGlyph(string,InputActionGlyph.InputPriority,bool)  // token 0x06001101 rva 0x4ec64 attrs Public, Static, HideBySig
    // code size 648 (0x288), max stack 4, init locals
    .locals ([0] string, [1] InputAction, [2] List<ActionElementMap>, [3] List<ActionElementMap>, [4] int, [5] ActionElementMap, [6] ActionElementMap, [7] List.Enumerator<ActionElementMap>, [8] ActionElementMap, [9] ActionElementMap)
    IL_0000: ldstr ""
    IL_0005: stloc.0
    IL_0006: call ReInput.MappingHelper Rewired.ReInput::get_mapping()  /*0x0A0003F0*/
    IL_000b: ldarg.0
    IL_000c: callvirt InputAction Rewired.ReInput.MappingHelper::GetAction(string)  /*0x0A00067E*/
    IL_0011: stloc.1
    IL_0012: newobj void System.Collections.Generic.List<Rewired.ActionElementMap>::.ctor()  /*0x0A00064F*/
    IL_0017: stloc.2
    IL_0018: ldsfld Player InputActionGlyph::player  /*0x04001444*/
    IL_001d: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0022: ldfld Player.ControllerHelper.MapHelper Rewired.Player.ControllerHelper::maps  /*0x0A0003E4*/
    IL_0027: ldloc.1
    IL_0028: callvirt int Rewired.InputAction::get_id()  /*0x0A0003F3*/
    IL_002d: ldc.i4.1
    IL_002e: ldloc.2
    IL_002f: callvirt int Rewired.Player.ControllerHelper.MapHelper::GetElementMapsWithAction(int,bool,System.Collections.Generic.List<Rewired.ActionElementMap>)  /*0x0A00067F*/
    IL_0034: pop
    IL_0035: newobj void System.Collections.Generic.List<Rewired.ActionElementMap>::.ctor()  /*0x0A00064F*/
    IL_003a: stloc.3
    IL_003b: ldloc.2
    IL_003c: callvirt int System.Collections.Generic.List<Rewired.ActionElementMap>::get_Count()  /*0x0A000652*/
    IL_0041: ldc.i4.1
    IL_0042: sub
    IL_0043: stloc.s 4
    IL_0045: br.s IL_0090
    IL_0047: call ReInput.MappingHelper Rewired.ReInput::get_mapping()  /*0x0A0003F0*/
    IL_004c: ldloc.2
    IL_004d: ldloc.s 4
    IL_004f: callvirt !0 System.Collections.Generic.List<Rewired.ActionElementMap>::get_Item(int)  /*0x0A000653*/
    IL_0054: callvirt ControllerMap Rewired.ActionElementMap::get_controllerMap()  /*0x0A000680*/
    IL_0059: callvirt int Rewired.ControllerMap::get_categoryId()  /*0x0A0003F5*/
    IL_005e: callvirt InputMapCategory Rewired.ReInput.MappingHelper::GetMapCategory(int)  /*0x0A000681*/
    IL_0063: callvirt string Rewired.InputCategory::get_name()  /*0x0A000682*/
    IL_0068: ldstr "No Glyphs"
    IL_006d: callvirt bool System.String::Contains(string)  /*0x0A000055*/
    IL_0072: brfalse.s IL_008a
    IL_0074: ldloc.3
    IL_0075: ldloc.2
    IL_0076: ldloc.s 4
    IL_0078: callvirt !0 System.Collections.Generic.List<Rewired.ActionElementMap>::get_Item(int)  /*0x0A000653*/
    IL_007d: callvirt void System.Collections.Generic.List<Rewired.ActionElementMap>::Add(!0)  /*0x0A000683*/
    IL_0082: ldloc.2
    IL_0083: ldloc.s 4
    IL_0085: callvirt void System.Collections.Generic.List<Rewired.ActionElementMap>::RemoveAt(int)  /*0x0A000654*/
    IL_008a: ldloc.s 4
    IL_008c: ldc.i4.1
    IL_008d: sub
    IL_008e: stloc.s 4
    IL_0090: ldloc.s 4
    IL_0092: ldc.i4.0
    IL_0093: bge.s IL_0047
    IL_0095: ldarg.1
    IL_0096: ldc.i4.1
    IL_0097: bne.un.s IL_00f1
    IL_0099: ldloc.2
    IL_009a: ldsfld Func<ActionElementMap, bool> InputActionGlyph.<>c::<>9__10_0  /*0x04001449*/
    IL_009f: dup
    IL_00a0: brtrue.s IL_00b9
    IL_00a2: pop
    IL_00a3: ldsfld InputActionGlyph.<>c InputActionGlyph.<>c::<>9  /*0x04001448*/
    IL_00a8: ldftn bool InputActionGlyph.<>c::<GetActionGlyph>b__10_0(Rewired.ActionElementMap)  /*0x06001106*/
    IL_00ae: newobj void System.Func<Rewired.ActionElementMap, bool>::.ctor(object,IntPtr)  /*0x0A000684*/
    IL_00b3: dup
    IL_00b4: stsfld Func<ActionElementMap, bool> InputActionGlyph.<>c::<>9__10_0  /*0x04001449*/
    IL_00b9: call IOrderedEnumerable<!!0> System.Linq.Enumerable::OrderBy(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, !!1>)<Rewired.ActionElementMap,bool>  /*0x2B0000F2*/
    IL_00be: call List<!!0> System.Linq.Enumerable::ToList(System.Collections.Generic.IEnumerable<!!0>)<Rewired.ActionElementMap>  /*0x2B0000F3*/
    IL_00c3: stloc.2
    IL_00c4: ldloc.3
    IL_00c5: ldsfld Func<ActionElementMap, bool> InputActionGlyph.<>c::<>9__10_1  /*0x0400144A*/
    IL_00ca: dup
    IL_00cb: brtrue.s IL_00e4
    IL_00cd: pop
    IL_00ce: ldsfld InputActionGlyph.<>c InputActionGlyph.<>c::<>9  /*0x04001448*/
    IL_00d3: ldftn bool InputActionGlyph.<>c::<GetActionGlyph>b__10_1(Rewired.ActionElementMap)  /*0x06001107*/
    IL_00d9: newobj void System.Func<Rewired.ActionElementMap, bool>::.ctor(object,IntPtr)  /*0x0A000684*/
    IL_00de: dup
    IL_00df: stsfld Func<ActionElementMap, bool> InputActionGlyph.<>c::<>9__10_1  /*0x0400144A*/
    IL_00e4: call IOrderedEnumerable<!!0> System.Linq.Enumerable::OrderBy(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, !!1>)<Rewired.ActionElementMap,bool>  /*0x2B0000F2*/
    IL_00e9: call List<!!0> System.Linq.Enumerable::ToList(System.Collections.Generic.IEnumerable<!!0>)<Rewired.ActionElementMap>  /*0x2B0000F3*/
    IL_00ee: stloc.3
    IL_00ef: br.s IL_014a
    IL_00f1: ldarg.1
    IL_00f2: brtrue.s IL_014a
    IL_00f4: ldloc.2
    IL_00f5: ldsfld Func<ActionElementMap, bool> InputActionGlyph.<>c::<>9__10_2  /*0x0400144B*/
    IL_00fa: dup
    IL_00fb: brtrue.s IL_0114
    IL_00fd: pop
    IL_00fe: ldsfld InputActionGlyph.<>c InputActionGlyph.<>c::<>9  /*0x04001448*/
    IL_0103: ldftn bool InputActionGlyph.<>c::<GetActionGlyph>b__10_2(Rewired.ActionElementMap)  /*0x06001108*/
    IL_0109: newobj void System.Func<Rewired.ActionElementMap, bool>::.ctor(object,IntPtr)  /*0x0A000684*/
    IL_010e: dup
    IL_010f: stsfld Func<ActionElementMap, bool> InputActionGlyph.<>c::<>9__10_2  /*0x0400144B*/
    IL_0114: call IOrderedEnumerable<!!0> System.Linq.Enumerable::OrderBy(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, !!1>)<Rewired.ActionElementMap,bool>  /*0x2B0000F2*/
    IL_0119: call List<!!0> System.Linq.Enumerable::ToList(System.Collections.Generic.IEnumerable<!!0>)<Rewired.ActionElementMap>  /*0x2B0000F3*/
    IL_011e: stloc.2
    IL_011f: ldloc.3
    IL_0120: ldsfld Func<ActionElementMap, bool> InputActionGlyph.<>c::<>9__10_3  /*0x0400144C*/
    IL_0125: dup
    IL_0126: brtrue.s IL_013f
    IL_0128: pop
    IL_0129: ldsfld InputActionGlyph.<>c InputActionGlyph.<>c::<>9  /*0x04001448*/
    IL_012e: ldftn bool InputActionGlyph.<>c::<GetActionGlyph>b__10_3(Rewired.ActionElementMap)  /*0x06001109*/
    IL_0134: newobj void System.Func<Rewired.ActionElementMap, bool>::.ctor(object,IntPtr)  /*0x0A000684*/
    IL_0139: dup
    IL_013a: stsfld Func<ActionElementMap, bool> InputActionGlyph.<>c::<>9__10_3  /*0x0400144C*/
    IL_013f: call IOrderedEnumerable<!!0> System.Linq.Enumerable::OrderBy(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, !!1>)<Rewired.ActionElementMap,bool>  /*0x2B0000F2*/
    IL_0144: call List<!!0> System.Linq.Enumerable::ToList(System.Collections.Generic.IEnumerable<!!0>)<Rewired.ActionElementMap>  /*0x2B0000F3*/
    IL_0149: stloc.3
    IL_014a: ldloc.1
    IL_014b: callvirt InputActionType Rewired.InputAction::get_type()  /*0x0A000685*/
    IL_0150: brtrue IL_0256
    IL_0155: ldnull
    IL_0156: stloc.s 5
    IL_0158: ldnull
    IL_0159: stloc.s 6
    IL_015b: ldloc.2
    IL_015c: callvirt List.Enumerator<!0> System.Collections.Generic.List<Rewired.ActionElementMap>::GetEnumerator()  /*0x0A000686*/
    IL_0161: stloc.s 7
    IL_0163: br.s IL_019d
    IL_0165: ldloca.s 7
    IL_0167: call !0 System.Collections.Generic.List.Enumerator<Rewired.ActionElementMap>::get_Current()  /*0x0A000687*/
    IL_016c: stloc.s 8
    IL_016e: ldloc.s 8
    IL_0170: callvirt Pole Rewired.ActionElementMap::get_axisContribution()  /*0x0A000403*/
    IL_0175: brtrue.s IL_0181
    IL_0177: ldloc.s 5
    IL_0179: brtrue.s IL_0181
    IL_017b: ldloc.s 8
    IL_017d: stloc.s 5
    IL_017f: br.s IL_0193
    IL_0181: ldloc.s 8
    IL_0183: callvirt Pole Rewired.ActionElementMap::get_axisContribution()  /*0x0A000403*/
    IL_0188: ldc.i4.1
    IL_0189: bne.un.s IL_0193
    IL_018b: ldloc.s 6
    IL_018d: brtrue.s IL_0193
    IL_018f: ldloc.s 8
    IL_0191: stloc.s 6
    IL_0193: ldloc.s 5
    IL_0195: brfalse.s IL_019d
    IL_0197: ldloc.s 6
    IL_0199: brfalse.s IL_019d
    IL_019b: leave.s IL_01b6
    IL_019d: ldloca.s 7
    IL_019f: call bool System.Collections.Generic.List.Enumerator<Rewired.ActionElementMap>::MoveNext()  /*0x0A000688*/
    IL_01a4: brtrue.s IL_0165
    IL_01a6: leave.s IL_01b6
    IL_01a8: ldloca.s 7
    IL_01aa: constrained. System.Collections.Generic.List.Enumerator<Rewired.ActionElementMap>  /*0x1B00012D*/
    IL_01b0: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01b5: endfinally
    IL_01b6: ldloc.s 6
    IL_01b8: brfalse.s IL_01be
    IL_01ba: ldloc.s 5
    IL_01bc: brtrue.s IL_0219
    IL_01be: ldloc.3
    IL_01bf: callvirt List.Enumerator<!0> System.Collections.Generic.List<Rewired.ActionElementMap>::GetEnumerator()  /*0x0A000686*/
    IL_01c4: stloc.s 7
    IL_01c6: br.s IL_0200
    IL_01c8: ldloca.s 7
    IL_01ca: call !0 System.Collections.Generic.List.Enumerator<Rewired.ActionElementMap>::get_Current()  /*0x0A000687*/
    IL_01cf: stloc.s 9
    IL_01d1: ldloc.s 9
    IL_01d3: callvirt Pole Rewired.ActionElementMap::get_axisContribution()  /*0x0A000403*/
    IL_01d8: brtrue.s IL_01e4
    IL_01da: ldloc.s 5
    IL_01dc: brtrue.s IL_01e4
    IL_01de: ldloc.s 9
    IL_01e0: stloc.s 5
    IL_01e2: br.s IL_01f6
    IL_01e4: ldloc.s 9
    IL_01e6: callvirt Pole Rewired.ActionElementMap::get_axisContribution()  /*0x0A000403*/
    IL_01eb: ldc.i4.1
    IL_01ec: bne.un.s IL_01f6
    IL_01ee: ldloc.s 6
    IL_01f0: brtrue.s IL_01f6
    IL_01f2: ldloc.s 9
    IL_01f4: stloc.s 6
    IL_01f6: ldloc.s 5
    IL_01f8: brfalse.s IL_0200
    IL_01fa: ldloc.s 6
    IL_01fc: brfalse.s IL_0200
    IL_01fe: leave.s IL_0219
    IL_0200: ldloca.s 7
    IL_0202: call bool System.Collections.Generic.List.Enumerator<Rewired.ActionElementMap>::MoveNext()  /*0x0A000688*/
    IL_0207: brtrue.s IL_01c8
    IL_0209: leave.s IL_0219
    IL_020b: ldloca.s 7
    IL_020d: constrained. System.Collections.Generic.List.Enumerator<Rewired.ActionElementMap>  /*0x1B00012D*/
    IL_0213: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0218: endfinally
    IL_0219: ldloc.s 6
    IL_021b: brfalse.s IL_022c
    IL_021d: ldloc.0
    IL_021e: ldloc.s 6
    IL_0220: ldc.i4.1
    IL_0221: call string InputActionGlyph::GetGlyphFromElementMap(Rewired.ActionElementMap,bool)  /*0x06001102*/
    IL_0226: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_022b: stloc.0
    IL_022c: ldloc.s 5
    IL_022e: brfalse.s IL_0286
    IL_0230: ldloc.0
    IL_0231: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_0236: ldc.i4.0
    IL_0237: ble.s IL_0245
    IL_0239: ldloc.0
    IL_023a: ldstr " <color=#FFE7C4>/</color> "
    IL_023f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0244: stloc.0
    IL_0245: ldloc.0
    IL_0246: ldloc.s 5
    IL_0248: ldc.i4.1
    IL_0249: call string InputActionGlyph::GetGlyphFromElementMap(Rewired.ActionElementMap,bool)  /*0x06001102*/
    IL_024e: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0253: stloc.0
    IL_0254: br.s IL_0286
    IL_0256: ldloc.2
    IL_0257: callvirt int System.Collections.Generic.List<Rewired.ActionElementMap>::get_Count()  /*0x0A000652*/
    IL_025c: ldc.i4.0
    IL_025d: ble.s IL_026f
    IL_025f: ldloc.2
    IL_0260: ldc.i4.0
    IL_0261: callvirt !0 System.Collections.Generic.List<Rewired.ActionElementMap>::get_Item(int)  /*0x0A000653*/
    IL_0266: ldc.i4.1
    IL_0267: call string InputActionGlyph::GetGlyphFromElementMap(Rewired.ActionElementMap,bool)  /*0x06001102*/
    IL_026c: stloc.0
    IL_026d: br.s IL_0286
    IL_026f: ldloc.3
    IL_0270: callvirt int System.Collections.Generic.List<Rewired.ActionElementMap>::get_Count()  /*0x0A000652*/
    IL_0275: ldc.i4.0
    IL_0276: ble.s IL_0286
    IL_0278: ldloc.3
    IL_0279: ldc.i4.0
    IL_027a: callvirt !0 System.Collections.Generic.List<Rewired.ActionElementMap>::get_Item(int)  /*0x0A000653*/
    IL_027f: ldc.i4.1
    IL_0280: call string InputActionGlyph::GetGlyphFromElementMap(Rewired.ActionElementMap,bool)  /*0x06001102*/
    IL_0285: stloc.0
    IL_0286: ldloc.0
    IL_0287: ret
    .try IL_0163-IL_01a8 finally handler IL_01a8-IL_01b6
    .try IL_01c6-IL_020b finally handler IL_020b-IL_0219

  .method InputActionGlyph::GetGlyphFromElementMap(Rewired.ActionElementMap,bool)  // token 0x06001102 rva 0x4ef14 attrs Public, Static, HideBySig
    // code size 1035 (0x40b), max stack 4, init locals
    .locals ([0] string, [1] TMP_SpriteAsset, [2] string, [3] string, [4] string, [5] string, [6] ControllerType, [7] Guid, [8] string, [9] int)
    IL_0000: ldarg.1
    IL_0001: brtrue.s IL_000a
    IL_0003: ldstr "C8A674"
    IL_0008: br.s IL_000f
    IL_000a: ldstr "FFE7C4"
    IL_000f: stloc.2
    IL_0010: call ReInput.MappingHelper Rewired.ReInput::get_mapping()  /*0x0A0003F0*/
    IL_0015: ldarg.0
    IL_0016: callvirt int Rewired.ActionElementMap::get_actionId()  /*0x0A0003FB*/
    IL_001b: callvirt InputAction Rewired.ReInput.MappingHelper::GetAction(int)  /*0x0A000689*/
    IL_0020: pop
    IL_0021: ldarg.0
    IL_0022: callvirt ControllerMap Rewired.ActionElementMap::get_controllerMap()  /*0x0A000680*/
    IL_0027: callvirt ControllerType Rewired.ControllerMap::get_controllerType()  /*0x0A0003FD*/
    IL_002c: stloc.s 6
    IL_002e: ldloc.s 6
    IL_0030: switch (IL_0046, IL_00df, IL_0201)
    IL_0041: br IL_0405
    IL_0046: ldstr "keyboard_glyphs"
    IL_004b: stloc.0
    IL_004c: ldstr "Sprite Assets/"
    IL_0051: ldloc.0
    IL_0052: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0057: call !!0 UnityEngine.Resources::Load(string)<TMPro.TMP_SpriteAsset>  /*0x2B0000F4*/
    IL_005c: stloc.1
    IL_005d: ldloc.1
    IL_005e: ldarg.0
    IL_005f: callvirt string Rewired.ActionElementMap::get_elementIdentifierName()  /*0x0A00068A*/
    IL_0064: callvirt int TMPro.TMP_SpriteAsset::GetSpriteIndexFromName(string)  /*0x0A00068B*/
    IL_0069: ldc.i4.0
    IL_006a: bge.s IL_009d
    IL_006c: ldc.i4.5
    IL_006d: newarr System.String  /*0x0100001D*/
    IL_0072: dup
    IL_0073: ldc.i4.0
    IL_0074: ldstr "<color=#"
    IL_0079: stelem.ref
    IL_007a: dup
    IL_007b: ldc.i4.1
    IL_007c: ldloc.2
    IL_007d: stelem.ref
    IL_007e: dup
    IL_007f: ldc.i4.2
    IL_0080: ldstr ">"
    IL_0085: stelem.ref
    IL_0086: dup
    IL_0087: ldc.i4.3
    IL_0088: ldarg.0
    IL_0089: callvirt string Rewired.ActionElementMap::get_elementIdentifierName()  /*0x0A00068A*/
    IL_008e: stelem.ref
    IL_008f: dup
    IL_0090: ldc.i4.4
    IL_0091: ldstr "</color>"
    IL_0096: stelem.ref
    IL_0097: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_009c: ret
    IL_009d: ldc.i4.7
    IL_009e: newarr System.String  /*0x0100001D*/
    IL_00a3: dup
    IL_00a4: ldc.i4.0
    IL_00a5: ldstr "<sprite=\""
    IL_00aa: stelem.ref
    IL_00ab: dup
    IL_00ac: ldc.i4.1
    IL_00ad: ldloc.0
    IL_00ae: stelem.ref
    IL_00af: dup
    IL_00b0: ldc.i4.2
    IL_00b1: ldstr "\" name=\""
    IL_00b6: stelem.ref
    IL_00b7: dup
    IL_00b8: ldc.i4.3
    IL_00b9: ldarg.0
    IL_00ba: callvirt string Rewired.ActionElementMap::get_elementIdentifierName()  /*0x0A00068A*/
    IL_00bf: stelem.ref
    IL_00c0: dup
    IL_00c1: ldc.i4.4
    IL_00c2: ldstr "\" color=#"
    IL_00c7: stelem.ref
    IL_00c8: dup
    IL_00c9: ldc.i4.5
    IL_00ca: ldloc.2
    IL_00cb: stelem.ref
    IL_00cc: dup
    IL_00cd: ldc.i4.6
    IL_00ce: ldstr ">"
    IL_00d3: stelem.ref
    IL_00d4: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_00d9: call string InputActionGlyph::PutIntoVoffset(string)  /*0x06001103*/
    IL_00de: ret
    IL_00df: ldstr "mouse_glyphs"
    IL_00e4: stloc.0
    IL_00e5: ldstr "Sprite Assets/"
    IL_00ea: ldloc.0
    IL_00eb: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00f0: call !!0 UnityEngine.Resources::Load(string)<TMPro.TMP_SpriteAsset>  /*0x2B0000F4*/
    IL_00f5: stloc.1
    IL_00f6: ldarg.0
    IL_00f7: callvirt string Rewired.ActionElementMap::get_elementIdentifierName()  /*0x0A00068A*/
    IL_00fc: stloc.3
    IL_00fd: ldstr ""
    IL_0102: stloc.s 4
    IL_0104: ldloc.3
    IL_0105: ldstr "Left Mouse Button"
    IL_010a: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_010f: brtrue.s IL_0154
    IL_0111: ldloc.3
    IL_0112: ldstr "Right Mouse Button"
    IL_0117: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_011c: brtrue.s IL_015d
    IL_011e: ldloc.3
    IL_011f: ldstr "Mouse Button 3"
    IL_0124: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0129: brtrue.s IL_0166
    IL_012b: ldloc.3
    IL_012c: ldstr "Mouse Wheel"
    IL_0131: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0136: brtrue.s IL_016f
    IL_0138: ldloc.3
    IL_0139: ldstr "Mouse Wheel Up"
    IL_013e: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0143: brtrue.s IL_0178
    IL_0145: ldloc.3
    IL_0146: ldstr "Mouse Wheel Down"
    IL_014b: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0150: brtrue.s IL_0181
    IL_0152: br.s IL_0188
    IL_0154: ldstr "click_l"
    IL_0159: stloc.s 4
    IL_015b: br.s IL_0188
    IL_015d: ldstr "click_r"
    IL_0162: stloc.s 4
    IL_0164: br.s IL_0188
    IL_0166: ldstr "click_m"
    IL_016b: stloc.s 4
    IL_016d: br.s IL_0188
    IL_016f: ldstr "scroll"
    IL_0174: stloc.s 4
    IL_0176: br.s IL_0188
    IL_0178: ldstr "scroll+"
    IL_017d: stloc.s 4
    IL_017f: br.s IL_0188
    IL_0181: ldstr "scroll-"
    IL_0186: stloc.s 4
    IL_0188: ldloc.s 4
    IL_018a: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_018f: ldc.i4.0
    IL_0190: ble.s IL_01d0
    IL_0192: ldc.i4.7
    IL_0193: newarr System.String  /*0x0100001D*/
    IL_0198: dup
    IL_0199: ldc.i4.0
    IL_019a: ldstr "<sprite=\""
    IL_019f: stelem.ref
    IL_01a0: dup
    IL_01a1: ldc.i4.1
    IL_01a2: ldloc.0
    IL_01a3: stelem.ref
    IL_01a4: dup
    IL_01a5: ldc.i4.2
    IL_01a6: ldstr "\" name=\""
    IL_01ab: stelem.ref
    IL_01ac: dup
    IL_01ad: ldc.i4.3
    IL_01ae: ldloc.s 4
    IL_01b0: stelem.ref
    IL_01b1: dup
    IL_01b2: ldc.i4.4
    IL_01b3: ldstr "\" color=#"
    IL_01b8: stelem.ref
    IL_01b9: dup
    IL_01ba: ldc.i4.5
    IL_01bb: ldloc.2
    IL_01bc: stelem.ref
    IL_01bd: dup
    IL_01be: ldc.i4.6
    IL_01bf: ldstr ">"
    IL_01c4: stelem.ref
    IL_01c5: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_01ca: call string InputActionGlyph::PutIntoVoffset(string)  /*0x06001103*/
    IL_01cf: ret
    IL_01d0: ldc.i4.5
    IL_01d1: newarr System.String  /*0x0100001D*/
    IL_01d6: dup
    IL_01d7: ldc.i4.0
    IL_01d8: ldstr "<color=#"
    IL_01dd: stelem.ref
    IL_01de: dup
    IL_01df: ldc.i4.1
    IL_01e0: ldloc.2
    IL_01e1: stelem.ref
    IL_01e2: dup
    IL_01e3: ldc.i4.2
    IL_01e4: ldstr ">"
    IL_01e9: stelem.ref
    IL_01ea: dup
    IL_01eb: ldc.i4.3
    IL_01ec: ldarg.0
    IL_01ed: callvirt string Rewired.ActionElementMap::get_elementIdentifierName()  /*0x0A00068A*/
    IL_01f2: stelem.ref
    IL_01f3: dup
    IL_01f4: ldc.i4.4
    IL_01f5: ldstr "</color>"
    IL_01fa: stelem.ref
    IL_01fb: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_0200: ret
    IL_0201: ldarg.0
    IL_0202: callvirt ControllerMap Rewired.ActionElementMap::get_controllerMap()  /*0x0A000680*/
    IL_0207: callvirt Guid Rewired.ControllerMap::get_hardwareGuid()  /*0x0A00068C*/
    IL_020c: stloc.s 7
    IL_020e: ldloca.s 7
    IL_0210: constrained. System.Guid  /*0x01000107*/
    IL_0216: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_021b: stloc.s 5
    IL_021d: ldstr ""
    IL_0222: stloc.0
    IL_0223: ldsfld string[] InputActionGlyph::xbox_controllers  /*0x04001440*/
    IL_0228: ldloc.s 5
    IL_022a: call bool System.Linq.Enumerable::Contains(System.Collections.Generic.IEnumerable<!!0>,!!0)<string>  /*0x2B0000C7*/
    IL_022f: brfalse.s IL_0239
    IL_0231: ldstr "xbox_glyphs"
    IL_0236: stloc.0
    IL_0237: br.s IL_026b
    IL_0239: ldsfld string[] InputActionGlyph::playstation_controllers  /*0x0400143F*/
    IL_023e: ldloc.s 5
    IL_0240: call bool System.Linq.Enumerable::Contains(System.Collections.Generic.IEnumerable<!!0>,!!0)<string>  /*0x2B0000C7*/
    IL_0245: brfalse.s IL_024f
    IL_0247: ldstr "playstation_glyphs"
    IL_024c: stloc.0
    IL_024d: br.s IL_026b
    IL_024f: ldsfld string[] InputActionGlyph::switch_controllers  /*0x04001441*/
    IL_0254: ldloc.s 5
    IL_0256: call bool System.Linq.Enumerable::Contains(System.Collections.Generic.IEnumerable<!!0>,!!0)<string>  /*0x2B0000C7*/
    IL_025b: brfalse.s IL_0265
    IL_025d: ldstr "switch_default_glyphs"
    IL_0262: stloc.0
    IL_0263: br.s IL_026b
    IL_0265: ldstr "generic_glyphs"
    IL_026a: stloc.0
    IL_026b: ldstr "Sprite Assets/"
    IL_0270: ldloc.0
    IL_0271: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0276: call !!0 UnityEngine.Resources::Load(string)<TMPro.TMP_SpriteAsset>  /*0x2B0000F4*/
    IL_027b: stloc.1
    IL_027c: ldloc.0
    IL_027d: ldstr "generic_glyphs"
    IL_0282: call bool System.String::op_Inequality(string,string)  /*0x0A00002D*/
    IL_0287: brfalse IL_0383
    IL_028c: ldstr ""
    IL_0291: stloc.s 8
    IL_0293: ldarg.0
    IL_0294: callvirt AxisRange Rewired.ActionElementMap::get_axisRange()  /*0x0A000400*/
    IL_0299: brfalse.s IL_02e3
    IL_029b: ldarg.0
    IL_029c: callvirt AxisRange Rewired.ActionElementMap::get_axisRange()  /*0x0A000400*/
    IL_02a1: ldc.i4.1
    IL_02a2: bne.un.s IL_02ad
    IL_02a4: ldstr "+"
    IL_02a9: stloc.s 8
    IL_02ab: br.s IL_02bd
    IL_02ad: ldarg.0
    IL_02ae: callvirt AxisRange Rewired.ActionElementMap::get_axisRange()  /*0x0A000400*/
    IL_02b3: ldc.i4.2
    IL_02b4: bne.un.s IL_02bd
    IL_02b6: ldstr "-"
    IL_02bb: stloc.s 8
    IL_02bd: ldloc.1
    IL_02be: ldarg.0
    IL_02bf: callvirt int Rewired.ActionElementMap::get_elementIdentifierId()  /*0x0A0003FF*/
    IL_02c4: stloc.s 9
    IL_02c6: ldloca.s 9
    IL_02c8: call string System.Int32::ToString()  /*0x0A000031*/
    IL_02cd: ldloc.s 8
    IL_02cf: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_02d4: callvirt int TMPro.TMP_SpriteAsset::GetSpriteIndexFromName(string)  /*0x0A00068B*/
    IL_02d9: ldc.i4.0
    IL_02da: bge.s IL_02e3
    IL_02dc: ldstr ""
    IL_02e1: stloc.s 8
    IL_02e3: ldloc.1
    IL_02e4: ldarg.0
    IL_02e5: callvirt int Rewired.ActionElementMap::get_elementIdentifierId()  /*0x0A0003FF*/
    IL_02ea: stloc.s 9
    IL_02ec: ldloca.s 9
    IL_02ee: call string System.Int32::ToString()  /*0x0A000031*/
    IL_02f3: ldloc.s 8
    IL_02f5: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_02fa: callvirt int TMPro.TMP_SpriteAsset::GetSpriteIndexFromName(string)  /*0x0A00068B*/
    IL_02ff: ldc.i4.0
    IL_0300: bge.s IL_0333
    IL_0302: ldc.i4.5
    IL_0303: newarr System.String  /*0x0100001D*/
    IL_0308: dup
    IL_0309: ldc.i4.0
    IL_030a: ldstr "<color=#"
    IL_030f: stelem.ref
    IL_0310: dup
    IL_0311: ldc.i4.1
    IL_0312: ldloc.2
    IL_0313: stelem.ref
    IL_0314: dup
    IL_0315: ldc.i4.2
    IL_0316: ldstr ">"
    IL_031b: stelem.ref
    IL_031c: dup
    IL_031d: ldc.i4.3
    IL_031e: ldarg.0
    IL_031f: callvirt string Rewired.ActionElementMap::get_elementIdentifierName()  /*0x0A00068A*/
    IL_0324: stelem.ref
    IL_0325: dup
    IL_0326: ldc.i4.4
    IL_0327: ldstr "</color>"
    IL_032c: stelem.ref
    IL_032d: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_0332: ret
    IL_0333: ldc.i4.8
    IL_0334: newarr System.String  /*0x0100001D*/
    IL_0339: dup
    IL_033a: ldc.i4.0
    IL_033b: ldstr "<sprite=\""
    IL_0340: stelem.ref
    IL_0341: dup
    IL_0342: ldc.i4.1
    IL_0343: ldloc.0
    IL_0344: stelem.ref
    IL_0345: dup
    IL_0346: ldc.i4.2
    IL_0347: ldstr "\" name=\""
    IL_034c: stelem.ref
    IL_034d: dup
    IL_034e: ldc.i4.3
    IL_034f: ldarg.0
    IL_0350: callvirt int Rewired.ActionElementMap::get_elementIdentifierId()  /*0x0A0003FF*/
    IL_0355: stloc.s 9
    IL_0357: ldloca.s 9
    IL_0359: call string System.Int32::ToString()  /*0x0A000031*/
    IL_035e: stelem.ref
    IL_035f: dup
    IL_0360: ldc.i4.4
    IL_0361: ldloc.s 8
    IL_0363: stelem.ref
    IL_0364: dup
    IL_0365: ldc.i4.5
    IL_0366: ldstr "\" color=#"
    IL_036b: stelem.ref
    IL_036c: dup
    IL_036d: ldc.i4.6
    IL_036e: ldloc.2
    IL_036f: stelem.ref
    IL_0370: dup
    IL_0371: ldc.i4.7
    IL_0372: ldstr ">"
    IL_0377: stelem.ref
    IL_0378: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_037d: call string InputActionGlyph::PutIntoVoffset(string)  /*0x06001103*/
    IL_0382: ret
    IL_0383: ldloc.1
    IL_0384: ldarg.0
    IL_0385: callvirt string Rewired.ActionElementMap::get_elementIdentifierName()  /*0x0A00068A*/
    IL_038a: callvirt int TMPro.TMP_SpriteAsset::GetSpriteIndexFromName(string)  /*0x0A00068B*/
    IL_038f: ldc.i4.0
    IL_0390: bge.s IL_03c3
    IL_0392: ldc.i4.5
    IL_0393: newarr System.String  /*0x0100001D*/
    IL_0398: dup
    IL_0399: ldc.i4.0
    IL_039a: ldstr "<color=#"
    IL_039f: stelem.ref
    IL_03a0: dup
    IL_03a1: ldc.i4.1
    IL_03a2: ldloc.2
    IL_03a3: stelem.ref
    IL_03a4: dup
    IL_03a5: ldc.i4.2
    IL_03a6: ldstr ">"
    IL_03ab: stelem.ref
    IL_03ac: dup
    IL_03ad: ldc.i4.3
    IL_03ae: ldarg.0
    IL_03af: callvirt string Rewired.ActionElementMap::get_elementIdentifierName()  /*0x0A00068A*/
    IL_03b4: stelem.ref
    IL_03b5: dup
    IL_03b6: ldc.i4.4
    IL_03b7: ldstr "</color>"
    IL_03bc: stelem.ref
    IL_03bd: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_03c2: ret
    IL_03c3: ldc.i4.7
    IL_03c4: newarr System.String  /*0x0100001D*/
    IL_03c9: dup
    IL_03ca: ldc.i4.0
    IL_03cb: ldstr "<sprite=\""
    IL_03d0: stelem.ref
    IL_03d1: dup
    IL_03d2: ldc.i4.1
    IL_03d3: ldloc.0
    IL_03d4: stelem.ref
    IL_03d5: dup
    IL_03d6: ldc.i4.2
    IL_03d7: ldstr "\" name=\""
    IL_03dc: stelem.ref
    IL_03dd: dup
    IL_03de: ldc.i4.3
    IL_03df: ldarg.0
    IL_03e0: callvirt string Rewired.ActionElementMap::get_elementIdentifierName()  /*0x0A00068A*/
    IL_03e5: stelem.ref
    IL_03e6: dup
    IL_03e7: ldc.i4.4
    IL_03e8: ldstr "\" color=#"
    IL_03ed: stelem.ref
    IL_03ee: dup
    IL_03ef: ldc.i4.5
    IL_03f0: ldloc.2
    IL_03f1: stelem.ref
    IL_03f2: dup
    IL_03f3: ldc.i4.6
    IL_03f4: ldstr ">"
    IL_03f9: stelem.ref
    IL_03fa: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_03ff: call string InputActionGlyph::PutIntoVoffset(string)  /*0x06001103*/
    IL_0404: ret
    IL_0405: ldstr "NOT SUPPORTED YED"
    IL_040a: ret

  .method InputActionGlyph::PutIntoVoffset(string)  // token 0x06001103 rva 0x4f32b attrs Public, Static, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldstr "<voffset=-0.1em>"
    IL_0005: ldarg.0
    IL_0006: ldstr "</voffset>"
    IL_000b: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0010: ret

// ===== InputActionGlyph/InputPriority  (token 0x02000318) =====
// ===== InputActionGlyph/<>c  (token 0x02000319) =====
  .method InputActionGlyph.<>c::.cctor()  // token 0x06001104 rva 0x4f33d attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void InputActionGlyph.<>c::.ctor()  /*0x06001105*/
    IL_0005: stsfld InputActionGlyph.<>c InputActionGlyph.<>c::<>9  /*0x04001448*/
    IL_000a: ret

  .method InputActionGlyph.<>c::.ctor()  // token 0x06001105 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method InputActionGlyph.<>c::<GetActionGlyph>b__10_0(Rewired.ActionElementMap)  // token 0x06001106 rva 0x4f349 attrs Assembly, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.1
    IL_0001: callvirt ControllerMap Rewired.ActionElementMap::get_controllerMap()  /*0x0A000680*/
    IL_0006: callvirt ControllerType Rewired.ControllerMap::get_controllerType()  /*0x0A0003FD*/
    IL_000b: brfalse.s IL_001f
    IL_000d: ldarg.1
    IL_000e: callvirt ControllerMap Rewired.ActionElementMap::get_controllerMap()  /*0x0A000680*/
    IL_0013: callvirt ControllerType Rewired.ControllerMap::get_controllerType()  /*0x0A0003FD*/
    IL_0018: ldc.i4.1
    IL_0019: ceq
    IL_001b: ldc.i4.0
    IL_001c: ceq
    IL_001e: ret
    IL_001f: ldc.i4.0
    IL_0020: ret

  .method InputActionGlyph.<>c::<GetActionGlyph>b__10_1(Rewired.ActionElementMap)  // token 0x06001107 rva 0x4f349 attrs Assembly, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.1
    IL_0001: callvirt ControllerMap Rewired.ActionElementMap::get_controllerMap()  /*0x0A000680*/
    IL_0006: callvirt ControllerType Rewired.ControllerMap::get_controllerType()  /*0x0A0003FD*/
    IL_000b: brfalse.s IL_001f
    IL_000d: ldarg.1
    IL_000e: callvirt ControllerMap Rewired.ActionElementMap::get_controllerMap()  /*0x0A000680*/
    IL_0013: callvirt ControllerType Rewired.ControllerMap::get_controllerType()  /*0x0A0003FD*/
    IL_0018: ldc.i4.1
    IL_0019: ceq
    IL_001b: ldc.i4.0
    IL_001c: ceq
    IL_001e: ret
    IL_001f: ldc.i4.0
    IL_0020: ret

  .method InputActionGlyph.<>c::<GetActionGlyph>b__10_2(Rewired.ActionElementMap)  // token 0x06001108 rva 0x4f36b attrs Assembly, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.1
    IL_0001: callvirt ControllerMap Rewired.ActionElementMap::get_controllerMap()  /*0x0A000680*/
    IL_0006: callvirt ControllerType Rewired.ControllerMap::get_controllerType()  /*0x0A0003FD*/
    IL_000b: ldc.i4.2
    IL_000c: ceq
    IL_000e: ldc.i4.0
    IL_000f: ceq
    IL_0011: ret

  .method InputActionGlyph.<>c::<GetActionGlyph>b__10_3(Rewired.ActionElementMap)  // token 0x06001109 rva 0x4f36b attrs Assembly, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.1
    IL_0001: callvirt ControllerMap Rewired.ActionElementMap::get_controllerMap()  /*0x0A000680*/
    IL_0006: callvirt ControllerType Rewired.ControllerMap::get_controllerType()  /*0x0A0003FD*/
    IL_000b: ldc.i4.2
    IL_000c: ceq
    IL_000e: ldc.i4.0
    IL_000f: ceq
    IL_0011: ret

