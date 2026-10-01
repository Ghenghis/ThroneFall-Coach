// ===== PlatformManager  (token 0x02000108) =====
  .method PlatformManager::OnEnable()  // token 0x0600056C rva 0x1775f attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldftn void PlatformManager::OnPlatformLeaving(int)  /*0x06000572*/
    IL_0007: newobj void System.Action<int>::.ctor(object,IntPtr)  /*0x0A000239*/
    IL_000c: call void PlatformMover::add_OnPlatformLeaving(System.Action<int>)  /*0x06000599*/
    IL_0011: ret

  .method PlatformManager::OnDisable()  // token 0x0600056D rva 0x17772 attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldftn void PlatformManager::OnPlatformLeaving(int)  /*0x06000572*/
    IL_0007: newobj void System.Action<int>::.ctor(object,IntPtr)  /*0x0A000239*/
    IL_000c: call void PlatformMover::remove_OnPlatformLeaving(System.Action<int>)  /*0x0600059A*/
    IL_0011: ret

  .method PlatformManager::Start()  // token 0x0600056E rva 0x17785 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void PlatformManager::InitialState()  /*0x0600056F*/
    IL_0006: ret

  .method PlatformManager::InitialState()  // token 0x0600056F rva 0x17790 attrs Private, HideBySig
    // code size 132 (0x84), max stack 2, init locals
    .locals ([0] List.Enumerator<PlatformMover>, [1] PlatformMover, [2] Docker)
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0018
    IL_000d: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0012: ldarg.0
    IL_0013: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0018: ldarg.0
    IL_0019: ldfld bool PlatformManager::wasLoaded  /*0x040006FF*/
    IL_001e: brtrue.s IL_0083
    IL_0020: ldarg.0
    IL_0021: ldfld List<PlatformMover> PlatformManager::platforms  /*0x040006FC*/
    IL_0026: callvirt List.Enumerator<!0> System.Collections.Generic.List<PlatformMover>::GetEnumerator()  /*0x0A00023A*/
    IL_002b: stloc.0
    IL_002c: br.s IL_006a
    IL_002e: ldloca.s 0
    IL_0030: call !0 System.Collections.Generic.List.Enumerator<PlatformMover>::get_Current()  /*0x0A00023B*/
    IL_0035: stloc.1
    IL_0036: ldloc.1
    IL_0037: callvirt void PlatformMover::SetStartDockId()  /*0x060005A2*/
    IL_003c: ldarg.0
    IL_003d: ldloc.1
    IL_003e: callvirt int PlatformMover::get_CurrentDockId()  /*0x0600059C*/
    IL_0043: call Docker PlatformManager::GetDocker(int)  /*0x06000573*/
    IL_0048: stloc.2
    IL_0049: ldloc.2
    IL_004a: ldnull
    IL_004b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0050: brfalse.s IL_006a
    IL_0052: ldloc.1
    IL_0053: ldloc.2
    IL_0054: callvirt Vector3 Docker::get_DockPosition()  /*0x06000560*/
    IL_0059: callvirt void PlatformMover::SetCurrentDockPosition(UnityEngine.Vector3)  /*0x060005A4*/
    IL_005e: ldloc.1
    IL_005f: ldloc.2
    IL_0060: callvirt Vector3 Docker::get_DockPosition()  /*0x06000560*/
    IL_0065: callvirt void PlatformMover::SnapToDock(UnityEngine.Vector3)  /*0x060005A5*/
    IL_006a: ldloca.s 0
    IL_006c: call bool System.Collections.Generic.List.Enumerator<PlatformMover>::MoveNext()  /*0x0A00023C*/
    IL_0071: brtrue.s IL_002e
    IL_0073: leave.s IL_0083
    IL_0075: ldloca.s 0
    IL_0077: constrained. System.Collections.Generic.List.Enumerator<PlatformMover>  /*0x1B00005E*/
    IL_007d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0082: endfinally
    IL_0083: ret
    .try IL_002c-IL_0075 finally handler IL_0075-IL_0083

  .method PlatformManager::OnSunrise(int)  // token 0x06000570 rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlatformManager::OpenDocksAfterBuffer(int)  // token 0x06000571 rva 0x17830 attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void PlatformManager.<OpenDocksAfterBuffer>d__11::.ctor(int)  /*0x0600058C*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld PlatformManager PlatformManager.<OpenDocksAfterBuffer>d__11::<>4__this  /*0x04000708*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld int PlatformManager.<OpenDocksAfterBuffer>d__11::nightIndex  /*0x04000709*/
    IL_0014: ret

  .method PlatformManager::OnPlatformLeaving(int)  // token 0x06000572 rva 0x17846 attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call Docker PlatformManager::GetDocker(int)  /*0x06000573*/
    IL_0007: dup
    IL_0008: brtrue.s IL_000c
    IL_000a: pop
    IL_000b: ret
    IL_000c: call void Docker::Close()  /*0x06000562*/
    IL_0011: ret

  .method PlatformManager::GetDocker(int)  // token 0x06000573 rva 0x1785c attrs Private, HideBySig
    // code size 37 (0x25), max stack 3, init locals
    .locals ([0] PlatformManager.<>c__DisplayClass13_0)
    IL_0000: newobj void PlatformManager.<>c__DisplayClass13_0::.ctor()  /*0x06000588*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldarg.1
    IL_0008: stfld int PlatformManager.<>c__DisplayClass13_0::id  /*0x04000703*/
    IL_000d: ldarg.0
    IL_000e: ldfld List<Docker> PlatformManager::dockers  /*0x040006FB*/
    IL_0013: ldloc.0
    IL_0014: ldftn bool PlatformManager.<>c__DisplayClass13_0::<GetDocker>b__0(Docker)  /*0x06000589*/
    IL_001a: newobj void System.Predicate<Docker>::.ctor(object,IntPtr)  /*0x0A00023D*/
    IL_001f: callvirt !0 System.Collections.Generic.List<Docker>::Find(System.Predicate<!0>)  /*0x0A00023E*/
    IL_0024: ret

  .method PlatformManager::GetOccupiedDocks(int)  // token 0x06000574 rva 0x17890 attrs Private, HideBySig
    // code size 91 (0x5b), max stack 2, init locals
    .locals ([0] HashSet<int>, [1] List.Enumerator<PlatformMover>, [2] PlatformMover, [3] ScheduleEntry, [4] int)
    IL_0000: newobj void System.Collections.Generic.HashSet<int>::.ctor()  /*0x0A0001F9*/
    IL_0005: stloc.0
    IL_0006: ldarg.0
    IL_0007: ldfld List<PlatformMover> PlatformManager::platforms  /*0x040006FC*/
    IL_000c: callvirt List.Enumerator<!0> System.Collections.Generic.List<PlatformMover>::GetEnumerator()  /*0x0A00023A*/
    IL_0011: stloc.1
    IL_0012: br.s IL_0040
    IL_0014: ldloca.s 1
    IL_0016: call !0 System.Collections.Generic.List.Enumerator<PlatformMover>::get_Current()  /*0x0A00023B*/
    IL_001b: stloc.2
    IL_001c: ldloc.2
    IL_001d: ldarg.1
    IL_001e: callvirt ScheduleEntry PlatformMover::GetEntryAfterNight(int)  /*0x060005A1*/
    IL_0023: stloc.3
    IL_0024: ldloc.3
    IL_0025: brtrue.s IL_002f
    IL_0027: ldloc.2
    IL_0028: callvirt int PlatformMover::get_CurrentDockId()  /*0x0600059C*/
    IL_002d: br.s IL_0035
    IL_002f: ldloc.3
    IL_0030: ldfld int ScheduleEntry::toDockId  /*0x0400070E*/
    IL_0035: stloc.s 4
    IL_0037: ldloc.0
    IL_0038: ldloc.s 4
    IL_003a: callvirt bool System.Collections.Generic.HashSet<int>::Add(!0)  /*0x0A0001FC*/
    IL_003f: pop
    IL_0040: ldloca.s 1
    IL_0042: call bool System.Collections.Generic.List.Enumerator<PlatformMover>::MoveNext()  /*0x0A00023C*/
    IL_0047: brtrue.s IL_0014
    IL_0049: leave.s IL_0059
    IL_004b: ldloca.s 1
    IL_004d: constrained. System.Collections.Generic.List.Enumerator<PlatformMover>  /*0x1B00005E*/
    IL_0053: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0058: endfinally
    IL_0059: ldloc.0
    IL_005a: ret
    .try IL_0012-IL_004b finally handler IL_004b-IL_0059

  .method PlatformManager::OnDuskEarly()  // token 0x06000575 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlatformManager::OnDusk()  // token 0x06000576 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlatformManager::OnDawn_AfterSunrise()  // token 0x06000577 rva 0x17908 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0007: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_000c: ldc.i4.1
    IL_000d: add
    IL_000e: call IEnumerator PlatformManager::OpenDocksAfterBuffer(int)  /*0x06000571*/
    IL_0013: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0018: pop
    IL_0019: ret

  .method PlatformManager::OnDawn_BeforeSunrise()  // token 0x06000578 rva 0x17923 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 21 (0x15), max stack 8
    IL_0000: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0005: callvirt LocalGamestate.State LocalGamestate::get_CurrentState()  /*0x060008FD*/
    IL_000a: ldc.i4.3
    IL_000b: bne.un.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: call void PlatformManager::MovePlatforms()  /*0x0600057A*/
    IL_0014: ret

  .method PlatformManager::GetClip(int,int)  // token 0x06000579 rva 0x1793c attrs Private, HideBySig
    // code size 55 (0x37), max stack 3, init locals
    .locals ([0] PlatformManager.<>c__DisplayClass19_0)
    IL_0000: newobj void PlatformManager.<>c__DisplayClass19_0::.ctor()  /*0x0600058A*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldarg.1
    IL_0008: stfld int PlatformManager.<>c__DisplayClass19_0::fromId  /*0x04000704*/
    IL_000d: ldloc.0
    IL_000e: ldarg.2
    IL_000f: stfld int PlatformManager.<>c__DisplayClass19_0::toId  /*0x04000705*/
    IL_0014: ldarg.0
    IL_0015: ldfld List<RouteClip> PlatformManager::animationClips  /*0x040006FD*/
    IL_001a: ldloc.0
    IL_001b: ldftn bool PlatformManager.<>c__DisplayClass19_0::<GetClip>b__0(RouteClip)  /*0x0600058B*/
    IL_0021: newobj void System.Predicate<RouteClip>::.ctor(object,IntPtr)  /*0x0A00023F*/
    IL_0026: callvirt !0 System.Collections.Generic.List<RouteClip>::Find(System.Predicate<!0>)  /*0x0A000240*/
    IL_002b: dup
    IL_002c: brtrue.s IL_0031
    IL_002e: pop
    IL_002f: ldnull
    IL_0030: ret
    IL_0031: ldfld AnimationClip RouteClip::clip  /*0x040006FA*/
    IL_0036: ret

  .method PlatformManager::MovePlatforms()  // token 0x0600057A rva 0x17980 attrs Private, HideBySig
    // code size 190 (0xbe), max stack 4, init locals
    .locals ([0] List.Enumerator<PlatformMover>, [1] PlatformMover, [2] ScheduleEntry, [3] Docker, [4] Docker, [5] AnimationClip)
    IL_0000: ldarg.0
    IL_0001: ldfld List<PlatformMover> PlatformManager::platforms  /*0x040006FC*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<PlatformMover>::GetEnumerator()  /*0x0A00023A*/
    IL_000b: stloc.0
    IL_000c: br IL_00a1
    IL_0011: ldloca.s 0
    IL_0013: call !0 System.Collections.Generic.List.Enumerator<PlatformMover>::get_Current()  /*0x0A00023B*/
    IL_0018: stloc.1
    IL_0019: ldloc.1
    IL_001a: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_001f: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0024: ldc.i4.1
    IL_0025: add
    IL_0026: callvirt ScheduleEntry PlatformMover::GetEntryAfterNight(int)  /*0x060005A1*/
    IL_002b: stloc.2
    IL_002c: ldloc.2
    IL_002d: brfalse.s IL_00a1
    IL_002f: ldarg.0
    IL_0030: ldloc.1
    IL_0031: callvirt int PlatformMover::get_CurrentDockId()  /*0x0600059C*/
    IL_0036: call Docker PlatformManager::GetDocker(int)  /*0x06000573*/
    IL_003b: stloc.3
    IL_003c: ldarg.0
    IL_003d: ldloc.2
    IL_003e: ldfld int ScheduleEntry::toDockId  /*0x0400070E*/
    IL_0043: call Docker PlatformManager::GetDocker(int)  /*0x06000573*/
    IL_0048: stloc.s 4
    IL_004a: ldloc.s 4
    IL_004c: ldnull
    IL_004d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0052: brfalse.s IL_0070
    IL_0054: ldstr "[PlatformManager] Docker {0} not found"
    IL_0059: ldloc.2
    IL_005a: ldfld int ScheduleEntry::toDockId  /*0x0400070E*/
    IL_005f: box System.Int32  /*0x01000026*/
    IL_0064: call string System.String::Format(string,object)  /*0x0A00021A*/
    IL_0069: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_006e: br.s IL_00a1
    IL_0070: ldarg.0
    IL_0071: ldloc.3
    IL_0072: ldloc.1
    IL_0073: call void PlatformManager::TeleportUnits(Docker,PlatformMover)  /*0x0600057B*/
    IL_0078: ldarg.0
    IL_0079: ldloc.1
    IL_007a: callvirt int PlatformMover::get_CurrentDockId()  /*0x0600059C*/
    IL_007f: ldloc.2
    IL_0080: ldfld int ScheduleEntry::toDockId  /*0x0400070E*/
    IL_0085: call AnimationClip PlatformManager::GetClip(int,int)  /*0x06000579*/
    IL_008a: stloc.s 5
    IL_008c: ldloc.1
    IL_008d: ldloc.2
    IL_008e: ldfld int ScheduleEntry::toDockId  /*0x0400070E*/
    IL_0093: ldloc.s 4
    IL_0095: callvirt Vector3 Docker::get_DockPosition()  /*0x06000560*/
    IL_009a: ldloc.s 5
    IL_009c: callvirt void PlatformMover::MoveTo(int,UnityEngine.Vector3,UnityEngine.AnimationClip)  /*0x060005A6*/
    IL_00a1: ldloca.s 0
    IL_00a3: call bool System.Collections.Generic.List.Enumerator<PlatformMover>::MoveNext()  /*0x0A00023C*/
    IL_00a8: brtrue IL_0011
    IL_00ad: leave.s IL_00bd
    IL_00af: ldloca.s 0
    IL_00b1: constrained. System.Collections.Generic.List.Enumerator<PlatformMover>  /*0x1B00005E*/
    IL_00b7: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00bc: endfinally
    IL_00bd: ret
    .try IL_000c-IL_00af finally handler IL_00af-IL_00bd

  .method PlatformManager::TeleportUnits(Docker,PlatformMover)  // token 0x0600057B rva 0x17a5c attrs Private, HideBySig
    // code size 86 (0x56), max stack 3, init locals
    .locals ([0] Transform, [1] PlayerMovement, [2] List<TaggedObject>)
    IL_0000: ldarg.1
    IL_0001: callvirt Transform Docker::GetTeleportPoint()  /*0x06000565*/
    IL_0006: stloc.0
    IL_0007: ldarg.2
    IL_0008: ldloca.s 1
    IL_000a: ldloca.s 2
    IL_000c: callvirt void PlatformMover::GetOccupants(ref PlayerMovement,ref System.Collections.Generic.List<TaggedObject>)  /*0x060005A7*/
    IL_0011: ldloc.1
    IL_0012: ldnull
    IL_0013: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0018: brfalse.s IL_002f
    IL_001a: ldloc.0
    IL_001b: ldnull
    IL_001c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0021: brfalse.s IL_002f
    IL_0023: ldloc.1
    IL_0024: ldloc.0
    IL_0025: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002a: callvirt void PlayerMovement::TeleportTo(UnityEngine.Vector3)  /*0x06000C22*/
    IL_002f: ldloc.1
    IL_0030: ldnull
    IL_0031: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0036: brfalse.s IL_0047
    IL_0038: ldloc.0
    IL_0039: ldnull
    IL_003a: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_003f: brfalse.s IL_0047
    IL_0041: ldloc.1
    IL_0042: callvirt void PlayerMovement::TeleportToStart()  /*0x06000C23*/
    IL_0047: ldarg.0
    IL_0048: ldarg.0
    IL_0049: ldloc.2
    IL_004a: call IEnumerator PlatformManager::TeleportOnEndFrame(System.Collections.Generic.List<TaggedObject>)  /*0x0600057C*/
    IL_004f: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0054: pop
    IL_0055: ret

  .method PlatformManager::TeleportOnEndFrame(System.Collections.Generic.List<TaggedObject>)  // token 0x0600057C rva 0x17abe attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void PlatformManager.<TeleportOnEndFrame>d__22::.ctor(int)  /*0x06000592*/
    IL_0006: dup
    IL_0007: ldarg.1
    IL_0008: stfld List<TaggedObject> PlatformManager.<TeleportOnEndFrame>d__22::units  /*0x0400070C*/
    IL_000d: ret

  .method PlatformManager::OnBeforeMainLoadPass(string)  // token 0x0600057D rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlatformManager::OnLoad(string)  // token 0x0600057E rva 0x17acd attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 38 (0x26), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldstr "lastWaveNumber"
    IL_0006: ldarg.0
    IL_0007: ldflda int PlatformManager::lastWaveNumber  /*0x04000700*/
    IL_000c: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_0011: pop
    IL_0012: ldarg.0
    IL_0013: ldarg.0
    IL_0014: ldfld int PlatformManager::lastWaveNumber  /*0x04000700*/
    IL_0019: call void PlatformManager::InitializeFromSchedule(int)  /*0x06000581*/
    IL_001e: ldarg.0
    IL_001f: ldc.i4.1
    IL_0020: stfld bool PlatformManager::wasLoaded  /*0x040006FF*/
    IL_0025: ret

  .method PlatformManager::OnAfterMainLoadPass(string)  // token 0x0600057F rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlatformManager::OnSave(string)  // token 0x06000580 rva 0x17af4 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldstr "lastWaveNumber"
    IL_0006: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_000b: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0010: ldc.i4.1
    IL_0011: add
    IL_0012: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_0017: ret

  .method PlatformManager::InitializeFromSchedule(int)  // token 0x06000581 rva 0x17b10 attrs Private, HideBySig
    // code size 111 (0x6f), max stack 3, init locals
    .locals ([0] List.Enumerator<PlatformMover>, [1] PlatformMover, [2] int, [3] Docker)
    IL_0000: ldarg.0
    IL_0001: ldfld List<PlatformMover> PlatformManager::platforms  /*0x040006FC*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<PlatformMover>::GetEnumerator()  /*0x0A00023A*/
    IL_000b: stloc.0
    IL_000c: br.s IL_004f
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<PlatformMover>::get_Current()  /*0x0A00023B*/
    IL_0015: stloc.1
    IL_0016: ldarg.0
    IL_0017: ldloc.1
    IL_0018: ldarg.1
    IL_0019: call int PlatformManager::GetPlatformDockAtNight(PlatformMover,int)  /*0x06000582*/
    IL_001e: stloc.2
    IL_001f: ldloc.1
    IL_0020: ldloc.2
    IL_0021: callvirt void PlatformMover::SetCurrentDockId(int)  /*0x060005A3*/
    IL_0026: ldarg.0
    IL_0027: ldloc.2
    IL_0028: call Docker PlatformManager::GetDocker(int)  /*0x06000573*/
    IL_002d: stloc.3
    IL_002e: ldloc.3
    IL_002f: ldnull
    IL_0030: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0035: brfalse.s IL_004f
    IL_0037: ldloc.1
    IL_0038: ldloc.3
    IL_0039: callvirt Vector3 Docker::get_DockPosition()  /*0x06000560*/
    IL_003e: callvirt void PlatformMover::SnapToDock(UnityEngine.Vector3)  /*0x060005A5*/
    IL_0043: ldloc.1
    IL_0044: ldloc.3
    IL_0045: callvirt Vector3 Docker::get_DockPosition()  /*0x06000560*/
    IL_004a: callvirt void PlatformMover::SetCurrentDockPosition(UnityEngine.Vector3)  /*0x060005A4*/
    IL_004f: ldloca.s 0
    IL_0051: call bool System.Collections.Generic.List.Enumerator<PlatformMover>::MoveNext()  /*0x0A00023C*/
    IL_0056: brtrue.s IL_000e
    IL_0058: leave.s IL_0068
    IL_005a: ldloca.s 0
    IL_005c: constrained. System.Collections.Generic.List.Enumerator<PlatformMover>  /*0x1B00005E*/
    IL_0062: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0067: endfinally
    IL_0068: ldarg.0
    IL_0069: call void PlatformManager::UpdateDockers()  /*0x06000583*/
    IL_006e: ret
    .try IL_000c-IL_005a finally handler IL_005a-IL_0068

  .method PlatformManager::GetPlatformDockAtNight(PlatformMover,int)  // token 0x06000582 rva 0x17b9c attrs Private, HideBySig
    // code size 77 (0x4d), max stack 2, init locals
    .locals ([0] ScheduleEntry, [1] List.Enumerator<ScheduleEntry>, [2] ScheduleEntry)
    IL_0000: ldnull
    IL_0001: stloc.0
    IL_0002: ldarg.1
    IL_0003: ldfld List<ScheduleEntry> PlatformMover::schedule  /*0x04000714*/
    IL_0008: callvirt List.Enumerator<!0> System.Collections.Generic.List<ScheduleEntry>::GetEnumerator()  /*0x0A000241*/
    IL_000d: stloc.1
    IL_000e: br.s IL_0023
    IL_0010: ldloca.s 1
    IL_0012: call !0 System.Collections.Generic.List.Enumerator<ScheduleEntry>::get_Current()  /*0x0A000242*/
    IL_0017: stloc.2
    IL_0018: ldloc.2
    IL_0019: ldfld int ScheduleEntry::afterNight  /*0x0400070D*/
    IL_001e: ldarg.2
    IL_001f: bgt.s IL_002c
    IL_0021: ldloc.2
    IL_0022: stloc.0
    IL_0023: ldloca.s 1
    IL_0025: call bool System.Collections.Generic.List.Enumerator<ScheduleEntry>::MoveNext()  /*0x0A000243*/
    IL_002a: brtrue.s IL_0010
    IL_002c: leave.s IL_003c
    IL_002e: ldloca.s 1
    IL_0030: constrained. System.Collections.Generic.List.Enumerator<ScheduleEntry>  /*0x1B000064*/
    IL_0036: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_003b: endfinally
    IL_003c: ldloc.0
    IL_003d: brtrue.s IL_0046
    IL_003f: ldarg.1
    IL_0040: callvirt int PlatformMover::get_StartingDockId()  /*0x0600059B*/
    IL_0045: ret
    IL_0046: ldloc.0
    IL_0047: ldfld int ScheduleEntry::toDockId  /*0x0400070E*/
    IL_004c: ret
    .try IL_000e-IL_002e finally handler IL_002e-IL_003c

  .method PlatformManager::UpdateDockers()  // token 0x06000583 rva 0x17c08 attrs Private, HideBySig
    // code size 124 (0x7c), max stack 3, init locals
    .locals ([0] HashSet<int>, [1] List.Enumerator<Docker>, [2] Docker)
    IL_0000: ldarg.0
    IL_0001: ldfld List<PlatformMover> PlatformManager::platforms  /*0x040006FC*/
    IL_0006: ldsfld Func<PlatformMover, int> PlatformManager.<>c::<>9__29_0  /*0x04000702*/
    IL_000b: dup
    IL_000c: brtrue.s IL_0025
    IL_000e: pop
    IL_000f: ldsfld PlatformManager.<>c PlatformManager.<>c::<>9  /*0x04000701*/
    IL_0014: ldftn int PlatformManager.<>c::<UpdateDockers>b__29_0(PlatformMover)  /*0x06000587*/
    IL_001a: newobj void System.Func<PlatformMover, int>::.ctor(object,IntPtr)  /*0x0A000244*/
    IL_001f: dup
    IL_0020: stsfld Func<PlatformMover, int> PlatformManager.<>c::<>9__29_0  /*0x04000702*/
    IL_0025: call IEnumerable<!!1> System.Linq.Enumerable::Select(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, !!1>)<PlatformMover,int>  /*0x2B00003D*/
    IL_002a: newobj void System.Collections.Generic.HashSet<int>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000246*/
    IL_002f: stloc.0
    IL_0030: ldarg.0
    IL_0031: ldfld List<Docker> PlatformManager::dockers  /*0x040006FB*/
    IL_0036: callvirt List.Enumerator<!0> System.Collections.Generic.List<Docker>::GetEnumerator()  /*0x0A000247*/
    IL_003b: stloc.1
    IL_003c: br.s IL_0062
    IL_003e: ldloca.s 1
    IL_0040: call !0 System.Collections.Generic.List.Enumerator<Docker>::get_Current()  /*0x0A000248*/
    IL_0045: stloc.2
    IL_0046: ldloc.0
    IL_0047: ldloc.2
    IL_0048: ldfld int Docker::id  /*0x040006F1*/
    IL_004d: callvirt bool System.Collections.Generic.HashSet<int>::Contains(!0)  /*0x0A0001FD*/
    IL_0052: brfalse.s IL_005c
    IL_0054: ldloc.2
    IL_0055: callvirt void Docker::Open()  /*0x06000561*/
    IL_005a: br.s IL_0062
    IL_005c: ldloc.2
    IL_005d: callvirt void Docker::Close()  /*0x06000562*/
    IL_0062: ldloca.s 1
    IL_0064: call bool System.Collections.Generic.List.Enumerator<Docker>::MoveNext()  /*0x0A000249*/
    IL_0069: brtrue.s IL_003e
    IL_006b: leave.s IL_007b
    IL_006d: ldloca.s 1
    IL_006f: constrained. System.Collections.Generic.List.Enumerator<Docker>  /*0x1B000066*/
    IL_0075: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_007a: endfinally
    IL_007b: ret
    .try IL_003c-IL_006d finally handler IL_006d-IL_007b

  .method PlatformManager::.ctor()  // token 0x06000584 rva 0x17ca0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 3f
    IL_0006: stfld float PlatformManager::dayStartBuffer  /*0x040006FE*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== PlatformManager/<>c  (token 0x02000109) =====
  .method PlatformManager.<>c::.cctor()  // token 0x06000585 rva 0x17cb3 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void PlatformManager.<>c::.ctor()  /*0x06000586*/
    IL_0005: stsfld PlatformManager.<>c PlatformManager.<>c::<>9  /*0x04000701*/
    IL_000a: ret

  .method PlatformManager.<>c::.ctor()  // token 0x06000586 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method PlatformManager.<>c::<UpdateDockers>b__29_0(PlatformMover)  // token 0x06000587 rva 0x17cbf attrs Assembly, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.1
    IL_0001: callvirt int PlatformMover::get_CurrentDockId()  /*0x0600059C*/
    IL_0006: ret

