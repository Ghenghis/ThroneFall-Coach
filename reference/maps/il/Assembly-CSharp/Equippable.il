// ===== Equippable  (token 0x02000213) =====
  .method Equippable::get_LOCIDENTIFIER_NAME()  // token 0x06000B4F rva 0x36262 attrs Public, HideBySig, SpecialName
    // code size 17 (0x11), max stack 8
    IL_0000: ldstr "Equippable/"
    IL_0005: ldarg.0
    IL_0006: ldfld string Equippable::displayName  /*0x04000E2B*/
    IL_000b: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0010: ret

  .method Equippable::get_LOCIDENTIFIER_DESCRIPTION()  // token 0x06000B50 rva 0x36274 attrs Public, HideBySig, SpecialName
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: call string Equippable::get_LOCIDENTIFIER_NAME()  /*0x06000B4F*/
    IL_0006: ldstr " Description"
    IL_000b: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0010: ret

  .method Equippable::get_UnlockIsCampaignProgress()  // token 0x06000B51 rva 0x36286 attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable.UnlockRequirement Equippable::unlockRequirement  /*0x04000E2D*/
    IL_0006: ldc.i4.1
    IL_0007: ceq
    IL_0009: ret

  .method Equippable::get_UnlockIsMetaLevel()  // token 0x06000B52 rva 0x36291 attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable.UnlockRequirement Equippable::unlockRequirement  /*0x04000E2D*/
    IL_0006: ldc.i4.0
    IL_0007: ceq
    IL_0009: ret

  .method Equippable::get_sortingValue()  // token 0x06000B53 rva 0x3629c attrs Public, HideBySig, SpecialName
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool Equippable::get_UnlockIsCampaignProgress()  /*0x06000B51*/
    IL_0006: brtrue.s IL_0019
    IL_0008: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_000d: ldfld Dictionary<Equippable, int> PerkManager::metaLevelByPerk  /*0x04000BEA*/
    IL_0012: ldarg.0
    IL_0013: callvirt !1 System.Collections.Generic.Dictionary<Equippable, int>::get_Item(!0)  /*0x0A0004E7*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: ldfld Equippable.LevelName Equippable::requiredBeatenLevel  /*0x04000E2E*/
    IL_001f: ret

  .method Equippable::get_IsUnlocked()  // token 0x06000B54 rva 0x362c0 attrs Public, HideBySig, SpecialName
    // code size 100 (0x64), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable.UnlockRequirement Equippable::unlockRequirement  /*0x04000E2D*/
    IL_0006: brtrue.s IL_0039
    IL_0008: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_000d: ldfld Dictionary<Equippable, int> PerkManager::metaLevelByPerk  /*0x04000BEA*/
    IL_0012: ldarg.0
    IL_0013: callvirt bool System.Collections.Generic.Dictionary<Equippable, int>::ContainsKey(!0)  /*0x0A000457*/
    IL_0018: brfalse.s IL_0037
    IL_001a: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_001f: ldfld int PerkManager::level  /*0x04000BEC*/
    IL_0024: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0029: ldfld Dictionary<Equippable, int> PerkManager::metaLevelByPerk  /*0x04000BEA*/
    IL_002e: ldarg.0
    IL_002f: callvirt !1 System.Collections.Generic.Dictionary<Equippable, int>::get_Item(!0)  /*0x0A0004E7*/
    IL_0034: cgt
    IL_0036: ret
    IL_0037: ldc.i4.1
    IL_0038: ret
    IL_0039: ldarg.0
    IL_003a: ldfld Equippable.LevelName Equippable::requiredBeatenLevel  /*0x04000E2E*/
    IL_003f: brtrue.s IL_0043
    IL_0041: ldc.i4.1
    IL_0042: ret
    IL_0043: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0048: ldarg.0
    IL_0049: ldflda Equippable.LevelName Equippable::requiredBeatenLevel  /*0x04000E2E*/
    IL_004e: constrained. Equippable.LevelName  /*0x02000215*/
    IL_0054: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_0059: callvirt LevelInfo LevelProgressManager::GetLevelInfoFromSceneName(string)  /*0x06000944*/
    IL_005e: callvirt bool LevelInfo::get_Beaten()  /*0x060008E6*/
    IL_0063: ret

  .method Equippable::IsAvailableInContentPack(Equippable.ContentPack)  // token 0x06000B55 rva 0x36330 attrs Public, HideBySig
    // code size 37 (0x25), max stack 3, init locals
    .locals ([0] Equippable.<>c__DisplayClass21_0)
    IL_0000: newobj void Equippable.<>c__DisplayClass21_0::.ctor()  /*0x06000B59*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldarg.1
    IL_0008: stfld Equippable.ContentPack Equippable.<>c__DisplayClass21_0::pack  /*0x04000E42*/
    IL_000d: ldarg.0
    IL_000e: ldfld Equippable.ContentPack[] Equippable::availableToContentPack  /*0x04000E2F*/
    IL_0013: ldloc.0
    IL_0014: ldftn bool Equippable.<>c__DisplayClass21_0::<IsAvailableInContentPack>b__0(Equippable.ContentPack)  /*0x06000B5A*/
    IL_001a: newobj void System.Predicate<Equippable.ContentPack>::.ctor(object,IntPtr)  /*0x0A0004E8*/
    IL_001f: call bool System.Array::Exists(!!0[],System.Predicate<!!0>)<Equippable.ContentPack>  /*0x2B0000A8*/
    IL_0024: ret

  .method Equippable::GetCurrentContentPackFromLoadoutScene()  // token 0x06000B56 rva 0x36364 attrs Public, Static, HideBySig
    // code size 63 (0x3f), max stack 2, init locals
    .locals ([0] string, [1] Scene)
    IL_0000: call Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()  /*0x0A000292*/
    IL_0005: stloc.1
    IL_0006: ldloca.s 1
    IL_0008: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_000d: stloc.0
    IL_000e: ldloc.0
    IL_000f: ldstr "_LevelSelect"
    IL_0014: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0019: brtrue.s IL_0037
    IL_001b: ldloc.0
    IL_001c: ldstr "_LevelSelectCraaghelm"
    IL_0021: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0026: brtrue.s IL_0039
    IL_0028: ldloc.0
    IL_0029: ldstr "_LevelSelectFangmoor"
    IL_002e: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0033: brtrue.s IL_003b
    IL_0035: br.s IL_003d
    IL_0037: ldc.i4.0
    IL_0038: ret
    IL_0039: ldc.i4.1
    IL_003a: ret
    IL_003b: ldc.i4.2
    IL_003c: ret
    IL_003d: ldc.i4.0
    IL_003e: ret

  .method Equippable::GetLockedTooltip()  // token 0x06000B57 rva 0x363b0 attrs Public, HideBySig
    // code size 102 (0x66), max stack 7, init locals
    .locals ([0] string, [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable.UnlockRequirement Equippable::unlockRequirement  /*0x04000E2D*/
    IL_0006: ldc.i4.1
    IL_0007: bne.un.s IL_002c
    IL_0009: ldstr "Menu/Beat Map to Unlock Cue"
    IL_000e: ldarg.0
    IL_000f: ldflda Equippable.LevelName Equippable::requiredBeatenLevel  /*0x04000E2E*/
    IL_0014: constrained. Equippable.LevelName  /*0x02000215*/
    IL_001a: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_001f: ldc.i4.1
    IL_0020: ldc.i4.1
    IL_0021: ldc.i4.0
    IL_0022: ldc.i4.1
    IL_0023: ldc.i4.1
    IL_0024: call string TextTranslator::TranslateAndInsertMapName(string,string,bool,bool,int,bool,bool)  /*0x060009E5*/
    IL_0029: stloc.0
    IL_002a: br.s IL_0064
    IL_002c: ldc.i4.1
    IL_002d: stloc.1
    IL_002e: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0033: ldfld Dictionary<Equippable, int> PerkManager::metaLevelByPerk  /*0x04000BEA*/
    IL_0038: ldarg.0
    IL_0039: callvirt bool System.Collections.Generic.Dictionary<Equippable, int>::ContainsKey(!0)  /*0x0A000457*/
    IL_003e: brfalse.s IL_0053
    IL_0040: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0045: ldfld Dictionary<Equippable, int> PerkManager::metaLevelByPerk  /*0x04000BEA*/
    IL_004a: ldarg.0
    IL_004b: callvirt !1 System.Collections.Generic.Dictionary<Equippable, int>::get_Item(!0)  /*0x0A0004E7*/
    IL_0050: ldc.i4.1
    IL_0051: add
    IL_0052: stloc.1
    IL_0053: ldstr "Menu/Reach Level to Unlock Cue"
    IL_0058: ldloc.1
    IL_0059: ldc.i4.1
    IL_005a: ldc.i4.1
    IL_005b: ldc.i4.0
    IL_005c: ldc.i4.1
    IL_005d: ldc.i4.1
    IL_005e: call string TextTranslator::TranslateAndInsertLevelNumber(string,int,bool,bool,int,bool,bool)  /*0x060009E4*/
    IL_0063: stloc.0
    IL_0064: ldloc.0
    IL_0065: ret

  .method Equippable::.ctor()  // token 0x06000B58 rva 0x36422 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.3
    IL_0002: newarr Equippable.ContentPack  /*0x02000216*/
    IL_0007: dup
    IL_0008: ldc.i4.1
    IL_0009: ldc.i4.1
    IL_000a: stelem.i4
    IL_000b: dup
    IL_000c: ldc.i4.2
    IL_000d: ldc.i4.2
    IL_000e: stelem.i4
    IL_000f: stfld Equippable.ContentPack[] Equippable::availableToContentPack  /*0x04000E2F*/
    IL_0014: ldarg.0
    IL_0015: call void UnityEngine.ScriptableObject::.ctor()  /*0x0A00002B*/
    IL_001a: ret

// ===== Equippable/UnlockRequirement  (token 0x02000214) =====
// ===== Equippable/LevelName  (token 0x02000215) =====
// ===== Equippable/ContentPack  (token 0x02000216) =====
// ===== Equippable/<>c__DisplayClass21_0  (token 0x02000217) =====
  .method Equippable.<>c__DisplayClass21_0::.ctor()  // token 0x06000B59 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method Equippable.<>c__DisplayClass21_0::<IsAvailableInContentPack>b__0(Equippable.ContentPack)  // token 0x06000B5A rva 0x3643e attrs Assembly, HideBySig
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld Equippable.ContentPack Equippable.<>c__DisplayClass21_0::pack  /*0x04000E42*/
    IL_0007: ceq
    IL_0009: ret

