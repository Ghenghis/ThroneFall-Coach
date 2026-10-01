// ===== ScoreManager  (token 0x02000261) =====
  .method ScoreManager::get_Instance()  // token 0x06000D10 rva 0x3bc7d attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld ScoreManager ScoreManager::instance  /*0x04000F9D*/
    IL_0005: ret

  .method ScoreManager::get_CurrentScore()  // token 0x06000D11 rva 0x3bc84 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int ScoreManager::currentScore  /*0x04000FA9*/
    IL_0006: ret

  .method ScoreManager::get_VictoryGoldBonus()  // token 0x06000D12 rva 0x3bc8c attrs Public, HideBySig, SpecialName
    // code size 24 (0x18), max stack 8
    IL_0000: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0005: callvirt int PlayerInteraction::get_TrueBalance()  /*0x06000C06*/
    IL_000a: conv.r4
    IL_000b: ldarg.0
    IL_000c: ldfld float ScoreManager::victoryGoldBonusMultiplyer  /*0x04000FB1*/
    IL_0011: mul
    IL_0012: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000298*/
    IL_0017: ret

  .method ScoreManager::get_VictoryMutatorBonus()  // token 0x06000D13 rva 0x3bca8 attrs Public, HideBySig, SpecialName
    // code size 122 (0x7a), max stack 3, init locals
    .locals ([0] float, [1] List.Enumerator<Equippable>, [2] Equippable)
    IL_0000: ldc.r4 1f
    IL_0005: stloc.0
    IL_0006: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_000b: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_0010: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_0015: stloc.1
    IL_0016: br.s IL_0045
    IL_0018: ldloca.s 1
    IL_001a: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_001f: stloc.2
    IL_0020: ldloc.2
    IL_0021: callvirt Type System.Object::GetType()  /*0x0A0002B4*/
    IL_0026: ldtoken EquippableMutation  /*0x02000219*/
    IL_002b: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_0030: call bool System.Type::op_Equality(System.Type,System.Type)  /*0x0A0002B6*/
    IL_0035: brfalse.s IL_0045
    IL_0037: ldloc.0
    IL_0038: ldloc.2
    IL_0039: castclass EquippableMutation  /*0x02000219*/
    IL_003e: ldfld float EquippableMutation::scoreMultiplyerOnWin  /*0x04000E43*/
    IL_0043: mul
    IL_0044: stloc.0
    IL_0045: ldloca.s 1
    IL_0047: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_004c: brtrue.s IL_0018
    IL_004e: leave.s IL_005e
    IL_0050: ldloca.s 1
    IL_0052: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_0058: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_005d: endfinally
    IL_005e: ldarg.0
    IL_005f: ldfld int ScoreManager::currentScore  /*0x04000FA9*/
    IL_0064: ldarg.0
    IL_0065: call int ScoreManager::get_VictoryGoldBonus()  /*0x06000D12*/
    IL_006a: add
    IL_006b: conv.r4
    IL_006c: ldloc.0
    IL_006d: ldc.r4 1f
    IL_0072: sub
    IL_0073: mul
    IL_0074: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000298*/
    IL_0079: ret
    .try IL_0016-IL_0050 finally handler IL_0050-IL_005e

  .method ScoreManager::get_DefeatNoRetryBonus()  // token 0x06000D14 rva 0x3bd40 attrs Public, HideBySig, SpecialName
    // code size 91 (0x5b), max stack 3, init locals
    IL_0000: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0005: brfalse.s IL_0015
    IL_0007: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_000c: ldfld bool MatchSave::hadRestarts  /*0x04000F90*/
    IL_0011: brfalse.s IL_0015
    IL_0013: ldc.i4.0
    IL_0014: ret
    IL_0015: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_001a: callvirt LevelInfo LevelProgressManager::GetLevelInfoFromCurrentSceneName()  /*0x06000945*/
    IL_001f: ldfld LevelInfo.ProgressionContribution LevelInfo::contribution  /*0x04000B26*/
    IL_0024: ldc.i4.1
    IL_0025: bne.un.s IL_0041
    IL_0027: ldarg.0
    IL_0028: ldfld int ScoreManager::currentScore  /*0x04000FA9*/
    IL_002d: conv.r4
    IL_002e: ldarg.0
    IL_002f: ldfld float ScoreManager::noRetryScoreMultiplierInMiniModes  /*0x04000FA8*/
    IL_0034: ldc.r4 1f
    IL_0039: sub
    IL_003a: mul
    IL_003b: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000298*/
    IL_0040: ret
    IL_0041: ldarg.0
    IL_0042: ldfld int ScoreManager::currentScore  /*0x04000FA9*/
    IL_0047: conv.r4
    IL_0048: ldarg.0
    IL_0049: ldfld float ScoreManager::noRetryScoreMultiplier  /*0x04000FA7*/
    IL_004e: ldc.r4 1f
    IL_0053: sub
    IL_0054: mul
    IL_0055: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000298*/
    IL_005a: ret

  .method ScoreManager::get_VictoryNoRetryBonus()  // token 0x06000D15 rva 0x3bda8 attrs Public, HideBySig, SpecialName
    // code size 119 (0x77), max stack 3, init locals
    IL_0000: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0005: brfalse.s IL_0015
    IL_0007: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_000c: ldfld bool MatchSave::hadRestarts  /*0x04000F90*/
    IL_0011: brfalse.s IL_0015
    IL_0013: ldc.i4.0
    IL_0014: ret
    IL_0015: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_001a: callvirt LevelInfo LevelProgressManager::GetLevelInfoFromCurrentSceneName()  /*0x06000945*/
    IL_001f: ldfld LevelInfo.ProgressionContribution LevelInfo::contribution  /*0x04000B26*/
    IL_0024: ldc.i4.1
    IL_0025: bne.un.s IL_004f
    IL_0027: ldarg.0
    IL_0028: ldfld int ScoreManager::currentScore  /*0x04000FA9*/
    IL_002d: ldarg.0
    IL_002e: call int ScoreManager::get_VictoryGoldBonus()  /*0x06000D12*/
    IL_0033: add
    IL_0034: ldarg.0
    IL_0035: call int ScoreManager::get_VictoryMutatorBonus()  /*0x06000D13*/
    IL_003a: add
    IL_003b: conv.r4
    IL_003c: ldarg.0
    IL_003d: ldfld float ScoreManager::noRetryScoreMultiplierInMiniModes  /*0x04000FA8*/
    IL_0042: ldc.r4 1f
    IL_0047: sub
    IL_0048: mul
    IL_0049: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000298*/
    IL_004e: ret
    IL_004f: ldarg.0
    IL_0050: ldfld int ScoreManager::currentScore  /*0x04000FA9*/
    IL_0055: ldarg.0
    IL_0056: call int ScoreManager::get_VictoryGoldBonus()  /*0x06000D12*/
    IL_005b: add
    IL_005c: ldarg.0
    IL_005d: call int ScoreManager::get_VictoryMutatorBonus()  /*0x06000D13*/
    IL_0062: add
    IL_0063: conv.r4
    IL_0064: ldarg.0
    IL_0065: ldfld float ScoreManager::noRetryScoreMultiplier  /*0x04000FA7*/
    IL_006a: ldc.r4 1f
    IL_006f: sub
    IL_0070: mul
    IL_0071: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000298*/
    IL_0076: ret

  .method ScoreManager::OnBeforeMainLoadPass(string)  // token 0x06000D16 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ScoreManager::OnAfterMainLoadPass(string)  // token 0x06000D17 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ScoreManager::OnLoad(string)  // token 0x06000D18 rva 0x3be2b attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 56 (0x38), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldstr "currentScore"
    IL_0006: ldarg.0
    IL_0007: ldflda int ScoreManager::currentScore  /*0x04000FA9*/
    IL_000c: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_0011: pop
    IL_0012: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0017: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_001c: brfalse.s IL_002c
    IL_001e: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0023: callvirt int EnemySpawner::get_WaveCount()  /*0x0600066D*/
    IL_0028: ldc.i4.2
    IL_0029: bge.s IL_002c
    IL_002b: ret
    IL_002c: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0031: ldc.i4.1
    IL_0032: stfld bool MatchSave::hadRestarts  /*0x04000F90*/
    IL_0037: ret

  .method ScoreManager::OnSave(string)  // token 0x06000D19 rva 0x3be64 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldstr "currentScore"
    IL_0006: ldarg.0
    IL_0007: ldfld int ScoreManager::currentScore  /*0x04000FA9*/
    IL_000c: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_0011: ret

  .method ScoreManager::Awake()  // token 0x06000D1A rva 0x3be77 attrs Private, HideBySig
    // code size 40 (0x28), max stack 8
    IL_0000: ldsfld ScoreManager ScoreManager::instance  /*0x04000F9D*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0021
    IL_000d: ldstr "More than one Scoremanger in Scene. Old Scoremanager destroyed."
    IL_0012: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_0017: ldsfld ScoreManager ScoreManager::instance  /*0x04000F9D*/
    IL_001c: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0021: ldarg.0
    IL_0022: stsfld ScoreManager ScoreManager::instance  /*0x04000F9D*/
    IL_0027: ret

  .method ScoreManager::Start()  // token 0x06000D1B rva 0x3bea0 attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0006: stfld EnemySpawner ScoreManager::enemySpawner  /*0x04000F9E*/
    IL_000b: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0010: ldarg.0
    IL_0011: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1f
    IL_001c: stfld float ScoreManager::scoreMultiplyerFromPerks  /*0x04000FB0*/
    IL_0021: ret

  .method ScoreManager::get_MaxScorePerNight()  // token 0x06000D1C rva 0x3bec3 attrs Public, HideBySig, SpecialName
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int ScoreManager::baseScorePerNight  /*0x04000F9F*/
    IL_0006: ldarg.0
    IL_0007: ldfld int ScoreManager::protectionScorePerNight  /*0x04000FA0*/
    IL_000c: add
    IL_000d: ldarg.0
    IL_000e: ldfld int ScoreManager::timeScorePerNight  /*0x04000FA1*/
    IL_0013: add
    IL_0014: conv.r4
    IL_0015: ldarg.0
    IL_0016: ldfld float ScoreManager::scoreMultiplyerFromPerks  /*0x04000FB0*/
    IL_001b: mul
    IL_001c: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0021: ret

  .method ScoreManager::CalculateEndOfNightScore()  // token 0x06000D1D rva 0x3bee8 attrs Public, HideBySig
    // code size 367 (0x16f), max stack 5, init locals
    .locals ([0] int, [1] int, [2] float, [3] float, [4] int, [5] List<TaggedObject>, [6] BuildingInteractor, [7] int, [8] float, [9] float, [10] int, [11] List.Enumerator<TaggedObject>)
    IL_0000: ldarg.0
    IL_0001: ldfld int ScoreManager::baseScorePerNight  /*0x04000F9F*/
    IL_0006: conv.r4
    IL_0007: ldarg.0
    IL_0008: ldfld float ScoreManager::scoreMultiplyerFromPerks  /*0x04000FB0*/
    IL_000d: mul
    IL_000e: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0013: stloc.0
    IL_0014: ldloc.0
    IL_0015: stloc.1
    IL_0016: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_001b: callvirt float DayNightCycle::get_CurrentNightLength()  /*0x060003A3*/
    IL_0020: stloc.2
    IL_0021: ldarg.0
    IL_0022: ldfld EnemySpawner ScoreManager::enemySpawner  /*0x04000F9E*/
    IL_0027: callvirt float EnemySpawner::get_LastSpawnPeriodDuration()  /*0x06000675*/
    IL_002c: stloc.3
    IL_002d: ldarg.0
    IL_002e: ldfld float ScoreManager::timeBonusMaxTime  /*0x04000FA4*/
    IL_0033: ldloc.3
    IL_0034: add
    IL_0035: ldarg.0
    IL_0036: ldfld float ScoreManager::timeBonusMinTime  /*0x04000FA3*/
    IL_003b: ldloc.3
    IL_003c: add
    IL_003d: ldloc.2
    IL_003e: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0043: ldarg.0
    IL_0044: ldfld float ScoreManager::scoreExponent  /*0x04000FA6*/
    IL_0049: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_004e: ldarg.0
    IL_004f: ldfld int ScoreManager::timeScorePerNight  /*0x04000FA1*/
    IL_0054: conv.r4
    IL_0055: mul
    IL_0056: ldarg.0
    IL_0057: ldfld float ScoreManager::scoreMultiplyerFromPerks  /*0x04000FB0*/
    IL_005c: mul
    IL_005d: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0062: stloc.s 4
    IL_0064: ldloc.1
    IL_0065: ldloc.s 4
    IL_0067: add
    IL_0068: stloc.1
    IL_0069: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_006e: stloc.s 5
    IL_0070: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0075: ldloc.s 5
    IL_0077: ldarg.0
    IL_0078: ldfld List<TagManager.ETag> ScoreManager::buildingTags  /*0x04000FAA*/
    IL_007d: ldnull
    IL_007e: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0083: ldc.i4.0
    IL_0084: stloc.s 7
    IL_0086: ldloc.s 5
    IL_0088: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_008d: stloc.s 11
    IL_008f: br.s IL_00c2
    IL_0091: ldloca.s 11
    IL_0093: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_0098: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_009d: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_00a2: ldc.i4.1
    IL_00a3: callvirt !!0 UnityEngine.Component::GetComponentInChildren(bool)<BuildingInteractor>  /*0x2B0000C4*/
    IL_00a8: stloc.s 6
    IL_00aa: ldloc.s 6
    IL_00ac: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00b1: brfalse.s IL_00c2
    IL_00b3: ldloc.s 6
    IL_00b5: callvirt bool BuildingInteractor::get_KnockedOutTonight()  /*0x06000BA2*/
    IL_00ba: brfalse.s IL_00c2
    IL_00bc: ldloc.s 7
    IL_00be: ldc.i4.1
    IL_00bf: add
    IL_00c0: stloc.s 7
    IL_00c2: ldloca.s 11
    IL_00c4: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_00c9: brtrue.s IL_0091
    IL_00cb: leave.s IL_00db
    IL_00cd: ldloca.s 11
    IL_00cf: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_00d5: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00da: endfinally
    IL_00db: ldc.r4 1f
    IL_00e0: ldc.r4 0f
    IL_00e5: ldloc.s 5
    IL_00e7: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_00ec: conv.r4
    IL_00ed: ldloc.s 7
    IL_00ef: conv.r4
    IL_00f0: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_00f5: sub
    IL_00f6: stloc.s 8
    IL_00f8: ldloc.s 8
    IL_00fa: stloc.s 9
    IL_00fc: ldloc.s 8
    IL_00fe: ldarg.0
    IL_00ff: ldfld float ScoreManager::scoreExponent  /*0x04000FA6*/
    IL_0104: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0109: stloc.s 8
    IL_010b: ldarg.0
    IL_010c: ldfld int ScoreManager::protectionScorePerNight  /*0x04000FA0*/
    IL_0111: conv.r4
    IL_0112: ldloc.s 8
    IL_0114: mul
    IL_0115: ldarg.0
    IL_0116: ldfld float ScoreManager::scoreMultiplyerFromPerks  /*0x04000FB0*/
    IL_011b: mul
    IL_011c: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0121: stloc.s 10
    IL_0123: ldloc.1
    IL_0124: ldloc.s 10
    IL_0126: add
    IL_0127: stloc.1
    IL_0128: ldarg.0
    IL_0129: ldarg.0
    IL_012a: ldfld int ScoreManager::currentScore  /*0x04000FA9*/
    IL_012f: ldloc.1
    IL_0130: add
    IL_0131: stfld int ScoreManager::currentScore  /*0x04000FA9*/
    IL_0136: ldarg.0
    IL_0137: ldfld UnityEvent<int, int, float, int> ScoreManager::OnNightScoreAdd  /*0x04000FAB*/
    IL_013c: ldloc.0
    IL_013d: ldloc.s 4
    IL_013f: ldloc.s 9
    IL_0141: ldloc.s 10
    IL_0143: callvirt void UnityEngine.Events.UnityEvent<int, int, float, int>::Invoke(!0,!1,!2,!3)  /*0x0A000573*/
    IL_0148: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_014d: callvirt LevelData LevelProgressManager::GetLevelDataForActiveScene()  /*0x0600094B*/
    IL_0152: dup
    IL_0153: ldarg.0
    IL_0154: ldfld int ScoreManager::currentScore  /*0x04000FA9*/
    IL_0159: stfld int LevelData::highscore  /*0x04000BBE*/
    IL_015e: ldfld List<int> LevelData::dayToDayScore  /*0x04000BBF*/
    IL_0163: ldarg.0
    IL_0164: ldfld int ScoreManager::currentScore  /*0x04000FA9*/
    IL_0169: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_016e: ret
    .try IL_008f-IL_00cd finally handler IL_00cd-IL_00db

  .method ScoreManager::OnDusk()  // token 0x06000D1E rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ScoreManager::OnDawn_AfterSunrise()  // token 0x06000D1F rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ScoreManager::OnDawn_BeforeSunrise()  // token 0x06000D20 rva 0x3c074 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ScoreManager::CalculateEndOfNightScore()  /*0x06000D1D*/
    IL_0006: ret

  .method ScoreManager::AddDebugPoints(int)  // token 0x06000D21 rva 0x3c07c attrs Public, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int ScoreManager::currentScore  /*0x04000FA9*/
    IL_0007: ldarg.1
    IL_0008: add
    IL_0009: stfld int ScoreManager::currentScore  /*0x04000FA9*/
    IL_000e: ret

  .method ScoreManager::OnDuskEarly()  // token 0x06000D22 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ScoreManager::.ctor()  // token 0x06000D23 rva 0x3c08c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 157 (0x9d), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.s 100
    IL_0003: stfld int ScoreManager::baseScorePerNight  /*0x04000F9F*/
    IL_0008: ldarg.0
    IL_0009: ldc.i4 200
    IL_000e: stfld int ScoreManager::protectionScorePerNight  /*0x04000FA0*/
    IL_0013: ldarg.0
    IL_0014: ldc.i4 200
    IL_0019: stfld int ScoreManager::timeScorePerNight  /*0x04000FA1*/
    IL_001e: ldarg.0
    IL_001f: ldc.r4 1f
    IL_0024: stfld float ScoreManager::timebonusMultiplier  /*0x04000FA2*/
    IL_0029: ldarg.0
    IL_002a: ldc.r4 10f
    IL_002f: stfld float ScoreManager::timeBonusMinTime  /*0x04000FA3*/
    IL_0034: ldarg.0
    IL_0035: ldc.r4 120f
    IL_003a: stfld float ScoreManager::timeBonusMaxTime  /*0x04000FA4*/
    IL_003f: ldarg.0
    IL_0040: ldc.r4 1f
    IL_0045: stfld float ScoreManager::protectionScoreMultiplier  /*0x04000FA5*/
    IL_004a: ldarg.0
    IL_004b: ldc.r4 2f
    IL_0050: stfld float ScoreManager::scoreExponent  /*0x04000FA6*/
    IL_0055: ldarg.0
    IL_0056: ldc.r4 1.1f
    IL_005b: stfld float ScoreManager::noRetryScoreMultiplier  /*0x04000FA7*/
    IL_0060: ldarg.0
    IL_0061: ldc.r4 1.01f
    IL_0066: stfld float ScoreManager::noRetryScoreMultiplierInMiniModes  /*0x04000FA8*/
    IL_006b: ldarg.0
    IL_006c: ldc.i4.2
    IL_006d: newarr TagManager.ETag  /*0x0200029A*/
    IL_0072: dup
    IL_0073: ldc.i4.0
    IL_0074: ldc.i4.8
    IL_0075: stelem.i4
    IL_0076: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0003AD*/
    IL_007b: stfld List<TagManager.ETag> ScoreManager::buildingTags  /*0x04000FAA*/
    IL_0080: ldarg.0
    IL_0081: newobj void UnityEngine.Events.UnityEvent<int, int, float, int>::.ctor()  /*0x0A000574*/
    IL_0086: stfld UnityEvent<int, int, float, int> ScoreManager::OnNightScoreAdd  /*0x04000FAB*/
    IL_008b: ldarg.0
    IL_008c: ldc.r4 10f
    IL_0091: stfld float ScoreManager::victoryGoldBonusMultiplyer  /*0x04000FB1*/
    IL_0096: ldarg.0
    IL_0097: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_009c: ret

