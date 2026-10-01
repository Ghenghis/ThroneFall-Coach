// ===== WaveCountPopUp  (token 0x02000386) =====
  .method WaveCountPopUp::Start()  // token 0x06001362 rva 0x5c074 attrs Private, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject WaveCountPopUp::popup  /*0x0400178A*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0011: ldarg.0
    IL_0012: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0017: ret

  .method WaveCountPopUp::OnDawn_AfterSunrise()  // token 0x06001363 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method WaveCountPopUp::OnDawn_BeforeSunrise()  // token 0x06001364 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method WaveCountPopUp::OnDusk()  // token 0x06001365 rva 0x5c08d attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool WaveCountPopUp::inAnimation  /*0x04001790*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: call IEnumerator WaveCountPopUp::PopUpAnimation()  /*0x06001366*/
    IL_0010: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0015: pop
    IL_0016: ret

  .method WaveCountPopUp::PopUpAnimation()  // token 0x06001366 rva 0x5c0a5 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void WaveCountPopUp.<PopUpAnimation>d__11::.ctor(int)  /*0x06001370*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld WaveCountPopUp WaveCountPopUp.<PopUpAnimation>d__11::<>4__this  /*0x04001795*/
    IL_000d: ret

  .method WaveCountPopUp::PlaySoundDelayed()  // token 0x06001367 rva 0x5c0b4 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void WaveCountPopUp.<PlaySoundDelayed>d__12::.ctor(int)  /*0x0600136A*/
    IL_0006: ret

  .method WaveCountPopUp::OnDuskEarly()  // token 0x06001368 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method WaveCountPopUp::.ctor()  // token 0x06001369 rva 0x5c0bc attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.75f
    IL_0006: stfld float WaveCountPopUp::animationTime  /*0x0400178C*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.5f
    IL_0011: stfld float WaveCountPopUp::initialDelay  /*0x0400178D*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 3f
    IL_001c: stfld float WaveCountPopUp::showTime  /*0x0400178E*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

// ===== WaveCountPopUp/<PlaySoundDelayed>d__12  (token 0x02000387) =====
  .method WaveCountPopUp.<PlaySoundDelayed>d__12::.ctor(int)  // token 0x0600136A rva 0x5c0e5 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int WaveCountPopUp.<PlaySoundDelayed>d__12::<>1__state  /*0x04001791*/
    IL_000d: ret

  .method WaveCountPopUp.<PlaySoundDelayed>d__12::System.IDisposable.Dispose()  // token 0x0600136B rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method WaveCountPopUp.<PlaySoundDelayed>d__12::MoveNext()  // token 0x0600136C rva 0x5c0f4 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 64 (0x40), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int WaveCountPopUp.<PlaySoundDelayed>d__12::<>1__state  /*0x04001791*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: brfalse.s IL_0010
    IL_000a: ldloc.0
    IL_000b: ldc.i4.1
    IL_000c: beq.s IL_0030
    IL_000e: ldc.i4.0
    IL_000f: ret
    IL_0010: ldarg.0
    IL_0011: ldc.i4.m1
    IL_0012: stfld int WaveCountPopUp.<PlaySoundDelayed>d__12::<>1__state  /*0x04001791*/
    IL_0017: ldarg.0
    IL_0018: ldc.r4 0.1f
    IL_001d: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0022: stfld object WaveCountPopUp.<PlaySoundDelayed>d__12::<>2__current  /*0x04001792*/
    IL_0027: ldarg.0
    IL_0028: ldc.i4.1
    IL_0029: stfld int WaveCountPopUp.<PlaySoundDelayed>d__12::<>1__state  /*0x04001791*/
    IL_002e: ldc.i4.1
    IL_002f: ret
    IL_0030: ldarg.0
    IL_0031: ldc.i4.m1
    IL_0032: stfld int WaveCountPopUp.<PlaySoundDelayed>d__12::<>1__state  /*0x04001791*/
    IL_0037: ldc.i4.s 18
    IL_0039: call void ThronefallAudioManager::Oneshot(ThronefallAudioManager.AudioOneShot)  /*0x06000219*/
    IL_003e: ldc.i4.0
    IL_003f: ret

  .method WaveCountPopUp.<PlaySoundDelayed>d__12::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600136D rva 0x5c140 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object WaveCountPopUp.<PlaySoundDelayed>d__12::<>2__current  /*0x04001792*/
    IL_0006: ret

  .method WaveCountPopUp.<PlaySoundDelayed>d__12::System.Collections.IEnumerator.Reset()  // token 0x0600136E rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method WaveCountPopUp.<PlaySoundDelayed>d__12::System.Collections.IEnumerator.get_Current()  // token 0x0600136F rva 0x5c140 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object WaveCountPopUp.<PlaySoundDelayed>d__12::<>2__current  /*0x04001792*/
    IL_0006: ret

