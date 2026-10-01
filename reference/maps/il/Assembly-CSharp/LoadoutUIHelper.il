// ===== LoadoutUIHelper  (token 0x02000320) =====
  .method LoadoutUIHelper::get_GetLevelData()  // token 0x06001136 rva 0x5064a attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LocalGamestate.GameMode LoadoutUIHelper::mode  /*0x04001483*/
    IL_0006: ldc.i4.0
    IL_0007: ceq
    IL_0009: ret

  .method LoadoutUIHelper::get_DrawQuests()  // token 0x06001137 rva 0x5064a attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LocalGamestate.GameMode LoadoutUIHelper::mode  /*0x04001483*/
    IL_0006: ldc.i4.0
    IL_0007: ceq
    IL_0009: ret

  .method LoadoutUIHelper::get_DrawMutators()  // token 0x06001138 rva 0x5064a attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LocalGamestate.GameMode LoadoutUIHelper::mode  /*0x04001483*/
    IL_0006: ldc.i4.0
    IL_0007: ceq
    IL_0009: ret

  .method LoadoutUIHelper::get_HasFixedLoadout()  // token 0x06001139 rva 0x50655 attrs Private, HideBySig, SpecialName
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool LoadoutUIHelper::get_GetLevelData()  /*0x06001136*/
    IL_0006: brfalse.s IL_0022
    IL_0008: ldarg.0
    IL_0009: ldfld LevelInfo LoadoutUIHelper::levelInfo  /*0x04001499*/
    IL_000e: ldnull
    IL_000f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0014: brfalse.s IL_0022
    IL_0016: ldarg.0
    IL_0017: ldfld LevelInfo LoadoutUIHelper::levelInfo  /*0x04001499*/
    IL_001c: callvirt bool LevelInfo::get_HasFixedLoadout()  /*0x060008E2*/
    IL_0021: ret
    IL_0022: ldc.i4.0
    IL_0023: ret

  .method LoadoutUIHelper::get_UnequipAllBesidesWeaponsOnStart()  // token 0x0600113A rva 0x5067a attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LocalGamestate.GameMode LoadoutUIHelper::mode  /*0x04001483*/
    IL_0006: ldc.i4.1
    IL_0007: ceq
    IL_0009: ret

  .method LoadoutUIHelper::get_LoadoutWorth()  // token 0x0600113B rva 0x50685 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_0006: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_000b: ret

  .method LoadoutUIHelper::OnShow()  // token 0x0600113C rva 0x50694 attrs Public, HideBySig
    // code size 1234 (0x4d2), max stack 3, init locals
    .locals ([0] IEnumerator, [1] IDisposable, [2] List.Enumerator<Equippable>, [3] Equippable, [4] Equippable, [5] int, [6] int, [7] int, [8] TFUIEquippable)
    IL_0000: ldarg.0
    IL_0001: ldfld bool LoadoutUIHelper::inMatch  /*0x04001480*/
    IL_0006: brfalse.s IL_0026
    IL_0008: call bool MatchSaveLoadHandler::get_SaveLoadForbidden()  /*0x06000CF0*/
    IL_000d: brfalse.s IL_0026
    IL_000f: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0014: callvirt void SceneTransitionManager::RestartCurrentLevel()  /*0x060009CB*/
    IL_0019: ldarg.0
    IL_001a: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001f: ldc.i4.0
    IL_0020: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: call bool LoadoutUIHelper::get_GetLevelData()  /*0x06001136*/
    IL_002c: brfalse.s IL_008c
    IL_002e: ldarg.0
    IL_002f: ldfld bool LoadoutUIHelper::inMatch  /*0x04001480*/
    IL_0034: brfalse.s IL_0058
    IL_0036: ldarg.0
    IL_0037: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_003c: callvirt LevelData LevelProgressManager::GetLevelDataForActiveScene()  /*0x0600094B*/
    IL_0041: stfld LevelData LoadoutUIHelper::levelData  /*0x04001498*/
    IL_0046: ldarg.0
    IL_0047: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_004c: callvirt LevelInfo LevelProgressManager::GetLevelInfoFromCurrentSceneName()  /*0x06000945*/
    IL_0051: stfld LevelInfo LoadoutUIHelper::levelInfo  /*0x04001499*/
    IL_0056: br.s IL_008c
    IL_0058: ldarg.0
    IL_0059: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_005e: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_0063: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0068: callvirt LevelData LevelProgressManager::GetLevelDataForScene(string)  /*0x0600094A*/
    IL_006d: stfld LevelData LoadoutUIHelper::levelData  /*0x04001498*/
    IL_0072: ldarg.0
    IL_0073: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0078: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_007d: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0082: callvirt LevelInfo LevelProgressManager::GetLevelInfoFromSceneName(string)  /*0x06000944*/
    IL_0087: stfld LevelInfo LoadoutUIHelper::levelInfo  /*0x04001499*/
    IL_008c: ldarg.0
    IL_008d: ldfld GameObject LoadoutUIHelper::fixedLoadoutWarning  /*0x0400148F*/
    IL_0092: ldnull
    IL_0093: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0098: brfalse.s IL_00b0
    IL_009a: ldarg.0
    IL_009b: ldfld GameObject LoadoutUIHelper::fixedLoadoutWarning  /*0x0400148F*/
    IL_00a0: ldarg.0
    IL_00a1: ldfld LevelInfo LoadoutUIHelper::levelInfo  /*0x04001499*/
    IL_00a6: callvirt bool LevelInfo::get_HasFixedLoadout()  /*0x060008E2*/
    IL_00ab: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00b0: ldarg.0
    IL_00b1: ldfld bool LoadoutUIHelper::bufferLastLoadoutOnShow  /*0x04001482*/
    IL_00b6: brfalse.s IL_00d2
    IL_00b8: ldarg.0
    IL_00b9: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00be: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_00c3: callvirt !0[] System.Collections.Generic.List<Equippable>::ToArray()  /*0x0A0006D7*/
    IL_00c8: newobj void System.Collections.Generic.List<Equippable>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000430*/
    IL_00cd: stfld List<Equippable> LoadoutUIHelper::lastLoadout  /*0x0400149A*/
    IL_00d2: ldarg.0
    IL_00d3: ldfld List<TFUIEquippable> LoadoutUIHelper::weapons  /*0x04001490*/
    IL_00d8: callvirt void System.Collections.Generic.List<TFUIEquippable>::Clear()  /*0x0A0006D8*/
    IL_00dd: ldarg.0
    IL_00de: ldfld List<TFUIEquippable> LoadoutUIHelper::perks  /*0x04001491*/
    IL_00e3: callvirt void System.Collections.Generic.List<TFUIEquippable>::Clear()  /*0x0A0006D8*/
    IL_00e8: ldarg.0
    IL_00e9: ldfld List<TFUIEquippable> LoadoutUIHelper::mutators  /*0x04001492*/
    IL_00ee: callvirt void System.Collections.Generic.List<TFUIEquippable>::Clear()  /*0x0A0006D8*/
    IL_00f3: ldarg.0
    IL_00f4: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedWeapons  /*0x04001493*/
    IL_00f9: callvirt void System.Collections.Generic.List<TFUIEquippable>::Clear()  /*0x0A0006D8*/
    IL_00fe: ldarg.0
    IL_00ff: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_0104: callvirt void System.Collections.Generic.List<TFUIEquippable>::Clear()  /*0x0A0006D8*/
    IL_0109: ldarg.0
    IL_010a: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedMutators  /*0x04001495*/
    IL_010f: callvirt void System.Collections.Generic.List<TFUIEquippable>::Clear()  /*0x0A0006D8*/
    IL_0114: ldarg.0
    IL_0115: ldfld GridLayoutGroup LoadoutUIHelper::weaponsParent  /*0x04001489*/
    IL_011a: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_011f: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_0124: stloc.0
    IL_0125: br.s IL_013c
    IL_0127: ldloc.0
    IL_0128: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_012d: castclass UnityEngine.Transform  /*0x01000015*/
    IL_0132: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0137: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_013c: ldloc.0
    IL_013d: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0142: brtrue.s IL_0127
    IL_0144: leave.s IL_0157
    IL_0146: ldloc.0
    IL_0147: isinst System.IDisposable  /*0x0100001B*/
    IL_014c: stloc.1
    IL_014d: ldloc.1
    IL_014e: brfalse.s IL_0156
    IL_0150: ldloc.1
    IL_0151: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0156: endfinally
    IL_0157: ldarg.0
    IL_0158: ldfld GridLayoutGroup LoadoutUIHelper::perksParent  /*0x0400148A*/
    IL_015d: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0162: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_0167: stloc.0
    IL_0168: br.s IL_017f
    IL_016a: ldloc.0
    IL_016b: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_0170: castclass UnityEngine.Transform  /*0x01000015*/
    IL_0175: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_017a: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_017f: ldloc.0
    IL_0180: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0185: brtrue.s IL_016a
    IL_0187: leave.s IL_019a
    IL_0189: ldloc.0
    IL_018a: isinst System.IDisposable  /*0x0100001B*/
    IL_018f: stloc.1
    IL_0190: ldloc.1
    IL_0191: brfalse.s IL_0199
    IL_0193: ldloc.1
    IL_0194: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0199: endfinally
    IL_019a: ldarg.0
    IL_019b: call bool LoadoutUIHelper::get_DrawMutators()  /*0x06001138*/
    IL_01a0: brfalse.s IL_01e5
    IL_01a2: ldarg.0
    IL_01a3: ldfld GridLayoutGroup LoadoutUIHelper::mutatorsParent  /*0x0400148B*/
    IL_01a8: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01ad: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_01b2: stloc.0
    IL_01b3: br.s IL_01ca
    IL_01b5: ldloc.0
    IL_01b6: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_01bb: castclass UnityEngine.Transform  /*0x01000015*/
    IL_01c0: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01c5: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_01ca: ldloc.0
    IL_01cb: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_01d0: brtrue.s IL_01b5
    IL_01d2: leave.s IL_01e5
    IL_01d4: ldloc.0
    IL_01d5: isinst System.IDisposable  /*0x0100001B*/
    IL_01da: stloc.1
    IL_01db: ldloc.1
    IL_01dc: brfalse.s IL_01e4
    IL_01de: ldloc.1
    IL_01df: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01e4: endfinally
    IL_01e5: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_01ea: ldfld List<Equippable> PerkManager::allEquippables  /*0x04000BE8*/
    IL_01ef: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_01f4: stloc.2
    IL_01f5: br IL_0281
    IL_01fa: ldloca.s 2
    IL_01fc: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_0201: stloc.3
    IL_0202: ldloc.3
    IL_0203: call Equippable.ContentPack Equippable::GetCurrentContentPackFromLoadoutScene()  /*0x06000B56*/
    IL_0208: callvirt bool Equippable::IsAvailableInContentPack(Equippable.ContentPack)  /*0x06000B55*/
    IL_020d: brfalse.s IL_0281
    IL_020f: ldloc.3
    IL_0210: callvirt bool Equippable::get_IsUnlocked()  /*0x06000B54*/
    IL_0215: brfalse.s IL_0281
    IL_0217: ldarg.0
    IL_0218: call bool LoadoutUIHelper::get_DrawMutators()  /*0x06001138*/
    IL_021d: brtrue.s IL_0236
    IL_021f: ldarg.0
    IL_0220: call bool LoadoutUIHelper::get_UnequipAllBesidesWeaponsOnStart()  /*0x0600113A*/
    IL_0225: brfalse.s IL_0236
    IL_0227: ldloc.3
    IL_0228: isinst EquippableMutation  /*0x02000219*/
    IL_022d: brfalse.s IL_0236
    IL_022f: ldloc.3
    IL_0230: ldc.i4.0
    IL_0231: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_0236: ldloc.3
    IL_0237: isinst EquippableWeapon  /*0x0200021B*/
    IL_023c: brfalse.s IL_024d
    IL_023e: ldarg.0
    IL_023f: ldarg.0
    IL_0240: ldfld GridLayoutGroup LoadoutUIHelper::weaponsParent  /*0x04001489*/
    IL_0245: ldloc.3
    IL_0246: call void LoadoutUIHelper::AddTFUIEquippable(UnityEngine.UI.GridLayoutGroup,Equippable)  /*0x0600113D*/
    IL_024b: br.s IL_0281
    IL_024d: ldloc.3
    IL_024e: isinst EquippablePerk  /*0x0200021A*/
    IL_0253: brfalse.s IL_0264
    IL_0255: ldarg.0
    IL_0256: ldarg.0
    IL_0257: ldfld GridLayoutGroup LoadoutUIHelper::perksParent  /*0x0400148A*/
    IL_025c: ldloc.3
    IL_025d: call void LoadoutUIHelper::AddTFUIEquippable(UnityEngine.UI.GridLayoutGroup,Equippable)  /*0x0600113D*/
    IL_0262: br.s IL_0281
    IL_0264: ldloc.3
    IL_0265: isinst EquippableMutation  /*0x02000219*/
    IL_026a: brfalse.s IL_0281
    IL_026c: ldarg.0
    IL_026d: call bool LoadoutUIHelper::get_DrawMutators()  /*0x06001138*/
    IL_0272: brfalse.s IL_0281
    IL_0274: ldarg.0
    IL_0275: ldarg.0
    IL_0276: ldfld GridLayoutGroup LoadoutUIHelper::mutatorsParent  /*0x0400148B*/
    IL_027b: ldloc.3
    IL_027c: call void LoadoutUIHelper::AddTFUIEquippable(UnityEngine.UI.GridLayoutGroup,Equippable)  /*0x0600113D*/
    IL_0281: ldloca.s 2
    IL_0283: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_0288: brtrue IL_01fa
    IL_028d: leave.s IL_029d
    IL_028f: ldloca.s 2
    IL_0291: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_0297: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_029c: endfinally
    IL_029d: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_02a2: ldfld List<Equippable> PerkManager::allEquippables  /*0x04000BE8*/
    IL_02a7: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_02ac: stloc.2
    IL_02ad: br IL_036c
    IL_02b2: ldloca.s 2
    IL_02b4: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_02b9: stloc.s 4
    IL_02bb: ldloc.s 4
    IL_02bd: call Equippable.ContentPack Equippable::GetCurrentContentPackFromLoadoutScene()  /*0x06000B56*/
    IL_02c2: callvirt bool Equippable::IsAvailableInContentPack(Equippable.ContentPack)  /*0x06000B55*/
    IL_02c7: brfalse IL_036c
    IL_02cc: ldarg.0
    IL_02cd: call bool LoadoutUIHelper::get_DrawMutators()  /*0x06001138*/
    IL_02d2: brtrue.s IL_02ed
    IL_02d4: ldarg.0
    IL_02d5: call bool LoadoutUIHelper::get_UnequipAllBesidesWeaponsOnStart()  /*0x0600113A*/
    IL_02da: brfalse.s IL_02ed
    IL_02dc: ldloc.s 4
    IL_02de: isinst EquippableMutation  /*0x02000219*/
    IL_02e3: brfalse.s IL_02ed
    IL_02e5: ldloc.s 4
    IL_02e7: ldc.i4.0
    IL_02e8: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_02ed: ldloc.s 4
    IL_02ef: callvirt bool Equippable::get_IsUnlocked()  /*0x06000B54*/
    IL_02f4: brtrue.s IL_036c
    IL_02f6: ldloc.s 4
    IL_02f8: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_02fd: brfalse.s IL_031b
    IL_02ff: ldarg.0
    IL_0300: ldfld LevelInfo LoadoutUIHelper::levelInfo  /*0x04001499*/
    IL_0305: ldfld List<Equippable> LevelInfo::fixedLoadout  /*0x04000B2A*/
    IL_030a: ldloc.s 4
    IL_030c: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_0311: brtrue.s IL_031b
    IL_0313: ldloc.s 4
    IL_0315: ldc.i4.0
    IL_0316: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_031b: ldloc.s 4
    IL_031d: isinst EquippableWeapon  /*0x0200021B*/
    IL_0322: brfalse.s IL_0334
    IL_0324: ldarg.0
    IL_0325: ldarg.0
    IL_0326: ldfld GridLayoutGroup LoadoutUIHelper::weaponsParent  /*0x04001489*/
    IL_032b: ldloc.s 4
    IL_032d: call void LoadoutUIHelper::AddTFUIEquippable(UnityEngine.UI.GridLayoutGroup,Equippable)  /*0x0600113D*/
    IL_0332: br.s IL_036c
    IL_0334: ldloc.s 4
    IL_0336: isinst EquippablePerk  /*0x0200021A*/
    IL_033b: brfalse.s IL_034d
    IL_033d: ldarg.0
    IL_033e: ldarg.0
    IL_033f: ldfld GridLayoutGroup LoadoutUIHelper::perksParent  /*0x0400148A*/
    IL_0344: ldloc.s 4
    IL_0346: call void LoadoutUIHelper::AddTFUIEquippable(UnityEngine.UI.GridLayoutGroup,Equippable)  /*0x0600113D*/
    IL_034b: br.s IL_036c
    IL_034d: ldloc.s 4
    IL_034f: isinst EquippableMutation  /*0x02000219*/
    IL_0354: brfalse.s IL_036c
    IL_0356: ldarg.0
    IL_0357: call bool LoadoutUIHelper::get_DrawMutators()  /*0x06001138*/
    IL_035c: brfalse.s IL_036c
    IL_035e: ldarg.0
    IL_035f: ldarg.0
    IL_0360: ldfld GridLayoutGroup LoadoutUIHelper::mutatorsParent  /*0x0400148B*/
    IL_0365: ldloc.s 4
    IL_0367: call void LoadoutUIHelper::AddTFUIEquippable(UnityEngine.UI.GridLayoutGroup,Equippable)  /*0x0600113D*/
    IL_036c: ldloca.s 2
    IL_036e: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_0373: brtrue IL_02b2
    IL_0378: leave.s IL_0388
    IL_037a: ldloca.s 2
    IL_037c: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_0382: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0387: endfinally
    IL_0388: ldarg.0
    IL_0389: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_038e: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_0393: ldarg.0
    IL_0394: ldfld LevelInfo LoadoutUIHelper::levelInfo  /*0x04001499*/
    IL_0399: ldfld int LevelInfo::maxPerkCount  /*0x04000B2B*/
    IL_039e: ble IL_0454
    IL_03a3: ldarg.0
    IL_03a4: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_03a9: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_03ae: ldarg.0
    IL_03af: ldfld LevelInfo LoadoutUIHelper::levelInfo  /*0x04001499*/
    IL_03b4: ldfld int LevelInfo::maxPerkCount  /*0x04000B2B*/
    IL_03b9: sub
    IL_03ba: stloc.s 5
    IL_03bc: ldc.i4.0
    IL_03bd: stloc.s 6
    IL_03bf: ldarg.0
    IL_03c0: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_03c5: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_03ca: ldc.i4.1
    IL_03cb: sub
    IL_03cc: stloc.s 7
    IL_03ce: br.s IL_0434
    IL_03d0: ldloc.s 6
    IL_03d2: ldloc.s 5
    IL_03d4: bge.s IL_042e
    IL_03d6: ldarg.0
    IL_03d7: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_03dc: ldloc.s 7
    IL_03de: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_03e3: stloc.s 8
    IL_03e5: ldarg.0
    IL_03e6: call bool LoadoutUIHelper::get_HasFixedLoadout()  /*0x06001139*/
    IL_03eb: brfalse.s IL_0406
    IL_03ed: ldarg.0
    IL_03ee: ldfld LevelInfo LoadoutUIHelper::levelInfo  /*0x04001499*/
    IL_03f3: ldfld List<Equippable> LevelInfo::fixedLoadout  /*0x04000B2A*/
    IL_03f8: ldloc.s 8
    IL_03fa: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_03ff: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_0404: brtrue.s IL_042e
    IL_0406: ldloc.s 8
    IL_0408: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_040d: ldc.i4.0
    IL_040e: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_0413: ldloc.s 8
    IL_0415: callvirt void TFUIEquippable::UnPick()  /*0x0600120D*/
    IL_041a: ldarg.0
    IL_041b: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_0420: ldloc.s 8
    IL_0422: callvirt bool System.Collections.Generic.List<TFUIEquippable>::Remove(!0)  /*0x0A0006DA*/
    IL_0427: pop
    IL_0428: ldloc.s 6
    IL_042a: ldc.i4.1
    IL_042b: add
    IL_042c: stloc.s 6
    IL_042e: ldloc.s 7
    IL_0430: ldc.i4.1
    IL_0431: sub
    IL_0432: stloc.s 7
    IL_0434: ldloc.s 7
    IL_0436: ldc.i4.0
    IL_0437: bge.s IL_03d0
    IL_0439: ldstr "Unequipped "
    IL_043e: ldloca.s 6
    IL_0440: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0445: ldstr " excess perks."
    IL_044a: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_044f: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_0454: ldarg.0
    IL_0455: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedWeapons  /*0x04001493*/
    IL_045a: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_045f: ldc.i4.1
    IL_0460: bge.s IL_04a9
    IL_0462: ldarg.0
    IL_0463: call bool LoadoutUIHelper::get_HasFixedLoadout()  /*0x06001139*/
    IL_0468: brtrue.s IL_04a9
    IL_046a: ldarg.0
    IL_046b: ldfld List<TFUIEquippable> LoadoutUIHelper::weapons  /*0x04001490*/
    IL_0470: ldc.i4.0
    IL_0471: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0476: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_047b: ldc.i4.1
    IL_047c: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_0481: ldarg.0
    IL_0482: ldfld List<TFUIEquippable> LoadoutUIHelper::weapons  /*0x04001490*/
    IL_0487: ldc.i4.0
    IL_0488: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_048d: callvirt void TFUIEquippable::Pick()  /*0x0600120C*/
    IL_0492: ldarg.0
    IL_0493: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedWeapons  /*0x04001493*/
    IL_0498: ldarg.0
    IL_0499: ldfld List<TFUIEquippable> LoadoutUIHelper::weapons  /*0x04001490*/
    IL_049e: ldc.i4.0
    IL_049f: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_04a4: callvirt void System.Collections.Generic.List<TFUIEquippable>::Add(!0)  /*0x0A0006DB*/
    IL_04a9: ldarg.0
    IL_04aa: call void LoadoutUIHelper::RecomputeNavigation()  /*0x0600113F*/
    IL_04af: ldarg.0
    IL_04b0: call void LoadoutUIHelper::UpdatePerkPointsRemainingText()  /*0x06001141*/
    IL_04b5: ldarg.0
    IL_04b6: call bool LoadoutUIHelper::get_DrawQuests()  /*0x06001137*/
    IL_04bb: brfalse.s IL_04c3
    IL_04bd: ldarg.0
    IL_04be: call void LoadoutUIHelper::RewriteQuestTexts()  /*0x06001140*/
    IL_04c3: ldarg.0
    IL_04c4: call bool LoadoutUIHelper::get_DrawMutators()  /*0x06001138*/
    IL_04c9: brfalse.s IL_04d1
    IL_04cb: ldarg.0
    IL_04cc: call void LoadoutUIHelper::UpdateMutatorBonusText()  /*0x06001142*/
    IL_04d1: ret
    .try IL_0125-IL_0146 finally handler IL_0146-IL_0157
    .try IL_0168-IL_0189 finally handler IL_0189-IL_019a
    .try IL_01b3-IL_01d4 finally handler IL_01d4-IL_01e5
    .try IL_01f5-IL_028f finally handler IL_028f-IL_029d
    .try IL_02ad-IL_037a finally handler IL_037a-IL_0388

  .method LoadoutUIHelper::AddTFUIEquippable(UnityEngine.UI.GridLayoutGroup,Equippable)  // token 0x0600113D rva 0x50bb4 attrs Private, HideBySig
    // code size 368 (0x170), max stack 5, init locals
    .locals ([0] TFUIEquippable, [1] bool)
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIEquippable LoadoutUIHelper::equippableButtonPrefab  /*0x0400148C*/
    IL_0006: ldarg.1
    IL_0007: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000c: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<TFUIEquippable>  /*0x2B0000EB*/
    IL_0011: callvirt !!0 UnityEngine.Component::GetComponent()<TFUIEquippable>  /*0x2B0000E9*/
    IL_0016: stloc.0
    IL_0017: ldloc.0
    IL_0018: ldarg.2
    IL_0019: ldarg.0
    IL_001a: call bool LoadoutUIHelper::get_HasFixedLoadout()  /*0x06001139*/
    IL_001f: ldc.i4.0
    IL_0020: ldarg.0
    IL_0021: ldfld LevelInfo LoadoutUIHelper::levelInfo  /*0x04001499*/
    IL_0026: callvirt void TFUIEquippable::SetData(Equippable,bool,bool,LevelInfo)  /*0x06001209*/
    IL_002b: ldarg.2
    IL_002c: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0031: brfalse IL_00bb
    IL_0036: ldarg.0
    IL_0037: call bool LoadoutUIHelper::get_HasFixedLoadout()  /*0x06001139*/
    IL_003c: brfalse.s IL_0054
    IL_003e: ldarg.0
    IL_003f: ldfld LevelInfo LoadoutUIHelper::levelInfo  /*0x04001499*/
    IL_0044: ldfld List<Equippable> LevelInfo::fixedLoadout  /*0x04000B2A*/
    IL_0049: ldarg.2
    IL_004a: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_004f: ldc.i4.0
    IL_0050: ceq
    IL_0052: br.s IL_0055
    IL_0054: ldc.i4.0
    IL_0055: stloc.1
    IL_0056: ldarg.0
    IL_0057: call bool LoadoutUIHelper::get_UnequipAllBesidesWeaponsOnStart()  /*0x0600113A*/
    IL_005c: brfalse.s IL_0068
    IL_005e: ldarg.2
    IL_005f: isinst EquippableWeapon  /*0x0200021B*/
    IL_0064: brtrue.s IL_0068
    IL_0066: ldc.i4.1
    IL_0067: stloc.1
    IL_0068: ldloc.1
    IL_0069: brfalse.s IL_0077
    IL_006b: ldarg.2
    IL_006c: ldc.i4.0
    IL_006d: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_0072: br IL_011f
    IL_0077: ldloc.0
    IL_0078: callvirt void TFUIEquippable::Pick()  /*0x0600120C*/
    IL_007d: ldarg.2
    IL_007e: isinst EquippableWeapon  /*0x0200021B*/
    IL_0083: brfalse.s IL_0091
    IL_0085: ldarg.0
    IL_0086: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedWeapons  /*0x04001493*/
    IL_008b: ldloc.0
    IL_008c: callvirt void System.Collections.Generic.List<TFUIEquippable>::Add(!0)  /*0x0A0006DB*/
    IL_0091: ldarg.2
    IL_0092: isinst EquippablePerk  /*0x0200021A*/
    IL_0097: brfalse.s IL_00a5
    IL_0099: ldarg.0
    IL_009a: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_009f: ldloc.0
    IL_00a0: callvirt void System.Collections.Generic.List<TFUIEquippable>::Add(!0)  /*0x0A0006DB*/
    IL_00a5: ldarg.2
    IL_00a6: isinst EquippableMutation  /*0x02000219*/
    IL_00ab: brfalse.s IL_011f
    IL_00ad: ldarg.0
    IL_00ae: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedMutators  /*0x04001495*/
    IL_00b3: ldloc.0
    IL_00b4: callvirt void System.Collections.Generic.List<TFUIEquippable>::Add(!0)  /*0x0A0006DB*/
    IL_00b9: br.s IL_011f
    IL_00bb: ldarg.0
    IL_00bc: call bool LoadoutUIHelper::get_HasFixedLoadout()  /*0x06001139*/
    IL_00c1: brfalse.s IL_011f
    IL_00c3: ldarg.0
    IL_00c4: ldfld LevelInfo LoadoutUIHelper::levelInfo  /*0x04001499*/
    IL_00c9: ldfld List<Equippable> LevelInfo::fixedLoadout  /*0x04000B2A*/
    IL_00ce: ldarg.2
    IL_00cf: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_00d4: brfalse.s IL_011f
    IL_00d6: ldarg.2
    IL_00d7: ldc.i4.1
    IL_00d8: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_00dd: ldloc.0
    IL_00de: callvirt void TFUIEquippable::Pick()  /*0x0600120C*/
    IL_00e3: ldarg.2
    IL_00e4: isinst EquippableWeapon  /*0x0200021B*/
    IL_00e9: brfalse.s IL_00f7
    IL_00eb: ldarg.0
    IL_00ec: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedWeapons  /*0x04001493*/
    IL_00f1: ldloc.0
    IL_00f2: callvirt void System.Collections.Generic.List<TFUIEquippable>::Add(!0)  /*0x0A0006DB*/
    IL_00f7: ldarg.2
    IL_00f8: isinst EquippablePerk  /*0x0200021A*/
    IL_00fd: brfalse.s IL_010b
    IL_00ff: ldarg.0
    IL_0100: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_0105: ldloc.0
    IL_0106: callvirt void System.Collections.Generic.List<TFUIEquippable>::Add(!0)  /*0x0A0006DB*/
    IL_010b: ldarg.2
    IL_010c: isinst EquippableMutation  /*0x02000219*/
    IL_0111: brfalse.s IL_011f
    IL_0113: ldarg.0
    IL_0114: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedMutators  /*0x04001495*/
    IL_0119: ldloc.0
    IL_011a: callvirt void System.Collections.Generic.List<TFUIEquippable>::Add(!0)  /*0x0A0006DB*/
    IL_011f: ldarg.1
    IL_0120: ldarg.0
    IL_0121: ldfld GridLayoutGroup LoadoutUIHelper::weaponsParent  /*0x04001489*/
    IL_0126: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_012b: brfalse.s IL_013a
    IL_012d: ldarg.0
    IL_012e: ldfld List<TFUIEquippable> LoadoutUIHelper::weapons  /*0x04001490*/
    IL_0133: ldloc.0
    IL_0134: callvirt void System.Collections.Generic.List<TFUIEquippable>::Add(!0)  /*0x0A0006DB*/
    IL_0139: ret
    IL_013a: ldarg.1
    IL_013b: ldarg.0
    IL_013c: ldfld GridLayoutGroup LoadoutUIHelper::perksParent  /*0x0400148A*/
    IL_0141: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0146: brfalse.s IL_0155
    IL_0148: ldarg.0
    IL_0149: ldfld List<TFUIEquippable> LoadoutUIHelper::perks  /*0x04001491*/
    IL_014e: ldloc.0
    IL_014f: callvirt void System.Collections.Generic.List<TFUIEquippable>::Add(!0)  /*0x0A0006DB*/
    IL_0154: ret
    IL_0155: ldarg.1
    IL_0156: ldarg.0
    IL_0157: ldfld GridLayoutGroup LoadoutUIHelper::mutatorsParent  /*0x0400148B*/
    IL_015c: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0161: brfalse.s IL_016f
    IL_0163: ldarg.0
    IL_0164: ldfld List<TFUIEquippable> LoadoutUIHelper::mutators  /*0x04001492*/
    IL_0169: ldloc.0
    IL_016a: callvirt void System.Collections.Generic.List<TFUIEquippable>::Add(!0)  /*0x0A0006DB*/
    IL_016f: ret

  .method LoadoutUIHelper::TrySelectEquippableForLoadout()  // token 0x0600113E rva 0x50d30 attrs Public, HideBySig
    // code size 552 (0x228), max stack 3, init locals
    .locals ([0] TFUIEquippable, [1] int, [2] List<TFUIEquippable>, [3] int, [4] int, [5] List.Enumerator<TFUIEquippable>, [6] TFUIEquippable)
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame LoadoutUIHelper::frame  /*0x04001484*/
    IL_0006: callvirt ThronefallUIElement UIFrame::get_LastApplied()  /*0x060012E8*/
    IL_000b: isinst TFUIEquippable  /*0x0200034D*/
    IL_0010: stloc.0
    IL_0011: ldloc.0
    IL_0012: ldnull
    IL_0013: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0018: brfalse.s IL_001b
    IL_001a: ret
    IL_001b: ldloc.0
    IL_001c: callvirt bool TFUIEquippable::get_Locked()  /*0x060011FA*/
    IL_0021: brfalse.s IL_0024
    IL_0023: ret
    IL_0024: ldarg.0
    IL_0025: call bool LoadoutUIHelper::get_HasFixedLoadout()  /*0x06001139*/
    IL_002a: brfalse.s IL_002d
    IL_002c: ret
    IL_002d: ldloc.0
    IL_002e: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_0033: isinst EquippableWeapon  /*0x0200021B*/
    IL_0038: brfalse.s IL_00b0
    IL_003a: ldarg.0
    IL_003b: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedWeapons  /*0x04001493*/
    IL_0040: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_0045: ldc.i4.1
    IL_0046: sub
    IL_0047: stloc.1
    IL_0048: br.s IL_008e
    IL_004a: ldarg.0
    IL_004b: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedWeapons  /*0x04001493*/
    IL_0050: ldloc.1
    IL_0051: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0056: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_005b: ldc.i4.0
    IL_005c: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_0061: ldarg.0
    IL_0062: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedWeapons  /*0x04001493*/
    IL_0067: ldloc.1
    IL_0068: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_006d: callvirt void TFUIEquippable::UnPick()  /*0x0600120D*/
    IL_0072: ldarg.0
    IL_0073: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedWeapons  /*0x04001493*/
    IL_0078: ldarg.0
    IL_0079: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedWeapons  /*0x04001493*/
    IL_007e: ldloc.1
    IL_007f: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0084: callvirt bool System.Collections.Generic.List<TFUIEquippable>::Remove(!0)  /*0x0A0006DA*/
    IL_0089: pop
    IL_008a: ldloc.1
    IL_008b: ldc.i4.1
    IL_008c: sub
    IL_008d: stloc.1
    IL_008e: ldloc.1
    IL_008f: ldc.i4.0
    IL_0090: bge.s IL_004a
    IL_0092: ldloc.0
    IL_0093: callvirt void TFUIEquippable::Pick()  /*0x0600120C*/
    IL_0098: ldloc.0
    IL_0099: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_009e: ldc.i4.1
    IL_009f: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_00a4: ldarg.0
    IL_00a5: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedWeapons  /*0x04001493*/
    IL_00aa: ldloc.0
    IL_00ab: callvirt void System.Collections.Generic.List<TFUIEquippable>::Add(!0)  /*0x0A0006DB*/
    IL_00b0: ldloc.0
    IL_00b1: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_00b6: isinst EquippablePerk  /*0x0200021A*/
    IL_00bb: brfalse IL_01b9
    IL_00c0: newobj void System.Collections.Generic.List<TFUIEquippable>::.ctor()  /*0x0A0006DC*/
    IL_00c5: stloc.2
    IL_00c6: ldc.i4.0
    IL_00c7: stloc.3
    IL_00c8: ldarg.0
    IL_00c9: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_00ce: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_00d3: ldc.i4.1
    IL_00d4: sub
    IL_00d5: stloc.s 4
    IL_00d7: br.s IL_0119
    IL_00d9: ldarg.0
    IL_00da: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_00df: ldloc.s 4
    IL_00e1: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_00e6: ldloc.0
    IL_00e7: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00ec: brfalse.s IL_00f2
    IL_00ee: ldloc.3
    IL_00ef: ldc.i4.1
    IL_00f0: add
    IL_00f1: stloc.3
    IL_00f2: ldloc.3
    IL_00f3: ldarg.0
    IL_00f4: ldfld LevelInfo LoadoutUIHelper::levelInfo  /*0x04001499*/
    IL_00f9: ldfld int LevelInfo::maxPerkCount  /*0x04000B2B*/
    IL_00fe: blt.s IL_0113
    IL_0100: ldloc.2
    IL_0101: ldarg.0
    IL_0102: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_0107: ldloc.s 4
    IL_0109: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_010e: callvirt void System.Collections.Generic.List<TFUIEquippable>::Add(!0)  /*0x0A0006DB*/
    IL_0113: ldloc.s 4
    IL_0115: ldc.i4.1
    IL_0116: sub
    IL_0117: stloc.s 4
    IL_0119: ldloc.s 4
    IL_011b: ldc.i4.0
    IL_011c: bge.s IL_00d9
    IL_011e: ldloc.2
    IL_011f: callvirt List.Enumerator<!0> System.Collections.Generic.List<TFUIEquippable>::GetEnumerator()  /*0x0A0006DD*/
    IL_0124: stloc.s 5
    IL_0126: br.s IL_0153
    IL_0128: ldloca.s 5
    IL_012a: call !0 System.Collections.Generic.List.Enumerator<TFUIEquippable>::get_Current()  /*0x0A0006DE*/
    IL_012f: stloc.s 6
    IL_0131: ldloc.s 6
    IL_0133: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_0138: ldc.i4.0
    IL_0139: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_013e: ldloc.s 6
    IL_0140: callvirt void TFUIEquippable::UnPick()  /*0x0600120D*/
    IL_0145: ldarg.0
    IL_0146: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_014b: ldloc.s 6
    IL_014d: callvirt bool System.Collections.Generic.List<TFUIEquippable>::Remove(!0)  /*0x0A0006DA*/
    IL_0152: pop
    IL_0153: ldloca.s 5
    IL_0155: call bool System.Collections.Generic.List.Enumerator<TFUIEquippable>::MoveNext()  /*0x0A0006DF*/
    IL_015a: brtrue.s IL_0128
    IL_015c: leave.s IL_016c
    IL_015e: ldloca.s 5
    IL_0160: constrained. System.Collections.Generic.List.Enumerator<TFUIEquippable>  /*0x1B000140*/
    IL_0166: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_016b: endfinally
    IL_016c: ldarg.0
    IL_016d: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_0172: ldloc.0
    IL_0173: callvirt bool System.Collections.Generic.List<TFUIEquippable>::Contains(!0)  /*0x0A0006E0*/
    IL_0178: brfalse.s IL_019b
    IL_017a: ldloc.0
    IL_017b: callvirt void TFUIEquippable::UnPick()  /*0x0600120D*/
    IL_0180: ldloc.0
    IL_0181: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_0186: ldc.i4.0
    IL_0187: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_018c: ldarg.0
    IL_018d: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_0192: ldloc.0
    IL_0193: callvirt bool System.Collections.Generic.List<TFUIEquippable>::Remove(!0)  /*0x0A0006DA*/
    IL_0198: pop
    IL_0199: br.s IL_01b9
    IL_019b: ldloc.0
    IL_019c: callvirt void TFUIEquippable::Pick()  /*0x0600120C*/
    IL_01a1: ldloc.0
    IL_01a2: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_01a7: ldc.i4.1
    IL_01a8: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_01ad: ldarg.0
    IL_01ae: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_01b3: ldloc.0
    IL_01b4: callvirt void System.Collections.Generic.List<TFUIEquippable>::Add(!0)  /*0x0A0006DB*/
    IL_01b9: ldloc.0
    IL_01ba: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_01bf: isinst EquippableMutation  /*0x02000219*/
    IL_01c4: brfalse.s IL_0213
    IL_01c6: ldarg.0
    IL_01c7: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedMutators  /*0x04001495*/
    IL_01cc: ldloc.0
    IL_01cd: callvirt bool System.Collections.Generic.List<TFUIEquippable>::Contains(!0)  /*0x0A0006E0*/
    IL_01d2: brfalse.s IL_01f5
    IL_01d4: ldloc.0
    IL_01d5: callvirt void TFUIEquippable::UnPick()  /*0x0600120D*/
    IL_01da: ldloc.0
    IL_01db: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_01e0: ldc.i4.0
    IL_01e1: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_01e6: ldarg.0
    IL_01e7: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedMutators  /*0x04001495*/
    IL_01ec: ldloc.0
    IL_01ed: callvirt bool System.Collections.Generic.List<TFUIEquippable>::Remove(!0)  /*0x0A0006DA*/
    IL_01f2: pop
    IL_01f3: br.s IL_0213
    IL_01f5: ldloc.0
    IL_01f6: callvirt void TFUIEquippable::Pick()  /*0x0600120C*/
    IL_01fb: ldloc.0
    IL_01fc: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_0201: ldc.i4.1
    IL_0202: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_0207: ldarg.0
    IL_0208: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedMutators  /*0x04001495*/
    IL_020d: ldloc.0
    IL_020e: callvirt void System.Collections.Generic.List<TFUIEquippable>::Add(!0)  /*0x0A0006DB*/
    IL_0213: ldarg.0
    IL_0214: call void LoadoutUIHelper::UpdatePerkPointsRemainingText()  /*0x06001141*/
    IL_0219: ldarg.0
    IL_021a: call bool LoadoutUIHelper::get_DrawMutators()  /*0x06001138*/
    IL_021f: brfalse.s IL_0227
    IL_0221: ldarg.0
    IL_0222: call void LoadoutUIHelper::UpdateMutatorBonusText()  /*0x06001142*/
    IL_0227: ret
    .try IL_0126-IL_015e finally handler IL_015e-IL_016c

  .method LoadoutUIHelper::RecomputeNavigation()  // token 0x0600113F rva 0x50f74 attrs Private, HideBySig
    // code size 378 (0x17a), max stack 7, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld GridLayoutGroup LoadoutUIHelper::weaponsParent  /*0x04001489*/
    IL_0006: callvirt int UnityEngine.UI.GridLayoutGroup::get_constraintCount()  /*0x0A000643*/
    IL_000b: stloc.0
    IL_000c: ldarg.0
    IL_000d: call bool LoadoutUIHelper::get_DrawMutators()  /*0x06001138*/
    IL_0012: brfalse IL_00b0
    IL_0017: ldarg.0
    IL_0018: ldarg.0
    IL_0019: ldfld List<TFUIEquippable> LoadoutUIHelper::weapons  /*0x04001490*/
    IL_001e: ldarg.0
    IL_001f: ldfld ThronefallUIElement LoadoutUIHelper::playButton  /*0x04001488*/
    IL_0024: ldnull
    IL_0025: ldnull
    IL_0026: ldarg.0
    IL_0027: ldfld List<TFUIEquippable> LoadoutUIHelper::perks  /*0x04001491*/
    IL_002c: ldloc.0
    IL_002d: call void LoadoutUIHelper::AssignNavigationTargets(System.Collections.Generic.List<TFUIEquippable>,ThronefallUIElement,System.Collections.Generic.List<TFUIEquippable>,ThronefallUIElement,System.Collections.Generic.List<TFUIEquippable>,int)  /*0x06001143*/
    IL_0032: ldarg.0
    IL_0033: ldarg.0
    IL_0034: ldfld List<TFUIEquippable> LoadoutUIHelper::perks  /*0x04001491*/
    IL_0039: ldnull
    IL_003a: ldarg.0
    IL_003b: ldfld List<TFUIEquippable> LoadoutUIHelper::weapons  /*0x04001490*/
    IL_0040: ldnull
    IL_0041: ldarg.0
    IL_0042: ldfld List<TFUIEquippable> LoadoutUIHelper::mutators  /*0x04001492*/
    IL_0047: ldloc.0
    IL_0048: call void LoadoutUIHelper::AssignNavigationTargets(System.Collections.Generic.List<TFUIEquippable>,ThronefallUIElement,System.Collections.Generic.List<TFUIEquippable>,ThronefallUIElement,System.Collections.Generic.List<TFUIEquippable>,int)  /*0x06001143*/
    IL_004d: ldarg.0
    IL_004e: ldarg.0
    IL_004f: ldfld List<TFUIEquippable> LoadoutUIHelper::mutators  /*0x04001492*/
    IL_0054: ldnull
    IL_0055: ldarg.0
    IL_0056: ldfld List<TFUIEquippable> LoadoutUIHelper::perks  /*0x04001491*/
    IL_005b: ldarg.0
    IL_005c: ldfld ThronefallUIElement LoadoutUIHelper::playButton  /*0x04001488*/
    IL_0061: ldnull
    IL_0062: ldloc.0
    IL_0063: call void LoadoutUIHelper::AssignNavigationTargets(System.Collections.Generic.List<TFUIEquippable>,ThronefallUIElement,System.Collections.Generic.List<TFUIEquippable>,ThronefallUIElement,System.Collections.Generic.List<TFUIEquippable>,int)  /*0x06001143*/
    IL_0068: ldarg.0
    IL_0069: ldfld ThronefallUIElement LoadoutUIHelper::playButton  /*0x04001488*/
    IL_006e: ldarg.0
    IL_006f: ldfld List<TFUIEquippable> LoadoutUIHelper::mutators  /*0x04001492*/
    IL_0074: ldarg.0
    IL_0075: ldfld List<TFUIEquippable> LoadoutUIHelper::mutators  /*0x04001492*/
    IL_007a: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_007f: ldc.i4.1
    IL_0080: sub
    IL_0081: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0086: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_008b: ldarg.0
    IL_008c: ldfld ThronefallUIElement LoadoutUIHelper::playButton  /*0x04001488*/
    IL_0091: ldarg.0
    IL_0092: ldfld List<TFUIEquippable> LoadoutUIHelper::mutators  /*0x04001492*/
    IL_0097: ldarg.0
    IL_0098: ldfld List<TFUIEquippable> LoadoutUIHelper::mutators  /*0x04001492*/
    IL_009d: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_00a2: ldc.i4.1
    IL_00a3: sub
    IL_00a4: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_00a9: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_00ae: br.s IL_012c
    IL_00b0: ldarg.0
    IL_00b1: ldarg.0
    IL_00b2: ldfld List<TFUIEquippable> LoadoutUIHelper::weapons  /*0x04001490*/
    IL_00b7: ldarg.0
    IL_00b8: ldfld ThronefallUIElement LoadoutUIHelper::playButton  /*0x04001488*/
    IL_00bd: ldnull
    IL_00be: ldnull
    IL_00bf: ldarg.0
    IL_00c0: ldfld List<TFUIEquippable> LoadoutUIHelper::perks  /*0x04001491*/
    IL_00c5: ldloc.0
    IL_00c6: call void LoadoutUIHelper::AssignNavigationTargets(System.Collections.Generic.List<TFUIEquippable>,ThronefallUIElement,System.Collections.Generic.List<TFUIEquippable>,ThronefallUIElement,System.Collections.Generic.List<TFUIEquippable>,int)  /*0x06001143*/
    IL_00cb: ldarg.0
    IL_00cc: ldarg.0
    IL_00cd: ldfld List<TFUIEquippable> LoadoutUIHelper::perks  /*0x04001491*/
    IL_00d2: ldnull
    IL_00d3: ldarg.0
    IL_00d4: ldfld List<TFUIEquippable> LoadoutUIHelper::weapons  /*0x04001490*/
    IL_00d9: ldarg.0
    IL_00da: ldfld ThronefallUIElement LoadoutUIHelper::playButton  /*0x04001488*/
    IL_00df: ldnull
    IL_00e0: ldloc.0
    IL_00e1: call void LoadoutUIHelper::AssignNavigationTargets(System.Collections.Generic.List<TFUIEquippable>,ThronefallUIElement,System.Collections.Generic.List<TFUIEquippable>,ThronefallUIElement,System.Collections.Generic.List<TFUIEquippable>,int)  /*0x06001143*/
    IL_00e6: ldarg.0
    IL_00e7: ldfld ThronefallUIElement LoadoutUIHelper::playButton  /*0x04001488*/
    IL_00ec: ldarg.0
    IL_00ed: ldfld List<TFUIEquippable> LoadoutUIHelper::perks  /*0x04001491*/
    IL_00f2: ldarg.0
    IL_00f3: ldfld List<TFUIEquippable> LoadoutUIHelper::perks  /*0x04001491*/
    IL_00f8: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_00fd: ldc.i4.1
    IL_00fe: sub
    IL_00ff: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0104: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0109: ldarg.0
    IL_010a: ldfld ThronefallUIElement LoadoutUIHelper::playButton  /*0x04001488*/
    IL_010f: ldarg.0
    IL_0110: ldfld List<TFUIEquippable> LoadoutUIHelper::perks  /*0x04001491*/
    IL_0115: ldarg.0
    IL_0116: ldfld List<TFUIEquippable> LoadoutUIHelper::perks  /*0x04001491*/
    IL_011b: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_0120: ldc.i4.1
    IL_0121: sub
    IL_0122: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0127: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_012c: ldarg.0
    IL_012d: ldfld ThronefallUIElement LoadoutUIHelper::playButton  /*0x04001488*/
    IL_0132: ldarg.0
    IL_0133: ldfld List<TFUIEquippable> LoadoutUIHelper::weapons  /*0x04001490*/
    IL_0138: ldc.i4.0
    IL_0139: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_013e: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0143: ldarg.0
    IL_0144: ldfld ThronefallUIElement LoadoutUIHelper::playButton  /*0x04001488*/
    IL_0149: ldarg.0
    IL_014a: ldfld List<TFUIEquippable> LoadoutUIHelper::weapons  /*0x04001490*/
    IL_014f: ldc.i4.0
    IL_0150: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0155: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_015a: ldarg.0
    IL_015b: ldfld bool LoadoutUIHelper::autoSelectPlay  /*0x04001481*/
    IL_0160: brtrue.s IL_0179
    IL_0162: ldarg.0
    IL_0163: call !!0 UnityEngine.Component::GetComponent()<UIFrame>  /*0x2B0000E8*/
    IL_0168: ldarg.0
    IL_0169: ldfld List<TFUIEquippable> LoadoutUIHelper::weapons  /*0x04001490*/
    IL_016e: ldc.i4.0
    IL_016f: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0174: stfld ThronefallUIElement UIFrame::firstSelected  /*0x040016DA*/
    IL_0179: ret

  .method LoadoutUIHelper::RewriteQuestTexts()  // token 0x06001140 rva 0x510fc attrs Private, HideBySig
    // code size 212 (0xd4), max stack 5, init locals
    .locals ([0] int, [1] LevelInfo, [2] int, [3] Scene, [4] List.Enumerator<Quest>, [5] Quest)
    IL_0000: ldarg.0
    IL_0001: call bool LoadoutUIHelper::get_DrawQuests()  /*0x06001137*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld Transform LoadoutUIHelper::questsParent  /*0x0400148D*/
    IL_000f: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0014: ldc.i4.1
    IL_0015: sub
    IL_0016: stloc.2
    IL_0017: br.s IL_0033
    IL_0019: ldarg.0
    IL_001a: ldfld Transform LoadoutUIHelper::questsParent  /*0x0400148D*/
    IL_001f: ldloc.2
    IL_0020: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0025: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002a: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_002f: ldloc.2
    IL_0030: ldc.i4.1
    IL_0031: sub
    IL_0032: stloc.2
    IL_0033: ldloc.2
    IL_0034: ldc.i4.0
    IL_0035: bge.s IL_0019
    IL_0037: ldc.i4.0
    IL_0038: stloc.0
    IL_0039: ldnull
    IL_003a: stloc.1
    IL_003b: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_0040: ldnull
    IL_0041: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0046: brfalse.s IL_004e
    IL_0048: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_004d: stloc.1
    IL_004e: ldloc.1
    IL_004f: ldnull
    IL_0050: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0055: brfalse.s IL_006f
    IL_0057: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_005c: call Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()  /*0x0A000292*/
    IL_0061: stloc.3
    IL_0062: ldloca.s 3
    IL_0064: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_0069: callvirt LevelInfo LevelProgressManager::GetLevelInfoFromSceneName(string)  /*0x06000944*/
    IL_006e: stloc.1
    IL_006f: ldloc.1
    IL_0070: ldnull
    IL_0071: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0076: brfalse.s IL_00d3
    IL_0078: ldloc.1
    IL_0079: ldfld List<Quest> LevelInfo::quests  /*0x04000B29*/
    IL_007e: callvirt List.Enumerator<!0> System.Collections.Generic.List<Quest>::GetEnumerator()  /*0x0A0006E1*/
    IL_0083: stloc.s 4
    IL_0085: br.s IL_00ba
    IL_0087: ldloca.s 4
    IL_0089: call !0 System.Collections.Generic.List.Enumerator<Quest>::get_Current()  /*0x0A0006E2*/
    IL_008e: stloc.s 5
    IL_0090: ldarg.0
    IL_0091: ldfld QuestEntry LoadoutUIHelper::questEntryPrefab  /*0x0400148E*/
    IL_0096: ldarg.0
    IL_0097: ldfld Transform LoadoutUIHelper::questsParent  /*0x0400148D*/
    IL_009c: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<QuestEntry>  /*0x2B0000FB*/
    IL_00a1: ldloc.s 5
    IL_00a3: ldloc.0
    IL_00a4: ldloc.s 5
    IL_00a6: ldloc.1
    IL_00a7: callvirt LevelData LevelInfo::get_LevelData()  /*0x060008E3*/
    IL_00ac: callvirt bool Quest::CheckBeaten(LevelData)  /*0x06000CA5*/
    IL_00b1: callvirt void QuestEntry::Init(Quest,int,bool)  /*0x06001192*/
    IL_00b6: ldloc.0
    IL_00b7: ldc.i4.1
    IL_00b8: add
    IL_00b9: stloc.0
    IL_00ba: ldloca.s 4
    IL_00bc: call bool System.Collections.Generic.List.Enumerator<Quest>::MoveNext()  /*0x0A0006E3*/
    IL_00c1: brtrue.s IL_0087
    IL_00c3: leave.s IL_00d3
    IL_00c5: ldloca.s 4
    IL_00c7: constrained. System.Collections.Generic.List.Enumerator<Quest>  /*0x1B000141*/
    IL_00cd: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00d2: endfinally
    IL_00d3: ret
    .try IL_0085-IL_00c5 finally handler IL_00c5-IL_00d3

  .method LoadoutUIHelper::UpdatePerkPointsRemainingText()  // token 0x06001141 rva 0x511ec attrs Private, HideBySig
    // code size 207 (0xcf), max stack 9, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: call bool LoadoutUIHelper::get_HasFixedLoadout()  /*0x06001139*/
    IL_0006: brtrue.s IL_0011
    IL_0008: ldarg.0
    IL_0009: ldfld LocalGamestate.GameMode LoadoutUIHelper::mode  /*0x04001483*/
    IL_000e: ldc.i4.1
    IL_000f: bne.un.s IL_002c
    IL_0011: ldarg.0
    IL_0012: ldfld TextMeshProUGUI LoadoutUIHelper::perksText  /*0x04001485*/
    IL_0017: ldstr "Menu/Perks"
    IL_001c: ldc.i4.1
    IL_001d: ldc.i4.0
    IL_001e: ldc.i4.1
    IL_001f: ldc.i4.1
    IL_0020: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0025: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_002a: br.s IL_0094
    IL_002c: ldarg.0
    IL_002d: ldfld TextMeshProUGUI LoadoutUIHelper::perksText  /*0x04001485*/
    IL_0032: ldc.i4.6
    IL_0033: newarr System.String  /*0x0100001D*/
    IL_0038: dup
    IL_0039: ldc.i4.0
    IL_003a: ldstr "Menu/Perks"
    IL_003f: ldc.i4.1
    IL_0040: ldc.i4.0
    IL_0041: ldc.i4.1
    IL_0042: ldc.i4.1
    IL_0043: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0048: stelem.ref
    IL_0049: dup
    IL_004a: ldc.i4.1
    IL_004b: ldstr " ("
    IL_0050: stelem.ref
    IL_0051: dup
    IL_0052: ldc.i4.2
    IL_0053: ldarg.0
    IL_0054: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_0059: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_005e: stloc.0
    IL_005f: ldloca.s 0
    IL_0061: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0066: stelem.ref
    IL_0067: dup
    IL_0068: ldc.i4.3
    IL_0069: ldstr "/"
    IL_006e: stelem.ref
    IL_006f: dup
    IL_0070: ldc.i4.4
    IL_0071: ldarg.0
    IL_0072: ldfld LevelInfo LoadoutUIHelper::levelInfo  /*0x04001499*/
    IL_0077: ldflda int LevelInfo::maxPerkCount  /*0x04000B2B*/
    IL_007c: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0081: stelem.ref
    IL_0082: dup
    IL_0083: ldc.i4.5
    IL_0084: ldstr ")"
    IL_0089: stelem.ref
    IL_008a: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_008f: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0094: ldarg.0
    IL_0095: ldfld LocalGamestate.GameMode LoadoutUIHelper::mode  /*0x04001483*/
    IL_009a: ldc.i4.1
    IL_009b: bne.un.s IL_00af
    IL_009d: ldarg.0
    IL_009e: ldfld TextMeshProUGUI LoadoutUIHelper::currentEternalTrialBalanceText  /*0x04001487*/
    IL_00a3: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00a8: ldc.i4.1
    IL_00a9: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00ae: ret
    IL_00af: ldarg.0
    IL_00b0: ldfld TextMeshProUGUI LoadoutUIHelper::currentEternalTrialBalanceText  /*0x04001487*/
    IL_00b5: ldnull
    IL_00b6: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00bb: brfalse.s IL_00ce
    IL_00bd: ldarg.0
    IL_00be: ldfld TextMeshProUGUI LoadoutUIHelper::currentEternalTrialBalanceText  /*0x04001487*/
    IL_00c3: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00c8: ldc.i4.0
    IL_00c9: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00ce: ret

  .method LoadoutUIHelper::UpdateMutatorBonusText()  // token 0x06001142 rva 0x512c8 attrs Private, HideBySig
    // code size 248 (0xf8), max stack 9, init locals
    .locals ([0] float, [1] string, [2] List.Enumerator<TFUIEquippable>, [3] EquippableMutation)
    IL_0000: ldarg.0
    IL_0001: call bool LoadoutUIHelper::get_DrawMutators()  /*0x06001138*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedMutators  /*0x04001495*/
    IL_000f: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_0014: ldc.i4.0
    IL_0015: ble IL_00e6
    IL_001a: ldarg.0
    IL_001b: ldfld TextMeshProUGUI LoadoutUIHelper::mutatorBonusText  /*0x04001486*/
    IL_0020: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0025: ldc.i4.1
    IL_0026: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_002b: ldc.r4 1f
    IL_0030: stloc.0
    IL_0031: ldarg.0
    IL_0032: ldfld List<TFUIEquippable> LoadoutUIHelper::equippedMutators  /*0x04001495*/
    IL_0037: callvirt List.Enumerator<!0> System.Collections.Generic.List<TFUIEquippable>::GetEnumerator()  /*0x0A0006DD*/
    IL_003c: stloc.2
    IL_003d: br.s IL_0063
    IL_003f: ldloca.s 2
    IL_0041: call !0 System.Collections.Generic.List.Enumerator<TFUIEquippable>::get_Current()  /*0x0A0006DE*/
    IL_0046: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_004b: isinst EquippableMutation  /*0x02000219*/
    IL_0050: stloc.3
    IL_0051: ldloc.3
    IL_0052: ldnull
    IL_0053: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0058: brtrue.s IL_0063
    IL_005a: ldloc.0
    IL_005b: ldloc.3
    IL_005c: ldfld float EquippableMutation::scoreMultiplyerOnWin  /*0x04000E43*/
    IL_0061: mul
    IL_0062: stloc.0
    IL_0063: ldloca.s 2
    IL_0065: call bool System.Collections.Generic.List.Enumerator<TFUIEquippable>::MoveNext()  /*0x0A0006DF*/
    IL_006a: brtrue.s IL_003f
    IL_006c: leave.s IL_007c
    IL_006e: ldloca.s 2
    IL_0070: constrained. System.Collections.Generic.List.Enumerator<TFUIEquippable>  /*0x1B000140*/
    IL_0076: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_007b: endfinally
    IL_007c: ldloc.0
    IL_007d: ldc.r4 1f
    IL_0082: sub
    IL_0083: stloc.0
    IL_0084: ldloc.0
    IL_0085: ldc.r4 100f
    IL_008a: mul
    IL_008b: stloc.0
    IL_008c: ldstr ""
    IL_0091: stloc.1
    IL_0092: ldloc.0
    IL_0093: ldc.r4 0f
    IL_0098: blt.un.s IL_00a6
    IL_009a: ldloc.1
    IL_009b: ldstr "+"
    IL_00a0: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00a5: stloc.1
    IL_00a6: ldloc.1
    IL_00a7: ldloca.s 0
    IL_00a9: ldstr "F0"
    IL_00ae: call string System.Single::ToString(string)  /*0x0A000623*/
    IL_00b3: ldstr "%"
    IL_00b8: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_00bd: stloc.1
    IL_00be: ldarg.0
    IL_00bf: ldfld TextMeshProUGUI LoadoutUIHelper::mutatorBonusText  /*0x04001486*/
    IL_00c4: ldstr "Menu/Mutator Bonus Preview"
    IL_00c9: ldc.i4.1
    IL_00ca: ldc.i4.0
    IL_00cb: ldc.i4.1
    IL_00cc: ldc.i4.0
    IL_00cd: ldnull
    IL_00ce: ldnull
    IL_00cf: ldc.i4.1
    IL_00d0: call string I2.Loc.LocalizationManager::GetTermTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001856*/
    IL_00d5: ldstr ": <style=Body Bold>"
    IL_00da: ldloc.1
    IL_00db: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_00e0: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00e5: ret
    IL_00e6: ldarg.0
    IL_00e7: ldfld TextMeshProUGUI LoadoutUIHelper::mutatorBonusText  /*0x04001486*/
    IL_00ec: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00f1: ldc.i4.0
    IL_00f2: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00f7: ret
    .try IL_003d-IL_006e finally handler IL_006e-IL_007c

  .method LoadoutUIHelper::AssignNavigationTargets(System.Collections.Generic.List<TFUIEquippable>,ThronefallUIElement,System.Collections.Generic.List<TFUIEquippable>,ThronefallUIElement,System.Collections.Generic.List<TFUIEquippable>,int)  // token 0x06001143 rva 0x513dc attrs Private, HideBySig
    // code size 474 (0x1da), max stack 4, init locals
    .locals ([0] int, [1] TFUIEquippable, [2] int, [3] int, [4] int, [5] int, [6] int, [7] int, [8] int, [9] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br IL_01cd
    IL_0007: ldarg.1
    IL_0008: ldloc.0
    IL_0009: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_000e: stloc.1
    IL_000f: ldloc.0
    IL_0010: ldc.i4.1
    IL_0011: sub
    IL_0012: stloc.2
    IL_0013: ldloc.0
    IL_0014: ldc.i4.1
    IL_0015: add
    IL_0016: stloc.3
    IL_0017: ldloc.0
    IL_0018: ldarg.s 6
    IL_001a: add
    IL_001b: stloc.s 4
    IL_001d: ldloc.0
    IL_001e: ldarg.s 6
    IL_0020: sub
    IL_0021: stloc.s 5
    IL_0023: ldloc.2
    IL_0024: ldc.i4.0
    IL_0025: bge.s IL_004f
    IL_0027: ldarg.2
    IL_0028: ldnull
    IL_0029: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002e: brfalse.s IL_0039
    IL_0030: ldloc.1
    IL_0031: ldarg.2
    IL_0032: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_0037: br.s IL_005c
    IL_0039: ldloc.1
    IL_003a: ldarg.3
    IL_003b: ldarg.3
    IL_003c: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_0041: ldc.i4.1
    IL_0042: sub
    IL_0043: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0048: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_004d: br.s IL_005c
    IL_004f: ldloc.1
    IL_0050: ldarg.1
    IL_0051: ldloc.2
    IL_0052: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0057: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_005c: ldloc.3
    IL_005d: ldarg.1
    IL_005e: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_0063: blt.s IL_0089
    IL_0065: ldarg.s 4
    IL_0067: ldnull
    IL_0068: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_006d: brfalse.s IL_0079
    IL_006f: ldloc.1
    IL_0070: ldarg.s 4
    IL_0072: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_0077: br.s IL_0096
    IL_0079: ldloc.1
    IL_007a: ldarg.s 5
    IL_007c: ldc.i4.0
    IL_007d: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0082: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_0087: br.s IL_0096
    IL_0089: ldloc.1
    IL_008a: ldarg.1
    IL_008b: ldloc.3
    IL_008c: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0091: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_0096: ldloc.s 4
    IL_0098: ldarg.1
    IL_0099: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_009e: blt IL_0139
    IL_00a3: ldarg.1
    IL_00a4: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_00a9: ldarg.s 6
    IL_00ab: rem
    IL_00ac: brtrue.s IL_00bf
    IL_00ae: ldarg.1
    IL_00af: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_00b4: ldloc.0
    IL_00b5: sub
    IL_00b6: ldarg.s 6
    IL_00b8: cgt
    IL_00ba: ldc.i4.0
    IL_00bb: ceq
    IL_00bd: br.s IL_00c0
    IL_00bf: ldc.i4.0
    IL_00c0: brtrue.s IL_00eb
    IL_00c2: ldarg.1
    IL_00c3: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_00c8: ldloc.0
    IL_00c9: sub
    IL_00ca: ldarg.1
    IL_00cb: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_00d0: ldarg.s 6
    IL_00d2: rem
    IL_00d3: ble.s IL_00eb
    IL_00d5: ldloc.1
    IL_00d6: ldarg.1
    IL_00d7: ldarg.1
    IL_00d8: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_00dd: ldc.i4.1
    IL_00de: sub
    IL_00df: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_00e4: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_00e9: br.s IL_0147
    IL_00eb: ldarg.s 4
    IL_00ed: ldnull
    IL_00ee: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00f3: brfalse.s IL_00ff
    IL_00f5: ldloc.1
    IL_00f6: ldarg.s 4
    IL_00f8: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_00fd: br.s IL_0147
    IL_00ff: ldloc.0
    IL_0100: ldarg.s 6
    IL_0102: rem
    IL_0103: stloc.s 6
    IL_0105: ldarg.s 5
    IL_0107: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_010c: ldloc.s 6
    IL_010e: bge.s IL_0128
    IL_0110: ldloc.1
    IL_0111: ldarg.s 5
    IL_0113: ldarg.s 5
    IL_0115: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_011a: ldc.i4.1
    IL_011b: sub
    IL_011c: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0121: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0126: br.s IL_0147
    IL_0128: ldloc.1
    IL_0129: ldarg.s 5
    IL_012b: ldloc.s 6
    IL_012d: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0132: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0137: br.s IL_0147
    IL_0139: ldloc.1
    IL_013a: ldarg.1
    IL_013b: ldloc.s 4
    IL_013d: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0142: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0147: ldloc.s 5
    IL_0149: ldc.i4.0
    IL_014a: bge.s IL_01bb
    IL_014c: ldarg.2
    IL_014d: ldnull
    IL_014e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0153: brfalse.s IL_015e
    IL_0155: ldloc.1
    IL_0156: ldarg.2
    IL_0157: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_015c: br.s IL_01c9
    IL_015e: ldloc.0
    IL_015f: ldarg.s 6
    IL_0161: rem
    IL_0162: stloc.s 7
    IL_0164: ldarg.3
    IL_0165: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_016a: ldarg.s 6
    IL_016c: rem
    IL_016d: stloc.s 8
    IL_016f: ldloc.s 7
    IL_0171: ldloc.s 8
    IL_0173: ble.s IL_018b
    IL_0175: ldloc.1
    IL_0176: ldarg.3
    IL_0177: ldarg.3
    IL_0178: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_017d: ldc.i4.1
    IL_017e: sub
    IL_017f: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_0184: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0189: br.s IL_01c9
    IL_018b: ldarg.3
    IL_018c: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_0191: ldloc.s 8
    IL_0193: sub
    IL_0194: ldloc.s 7
    IL_0196: add
    IL_0197: stloc.s 9
    IL_0199: ldloc.s 9
    IL_019b: ldc.i4.0
    IL_019c: ldarg.3
    IL_019d: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_01a2: ldc.i4.1
    IL_01a3: sub
    IL_01a4: call int UnityEngine.Mathf::Clamp(int,int,int)  /*0x0A000228*/
    IL_01a9: stloc.s 9
    IL_01ab: ldloc.1
    IL_01ac: ldarg.3
    IL_01ad: ldloc.s 9
    IL_01af: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_01b4: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_01b9: br.s IL_01c9
    IL_01bb: ldloc.1
    IL_01bc: ldarg.1
    IL_01bd: ldloc.s 5
    IL_01bf: callvirt !0 System.Collections.Generic.List<TFUIEquippable>::get_Item(int)  /*0x0A0006D9*/
    IL_01c4: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_01c9: ldloc.0
    IL_01ca: ldc.i4.1
    IL_01cb: add
    IL_01cc: stloc.0
    IL_01cd: ldloc.0
    IL_01ce: ldarg.1
    IL_01cf: callvirt int System.Collections.Generic.List<TFUIEquippable>::get_Count()  /*0x0A0006D6*/
    IL_01d4: blt IL_0007
    IL_01d9: ret

  .method LoadoutUIHelper::ResetToBufferedLoadout()  // token 0x06001144 rva 0x515c4 attrs Public, HideBySig
    // code size 119 (0x77), max stack 2, init locals
    .locals ([0] List.Enumerator<Equippable>)
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_000a: callvirt !0[] System.Collections.Generic.List<Equippable>::ToArray()  /*0x0A0006D7*/
    IL_000f: newobj void System.Collections.Generic.List<Equippable>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000430*/
    IL_0014: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_0019: stloc.0
    IL_001a: br.s IL_0029
    IL_001c: ldloca.s 0
    IL_001e: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_0023: ldc.i4.0
    IL_0024: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_0029: ldloca.s 0
    IL_002b: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_0030: brtrue.s IL_001c
    IL_0032: leave.s IL_0042
    IL_0034: ldloca.s 0
    IL_0036: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_003c: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0041: endfinally
    IL_0042: ldarg.0
    IL_0043: ldfld List<Equippable> LoadoutUIHelper::lastLoadout  /*0x0400149A*/
    IL_0048: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_004d: stloc.0
    IL_004e: br.s IL_005d
    IL_0050: ldloca.s 0
    IL_0052: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_0057: ldc.i4.1
    IL_0058: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_005d: ldloca.s 0
    IL_005f: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_0064: brtrue.s IL_0050
    IL_0066: leave.s IL_0076
    IL_0068: ldloca.s 0
    IL_006a: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_0070: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0075: endfinally
    IL_0076: ret
    .try IL_001a-IL_0034 finally handler IL_0034-IL_0042
    .try IL_004e-IL_0068 finally handler IL_0068-IL_0076

  .method LoadoutUIHelper::.ctor()  // token 0x06001145 rva 0x51664 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 102 (0x66), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TFUIEquippable>::.ctor()  /*0x0A0006DC*/
    IL_0006: stfld List<TFUIEquippable> LoadoutUIHelper::weapons  /*0x04001490*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<TFUIEquippable>::.ctor()  /*0x0A0006DC*/
    IL_0011: stfld List<TFUIEquippable> LoadoutUIHelper::perks  /*0x04001491*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<TFUIEquippable>::.ctor()  /*0x0A0006DC*/
    IL_001c: stfld List<TFUIEquippable> LoadoutUIHelper::mutators  /*0x04001492*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<TFUIEquippable>::.ctor()  /*0x0A0006DC*/
    IL_0027: stfld List<TFUIEquippable> LoadoutUIHelper::equippedWeapons  /*0x04001493*/
    IL_002c: ldarg.0
    IL_002d: newobj void System.Collections.Generic.List<TFUIEquippable>::.ctor()  /*0x0A0006DC*/
    IL_0032: stfld List<TFUIEquippable> LoadoutUIHelper::equippedPerks  /*0x04001494*/
    IL_0037: ldarg.0
    IL_0038: newobj void System.Collections.Generic.List<TFUIEquippable>::.ctor()  /*0x0A0006DC*/
    IL_003d: stfld List<TFUIEquippable> LoadoutUIHelper::equippedMutators  /*0x04001495*/
    IL_0042: ldarg.0
    IL_0043: ldc.i4.1
    IL_0044: stfld int LoadoutUIHelper::numberOfWeaponsAllowedToEquip  /*0x04001496*/
    IL_0049: ldarg.0
    IL_004a: ldc.i4 1000
    IL_004f: stfld int LoadoutUIHelper::numberOfMutatiomsAllowedToEquip  /*0x04001497*/
    IL_0054: ldarg.0
    IL_0055: newobj void System.Collections.Generic.List<Equippable>::.ctor()  /*0x0A0003D9*/
    IL_005a: stfld List<Equippable> LoadoutUIHelper::lastLoadout  /*0x0400149A*/
    IL_005f: ldarg.0
    IL_0060: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0065: ret

