// ===== Ghostqueen  (token 0x02000185) =====
  .method Ghostqueen::Start()  // token 0x060007D6 rva 0x2684c attrs Private, HideBySig
    // code size 101 (0x65), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Spawn Ghostqueen::waveToSpawn  /*0x040009C8*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void Spawn::Reset(bool)  /*0x060006A6*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: call !!0 UnityEngine.Component::GetComponent()<Pathfinding.Seeker>  /*0x2B00008B*/
    IL_0013: stfld Seeker Ghostqueen::seeker  /*0x040009CC*/
    IL_0018: ldarg.0
    IL_0019: ldfld NNConstraint Ghostqueen::nearestConstraint  /*0x040009CB*/
    IL_001e: ldarg.0
    IL_001f: ldfld Seeker Ghostqueen::seeker  /*0x040009CC*/
    IL_0024: ldfld GraphMask Pathfinding.Seeker::graphMask  /*0x0A0002D1*/
    IL_0029: stfld GraphMask Pathfinding.NNConstraint::graphMask  /*0x0A000291*/
    IL_002e: ldarg.0
    IL_002f: ldfld AutoAttack Ghostqueen::aaFireStorm  /*0x040009D2*/
    IL_0034: ldc.i4.0
    IL_0035: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_003a: ldarg.0
    IL_003b: ldfld AutoAttack Ghostqueen::aaFireSpray  /*0x040009D5*/
    IL_0040: ldc.i4.0
    IL_0041: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0046: ldarg.0
    IL_0047: ldarg.0
    IL_0048: ldfld AudioSource Ghostqueen::fireStormAudio  /*0x040009D6*/
    IL_004d: callvirt float UnityEngine.AudioSource::get_volume()  /*0x0A0000C4*/
    IL_0052: stfld float Ghostqueen::fireTargetVolume  /*0x040009DE*/
    IL_0057: ldarg.0
    IL_0058: ldarg.0
    IL_0059: call IEnumerator Ghostqueen::FullBossBehaviour()  /*0x060007D8*/
    IL_005e: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0063: pop
    IL_0064: ret

  .method Ghostqueen::Update()  // token 0x060007D7 rva 0x268c0 attrs Private, HideBySig
    // code size 194 (0xc2), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Light Ghostqueen::nightLightCache  /*0x040009C7*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_001f
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: ldfld NightLight Ghostqueen::nightLight  /*0x040009C4*/
    IL_0015: callvirt !!0 UnityEngine.Component::GetComponent()<UnityEngine.Light>  /*0x2B00002C*/
    IL_001a: stfld Light Ghostqueen::nightLightCache  /*0x040009C7*/
    IL_001f: ldarg.0
    IL_0020: ldfld Light Ghostqueen::nightLightCache  /*0x040009C7*/
    IL_0025: ldarg.0
    IL_0026: ldfld Color Ghostqueen::nichtLightColor  /*0x040009C5*/
    IL_002b: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_0030: ldarg.0
    IL_0031: ldfld NightLight Ghostqueen::nightLight  /*0x040009C4*/
    IL_0036: ldarg.0
    IL_0037: ldfld float Ghostqueen::nightLightIntensity  /*0x040009DD*/
    IL_003c: stfld float NightLight::targetIntensity  /*0x04000D86*/
    IL_0041: ldarg.0
    IL_0042: ldc.r4 1.5f
    IL_0047: ldarg.0
    IL_0048: ldfld float Ghostqueen::nightLightIntensity  /*0x040009DD*/
    IL_004d: ldc.r4 0.2f
    IL_0052: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0057: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_005c: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0061: stfld float Ghostqueen::nightLightIntensity  /*0x040009DD*/
    IL_0066: ldarg.0
    IL_0067: ldfld NightLight Ghostqueen::nightLight  /*0x040009C4*/
    IL_006c: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0071: ldarg.0
    IL_0072: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0077: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_007c: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0081: ldarg.0
    IL_0082: ldfld Light Ghostqueen::nightLightCache  /*0x040009C7*/
    IL_0087: ldc.r4 150f
    IL_008c: callvirt void UnityEngine.Light::set_range(float)  /*0x0A0003AE*/
    IL_0091: ldarg.0
    IL_0092: ldfld Light Ghostqueen::directionalLight  /*0x040009C9*/
    IL_0097: ldarg.0
    IL_0098: ldfld Color Ghostqueen::directionalLightColor  /*0x040009C6*/
    IL_009d: ldarg.0
    IL_009e: ldfld Light Ghostqueen::directionalLight  /*0x040009C9*/
    IL_00a3: callvirt Color UnityEngine.Light::get_color()  /*0x0A000199*/
    IL_00a8: ldc.r4 0.5f
    IL_00ad: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00b2: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_00b7: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_00bc: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_00c1: ret

  .method Ghostqueen::FullBossBehaviour()  // token 0x060007D8 rva 0x2698e attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void Ghostqueen.<FullBossBehaviour>d__29::.ctor(int)  /*0x060007E4*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld Ghostqueen Ghostqueen.<FullBossBehaviour>d__29::<>4__this  /*0x040009E6*/
    IL_000d: ret

  .method Ghostqueen::FireStorm(float)  // token 0x060007D9 rva 0x2699d attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void Ghostqueen.<FireStorm>d__30::.ctor(int)  /*0x060007DE*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld Ghostqueen Ghostqueen.<FireStorm>d__30::<>4__this  /*0x040009E1*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float Ghostqueen.<FireStorm>d__30::duration  /*0x040009E2*/
    IL_0014: ret

  .method Ghostqueen::SpawnGhosts()  // token 0x060007DA rva 0x269b3 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void Ghostqueen.<SpawnGhosts>d__31::.ctor(int)  /*0x060007F0*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld Ghostqueen Ghostqueen.<SpawnGhosts>d__31::<>4__this  /*0x040009F0*/
    IL_000d: ret

  .method Ghostqueen::SpawnFireBolts(float,float)  // token 0x060007DB rva 0x269c2 attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void Ghostqueen.<SpawnFireBolts>d__32::.ctor(int)  /*0x060007EA*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld Ghostqueen Ghostqueen.<SpawnFireBolts>d__32::<>4__this  /*0x040009E9*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float Ghostqueen.<SpawnFireBolts>d__32::interval  /*0x040009EA*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld float Ghostqueen.<SpawnFireBolts>d__32::waitafter  /*0x040009EB*/
    IL_001b: ret

  .method Ghostqueen::SpawnFireBolt(UnityEngine.Vector3)  // token 0x060007DC rva 0x269e0 attrs Private, HideBySig
    // code size 69 (0x45), max stack 3, init locals
    .locals ([0] Vector3)
    IL_0000: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_0005: ldarg.1
    IL_0006: ldarg.0
    IL_0007: ldfld NNConstraint Ghostqueen::nearestConstraint  /*0x040009CB*/
    IL_000c: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_0011: ldfld Vector3 Pathfinding.NNInfo::position  /*0x0A00028D*/
    IL_0016: stloc.0
    IL_0017: ldarg.0
    IL_0018: ldfld GameObject Ghostqueen::fireBolt  /*0x040009CD*/
    IL_001d: ldloc.0
    IL_001e: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0023: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_0028: callvirt !!0 UnityEngine.GameObject::GetComponent()<SpawnAttackAfter>  /*0x2B00008C*/
    IL_002d: dup
    IL_002e: ldfld float SpawnAttackAfter::damageMultiplyer  /*0x04000CE1*/
    IL_0033: ldarg.0
    IL_0034: ldfld AutoAttack Ghostqueen::autoAttack  /*0x040009CE*/
    IL_0039: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_003e: mul
    IL_003f: stfld float SpawnAttackAfter::damageMultiplyer  /*0x04000CE1*/
    IL_0044: ret

  .method Ghostqueen::.ctor()  // token 0x060007DD rva 0x26a34 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 92 (0x5c), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.25f
    IL_0006: stfld float Ghostqueen::directionalLightFlickerSpeed  /*0x040009CA*/
    IL_000b: ldarg.0
    IL_000c: newobj void Pathfinding.NNConstraint::.ctor()  /*0x0A0002AB*/
    IL_0011: stfld NNConstraint Ghostqueen::nearestConstraint  /*0x040009CB*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 10f
    IL_001c: stfld float Ghostqueen::fireStormDuration  /*0x040009D7*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 3f
    IL_0027: stfld float Ghostqueen::fireBoltPreDelay  /*0x040009D8*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 0.33f
    IL_0032: stfld float Ghostqueen::fireBoltInterval  /*0x040009D9*/
    IL_0037: ldarg.0
    IL_0038: ldc.i4.s 14
    IL_003a: stfld int Ghostqueen::fireBoltCount  /*0x040009DA*/
    IL_003f: ldarg.0
    IL_0040: ldc.r4 2f
    IL_0045: stfld float Ghostqueen::fireBoltAfterDelay  /*0x040009DB*/
    IL_004a: ldarg.0
    IL_004b: ldc.r4 10f
    IL_0050: stfld float Ghostqueen::fireSprayDuration  /*0x040009DC*/
    IL_0055: ldarg.0
    IL_0056: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_005b: ret

