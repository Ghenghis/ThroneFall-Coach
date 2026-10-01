// ===== StabMA  (token 0x020001EE) =====
  .method StabMA::get_TargetsStabeed()  // token 0x06000A34 rva 0x303c8 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int StabMA::targetsStabbed  /*0x04000CFC*/
    IL_0006: ret

  .method StabMA::Start()  // token 0x06000A35 rva 0x303d0 attrs Public, Virtual, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ManualAttack::Start()  /*0x06000A00*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: ldfld AudioSet ManualAttack::audioSet  /*0x04000CCD*/
    IL_000d: callvirt AudioSet.ClipArray AudioSet::get_PlayerBowStab()  /*0x060001BD*/
    IL_0012: stfld AudioSet.ClipArray StabMA::caSuccessfulHit  /*0x04000CFD*/
    IL_0017: ldarg.0
    IL_0018: ldarg.0
    IL_0019: ldfld AudioSet ManualAttack::audioSet  /*0x04000CCD*/
    IL_001e: callvirt AudioSet.ClipArray AudioSet::get_PlayerBowStabMiss()  /*0x060001BE*/
    IL_0023: stfld AudioSet.ClipArray StabMA::caFailedHit  /*0x04000CFE*/
    IL_0028: ret

  .method StabMA::Attack()  // token 0x06000A36 rva 0x303fc attrs Public, Virtual, HideBySig
    // code size 253 (0xfd), max stack 7, init locals
    .locals ([0] TaggedObject, [1] Hp, [2] float)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: callvirt TaggedObject ManualAttack::FindAttackTarget(bool)  /*0x06000A08*/
    IL_0007: stloc.0
    IL_0008: ldnull
    IL_0009: stloc.1
    IL_000a: ldloc.0
    IL_000b: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0010: brfalse.s IL_006b
    IL_0012: ldloc.0
    IL_0013: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0018: stloc.1
    IL_0019: ldarg.0
    IL_001a: ldarg.0
    IL_001b: ldfld float StabMA::maximumCooldownTime  /*0x04000CFA*/
    IL_0020: ldarg.0
    IL_0021: ldfld float StabMA::minimumCooldownPercentage  /*0x04000CFB*/
    IL_0026: ldloc.1
    IL_0027: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_002c: ldc.r4 1f
    IL_0031: ldarg.0
    IL_0032: ldfld float StabMA::minimumCooldownPercentage  /*0x04000CFB*/
    IL_0037: sub
    IL_0038: mul
    IL_0039: add
    IL_003a: mul
    IL_003b: stfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_0040: ldarg.0
    IL_0041: ldarg.0
    IL_0042: ldfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_0047: stfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_004c: ldarg.0
    IL_004d: ldfld bool ManualAttack::timedActivationPerfectly  /*0x04000CD3*/
    IL_0052: brfalse.s IL_006b
    IL_0054: ldarg.0
    IL_0055: ldarg.0
    IL_0056: ldfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_005b: ldsfld UpgradeAssassinsTraining UpgradeAssassinsTraining::instance  /*0x04000F00*/
    IL_0060: ldfld float UpgradeAssassinsTraining::cooldownMultiForPerfectlyTimedAttacks  /*0x04000F04*/
    IL_0065: mul
    IL_0066: stfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_006b: ldc.r4 0f
    IL_0070: stloc.2
    IL_0071: ldloc.1
    IL_0072: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0077: brfalse.s IL_0080
    IL_0079: ldloc.1
    IL_007a: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_007f: stloc.2
    IL_0080: ldarg.0
    IL_0081: ldfld Weapon ManualAttack::weapon  /*0x04000CB9*/
    IL_0086: ldarg.0
    IL_0087: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_008c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0091: ldarg.0
    IL_0092: ldfld float ManualAttack::spawnAttackHeight  /*0x04000CB7*/
    IL_0097: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_009c: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_00a1: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00a6: ldloc.1
    IL_00a7: ldarg.0
    IL_00a8: ldfld Transform ManualAttack::transformForAttackDirection  /*0x04000CBB*/
    IL_00ad: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_00b2: ldarg.0
    IL_00b3: ldfld TaggedObject ManualAttack::myTaggedObj  /*0x04000CC8*/
    IL_00b8: ldarg.0
    IL_00b9: call float ManualAttack::get_AttackDamageMultiplyer()  /*0x060009FC*/
    IL_00be: ldc.r4 1f
    IL_00c3: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_00c8: ldloc.1
    IL_00c9: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00ce: brfalse.s IL_00e7
    IL_00d0: ldloc.2
    IL_00d1: ldloc.1
    IL_00d2: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_00d7: ble.un.s IL_00e0
    IL_00d9: ldarg.0
    IL_00da: call void StabMA::StabSuccessful()  /*0x06000A37*/
    IL_00df: ret
    IL_00e0: ldarg.0
    IL_00e1: call void StabMA::StabMissed()  /*0x06000A38*/
    IL_00e6: ret
    IL_00e7: ldloc.2
    IL_00e8: ldc.r4 0f
    IL_00ed: ble.un.s IL_00f6
    IL_00ef: ldarg.0
    IL_00f0: call void StabMA::StabSuccessful()  /*0x06000A37*/
    IL_00f5: ret
    IL_00f6: ldarg.0
    IL_00f7: call void StabMA::StabMissed()  /*0x06000A38*/
    IL_00fc: ret

  .method StabMA::StabSuccessful()  // token 0x06000A37 rva 0x30508 attrs Private, HideBySig
    // code size 75 (0x4b), max stack 8, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallAudioManager ManualAttack::audioManager  /*0x04000CD1*/
    IL_0006: ldarg.0
    IL_0007: ldfld AudioSet.ClipArray StabMA::caSuccessfulHit  /*0x04000CFD*/
    IL_000c: ldc.r4 1f
    IL_0011: ldc.r4 0.9f
    IL_0016: ldc.r4 1.1f
    IL_001b: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0020: ldarg.0
    IL_0021: ldfld AudioSet ManualAttack::audioSet  /*0x04000CCD*/
    IL_0026: ldfld AudioMixerGroup AudioSet::mixGroupFX  /*0x040001D9*/
    IL_002b: ldc.i4.5
    IL_002c: ldc.i4.0
    IL_002d: ldloca.s 0
    IL_002f: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_0035: ldloc.0
    IL_0036: callvirt ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_003b: pop
    IL_003c: ldarg.0
    IL_003d: ldarg.0
    IL_003e: ldfld int StabMA::targetsStabbed  /*0x04000CFC*/
    IL_0043: ldc.i4.1
    IL_0044: add
    IL_0045: stfld int StabMA::targetsStabbed  /*0x04000CFC*/
    IL_004a: ret

  .method StabMA::StabMissed()  // token 0x06000A38 rva 0x30560 attrs Private, HideBySig
    // code size 61 (0x3d), max stack 8, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallAudioManager ManualAttack::audioManager  /*0x04000CD1*/
    IL_0006: ldarg.0
    IL_0007: ldfld AudioSet.ClipArray StabMA::caFailedHit  /*0x04000CFE*/
    IL_000c: ldc.r4 1f
    IL_0011: ldc.r4 0.9f
    IL_0016: ldc.r4 1.1f
    IL_001b: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0020: ldarg.0
    IL_0021: ldfld AudioSet ManualAttack::audioSet  /*0x04000CCD*/
    IL_0026: ldfld AudioMixerGroup AudioSet::mixGroupFX  /*0x040001D9*/
    IL_002b: ldc.i4.5
    IL_002c: ldc.i4.0
    IL_002d: ldloca.s 0
    IL_002f: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_0035: ldloc.0
    IL_0036: callvirt ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_003b: pop
    IL_003c: ret

  .method StabMA::FindAttackTarget(bool)  // token 0x06000A39 rva 0x305ac attrs Public, Virtual, HideBySig
    // code size 134 (0x86), max stack 3, init locals
    .locals ([0] int, [1] TaggedObject)
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_0045
    IL_0003: ldarg.0
    IL_0004: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_0009: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000e: brfalse.s IL_0045
    IL_0010: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0015: ldarg.0
    IL_0016: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_001b: ldarg.0
    IL_001c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0021: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0026: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_002b: ldarg.0
    IL_002c: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_0031: ldc.i4.0
    IL_0032: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0037: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_003c: bgt.un.s IL_0045
    IL_003e: ldarg.0
    IL_003f: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_0044: ret
    IL_0045: ldc.i4.0
    IL_0046: stloc.0
    IL_0047: br.s IL_0076
    IL_0049: ldarg.0
    IL_004a: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_004f: ldloc.0
    IL_0050: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0055: ldarg.0
    IL_0056: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0060: ldc.i4.0
    IL_0061: callvirt TaggedObject TargetPriority::FindLowestHealthObjectInRange(UnityEngine.Vector3,bool)  /*0x06000E7A*/
    IL_0066: stloc.1
    IL_0067: ldloc.1
    IL_0068: ldnull
    IL_0069: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_006e: brfalse.s IL_0072
    IL_0070: ldloc.1
    IL_0071: ret
    IL_0072: ldloc.0
    IL_0073: ldc.i4.1
    IL_0074: add
    IL_0075: stloc.0
    IL_0076: ldloc.0
    IL_0077: ldarg.0
    IL_0078: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_007d: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_0082: blt.s IL_0049
    IL_0084: ldnull
    IL_0085: ret

  .method StabMA::.ctor()  // token 0x06000A3A rva 0x3063e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 15f
    IL_0006: stfld float StabMA::maximumCooldownTime  /*0x04000CFA*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.2f
    IL_0011: stfld float StabMA::minimumCooldownPercentage  /*0x04000CFB*/
    IL_0016: ldarg.0
    IL_0017: call void ManualAttack::.ctor()  /*0x06000A0A*/
    IL_001c: ret

