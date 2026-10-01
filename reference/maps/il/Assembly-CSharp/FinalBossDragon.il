// ===== FinalBossDragon  (token 0x02000163) =====
  .method FinalBossDragon::Start()  // token 0x0600073D rva 0x24758 attrs Private, HideBySig
    // code size 80 (0x50), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld List<string> FinalBossDragon::animationTriggers  /*0x0400091F*/
    IL_0007: callvirt int System.Collections.Generic.List<string>::get_Count()  /*0x0A000047*/
    IL_000c: stfld int FinalBossDragon::healthSegments  /*0x04000920*/
    IL_0011: ldarg.0
    IL_0012: ldc.i4.0
    IL_0013: stfld int FinalBossDragon::currentSegment  /*0x04000921*/
    IL_0018: ldarg.0
    IL_0019: ldc.i4.0
    IL_001a: ldc.i4.0
    IL_001b: call void FinalBossDragon::OnLoseHealthSegment(int,bool)  /*0x06000741*/
    IL_0020: ldarg.0
    IL_0021: ldfld Hp FinalBossDragon::hp  /*0x0400091D*/
    IL_0026: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_002b: ldarg.0
    IL_002c: ldftn void FinalBossDragon::SpawnSecondBossStage()  /*0x06000743*/
    IL_0032: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0037: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_003c: ldarg.0
    IL_003d: ldfld AudioSource FinalBossDragon::screamAudioSource  /*0x04000927*/
    IL_0042: ldarg.0
    IL_0043: ldfld AudioClip[] FinalBossDragon::bossScreams  /*0x04000926*/
    IL_0048: ldc.i4.0
    IL_0049: ldelem.ref
    IL_004a: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_004f: ret

  .method FinalBossDragon::Update()  // token 0x0600073E rva 0x247b4 attrs Private, HideBySig
    // code size 138 (0x8a), max stack 4, init locals
    .locals ([0] float, [1] float, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld Hp FinalBossDragon::hp  /*0x0400091D*/
    IL_0006: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_000b: ldarg.0
    IL_000c: ldfld int FinalBossDragon::healthSegments  /*0x04000920*/
    IL_0011: conv.r4
    IL_0012: div
    IL_0013: stloc.0
    IL_0014: ldarg.0
    IL_0015: ldfld Hp FinalBossDragon::hp  /*0x0400091D*/
    IL_001a: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_001f: stloc.1
    IL_0020: ldarg.0
    IL_0021: ldfld int FinalBossDragon::healthSegments  /*0x04000920*/
    IL_0026: conv.r4
    IL_0027: ldloc.1
    IL_0028: ldloc.0
    IL_0029: div
    IL_002a: sub
    IL_002b: call int UnityEngine.Mathf::FloorToInt(float)  /*0x0A000144*/
    IL_0030: stloc.2
    IL_0031: ldloc.2
    IL_0032: ldc.i4.0
    IL_0033: ldarg.0
    IL_0034: ldfld int FinalBossDragon::healthSegments  /*0x04000920*/
    IL_0039: ldc.i4.1
    IL_003a: sub
    IL_003b: call int UnityEngine.Mathf::Clamp(int,int,int)  /*0x0A000228*/
    IL_0040: stloc.2
    IL_0041: ldloc.2
    IL_0042: ldarg.0
    IL_0043: ldfld int FinalBossDragon::currentSegment  /*0x04000921*/
    IL_0048: beq.s IL_005e
    IL_004a: ldarg.0
    IL_004b: ldloc.2
    IL_004c: stfld int FinalBossDragon::currentSegment  /*0x04000921*/
    IL_0051: ldarg.0
    IL_0052: ldarg.0
    IL_0053: ldfld int FinalBossDragon::currentSegment  /*0x04000921*/
    IL_0058: ldc.i4.1
    IL_0059: call void FinalBossDragon::OnLoseHealthSegment(int,bool)  /*0x06000741*/
    IL_005e: ldarg.0
    IL_005f: ldarg.0
    IL_0060: ldfld float FinalBossDragon::invulnerableFor  /*0x0400092C*/
    IL_0065: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_006a: sub
    IL_006b: stfld float FinalBossDragon::invulnerableFor  /*0x0400092C*/
    IL_0070: ldarg.0
    IL_0071: ldfld float FinalBossDragon::invulnerableFor  /*0x0400092C*/
    IL_0076: ldc.r4 0f
    IL_007b: bge.un.s IL_0089
    IL_007d: ldarg.0
    IL_007e: ldfld Hp FinalBossDragon::hp  /*0x0400091D*/
    IL_0083: ldc.i4.0
    IL_0084: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0089: ret

  .method FinalBossDragon::EnablePuke()  // token 0x0600073F rva 0x2484c attrs Public, HideBySig
    // code size 33 (0x21), max stack 2, init locals
    .locals ([0] ParticleSystem.EmissionModule)
    IL_0000: ldarg.0
    IL_0001: ldfld ParticleSystem FinalBossDragon::puke  /*0x0400092A*/
    IL_0006: callvirt ParticleSystem.EmissionModule UnityEngine.ParticleSystem::get_emission()  /*0x0A00020F*/
    IL_000b: stloc.0
    IL_000c: ldloca.s 0
    IL_000e: ldc.i4.1
    IL_000f: call void UnityEngine.ParticleSystem.EmissionModule::set_enabled(bool)  /*0x0A000210*/
    IL_0014: ldarg.0
    IL_0015: ldfld GameObject FinalBossDragon::pukingLogic  /*0x0400092B*/
    IL_001a: ldc.i4.1
    IL_001b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0020: ret

  .method FinalBossDragon::DisablePuke()  // token 0x06000740 rva 0x2487c attrs Public, HideBySig
    // code size 33 (0x21), max stack 2, init locals
    .locals ([0] ParticleSystem.EmissionModule)
    IL_0000: ldarg.0
    IL_0001: ldfld ParticleSystem FinalBossDragon::puke  /*0x0400092A*/
    IL_0006: callvirt ParticleSystem.EmissionModule UnityEngine.ParticleSystem::get_emission()  /*0x0A00020F*/
    IL_000b: stloc.0
    IL_000c: ldloca.s 0
    IL_000e: ldc.i4.0
    IL_000f: call void UnityEngine.ParticleSystem.EmissionModule::set_enabled(bool)  /*0x0A000210*/
    IL_0014: ldarg.0
    IL_0015: ldfld GameObject FinalBossDragon::pukingLogic  /*0x0400092B*/
    IL_001a: ldc.i4.0
    IL_001b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0020: ret

  .method FinalBossDragon::OnLoseHealthSegment(int,bool)  // token 0x06000741 rva 0x248ac attrs Private, HideBySig
    // code size 181 (0xb5), max stack 4, init locals
    IL_0000: ldarg.1
    IL_0001: ldc.i4.0
    IL_0002: blt.s IL_0012
    IL_0004: ldarg.1
    IL_0005: ldarg.0
    IL_0006: ldfld List<string> FinalBossDragon::animationTriggers  /*0x0400091F*/
    IL_000b: callvirt int System.Collections.Generic.List<string>::get_Count()  /*0x0A000047*/
    IL_0010: blt.s IL_0013
    IL_0012: ret
    IL_0013: ldarg.0
    IL_0014: ldfld Hp FinalBossDragon::hp  /*0x0400091D*/
    IL_0019: ldc.i4.1
    IL_001a: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_001f: ldarg.0
    IL_0020: ldc.r4 7f
    IL_0025: stfld float FinalBossDragon::invulnerableFor  /*0x0400092C*/
    IL_002a: ldarg.0
    IL_002b: ldfld Animator FinalBossDragon::animator  /*0x0400091E*/
    IL_0030: ldstr "AttackLeft"
    IL_0035: ldc.i4.0
    IL_0036: callvirt void UnityEngine.Animator::SetBool(string,bool)  /*0x0A0001BA*/
    IL_003b: ldarg.0
    IL_003c: ldfld Animator FinalBossDragon::animator  /*0x0400091E*/
    IL_0041: ldstr "AttackRight"
    IL_0046: ldc.i4.0
    IL_0047: callvirt void UnityEngine.Animator::SetBool(string,bool)  /*0x0A0001BA*/
    IL_004c: ldarg.0
    IL_004d: ldfld Animator FinalBossDragon::animator  /*0x0400091E*/
    IL_0052: ldstr "AttackMiddle"
    IL_0057: ldc.i4.0
    IL_0058: callvirt void UnityEngine.Animator::SetBool(string,bool)  /*0x0A0001BA*/
    IL_005d: ldarg.0
    IL_005e: ldfld Animator FinalBossDragon::animator  /*0x0400091E*/
    IL_0063: ldarg.0
    IL_0064: ldfld List<string> FinalBossDragon::animationTriggers  /*0x0400091F*/
    IL_0069: ldarg.1
    IL_006a: callvirt !0 System.Collections.Generic.List<string>::get_Item(int)  /*0x0A000362*/
    IL_006f: ldc.i4.1
    IL_0070: callvirt void UnityEngine.Animator::SetBool(string,bool)  /*0x0A0001BA*/
    IL_0075: ldarg.0
    IL_0076: ldfld AudioSource FinalBossDragon::screamAudioSource  /*0x04000927*/
    IL_007b: ldarg.0
    IL_007c: ldfld AudioClip[] FinalBossDragon::bossScreams  /*0x04000926*/
    IL_0081: ldarg.1
    IL_0082: ldelem.ref
    IL_0083: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_0088: ldarg.2
    IL_0089: brfalse.s IL_009b
    IL_008b: ldarg.0
    IL_008c: ldfld Animator FinalBossDragon::animator  /*0x0400091E*/
    IL_0091: ldstr "NewAttack"
    IL_0096: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_009b: ldarg.0
    IL_009c: ldarg.0
    IL_009d: ldarg.0
    IL_009e: ldfld List<Wave> FinalBossDragon::waves  /*0x04000922*/
    IL_00a3: ldarg.1
    IL_00a4: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_00a9: call IEnumerator FinalBossDragon::SpawnWave(Wave)  /*0x06000742*/
    IL_00ae: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_00b3: pop
    IL_00b4: ret

  .method FinalBossDragon::SpawnWave(Wave)  // token 0x06000742 rva 0x2496d attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void FinalBossDragon.<SpawnWave>d__21::.ctor(int)  /*0x06000745*/
    IL_0006: dup
    IL_0007: ldarg.1
    IL_0008: stfld Wave FinalBossDragon.<SpawnWave>d__21::_wave  /*0x0400092F*/
    IL_000d: ret

  .method FinalBossDragon::SpawnSecondBossStage()  // token 0x06000743 rva 0x2497c attrs Private, HideBySig
    // code size 232 (0xe8), max stack 4, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject FinalBossDragon::stage2SpawnerObj  /*0x04000923*/
    IL_0006: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_000b: ldc.i4.0
    IL_000c: ldc.i4.0
    IL_000d: ldarg.0
    IL_000e: ldfld Transform FinalBossDragon::spawnFromPosition  /*0x04000924*/
    IL_0013: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0018: call Vector3 EnemySpawner::GetValidSpawnPointForEnemy(bool,bool,UnityEngine.Vector3)  /*0x0600067D*/
    IL_001d: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0022: ldarg.0
    IL_0023: ldfld GameObject FinalBossDragon::stage2SpawnerObj  /*0x04000923*/
    IL_0028: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_002d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0032: ldarg.0
    IL_0033: ldfld Transform FinalBossDragon::castleCenter  /*0x04000928*/
    IL_0038: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0042: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0047: stloc.0
    IL_0048: ldloca.s 0
    IL_004a: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_004f: ldarg.0
    IL_0050: ldfld float FinalBossDragon::minDistanceStage2  /*0x04000929*/
    IL_0055: bge.un.s IL_00b5
    IL_0057: ldarg.0
    IL_0058: ldfld GameObject FinalBossDragon::stage2SpawnerObj  /*0x04000923*/
    IL_005d: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0062: ldarg.0
    IL_0063: ldfld Transform FinalBossDragon::castleCenter  /*0x04000928*/
    IL_0068: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_006d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0072: ldloca.s 0
    IL_0074: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_0079: ldarg.0
    IL_007a: ldfld float FinalBossDragon::minDistanceStage2  /*0x04000929*/
    IL_007f: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0084: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0089: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_008e: ldarg.0
    IL_008f: ldfld GameObject FinalBossDragon::stage2SpawnerObj  /*0x04000923*/
    IL_0094: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0099: ldc.i4.0
    IL_009a: ldc.i4.0
    IL_009b: ldarg.0
    IL_009c: ldfld GameObject FinalBossDragon::stage2SpawnerObj  /*0x04000923*/
    IL_00a1: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00a6: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00ab: call Vector3 EnemySpawner::GetValidSpawnPointForEnemy(bool,bool,UnityEngine.Vector3)  /*0x0600067D*/
    IL_00b0: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_00b5: ldarg.0
    IL_00b6: ldfld GameObject FinalBossDragon::stage2SpawnerObj  /*0x04000923*/
    IL_00bb: ldc.i4.1
    IL_00bc: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00c1: ldarg.0
    IL_00c2: ldfld Wave FinalBossDragon::immediateWaveOnDeath  /*0x04000925*/
    IL_00c7: ldc.i4.1
    IL_00c8: callvirt void Wave::Reset(bool)  /*0x0600069C*/
    IL_00cd: br.s IL_00da
    IL_00cf: ldarg.0
    IL_00d0: ldfld Wave FinalBossDragon::immediateWaveOnDeath  /*0x04000925*/
    IL_00d5: callvirt void Wave::Update()  /*0x0600069D*/
    IL_00da: ldarg.0
    IL_00db: ldfld Wave FinalBossDragon::immediateWaveOnDeath  /*0x04000925*/
    IL_00e0: callvirt bool Wave::HasFinished()  /*0x0600069E*/
    IL_00e5: brfalse.s IL_00cf
    IL_00e7: ret

  .method FinalBossDragon::.ctor()  // token 0x06000744 rva 0x24a70 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 40f
    IL_0006: stfld float FinalBossDragon::minDistanceStage2  /*0x04000929*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== FinalBossDragon/<SpawnWave>d__21  (token 0x02000164) =====
  .method FinalBossDragon.<SpawnWave>d__21::.ctor(int)  // token 0x06000745 rva 0x24a83 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int FinalBossDragon.<SpawnWave>d__21::<>1__state  /*0x0400092D*/
    IL_000d: ret

  .method FinalBossDragon.<SpawnWave>d__21::System.IDisposable.Dispose()  // token 0x06000746 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method FinalBossDragon.<SpawnWave>d__21::MoveNext()  // token 0x06000747 rva 0x24a94 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 86 (0x56), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int FinalBossDragon.<SpawnWave>d__21::<>1__state  /*0x0400092D*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: brfalse.s IL_0010
    IL_000a: ldloc.0
    IL_000b: ldc.i4.1
    IL_000c: beq.s IL_0040
    IL_000e: ldc.i4.0
    IL_000f: ret
    IL_0010: ldarg.0
    IL_0011: ldc.i4.m1
    IL_0012: stfld int FinalBossDragon.<SpawnWave>d__21::<>1__state  /*0x0400092D*/
    IL_0017: ldarg.0
    IL_0018: ldfld Wave FinalBossDragon.<SpawnWave>d__21::_wave  /*0x0400092F*/
    IL_001d: ldc.i4.1
    IL_001e: callvirt void Wave::Reset(bool)  /*0x0600069C*/
    IL_0023: br.s IL_0047
    IL_0025: ldarg.0
    IL_0026: ldfld Wave FinalBossDragon.<SpawnWave>d__21::_wave  /*0x0400092F*/
    IL_002b: callvirt void Wave::Update()  /*0x0600069D*/
    IL_0030: ldarg.0
    IL_0031: ldnull
    IL_0032: stfld object FinalBossDragon.<SpawnWave>d__21::<>2__current  /*0x0400092E*/
    IL_0037: ldarg.0
    IL_0038: ldc.i4.1
    IL_0039: stfld int FinalBossDragon.<SpawnWave>d__21::<>1__state  /*0x0400092D*/
    IL_003e: ldc.i4.1
    IL_003f: ret
    IL_0040: ldarg.0
    IL_0041: ldc.i4.m1
    IL_0042: stfld int FinalBossDragon.<SpawnWave>d__21::<>1__state  /*0x0400092D*/
    IL_0047: ldarg.0
    IL_0048: ldfld Wave FinalBossDragon.<SpawnWave>d__21::_wave  /*0x0400092F*/
    IL_004d: callvirt bool Wave::HasFinished()  /*0x0600069E*/
    IL_0052: brfalse.s IL_0025
    IL_0054: ldc.i4.0
    IL_0055: ret

  .method FinalBossDragon.<SpawnWave>d__21::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000748 rva 0x24af6 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object FinalBossDragon.<SpawnWave>d__21::<>2__current  /*0x0400092E*/
    IL_0006: ret

  .method FinalBossDragon.<SpawnWave>d__21::System.Collections.IEnumerator.Reset()  // token 0x06000749 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method FinalBossDragon.<SpawnWave>d__21::System.Collections.IEnumerator.get_Current()  // token 0x0600074A rva 0x24af6 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object FinalBossDragon.<SpawnWave>d__21::<>2__current  /*0x0400092E*/
    IL_0006: ret

