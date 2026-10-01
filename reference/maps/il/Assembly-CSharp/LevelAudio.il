// ===== LevelAudio  (token 0x02000054) =====
  .method LevelAudio::OnValidate()  // token 0x060001F1 rva 0x8144 attrs Private, HideBySig
    // code size 79 (0x4f), max stack 2, init locals
    .locals ([0] List.Enumerator<LevelAudio.CivilisationAudioSource>, [1] LevelAudio.CivilisationAudioSource)
    IL_0000: ldarg.0
    IL_0001: ldfld List<LevelAudio.CivilisationAudioSource> LevelAudio::managedCivAudioSources  /*0x04000247*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<LevelAudio.CivilisationAudioSource>::GetEnumerator()  /*0x0A0000C2*/
    IL_000b: stloc.0
    IL_000c: br.s IL_0035
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<LevelAudio.CivilisationAudioSource>::get_Current()  /*0x0A0000C3*/
    IL_0015: stloc.1
    IL_0016: ldloc.1
    IL_0017: ldfld AudioSource LevelAudio.CivilisationAudioSource::audioSource  /*0x04000249*/
    IL_001c: ldnull
    IL_001d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0022: brfalse.s IL_0035
    IL_0024: ldloc.1
    IL_0025: ldloc.1
    IL_0026: ldfld AudioSource LevelAudio.CivilisationAudioSource::audioSource  /*0x04000249*/
    IL_002b: callvirt float UnityEngine.AudioSource::get_volume()  /*0x0A0000C4*/
    IL_0030: stfld float LevelAudio.CivilisationAudioSource::targetVolume  /*0x0400024B*/
    IL_0035: ldloca.s 0
    IL_0037: call bool System.Collections.Generic.List.Enumerator<LevelAudio.CivilisationAudioSource>::MoveNext()  /*0x0A0000C5*/
    IL_003c: brtrue.s IL_000e
    IL_003e: leave.s IL_004e
    IL_0040: ldloca.s 0
    IL_0042: constrained. System.Collections.Generic.List.Enumerator<LevelAudio.CivilisationAudioSource>  /*0x1B000016*/
    IL_0048: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_004d: endfinally
    IL_004e: ret
    .try IL_000c-IL_0040 finally handler IL_0040-IL_004e

  .method LevelAudio::Start()  // token 0x060001F2 rva 0x81b0 attrs Private, HideBySig
    // code size 126 (0x7e), max stack 3, init locals
    .locals ([0] int, [1] LevelAudio.CivilisationAudioSource)
    IL_0000: ldarg.0
    IL_0001: ldfld List<LevelAudio.CivilisationAudioSource> LevelAudio::managedCivAudioSources  /*0x04000247*/
    IL_0006: callvirt int System.Collections.Generic.List<LevelAudio.CivilisationAudioSource>::get_Count()  /*0x0A0000C6*/
    IL_000b: ldc.i4.1
    IL_000c: sub
    IL_000d: stloc.0
    IL_000e: br.s IL_005e
    IL_0010: ldarg.0
    IL_0011: ldfld List<LevelAudio.CivilisationAudioSource> LevelAudio::managedCivAudioSources  /*0x04000247*/
    IL_0016: ldloc.0
    IL_0017: callvirt !0 System.Collections.Generic.List<LevelAudio.CivilisationAudioSource>::get_Item(int)  /*0x0A0000C7*/
    IL_001c: stloc.1
    IL_001d: ldloc.1
    IL_001e: ldfld AudioSource LevelAudio.CivilisationAudioSource::audioSource  /*0x04000249*/
    IL_0023: ldnull
    IL_0024: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0029: brfalse.s IL_0039
    IL_002b: ldarg.0
    IL_002c: ldfld List<LevelAudio.CivilisationAudioSource> LevelAudio::managedCivAudioSources  /*0x04000247*/
    IL_0031: ldloc.0
    IL_0032: callvirt void System.Collections.Generic.List<LevelAudio.CivilisationAudioSource>::RemoveAt(int)  /*0x0A0000C8*/
    IL_0037: br.s IL_005a
    IL_0039: ldloc.1
    IL_003a: ldloc.1
    IL_003b: ldfld AudioSource LevelAudio.CivilisationAudioSource::audioSource  /*0x04000249*/
    IL_0040: callvirt float UnityEngine.AudioSource::get_volume()  /*0x0A0000C4*/
    IL_0045: stfld float LevelAudio.CivilisationAudioSource::targetVolume  /*0x0400024B*/
    IL_004a: ldloc.1
    IL_004b: ldfld AudioSource LevelAudio.CivilisationAudioSource::audioSource  /*0x04000249*/
    IL_0050: ldc.r4 0f
    IL_0055: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_005a: ldloc.0
    IL_005b: ldc.i4.1
    IL_005c: sub
    IL_005d: stloc.0
    IL_005e: ldloc.0
    IL_005f: ldc.i4.0
    IL_0060: bge.s IL_0010
    IL_0062: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0067: ldfld UnityEvent ThronefallAudioManager::onBuildingBuild  /*0x04000282*/
    IL_006c: ldarg.0
    IL_006d: ldftn void LevelAudio::OnNewBuildingBuilt()  /*0x060001F3*/
    IL_0073: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0078: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_007d: ret

  .method LevelAudio::OnNewBuildingBuilt()  // token 0x060001F3 rva 0x823c attrs Private, HideBySig
    // code size 171 (0xab), max stack 6, init locals
    .locals ([0] int, [1] LevelAudio.CivilisationAudioSource)
    IL_0000: ldarg.0
    IL_0001: ldfld List<LevelAudio.CivilisationAudioSource> LevelAudio::managedCivAudioSources  /*0x04000247*/
    IL_0006: callvirt int System.Collections.Generic.List<LevelAudio.CivilisationAudioSource>::get_Count()  /*0x0A0000C6*/
    IL_000b: ldc.i4.1
    IL_000c: sub
    IL_000d: stloc.0
    IL_000e: br.s IL_006f
    IL_0010: ldarg.0
    IL_0011: ldfld List<LevelAudio.CivilisationAudioSource> LevelAudio::managedCivAudioSources  /*0x04000247*/
    IL_0016: ldloc.0
    IL_0017: callvirt !0 System.Collections.Generic.List<LevelAudio.CivilisationAudioSource>::get_Item(int)  /*0x0A0000C7*/
    IL_001c: stloc.1
    IL_001d: ldloc.1
    IL_001e: ldfld AudioSource LevelAudio.CivilisationAudioSource::audioSource  /*0x04000249*/
    IL_0023: ldloc.1
    IL_0024: ldfld float LevelAudio.CivilisationAudioSource::volumeAtCastleCenterBuild  /*0x0400024A*/
    IL_0029: ldloc.1
    IL_002a: ldfld float LevelAudio.CivilisationAudioSource::targetVolume  /*0x0400024B*/
    IL_002f: ldc.r4 0f
    IL_0034: ldloc.1
    IL_0035: ldfld int LevelAudio.CivilisationAudioSource::targetBuildingAmount  /*0x0400024C*/
    IL_003a: conv.r4
    IL_003b: ldarg.0
    IL_003c: ldfld int LevelAudio::buildingCount  /*0x04000248*/
    IL_0041: conv.r4
    IL_0042: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0047: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_004c: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_0051: ldarg.0
    IL_0052: ldfld int LevelAudio::buildingCount  /*0x04000248*/
    IL_0057: ldloc.1
    IL_0058: ldfld int LevelAudio.CivilisationAudioSource::targetBuildingAmount  /*0x0400024C*/
    IL_005d: blt.s IL_006b
    IL_005f: ldarg.0
    IL_0060: ldfld List<LevelAudio.CivilisationAudioSource> LevelAudio::managedCivAudioSources  /*0x04000247*/
    IL_0065: ldloc.0
    IL_0066: callvirt void System.Collections.Generic.List<LevelAudio.CivilisationAudioSource>::RemoveAt(int)  /*0x0A0000C8*/
    IL_006b: ldloc.0
    IL_006c: ldc.i4.1
    IL_006d: sub
    IL_006e: stloc.0
    IL_006f: ldloc.0
    IL_0070: ldc.i4.0
    IL_0071: bge.s IL_0010
    IL_0073: ldarg.0
    IL_0074: ldarg.0
    IL_0075: ldfld int LevelAudio::buildingCount  /*0x04000248*/
    IL_007a: ldc.i4.1
    IL_007b: add
    IL_007c: stfld int LevelAudio::buildingCount  /*0x04000248*/
    IL_0081: ldarg.0
    IL_0082: ldfld List<LevelAudio.CivilisationAudioSource> LevelAudio::managedCivAudioSources  /*0x04000247*/
    IL_0087: callvirt int System.Collections.Generic.List<LevelAudio.CivilisationAudioSource>::get_Count()  /*0x0A0000C6*/
    IL_008c: ldc.i4.1
    IL_008d: bge.s IL_00aa
    IL_008f: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0094: ldfld UnityEvent ThronefallAudioManager::onBuildingBuild  /*0x04000282*/
    IL_0099: ldarg.0
    IL_009a: ldftn void LevelAudio::OnNewBuildingBuilt()  /*0x060001F3*/
    IL_00a0: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00a5: callvirt void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)  /*0x0A0000B2*/
    IL_00aa: ret

  .method LevelAudio::.ctor()  // token 0x060001F4 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== LevelAudio/CivilisationAudioSource  (token 0x02000055) =====
  .method LevelAudio.CivilisationAudioSource::.ctor()  // token 0x060001F5 rva 0x82f3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.1f
    IL_0006: stfld float LevelAudio.CivilisationAudioSource::volumeAtCastleCenterBuild  /*0x0400024A*/
    IL_000b: ldarg.0
    IL_000c: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0011: ret