// ===== Ghostqueen/<FireStorm>d__30  (token 0x02000186) =====
  .method Ghostqueen.<FireStorm>d__30::.ctor(int)  // token 0x060007DE rva 0x26a9c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int Ghostqueen.<FireStorm>d__30::<>1__state  /*0x040009DF*/
    IL_000d: ret

  .method Ghostqueen.<FireStorm>d__30::System.IDisposable.Dispose()  // token 0x060007DF rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Ghostqueen.<FireStorm>d__30::MoveNext()  // token 0x060007E0 rva 0x26aac attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 523 (0x20b), max stack 3, init locals
    .locals ([0] int, [1] Ghostqueen)
    IL_0000: ldarg.0
    IL_0001: ldfld int Ghostqueen.<FireStorm>d__30::<>1__state  /*0x040009DF*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld Ghostqueen Ghostqueen.<FireStorm>d__30::<>4__this  /*0x040009E1*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0026, IL_00b5, IL_0125, IL_01a3)
    IL_0024: ldc.i4.0
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldc.i4.m1
    IL_0028: stfld int Ghostqueen.<FireStorm>d__30::<>1__state  /*0x040009DF*/
    IL_002d: ldloc.1
    IL_002e: ldfld AutoAttack Ghostqueen::aaFireSpray  /*0x040009D5*/
    IL_0033: ldc.i4.0
    IL_0034: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0039: ldloc.1
    IL_003a: ldfld Transform Ghostqueen::transFireStorm  /*0x040009D3*/
    IL_003f: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0044: ldc.i4.1
    IL_0045: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_004a: ldarg.0
    IL_004b: ldc.r4 0f
    IL_0050: stfld float Ghostqueen.<FireStorm>d__30::<scale>5__2  /*0x040009E3*/
    IL_0055: br.s IL_00ce
    IL_0057: ldloc.1
    IL_0058: ldfld Transform Ghostqueen::transFireStorm  /*0x040009D3*/
    IL_005d: ldarg.0
    IL_005e: ldfld float Ghostqueen.<FireStorm>d__30::<scale>5__2  /*0x040009E3*/
    IL_0063: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0068: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_006d: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0072: ldloc.1
    IL_0073: ldfld Transform Ghostqueen::transFireStormParticles  /*0x040009D4*/
    IL_0078: ldarg.0
    IL_0079: ldfld float Ghostqueen.<FireStorm>d__30::<scale>5__2  /*0x040009E3*/
    IL_007e: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0083: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_0088: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_008d: ldloc.1
    IL_008e: ldfld AudioSource Ghostqueen::fireStormAudio  /*0x040009D6*/
    IL_0093: ldloc.1
    IL_0094: ldfld float Ghostqueen::fireTargetVolume  /*0x040009DE*/
    IL_0099: ldarg.0
    IL_009a: ldfld float Ghostqueen.<FireStorm>d__30::<scale>5__2  /*0x040009E3*/
    IL_009f: mul
    IL_00a0: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_00a5: ldarg.0
    IL_00a6: ldnull
    IL_00a7: stfld object Ghostqueen.<FireStorm>d__30::<>2__current  /*0x040009E0*/
    IL_00ac: ldarg.0
    IL_00ad: ldc.i4.1
    IL_00ae: stfld int Ghostqueen.<FireStorm>d__30::<>1__state  /*0x040009DF*/
    IL_00b3: ldc.i4.1
    IL_00b4: ret
    IL_00b5: ldarg.0
    IL_00b6: ldc.i4.m1
    IL_00b7: stfld int Ghostqueen.<FireStorm>d__30::<>1__state  /*0x040009DF*/
    IL_00bc: ldarg.0
    IL_00bd: ldarg.0
    IL_00be: ldfld float Ghostqueen.<FireStorm>d__30::<scale>5__2  /*0x040009E3*/
    IL_00c3: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00c8: add
    IL_00c9: stfld float Ghostqueen.<FireStorm>d__30::<scale>5__2  /*0x040009E3*/
    IL_00ce: ldarg.0
    IL_00cf: ldfld float Ghostqueen.<FireStorm>d__30::<scale>5__2  /*0x040009E3*/
    IL_00d4: ldc.r4 1f
    IL_00d9: blt IL_0057
    IL_00de: ldloc.1
    IL_00df: ldfld Transform Ghostqueen::transFireStorm  /*0x040009D3*/
    IL_00e4: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00e9: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00ee: ldloc.1
    IL_00ef: ldfld AudioSource Ghostqueen::fireStormAudio  /*0x040009D6*/
    IL_00f4: ldloc.1
    IL_00f5: ldfld float Ghostqueen::fireTargetVolume  /*0x040009DE*/
    IL_00fa: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_00ff: ldloc.1
    IL_0100: ldfld AutoAttack Ghostqueen::aaFireStorm  /*0x040009D2*/
    IL_0105: ldc.i4.1
    IL_0106: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_010b: ldarg.0
    IL_010c: ldarg.0
    IL_010d: ldfld float Ghostqueen.<FireStorm>d__30::duration  /*0x040009E2*/
    IL_0112: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0117: stfld object Ghostqueen.<FireStorm>d__30::<>2__current  /*0x040009E0*/
    IL_011c: ldarg.0
    IL_011d: ldc.i4.2
    IL_011e: stfld int Ghostqueen.<FireStorm>d__30::<>1__state  /*0x040009DF*/
    IL_0123: ldc.i4.1
    IL_0124: ret
    IL_0125: ldarg.0
    IL_0126: ldc.i4.m1
    IL_0127: stfld int Ghostqueen.<FireStorm>d__30::<>1__state  /*0x040009DF*/
    IL_012c: ldloc.1
    IL_012d: ldfld AutoAttack Ghostqueen::aaFireStorm  /*0x040009D2*/
    IL_0132: ldc.i4.0
    IL_0133: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0138: ldarg.0
    IL_0139: ldc.r4 1f
    IL_013e: stfld float Ghostqueen.<FireStorm>d__30::<scale>5__2  /*0x040009E3*/
    IL_0143: br.s IL_01bc
    IL_0145: ldloc.1
    IL_0146: ldfld Transform Ghostqueen::transFireStorm  /*0x040009D3*/
    IL_014b: ldarg.0
    IL_014c: ldfld float Ghostqueen.<FireStorm>d__30::<scale>5__2  /*0x040009E3*/
    IL_0151: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0156: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_015b: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0160: ldloc.1
    IL_0161: ldfld Transform Ghostqueen::transFireStormParticles  /*0x040009D4*/
    IL_0166: ldarg.0
    IL_0167: ldfld float Ghostqueen.<FireStorm>d__30::<scale>5__2  /*0x040009E3*/
    IL_016c: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0171: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_0176: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_017b: ldloc.1
    IL_017c: ldfld AudioSource Ghostqueen::fireStormAudio  /*0x040009D6*/
    IL_0181: ldloc.1
    IL_0182: ldfld float Ghostqueen::fireTargetVolume  /*0x040009DE*/
    IL_0187: ldarg.0
    IL_0188: ldfld float Ghostqueen.<FireStorm>d__30::<scale>5__2  /*0x040009E3*/
    IL_018d: mul
    IL_018e: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_0193: ldarg.0
    IL_0194: ldnull
    IL_0195: stfld object Ghostqueen.<FireStorm>d__30::<>2__current  /*0x040009E0*/
    IL_019a: ldarg.0
    IL_019b: ldc.i4.3
    IL_019c: stfld int Ghostqueen.<FireStorm>d__30::<>1__state  /*0x040009DF*/
    IL_01a1: ldc.i4.1
    IL_01a2: ret
    IL_01a3: ldarg.0
    IL_01a4: ldc.i4.m1
    IL_01a5: stfld int Ghostqueen.<FireStorm>d__30::<>1__state  /*0x040009DF*/
    IL_01aa: ldarg.0
    IL_01ab: ldarg.0
    IL_01ac: ldfld float Ghostqueen.<FireStorm>d__30::<scale>5__2  /*0x040009E3*/
    IL_01b1: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_01b6: sub
    IL_01b7: stfld float Ghostqueen.<FireStorm>d__30::<scale>5__2  /*0x040009E3*/
    IL_01bc: ldarg.0
    IL_01bd: ldfld float Ghostqueen.<FireStorm>d__30::<scale>5__2  /*0x040009E3*/
    IL_01c2: ldc.r4 0f
    IL_01c7: bgt IL_0145
    IL_01cc: ldloc.1
    IL_01cd: ldfld Transform Ghostqueen::transFireStorm  /*0x040009D3*/
    IL_01d2: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_01d7: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_01dc: ldloc.1
    IL_01dd: ldfld AudioSource Ghostqueen::fireStormAudio  /*0x040009D6*/
    IL_01e2: ldc.r4 0f
    IL_01e7: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_01ec: ldloc.1
    IL_01ed: ldfld Transform Ghostqueen::transFireStorm  /*0x040009D3*/
    IL_01f2: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01f7: ldc.i4.0
    IL_01f8: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01fd: ldloc.1
    IL_01fe: ldfld AutoAttack Ghostqueen::aaFireSpray  /*0x040009D5*/
    IL_0203: ldc.i4.1
    IL_0204: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0209: ldc.i4.0
    IL_020a: ret

  .method Ghostqueen.<FireStorm>d__30::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060007E1 rva 0x26cc3 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object Ghostqueen.<FireStorm>d__30::<>2__current  /*0x040009E0*/
    IL_0006: ret

  .method Ghostqueen.<FireStorm>d__30::System.Collections.IEnumerator.Reset()  // token 0x060007E2 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method Ghostqueen.<FireStorm>d__30::System.Collections.IEnumerator.get_Current()  // token 0x060007E3 rva 0x26cc3 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object Ghostqueen.<FireStorm>d__30::<>2__current  /*0x040009E0*/
    IL_0006: ret