// ===== PlatformManager/<>c__DisplayClass13_0  (token 0x0200010A) =====
  .method PlatformManager.<>c__DisplayClass13_0::.ctor()  // token 0x06000588 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method PlatformManager.<>c__DisplayClass13_0::<GetDocker>b__0(Docker)  // token 0x06000589 rva 0x17cc7 attrs Assembly, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldfld int Docker::id  /*0x040006F1*/
    IL_0006: ldarg.0
    IL_0007: ldfld int PlatformManager.<>c__DisplayClass13_0::id  /*0x04000703*/
    IL_000c: ceq
    IL_000e: ret

// ===== PlatformManager/<>c__DisplayClass19_0  (token 0x0200010B) =====
  .method PlatformManager.<>c__DisplayClass19_0::.ctor()  // token 0x0600058A rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method PlatformManager.<>c__DisplayClass19_0::<GetClip>b__0(RouteClip)  // token 0x0600058B rva 0x17cd7 attrs Assembly, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldfld int RouteClip::fromDockId  /*0x040006F8*/
    IL_0006: ldarg.0
    IL_0007: ldfld int PlatformManager.<>c__DisplayClass19_0::fromId  /*0x04000704*/
    IL_000c: bne.un.s IL_001d
    IL_000e: ldarg.1
    IL_000f: ldfld int RouteClip::toDockId  /*0x040006F9*/
    IL_0014: ldarg.0
    IL_0015: ldfld int PlatformManager.<>c__DisplayClass19_0::toId  /*0x04000705*/
    IL_001a: ceq
    IL_001c: ret
    IL_001d: ldc.i4.0
    IL_001e: ret

