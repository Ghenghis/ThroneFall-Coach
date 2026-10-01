// ===== PlayerCharacterAudio  (token 0x02000056) =====
  .method PlayerCharacterAudio::Start()  // token 0x060001F6 rva 0x8308 attrs Private, HideBySig
    // code size 167 (0xa7), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld AudioSource PlayerCharacterAudio::stepAudioSource  /*0x0400024F*/
    IL_0007: callvirt float UnityEngine.AudioSource::get_pitch()  /*0x0A0000CA*/
    IL_000c: stfld float PlayerCharacterAudio::initialPitch  /*0x04000257*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: ldfld AudioSource PlayerCharacterAudio::stepAudioSource  /*0x0400024F*/
    IL_0018: callvirt float UnityEngine.AudioSource::get_volume()  /*0x0A0000C4*/
    IL_001d: stfld float PlayerCharacterAudio::initialVolume  /*0x04000256*/
    IL_0022: ldarg.0
    IL_0023: ldfld AudioSource PlayerCharacterAudio::stepAudioSource  /*0x0400024F*/
    IL_0028: ldc.r4 0f
    IL_002d: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_0032: ldarg.0
    IL_0033: ldfld AudioSource PlayerCharacterAudio::stepAudioSource  /*0x0400024F*/
    IL_0038: ldc.i4.s 110
    IL_003a: callvirt void UnityEngine.AudioSource::set_priority(int)  /*0x0A0000CB*/
    IL_003f: ldarg.0
    IL_0040: ldarg.0
    IL_0041: ldfld float PlayerCharacterAudio::initialVolume  /*0x04000256*/
    IL_0046: ldarg.0
    IL_0047: ldfld float PlayerCharacterAudio::fadeTime  /*0x04000253*/
    IL_004c: div
    IL_004d: stfld float PlayerCharacterAudio::fadeSpeed  /*0x04000258*/
    IL_0052: ldarg.0
    IL_0053: ldfld Hp PlayerCharacterAudio::playerHp  /*0x0400024D*/
    IL_0058: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_005d: ldarg.0
    IL_005e: ldftn void PlayerCharacterAudio::OnDeath()  /*0x060001F9*/
    IL_0064: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0069: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_006e: ldarg.0
    IL_006f: ldfld Hp PlayerCharacterAudio::playerHp  /*0x0400024D*/
    IL_0074: ldfld UnityEvent<bool> Hp::OnReceiveDamage  /*0x04000A3D*/
    IL_0079: ldarg.0
    IL_007a: ldftn void PlayerCharacterAudio::OnDmg(bool)  /*0x060001FA*/
    IL_0080: newobj void UnityEngine.Events.UnityAction<bool>::.ctor(object,IntPtr)  /*0x0A0000CC*/
    IL_0085: callvirt void UnityEngine.Events.UnityEvent<bool>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A0000CD*/
    IL_008a: ldarg.0
    IL_008b: ldfld AutoRevive PlayerCharacterAudio::playerReviveComponent  /*0x0400024E*/
    IL_0090: ldfld UnityEvent AutoRevive::onReviveTrigger  /*0x04000332*/
    IL_0095: ldarg.0
    IL_0096: ldftn void PlayerCharacterAudio::OnRevive()  /*0x060001FB*/
    IL_009c: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00a1: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00a6: ret

  .method PlayerCharacterAudio::OnWeaponEquip(ManualAttack)  // token 0x060001F7 rva 0x83bb attrs Public, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: callvirt !!0 UnityEngine.Component::GetComponent()<PlayerWeaponAudio>  /*0x2B000016*/
    IL_0007: stfld PlayerWeaponAudio PlayerCharacterAudio::weaponAudio  /*0x04000255*/
    IL_000c: ldarg.0
    IL_000d: ldfld PlayerWeaponAudio PlayerCharacterAudio::weaponAudio  /*0x04000255*/
    IL_0012: ldfld ManualAttack PlayerWeaponAudio::autoWeapon  /*0x04000259*/
    IL_0017: ldfld UnityEvent ManualAttack::onAttack  /*0x04000CCC*/
    IL_001c: ldarg.0
    IL_001d: ldftn void PlayerCharacterAudio::PlayAttackSound()  /*0x060001F8*/
    IL_0023: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0028: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_002d: ret

  .method PlayerCharacterAudio::PlayAttackSound()  // token 0x060001F8 rva 0x83ec attrs Private, HideBySig
    // code size 101 (0x65), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld AudioSource PlayerCharacterAudio::fxAudioSource  /*0x04000250*/
    IL_0006: ldc.i4.5
    IL_0007: callvirt void UnityEngine.AudioSource::set_priority(int)  /*0x0A0000CB*/
    IL_000c: ldarg.0
    IL_000d: ldfld AudioSource PlayerCharacterAudio::fxAudioSource  /*0x04000250*/
    IL_0012: ldc.r4 1f
    IL_0017: ldarg.0
    IL_0018: ldfld PlayerWeaponAudio PlayerCharacterAudio::weaponAudio  /*0x04000255*/
    IL_001d: ldfld float PlayerWeaponAudio::pitchRange  /*0x0400025C*/
    IL_0022: sub
    IL_0023: ldc.r4 1f
    IL_0028: ldarg.0
    IL_0029: ldfld PlayerWeaponAudio PlayerCharacterAudio::weaponAudio  /*0x04000255*/
    IL_002e: ldfld float PlayerWeaponAudio::pitchRange  /*0x0400025C*/
    IL_0033: add
    IL_0034: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0039: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_003e: ldarg.0
    IL_003f: ldfld AudioSource PlayerCharacterAudio::fxAudioSource  /*0x04000250*/
    IL_0044: ldarg.0
    IL_0045: ldfld PlayerWeaponAudio PlayerCharacterAudio::weaponAudio  /*0x04000255*/
    IL_004a: callvirt AudioSet.ClipArray PlayerWeaponAudio::get_AttackSound()  /*0x060001FE*/
    IL_004f: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_0054: ldarg.0
    IL_0055: ldfld PlayerWeaponAudio PlayerCharacterAudio::weaponAudio  /*0x04000255*/
    IL_005a: ldfld float PlayerWeaponAudio::volume  /*0x0400025D*/
    IL_005f: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_0064: ret

  .method PlayerCharacterAudio::OnDeath()  // token 0x060001F9 rva 0x8460 attrs Private, HideBySig
    // code size 65 (0x41), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld AudioSource PlayerCharacterAudio::dmgAudioSource  /*0x04000251*/
    IL_0006: ldc.i4.5
    IL_0007: callvirt void UnityEngine.AudioSource::set_priority(int)  /*0x0A0000CB*/
    IL_000c: ldarg.0
    IL_000d: ldfld AudioSource PlayerCharacterAudio::dmgAudioSource  /*0x04000251*/
    IL_0012: ldc.r4 1f
    IL_0017: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_001c: ldarg.0
    IL_001d: ldfld AudioSource PlayerCharacterAudio::dmgAudioSource  /*0x04000251*/
    IL_0022: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0027: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_002c: callvirt AudioSet.ClipArray AudioSet::get_PlayerDeath()  /*0x060001D0*/
    IL_0031: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_0036: ldc.r4 1f
    IL_003b: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_0040: ret

  .method PlayerCharacterAudio::OnDmg(bool)  // token 0x060001FA rva 0x84b0 attrs Private, HideBySig
    // code size 75 (0x4b), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld AudioSource PlayerCharacterAudio::dmgAudioSource  /*0x04000251*/
    IL_0006: ldc.i4.5
    IL_0007: callvirt void UnityEngine.AudioSource::set_priority(int)  /*0x0A0000CB*/
    IL_000c: ldarg.0
    IL_000d: ldfld AudioSource PlayerCharacterAudio::dmgAudioSource  /*0x04000251*/
    IL_0012: ldc.r4 0.9f
    IL_0017: ldc.r4 1.1f
    IL_001c: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0021: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_0026: ldarg.0
    IL_0027: ldfld AudioSource PlayerCharacterAudio::dmgAudioSource  /*0x04000251*/
    IL_002c: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0031: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0036: callvirt AudioSet.ClipArray AudioSet::get_PlayerDamage()  /*0x060001D1*/
    IL_003b: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_0040: ldc.r4 0.65f
    IL_0045: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_004a: ret

  .method PlayerCharacterAudio::OnRevive()  // token 0x060001FB rva 0x8507 attrs Private, HideBySig
    // code size 60 (0x3c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AudioSource PlayerCharacterAudio::fxAudioSource  /*0x04000250*/
    IL_0006: ldc.i4.5
    IL_0007: callvirt void UnityEngine.AudioSource::set_priority(int)  /*0x0A0000CB*/
    IL_000c: ldarg.0
    IL_000d: ldfld AudioSource PlayerCharacterAudio::fxAudioSource  /*0x04000250*/
    IL_0012: ldc.r4 1f
    IL_0017: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_001c: ldarg.0
    IL_001d: ldfld AudioSource PlayerCharacterAudio::fxAudioSource  /*0x04000250*/
    IL_0022: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0027: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_002c: callvirt AudioClip AudioSet::get_PlayerRevive()  /*0x060001D2*/
    IL_0031: ldc.r4 0.8f
    IL_0036: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_003b: ret

  .method PlayerCharacterAudio::Update()  // token 0x060001FC rva 0x8544 attrs Private, HideBySig
    // code size 180 (0xb4), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld PlayerMovement PlayerCharacterAudio::targetController  /*0x04000252*/
    IL_0006: callvirt bool PlayerMovement::get_Sprinting()  /*0x06000C1E*/
    IL_000b: brfalse.s IL_0020
    IL_000d: ldarg.0
    IL_000e: ldfld AudioSource PlayerCharacterAudio::stepAudioSource  /*0x0400024F*/
    IL_0013: ldarg.0
    IL_0014: ldfld float PlayerCharacterAudio::sprintPitch  /*0x04000254*/
    IL_0019: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_001e: br.s IL_0031
    IL_0020: ldarg.0
    IL_0021: ldfld AudioSource PlayerCharacterAudio::stepAudioSource  /*0x0400024F*/
    IL_0026: ldarg.0
    IL_0027: ldfld float PlayerCharacterAudio::initialPitch  /*0x04000257*/
    IL_002c: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_0031: ldarg.0
    IL_0032: ldfld PlayerMovement PlayerCharacterAudio::targetController  /*0x04000252*/
    IL_0037: callvirt bool PlayerMovement::get_Moving()  /*0x06000C1D*/
    IL_003c: brfalse.s IL_0087
    IL_003e: ldarg.0
    IL_003f: ldfld Hp PlayerCharacterAudio::playerHp  /*0x0400024D*/
    IL_0044: ldnull
    IL_0045: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_004a: brtrue.s IL_0059
    IL_004c: ldarg.0
    IL_004d: ldfld Hp PlayerCharacterAudio::playerHp  /*0x0400024D*/
    IL_0052: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_0057: brtrue.s IL_0087
    IL_0059: ldarg.0
    IL_005a: ldfld AudioSource PlayerCharacterAudio::stepAudioSource  /*0x0400024F*/
    IL_005f: ldarg.0
    IL_0060: ldfld AudioSource PlayerCharacterAudio::stepAudioSource  /*0x0400024F*/
    IL_0065: callvirt float UnityEngine.AudioSource::get_volume()  /*0x0A0000C4*/
    IL_006a: ldarg.0
    IL_006b: ldfld float PlayerCharacterAudio::initialVolume  /*0x04000256*/
    IL_0070: ldarg.0
    IL_0071: ldfld float PlayerCharacterAudio::fadeSpeed  /*0x04000258*/
    IL_0076: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_007b: mul
    IL_007c: call float UnityEngine.Mathf::MoveTowards(float,float,float)  /*0x0A0000CF*/
    IL_0081: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_0086: ret
    IL_0087: ldarg.0
    IL_0088: ldfld AudioSource PlayerCharacterAudio::stepAudioSource  /*0x0400024F*/
    IL_008d: ldarg.0
    IL_008e: ldfld AudioSource PlayerCharacterAudio::stepAudioSource  /*0x0400024F*/
    IL_0093: callvirt float UnityEngine.AudioSource::get_volume()  /*0x0A0000C4*/
    IL_0098: ldc.r4 0f
    IL_009d: ldarg.0
    IL_009e: ldfld float PlayerCharacterAudio::fadeSpeed  /*0x04000258*/
    IL_00a3: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_00a8: mul
    IL_00a9: call float UnityEngine.Mathf::MoveTowards(float,float,float)  /*0x0A0000CF*/
    IL_00ae: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_00b3: ret

  .method PlayerCharacterAudio::.ctor()  // token 0x060001FD rva 0x8604 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.3f
    IL_0006: stfld float PlayerCharacterAudio::fadeTime  /*0x04000253*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1.1f
    IL_0011: stfld float PlayerCharacterAudio::sprintPitch  /*0x04000254*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