// ===== Ghostqueen/<FullBossBehaviour>d__29  (token 0x02000187) =====
  .method Ghostqueen.<FullBossBehaviour>d__29::.ctor(int)  // token 0x060007E4 rva 0x26ccb attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int Ghostqueen.<FullBossBehaviour>d__29::<>1__state  /*0x040009E4*/
    IL_000d: ret

  .method Ghostqueen.<FullBossBehaviour>d__29::System.IDisposable.Dispose()  // token 0x060007E5 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Ghostqueen.<FullBossBehaviour>d__29::MoveNext()  // token 0x060007E6 rva 0x26cdc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 240 (0xf0), max stack 4, init locals
    .locals ([0] int, [1] Ghostqueen)
    IL_0000: ldarg.0
    IL_0001: ldfld int Ghostqueen.<FullBossBehaviour>d__29::<>1__state  /*0x040009E4*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld Ghostqueen Ghostqueen.<FullBossBehaviour>d__29::<>4__this  /*0x040009E6*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_002e, IL_0045, IL_007f, IL_00a7, IL_00c3, IL_00e4)
    IL_002c: ldc.i4.0
    IL_002d: ret
    IL_002e: ldarg.0
    IL_002f: ldc.i4.m1
    IL_0030: stfld int Ghostqueen.<FullBossBehaviour>d__29::<>1__state  /*0x040009E4*/
    IL_0035: ldarg.0
    IL_0036: ldnull
    IL_0037: stfld object Ghostqueen.<FullBossBehaviour>d__29::<>2__current  /*0x040009E5*/
    IL_003c: ldarg.0
    IL_003d: ldc.i4.1
    IL_003e: stfld int Ghostqueen.<FullBossBehaviour>d__29::<>1__state  /*0x040009E4*/
    IL_0043: ldc.i4.1
    IL_0044: ret
    IL_0045: ldarg.0
    IL_0046: ldc.i4.m1
    IL_0047: stfld int Ghostqueen.<FullBossBehaviour>d__29::<>1__state  /*0x040009E4*/
    IL_004c: ldloc.1
    IL_004d: ldfld AutoAttack Ghostqueen::aaFireStorm  /*0x040009D2*/
    IL_0052: ldc.i4.0
    IL_0053: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0058: ldloc.1
    IL_0059: ldfld AutoAttack Ghostqueen::aaFireSpray  /*0x040009D5*/
    IL_005e: ldc.i4.0
    IL_005f: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0064: ldarg.0
    IL_0065: ldloc.1
    IL_0066: ldloc.1
    IL_0067: ldfld float Ghostqueen::fireStormDuration  /*0x040009D7*/
    IL_006c: call IEnumerator Ghostqueen::FireStorm(float)  /*0x060007D9*/
    IL_0071: stfld object Ghostqueen.<FullBossBehaviour>d__29::<>2__current  /*0x040009E5*/
    IL_0076: ldarg.0
    IL_0077: ldc.i4.2
    IL_0078: stfld int Ghostqueen.<FullBossBehaviour>d__29::<>1__state  /*0x040009E4*/
    IL_007d: ldc.i4.1
    IL_007e: ret
    IL_007f: ldarg.0
    IL_0080: ldc.i4.m1
    IL_0081: stfld int Ghostqueen.<FullBossBehaviour>d__29::<>1__state  /*0x040009E4*/
    IL_0086: ldarg.0
    IL_0087: ldloc.1
    IL_0088: ldloc.1
    IL_0089: ldfld float Ghostqueen::fireBoltInterval  /*0x040009D9*/
    IL_008e: ldloc.1
    IL_008f: ldfld float Ghostqueen::fireBoltAfterDelay  /*0x040009DB*/
    IL_0094: call IEnumerator Ghostqueen::SpawnFireBolts(float,float)  /*0x060007DB*/
    IL_0099: stfld object Ghostqueen.<FullBossBehaviour>d__29::<>2__current  /*0x040009E5*/
    IL_009e: ldarg.0
    IL_009f: ldc.i4.3
    IL_00a0: stfld int Ghostqueen.<FullBossBehaviour>d__29::<>1__state  /*0x040009E4*/
    IL_00a5: ldc.i4.1
    IL_00a6: ret
    IL_00a7: ldarg.0
    IL_00a8: ldc.i4.m1
    IL_00a9: stfld int Ghostqueen.<FullBossBehaviour>d__29::<>1__state  /*0x040009E4*/
    IL_00ae: ldarg.0
    IL_00af: ldloc.1
    IL_00b0: call IEnumerator Ghostqueen::SpawnGhosts()  /*0x060007DA*/
    IL_00b5: stfld object Ghostqueen.<FullBossBehaviour>d__29::<>2__current  /*0x040009E5*/
    IL_00ba: ldarg.0
    IL_00bb: ldc.i4.4
    IL_00bc: stfld int Ghostqueen.<FullBossBehaviour>d__29::<>1__state  /*0x040009E4*/
    IL_00c1: ldc.i4.1
    IL_00c2: ret
    IL_00c3: ldarg.0
    IL_00c4: ldc.i4.m1
    IL_00c5: stfld int Ghostqueen.<FullBossBehaviour>d__29::<>1__state  /*0x040009E4*/
    IL_00ca: ldarg.0
    IL_00cb: ldloc.1
    IL_00cc: ldfld float Ghostqueen::fireSprayDuration  /*0x040009DC*/
    IL_00d1: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_00d6: stfld object Ghostqueen.<FullBossBehaviour>d__29::<>2__current  /*0x040009E5*/
    IL_00db: ldarg.0
    IL_00dc: ldc.i4.5
    IL_00dd: stfld int Ghostqueen.<FullBossBehaviour>d__29::<>1__state  /*0x040009E4*/
    IL_00e2: ldc.i4.1
    IL_00e3: ret
    IL_00e4: ldarg.0
    IL_00e5: ldc.i4.m1
    IL_00e6: stfld int Ghostqueen.<FullBossBehaviour>d__29::<>1__state  /*0x040009E4*/
    IL_00eb: br IL_0064

  .method Ghostqueen.<FullBossBehaviour>d__29::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060007E7 rva 0x26dd8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object Ghostqueen.<FullBossBehaviour>d__29::<>2__current  /*0x040009E5*/
    IL_0006: ret

  .method Ghostqueen.<FullBossBehaviour>d__29::System.Collections.IEnumerator.Reset()  // token 0x060007E8 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method Ghostqueen.<FullBossBehaviour>d__29::System.Collections.IEnumerator.get_Current()  // token 0x060007E9 rva 0x26dd8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object Ghostqueen.<FullBossBehaviour>d__29::<>2__current  /*0x040009E5*/
    IL_0006: ret

