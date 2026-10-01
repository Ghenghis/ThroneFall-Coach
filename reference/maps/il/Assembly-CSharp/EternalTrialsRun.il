// ===== EternalTrialsRun  (token 0x02000146) =====
  .method EternalTrialsRun::get_StageBonusScore()  // token 0x060006FB rva 0x1ec6b attrs Public, HideBySig, SpecialName
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsRun::stage  /*0x0400084F*/
    IL_0006: ldarg.0
    IL_0007: ldfld int EternalTrialsRun::stage  /*0x0400084F*/
    IL_000c: mul
    IL_000d: ldc.i4 1000
    IL_0012: mul
    IL_0013: ret

  .method EternalTrialsRun::get_OverallScore()  // token 0x060006FC rva 0x1ec80 attrs Public, HideBySig, SpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int EternalTrialsRun::score  /*0x04000850*/
    IL_0006: ldarg.0
    IL_0007: call int EternalTrialsRun::get_StageBonusScore()  /*0x060006FB*/
    IL_000c: add
    IL_000d: ret

  .method EternalTrialsRun::.ctor(string,int,int,bool)  // token 0x060006FD rva 0x1ec90 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 102 (0x66), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldstr "Nordfels"
    IL_0006: stfld string EternalTrialsRun::currentMap  /*0x0400084E*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<EquippablePerk>::.ctor()  /*0x0A0002E1*/
    IL_0011: stfld List<EquippablePerk> EternalTrialsRun::acquiredPerks  /*0x04000854*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<EquippablePerk>::.ctor()  /*0x0A0002E1*/
    IL_001c: stfld List<EquippablePerk> EternalTrialsRun::disabledPerks  /*0x04000855*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_0027: stfld List<string> EternalTrialsRun::acquiredPerkNamesForSaving  /*0x04000857*/
    IL_002c: ldarg.0
    IL_002d: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_0032: stfld List<string> EternalTrialsRun::disabledPerkNamesForSaving  /*0x04000858*/
    IL_0037: ldarg.0
    IL_0038: ldstr ""
    IL_003d: stfld string EternalTrialsRun::currentWeaponNameForSaving  /*0x04000859*/
    IL_0042: ldarg.0
    IL_0043: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0048: ldarg.0
    IL_0049: ldarg.2
    IL_004a: stfld int EternalTrialsRun::currentStageSeed  /*0x0400084D*/
    IL_004f: ldarg.0
    IL_0050: ldarg.1
    IL_0051: stfld string EternalTrialsRun::currentMap  /*0x0400084E*/
    IL_0056: ldarg.0
    IL_0057: ldarg.3
    IL_0058: stfld int EternalTrialsRun::stage  /*0x0400084F*/
    IL_005d: ldarg.0
    IL_005e: ldarg.s 4
    IL_0060: stfld bool EternalTrialsRun::runComplete  /*0x04000851*/
    IL_0065: ret

  .method EternalTrialsRun::LoadoutToStringsForSaving()  // token 0x060006FE rva 0x1ed04 attrs Public, HideBySig
    // code size 193 (0xc1), max stack 2, init locals
    .locals ([0] List.Enumerator<EquippablePerk>, [1] EquippablePerk, [2] EquippablePerk)
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_0006: stfld List<string> EternalTrialsRun::acquiredPerkNamesForSaving  /*0x04000857*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_0011: stfld List<string> EternalTrialsRun::disabledPerkNamesForSaving  /*0x04000858*/
    IL_0016: ldarg.0
    IL_0017: ldstr ""
    IL_001c: stfld string EternalTrialsRun::currentWeaponNameForSaving  /*0x04000859*/
    IL_0021: ldarg.0
    IL_0022: ldfld EquippableWeapon EternalTrialsRun::currentWeapon  /*0x04000856*/
    IL_0027: ldnull
    IL_0028: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002d: brfalse.s IL_0040
    IL_002f: ldarg.0
    IL_0030: ldarg.0
    IL_0031: ldfld EquippableWeapon EternalTrialsRun::currentWeapon  /*0x04000856*/
    IL_0036: ldfld string Equippable::displayName  /*0x04000E2B*/
    IL_003b: stfld string EternalTrialsRun::currentWeaponNameForSaving  /*0x04000859*/
    IL_0040: ldarg.0
    IL_0041: ldfld List<EquippablePerk> EternalTrialsRun::acquiredPerks  /*0x04000854*/
    IL_0046: callvirt List.Enumerator<!0> System.Collections.Generic.List<EquippablePerk>::GetEnumerator()  /*0x0A0002DB*/
    IL_004b: stloc.0
    IL_004c: br.s IL_0067
    IL_004e: ldloca.s 0
    IL_0050: call !0 System.Collections.Generic.List.Enumerator<EquippablePerk>::get_Current()  /*0x0A0002DC*/
    IL_0055: stloc.1
    IL_0056: ldarg.0
    IL_0057: ldfld List<string> EternalTrialsRun::acquiredPerkNamesForSaving  /*0x04000857*/
    IL_005c: ldloc.1
    IL_005d: ldfld string Equippable::displayName  /*0x04000E2B*/
    IL_0062: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0067: ldloca.s 0
    IL_0069: call bool System.Collections.Generic.List.Enumerator<EquippablePerk>::MoveNext()  /*0x0A0002DE*/
    IL_006e: brtrue.s IL_004e
    IL_0070: leave.s IL_0080
    IL_0072: ldloca.s 0
    IL_0074: constrained. System.Collections.Generic.List.Enumerator<EquippablePerk>  /*0x1B000082*/
    IL_007a: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_007f: endfinally
    IL_0080: ldarg.0
    IL_0081: ldfld List<EquippablePerk> EternalTrialsRun::disabledPerks  /*0x04000855*/
    IL_0086: callvirt List.Enumerator<!0> System.Collections.Generic.List<EquippablePerk>::GetEnumerator()  /*0x0A0002DB*/
    IL_008b: stloc.0
    IL_008c: br.s IL_00a7
    IL_008e: ldloca.s 0
    IL_0090: call !0 System.Collections.Generic.List.Enumerator<EquippablePerk>::get_Current()  /*0x0A0002DC*/
    IL_0095: stloc.2
    IL_0096: ldarg.0
    IL_0097: ldfld List<string> EternalTrialsRun::disabledPerkNamesForSaving  /*0x04000858*/
    IL_009c: ldloc.2
    IL_009d: ldfld string Equippable::displayName  /*0x04000E2B*/
    IL_00a2: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_00a7: ldloca.s 0
    IL_00a9: call bool System.Collections.Generic.List.Enumerator<EquippablePerk>::MoveNext()  /*0x0A0002DE*/
    IL_00ae: brtrue.s IL_008e
    IL_00b0: leave.s IL_00c0
    IL_00b2: ldloca.s 0
    IL_00b4: constrained. System.Collections.Generic.List.Enumerator<EquippablePerk>  /*0x1B000082*/
    IL_00ba: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00bf: endfinally
    IL_00c0: ret
    .try IL_004c-IL_0072 finally handler IL_0072-IL_0080
    .try IL_008c-IL_00b2 finally handler IL_00b2-IL_00c0

  .method EternalTrialsRun::SavedStringsToLoadout()  // token 0x060006FF rva 0x1edf0 attrs Public, HideBySig
    // code size 455 (0x1c7), max stack 2, init locals
    .locals ([0] List<EquippableWeapon>, [1] List<EquippablePerk>, [2] List.Enumerator<Equippable>, [3] Equippable, [4] List.Enumerator<EquippableWeapon>, [5] EquippableWeapon, [6] List.Enumerator<string>, [7] string, [8] List.Enumerator<EquippablePerk>, [9] EquippablePerk, [10] string, [11] EquippablePerk)
    IL_0000: ldarg.0
    IL_0001: ldnull
    IL_0002: stfld EquippableWeapon EternalTrialsRun::currentWeapon  /*0x04000856*/
    IL_0007: ldarg.0
    IL_0008: newobj void System.Collections.Generic.List<EquippablePerk>::.ctor()  /*0x0A0002E1*/
    IL_000d: stfld List<EquippablePerk> EternalTrialsRun::acquiredPerks  /*0x04000854*/
    IL_0012: ldarg.0
    IL_0013: newobj void System.Collections.Generic.List<EquippablePerk>::.ctor()  /*0x0A0002E1*/
    IL_0018: stfld List<EquippablePerk> EternalTrialsRun::disabledPerks  /*0x04000855*/
    IL_001d: newobj void System.Collections.Generic.List<EquippableWeapon>::.ctor()  /*0x0A0002E2*/
    IL_0022: stloc.0
    IL_0023: newobj void System.Collections.Generic.List<EquippablePerk>::.ctor()  /*0x0A0002E1*/
    IL_0028: stloc.1
    IL_0029: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_002e: ldfld List<Equippable> PerkManager::allEquippables  /*0x04000BE8*/
    IL_0033: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_0038: stloc.2
    IL_0039: br.s IL_006b
    IL_003b: ldloca.s 2
    IL_003d: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_0042: stloc.3
    IL_0043: ldloc.3
    IL_0044: isinst EquippableWeapon  /*0x0200021B*/
    IL_0049: brfalse.s IL_0057
    IL_004b: ldloc.0
    IL_004c: ldloc.3
    IL_004d: isinst EquippableWeapon  /*0x0200021B*/
    IL_0052: callvirt void System.Collections.Generic.List<EquippableWeapon>::Add(!0)  /*0x0A0002E5*/
    IL_0057: ldloc.3
    IL_0058: isinst EquippablePerk  /*0x0200021A*/
    IL_005d: brfalse.s IL_006b
    IL_005f: ldloc.1
    IL_0060: ldloc.3
    IL_0061: isinst EquippablePerk  /*0x0200021A*/
    IL_0066: callvirt void System.Collections.Generic.List<EquippablePerk>::Add(!0)  /*0x0A0002E6*/
    IL_006b: ldloca.s 2
    IL_006d: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_0072: brtrue.s IL_003b
    IL_0074: leave.s IL_0084
    IL_0076: ldloca.s 2
    IL_0078: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_007e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0083: endfinally
    IL_0084: ldloc.0
    IL_0085: callvirt List.Enumerator<!0> System.Collections.Generic.List<EquippableWeapon>::GetEnumerator()  /*0x0A0002E8*/
    IL_008a: stloc.s 4
    IL_008c: br.s IL_00b5
    IL_008e: ldloca.s 4
    IL_0090: call !0 System.Collections.Generic.List.Enumerator<EquippableWeapon>::get_Current()  /*0x0A0002E9*/
    IL_0095: stloc.s 5
    IL_0097: ldloc.s 5
    IL_0099: ldfld string Equippable::displayName  /*0x04000E2B*/
    IL_009e: ldarg.0
    IL_009f: ldfld string EternalTrialsRun::currentWeaponNameForSaving  /*0x04000859*/
    IL_00a4: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_00a9: brfalse.s IL_00b5
    IL_00ab: ldarg.0
    IL_00ac: ldloc.s 5
    IL_00ae: stfld EquippableWeapon EternalTrialsRun::currentWeapon  /*0x04000856*/
    IL_00b3: leave.s IL_00ce
    IL_00b5: ldloca.s 4
    IL_00b7: call bool System.Collections.Generic.List.Enumerator<EquippableWeapon>::MoveNext()  /*0x0A0002EA*/
    IL_00bc: brtrue.s IL_008e
    IL_00be: leave.s IL_00ce
    IL_00c0: ldloca.s 4
    IL_00c2: constrained. System.Collections.Generic.List.Enumerator<EquippableWeapon>  /*0x1B000086*/
    IL_00c8: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00cd: endfinally
    IL_00ce: ldarg.0
    IL_00cf: ldfld List<string> EternalTrialsRun::acquiredPerkNamesForSaving  /*0x04000857*/
    IL_00d4: callvirt List.Enumerator<!0> System.Collections.Generic.List<string>::GetEnumerator()  /*0x0A0002EB*/
    IL_00d9: stloc.s 6
    IL_00db: br.s IL_0131
    IL_00dd: ldloca.s 6
    IL_00df: call !0 System.Collections.Generic.List.Enumerator<string>::get_Current()  /*0x0A0002EC*/
    IL_00e4: stloc.s 7
    IL_00e6: ldloc.1
    IL_00e7: callvirt List.Enumerator<!0> System.Collections.Generic.List<EquippablePerk>::GetEnumerator()  /*0x0A0002DB*/
    IL_00ec: stloc.s 8
    IL_00ee: br.s IL_0118
    IL_00f0: ldloca.s 8
    IL_00f2: call !0 System.Collections.Generic.List.Enumerator<EquippablePerk>::get_Current()  /*0x0A0002DC*/
    IL_00f7: stloc.s 9
    IL_00f9: ldloc.s 9
    IL_00fb: ldfld string Equippable::displayName  /*0x04000E2B*/
    IL_0100: ldloc.s 7
    IL_0102: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0107: brfalse.s IL_0118
    IL_0109: ldarg.0
    IL_010a: ldfld List<EquippablePerk> EternalTrialsRun::acquiredPerks  /*0x04000854*/
    IL_010f: ldloc.s 9
    IL_0111: callvirt void System.Collections.Generic.List<EquippablePerk>::Add(!0)  /*0x0A0002E6*/
    IL_0116: leave.s IL_0131
    IL_0118: ldloca.s 8
    IL_011a: call bool System.Collections.Generic.List.Enumerator<EquippablePerk>::MoveNext()  /*0x0A0002DE*/
    IL_011f: brtrue.s IL_00f0
    IL_0121: leave.s IL_0131
    IL_0123: ldloca.s 8
    IL_0125: constrained. System.Collections.Generic.List.Enumerator<EquippablePerk>  /*0x1B000082*/
    IL_012b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0130: endfinally
    IL_0131: ldloca.s 6
    IL_0133: call bool System.Collections.Generic.List.Enumerator<string>::MoveNext()  /*0x0A0002ED*/
    IL_0138: brtrue.s IL_00dd
    IL_013a: leave.s IL_014a
    IL_013c: ldloca.s 6
    IL_013e: constrained. System.Collections.Generic.List.Enumerator<string>  /*0x1B000087*/
    IL_0144: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0149: endfinally
    IL_014a: ldarg.0
    IL_014b: ldfld List<string> EternalTrialsRun::disabledPerkNamesForSaving  /*0x04000858*/
    IL_0150: callvirt List.Enumerator<!0> System.Collections.Generic.List<string>::GetEnumerator()  /*0x0A0002EB*/
    IL_0155: stloc.s 6
    IL_0157: br.s IL_01ad
    IL_0159: ldloca.s 6
    IL_015b: call !0 System.Collections.Generic.List.Enumerator<string>::get_Current()  /*0x0A0002EC*/
    IL_0160: stloc.s 10
    IL_0162: ldloc.1
    IL_0163: callvirt List.Enumerator<!0> System.Collections.Generic.List<EquippablePerk>::GetEnumerator()  /*0x0A0002DB*/
    IL_0168: stloc.s 8
    IL_016a: br.s IL_0194
    IL_016c: ldloca.s 8
    IL_016e: call !0 System.Collections.Generic.List.Enumerator<EquippablePerk>::get_Current()  /*0x0A0002DC*/
    IL_0173: stloc.s 11
    IL_0175: ldloc.s 11
    IL_0177: ldfld string Equippable::displayName  /*0x04000E2B*/
    IL_017c: ldloc.s 10
    IL_017e: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0183: brfalse.s IL_0194
    IL_0185: ldarg.0
    IL_0186: ldfld List<EquippablePerk> EternalTrialsRun::disabledPerks  /*0x04000855*/
    IL_018b: ldloc.s 11
    IL_018d: callvirt void System.Collections.Generic.List<EquippablePerk>::Add(!0)  /*0x0A0002E6*/
    IL_0192: leave.s IL_01ad
    IL_0194: ldloca.s 8
    IL_0196: call bool System.Collections.Generic.List.Enumerator<EquippablePerk>::MoveNext()  /*0x0A0002DE*/
    IL_019b: brtrue.s IL_016c
    IL_019d: leave.s IL_01ad
    IL_019f: ldloca.s 8
    IL_01a1: constrained. System.Collections.Generic.List.Enumerator<EquippablePerk>  /*0x1B000082*/
    IL_01a7: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01ac: endfinally
    IL_01ad: ldloca.s 6
    IL_01af: call bool System.Collections.Generic.List.Enumerator<string>::MoveNext()  /*0x0A0002ED*/
    IL_01b4: brtrue.s IL_0159
    IL_01b6: leave.s IL_01c6
    IL_01b8: ldloca.s 6
    IL_01ba: constrained. System.Collections.Generic.List.Enumerator<string>  /*0x1B000087*/
    IL_01c0: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01c5: endfinally
    IL_01c6: ret
    .try IL_0039-IL_0076 finally handler IL_0076-IL_0084
    .try IL_008c-IL_00c0 finally handler IL_00c0-IL_00ce
    .try IL_00ee-IL_0123 finally handler IL_0123-IL_0131
    .try IL_00db-IL_013c finally handler IL_013c-IL_014a
    .try IL_016a-IL_019f finally handler IL_019f-IL_01ad
    .try IL_0157-IL_01b8 finally handler IL_01b8-IL_01c6

