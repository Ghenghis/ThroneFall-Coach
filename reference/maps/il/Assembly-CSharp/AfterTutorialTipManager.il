// ===== AfterTutorialTipManager  (token 0x0200000C) =====
  .method AfterTutorialTipManager::Awake()  // token 0x06000042 rva 0x2f81 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld AfterTutorialTipManager AfterTutorialTipManager::instance  /*0x04000048*/
    IL_0006: ret

  .method AfterTutorialTipManager::Start()  // token 0x06000043 rva 0x2f8c attrs Private, HideBySig
    // code size 133 (0x85), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_000c: stfld Player AfterTutorialTipManager::input  /*0x0400004B*/
    IL_0011: ldarg.0
    IL_0012: ldsfld TipManager TipManager::instance  /*0x04001155*/
    IL_0017: stfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_001c: ldarg.0
    IL_001d: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_0022: ldstr ""
    IL_0027: ldstr ""
    IL_002c: ldc.i4.0
    IL_002d: callvirt void TipManager::UpdateTipRaw(string,string,bool)  /*0x06000F0B*/
    IL_0032: ldarg.0
    IL_0033: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0038: ldfld List<string> LevelProgressManager::tipsShown  /*0x04000BBA*/
    IL_003d: stfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0042: ldarg.0
    IL_0043: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0048: stfld TagManager AfterTutorialTipManager::tagManager  /*0x0400004E*/
    IL_004d: ldarg.0
    IL_004e: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0053: stfld PlayerInteraction AfterTutorialTipManager::playerInteraction  /*0x0400004F*/
    IL_0058: ldarg.0
    IL_0059: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_005e: stfld DayNightCycle AfterTutorialTipManager::dayNightCycle  /*0x04000050*/
    IL_0063: ldarg.0
    IL_0064: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0069: stfld EnemySpawner AfterTutorialTipManager::enemySpawner  /*0x04000051*/
    IL_006e: ldarg.0
    IL_006f: ldsfld CommandUnits CommandUnits::instance  /*0x04000DAD*/
    IL_0074: stfld CommandUnits AfterTutorialTipManager::command  /*0x04000053*/
    IL_0079: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_007e: ldarg.0
    IL_007f: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0084: ret

  .method AfterTutorialTipManager::OnDisable()  // token 0x06000044 rva 0x301d attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_0006: ldstr ""
    IL_000b: ldstr ""
    IL_0010: ldc.i4.0
    IL_0011: callvirt void TipManager::UpdateTipRaw(string,string,bool)  /*0x06000F0B*/
    IL_0016: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_001b: ldarg.0
    IL_001c: callvirt void DayNightCycle::UnregisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B4*/
    IL_0021: ret

  .method AfterTutorialTipManager::Update()  // token 0x06000045 rva 0x3040 attrs Private, HideBySig
    // code size 71 (0x47), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool AfterTutorialTipManager::coroutineRunning  /*0x04000054*/
    IL_0006: brtrue.s IL_0046
    IL_0008: ldarg.0
    IL_0009: ldarg.0
    IL_000a: ldfld float AfterTutorialTipManager::nextUpdateIn  /*0x0400004A*/
    IL_000f: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0014: sub
    IL_0015: stfld float AfterTutorialTipManager::nextUpdateIn  /*0x0400004A*/
    IL_001a: ldarg.0
    IL_001b: ldfld float AfterTutorialTipManager::nextUpdateIn  /*0x0400004A*/
    IL_0020: ldc.r4 0f
    IL_0025: bgt.un.s IL_0046
    IL_0027: ldarg.0
    IL_0028: ldarg.0
    IL_0029: ldfld float AfterTutorialTipManager::updateRate  /*0x04000049*/
    IL_002e: stfld float AfterTutorialTipManager::nextUpdateIn  /*0x0400004A*/
    IL_0033: ldarg.0
    IL_0034: ldc.i4.1
    IL_0035: stfld bool AfterTutorialTipManager::coroutineRunning  /*0x04000054*/
    IL_003a: ldarg.0
    IL_003b: ldarg.0
    IL_003c: call Coroutine AfterTutorialTipManager::CheckForAvailableTips()  /*0x06000046*/
    IL_0041: stfld Coroutine AfterTutorialTipManager::tipCoroutine  /*0x0400004C*/
    IL_0046: ret

  .method AfterTutorialTipManager::CheckForAvailableTips()  // token 0x06000046 rva 0x3094 attrs Private, HideBySig
    // code size 1712 (0x6b0), max stack 6, init locals
    .locals ([0] List<BuildSlot>, [1] bool, [2] bool, [3] bool, [4] bool, [5] bool, [6] int, [7] int, [8] int, [9] int, [10] float, [11] List.Enumerator<TaggedObject>, [12] bool, [13] List.Enumerator<Spawn>, [14] Spawn, [15] TaggedObject, [16] int, [17] BuildSlot, [18] string, [19] bool, [20] bool, [21] List.Enumerator<PathfindMovementPlayerunit>, [22] List<TagManager.ETag>)
    IL_0000: ldarg.0
    IL_0001: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0006: callvirt int System.Collections.Generic.List<string>::get_Count()  /*0x0A000047*/
    IL_000b: ldc.i4.s 14
    IL_000d: blt.s IL_0018
    IL_000f: ldarg.0
    IL_0010: ldc.i4.0
    IL_0011: call void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0016: ldnull
    IL_0017: ret
    IL_0018: ldarg.0
    IL_0019: ldfld DayNightCycle AfterTutorialTipManager::dayNightCycle  /*0x04000050*/
    IL_001e: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0023: ldc.i4.1
    IL_0024: bne.un IL_00cc
    IL_0029: ldarg.0
    IL_002a: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_002f: ldstr "locktrg"
    IL_0034: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_0039: brtrue IL_00c3
    IL_003e: ldarg.0
    IL_003f: ldarg.0
    IL_0040: ldfld TagManager AfterTutorialTipManager::tagManager  /*0x0400004E*/
    IL_0045: ldc.i4.1
    IL_0046: callvirt List<TaggedObject> TagManager::FindAllTaggedObjectsWithTagDirect_UseWithCare(TagManager.ETag)  /*0x06000E5D*/
    IL_004b: stfld List<TaggedObject> AfterTutorialTipManager::enemies  /*0x04000057*/
    IL_0050: ldc.r4 0f
    IL_0055: stloc.s 10
    IL_0057: ldarg.0
    IL_0058: ldfld List<TaggedObject> AfterTutorialTipManager::enemies  /*0x04000057*/
    IL_005d: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0062: stloc.s 11
    IL_0064: br.s IL_0080
    IL_0066: ldloca.s 11
    IL_0068: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_006d: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0072: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0077: ldloc.s 10
    IL_0079: call float UnityEngine.Mathf::Max(float,float)  /*0x0A00004B*/
    IL_007e: stloc.s 10
    IL_0080: ldloca.s 11
    IL_0082: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0087: brtrue.s IL_0066
    IL_0089: leave.s IL_0099
    IL_008b: ldloca.s 11
    IL_008d: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0093: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0098: endfinally
    IL_0099: ldloc.s 10
    IL_009b: ldc.r4 175f
    IL_00a0: blt.un.s IL_00c3
    IL_00a2: ldarg.0
    IL_00a3: ldarg.0
    IL_00a4: ldstr "NewTutorial/tipLockTargetA"
    IL_00a9: ldstr "NewTutorial/tipLockTargetB"
    IL_00ae: ldstr "locktrg"
    IL_00b3: ldstr "Lock Target"
    IL_00b8: call IEnumerator AfterTutorialTipManager::DisplayUntilHotkeyTipNight(string,string,string,string)  /*0x06000047*/
    IL_00bd: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_00c2: ret
    IL_00c3: ldarg.0
    IL_00c4: ldc.i4.0
    IL_00c5: stfld bool AfterTutorialTipManager::coroutineRunning  /*0x04000054*/
    IL_00ca: ldnull
    IL_00cb: ret
    IL_00cc: ldarg.0
    IL_00cd: ldfld TagManager AfterTutorialTipManager::tagManager  /*0x0400004E*/
    IL_00d2: ldc.i4.3
    IL_00d3: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_00d8: ldc.i4.1
    IL_00d9: blt.s IL_0121
    IL_00db: ldarg.0
    IL_00dc: ldfld EnemySpawner AfterTutorialTipManager::enemySpawner  /*0x04000051*/
    IL_00e1: ldarg.0
    IL_00e2: ldfld EnemySpawner AfterTutorialTipManager::enemySpawner  /*0x04000051*/
    IL_00e7: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_00ec: callvirt bool EnemySpawner::WaveBeforeFinalWaveComingUp(int)  /*0x06000672*/
    IL_00f1: brfalse.s IL_0121
    IL_00f3: ldarg.0
    IL_00f4: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_00f9: ldstr "finale"
    IL_00fe: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_0103: brtrue.s IL_0121
    IL_0105: ldarg.0
    IL_0106: ldarg.0
    IL_0107: ldstr ""
    IL_010c: ldstr "NewTutorial/almostLastWave"
    IL_0111: ldstr "finale"
    IL_0116: call IEnumerator AfterTutorialTipManager::DisplayUntilBuild(string,string,string)  /*0x0600004E*/
    IL_011b: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0120: ret
    IL_0121: ldarg.0
    IL_0122: ldfld EnemySpawner AfterTutorialTipManager::enemySpawner  /*0x04000051*/
    IL_0127: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_012c: ldc.i4.2
    IL_012d: blt IL_0208
    IL_0132: ldarg.0
    IL_0133: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0138: ldstr "edescri"
    IL_013d: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_0142: brtrue IL_0208
    IL_0147: ldc.i4.0
    IL_0148: stloc.s 12
    IL_014a: call Wave EnemySpawner::GetNextWave()  /*0x06000696*/
    IL_014f: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0154: callvirt List.Enumerator<!0> System.Collections.Generic.List<Spawn>::GetEnumerator()  /*0x0A00004D*/
    IL_0159: stloc.s 13
    IL_015b: br.s IL_01cf
    IL_015d: ldloca.s 13
    IL_015f: call !0 System.Collections.Generic.List.Enumerator<Spawn>::get_Current()  /*0x0A00004E*/
    IL_0164: stloc.s 14
    IL_0166: ldloc.s 14
    IL_0168: brfalse.s IL_01cf
    IL_016a: ldloc.s 14
    IL_016c: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_0171: ldnull
    IL_0172: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0177: brtrue.s IL_01cf
    IL_0179: ldloc.s 14
    IL_017b: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_0180: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_0185: stloc.s 15
    IL_0187: ldloc.s 15
    IL_0189: ldnull
    IL_018a: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_018f: brtrue.s IL_01cf
    IL_0191: ldloc.s 15
    IL_0193: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0198: ldc.i4.6
    IL_0199: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_019e: brfalse.s IL_01a5
    IL_01a0: ldc.i4.1
    IL_01a1: stloc.s 12
    IL_01a3: leave.s IL_01e8
    IL_01a5: ldloc.s 15
    IL_01a7: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_01ac: ldc.i4.s 28
    IL_01ae: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_01b3: brfalse.s IL_01ba
    IL_01b5: ldc.i4.1
    IL_01b6: stloc.s 12
    IL_01b8: leave.s IL_01e8
    IL_01ba: ldloc.s 15
    IL_01bc: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_01c1: ldc.i4.s 16
    IL_01c3: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_01c8: brfalse.s IL_01cf
    IL_01ca: ldc.i4.1
    IL_01cb: stloc.s 12
    IL_01cd: leave.s IL_01e8
    IL_01cf: ldloca.s 13
    IL_01d1: call bool System.Collections.Generic.List.Enumerator<Spawn>::MoveNext()  /*0x0A000051*/
    IL_01d6: brtrue.s IL_015d
    IL_01d8: leave.s IL_01e8
    IL_01da: ldloca.s 13
    IL_01dc: constrained. System.Collections.Generic.List.Enumerator<Spawn>  /*0x1B00000A*/
    IL_01e2: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01e7: endfinally
    IL_01e8: ldloc.s 12
    IL_01ea: brfalse.s IL_0208
    IL_01ec: ldarg.0
    IL_01ed: ldarg.0
    IL_01ee: ldstr ""
    IL_01f3: ldstr "NewTutorial/getEnemyInfo"
    IL_01f8: ldstr "edescri"
    IL_01fd: call IEnumerator AfterTutorialTipManager::DisplayUntilBuild(string,string,string)  /*0x0600004E*/
    IL_0202: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0207: ret
    IL_0208: ldsfld CastleCenter CastleCenter::instance  /*0x040003F7*/
    IL_020d: callvirt !!0 UnityEngine.Component::GetComponentInParent()<BuildSlot>  /*0x2B000004*/
    IL_0212: callvirt List<BuildSlot> BuildSlot::get_IsActivatorOf()  /*0x060002C9*/
    IL_0217: stloc.0
    IL_0218: ldc.i4.0
    IL_0219: stloc.1
    IL_021a: ldc.i4.0
    IL_021b: stloc.2
    IL_021c: ldc.i4.0
    IL_021d: stloc.3
    IL_021e: ldc.i4.0
    IL_021f: stloc.s 4
    IL_0221: ldc.i4.0
    IL_0222: stloc.s 5
    IL_0224: ldloc.0
    IL_0225: callvirt int System.Collections.Generic.List<BuildSlot>::get_Count()  /*0x0A000053*/
    IL_022a: ldc.i4.1
    IL_022b: sub
    IL_022c: stloc.s 16
    IL_022e: br IL_02c9
    IL_0233: ldloc.0
    IL_0234: ldloc.s 16
    IL_0236: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_023b: stloc.s 17
    IL_023d: ldloc.s 17
    IL_023f: ldnull
    IL_0240: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0245: brtrue.s IL_02c3
    IL_0247: ldloc.s 17
    IL_0249: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_024e: stloc.s 18
    IL_0250: ldloc.s 17
    IL_0252: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_0257: brfalse.s IL_02c3
    IL_0259: ldloc.s 17
    IL_025b: callvirt int BuildSlot::get_ActivatorLevel()  /*0x060002CE*/
    IL_0260: ldc.i4.0
    IL_0261: bgt.s IL_02c3
    IL_0263: ldloc.s 18
    IL_0265: ldstr "House"
    IL_026a: callvirt bool System.String::Contains(string)  /*0x0A000055*/
    IL_026f: brfalse.s IL_0273
    IL_0271: ldc.i4.1
    IL_0272: stloc.1
    IL_0273: ldloc.s 18
    IL_0275: ldstr "Mill"
    IL_027a: callvirt bool System.String::Contains(string)  /*0x0A000055*/
    IL_027f: brfalse.s IL_0283
    IL_0281: ldc.i4.1
    IL_0282: stloc.2
    IL_0283: ldloc.s 18
    IL_0285: ldstr "Mine Shaft"
    IL_028a: callvirt bool System.String::Contains(string)  /*0x0A000055*/
    IL_028f: brfalse.s IL_0293
    IL_0291: ldc.i4.1
    IL_0292: stloc.3
    IL_0293: ldloc.s 18
    IL_0295: ldstr "Defense Tower"
    IL_029a: callvirt bool System.String::Contains(string)  /*0x0A000055*/
    IL_029f: brfalse.s IL_02a4
    IL_02a1: ldc.i4.1
    IL_02a2: stloc.s 4
    IL_02a4: ldloc.s 18
    IL_02a6: ldstr "Archer Hut"
    IL_02ab: callvirt bool System.String::Contains(string)  /*0x0A000055*/
    IL_02b0: brtrue.s IL_02c0
    IL_02b2: ldloc.s 18
    IL_02b4: ldstr "Swordsmen Hut"
    IL_02b9: callvirt bool System.String::Contains(string)  /*0x0A000055*/
    IL_02be: brfalse.s IL_02c3
    IL_02c0: ldc.i4.1
    IL_02c1: stloc.s 5
    IL_02c3: ldloc.s 16
    IL_02c5: ldc.i4.1
    IL_02c6: sub
    IL_02c7: stloc.s 16
    IL_02c9: ldloc.s 16
    IL_02cb: ldc.i4.0
    IL_02cc: bge IL_0233
    IL_02d1: ldarg.0
    IL_02d2: ldfld bool AfterTutorialTipManager::dontShowAnotherStartupTip  /*0x04000055*/
    IL_02d7: brtrue IL_0413
    IL_02dc: ldarg.0
    IL_02dd: ldfld EnemySpawner AfterTutorialTipManager::enemySpawner  /*0x04000051*/
    IL_02e2: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_02e7: ldc.i4.m1
    IL_02e8: bne.un IL_0413
    IL_02ed: ldarg.0
    IL_02ee: ldfld TagManager AfterTutorialTipManager::tagManager  /*0x0400004E*/
    IL_02f3: ldc.i4.3
    IL_02f4: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_02f9: ldc.i4.1
    IL_02fa: blt IL_0413
    IL_02ff: ldarg.0
    IL_0300: ldc.i4.1
    IL_0301: stfld bool AfterTutorialTipManager::dontShowAnotherStartupTip  /*0x04000055*/
    IL_0306: ldarg.0
    IL_0307: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_030c: ldstr "prev"
    IL_0311: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_0316: brtrue.s IL_0325
    IL_0318: ldarg.0
    IL_0319: ldarg.0
    IL_031a: call IEnumerator AfterTutorialTipManager::DisplayBuildOptionsTipDay()  /*0x0600004C*/
    IL_031f: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0324: ret
    IL_0325: ldarg.0
    IL_0326: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_032b: ldstr "mines"
    IL_0330: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_0335: ldc.i4.0
    IL_0336: ceq
    IL_0338: ldloc.1
    IL_0339: and
    IL_033a: ldloc.3
    IL_033b: and
    IL_033c: brfalse.s IL_035a
    IL_033e: ldarg.0
    IL_033f: ldarg.0
    IL_0340: ldstr ""
    IL_0345: ldstr "NewTutorial/goldMines"
    IL_034a: ldstr "mines"
    IL_034f: call IEnumerator AfterTutorialTipManager::DisplayUntilBuild(string,string,string)  /*0x0600004E*/
    IL_0354: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0359: ret
    IL_035a: ldarg.0
    IL_035b: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0360: ldstr "sprnt"
    IL_0365: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_036a: brtrue.s IL_0379
    IL_036c: ldarg.0
    IL_036d: ldarg.0
    IL_036e: call IEnumerator AfterTutorialTipManager::DisplayToggleSprintTip()  /*0x0600004D*/
    IL_0373: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0378: ret
    IL_0379: ldarg.0
    IL_037a: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_037f: ldstr "mills"
    IL_0384: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_0389: ldc.i4.0
    IL_038a: ceq
    IL_038c: ldloc.1
    IL_038d: and
    IL_038e: ldloc.2
    IL_038f: and
    IL_0390: brfalse.s IL_03ae
    IL_0392: ldarg.0
    IL_0393: ldarg.0
    IL_0394: ldstr ""
    IL_0399: ldstr "NewTutorial/mills"
    IL_039e: ldstr "mills"
    IL_03a3: call IEnumerator AfterTutorialTipManager::DisplayUntilBuild(string,string,string)  /*0x0600004E*/
    IL_03a8: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_03ad: ret
    IL_03ae: ldarg.0
    IL_03af: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_03b4: ldstr "towrs"
    IL_03b9: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_03be: ldc.i4.0
    IL_03bf: ceq
    IL_03c1: ldloc.s 4
    IL_03c3: and
    IL_03c4: ldloc.s 5
    IL_03c6: and
    IL_03c7: brfalse.s IL_03e5
    IL_03c9: ldarg.0
    IL_03ca: ldarg.0
    IL_03cb: ldstr ""
    IL_03d0: ldstr "NewTutorial/towers"
    IL_03d5: ldstr "towrs"
    IL_03da: call IEnumerator AfterTutorialTipManager::DisplayUntilBuild(string,string,string)  /*0x0600004E*/
    IL_03df: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_03e4: ret
    IL_03e5: ldarg.0
    IL_03e6: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_03eb: ldstr "alone"
    IL_03f0: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_03f5: brtrue.s IL_0413
    IL_03f7: ldarg.0
    IL_03f8: ldarg.0
    IL_03f9: ldstr ""
    IL_03fe: ldstr "NewTutorial/defendAlone"
    IL_0403: ldstr "alone"
    IL_0408: call IEnumerator AfterTutorialTipManager::DisplayUntilBuild(string,string,string)  /*0x0600004E*/
    IL_040d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0412: ret
    IL_0413: ldarg.0
    IL_0414: ldfld EnemySpawner AfterTutorialTipManager::enemySpawner  /*0x04000051*/
    IL_0419: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_041e: brtrue.s IL_0462
    IL_0420: ldarg.0
    IL_0421: ldfld TagManager AfterTutorialTipManager::tagManager  /*0x0400004E*/
    IL_0426: ldc.i4.3
    IL_0427: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_042c: ldc.i4.1
    IL_042d: blt.s IL_0462
    IL_042f: ldarg.0
    IL_0430: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0435: ldstr "zoom"
    IL_043a: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_043f: brtrue.s IL_0462
    IL_0441: ldarg.0
    IL_0442: ldarg.0
    IL_0443: ldstr "Controls/Zoom"
    IL_0448: ldstr "NewTutorial/tipZoom"
    IL_044d: ldstr "zoom"
    IL_0452: ldstr "Zoom"
    IL_0457: call IEnumerator AfterTutorialTipManager::DisplayUntilHotkeyTipDay(string,string,string,string)  /*0x06000048*/
    IL_045c: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0461: ret
    IL_0462: ldarg.0
    IL_0463: ldfld TagManager AfterTutorialTipManager::tagManager  /*0x0400004E*/
    IL_0468: ldc.i4.7
    IL_0469: ldc.i4.4
    IL_046a: ldc.i4.s 37
    IL_046c: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag,TagManager.ETag,TagManager.ETag)  /*0x06000E66*/
    IL_0471: stloc.s 6
    IL_0473: ldarg.0
    IL_0474: ldfld TagManager AfterTutorialTipManager::tagManager  /*0x0400004E*/
    IL_0479: ldc.i4.7
    IL_047a: ldc.i4.5
    IL_047b: ldc.i4.s 37
    IL_047d: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag,TagManager.ETag,TagManager.ETag)  /*0x06000E66*/
    IL_0482: stloc.s 7
    IL_0484: ldarg.0
    IL_0485: ldfld TagManager AfterTutorialTipManager::tagManager  /*0x0400004E*/
    IL_048a: ldc.i4.s 37
    IL_048c: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_0491: stloc.s 8
    IL_0493: ldarg.0
    IL_0494: ldfld TagManager AfterTutorialTipManager::tagManager  /*0x0400004E*/
    IL_0499: ldc.i4.7
    IL_049a: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_049f: stloc.s 9
    IL_04a1: ldarg.0
    IL_04a2: ldfld bool AfterTutorialTipManager::dontShowAnotherUnitHotkeyTip  /*0x04000056*/
    IL_04a7: brtrue IL_05c6
    IL_04ac: ldarg.0
    IL_04ad: ldfld EnemySpawner AfterTutorialTipManager::enemySpawner  /*0x04000051*/
    IL_04b2: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_04b7: ldc.i4.m1
    IL_04b8: ble IL_05c6
    IL_04bd: ldloc.s 9
    IL_04bf: ldc.i4.s 16
    IL_04c1: blt.s IL_04fd
    IL_04c3: ldarg.0
    IL_04c4: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_04c9: ldstr "allarmy"
    IL_04ce: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_04d3: brtrue.s IL_04fd
    IL_04d5: ldarg.0
    IL_04d6: ldc.i4.1
    IL_04d7: stfld bool AfterTutorialTipManager::dontShowAnotherUnitHotkeyTip  /*0x04000056*/
    IL_04dc: ldarg.0
    IL_04dd: ldarg.0
    IL_04de: ldstr "NewTutorial/selectArmyA"
    IL_04e3: ldstr "NewTutorial/selectArmyB"
    IL_04e8: ldstr "allarmy"
    IL_04ed: ldstr "Select All Army"
    IL_04f2: call IEnumerator AfterTutorialTipManager::DisplayUntilHotkeyTipDay(string,string,string,string)  /*0x06000048*/
    IL_04f7: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_04fc: ret
    IL_04fd: ldloc.s 6
    IL_04ff: ldc.i4.s 16
    IL_0501: blt.s IL_0542
    IL_0503: ldloc.s 7
    IL_0505: ldc.i4.0
    IL_0506: ble.s IL_0542
    IL_0508: ldarg.0
    IL_0509: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_050e: ldstr "allmelee"
    IL_0513: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_0518: brtrue.s IL_0542
    IL_051a: ldarg.0
    IL_051b: ldc.i4.1
    IL_051c: stfld bool AfterTutorialTipManager::dontShowAnotherUnitHotkeyTip  /*0x04000056*/
    IL_0521: ldarg.0
    IL_0522: ldarg.0
    IL_0523: ldstr "NewTutorial/selectMelee"
    IL_0528: ldstr "NewTutorial/selectArmyB"
    IL_052d: ldstr "allmelee"
    IL_0532: ldstr "Select All Melee"
    IL_0537: call IEnumerator AfterTutorialTipManager::DisplayUntilHotkeyTipDay(string,string,string,string)  /*0x06000048*/
    IL_053c: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0541: ret
    IL_0542: ldloc.s 7
    IL_0544: ldc.i4.s 16
    IL_0546: blt.s IL_0587
    IL_0548: ldloc.s 6
    IL_054a: ldc.i4.0
    IL_054b: ble.s IL_0587
    IL_054d: ldarg.0
    IL_054e: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0553: ldstr "allranged"
    IL_0558: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_055d: brtrue.s IL_0587
    IL_055f: ldarg.0
    IL_0560: ldc.i4.1
    IL_0561: stfld bool AfterTutorialTipManager::dontShowAnotherUnitHotkeyTip  /*0x04000056*/
    IL_0566: ldarg.0
    IL_0567: ldarg.0
    IL_0568: ldstr "NewTutorial/selectRanged"
    IL_056d: ldstr "NewTutorial/selectArmyB"
    IL_0572: ldstr "allranged"
    IL_0577: ldstr "Select All Ranged"
    IL_057c: call IEnumerator AfterTutorialTipManager::DisplayUntilHotkeyTipDay(string,string,string,string)  /*0x06000048*/
    IL_0581: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0586: ret
    IL_0587: ldloc.s 8
    IL_0589: ldc.i4.1
    IL_058a: blt.s IL_05c6
    IL_058c: ldarg.0
    IL_058d: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0592: ldstr "allhero"
    IL_0597: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_059c: brtrue.s IL_05c6
    IL_059e: ldarg.0
    IL_059f: ldc.i4.1
    IL_05a0: stfld bool AfterTutorialTipManager::dontShowAnotherUnitHotkeyTip  /*0x04000056*/
    IL_05a5: ldarg.0
    IL_05a6: ldarg.0
    IL_05a7: ldstr "NewTutorial/selectHeroes"
    IL_05ac: ldstr "NewTutorial/selectArmyB"
    IL_05b1: ldstr "allhero"
    IL_05b6: ldstr "Select All Heroes"
    IL_05bb: call IEnumerator AfterTutorialTipManager::DisplayUntilHotkeyTipDay(string,string,string,string)  /*0x06000048*/
    IL_05c0: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_05c5: ret
    IL_05c6: ldarg.0
    IL_05c7: ldfld CommandUnits AfterTutorialTipManager::command  /*0x04000053*/
    IL_05cc: callvirt List<PathfindMovementPlayerunit> CommandUnits::get_PlayerUnitsCommanding()  /*0x06000AF5*/
    IL_05d1: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_05d6: ldc.i4.2
    IL_05d7: ble IL_06a7
    IL_05dc: ldc.i4.0
    IL_05dd: stloc.s 19
    IL_05df: ldc.i4.0
    IL_05e0: stloc.s 20
    IL_05e2: ldarg.0
    IL_05e3: ldfld CommandUnits AfterTutorialTipManager::command  /*0x04000053*/
    IL_05e8: callvirt List<PathfindMovementPlayerunit> CommandUnits::get_PlayerUnitsCommanding()  /*0x06000AF5*/
    IL_05ed: callvirt List.Enumerator<!0> System.Collections.Generic.List<PathfindMovementPlayerunit>::GetEnumerator()  /*0x0A000057*/
    IL_05f2: stloc.s 21
    IL_05f4: br.s IL_062e
    IL_05f6: ldloca.s 21
    IL_05f8: call !0 System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>::get_Current()  /*0x0A000058*/
    IL_05fd: callvirt !!0 UnityEngine.Component::GetComponent()<TaggedObject>  /*0x2B000005*/
    IL_0602: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0607: stloc.s 22
    IL_0609: ldloc.s 22
    IL_060b: ldc.i4.4
    IL_060c: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0611: brfalse.s IL_0618
    IL_0613: ldc.i4.1
    IL_0614: stloc.s 19
    IL_0616: br.s IL_0625
    IL_0618: ldloc.s 22
    IL_061a: ldc.i4.5
    IL_061b: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0620: brfalse.s IL_0625
    IL_0622: ldc.i4.1
    IL_0623: stloc.s 20
    IL_0625: ldloc.s 19
    IL_0627: ldloc.s 20
    IL_0629: and
    IL_062a: brfalse.s IL_062e
    IL_062c: leave.s IL_0647
    IL_062e: ldloca.s 21
    IL_0630: call bool System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>::MoveNext()  /*0x0A00005A*/
    IL_0635: brtrue.s IL_05f6
    IL_0637: leave.s IL_0647
    IL_0639: ldloca.s 21
    IL_063b: constrained. System.Collections.Generic.List.Enumerator<PathfindMovementPlayerunit>  /*0x1B00000D*/
    IL_0641: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0646: endfinally
    IL_0647: ldloc.s 20
    IL_0649: brfalse.s IL_066e
    IL_064b: ldloc.s 19
    IL_064d: brtrue.s IL_066e
    IL_064f: ldarg.0
    IL_0650: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0655: ldstr "holdp"
    IL_065a: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_065f: brtrue.s IL_066e
    IL_0661: ldarg.0
    IL_0662: ldarg.0
    IL_0663: call IEnumerator AfterTutorialTipManager::DisplayRangedHoldPositionTip()  /*0x0600004B*/
    IL_0668: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_066d: ret
    IL_066e: ldloc.s 20
    IL_0670: ldloc.s 19
    IL_0672: and
    IL_0673: brfalse.s IL_06a7
    IL_0675: ldarg.0
    IL_0676: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_067b: ldstr "smrtc"
    IL_0680: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_0685: brtrue.s IL_06a7
    IL_0687: ldarg.0
    IL_0688: ldfld CommandUnits AfterTutorialTipManager::command  /*0x04000053*/
    IL_068d: callvirt List<PathfindMovementPlayerunit> CommandUnits::get_PlayerUnitsCommanding()  /*0x06000AF5*/
    IL_0692: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_0697: ldc.i4.8
    IL_0698: blt.s IL_06a7
    IL_069a: ldarg.0
    IL_069b: ldarg.0
    IL_069c: call IEnumerator AfterTutorialTipManager::DisplaySmartCommandTip()  /*0x0600004A*/
    IL_06a1: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_06a6: ret
    IL_06a7: ldarg.0
    IL_06a8: ldc.i4.0
    IL_06a9: stfld bool AfterTutorialTipManager::coroutineRunning  /*0x04000054*/
    IL_06ae: ldnull
    IL_06af: ret
    .try IL_0064-IL_008b finally handler IL_008b-IL_0099
    .try IL_015b-IL_01da finally handler IL_01da-IL_01e8
    .try IL_05f4-IL_0639 finally handler IL_0639-IL_0647

  .method AfterTutorialTipManager::DisplayUntilHotkeyTipNight(string,string,string,string)  // token 0x06000047 rva 0x3778 attrs Private, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::.ctor(int)  /*0x06000078*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld AfterTutorialTipManager AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::<>4__this  /*0x04000075*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::_keyA  /*0x04000076*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::_keyB  /*0x04000077*/
    IL_001b: dup
    IL_001c: ldarg.3
    IL_001d: stfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::_tipKey  /*0x04000079*/
    IL_0022: dup
    IL_0023: ldarg.s 4
    IL_0025: stfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::_buttonKey  /*0x04000078*/
    IL_002a: ret

  .method AfterTutorialTipManager::DisplayUntilHotkeyTipDay(string,string,string,string)  // token 0x06000048 rva 0x37a4 attrs Private, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::.ctor(int)  /*0x06000072*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld AfterTutorialTipManager AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::<>4__this  /*0x0400006E*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::_keyA  /*0x0400006F*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::_keyB  /*0x04000070*/
    IL_001b: dup
    IL_001c: ldarg.3
    IL_001d: stfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::_tipKey  /*0x04000072*/
    IL_0022: dup
    IL_0023: ldarg.s 4
    IL_0025: stfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::_buttonKey  /*0x04000071*/
    IL_002a: ret

  .method AfterTutorialTipManager::AddPostTutorialTipAsComplete(string)  // token 0x06000049 rva 0x37d0 attrs Public, Static, HideBySig
    // code size 48 (0x30), max stack 8
    IL_0000: ldsfld AfterTutorialTipManager AfterTutorialTipManager::instance  /*0x04000048*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brtrue.s IL_000d
    IL_000c: ret
    IL_000d: ldsfld AfterTutorialTipManager AfterTutorialTipManager::instance  /*0x04000048*/
    IL_0012: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0017: ldarg.0
    IL_0018: callvirt bool System.Collections.Generic.List<string>::Contains(!0)  /*0x0A00002A*/
    IL_001d: brtrue.s IL_002f
    IL_001f: ldsfld AfterTutorialTipManager AfterTutorialTipManager::instance  /*0x04000048*/
    IL_0024: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0029: ldarg.0
    IL_002a: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_002f: ret

  .method AfterTutorialTipManager::DisplaySmartCommandTip()  // token 0x0600004A rva 0x3801 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::.ctor(int)  /*0x06000060*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld AfterTutorialTipManager AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::<>4__this  /*0x04000061*/
    IL_000d: ret

  .method AfterTutorialTipManager::DisplayRangedHoldPositionTip()  // token 0x0600004B rva 0x3810 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::.ctor(int)  /*0x0600005A*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld AfterTutorialTipManager AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::<>4__this  /*0x0400005D*/
    IL_000d: ret

  .method AfterTutorialTipManager::DisplayBuildOptionsTipDay()  // token 0x0600004C rva 0x381f attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::.ctor(int)  /*0x06000054*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld AfterTutorialTipManager AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::<>4__this  /*0x0400005A*/
    IL_000d: ret

  .method AfterTutorialTipManager::DisplayToggleSprintTip()  // token 0x0600004D rva 0x382e attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::.ctor(int)  /*0x06000066*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld AfterTutorialTipManager AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::<>4__this  /*0x04000064*/
    IL_000d: ret

  .method AfterTutorialTipManager::DisplayUntilBuild(string,string,string)  // token 0x0600004E rva 0x383d attrs Private, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void AfterTutorialTipManager.<DisplayUntilBuild>d__28::.ctor(int)  /*0x0600006C*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld AfterTutorialTipManager AfterTutorialTipManager.<DisplayUntilBuild>d__28::<>4__this  /*0x04000067*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld string AfterTutorialTipManager.<DisplayUntilBuild>d__28::keyA  /*0x04000068*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld string AfterTutorialTipManager.<DisplayUntilBuild>d__28::keyB  /*0x04000069*/
    IL_001b: dup
    IL_001c: ldarg.3
    IL_001d: stfld string AfterTutorialTipManager.<DisplayUntilBuild>d__28::tipKey  /*0x0400006A*/
    IL_0022: ret

  .method AfterTutorialTipManager::OnDuskEarly()  // token 0x0600004F rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AfterTutorialTipManager::OnDusk()  // token 0x06000050 rva 0x3861 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 11 (0xb), max stack 8
    IL_0000: ldsfld SaveLoadManager SaveLoadManager::instance  /*0x04000C65*/
    IL_0005: callvirt void SaveLoadManager::SaveGame()  /*0x060009B5*/
    IL_000a: ret

  .method AfterTutorialTipManager::OnDawn_AfterSunrise()  // token 0x06000051 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AfterTutorialTipManager::OnDawn_BeforeSunrise()  // token 0x06000052 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AfterTutorialTipManager::.ctor()  // token 0x06000053 rva 0x386d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1.5f
    IL_0006: stfld float AfterTutorialTipManager::updateRate  /*0x04000049*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 3f
    IL_0011: stfld float AfterTutorialTipManager::nextUpdateIn  /*0x0400004A*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_001c: stfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

// ===== AfterTutorialTipManager/<DisplayBuildOptionsTipDay>d__26  (token 0x0200000D) =====
  .method AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::.ctor(int)  // token 0x06000054 rva 0x3896 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::<>1__state  /*0x04000058*/
    IL_000d: ret

  .method AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::System.IDisposable.Dispose()  // token 0x06000055 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::MoveNext()  // token 0x06000056 rva 0x38a8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 185 (0xb9), max stack 4, init locals
    .locals ([0] int, [1] AfterTutorialTipManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::<>1__state  /*0x04000058*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld AfterTutorialTipManager AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::<>4__this  /*0x0400005A*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0046
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::<>1__state  /*0x04000058*/
    IL_001e: ldloc.1
    IL_001f: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_0024: ldstr "NewTutorial/previewBuildOptionsA"
    IL_0029: ldstr "NewTutorial/previewBuildOptionsB"
    IL_002e: ldc.i4.0
    IL_002f: callvirt void TipManager::UpdateTipLocalized(string,string,bool)  /*0x06000F0C*/
    IL_0034: br.s IL_004d
    IL_0036: ldarg.0
    IL_0037: ldnull
    IL_0038: stfld object AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::<>2__current  /*0x04000059*/
    IL_003d: ldarg.0
    IL_003e: ldc.i4.1
    IL_003f: stfld int AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::<>1__state  /*0x04000058*/
    IL_0044: ldc.i4.1
    IL_0045: ret
    IL_0046: ldarg.0
    IL_0047: ldc.i4.m1
    IL_0048: stfld int AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::<>1__state  /*0x04000058*/
    IL_004d: ldloc.1
    IL_004e: ldfld Player AfterTutorialTipManager::input  /*0x0400004B*/
    IL_0053: ldstr "Preview Build Options"
    IL_0058: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_005d: brtrue.s IL_0078
    IL_005f: ldloc.1
    IL_0060: ldfld DayNightCycle AfterTutorialTipManager::dayNightCycle  /*0x04000050*/
    IL_0065: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_006a: brtrue.s IL_0078
    IL_006c: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0071: callvirt bool LocalGamestate::get_PlayerFrozen()  /*0x060008FF*/
    IL_0076: brfalse.s IL_0036
    IL_0078: ldloc.1
    IL_0079: ldfld Player AfterTutorialTipManager::input  /*0x0400004B*/
    IL_007e: ldstr "Preview Build Options"
    IL_0083: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_0088: brfalse.s IL_009a
    IL_008a: ldloc.1
    IL_008b: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0090: ldstr "prev"
    IL_0095: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_009a: ldloc.1
    IL_009b: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_00a0: ldstr ""
    IL_00a5: ldstr ""
    IL_00aa: ldc.i4.0
    IL_00ab: callvirt void TipManager::UpdateTipLocalized(string,string,bool)  /*0x06000F0C*/
    IL_00b0: ldloc.1
    IL_00b1: ldc.i4.0
    IL_00b2: stfld bool AfterTutorialTipManager::coroutineRunning  /*0x04000054*/
    IL_00b7: ldc.i4.0
    IL_00b8: ret

  .method AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000057 rva 0x396d attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::<>2__current  /*0x04000059*/
    IL_0006: ret

  .method AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::System.Collections.IEnumerator.Reset()  // token 0x06000058 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::System.Collections.IEnumerator.get_Current()  // token 0x06000059 rva 0x396d attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterTutorialTipManager.<DisplayBuildOptionsTipDay>d__26::<>2__current  /*0x04000059*/
    IL_0006: ret

// ===== AfterTutorialTipManager/<DisplayRangedHoldPositionTip>d__25  (token 0x0200000E) =====
  .method AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::.ctor(int)  // token 0x0600005A rva 0x3975 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::<>1__state  /*0x0400005B*/
    IL_000d: ret

  .method AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::System.IDisposable.Dispose()  // token 0x0600005B rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::MoveNext()  // token 0x0600005C rva 0x3984 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 293 (0x125), max stack 4, init locals
    .locals ([0] int, [1] AfterTutorialTipManager, [2] List<TaggedObject>, [3] List.Enumerator<TaggedObject>)
    IL_0000: ldarg.0
    IL_0001: ldfld int AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::<>1__state  /*0x0400005B*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld AfterTutorialTipManager AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::<>4__this  /*0x0400005D*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_009e
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::<>1__state  /*0x0400005B*/
    IL_0021: ldarg.0
    IL_0022: ldc.i4.0
    IL_0023: stfld bool AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::<someHoldingPosition>5__2  /*0x0400005E*/
    IL_0028: br.s IL_00a5
    IL_002a: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_002f: stloc.2
    IL_0030: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0035: ldloc.2
    IL_0036: ldc.i4.7
    IL_0037: callvirt void TagManager::FindAllTaggedObjectsWithTag(System.Collections.Generic.List<TaggedObject>,TagManager.ETag)  /*0x06000E5C*/
    IL_003c: ldloc.2
    IL_003d: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0042: stloc.3
    IL_0043: br.s IL_005f
    IL_0045: ldloca.s 3
    IL_0047: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_004c: callvirt !!0 UnityEngine.Component::GetComponentInChildren()<PathfindMovementPlayerunit>  /*0x2B000006*/
    IL_0051: callvirt bool PathfindMovementPlayerunit::get_HoldPosition()  /*0x06000B33*/
    IL_0056: brfalse.s IL_005f
    IL_0058: ldarg.0
    IL_0059: ldc.i4.1
    IL_005a: stfld bool AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::<someHoldingPosition>5__2  /*0x0400005E*/
    IL_005f: ldloca.s 3
    IL_0061: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0066: brtrue.s IL_0045
    IL_0068: leave.s IL_0078
    IL_006a: ldloca.s 3
    IL_006c: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0072: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0077: endfinally
    IL_0078: ldloc.1
    IL_0079: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_007e: ldstr "NewTutorial/unitCommandG"
    IL_0083: ldstr "NewTutorial/holdArchersTip"
    IL_0088: ldc.i4.0
    IL_0089: callvirt void TipManager::UpdateTipLocalized(string,string,bool)  /*0x06000F0C*/
    IL_008e: ldarg.0
    IL_008f: ldnull
    IL_0090: stfld object AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::<>2__current  /*0x0400005C*/
    IL_0095: ldarg.0
    IL_0096: ldc.i4.1
    IL_0097: stfld int AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::<>1__state  /*0x0400005B*/
    IL_009c: ldc.i4.1
    IL_009d: ret
    IL_009e: ldarg.0
    IL_009f: ldc.i4.m1
    IL_00a0: stfld int AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::<>1__state  /*0x0400005B*/
    IL_00a5: ldarg.0
    IL_00a6: ldfld bool AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::<someHoldingPosition>5__2  /*0x0400005E*/
    IL_00ab: brtrue.s IL_00ee
    IL_00ad: ldloc.1
    IL_00ae: ldfld DayNightCycle AfterTutorialTipManager::dayNightCycle  /*0x04000050*/
    IL_00b3: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_00b8: brtrue.s IL_00ee
    IL_00ba: ldloc.1
    IL_00bb: ldfld CommandUnits AfterTutorialTipManager::command  /*0x04000053*/
    IL_00c0: callvirt List<PathfindMovementPlayerunit> CommandUnits::get_PlayerUnitsCommanding()  /*0x06000AF5*/
    IL_00c5: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_00ca: ldc.i4.2
    IL_00cb: bgt.s IL_00df
    IL_00cd: ldloc.1
    IL_00ce: ldfld Player AfterTutorialTipManager::input  /*0x0400004B*/
    IL_00d3: ldstr "Command Units"
    IL_00d8: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_00dd: brfalse.s IL_00ee
    IL_00df: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_00e4: callvirt bool LocalGamestate::get_PlayerFrozen()  /*0x060008FF*/
    IL_00e9: brfalse IL_002a
    IL_00ee: ldarg.0
    IL_00ef: ldfld bool AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::<someHoldingPosition>5__2  /*0x0400005E*/
    IL_00f4: brfalse.s IL_0106
    IL_00f6: ldloc.1
    IL_00f7: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_00fc: ldstr "holdp"
    IL_0101: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0106: ldloc.1
    IL_0107: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_010c: ldstr ""
    IL_0111: ldstr ""
    IL_0116: ldc.i4.0
    IL_0117: callvirt void TipManager::UpdateTipLocalized(string,string,bool)  /*0x06000F0C*/
    IL_011c: ldloc.1
    IL_011d: ldc.i4.0
    IL_011e: stfld bool AfterTutorialTipManager::coroutineRunning  /*0x04000054*/
    IL_0123: ldc.i4.0
    IL_0124: ret
    .try IL_0043-IL_006a finally handler IL_006a-IL_0078

  .method AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600005D rva 0x3ac8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::<>2__current  /*0x0400005C*/
    IL_0006: ret

  .method AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::System.Collections.IEnumerator.Reset()  // token 0x0600005E rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::System.Collections.IEnumerator.get_Current()  // token 0x0600005F rva 0x3ac8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterTutorialTipManager.<DisplayRangedHoldPositionTip>d__25::<>2__current  /*0x0400005C*/
    IL_0006: ret

// ===== AfterTutorialTipManager/<DisplaySmartCommandTip>d__24  (token 0x0200000F) =====
  .method AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::.ctor(int)  // token 0x06000060 rva 0x3ad0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::<>1__state  /*0x0400005F*/
    IL_000d: ret

  .method AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::System.IDisposable.Dispose()  // token 0x06000061 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::MoveNext()  // token 0x06000062 rva 0x3ae0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 204 (0xcc), max stack 4, init locals
    .locals ([0] int, [1] AfterTutorialTipManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::<>1__state  /*0x0400005F*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld AfterTutorialTipManager AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::<>4__this  /*0x04000061*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0046
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::<>1__state  /*0x0400005F*/
    IL_001e: ldloc.1
    IL_001f: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_0024: ldstr "NewTutorial/smartCommandA"
    IL_0029: ldstr "NewTutorial/smartCommandB"
    IL_002e: ldc.i4.0
    IL_002f: callvirt void TipManager::UpdateTipLocalized(string,string,bool)  /*0x06000F0C*/
    IL_0034: br.s IL_004d
    IL_0036: ldarg.0
    IL_0037: ldnull
    IL_0038: stfld object AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::<>2__current  /*0x04000060*/
    IL_003d: ldarg.0
    IL_003e: ldc.i4.1
    IL_003f: stfld int AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::<>1__state  /*0x0400005F*/
    IL_0044: ldc.i4.1
    IL_0045: ret
    IL_0046: ldarg.0
    IL_0047: ldc.i4.m1
    IL_0048: stfld int AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::<>1__state  /*0x0400005F*/
    IL_004d: ldloc.1
    IL_004e: ldfld Player AfterTutorialTipManager::input  /*0x0400004B*/
    IL_0053: ldstr "Smart Command Units"
    IL_0058: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_005d: brtrue.s IL_008b
    IL_005f: ldloc.1
    IL_0060: ldfld DayNightCycle AfterTutorialTipManager::dayNightCycle  /*0x04000050*/
    IL_0065: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_006a: brtrue.s IL_008b
    IL_006c: ldloc.1
    IL_006d: ldfld CommandUnits AfterTutorialTipManager::command  /*0x04000053*/
    IL_0072: callvirt List<PathfindMovementPlayerunit> CommandUnits::get_PlayerUnitsCommanding()  /*0x06000AF5*/
    IL_0077: callvirt int System.Collections.Generic.List<PathfindMovementPlayerunit>::get_Count()  /*0x0A000056*/
    IL_007c: ldc.i4.8
    IL_007d: blt.s IL_008b
    IL_007f: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0084: callvirt bool LocalGamestate::get_PlayerFrozen()  /*0x060008FF*/
    IL_0089: brfalse.s IL_0036
    IL_008b: ldloc.1
    IL_008c: ldfld Player AfterTutorialTipManager::input  /*0x0400004B*/
    IL_0091: ldstr "Smart Command Units"
    IL_0096: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_009b: brfalse.s IL_00ad
    IL_009d: ldloc.1
    IL_009e: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_00a3: ldstr "smrtc"
    IL_00a8: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_00ad: ldloc.1
    IL_00ae: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_00b3: ldstr ""
    IL_00b8: ldstr ""
    IL_00bd: ldc.i4.0
    IL_00be: callvirt void TipManager::UpdateTipLocalized(string,string,bool)  /*0x06000F0C*/
    IL_00c3: ldloc.1
    IL_00c4: ldc.i4.0
    IL_00c5: stfld bool AfterTutorialTipManager::coroutineRunning  /*0x04000054*/
    IL_00ca: ldc.i4.0
    IL_00cb: ret

  .method AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000063 rva 0x3bb8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::<>2__current  /*0x04000060*/
    IL_0006: ret

  .method AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::System.Collections.IEnumerator.Reset()  // token 0x06000064 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::System.Collections.IEnumerator.get_Current()  // token 0x06000065 rva 0x3bb8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterTutorialTipManager.<DisplaySmartCommandTip>d__24::<>2__current  /*0x04000060*/
    IL_0006: ret

// ===== AfterTutorialTipManager/<DisplayToggleSprintTip>d__27  (token 0x02000010) =====
  .method AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::.ctor(int)  // token 0x06000066 rva 0x3bc0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::<>1__state  /*0x04000062*/
    IL_000d: ret

  .method AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::System.IDisposable.Dispose()  // token 0x06000067 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::MoveNext()  // token 0x06000068 rva 0x3bd0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 185 (0xb9), max stack 4, init locals
    .locals ([0] int, [1] AfterTutorialTipManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::<>1__state  /*0x04000062*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld AfterTutorialTipManager AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::<>4__this  /*0x04000064*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0046
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::<>1__state  /*0x04000062*/
    IL_001e: ldloc.1
    IL_001f: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_0024: ldstr "NewTutorial/toggsprintA"
    IL_0029: ldstr "NewTutorial/toggsprintB"
    IL_002e: ldc.i4.0
    IL_002f: callvirt void TipManager::UpdateTipLocalized(string,string,bool)  /*0x06000F0C*/
    IL_0034: br.s IL_004d
    IL_0036: ldarg.0
    IL_0037: ldnull
    IL_0038: stfld object AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::<>2__current  /*0x04000063*/
    IL_003d: ldarg.0
    IL_003e: ldc.i4.1
    IL_003f: stfld int AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::<>1__state  /*0x04000062*/
    IL_0044: ldc.i4.1
    IL_0045: ret
    IL_0046: ldarg.0
    IL_0047: ldc.i4.m1
    IL_0048: stfld int AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::<>1__state  /*0x04000062*/
    IL_004d: ldloc.1
    IL_004e: ldfld Player AfterTutorialTipManager::input  /*0x0400004B*/
    IL_0053: ldstr "Sprint Toggle"
    IL_0058: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_005d: brtrue.s IL_0078
    IL_005f: ldloc.1
    IL_0060: ldfld DayNightCycle AfterTutorialTipManager::dayNightCycle  /*0x04000050*/
    IL_0065: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_006a: brtrue.s IL_0078
    IL_006c: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0071: callvirt bool LocalGamestate::get_PlayerFrozen()  /*0x060008FF*/
    IL_0076: brfalse.s IL_0036
    IL_0078: ldloc.1
    IL_0079: ldfld Player AfterTutorialTipManager::input  /*0x0400004B*/
    IL_007e: ldstr "Sprint Toggle"
    IL_0083: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_0088: brfalse.s IL_009a
    IL_008a: ldloc.1
    IL_008b: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0090: ldstr "sprnt"
    IL_0095: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_009a: ldloc.1
    IL_009b: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_00a0: ldstr ""
    IL_00a5: ldstr ""
    IL_00aa: ldc.i4.0
    IL_00ab: callvirt void TipManager::UpdateTipLocalized(string,string,bool)  /*0x06000F0C*/
    IL_00b0: ldloc.1
    IL_00b1: ldc.i4.0
    IL_00b2: stfld bool AfterTutorialTipManager::coroutineRunning  /*0x04000054*/
    IL_00b7: ldc.i4.0
    IL_00b8: ret

  .method AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000069 rva 0x3c95 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::<>2__current  /*0x04000063*/
    IL_0006: ret

  .method AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::System.Collections.IEnumerator.Reset()  // token 0x0600006A rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::System.Collections.IEnumerator.get_Current()  // token 0x0600006B rva 0x3c95 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterTutorialTipManager.<DisplayToggleSprintTip>d__27::<>2__current  /*0x04000063*/
    IL_0006: ret

// ===== AfterTutorialTipManager/<DisplayUntilBuild>d__28  (token 0x02000011) =====
  .method AfterTutorialTipManager.<DisplayUntilBuild>d__28::.ctor(int)  // token 0x0600006C rva 0x3c9d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int AfterTutorialTipManager.<DisplayUntilBuild>d__28::<>1__state  /*0x04000065*/
    IL_000d: ret

  .method AfterTutorialTipManager.<DisplayUntilBuild>d__28::System.IDisposable.Dispose()  // token 0x0600006D rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AfterTutorialTipManager.<DisplayUntilBuild>d__28::MoveNext()  // token 0x0600006E rva 0x3cac attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 190 (0xbe), max stack 4, init locals
    .locals ([0] int, [1] AfterTutorialTipManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int AfterTutorialTipManager.<DisplayUntilBuild>d__28::<>1__state  /*0x04000065*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld AfterTutorialTipManager AfterTutorialTipManager.<DisplayUntilBuild>d__28::<>4__this  /*0x04000067*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_005a
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int AfterTutorialTipManager.<DisplayUntilBuild>d__28::<>1__state  /*0x04000065*/
    IL_001e: ldloc.1
    IL_001f: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_0024: ldarg.0
    IL_0025: ldfld string AfterTutorialTipManager.<DisplayUntilBuild>d__28::keyA  /*0x04000068*/
    IL_002a: ldarg.0
    IL_002b: ldfld string AfterTutorialTipManager.<DisplayUntilBuild>d__28::keyB  /*0x04000069*/
    IL_0030: ldc.i4.0
    IL_0031: callvirt void TipManager::UpdateTipLocalized(string,string,bool)  /*0x06000F0C*/
    IL_0036: ldarg.0
    IL_0037: ldloc.1
    IL_0038: ldfld TagManager AfterTutorialTipManager::tagManager  /*0x0400004E*/
    IL_003d: ldc.i4.8
    IL_003e: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_0043: stfld int AfterTutorialTipManager.<DisplayUntilBuild>d__28::<buildingsCount>5__2  /*0x0400006B*/
    IL_0048: br.s IL_0061
    IL_004a: ldarg.0
    IL_004b: ldnull
    IL_004c: stfld object AfterTutorialTipManager.<DisplayUntilBuild>d__28::<>2__current  /*0x04000066*/
    IL_0051: ldarg.0
    IL_0052: ldc.i4.1
    IL_0053: stfld int AfterTutorialTipManager.<DisplayUntilBuild>d__28::<>1__state  /*0x04000065*/
    IL_0058: ldc.i4.1
    IL_0059: ret
    IL_005a: ldarg.0
    IL_005b: ldc.i4.m1
    IL_005c: stfld int AfterTutorialTipManager.<DisplayUntilBuild>d__28::<>1__state  /*0x04000065*/
    IL_0061: ldarg.0
    IL_0062: ldfld int AfterTutorialTipManager.<DisplayUntilBuild>d__28::<buildingsCount>5__2  /*0x0400006B*/
    IL_0067: ldloc.1
    IL_0068: ldfld TagManager AfterTutorialTipManager::tagManager  /*0x0400004E*/
    IL_006d: ldc.i4.8
    IL_006e: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_0073: bne.un.s IL_008e
    IL_0075: ldloc.1
    IL_0076: ldfld DayNightCycle AfterTutorialTipManager::dayNightCycle  /*0x04000050*/
    IL_007b: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0080: brtrue.s IL_008e
    IL_0082: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0087: callvirt bool LocalGamestate::get_PlayerFrozen()  /*0x060008FF*/
    IL_008c: brfalse.s IL_004a
    IL_008e: ldloc.1
    IL_008f: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0094: ldarg.0
    IL_0095: ldfld string AfterTutorialTipManager.<DisplayUntilBuild>d__28::tipKey  /*0x0400006A*/
    IL_009a: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_009f: ldloc.1
    IL_00a0: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_00a5: ldstr ""
    IL_00aa: ldstr ""
    IL_00af: ldc.i4.0
    IL_00b0: callvirt void TipManager::UpdateTipLocalized(string,string,bool)  /*0x06000F0C*/
    IL_00b5: ldloc.1
    IL_00b6: ldc.i4.0
    IL_00b7: stfld bool AfterTutorialTipManager::coroutineRunning  /*0x04000054*/
    IL_00bc: ldc.i4.0
    IL_00bd: ret

  .method AfterTutorialTipManager.<DisplayUntilBuild>d__28::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600006F rva 0x3d76 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterTutorialTipManager.<DisplayUntilBuild>d__28::<>2__current  /*0x04000066*/
    IL_0006: ret

  .method AfterTutorialTipManager.<DisplayUntilBuild>d__28::System.Collections.IEnumerator.Reset()  // token 0x06000070 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method AfterTutorialTipManager.<DisplayUntilBuild>d__28::System.Collections.IEnumerator.get_Current()  // token 0x06000071 rva 0x3d76 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterTutorialTipManager.<DisplayUntilBuild>d__28::<>2__current  /*0x04000066*/
    IL_0006: ret

// ===== AfterTutorialTipManager/<DisplayUntilHotkeyTipDay>d__22  (token 0x02000012) =====
  .method AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::.ctor(int)  // token 0x06000072 rva 0x3d7e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::<>1__state  /*0x0400006C*/
    IL_000d: ret

  .method AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::System.IDisposable.Dispose()  // token 0x06000073 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::MoveNext()  // token 0x06000074 rva 0x3d90 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 190 (0xbe), max stack 4, init locals
    .locals ([0] int, [1] AfterTutorialTipManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::<>1__state  /*0x0400006C*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld AfterTutorialTipManager AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::<>4__this  /*0x0400006E*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0048
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::<>1__state  /*0x0400006C*/
    IL_001e: ldloc.1
    IL_001f: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_0024: ldarg.0
    IL_0025: ldfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::_keyA  /*0x0400006F*/
    IL_002a: ldarg.0
    IL_002b: ldfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::_keyB  /*0x04000070*/
    IL_0030: ldc.i4.0
    IL_0031: callvirt void TipManager::UpdateTipLocalized(string,string,bool)  /*0x06000F0C*/
    IL_0036: br.s IL_004f
    IL_0038: ldarg.0
    IL_0039: ldnull
    IL_003a: stfld object AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::<>2__current  /*0x0400006D*/
    IL_003f: ldarg.0
    IL_0040: ldc.i4.1
    IL_0041: stfld int AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::<>1__state  /*0x0400006C*/
    IL_0046: ldc.i4.1
    IL_0047: ret
    IL_0048: ldarg.0
    IL_0049: ldc.i4.m1
    IL_004a: stfld int AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::<>1__state  /*0x0400006C*/
    IL_004f: ldloc.1
    IL_0050: ldfld Player AfterTutorialTipManager::input  /*0x0400004B*/
    IL_0055: ldarg.0
    IL_0056: ldfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::_buttonKey  /*0x04000071*/
    IL_005b: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_0060: brtrue.s IL_007b
    IL_0062: ldloc.1
    IL_0063: ldfld DayNightCycle AfterTutorialTipManager::dayNightCycle  /*0x04000050*/
    IL_0068: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_006d: brtrue.s IL_007b
    IL_006f: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0074: callvirt bool LocalGamestate::get_PlayerFrozen()  /*0x060008FF*/
    IL_0079: brfalse.s IL_0038
    IL_007b: ldloc.1
    IL_007c: ldfld Player AfterTutorialTipManager::input  /*0x0400004B*/
    IL_0081: ldarg.0
    IL_0082: ldfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::_buttonKey  /*0x04000071*/
    IL_0087: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_008c: brfalse.s IL_009f
    IL_008e: ldloc.1
    IL_008f: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0094: ldarg.0
    IL_0095: ldfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::_tipKey  /*0x04000072*/
    IL_009a: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_009f: ldloc.1
    IL_00a0: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_00a5: ldstr ""
    IL_00aa: ldstr ""
    IL_00af: ldc.i4.0
    IL_00b0: callvirt void TipManager::UpdateTipLocalized(string,string,bool)  /*0x06000F0C*/
    IL_00b5: ldloc.1
    IL_00b6: ldc.i4.0
    IL_00b7: stfld bool AfterTutorialTipManager::coroutineRunning  /*0x04000054*/
    IL_00bc: ldc.i4.0
    IL_00bd: ret

  .method AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000075 rva 0x3e5a attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::<>2__current  /*0x0400006D*/
    IL_0006: ret

  .method AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::System.Collections.IEnumerator.Reset()  // token 0x06000076 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::System.Collections.IEnumerator.get_Current()  // token 0x06000077 rva 0x3e5a attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterTutorialTipManager.<DisplayUntilHotkeyTipDay>d__22::<>2__current  /*0x0400006D*/
    IL_0006: ret

// ===== AfterTutorialTipManager/<DisplayUntilHotkeyTipNight>d__21  (token 0x02000013) =====
  .method AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::.ctor(int)  // token 0x06000078 rva 0x3e62 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::<>1__state  /*0x04000073*/
    IL_000d: ret

  .method AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::System.IDisposable.Dispose()  // token 0x06000079 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::MoveNext()  // token 0x0600007A rva 0x3e74 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 191 (0xbf), max stack 4, init locals
    .locals ([0] int, [1] AfterTutorialTipManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::<>1__state  /*0x04000073*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld AfterTutorialTipManager AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::<>4__this  /*0x04000075*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0048
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::<>1__state  /*0x04000073*/
    IL_001e: ldloc.1
    IL_001f: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_0024: ldarg.0
    IL_0025: ldfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::_keyA  /*0x04000076*/
    IL_002a: ldarg.0
    IL_002b: ldfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::_keyB  /*0x04000077*/
    IL_0030: ldc.i4.0
    IL_0031: callvirt void TipManager::UpdateTipLocalized(string,string,bool)  /*0x06000F0C*/
    IL_0036: br.s IL_004f
    IL_0038: ldarg.0
    IL_0039: ldnull
    IL_003a: stfld object AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::<>2__current  /*0x04000074*/
    IL_003f: ldarg.0
    IL_0040: ldc.i4.1
    IL_0041: stfld int AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::<>1__state  /*0x04000073*/
    IL_0046: ldc.i4.1
    IL_0047: ret
    IL_0048: ldarg.0
    IL_0049: ldc.i4.m1
    IL_004a: stfld int AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::<>1__state  /*0x04000073*/
    IL_004f: ldloc.1
    IL_0050: ldfld Player AfterTutorialTipManager::input  /*0x0400004B*/
    IL_0055: ldarg.0
    IL_0056: ldfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::_buttonKey  /*0x04000078*/
    IL_005b: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_0060: brtrue.s IL_007c
    IL_0062: ldloc.1
    IL_0063: ldfld DayNightCycle AfterTutorialTipManager::dayNightCycle  /*0x04000050*/
    IL_0068: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_006d: ldc.i4.1
    IL_006e: bne.un.s IL_007c
    IL_0070: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0075: callvirt bool LocalGamestate::get_PlayerFrozen()  /*0x060008FF*/
    IL_007a: brfalse.s IL_0038
    IL_007c: ldloc.1
    IL_007d: ldfld Player AfterTutorialTipManager::input  /*0x0400004B*/
    IL_0082: ldarg.0
    IL_0083: ldfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::_buttonKey  /*0x04000078*/
    IL_0088: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_008d: brfalse.s IL_00a0
    IL_008f: ldloc.1
    IL_0090: ldfld List<string> AfterTutorialTipManager::tipsShown  /*0x0400004D*/
    IL_0095: ldarg.0
    IL_0096: ldfld string AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::_tipKey  /*0x04000079*/
    IL_009b: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_00a0: ldloc.1
    IL_00a1: ldfld TipManager AfterTutorialTipManager::tipManager  /*0x04000052*/
    IL_00a6: ldstr ""
    IL_00ab: ldstr ""
    IL_00b0: ldc.i4.0
    IL_00b1: callvirt void TipManager::UpdateTipLocalized(string,string,bool)  /*0x06000F0C*/
    IL_00b6: ldloc.1
    IL_00b7: ldc.i4.0
    IL_00b8: stfld bool AfterTutorialTipManager::coroutineRunning  /*0x04000054*/
    IL_00bd: ldc.i4.0
    IL_00be: ret

  .method AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600007B rva 0x3f3f attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::<>2__current  /*0x04000074*/
    IL_0006: ret

  .method AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::System.Collections.IEnumerator.Reset()  // token 0x0600007C rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::System.Collections.IEnumerator.get_Current()  // token 0x0600007D rva 0x3f3f attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AfterTutorialTipManager.<DisplayUntilHotkeyTipNight>d__21::<>2__current  /*0x04000074*/
    IL_0006: ret

