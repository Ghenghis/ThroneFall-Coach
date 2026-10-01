// ===== MatchSave  (token 0x0200025E) =====
  .method MatchSave::TryLoadValue(string,ref !!0)  // token 0x06000D01 rva 0x3b4b4 attrs Public, HideBySig
    // code size 42 (0x2a), max stack 3, init locals
    .locals ([0] object)
    IL_0000: ldarg.0
    IL_0001: ldfld Dictionary<string, object> MatchSave::savedEntities  /*0x04000F91*/
    IL_0006: ldarg.1
    IL_0007: ldloca.s 0
    IL_0009: callvirt bool System.Collections.Generic.Dictionary<string, object>::TryGetValue(!0,ref !1)  /*0x0A00052E*/
    IL_000e: brfalse.s IL_0028
    IL_0010: ldloc.0
    IL_0011: isinst !!0  /*0x1B00009D*/
    IL_0016: brfalse.s IL_0026
    IL_0018: ldarg.2
    IL_0019: ldloc.0
    IL_001a: unbox.any !!0  /*0x1B00009D*/
    IL_001f: stobj !!0  /*0x1B00009D*/
    IL_0024: ldc.i4.1
    IL_0025: ret
    IL_0026: ldc.i4.0
    IL_0027: ret
    IL_0028: ldc.i4.0
    IL_0029: ret

  .method MatchSave::AddValue(string,!!0)  // token 0x06000D02 rva 0x3b4ea attrs Public, HideBySig
    // code size 52 (0x34), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Dictionary<string, object> MatchSave::savedEntities  /*0x04000F91*/
    IL_0006: ldarg.1
    IL_0007: callvirt bool System.Collections.Generic.Dictionary<string, object>::ContainsKey(!0)  /*0x0A00052F*/
    IL_000c: brfalse.s IL_0021
    IL_000e: ldarg.0
    IL_000f: ldfld Dictionary<string, object> MatchSave::savedEntities  /*0x04000F91*/
    IL_0014: ldarg.1
    IL_0015: ldarg.2
    IL_0016: box !!0  /*0x1B00009D*/
    IL_001b: callvirt void System.Collections.Generic.Dictionary<string, object>::set_Item(!0,!1)  /*0x0A000530*/
    IL_0020: ret
    IL_0021: ldarg.0
    IL_0022: ldfld Dictionary<string, object> MatchSave::savedEntities  /*0x04000F91*/
    IL_0027: ldarg.1
    IL_0028: ldarg.2
    IL_0029: box !!0  /*0x1B00009D*/
    IL_002e: callvirt void System.Collections.Generic.Dictionary<string, object>::Add(!0,!1)  /*0x0A000531*/
    IL_0033: ret

  .method MatchSave::ConvertObjectDataToStrings()  // token 0x06000D03 rva 0x3b520 attrs Public, HideBySig
    // code size 514 (0x202), max stack 3, init locals
    .locals ([0] Dictionary.Enumerator<string, object>, [1] KeyValuePair<string, object>, [2] List.Enumerator<Equippable>, [3] Equippable)
    IL_0000: ldarg.0
    IL_0001: call void MatchSave::FetchLoadout()  /*0x06000D06*/
    IL_0006: ldarg.0
    IL_0007: ldfld List<MatchSave.SerializableDictionaryValue<string>> MatchSave::stringsToSerialize  /*0x04000F93*/
    IL_000c: callvirt void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<string>>::Clear()  /*0x0A000532*/
    IL_0011: ldarg.0
    IL_0012: ldfld List<MatchSave.SerializableDictionaryValue<bool>> MatchSave::boolsToSerialize  /*0x04000F95*/
    IL_0017: callvirt void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<bool>>::Clear()  /*0x0A000533*/
    IL_001c: ldarg.0
    IL_001d: ldfld List<MatchSave.SerializableDictionaryValue<int>> MatchSave::intsToSerialize  /*0x04000F94*/
    IL_0022: callvirt void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<int>>::Clear()  /*0x0A000534*/
    IL_0027: ldarg.0
    IL_0028: ldfld List<MatchSave.SerializableDictionaryValue<float>> MatchSave::floatsToSerialize  /*0x04000F96*/
    IL_002d: callvirt void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<float>>::Clear()  /*0x0A000535*/
    IL_0032: ldarg.0
    IL_0033: ldfld List<MatchSave.SerializableDictionaryValue<int[]>> MatchSave::intArraysToSerialize  /*0x04000F97*/
    IL_0038: callvirt void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<int[]>>::Clear()  /*0x0A000536*/
    IL_003d: ldarg.0
    IL_003e: ldfld List<MatchSave.SerializableDictionaryValue<TagManager.ETag[]>> MatchSave::tagArraysToSerialize  /*0x04000F98*/
    IL_0043: callvirt void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<TagManager.ETag[]>>::Clear()  /*0x0A000537*/
    IL_0048: ldarg.0
    IL_0049: ldfld Dictionary<string, object> MatchSave::savedEntities  /*0x04000F91*/
    IL_004e: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<string, object>::GetEnumerator()  /*0x0A000538*/
    IL_0053: stloc.0
    IL_0054: br IL_019a
    IL_0059: ldloca.s 0
    IL_005b: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<string, object>::get_Current()  /*0x0A000539*/
    IL_0060: stloc.1
    IL_0061: ldloca.s 1
    IL_0063: call !1 System.Collections.Generic.KeyValuePair<string, object>::get_Value()  /*0x0A00053A*/
    IL_0068: isinst System.String  /*0x0100001D*/
    IL_006d: brfalse.s IL_0097
    IL_006f: ldarg.0
    IL_0070: ldfld List<MatchSave.SerializableDictionaryValue<string>> MatchSave::stringsToSerialize  /*0x04000F93*/
    IL_0075: ldloca.s 1
    IL_0077: call !0 System.Collections.Generic.KeyValuePair<string, object>::get_Key()  /*0x0A00053B*/
    IL_007c: ldloca.s 1
    IL_007e: call !1 System.Collections.Generic.KeyValuePair<string, object>::get_Value()  /*0x0A00053A*/
    IL_0083: castclass System.String  /*0x0100001D*/
    IL_0088: newobj void MatchSave.SerializableDictionaryValue<string>::.ctor(string,!0)  /*0x0A00053C*/
    IL_008d: callvirt void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<string>>::Add(!0)  /*0x0A00053D*/
    IL_0092: br IL_019a
    IL_0097: ldloca.s 1
    IL_0099: call !1 System.Collections.Generic.KeyValuePair<string, object>::get_Value()  /*0x0A00053A*/
    IL_009e: isinst System.Int32  /*0x01000026*/
    IL_00a3: brfalse.s IL_00cd
    IL_00a5: ldarg.0
    IL_00a6: ldfld List<MatchSave.SerializableDictionaryValue<int>> MatchSave::intsToSerialize  /*0x04000F94*/
    IL_00ab: ldloca.s 1
    IL_00ad: call !0 System.Collections.Generic.KeyValuePair<string, object>::get_Key()  /*0x0A00053B*/
    IL_00b2: ldloca.s 1
    IL_00b4: call !1 System.Collections.Generic.KeyValuePair<string, object>::get_Value()  /*0x0A00053A*/
    IL_00b9: unbox.any System.Int32  /*0x01000026*/
    IL_00be: newobj void MatchSave.SerializableDictionaryValue<int>::.ctor(string,!0)  /*0x0A00053E*/
    IL_00c3: callvirt void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<int>>::Add(!0)  /*0x0A00053F*/
    IL_00c8: br IL_019a
    IL_00cd: ldloca.s 1
    IL_00cf: call !1 System.Collections.Generic.KeyValuePair<string, object>::get_Value()  /*0x0A00053A*/
    IL_00d4: isinst System.Boolean  /*0x01000106*/
    IL_00d9: brfalse.s IL_0103
    IL_00db: ldarg.0
    IL_00dc: ldfld List<MatchSave.SerializableDictionaryValue<bool>> MatchSave::boolsToSerialize  /*0x04000F95*/
    IL_00e1: ldloca.s 1
    IL_00e3: call !0 System.Collections.Generic.KeyValuePair<string, object>::get_Key()  /*0x0A00053B*/
    IL_00e8: ldloca.s 1
    IL_00ea: call !1 System.Collections.Generic.KeyValuePair<string, object>::get_Value()  /*0x0A00053A*/
    IL_00ef: unbox.any System.Boolean  /*0x01000106*/
    IL_00f4: newobj void MatchSave.SerializableDictionaryValue<bool>::.ctor(string,!0)  /*0x0A000540*/
    IL_00f9: callvirt void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<bool>>::Add(!0)  /*0x0A000541*/
    IL_00fe: br IL_019a
    IL_0103: ldloca.s 1
    IL_0105: call !1 System.Collections.Generic.KeyValuePair<string, object>::get_Value()  /*0x0A00053A*/
    IL_010a: isinst System.Single  /*0x01000052*/
    IL_010f: brfalse.s IL_0136
    IL_0111: ldarg.0
    IL_0112: ldfld List<MatchSave.SerializableDictionaryValue<float>> MatchSave::floatsToSerialize  /*0x04000F96*/
    IL_0117: ldloca.s 1
    IL_0119: call !0 System.Collections.Generic.KeyValuePair<string, object>::get_Key()  /*0x0A00053B*/
    IL_011e: ldloca.s 1
    IL_0120: call !1 System.Collections.Generic.KeyValuePair<string, object>::get_Value()  /*0x0A00053A*/
    IL_0125: unbox.any System.Single  /*0x01000052*/
    IL_012a: newobj void MatchSave.SerializableDictionaryValue<float>::.ctor(string,!0)  /*0x0A000542*/
    IL_012f: callvirt void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<float>>::Add(!0)  /*0x0A000543*/
    IL_0134: br.s IL_019a
    IL_0136: ldloca.s 1
    IL_0138: call !1 System.Collections.Generic.KeyValuePair<string, object>::get_Value()  /*0x0A00053A*/
    IL_013d: isinst int[]  /*0x1B0000F1*/
    IL_0142: brfalse.s IL_0169
    IL_0144: ldarg.0
    IL_0145: ldfld List<MatchSave.SerializableDictionaryValue<int[]>> MatchSave::intArraysToSerialize  /*0x04000F97*/
    IL_014a: ldloca.s 1
    IL_014c: call !0 System.Collections.Generic.KeyValuePair<string, object>::get_Key()  /*0x0A00053B*/
    IL_0151: ldloca.s 1
    IL_0153: call !1 System.Collections.Generic.KeyValuePair<string, object>::get_Value()  /*0x0A00053A*/
    IL_0158: castclass int[]  /*0x1B0000F1*/
    IL_015d: newobj void MatchSave.SerializableDictionaryValue<int[]>::.ctor(string,!0)  /*0x0A000544*/
    IL_0162: callvirt void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<int[]>>::Add(!0)  /*0x0A000545*/
    IL_0167: br.s IL_019a
    IL_0169: ldloca.s 1
    IL_016b: call !1 System.Collections.Generic.KeyValuePair<string, object>::get_Value()  /*0x0A00053A*/
    IL_0170: isinst TagManager.ETag[]  /*0x1B0000F3*/
    IL_0175: brfalse.s IL_019a
    IL_0177: ldarg.0
    IL_0178: ldfld List<MatchSave.SerializableDictionaryValue<TagManager.ETag[]>> MatchSave::tagArraysToSerialize  /*0x04000F98*/
    IL_017d: ldloca.s 1
    IL_017f: call !0 System.Collections.Generic.KeyValuePair<string, object>::get_Key()  /*0x0A00053B*/
    IL_0184: ldloca.s 1
    IL_0186: call !1 System.Collections.Generic.KeyValuePair<string, object>::get_Value()  /*0x0A00053A*/
    IL_018b: castclass TagManager.ETag[]  /*0x1B0000F3*/
    IL_0190: newobj void MatchSave.SerializableDictionaryValue<TagManager.ETag[]>::.ctor(string,!0)  /*0x0A000546*/
    IL_0195: callvirt void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<TagManager.ETag[]>>::Add(!0)  /*0x0A000547*/
    IL_019a: ldloca.s 0
    IL_019c: call bool System.Collections.Generic.Dictionary.Enumerator<string, object>::MoveNext()  /*0x0A000548*/
    IL_01a1: brtrue IL_0059
    IL_01a6: leave.s IL_01b6
    IL_01a8: ldloca.s 0
    IL_01aa: constrained. System.Collections.Generic.Dictionary.Enumerator<string, object>  /*0x1B0000EB*/
    IL_01b0: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01b5: endfinally
    IL_01b6: ldarg.0
    IL_01b7: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_01bc: stfld List<string> MatchSave::currentLoadoutAsString  /*0x04000F99*/
    IL_01c1: ldarg.0
    IL_01c2: ldfld List<Equippable> MatchSave::currentLoadout  /*0x04000F92*/
    IL_01c7: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_01cc: stloc.2
    IL_01cd: br.s IL_01e8
    IL_01cf: ldloca.s 2
    IL_01d1: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_01d6: stloc.3
    IL_01d7: ldarg.0
    IL_01d8: ldfld List<string> MatchSave::currentLoadoutAsString  /*0x04000F99*/
    IL_01dd: ldloc.3
    IL_01de: ldfld string Equippable::displayName  /*0x04000E2B*/
    IL_01e3: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_01e8: ldloca.s 2
    IL_01ea: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_01ef: brtrue.s IL_01cf
    IL_01f1: leave.s IL_0201
    IL_01f3: ldloca.s 2
    IL_01f5: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_01fb: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0200: endfinally
    IL_0201: ret
    .try IL_0054-IL_01a8 finally handler IL_01a8-IL_01b6
    .try IL_01cd-IL_01f3 finally handler IL_01f3-IL_0201

  .method MatchSave::ConvertStringsToObjectData()  // token 0x06000D04 rva 0x3b764 attrs Public, HideBySig
    // code size 623 (0x26f), max stack 3, init locals
    .locals ([0] List.Enumerator<MatchSave.SerializableDictionaryValue<string>>, [1] MatchSave.SerializableDictionaryValue<string>, [2] List.Enumerator<MatchSave.SerializableDictionaryValue<int>>, [3] MatchSave.SerializableDictionaryValue<int>, [4] List.Enumerator<MatchSave.SerializableDictionaryValue<float>>, [5] MatchSave.SerializableDictionaryValue<float>, [6] List.Enumerator<MatchSave.SerializableDictionaryValue<bool>>, [7] MatchSave.SerializableDictionaryValue<bool>, [8] List.Enumerator<MatchSave.SerializableDictionaryValue<int[]>>, [9] MatchSave.SerializableDictionaryValue<int[]>, [10] List.Enumerator<MatchSave.SerializableDictionaryValue<TagManager.ETag[]>>, [11] MatchSave.SerializableDictionaryValue<TagManager.ETag[]>, [12] List.Enumerator<string>, [13] string, [14] List.Enumerator<Equippable>, [15] Equippable)
    IL_0000: ldarg.0
    IL_0001: ldfld Dictionary<string, object> MatchSave::savedEntities  /*0x04000F91*/
    IL_0006: callvirt void System.Collections.Generic.Dictionary<string, object>::Clear()  /*0x0A000549*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<MatchSave.SerializableDictionaryValue<string>> MatchSave::stringsToSerialize  /*0x04000F93*/
    IL_0011: callvirt List.Enumerator<!0> System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<string>>::GetEnumerator()  /*0x0A00054A*/
    IL_0016: stloc.0
    IL_0017: br.s IL_0038
    IL_0019: ldloca.s 0
    IL_001b: call !0 System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<string>>::get_Current()  /*0x0A00054B*/
    IL_0020: stloc.1
    IL_0021: ldarg.0
    IL_0022: ldfld Dictionary<string, object> MatchSave::savedEntities  /*0x04000F91*/
    IL_0027: ldloc.1
    IL_0028: ldfld string MatchSave.SerializableDictionaryValue<string>::key  /*0x0A00054C*/
    IL_002d: ldloc.1
    IL_002e: ldfld !0 MatchSave.SerializableDictionaryValue<string>::value  /*0x0A00054D*/
    IL_0033: callvirt void System.Collections.Generic.Dictionary<string, object>::Add(!0,!1)  /*0x0A000531*/
    IL_0038: ldloca.s 0
    IL_003a: call bool System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<string>>::MoveNext()  /*0x0A00054E*/
    IL_003f: brtrue.s IL_0019
    IL_0041: leave.s IL_0051
    IL_0043: ldloca.s 0
    IL_0045: constrained. System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<string>>  /*0x1B0000F5*/
    IL_004b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0050: endfinally
    IL_0051: ldarg.0
    IL_0052: ldfld List<MatchSave.SerializableDictionaryValue<int>> MatchSave::intsToSerialize  /*0x04000F94*/
    IL_0057: callvirt List.Enumerator<!0> System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<int>>::GetEnumerator()  /*0x0A00054F*/
    IL_005c: stloc.2
    IL_005d: br.s IL_0083
    IL_005f: ldloca.s 2
    IL_0061: call !0 System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<int>>::get_Current()  /*0x0A000550*/
    IL_0066: stloc.3
    IL_0067: ldarg.0
    IL_0068: ldfld Dictionary<string, object> MatchSave::savedEntities  /*0x04000F91*/
    IL_006d: ldloc.3
    IL_006e: ldfld string MatchSave.SerializableDictionaryValue<int>::key  /*0x0A000551*/
    IL_0073: ldloc.3
    IL_0074: ldfld !0 MatchSave.SerializableDictionaryValue<int>::value  /*0x0A000552*/
    IL_0079: box System.Int32  /*0x01000026*/
    IL_007e: callvirt void System.Collections.Generic.Dictionary<string, object>::Add(!0,!1)  /*0x0A000531*/
    IL_0083: ldloca.s 2
    IL_0085: call bool System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<int>>::MoveNext()  /*0x0A000553*/
    IL_008a: brtrue.s IL_005f
    IL_008c: leave.s IL_009c
    IL_008e: ldloca.s 2
    IL_0090: constrained. System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<int>>  /*0x1B0000F6*/
    IL_0096: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_009b: endfinally
    IL_009c: ldarg.0
    IL_009d: ldfld List<MatchSave.SerializableDictionaryValue<float>> MatchSave::floatsToSerialize  /*0x04000F96*/
    IL_00a2: callvirt List.Enumerator<!0> System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<float>>::GetEnumerator()  /*0x0A000554*/
    IL_00a7: stloc.s 4
    IL_00a9: br.s IL_00d2
    IL_00ab: ldloca.s 4
    IL_00ad: call !0 System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<float>>::get_Current()  /*0x0A000555*/
    IL_00b2: stloc.s 5
    IL_00b4: ldarg.0
    IL_00b5: ldfld Dictionary<string, object> MatchSave::savedEntities  /*0x04000F91*/
    IL_00ba: ldloc.s 5
    IL_00bc: ldfld string MatchSave.SerializableDictionaryValue<float>::key  /*0x0A000556*/
    IL_00c1: ldloc.s 5
    IL_00c3: ldfld !0 MatchSave.SerializableDictionaryValue<float>::value  /*0x0A000557*/
    IL_00c8: box System.Single  /*0x01000052*/
    IL_00cd: callvirt void System.Collections.Generic.Dictionary<string, object>::Add(!0,!1)  /*0x0A000531*/
    IL_00d2: ldloca.s 4
    IL_00d4: call bool System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<float>>::MoveNext()  /*0x0A000558*/
    IL_00d9: brtrue.s IL_00ab
    IL_00db: leave.s IL_00eb
    IL_00dd: ldloca.s 4
    IL_00df: constrained. System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<float>>  /*0x1B0000F7*/
    IL_00e5: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00ea: endfinally
    IL_00eb: ldarg.0
    IL_00ec: ldfld List<MatchSave.SerializableDictionaryValue<bool>> MatchSave::boolsToSerialize  /*0x04000F95*/
    IL_00f1: callvirt List.Enumerator<!0> System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<bool>>::GetEnumerator()  /*0x0A000559*/
    IL_00f6: stloc.s 6
    IL_00f8: br.s IL_0121
    IL_00fa: ldloca.s 6
    IL_00fc: call !0 System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<bool>>::get_Current()  /*0x0A00055A*/
    IL_0101: stloc.s 7
    IL_0103: ldarg.0
    IL_0104: ldfld Dictionary<string, object> MatchSave::savedEntities  /*0x04000F91*/
    IL_0109: ldloc.s 7
    IL_010b: ldfld string MatchSave.SerializableDictionaryValue<bool>::key  /*0x0A00055B*/
    IL_0110: ldloc.s 7
    IL_0112: ldfld !0 MatchSave.SerializableDictionaryValue<bool>::value  /*0x0A00055C*/
    IL_0117: box System.Boolean  /*0x01000106*/
    IL_011c: callvirt void System.Collections.Generic.Dictionary<string, object>::Add(!0,!1)  /*0x0A000531*/
    IL_0121: ldloca.s 6
    IL_0123: call bool System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<bool>>::MoveNext()  /*0x0A00055D*/
    IL_0128: brtrue.s IL_00fa
    IL_012a: leave.s IL_013a
    IL_012c: ldloca.s 6
    IL_012e: constrained. System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<bool>>  /*0x1B0000F8*/
    IL_0134: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0139: endfinally
    IL_013a: ldarg.0
    IL_013b: ldfld List<MatchSave.SerializableDictionaryValue<int[]>> MatchSave::intArraysToSerialize  /*0x04000F97*/
    IL_0140: callvirt List.Enumerator<!0> System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<int[]>>::GetEnumerator()  /*0x0A00055E*/
    IL_0145: stloc.s 8
    IL_0147: br.s IL_016b
    IL_0149: ldloca.s 8
    IL_014b: call !0 System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<int[]>>::get_Current()  /*0x0A00055F*/
    IL_0150: stloc.s 9
    IL_0152: ldarg.0
    IL_0153: ldfld Dictionary<string, object> MatchSave::savedEntities  /*0x04000F91*/
    IL_0158: ldloc.s 9
    IL_015a: ldfld string MatchSave.SerializableDictionaryValue<int[]>::key  /*0x0A000560*/
    IL_015f: ldloc.s 9
    IL_0161: ldfld !0 MatchSave.SerializableDictionaryValue<int[]>::value  /*0x0A000561*/
    IL_0166: callvirt void System.Collections.Generic.Dictionary<string, object>::Add(!0,!1)  /*0x0A000531*/
    IL_016b: ldloca.s 8
    IL_016d: call bool System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<int[]>>::MoveNext()  /*0x0A000562*/
    IL_0172: brtrue.s IL_0149
    IL_0174: leave.s IL_0184
    IL_0176: ldloca.s 8
    IL_0178: constrained. System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<int[]>>  /*0x1B0000F9*/
    IL_017e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0183: endfinally
    IL_0184: ldarg.0
    IL_0185: ldfld List<MatchSave.SerializableDictionaryValue<TagManager.ETag[]>> MatchSave::tagArraysToSerialize  /*0x04000F98*/
    IL_018a: callvirt List.Enumerator<!0> System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<TagManager.ETag[]>>::GetEnumerator()  /*0x0A000563*/
    IL_018f: stloc.s 10
    IL_0191: br.s IL_01b5
    IL_0193: ldloca.s 10
    IL_0195: call !0 System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<TagManager.ETag[]>>::get_Current()  /*0x0A000564*/
    IL_019a: stloc.s 11
    IL_019c: ldarg.0
    IL_019d: ldfld Dictionary<string, object> MatchSave::savedEntities  /*0x04000F91*/
    IL_01a2: ldloc.s 11
    IL_01a4: ldfld string MatchSave.SerializableDictionaryValue<TagManager.ETag[]>::key  /*0x0A000565*/
    IL_01a9: ldloc.s 11
    IL_01ab: ldfld !0 MatchSave.SerializableDictionaryValue<TagManager.ETag[]>::value  /*0x0A000566*/
    IL_01b0: callvirt void System.Collections.Generic.Dictionary<string, object>::Add(!0,!1)  /*0x0A000531*/
    IL_01b5: ldloca.s 10
    IL_01b7: call bool System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<TagManager.ETag[]>>::MoveNext()  /*0x0A000567*/
    IL_01bc: brtrue.s IL_0193
    IL_01be: leave.s IL_01ce
    IL_01c0: ldloca.s 10
    IL_01c2: constrained. System.Collections.Generic.List.Enumerator<MatchSave.SerializableDictionaryValue<TagManager.ETag[]>>  /*0x1B0000FA*/
    IL_01c8: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01cd: endfinally
    IL_01ce: ldarg.0
    IL_01cf: newobj void System.Collections.Generic.List<Equippable>::.ctor()  /*0x0A0003D9*/
    IL_01d4: stfld List<Equippable> MatchSave::currentLoadout  /*0x04000F92*/
    IL_01d9: ldarg.0
    IL_01da: ldfld List<string> MatchSave::currentLoadoutAsString  /*0x04000F99*/
    IL_01df: callvirt List.Enumerator<!0> System.Collections.Generic.List<string>::GetEnumerator()  /*0x0A0002EB*/
    IL_01e4: stloc.s 12
    IL_01e6: br.s IL_024f
    IL_01e8: ldloca.s 12
    IL_01ea: call !0 System.Collections.Generic.List.Enumerator<string>::get_Current()  /*0x0A0002EC*/
    IL_01ef: stloc.s 13
    IL_01f1: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_01f6: ldfld List<Equippable> PerkManager::allEquippables  /*0x04000BE8*/
    IL_01fb: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_0200: stloc.s 14
    IL_0202: br.s IL_0236
    IL_0204: ldloca.s 14
    IL_0206: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_020b: stloc.s 15
    IL_020d: ldloc.s 15
    IL_020f: ldnull
    IL_0210: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0215: brfalse.s IL_0236
    IL_0217: ldloc.s 15
    IL_0219: ldfld string Equippable::displayName  /*0x04000E2B*/
    IL_021e: ldloc.s 13
    IL_0220: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0225: brfalse.s IL_0236
    IL_0227: ldarg.0
    IL_0228: ldfld List<Equippable> MatchSave::currentLoadout  /*0x04000F92*/
    IL_022d: ldloc.s 15
    IL_022f: callvirt void System.Collections.Generic.List<Equippable>::Add(!0)  /*0x0A0003D0*/
    IL_0234: leave.s IL_024f
    IL_0236: ldloca.s 14
    IL_0238: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_023d: brtrue.s IL_0204
    IL_023f: leave.s IL_024f
    IL_0241: ldloca.s 14
    IL_0243: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_0249: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_024e: endfinally
    IL_024f: ldloca.s 12
    IL_0251: call bool System.Collections.Generic.List.Enumerator<string>::MoveNext()  /*0x0A0002ED*/
    IL_0256: brtrue.s IL_01e8
    IL_0258: leave.s IL_0268
    IL_025a: ldloca.s 12
    IL_025c: constrained. System.Collections.Generic.List.Enumerator<string>  /*0x1B000087*/
    IL_0262: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0267: endfinally
    IL_0268: ldarg.0
    IL_0269: call void MatchSave::ApplyLoadout()  /*0x06000D05*/
    IL_026e: ret
    .try IL_0017-IL_0043 finally handler IL_0043-IL_0051
    .try IL_005d-IL_008e finally handler IL_008e-IL_009c
    .try IL_00a9-IL_00dd finally handler IL_00dd-IL_00eb
    .try IL_00f8-IL_012c finally handler IL_012c-IL_013a
    .try IL_0147-IL_0176 finally handler IL_0176-IL_0184
    .try IL_0191-IL_01c0 finally handler IL_01c0-IL_01ce
    .try IL_0202-IL_0241 finally handler IL_0241-IL_024f
    .try IL_01e6-IL_025a finally handler IL_025a-IL_0268

  .method MatchSave::ApplyLoadout()  // token 0x06000D05 rva 0x3ba44 attrs Public, HideBySig
    // code size 58 (0x3a), max stack 2, init locals
    .locals ([0] List.Enumerator<Equippable>)
    IL_0000: call void PerkManager::ClearAllEquipped()  /*0x060009A6*/
    IL_0005: ldarg.0
    IL_0006: ldfld List<Equippable> MatchSave::currentLoadout  /*0x04000F92*/
    IL_000b: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_0010: stloc.0
    IL_0011: br.s IL_0020
    IL_0013: ldloca.s 0
    IL_0015: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_001a: ldc.i4.1
    IL_001b: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_0020: ldloca.s 0
    IL_0022: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_0027: brtrue.s IL_0013
    IL_0029: leave.s IL_0039
    IL_002b: ldloca.s 0
    IL_002d: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_0033: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0038: endfinally
    IL_0039: ret
    .try IL_0011-IL_002b finally handler IL_002b-IL_0039

  .method MatchSave::FetchLoadout()  // token 0x06000D06 rva 0x3ba9c attrs Public, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<Equippable>::.ctor()  /*0x0A0003D9*/
    IL_0006: stfld List<Equippable> MatchSave::currentLoadout  /*0x04000F92*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<Equippable> MatchSave::currentLoadout  /*0x04000F92*/
    IL_0011: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0016: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_001b: callvirt void System.Collections.Generic.List<Equippable>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0003CC*/
    IL_0020: ret

  .method MatchSave::.ctor()  // token 0x06000D07 rva 0x3bac0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 95 (0x5f), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.Dictionary<string, object>::.ctor()  /*0x0A000568*/
    IL_0006: stfld Dictionary<string, object> MatchSave::savedEntities  /*0x04000F91*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<Equippable>::.ctor()  /*0x0A0003D9*/
    IL_0011: stfld List<Equippable> MatchSave::currentLoadout  /*0x04000F92*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<string>>::.ctor()  /*0x0A000569*/
    IL_001c: stfld List<MatchSave.SerializableDictionaryValue<string>> MatchSave::stringsToSerialize  /*0x04000F93*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<int>>::.ctor()  /*0x0A00056A*/
    IL_0027: stfld List<MatchSave.SerializableDictionaryValue<int>> MatchSave::intsToSerialize  /*0x04000F94*/
    IL_002c: ldarg.0
    IL_002d: newobj void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<bool>>::.ctor()  /*0x0A00056B*/
    IL_0032: stfld List<MatchSave.SerializableDictionaryValue<bool>> MatchSave::boolsToSerialize  /*0x04000F95*/
    IL_0037: ldarg.0
    IL_0038: newobj void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<float>>::.ctor()  /*0x0A00056C*/
    IL_003d: stfld List<MatchSave.SerializableDictionaryValue<float>> MatchSave::floatsToSerialize  /*0x04000F96*/
    IL_0042: ldarg.0
    IL_0043: newobj void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<int[]>>::.ctor()  /*0x0A00056D*/
    IL_0048: stfld List<MatchSave.SerializableDictionaryValue<int[]>> MatchSave::intArraysToSerialize  /*0x04000F97*/
    IL_004d: ldarg.0
    IL_004e: newobj void System.Collections.Generic.List<MatchSave.SerializableDictionaryValue<TagManager.ETag[]>>::.ctor()  /*0x0A00056E*/
    IL_0053: stfld List<MatchSave.SerializableDictionaryValue<TagManager.ETag[]>> MatchSave::tagArraysToSerialize  /*0x04000F98*/
    IL_0058: ldarg.0
    IL_0059: call void System.Object::.ctor()  /*0x0A000038*/
    IL_005e: ret

// ===== MatchSave/SerializableDictionaryValue`1  (token 0x0200025F) =====
  .method MatchSave.SerializableDictionaryValue::.ctor(string,!0)  // token 0x06000D08 rva 0x3bb2b attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld string MatchSave.SerializableDictionaryValue<!0>::key  /*0x0A00056F*/
    IL_000d: ldarg.0
    IL_000e: ldarg.2
    IL_000f: stfld !0 MatchSave.SerializableDictionaryValue<!0>::value  /*0x0A000570*/
    IL_0014: ret

