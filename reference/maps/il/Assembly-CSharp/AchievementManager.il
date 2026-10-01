// ===== AchievementManager  (token 0x020001C0) =====
  .method AchievementManager::GiveCrownsAchievement(int)  // token 0x0600090F rva 0x2b450 attrs Public, Static, HideBySig
    // code size 72 (0x48), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.5
    IL_0002: blt.s IL_000b
    IL_0004: ldc.i4.s 20
    IL_0006: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.s 10
    IL_000e: blt.s IL_0017
    IL_0010: ldc.i4.s 21
    IL_0012: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0017: ldarg.0
    IL_0018: ldc.i4.s 20
    IL_001a: blt.s IL_0023
    IL_001c: ldc.i4.s 22
    IL_001e: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0023: ldarg.0
    IL_0024: ldc.i4.s 30
    IL_0026: blt.s IL_002f
    IL_0028: ldc.i4.s 23
    IL_002a: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_002f: ldarg.0
    IL_0030: ldc.i4.s 40
    IL_0032: blt.s IL_003b
    IL_0034: ldc.i4.s 32
    IL_0036: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_003b: ldarg.0
    IL_003c: ldc.i4.s 50
    IL_003e: blt.s IL_0047
    IL_0040: ldc.i4.s 33
    IL_0042: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0047: ret

  .method AchievementManager::UnlockEternalTrialsAchievementForBeating(int)  // token 0x06000910 rva 0x2b4a4 attrs Public, Static, HideBySig
    // code size 93 (0x5d), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: sub
    IL_0003: switch (IL_0025, IL_002d, IL_0035, IL_003d, IL_0045, IL_004d, IL_0055)
    IL_0024: ret
    IL_0025: ldc.i4.s 11
    IL_0027: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_002c: ret
    IL_002d: ldc.i4.s 12
    IL_002f: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0034: ret
    IL_0035: ldc.i4.s 13
    IL_0037: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_003c: ret
    IL_003d: ldc.i4.s 14
    IL_003f: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0044: ret
    IL_0045: ldc.i4.s 15
    IL_0047: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_004c: ret
    IL_004d: ldc.i4.s 16
    IL_004f: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0054: ret
    IL_0055: ldc.i4.s 17
    IL_0057: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_005c: ret

  .method AchievementManager::UnlockAchievement(AchievementManager.Achievements)  // token 0x06000911 rva 0x2b50d attrs Public, Static, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_0005: callvirt bool Thronefall.GameServices.IGameServices::get_Initialized()  /*0x06003DF7*/
    IL_000a: brfalse.s IL_002d
    IL_000c: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_0011: ldarga.s 0
    IL_0013: constrained. AchievementManager.Achievements  /*0x020001C1*/
    IL_0019: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_001e: callvirt void Thronefall.GameServices.IGameServices::SetAchievement(string)  /*0x06003DFE*/
    IL_0023: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_0028: callvirt void Thronefall.GameServices.IGameServices::StoreStats()  /*0x06003E00*/
    IL_002d: ret

  .method AchievementManager::ResetAllAchievements()  // token 0x06000912 rva 0x2b53c attrs Public, Static, HideBySig
    // code size 64 (0x40), max stack 2, init locals
    .locals ([0] string[], [1] int, [2] string)
    IL_0000: call bool UnityEngine.Application::get_isPlaying()  /*0x0A0003DF*/
    IL_0005: brtrue.s IL_0012
    IL_0007: ldstr "Warning: Resetting achievements only works while in play mode."
    IL_000c: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_0011: ret
    IL_0012: ldtoken AchievementManager.Achievements  /*0x020001C1*/
    IL_0017: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_001c: call string[] System.Enum::GetNames(System.Type)  /*0x0A0003E0*/
    IL_0021: stloc.0
    IL_0022: ldc.i4.0
    IL_0023: stloc.1
    IL_0024: br.s IL_0039
    IL_0026: ldloc.0
    IL_0027: ldloc.1
    IL_0028: ldelem.ref
    IL_0029: stloc.2
    IL_002a: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_002f: ldloc.2
    IL_0030: callvirt void Thronefall.GameServices.IGameServices::ClearAchievement(string)  /*0x06003DFF*/
    IL_0035: ldloc.1
    IL_0036: ldc.i4.1
    IL_0037: add
    IL_0038: stloc.1
    IL_0039: ldloc.1
    IL_003a: ldloc.0
    IL_003b: ldlen
    IL_003c: conv.i4
    IL_003d: blt.s IL_0026
    IL_003f: ret

  .method AchievementManager::LevelBeaten(string)  // token 0x06000913 rva 0x2b588 attrs Public, Static, HideBySig
    // code size 203 (0xcb), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldstr "Neuland(Tutorial)"
    IL_0006: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldc.i4.0
    IL_000e: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0013: ldc.i4.1
    IL_0014: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0019: ldarg.0
    IL_001a: ldstr "Nordfels"
    IL_001f: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0024: brfalse.s IL_002c
    IL_0026: ldc.i4.2
    IL_0027: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_002c: ldarg.0
    IL_002d: ldstr "Durststein"
    IL_0032: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0037: brfalse.s IL_003f
    IL_0039: ldc.i4.4
    IL_003a: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_003f: ldarg.0
    IL_0040: ldstr "Frostsee"
    IL_0045: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_004a: brfalse.s IL_0052
    IL_004c: ldc.i4.6
    IL_004d: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0052: ldarg.0
    IL_0053: ldstr "Uferwind"
    IL_0058: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_005d: brfalse.s IL_0066
    IL_005f: ldc.i4.s 9
    IL_0061: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0066: ldarg.0
    IL_0067: ldstr "Sturmklamm"
    IL_006c: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0071: brfalse.s IL_007a
    IL_0073: ldc.i4.s 18
    IL_0075: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_007a: ldarg.0
    IL_007b: ldstr "Wildbach"
    IL_0080: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0085: brfalse.s IL_008e
    IL_0087: ldc.i4.s 24
    IL_0089: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_008e: ldarg.0
    IL_008f: ldstr "Moorweg"
    IL_0094: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0099: brfalse.s IL_00a2
    IL_009b: ldc.i4.s 26
    IL_009d: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_00a2: ldarg.0
    IL_00a3: ldstr "Freifort"
    IL_00a8: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_00ad: brfalse.s IL_00b6
    IL_00af: ldc.i4.s 28
    IL_00b1: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_00b6: ldarg.0
    IL_00b7: ldstr "Totend"
    IL_00bc: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_00c1: brfalse.s IL_00ca
    IL_00c3: ldc.i4.s 30
    IL_00c5: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_00ca: ret

  .method AchievementManager::LevelAllQuestsComplete(string)  // token 0x06000914 rva 0x2b660 attrs Public, Static, HideBySig
    // code size 178 (0xb2), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldstr "Nordfels"
    IL_0006: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_000b: brfalse.s IL_0013
    IL_000d: ldc.i4.3
    IL_000e: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0013: ldarg.0
    IL_0014: ldstr "Durststein"
    IL_0019: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_001e: brfalse.s IL_0026
    IL_0020: ldc.i4.5
    IL_0021: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0026: ldarg.0
    IL_0027: ldstr "Frostsee"
    IL_002c: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0031: brfalse.s IL_0039
    IL_0033: ldc.i4.7
    IL_0034: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0039: ldarg.0
    IL_003a: ldstr "Uferwind"
    IL_003f: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0044: brfalse.s IL_004d
    IL_0046: ldc.i4.s 10
    IL_0048: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_004d: ldarg.0
    IL_004e: ldstr "Sturmklamm"
    IL_0053: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0058: brfalse.s IL_0061
    IL_005a: ldc.i4.s 19
    IL_005c: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0061: ldarg.0
    IL_0062: ldstr "Wildbach"
    IL_0067: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_006c: brfalse.s IL_0075
    IL_006e: ldc.i4.s 25
    IL_0070: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0075: ldarg.0
    IL_0076: ldstr "Moorweg"
    IL_007b: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0080: brfalse.s IL_0089
    IL_0082: ldc.i4.s 27
    IL_0084: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0089: ldarg.0
    IL_008a: ldstr "Freifort"
    IL_008f: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0094: brfalse.s IL_009d
    IL_0096: ldc.i4.s 29
    IL_0098: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_009d: ldarg.0
    IL_009e: ldstr "Totend"
    IL_00a3: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_00a8: brfalse.s IL_00b1
    IL_00aa: ldc.i4.s 31
    IL_00ac: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_00b1: ret

  .method AchievementManager::.ctor()  // token 0x06000915 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== AchievementManager/Achievements  (token 0x020001C1) =====