// ===== WaveCountPopUp/<PopUpAnimation>d__11  (token 0x02000388) =====
  .method WaveCountPopUp.<PopUpAnimation>d__11::.ctor(int)  // token 0x06001370 rva 0x5c148 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int WaveCountPopUp.<PopUpAnimation>d__11::<>1__state  /*0x04001793*/
    IL_000d: ret

  .method WaveCountPopUp.<PopUpAnimation>d__11::System.IDisposable.Dispose()  // token 0x06001371 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method WaveCountPopUp.<PopUpAnimation>d__11::MoveNext()  // token 0x06001372 rva 0x5c158 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 549 (0x225), max stack 6, init locals
    .locals ([0] int, [1] WaveCountPopUp, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int WaveCountPopUp.<PopUpAnimation>d__11::<>1__state  /*0x04001793*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld WaveCountPopUp WaveCountPopUp.<PopUpAnimation>d__11::<>4__this  /*0x04001795*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_002a, IL_007e, IL_0131, IL_0175, IL_01e6)
    IL_0028: ldc.i4.0
    IL_0029: ret
    IL_002a: ldarg.0
    IL_002b: ldc.i4.m1
    IL_002c: stfld int WaveCountPopUp.<PopUpAnimation>d__11::<>1__state  /*0x04001793*/
    IL_0031: ldloc.1
    IL_0032: ldc.i4.1
    IL_0033: stfld bool WaveCountPopUp::inAnimation  /*0x04001790*/
    IL_0038: ldloc.1
    IL_0039: ldfld GameObject WaveCountPopUp::popup  /*0x0400178A*/
    IL_003e: ldc.i4.1
    IL_003f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0044: ldloc.1
    IL_0045: ldfld GameObject WaveCountPopUp::popup  /*0x0400178A*/
    IL_004a: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_004f: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0054: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0059: ldarg.0
    IL_005a: ldc.r4 0f
    IL_005f: stfld float WaveCountPopUp.<PopUpAnimation>d__11::<timer>5__2  /*0x04001796*/
    IL_0064: ldarg.0
    IL_0065: ldloc.1
    IL_0066: ldfld float WaveCountPopUp::initialDelay  /*0x0400178D*/
    IL_006b: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0070: stfld object WaveCountPopUp.<PopUpAnimation>d__11::<>2__current  /*0x04001794*/
    IL_0075: ldarg.0
    IL_0076: ldc.i4.1
    IL_0077: stfld int WaveCountPopUp.<PopUpAnimation>d__11::<>1__state  /*0x04001793*/
    IL_007c: ldc.i4.1
    IL_007d: ret
    IL_007e: ldarg.0
    IL_007f: ldc.i4.m1
    IL_0080: stfld int WaveCountPopUp.<PopUpAnimation>d__11::<>1__state  /*0x04001793*/
    IL_0085: ldloc.1
    IL_0086: ldfld TextMeshProUGUI WaveCountPopUp::targetText  /*0x0400178F*/
    IL_008b: ldstr "<style=Body Numerals>"
    IL_0090: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0095: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_009a: ldc.i4.1
    IL_009b: add
    IL_009c: stloc.2
    IL_009d: ldloca.s 2
    IL_009f: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00a4: ldstr "</style><style=Body Bold>/</style><style=Body Numerals>"
    IL_00a9: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_00ae: callvirt int EnemySpawner::get_WaveCount()  /*0x0600066D*/
    IL_00b3: stloc.2
    IL_00b4: ldloca.s 2
    IL_00b6: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00bb: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_00c0: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00c5: ldloc.1
    IL_00c6: ldloc.1
    IL_00c7: call IEnumerator WaveCountPopUp::PlaySoundDelayed()  /*0x06001367*/
    IL_00cc: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_00d1: pop
    IL_00d2: br.s IL_0138
    IL_00d4: ldarg.0
    IL_00d5: ldarg.0
    IL_00d6: ldfld float WaveCountPopUp.<PopUpAnimation>d__11::<timer>5__2  /*0x04001796*/
    IL_00db: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00e0: add
    IL_00e1: stfld float WaveCountPopUp.<PopUpAnimation>d__11::<timer>5__2  /*0x04001796*/
    IL_00e6: ldloc.1
    IL_00e7: ldfld GameObject WaveCountPopUp::popup  /*0x0400178A*/
    IL_00ec: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00f1: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00f6: ldloc.1
    IL_00f7: ldfld AnimationCurve WaveCountPopUp::scaleCurve  /*0x0400178B*/
    IL_00fc: ldc.r4 0f
    IL_0101: ldloc.1
    IL_0102: ldfld float WaveCountPopUp::animationTime  /*0x0400178C*/
    IL_0107: ldarg.0
    IL_0108: ldfld float WaveCountPopUp.<PopUpAnimation>d__11::<timer>5__2  /*0x04001796*/
    IL_010d: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0112: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0117: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_011c: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0121: ldarg.0
    IL_0122: ldnull
    IL_0123: stfld object WaveCountPopUp.<PopUpAnimation>d__11::<>2__current  /*0x04001794*/
    IL_0128: ldarg.0
    IL_0129: ldc.i4.2
    IL_012a: stfld int WaveCountPopUp.<PopUpAnimation>d__11::<>1__state  /*0x04001793*/
    IL_012f: ldc.i4.1
    IL_0130: ret
    IL_0131: ldarg.0
    IL_0132: ldc.i4.m1
    IL_0133: stfld int WaveCountPopUp.<PopUpAnimation>d__11::<>1__state  /*0x04001793*/
    IL_0138: ldarg.0
    IL_0139: ldfld float WaveCountPopUp.<PopUpAnimation>d__11::<timer>5__2  /*0x04001796*/
    IL_013e: ldloc.1
    IL_013f: ldfld float WaveCountPopUp::animationTime  /*0x0400178C*/
    IL_0144: blt.s IL_00d4
    IL_0146: ldloc.1
    IL_0147: ldfld GameObject WaveCountPopUp::popup  /*0x0400178A*/
    IL_014c: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0151: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0156: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_015b: ldarg.0
    IL_015c: ldloc.1
    IL_015d: ldfld float WaveCountPopUp::showTime  /*0x0400178E*/
    IL_0162: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0167: stfld object WaveCountPopUp.<PopUpAnimation>d__11::<>2__current  /*0x04001794*/
    IL_016c: ldarg.0
    IL_016d: ldc.i4.3
    IL_016e: stfld int WaveCountPopUp.<PopUpAnimation>d__11::<>1__state  /*0x04001793*/
    IL_0173: ldc.i4.1
    IL_0174: ret
    IL_0175: ldarg.0
    IL_0176: ldc.i4.m1
    IL_0177: stfld int WaveCountPopUp.<PopUpAnimation>d__11::<>1__state  /*0x04001793*/
    IL_017c: ldarg.0
    IL_017d: ldc.r4 0f
    IL_0182: stfld float WaveCountPopUp.<PopUpAnimation>d__11::<timer>5__2  /*0x04001796*/
    IL_0187: br.s IL_01ed
    IL_0189: ldarg.0
    IL_018a: ldarg.0
    IL_018b: ldfld float WaveCountPopUp.<PopUpAnimation>d__11::<timer>5__2  /*0x04001796*/
    IL_0190: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0195: add
    IL_0196: stfld float WaveCountPopUp.<PopUpAnimation>d__11::<timer>5__2  /*0x04001796*/
    IL_019b: ldloc.1
    IL_019c: ldfld GameObject WaveCountPopUp::popup  /*0x0400178A*/
    IL_01a1: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_01a6: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_01ab: ldloc.1
    IL_01ac: ldfld AnimationCurve WaveCountPopUp::scaleCurve  /*0x0400178B*/
    IL_01b1: ldloc.1
    IL_01b2: ldfld float WaveCountPopUp::animationTime  /*0x0400178C*/
    IL_01b7: ldc.r4 0f
    IL_01bc: ldarg.0
    IL_01bd: ldfld float WaveCountPopUp.<PopUpAnimation>d__11::<timer>5__2  /*0x04001796*/
    IL_01c2: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_01c7: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_01cc: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_01d1: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_01d6: ldarg.0
    IL_01d7: ldnull
    IL_01d8: stfld object WaveCountPopUp.<PopUpAnimation>d__11::<>2__current  /*0x04001794*/
    IL_01dd: ldarg.0
    IL_01de: ldc.i4.4
    IL_01df: stfld int WaveCountPopUp.<PopUpAnimation>d__11::<>1__state  /*0x04001793*/
    IL_01e4: ldc.i4.1
    IL_01e5: ret
    IL_01e6: ldarg.0
    IL_01e7: ldc.i4.m1
    IL_01e8: stfld int WaveCountPopUp.<PopUpAnimation>d__11::<>1__state  /*0x04001793*/
    IL_01ed: ldarg.0
    IL_01ee: ldfld float WaveCountPopUp.<PopUpAnimation>d__11::<timer>5__2  /*0x04001796*/
    IL_01f3: ldloc.1
    IL_01f4: ldfld float WaveCountPopUp::animationTime  /*0x0400178C*/
    IL_01f9: blt.s IL_0189
    IL_01fb: ldloc.1
    IL_01fc: ldfld GameObject WaveCountPopUp::popup  /*0x0400178A*/
    IL_0201: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0206: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_020b: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0210: ldloc.1
    IL_0211: ldfld GameObject WaveCountPopUp::popup  /*0x0400178A*/
    IL_0216: ldc.i4.0
    IL_0217: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_021c: ldloc.1
    IL_021d: ldc.i4.0
    IL_021e: stfld bool WaveCountPopUp::inAnimation  /*0x04001790*/
    IL_0223: ldc.i4.0
    IL_0224: ret

  .method WaveCountPopUp.<PopUpAnimation>d__11::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06001373 rva 0x5c389 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object WaveCountPopUp.<PopUpAnimation>d__11::<>2__current  /*0x04001794*/
    IL_0006: ret

  .method WaveCountPopUp.<PopUpAnimation>d__11::System.Collections.IEnumerator.Reset()  // token 0x06001374 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method WaveCountPopUp.<PopUpAnimation>d__11::System.Collections.IEnumerator.get_Current()  // token 0x06001375 rva 0x5c389 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object WaveCountPopUp.<PopUpAnimation>d__11::<>2__current  /*0x04001794*/
    IL_0006: ret

