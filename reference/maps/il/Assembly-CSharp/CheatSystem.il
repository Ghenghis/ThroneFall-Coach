// ===== CheatSystem  (token 0x020002DF) =====
  .method CheatSystem::GetCategories()  // token 0x06000FD0 rva 0x4854f attrs Public, Static, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: ldsfld Dictionary<string, CheatCategory> CheatSystem::categories  /*0x040012A9*/
    IL_0005: callvirt Dictionary.ValueCollection<!0, !1> System.Collections.Generic.Dictionary<string, CheatCategory>::get_Values()  /*0x0A000637*/
    IL_000a: ret

  .method CheatSystem::GetOrCreateCategory(string)  // token 0x06000FD1 rva 0x4855c attrs Private, Static, HideBySig
    // code size 42 (0x2a), max stack 3, init locals
    .locals ([0] CheatCategory)
    IL_0000: ldsfld Dictionary<string, CheatCategory> CheatSystem::categories  /*0x040012A9*/
    IL_0005: ldarg.0
    IL_0006: ldloca.s 0
    IL_0008: callvirt bool System.Collections.Generic.Dictionary<string, CheatCategory>::TryGetValue(!0,ref !1)  /*0x0A000638*/
    IL_000d: brtrue.s IL_0028
    IL_000f: newobj void CheatCategory::.ctor()  /*0x06000FC4*/
    IL_0014: dup
    IL_0015: ldarg.0
    IL_0016: stfld string CheatCategory::Name  /*0x0400128B*/
    IL_001b: stloc.0
    IL_001c: ldsfld Dictionary<string, CheatCategory> CheatSystem::categories  /*0x040012A9*/
    IL_0021: ldarg.0
    IL_0022: ldloc.0
    IL_0023: callvirt void System.Collections.Generic.Dictionary<string, CheatCategory>::set_Item(!0,!1)  /*0x0A000639*/
    IL_0028: ldloc.0
    IL_0029: ret

  .method CheatSystem::AddAction(string,string,System.Action)  // token 0x06000FD2 rva 0x48594 attrs Public, Static, HideBySig
    // code size 46 (0x2e), max stack 3, init locals
    .locals ([0] CheatEntry)
    IL_0000: newobj void CheatEntry::.ctor()  /*0x06000FC5*/
    IL_0005: dup
    IL_0006: ldarg.1
    IL_0007: stfld string CheatEntry::Name  /*0x04001291*/
    IL_000c: dup
    IL_000d: ldc.i4.0
    IL_000e: stfld CheatType CheatEntry::Type  /*0x04001292*/
    IL_0013: dup
    IL_0014: ldarg.2
    IL_0015: stfld Action CheatEntry::OnActivate  /*0x04001293*/
    IL_001a: stloc.0
    IL_001b: ldarg.0
    IL_001c: call CheatCategory CheatSystem::GetOrCreateCategory(string)  /*0x06000FD1*/
    IL_0021: ldfld List<CheatEntry> CheatCategory::Cheats  /*0x0400128C*/
    IL_0026: ldloc.0
    IL_0027: callvirt void System.Collections.Generic.List<CheatEntry>::Add(!0)  /*0x0A00063A*/
    IL_002c: ldloc.0
    IL_002d: ret

  .method CheatSystem::AddToggle(string,string,bool,System.Action<bool>)  // token 0x06000FD3 rva 0x485d0 attrs Public, Static, HideBySig
    // code size 53 (0x35), max stack 3, init locals
    .locals ([0] CheatEntry)
    IL_0000: newobj void CheatEntry::.ctor()  /*0x06000FC5*/
    IL_0005: dup
    IL_0006: ldarg.1
    IL_0007: stfld string CheatEntry::Name  /*0x04001291*/
    IL_000c: dup
    IL_000d: ldc.i4.1
    IL_000e: stfld CheatType CheatEntry::Type  /*0x04001292*/
    IL_0013: dup
    IL_0014: ldarg.2
    IL_0015: stfld bool CheatEntry::ToggleValue  /*0x04001294*/
    IL_001a: dup
    IL_001b: ldarg.3
    IL_001c: stfld Action<bool> CheatEntry::OnToggleChanged  /*0x04001295*/
    IL_0021: stloc.0
    IL_0022: ldarg.0
    IL_0023: call CheatCategory CheatSystem::GetOrCreateCategory(string)  /*0x06000FD1*/
    IL_0028: ldfld List<CheatEntry> CheatCategory::Cheats  /*0x0400128C*/
    IL_002d: ldloc.0
    IL_002e: callvirt void System.Collections.Generic.List<CheatEntry>::Add(!0)  /*0x0A00063A*/
    IL_0033: ldloc.0
    IL_0034: ret

  .method CheatSystem::AddSlider(string,string,float,float,float,System.Action<float>,float)  // token 0x06000FD4 rva 0x48614 attrs Public, Static, HideBySig
    // code size 77 (0x4d), max stack 3, init locals
    .locals ([0] CheatEntry)
    IL_0000: newobj void CheatEntry::.ctor()  /*0x06000FC5*/
    IL_0005: dup
    IL_0006: ldarg.1
    IL_0007: stfld string CheatEntry::Name  /*0x04001291*/
    IL_000c: dup
    IL_000d: ldc.i4.2
    IL_000e: stfld CheatType CheatEntry::Type  /*0x04001292*/
    IL_0013: dup
    IL_0014: ldarg.2
    IL_0015: stfld float CheatEntry::SliderMin  /*0x04001297*/
    IL_001a: dup
    IL_001b: ldarg.3
    IL_001c: stfld float CheatEntry::SliderMax  /*0x04001298*/
    IL_0021: dup
    IL_0022: ldarg.s 4
    IL_0024: stfld float CheatEntry::SliderValue  /*0x04001296*/
    IL_0029: dup
    IL_002a: ldarg.s 6
    IL_002c: stfld float CheatEntry::SliderStep  /*0x04001299*/
    IL_0031: dup
    IL_0032: ldarg.s 5
    IL_0034: stfld Action<float> CheatEntry::OnSliderChanged  /*0x0400129A*/
    IL_0039: stloc.0
    IL_003a: ldarg.0
    IL_003b: call CheatCategory CheatSystem::GetOrCreateCategory(string)  /*0x06000FD1*/
    IL_0040: ldfld List<CheatEntry> CheatCategory::Cheats  /*0x0400128C*/
    IL_0045: ldloc.0
    IL_0046: callvirt void System.Collections.Generic.List<CheatEntry>::Add(!0)  /*0x0A00063A*/
    IL_004b: ldloc.0
    IL_004c: ret

  .method CheatSystem::.cctor()  // token 0x06000FD5 rva 0x4866d attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void System.Collections.Generic.Dictionary<string, CheatCategory>::.ctor()  /*0x0A00063B*/
    IL_0005: stsfld Dictionary<string, CheatCategory> CheatSystem::categories  /*0x040012A9*/
    IL_000a: ret

