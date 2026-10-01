// ===== TextTranslator  (token 0x020001E1) =====
  .method TextTranslator::Awake()  // token 0x060009E1 rva 0x2e51e attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld TextTranslator TextTranslator::instance  /*0x04000C95*/
    IL_0006: ret

  .method TextTranslator::Translate(string,bool,int,bool,bool)  // token 0x060009E2 rva 0x2e528 attrs Public, Static, HideBySig
    // code size 341 (0x155), max stack 8, init locals
    .locals ([0] string, [1] IEnumerator, [2] Match, [3] string, [4] bool, [5] string, [6] string, [7] IDisposable, [8] string)
    IL_0000: ldarg.0
    IL_0001: ldstr ""
    IL_0006: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_000b: brfalse.s IL_0013
    IL_000d: ldstr ""
    IL_0012: ret
    IL_0013: nop
    IL_0014: ldarg.0
    IL_0015: ldarg.1
    IL_0016: ldarg.2
    IL_0017: ldarg.3
    IL_0018: ldarg.s 4
    IL_001a: ldnull
    IL_001b: ldnull
    IL_001c: ldc.i4.1
    IL_001d: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_0022: stloc.0
    IL_0023: ldstr "\\{(.+?)\\}"
    IL_0028: newobj void System.Text.RegularExpressions.Regex::.ctor(string)  /*0x0A000474*/
    IL_002d: ldloc.0
    IL_002e: callvirt MatchCollection System.Text.RegularExpressions.Regex::Matches(string)  /*0x0A000475*/
    IL_0033: callvirt IEnumerator System.Text.RegularExpressions.MatchCollection::GetEnumerator()  /*0x0A000476*/
    IL_0038: stloc.1
    IL_0039: br IL_0126
    IL_003e: ldloc.1
    IL_003f: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_0044: castclass System.Text.RegularExpressions.Match  /*0x010000E8*/
    IL_0049: stloc.2
    IL_004a: ldloc.2
    IL_004b: callvirt GroupCollection System.Text.RegularExpressions.Match::get_Groups()  /*0x0A000477*/
    IL_0050: ldc.i4.1
    IL_0051: callvirt Group System.Text.RegularExpressions.GroupCollection::get_Item(int)  /*0x0A000478*/
    IL_0056: callvirt string System.Text.RegularExpressions.Capture::get_Value()  /*0x0A000479*/
    IL_005b: stloc.3
    IL_005c: ldloc.3
    IL_005d: ldstr ".NOMIN"
    IL_0062: callvirt bool System.String::EndsWith(string)  /*0x0A00047A*/
    IL_0067: stloc.s 4
    IL_0069: ldloc.s 4
    IL_006b: brfalse.s IL_007d
    IL_006d: ldloc.3
    IL_006e: ldc.i4.0
    IL_006f: ldloc.3
    IL_0070: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_0075: ldc.i4.6
    IL_0076: sub
    IL_0077: callvirt string System.String::Substring(int,int)  /*0x0A00047B*/
    IL_007c: stloc.3
    IL_007d: ldloc.3
    IL_007e: ldstr "ACTION."
    IL_0083: callvirt bool System.String::StartsWith(string)  /*0x0A00047C*/
    IL_0088: brfalse.s IL_00bc
    IL_008a: ldloc.3
    IL_008b: ldc.i4.7
    IL_008c: callvirt string System.String::Substring(int)  /*0x0A000354*/
    IL_0091: stloc.s 5
    IL_0093: ldloc.s 5
    IL_0095: call string TextTranslator::ConvertToSpacedString(string)  /*0x060009E3*/
    IL_009a: stloc.s 5
    IL_009c: ldloc.s 5
    IL_009e: ldsfld InputActionGlyph.InputPriority TextTranslator::inputPriority  /*0x04000C96*/
    IL_00a3: ldc.i4.0
    IL_00a4: call string InputActionGlyph::GetActionGlyph(string,InputActionGlyph.InputPriority,bool)  /*0x06001101*/
    IL_00a9: stloc.s 5
    IL_00ab: ldloc.0
    IL_00ac: ldloc.2
    IL_00ad: callvirt string System.Text.RegularExpressions.Capture::get_Value()  /*0x0A000479*/
    IL_00b2: ldloc.s 5
    IL_00b4: callvirt string System.String::Replace(string,string)  /*0x0A0003CD*/
    IL_00b9: stloc.0
    IL_00ba: br.s IL_0126
    IL_00bc: ldsfld TextTranslator TextTranslator::instance  /*0x04000C95*/
    IL_00c1: ldfld BalancingParameters TextTranslator::balancingParameters  /*0x04000C94*/
    IL_00c6: ldfld StringFloatSerializableDictionary BalancingParameters::parameters  /*0x0400034D*/
    IL_00cb: ldloc.3
    IL_00cc: ldstr " "
    IL_00d1: ldstr ""
    IL_00d6: callvirt string System.String::Replace(string,string)  /*0x0A0003CD*/
    IL_00db: ldloca.s 6
    IL_00dd: callvirt bool System.Collections.Generic.Dictionary<string, string>::TryGetValue(!0,ref !1)  /*0x0A00047D*/
    IL_00e2: brfalse.s IL_0111
    IL_00e4: ldloc.s 4
    IL_00e6: brfalse.s IL_0100
    IL_00e8: ldloc.s 6
    IL_00ea: ldstr "-"
    IL_00ef: callvirt bool System.String::StartsWith(string)  /*0x0A00047C*/
    IL_00f4: brfalse.s IL_0100
    IL_00f6: ldloc.s 6
    IL_00f8: ldc.i4.1
    IL_00f9: callvirt string System.String::Substring(int)  /*0x0A000354*/
    IL_00fe: stloc.s 6
    IL_0100: ldloc.0
    IL_0101: ldloc.2
    IL_0102: callvirt string System.Text.RegularExpressions.Capture::get_Value()  /*0x0A000479*/
    IL_0107: ldloc.s 6
    IL_0109: callvirt string System.String::Replace(string,string)  /*0x0A0003CD*/
    IL_010e: stloc.0
    IL_010f: br.s IL_0126
    IL_0111: ldstr "Key "
    IL_0116: ldloc.3
    IL_0117: ldstr " not found in balancing parameters."
    IL_011c: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0121: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_0126: ldloc.1
    IL_0127: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_012c: brtrue IL_003e
    IL_0131: leave.s IL_0147
    IL_0133: ldloc.1
    IL_0134: isinst System.IDisposable  /*0x0100001B*/
    IL_0139: stloc.s 7
    IL_013b: ldloc.s 7
    IL_013d: brfalse.s IL_0146
    IL_013f: ldloc.s 7
    IL_0141: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0146: endfinally
    IL_0147: ldloc.0
    IL_0148: stloc.s 8
    IL_014a: leave.s IL_0152
    IL_014c: pop
    IL_014d: ldarg.0
    IL_014e: stloc.s 8
    IL_0150: leave.s IL_0152
    IL_0152: ldloc.s 8
    IL_0154: ret
    .try IL_0039-IL_0133 finally handler IL_0133-IL_0147
    .try IL_0014-IL_014c catch System.Object handler IL_014c-IL_0152

  .method TextTranslator::ConvertToSpacedString(string)  // token 0x060009E3 rva 0x2e6c0 attrs Public, Static, HideBySig
    // code size 101 (0x65), max stack 3, init locals
    .locals ([0] StringBuilder, [1] int)
    IL_0000: ldarg.0
    IL_0001: call bool System.String::IsNullOrEmpty(string)  /*0x0A000141*/
    IL_0006: brtrue.s IL_0012
    IL_0008: ldarg.0
    IL_0009: ldc.i4.s 32
    IL_000b: callvirt bool System.String::Contains(char)  /*0x0A00047E*/
    IL_0010: brfalse.s IL_0014
    IL_0012: ldarg.0
    IL_0013: ret
    IL_0014: newobj void System.Text.StringBuilder::.ctor()  /*0x0A00047F*/
    IL_0019: stloc.0
    IL_001a: ldloc.0
    IL_001b: ldarg.0
    IL_001c: ldc.i4.0
    IL_001d: callvirt char System.String::get_Chars(int)  /*0x0A000146*/
    IL_0022: callvirt StringBuilder System.Text.StringBuilder::Append(char)  /*0x0A000480*/
    IL_0027: pop
    IL_0028: ldc.i4.1
    IL_0029: stloc.1
    IL_002a: br.s IL_0055
    IL_002c: ldarg.0
    IL_002d: ldloc.1
    IL_002e: callvirt char System.String::get_Chars(int)  /*0x0A000146*/
    IL_0033: call bool System.Char::IsUpper(char)  /*0x0A000481*/
    IL_0038: brfalse.s IL_0043
    IL_003a: ldloc.0
    IL_003b: ldc.i4.s 32
    IL_003d: callvirt StringBuilder System.Text.StringBuilder::Append(char)  /*0x0A000480*/
    IL_0042: pop
    IL_0043: ldloc.0
    IL_0044: ldarg.0
    IL_0045: ldloc.1
    IL_0046: callvirt char System.String::get_Chars(int)  /*0x0A000146*/
    IL_004b: callvirt StringBuilder System.Text.StringBuilder::Append(char)  /*0x0A000480*/
    IL_0050: pop
    IL_0051: ldloc.1
    IL_0052: ldc.i4.1
    IL_0053: add
    IL_0054: stloc.1
    IL_0055: ldloc.1
    IL_0056: ldarg.0
    IL_0057: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_005c: blt.s IL_002c
    IL_005e: ldloc.0
    IL_005f: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_0064: ret

  .method TextTranslator::TranslateAndInsertLevelNumber(string,int,bool,bool,int,bool,bool)  // token 0x060009E4 rva 0x2e734 attrs Public, Static, HideBySig
    // code size 426 (0x1aa), max stack 13, init locals
    .locals ([0] string, [1] IEnumerator, [2] Match, [3] string, [4] string, [5] string, [6] IDisposable, [7] string)
    IL_0000: ldarg.0
    IL_0001: ldstr ""
    IL_0006: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_000b: brfalse.s IL_0013
    IL_000d: ldstr ""
    IL_0012: ret
    IL_0013: nop
    IL_0014: ldarg.0
    IL_0015: ldarg.3
    IL_0016: ldarg.s 4
    IL_0018: ldarg.s 5
    IL_001a: ldarg.s 6
    IL_001c: ldnull
    IL_001d: ldnull
    IL_001e: ldc.i4.1
    IL_001f: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_0024: stloc.0
    IL_0025: ldstr "\\{(.+?)\\}"
    IL_002a: newobj void System.Text.RegularExpressions.Regex::.ctor(string)  /*0x0A000474*/
    IL_002f: ldloc.0
    IL_0030: callvirt MatchCollection System.Text.RegularExpressions.Regex::Matches(string)  /*0x0A000475*/
    IL_0035: callvirt IEnumerator System.Text.RegularExpressions.MatchCollection::GetEnumerator()  /*0x0A000476*/
    IL_003a: stloc.1
    IL_003b: br IL_017b
    IL_0040: ldloc.1
    IL_0041: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_0046: castclass System.Text.RegularExpressions.Match  /*0x010000E8*/
    IL_004b: stloc.2
    IL_004c: ldloc.2
    IL_004d: callvirt GroupCollection System.Text.RegularExpressions.Match::get_Groups()  /*0x0A000477*/
    IL_0052: ldc.i4.1
    IL_0053: callvirt Group System.Text.RegularExpressions.GroupCollection::get_Item(int)  /*0x0A000478*/
    IL_0058: callvirt string System.Text.RegularExpressions.Capture::get_Value()  /*0x0A000479*/
    IL_005d: stloc.3
    IL_005e: ldloc.3
    IL_005f: ldstr "ACTION."
    IL_0064: callvirt bool System.String::Contains(string)  /*0x0A000055*/
    IL_0069: brfalse.s IL_00a0
    IL_006b: ldloc.3
    IL_006c: ldstr "ACTION."
    IL_0071: ldstr ""
    IL_0076: callvirt string System.String::Replace(string,string)  /*0x0A0003CD*/
    IL_007b: stloc.s 4
    IL_007d: ldloc.s 4
    IL_007f: ldsfld InputActionGlyph.InputPriority TextTranslator::inputPriority  /*0x04000C96*/
    IL_0084: ldc.i4.0
    IL_0085: call string InputActionGlyph::GetActionGlyph(string,InputActionGlyph.InputPriority,bool)  /*0x06001101*/
    IL_008a: stloc.s 4
    IL_008c: ldloc.0
    IL_008d: ldloc.2
    IL_008e: callvirt string System.Text.RegularExpressions.Capture::get_Value()  /*0x0A000479*/
    IL_0093: ldloc.s 4
    IL_0095: callvirt string System.String::Replace(string,string)  /*0x0A0003CD*/
    IL_009a: stloc.0
    IL_009b: br IL_017b
    IL_00a0: ldsfld TextTranslator TextTranslator::instance  /*0x04000C95*/
    IL_00a5: ldfld BalancingParameters TextTranslator::balancingParameters  /*0x04000C94*/
    IL_00aa: ldfld StringFloatSerializableDictionary BalancingParameters::parameters  /*0x0400034D*/
    IL_00af: ldloc.3
    IL_00b0: ldloca.s 5
    IL_00b2: callvirt bool System.Collections.Generic.Dictionary<string, string>::TryGetValue(!0,ref !1)  /*0x0A00047D*/
    IL_00b7: brfalse.s IL_00cd
    IL_00b9: ldloc.0
    IL_00ba: ldloc.2
    IL_00bb: callvirt string System.Text.RegularExpressions.Capture::get_Value()  /*0x0A000479*/
    IL_00c0: ldloc.s 5
    IL_00c2: callvirt string System.String::Replace(string,string)  /*0x0A0003CD*/
    IL_00c7: stloc.0
    IL_00c8: br IL_017b
    IL_00cd: ldloc.3
    IL_00ce: ldstr "LEVEL"
    IL_00d3: callvirt bool System.String::Contains(string)  /*0x0A000055*/
    IL_00d8: brfalse IL_0166
    IL_00dd: ldarg.2
    IL_00de: brtrue.s IL_0116
    IL_00e0: ldloc.0
    IL_00e1: ldloc.2
    IL_00e2: callvirt string System.Text.RegularExpressions.Capture::get_Value()  /*0x0A000479*/
    IL_00e7: ldstr "Menu/Level"
    IL_00ec: ldc.i4.1
    IL_00ed: ldc.i4.0
    IL_00ee: ldc.i4.1
    IL_00ef: ldc.i4.0
    IL_00f0: ldnull
    IL_00f1: ldnull
    IL_00f2: ldc.i4.1
    IL_00f3: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_00f8: ldstr " <style=\"Body Numerals\">"
    IL_00fd: ldarga.s 1
    IL_00ff: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0104: ldstr "</style>"
    IL_0109: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_010e: callvirt string System.String::Replace(string,string)  /*0x0A0003CD*/
    IL_0113: stloc.0
    IL_0114: br.s IL_017b
    IL_0116: ldloc.0
    IL_0117: ldloc.2
    IL_0118: callvirt string System.Text.RegularExpressions.Capture::get_Value()  /*0x0A000479*/
    IL_011d: ldc.i4.5
    IL_011e: newarr System.String  /*0x0100001D*/
    IL_0123: dup
    IL_0124: ldc.i4.0
    IL_0125: ldstr "<style=Highlighted>"
    IL_012a: stelem.ref
    IL_012b: dup
    IL_012c: ldc.i4.1
    IL_012d: ldstr "Menu/Level"
    IL_0132: ldc.i4.1
    IL_0133: ldc.i4.0
    IL_0134: ldc.i4.1
    IL_0135: ldc.i4.0
    IL_0136: ldnull
    IL_0137: ldnull
    IL_0138: ldc.i4.1
    IL_0139: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_013e: stelem.ref
    IL_013f: dup
    IL_0140: ldc.i4.2
    IL_0141: ldstr " <style=\"Body Numerals\">"
    IL_0146: stelem.ref
    IL_0147: dup
    IL_0148: ldc.i4.3
    IL_0149: ldarga.s 1
    IL_014b: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0150: stelem.ref
    IL_0151: dup
    IL_0152: ldc.i4.4
    IL_0153: ldstr "</style></style>"
    IL_0158: stelem.ref
    IL_0159: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_015e: callvirt string System.String::Replace(string,string)  /*0x0A0003CD*/
    IL_0163: stloc.0
    IL_0164: br.s IL_017b
    IL_0166: ldstr "Key "
    IL_016b: ldloc.3
    IL_016c: ldstr " not found in balancing parameters."
    IL_0171: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0176: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_017b: ldloc.1
    IL_017c: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0181: brtrue IL_0040
    IL_0186: leave.s IL_019c
    IL_0188: ldloc.1
    IL_0189: isinst System.IDisposable  /*0x0100001B*/
    IL_018e: stloc.s 6
    IL_0190: ldloc.s 6
    IL_0192: brfalse.s IL_019b
    IL_0194: ldloc.s 6
    IL_0196: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_019b: endfinally
    IL_019c: ldloc.0
    IL_019d: stloc.s 7
    IL_019f: leave.s IL_01a7
    IL_01a1: pop
    IL_01a2: ldarg.0
    IL_01a3: stloc.s 7
    IL_01a5: leave.s IL_01a7
    IL_01a7: ldloc.s 7
    IL_01a9: ret
    .try IL_003b-IL_0188 finally handler IL_0188-IL_019c
    .try IL_0014-IL_01a1 catch System.Object handler IL_01a1-IL_01a7

  .method TextTranslator::TranslateAndInsertMapName(string,string,bool,bool,int,bool,bool)  // token 0x060009E5 rva 0x2e920 attrs Public, Static, HideBySig
    // code size 390 (0x186), max stack 11, init locals
    .locals ([0] string, [1] IEnumerator, [2] Match, [3] string, [4] string, [5] string, [6] IDisposable, [7] string)
    IL_0000: ldarg.0
    IL_0001: ldstr ""
    IL_0006: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_000b: brfalse.s IL_0013
    IL_000d: ldstr ""
    IL_0012: ret
    IL_0013: nop
    IL_0014: ldarg.0
    IL_0015: ldarg.3
    IL_0016: ldarg.s 4
    IL_0018: ldarg.s 5
    IL_001a: ldarg.s 6
    IL_001c: ldnull
    IL_001d: ldnull
    IL_001e: ldc.i4.1
    IL_001f: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_0024: stloc.0
    IL_0025: ldstr "\\{(.+?)\\}"
    IL_002a: newobj void System.Text.RegularExpressions.Regex::.ctor(string)  /*0x0A000474*/
    IL_002f: ldloc.0
    IL_0030: callvirt MatchCollection System.Text.RegularExpressions.Regex::Matches(string)  /*0x0A000475*/
    IL_0035: callvirt IEnumerator System.Text.RegularExpressions.MatchCollection::GetEnumerator()  /*0x0A000476*/
    IL_003a: stloc.1
    IL_003b: br IL_0157
    IL_0040: ldloc.1
    IL_0041: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_0046: castclass System.Text.RegularExpressions.Match  /*0x010000E8*/
    IL_004b: stloc.2
    IL_004c: ldloc.2
    IL_004d: callvirt GroupCollection System.Text.RegularExpressions.Match::get_Groups()  /*0x0A000477*/
    IL_0052: ldc.i4.1
    IL_0053: callvirt Group System.Text.RegularExpressions.GroupCollection::get_Item(int)  /*0x0A000478*/
    IL_0058: callvirt string System.Text.RegularExpressions.Capture::get_Value()  /*0x0A000479*/
    IL_005d: stloc.3
    IL_005e: ldloc.3
    IL_005f: ldstr "ACTION."
    IL_0064: callvirt bool System.String::Contains(string)  /*0x0A000055*/
    IL_0069: brfalse.s IL_00a0
    IL_006b: ldloc.3
    IL_006c: ldstr "ACTION."
    IL_0071: ldstr ""
    IL_0076: callvirt string System.String::Replace(string,string)  /*0x0A0003CD*/
    IL_007b: stloc.s 4
    IL_007d: ldloc.s 4
    IL_007f: ldsfld InputActionGlyph.InputPriority TextTranslator::inputPriority  /*0x04000C96*/
    IL_0084: ldc.i4.0
    IL_0085: call string InputActionGlyph::GetActionGlyph(string,InputActionGlyph.InputPriority,bool)  /*0x06001101*/
    IL_008a: stloc.s 4
    IL_008c: ldloc.0
    IL_008d: ldloc.2
    IL_008e: callvirt string System.Text.RegularExpressions.Capture::get_Value()  /*0x0A000479*/
    IL_0093: ldloc.s 4
    IL_0095: callvirt string System.String::Replace(string,string)  /*0x0A0003CD*/
    IL_009a: stloc.0
    IL_009b: br IL_0157
    IL_00a0: ldsfld TextTranslator TextTranslator::instance  /*0x04000C95*/
    IL_00a5: ldfld BalancingParameters TextTranslator::balancingParameters  /*0x04000C94*/
    IL_00aa: ldfld StringFloatSerializableDictionary BalancingParameters::parameters  /*0x0400034D*/
    IL_00af: ldloc.3
    IL_00b0: ldloca.s 5
    IL_00b2: callvirt bool System.Collections.Generic.Dictionary<string, string>::TryGetValue(!0,ref !1)  /*0x0A00047D*/
    IL_00b7: brfalse.s IL_00cd
    IL_00b9: ldloc.0
    IL_00ba: ldloc.2
    IL_00bb: callvirt string System.Text.RegularExpressions.Capture::get_Value()  /*0x0A000479*/
    IL_00c0: ldloc.s 5
    IL_00c2: callvirt string System.String::Replace(string,string)  /*0x0A0003CD*/
    IL_00c7: stloc.0
    IL_00c8: br IL_0157
    IL_00cd: ldloc.3
    IL_00ce: ldstr "MAP"
    IL_00d3: callvirt bool System.String::Contains(string)  /*0x0A000055*/
    IL_00d8: brfalse.s IL_0142
    IL_00da: ldarg.2
    IL_00db: brtrue.s IL_010d
    IL_00dd: ldloc.0
    IL_00de: ldloc.2
    IL_00df: callvirt string System.Text.RegularExpressions.Capture::get_Value()  /*0x0A000479*/
    IL_00e4: ldstr "Map Name/"
    IL_00e9: ldarg.1
    IL_00ea: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00ef: ldc.i4.1
    IL_00f0: ldc.i4.0
    IL_00f1: ldc.i4.1
    IL_00f2: ldc.i4.0
    IL_00f3: ldnull
    IL_00f4: ldnull
    IL_00f5: ldc.i4.1
    IL_00f6: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_00fb: ldstr "</style>"
    IL_0100: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0105: callvirt string System.String::Replace(string,string)  /*0x0A0003CD*/
    IL_010a: stloc.0
    IL_010b: br.s IL_0157
    IL_010d: ldloc.0
    IL_010e: ldloc.2
    IL_010f: callvirt string System.Text.RegularExpressions.Capture::get_Value()  /*0x0A000479*/
    IL_0114: ldstr "<style=Highlighted>"
    IL_0119: ldstr "Map Name/"
    IL_011e: ldarg.1
    IL_011f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0124: ldc.i4.1
    IL_0125: ldc.i4.0
    IL_0126: ldc.i4.1
    IL_0127: ldc.i4.0
    IL_0128: ldnull
    IL_0129: ldnull
    IL_012a: ldc.i4.1
    IL_012b: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_0130: ldstr "</style></style>"
    IL_0135: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_013a: callvirt string System.String::Replace(string,string)  /*0x0A0003CD*/
    IL_013f: stloc.0
    IL_0140: br.s IL_0157
    IL_0142: ldstr "Key "
    IL_0147: ldloc.3
    IL_0148: ldstr " not found in balancing parameters."
    IL_014d: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0152: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_0157: ldloc.1
    IL_0158: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_015d: brtrue IL_0040
    IL_0162: leave.s IL_0178
    IL_0164: ldloc.1
    IL_0165: isinst System.IDisposable  /*0x0100001B*/
    IL_016a: stloc.s 6
    IL_016c: ldloc.s 6
    IL_016e: brfalse.s IL_0177
    IL_0170: ldloc.s 6
    IL_0172: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0177: endfinally
    IL_0178: ldloc.0
    IL_0179: stloc.s 7
    IL_017b: leave.s IL_0183
    IL_017d: pop
    IL_017e: ldarg.0
    IL_017f: stloc.s 7
    IL_0181: leave.s IL_0183
    IL_0183: ldloc.s 7
    IL_0185: ret
    .try IL_003b-IL_0164 finally handler IL_0164-IL_0178
    .try IL_0014-IL_017d catch System.Object handler IL_017d-IL_0183

  .method TextTranslator::.ctor()  // token 0x060009E6 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