// ===== Ghostqueen/<SpawnFireBolts>d__32  (token 0x02000188) =====
  .method Ghostqueen.<SpawnFireBolts>d__32::.ctor(int)  // token 0x060007EA rva 0x26de0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int Ghostqueen.<SpawnFireBolts>d__32::<>1__state  /*0x040009E7*/
    IL_000d: ret

  .method Ghostqueen.<SpawnFireBolts>d__32::System.IDisposable.Dispose()  // token 0x060007EB rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Ghostqueen.<SpawnFireBolts>d__32::MoveNext()  // token 0x060007EC rva 0x26df0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 352 (0x160), max stack 6, init locals
    .locals ([0] int, [1] Ghostqueen, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int Ghostqueen.<SpawnFireBolts>d__32::<>1__state  /*0x040009E7*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld Ghostqueen Ghostqueen.<SpawnFireBolts>d__32::<>4__this  /*0x040009E9*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0026, IL_008a, IL_0115, IL_0157)
    IL_0024: ldc.i4.0
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldc.i4.m1
    IL_0028: stfld int Ghostqueen.<SpawnFireBolts>d__32::<>1__state  /*0x040009E7*/
    IL_002d: ldloc.1
    IL_002e: ldfld AutoAttack Ghostqueen::aaFireSpray  /*0x040009D5*/
    IL_0033: ldc.i4.0
    IL_0034: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0039: ldarg.0
    IL_003a: ldloc.1
    IL_003b: ldfld MovementFollowPath Ghostqueen::followPath  /*0x040009CF*/
    IL_0040: ldfld float MovementFollowPath::speed  /*0x04000D70*/
    IL_0045: stfld float Ghostqueen.<SpawnFireBolts>d__32::<rememberSpeed>5__2  /*0x040009EC*/
    IL_004a: ldloc.1
    IL_004b: ldfld MovementFollowPath Ghostqueen::followPath  /*0x040009CF*/
    IL_0050: ldc.r4 0f
    IL_0055: stfld float MovementFollowPath::speed  /*0x04000D70*/
    IL_005a: ldloc.1
    IL_005b: ldfld AudioSource Ghostqueen::specialAttackAudio  /*0x040009D0*/
    IL_0060: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_0065: ldloc.1
    IL_0066: ldfld ParticleSystem Ghostqueen::specialAttackParticles  /*0x040009D1*/
    IL_006b: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_0070: ldarg.0
    IL_0071: ldloc.1
    IL_0072: ldfld float Ghostqueen::fireBoltPreDelay  /*0x040009D8*/
    IL_0077: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_007c: stfld object Ghostqueen.<SpawnFireBolts>d__32::<>2__current  /*0x040009E8*/
    IL_0081: ldarg.0
    IL_0082: ldc.i4.1
    IL_0083: stfld int Ghostqueen.<SpawnFireBolts>d__32::<>1__state  /*0x040009E7*/
    IL_0088: ldc.i4.1
    IL_0089: ret
    IL_008a: ldarg.0
    IL_008b: ldc.i4.m1
    IL_008c: stfld int Ghostqueen.<SpawnFireBolts>d__32::<>1__state  /*0x040009E7*/
    IL_0091: ldloc.1
    IL_0092: ldfld MovementFollowPath Ghostqueen::followPath  /*0x040009CF*/
    IL_0097: ldarg.0
    IL_0098: ldfld float Ghostqueen.<SpawnFireBolts>d__32::<rememberSpeed>5__2  /*0x040009EC*/
    IL_009d: stfld float MovementFollowPath::speed  /*0x04000D70*/
    IL_00a2: ldloc.1
    IL_00a3: ldfld AutoAttack Ghostqueen::aaFireSpray  /*0x040009D5*/
    IL_00a8: ldc.i4.1
    IL_00a9: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_00ae: ldarg.0
    IL_00af: ldc.i4.0
    IL_00b0: stfld int Ghostqueen.<SpawnFireBolts>d__32::<i>5__3  /*0x040009ED*/
    IL_00b5: br.s IL_012c
    IL_00b7: ldloc.1
    IL_00b8: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_00bd: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00c2: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00c7: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_00cc: ldc.r4 0.5f
    IL_00d1: sub
    IL_00d2: ldc.r4 0f
    IL_00d7: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_00dc: ldc.r4 0.5f
    IL_00e1: sub
    IL_00e2: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_00e7: ldc.r4 15f
    IL_00ec: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00f1: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00f6: call void Ghostqueen::SpawnFireBolt(UnityEngine.Vector3)  /*0x060007DC*/
    IL_00fb: ldarg.0
    IL_00fc: ldarg.0
    IL_00fd: ldfld float Ghostqueen.<SpawnFireBolts>d__32::interval  /*0x040009EA*/
    IL_0102: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0107: stfld object Ghostqueen.<SpawnFireBolts>d__32::<>2__current  /*0x040009E8*/
    IL_010c: ldarg.0
    IL_010d: ldc.i4.2
    IL_010e: stfld int Ghostqueen.<SpawnFireBolts>d__32::<>1__state  /*0x040009E7*/
    IL_0113: ldc.i4.1
    IL_0114: ret
    IL_0115: ldarg.0
    IL_0116: ldc.i4.m1
    IL_0117: stfld int Ghostqueen.<SpawnFireBolts>d__32::<>1__state  /*0x040009E7*/
    IL_011c: ldarg.0
    IL_011d: ldfld int Ghostqueen.<SpawnFireBolts>d__32::<i>5__3  /*0x040009ED*/
    IL_0122: stloc.2
    IL_0123: ldarg.0
    IL_0124: ldloc.2
    IL_0125: ldc.i4.1
    IL_0126: add
    IL_0127: stfld int Ghostqueen.<SpawnFireBolts>d__32::<i>5__3  /*0x040009ED*/
    IL_012c: ldarg.0
    IL_012d: ldfld int Ghostqueen.<SpawnFireBolts>d__32::<i>5__3  /*0x040009ED*/
    IL_0132: ldloc.1
    IL_0133: ldfld int Ghostqueen::fireBoltCount  /*0x040009DA*/
    IL_0138: blt IL_00b7
    IL_013d: ldarg.0
    IL_013e: ldarg.0
    IL_013f: ldfld float Ghostqueen.<SpawnFireBolts>d__32::waitafter  /*0x040009EB*/
    IL_0144: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0149: stfld object Ghostqueen.<SpawnFireBolts>d__32::<>2__current  /*0x040009E8*/
    IL_014e: ldarg.0
    IL_014f: ldc.i4.3
    IL_0150: stfld int Ghostqueen.<SpawnFireBolts>d__32::<>1__state  /*0x040009E7*/
    IL_0155: ldc.i4.1
    IL_0156: ret
    IL_0157: ldarg.0
    IL_0158: ldc.i4.m1
    IL_0159: stfld int Ghostqueen.<SpawnFireBolts>d__32::<>1__state  /*0x040009E7*/
    IL_015e: ldc.i4.0
    IL_015f: ret

  .method Ghostqueen.<SpawnFireBolts>d__32::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060007ED rva 0x26f5c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object Ghostqueen.<SpawnFireBolts>d__32::<>2__current  /*0x040009E8*/
    IL_0006: ret

  .method Ghostqueen.<SpawnFireBolts>d__32::System.Collections.IEnumerator.Reset()  // token 0x060007EE rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method Ghostqueen.<SpawnFireBolts>d__32::System.Collections.IEnumerator.get_Current()  // token 0x060007EF rva 0x26f5c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object Ghostqueen.<SpawnFireBolts>d__32::<>2__current  /*0x040009E8*/
    IL_0006: ret

// ===== Ghostqueen/<SpawnGhosts>d__31  (token 0x02000189) =====
  .method Ghostqueen.<SpawnGhosts>d__31::.ctor(int)  // token 0x060007F0 rva 0x26f64 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int Ghostqueen.<SpawnGhosts>d__31::<>1__state  /*0x040009EE*/
    IL_000d: ret

  .method Ghostqueen.<SpawnGhosts>d__31::System.IDisposable.Dispose()  // token 0x060007F1 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Ghostqueen.<SpawnGhosts>d__31::MoveNext()  // token 0x060007F2 rva 0x26f74 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 98 (0x62), max stack 2, init locals
    .locals ([0] int, [1] Ghostqueen)
    IL_0000: ldarg.0
    IL_0001: ldfld int Ghostqueen.<SpawnGhosts>d__31::<>1__state  /*0x040009EE*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld Ghostqueen Ghostqueen.<SpawnGhosts>d__31::<>4__this  /*0x040009F0*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_004c
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int Ghostqueen.<SpawnGhosts>d__31::<>1__state  /*0x040009EE*/
    IL_001e: ldloc.1
    IL_001f: ldfld Spawn Ghostqueen::waveToSpawn  /*0x040009C8*/
    IL_0024: ldc.i4.1
    IL_0025: callvirt void Spawn::Reset(bool)  /*0x060006A6*/
    IL_002a: br.s IL_0053
    IL_002c: ldloc.1
    IL_002d: ldfld Spawn Ghostqueen::waveToSpawn  /*0x040009C8*/
    IL_0032: ldc.r4 1f
    IL_0037: callvirt void Spawn::Update(float)  /*0x060006A7*/
    IL_003c: ldarg.0
    IL_003d: ldnull
    IL_003e: stfld object Ghostqueen.<SpawnGhosts>d__31::<>2__current  /*0x040009EF*/
    IL_0043: ldarg.0
    IL_0044: ldc.i4.1
    IL_0045: stfld int Ghostqueen.<SpawnGhosts>d__31::<>1__state  /*0x040009EE*/
    IL_004a: ldc.i4.1
    IL_004b: ret
    IL_004c: ldarg.0
    IL_004d: ldc.i4.m1
    IL_004e: stfld int Ghostqueen.<SpawnGhosts>d__31::<>1__state  /*0x040009EE*/
    IL_0053: ldloc.1
    IL_0054: ldfld Spawn Ghostqueen::waveToSpawn  /*0x040009C8*/
    IL_0059: callvirt bool Spawn::get_Finished()  /*0x060006A3*/
    IL_005e: brfalse.s IL_002c
    IL_0060: ldc.i4.0
    IL_0061: ret

  .method Ghostqueen.<SpawnGhosts>d__31::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060007F3 rva 0x26fe2 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object Ghostqueen.<SpawnGhosts>d__31::<>2__current  /*0x040009EF*/
    IL_0006: ret

  .method Ghostqueen.<SpawnGhosts>d__31::System.Collections.IEnumerator.Reset()  // token 0x060007F4 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method Ghostqueen.<SpawnGhosts>d__31::System.Collections.IEnumerator.get_Current()  // token 0x060007F5 rva 0x26fe2 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object Ghostqueen.<SpawnGhosts>d__31::<>2__current  /*0x040009EF*/
    IL_0006: ret