// ===== PlatformManager/<OpenDocksAfterBuffer>d__11  (token 0x0200010C) =====
  .method PlatformManager.<OpenDocksAfterBuffer>d__11::.ctor(int)  // token 0x0600058C rva 0x17cf7 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int PlatformManager.<OpenDocksAfterBuffer>d__11::<>1__state  /*0x04000706*/
    IL_000d: ret

  .method PlatformManager.<OpenDocksAfterBuffer>d__11::System.IDisposable.Dispose()  // token 0x0600058D rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlatformManager.<OpenDocksAfterBuffer>d__11::MoveNext()  // token 0x0600058E rva 0x17d08 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 157 (0x9d), max stack 2, init locals
    .locals ([0] int, [1] PlatformManager, [2] HashSet<int>, [3] List.Enumerator<Docker>, [4] Docker)
    IL_0000: ldarg.0
    IL_0001: ldfld int PlatformManager.<OpenDocksAfterBuffer>d__11::<>1__state  /*0x04000706*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld PlatformManager PlatformManager.<OpenDocksAfterBuffer>d__11::<>4__this  /*0x04000708*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0038
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int PlatformManager.<OpenDocksAfterBuffer>d__11::<>1__state  /*0x04000706*/
    IL_001e: ldarg.0
    IL_001f: ldloc.1
    IL_0020: ldfld float PlatformManager::dayStartBuffer  /*0x040006FE*/
    IL_0025: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_002a: stfld object PlatformManager.<OpenDocksAfterBuffer>d__11::<>2__current  /*0x04000707*/
    IL_002f: ldarg.0
    IL_0030: ldc.i4.1
    IL_0031: stfld int PlatformManager.<OpenDocksAfterBuffer>d__11::<>1__state  /*0x04000706*/
    IL_0036: ldc.i4.1
    IL_0037: ret
    IL_0038: ldarg.0
    IL_0039: ldc.i4.m1
    IL_003a: stfld int PlatformManager.<OpenDocksAfterBuffer>d__11::<>1__state  /*0x04000706*/
    IL_003f: ldloc.1
    IL_0040: ldarg.0
    IL_0041: ldfld int PlatformManager.<OpenDocksAfterBuffer>d__11::nightIndex  /*0x04000709*/
    IL_0046: call HashSet<int> PlatformManager::GetOccupiedDocks(int)  /*0x06000574*/
    IL_004b: stloc.2
    IL_004c: ldloc.1
    IL_004d: ldfld List<Docker> PlatformManager::dockers  /*0x040006FB*/
    IL_0052: callvirt List.Enumerator<!0> System.Collections.Generic.List<Docker>::GetEnumerator()  /*0x0A000247*/
    IL_0057: stloc.3
    IL_0058: br.s IL_0082
    IL_005a: ldloca.s 3
    IL_005c: call !0 System.Collections.Generic.List.Enumerator<Docker>::get_Current()  /*0x0A000248*/
    IL_0061: stloc.s 4
    IL_0063: ldloc.2
    IL_0064: ldloc.s 4
    IL_0066: ldfld int Docker::id  /*0x040006F1*/
    IL_006b: callvirt bool System.Collections.Generic.HashSet<int>::Contains(!0)  /*0x0A0001FD*/
    IL_0070: brfalse.s IL_007b
    IL_0072: ldloc.s 4
    IL_0074: callvirt void Docker::Open()  /*0x06000561*/
    IL_0079: br.s IL_0082
    IL_007b: ldloc.s 4
    IL_007d: callvirt void Docker::Close()  /*0x06000562*/
    IL_0082: ldloca.s 3
    IL_0084: call bool System.Collections.Generic.List.Enumerator<Docker>::MoveNext()  /*0x0A000249*/
    IL_0089: brtrue.s IL_005a
    IL_008b: leave.s IL_009b
    IL_008d: ldloca.s 3
    IL_008f: constrained. System.Collections.Generic.List.Enumerator<Docker>  /*0x1B000066*/
    IL_0095: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_009a: endfinally
    IL_009b: ldc.i4.0
    IL_009c: ret
    .try IL_0058-IL_008d finally handler IL_008d-IL_009b

  .method PlatformManager.<OpenDocksAfterBuffer>d__11::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600058F rva 0x17dc4 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlatformManager.<OpenDocksAfterBuffer>d__11::<>2__current  /*0x04000707*/
    IL_0006: ret

  .method PlatformManager.<OpenDocksAfterBuffer>d__11::System.Collections.IEnumerator.Reset()  // token 0x06000590 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method PlatformManager.<OpenDocksAfterBuffer>d__11::System.Collections.IEnumerator.get_Current()  // token 0x06000591 rva 0x17dc4 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlatformManager.<OpenDocksAfterBuffer>d__11::<>2__current  /*0x04000707*/
    IL_0006: ret

// ===== PlatformManager/<TeleportOnEndFrame>d__22  (token 0x0200010D) =====
  .method PlatformManager.<TeleportOnEndFrame>d__22::.ctor(int)  // token 0x06000592 rva 0x17dcc attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int PlatformManager.<TeleportOnEndFrame>d__22::<>1__state  /*0x0400070A*/
    IL_000d: ret

  .method PlatformManager.<TeleportOnEndFrame>d__22::System.IDisposable.Dispose()  // token 0x06000593 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlatformManager.<TeleportOnEndFrame>d__22::MoveNext()  // token 0x06000594 rva 0x17ddc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 158 (0x9e), max stack 3, init locals
    .locals ([0] int, [1] List.Enumerator<TaggedObject>, [2] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld int PlatformManager.<TeleportOnEndFrame>d__22::<>1__state  /*0x0400070A*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: brfalse.s IL_0010
    IL_000a: ldloc.0
    IL_000b: ldc.i4.1
    IL_000c: beq.s IL_002b
    IL_000e: ldc.i4.0
    IL_000f: ret
    IL_0010: ldarg.0
    IL_0011: ldc.i4.m1
    IL_0012: stfld int PlatformManager.<TeleportOnEndFrame>d__22::<>1__state  /*0x0400070A*/
    IL_0017: ldarg.0
    IL_0018: newobj void UnityEngine.WaitForEndOfFrame::.ctor()  /*0x0A00024A*/
    IL_001d: stfld object PlatformManager.<TeleportOnEndFrame>d__22::<>2__current  /*0x0400070B*/
    IL_0022: ldarg.0
    IL_0023: ldc.i4.1
    IL_0024: stfld int PlatformManager.<TeleportOnEndFrame>d__22::<>1__state  /*0x0400070A*/
    IL_0029: ldc.i4.1
    IL_002a: ret
    IL_002b: ldarg.0
    IL_002c: ldc.i4.m1
    IL_002d: stfld int PlatformManager.<TeleportOnEndFrame>d__22::<>1__state  /*0x0400070A*/
    IL_0032: ldarg.0
    IL_0033: ldfld List<TaggedObject> PlatformManager.<TeleportOnEndFrame>d__22::units  /*0x0400070C*/
    IL_0038: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_003d: ldc.i4.0
    IL_003e: ble.s IL_009c
    IL_0040: ldarg.0
    IL_0041: ldfld List<TaggedObject> PlatformManager.<TeleportOnEndFrame>d__22::units  /*0x0400070C*/
    IL_0046: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_004b: stloc.1
    IL_004c: br.s IL_0062
    IL_004e: ldloca.s 1
    IL_0050: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_0055: stloc.2
    IL_0056: ldsfld CommandUnits CommandUnits::instance  /*0x04000DAD*/
    IL_005b: ldloc.2
    IL_005c: ldc.i4.0
    IL_005d: callvirt void CommandUnits::OnUnitAdd(TaggedObject,bool)  /*0x06000B02*/
    IL_0062: ldloca.s 1
    IL_0064: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0069: brtrue.s IL_004e
    IL_006b: leave.s IL_007b
    IL_006d: ldloca.s 1
    IL_006f: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0075: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_007a: endfinally
    IL_007b: ldsfld CommandUnits CommandUnits::instance  /*0x04000DAD*/
    IL_0080: ldc.i4.1
    IL_0081: stfld bool CommandUnits::commanding  /*0x04000DC5*/
    IL_0086: ldsfld CommandUnits CommandUnits::instance  /*0x04000DAD*/
    IL_008b: ldc.i4.0
    IL_008c: callvirt void CommandUnits::PlaceCommandedUnitsAndCalculateTargetPositions(bool)  /*0x06000B01*/
    IL_0091: ldsfld CommandUnits CommandUnits::instance  /*0x04000DAD*/
    IL_0096: ldc.i4.0
    IL_0097: stfld bool CommandUnits::commanding  /*0x04000DC5*/
    IL_009c: ldc.i4.0
    IL_009d: ret
    .try IL_004c-IL_006d finally handler IL_006d-IL_007b

  .method PlatformManager.<TeleportOnEndFrame>d__22::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000595 rva 0x17e98 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlatformManager.<TeleportOnEndFrame>d__22::<>2__current  /*0x0400070B*/
    IL_0006: ret

  .method PlatformManager.<TeleportOnEndFrame>d__22::System.Collections.IEnumerator.Reset()  // token 0x06000596 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method PlatformManager.<TeleportOnEndFrame>d__22::System.Collections.IEnumerator.get_Current()  // token 0x06000597 rva 0x17e98 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlatformManager.<TeleportOnEndFrame>d__22::<>2__current  /*0x0400070B*/
    IL_0006: ret

