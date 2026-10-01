// ===== EnergyCore  (token 0x0200013B) =====
  .method EnergyCore::Start()  // token 0x060006AF rva 0x1d890 attrs Family, Virtual, HideBySig
    // code size 233 (0xe9), max stack 5, init locals
    .locals ([0] RaycastHit)
    IL_0000: ldarg.0
    IL_0001: ldfld Transform Coin::mesh  /*0x040003F9*/
    IL_0006: ldc.i4.0
    IL_0007: ldc.i4 360
    IL_000c: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_0011: conv.r4
    IL_0012: ldc.i4.0
    IL_0013: ldc.i4 360
    IL_0018: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_001d: conv.r4
    IL_001e: ldc.i4.0
    IL_001f: ldc.i4 360
    IL_0024: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_0029: conv.r4
    IL_002a: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_002f: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0034: ldarg.0
    IL_0035: ldarg.0
    IL_0036: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0040: stfld Vector3 Coin::initialPosition  /*0x04000409*/
    IL_0045: ldarg.0
    IL_0046: ldfld bool Coin::groundOnSpawn  /*0x04000400*/
    IL_004b: brfalse.s IL_00a8
    IL_004d: ldarg.0
    IL_004e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0053: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0058: call Vector3 UnityEngine.Vector3::get_down()  /*0x0A00016E*/
    IL_005d: newobj void UnityEngine.Ray::.ctor(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A00016F*/
    IL_0062: ldloca.s 0
    IL_0064: ldc.r4 Infinityf
    IL_0069: ldarg.0
    IL_006a: ldfld LayerMask Coin::groundLayer  /*0x04000401*/
    IL_006f: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_0074: call bool UnityEngine.Physics::Raycast(UnityEngine.Ray,ref UnityEngine.RaycastHit,float,int)  /*0x0A000170*/
    IL_0079: brfalse.s IL_00a1
    IL_007b: ldarg.0
    IL_007c: ldloca.s 0
    IL_007e: call Vector3 UnityEngine.RaycastHit::get_point()  /*0x0A000171*/
    IL_0083: ldarg.0
    IL_0084: ldfld Vector3 Coin::groundingOffset  /*0x04000402*/
    IL_0089: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_008e: stfld Vector3 Coin::groundingPos  /*0x0400040C*/
    IL_0093: ldarg.0
    IL_0094: ldarg.0
    IL_0095: ldfld Vector3 Coin::groundingPos  /*0x0400040C*/
    IL_009a: stfld Vector3 Coin::initialPosition  /*0x04000409*/
    IL_009f: br.s IL_00a8
    IL_00a1: ldarg.0
    IL_00a2: ldc.i4.1
    IL_00a3: stfld bool Coin::grounded  /*0x0400040B*/
    IL_00a8: ldarg.0
    IL_00a9: ldfld bool Coin::registerInTagManager  /*0x04000403*/
    IL_00ae: brfalse.s IL_00cc
    IL_00b0: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_00b5: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00ba: brfalse.s IL_00cc
    IL_00bc: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_00c1: ldfld List<EnergyCore> TagManager::freeEnergyCores  /*0x04001095*/
    IL_00c6: ldarg.0
    IL_00c7: callvirt void System.Collections.Generic.List<EnergyCore>::Add(!0)  /*0x0A0002B9*/
    IL_00cc: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_00d1: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00d6: brfalse.s IL_00e8
    IL_00d8: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_00dd: ldfld List<EnergyCore> TagManager::energyCores  /*0x04001096*/
    IL_00e2: ldarg.0
    IL_00e3: callvirt void System.Collections.Generic.List<EnergyCore>::Add(!0)  /*0x0A0002B9*/
    IL_00e8: ret

  .method EnergyCore::Update()  // token 0x060006B0 rva 0x1d988 attrs Family, Virtual, HideBySig
    // code size 543 (0x21f), max stack 7, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld Transform Coin::mesh  /*0x040003F9*/
    IL_0006: ldc.r4 45f
    IL_000b: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0010: mul
    IL_0011: ldc.r4 120f
    IL_0016: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_001b: mul
    IL_001c: ldc.r4 0f
    IL_0021: ldc.i4.0
    IL_0022: callvirt void UnityEngine.Transform::Rotate(float,float,float,UnityEngine.Space)  /*0x0A0000B1*/
    IL_0027: ldarg.0
    IL_0028: ldfld bool Coin::groundOnSpawn  /*0x04000400*/
    IL_002d: brfalse IL_00b2
    IL_0032: ldarg.0
    IL_0033: ldfld bool Coin::grounded  /*0x0400040B*/
    IL_0038: brtrue.s IL_00b2
    IL_003a: ldarg.0
    IL_003b: ldarg.0
    IL_003c: ldfld float Coin::groundingVelocity  /*0x0400040D*/
    IL_0041: ldc.r4 9.81f
    IL_0046: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_004b: mul
    IL_004c: add
    IL_004d: stfld float Coin::groundingVelocity  /*0x0400040D*/
    IL_0052: ldarg.0
    IL_0053: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0058: ldarg.0
    IL_0059: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0063: ldarg.0
    IL_0064: ldfld Vector3 Coin::groundingPos  /*0x0400040C*/
    IL_0069: ldarg.0
    IL_006a: ldfld float Coin::groundingVelocity  /*0x0400040D*/
    IL_006f: call Vector3 UnityEngine.Vector3::MoveTowards(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000173*/
    IL_0074: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0079: ldarg.0
    IL_007a: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_007f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0084: ldarg.0
    IL_0085: ldfld Vector3 Coin::groundingPos  /*0x0400040C*/
    IL_008a: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_008f: ldc.r4 0.05f
    IL_0094: bge.un IL_021e
    IL_0099: ldarg.0
    IL_009a: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_009f: ldarg.0
    IL_00a0: ldfld Vector3 Coin::groundingPos  /*0x0400040C*/
    IL_00a5: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_00aa: ldarg.0
    IL_00ab: ldc.i4.1
    IL_00ac: stfld bool Coin::grounded  /*0x0400040B*/
    IL_00b1: ret
    IL_00b2: ldarg.0
    IL_00b3: ldfld float Coin::spawnAnimationClock  /*0x04000408*/
    IL_00b8: ldarg.0
    IL_00b9: ldfld float Coin::spawnAnimationDuration  /*0x040003FD*/
    IL_00be: bge.un.s IL_0116
    IL_00c0: ldarg.0
    IL_00c1: ldarg.0
    IL_00c2: ldfld float Coin::spawnAnimationClock  /*0x04000408*/
    IL_00c7: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00cc: add
    IL_00cd: stfld float Coin::spawnAnimationClock  /*0x04000408*/
    IL_00d2: ldarg.0
    IL_00d3: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00d8: ldarg.0
    IL_00d9: ldfld Vector3 Coin::initialPosition  /*0x04000409*/
    IL_00de: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_00e3: ldarg.0
    IL_00e4: ldfld float Coin::spawnAnimationScale  /*0x040003FE*/
    IL_00e9: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00ee: ldarg.0
    IL_00ef: ldfld AnimationCurve Coin::spawnAnimationCurve  /*0x040003FF*/
    IL_00f4: ldarg.0
    IL_00f5: ldfld float Coin::spawnAnimationClock  /*0x04000408*/
    IL_00fa: ldarg.0
    IL_00fb: ldfld float Coin::spawnAnimationDuration  /*0x040003FD*/
    IL_0100: div
    IL_0101: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0106: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_010b: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0110: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0115: ret
    IL_0116: ldarg.0
    IL_0117: ldfld PlayerInteraction Coin::target  /*0x04000405*/
    IL_011c: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0121: brfalse IL_021e
    IL_0126: ldarg.0
    IL_0127: ldarg.0
    IL_0128: ldfld float Coin::accelerationClock  /*0x0400040A*/
    IL_012d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0132: add
    IL_0133: stfld float Coin::accelerationClock  /*0x0400040A*/
    IL_0138: ldarg.0
    IL_0139: ldfld PlayerInteraction Coin::target  /*0x04000405*/
    IL_013e: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0143: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0148: ldarg.0
    IL_0149: ldfld Vector3 Coin::targetOffset  /*0x04000406*/
    IL_014e: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0153: stloc.0
    IL_0154: ldarg.0
    IL_0155: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_015a: ldarg.0
    IL_015b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0160: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0165: ldloc.0
    IL_0166: ldarg.0
    IL_0167: ldfld float Coin::maxSpeed  /*0x040003FA*/
    IL_016c: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0171: mul
    IL_0172: ldarg.0
    IL_0173: ldfld AnimationCurve Coin::accelerationCurve  /*0x040003FC*/
    IL_0178: ldarg.0
    IL_0179: ldfld float Coin::accelerationClock  /*0x0400040A*/
    IL_017e: ldarg.0
    IL_017f: ldfld float Coin::accelerationTime  /*0x040003FB*/
    IL_0184: div
    IL_0185: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_018a: mul
    IL_018b: call Vector3 UnityEngine.Vector3::MoveTowards(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000173*/
    IL_0190: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0195: ldarg.0
    IL_0196: ldfld bool Coin::particlesSpawned  /*0x0400040E*/
    IL_019b: brtrue.s IL_01e7
    IL_019d: ldloc.0
    IL_019e: ldarg.0
    IL_019f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01a4: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01a9: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_01ae: ldc.r4 3f
    IL_01b3: bge.un.s IL_01e7
    IL_01b5: ldarg.0
    IL_01b6: ldfld GameObject Coin::onPickUpParticles  /*0x04000404*/
    IL_01bb: ldnull
    IL_01bc: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_01c1: brfalse.s IL_01e0
    IL_01c3: ldarg.0
    IL_01c4: ldfld GameObject Coin::onPickUpParticles  /*0x04000404*/
    IL_01c9: ldloc.0
    IL_01ca: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_01cf: ldarg.0
    IL_01d0: ldfld PlayerInteraction Coin::target  /*0x04000405*/
    IL_01d5: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01da: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B00000C*/
    IL_01df: pop
    IL_01e0: ldarg.0
    IL_01e1: ldc.i4.1
    IL_01e2: stfld bool Coin::particlesSpawned  /*0x0400040E*/
    IL_01e7: ldloc.0
    IL_01e8: ldarg.0
    IL_01e9: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01ee: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01f3: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_01f8: ldarg.0
    IL_01f9: ldfld float Coin::pickupRange  /*0x04000407*/
    IL_01fe: bge.un.s IL_021e
    IL_0200: ldarg.0
    IL_0201: ldfld PlayerInteraction Coin::target  /*0x04000405*/
    IL_0206: ldc.i4.1
    IL_0207: callvirt void PlayerInteraction::AddEnergyCores(int)  /*0x06000C10*/
    IL_020c: ldc.i4.s 13
    IL_020e: call void ThronefallAudioManager::Oneshot(ThronefallAudioManager.AudioOneShot)  /*0x06000219*/
    IL_0213: ldarg.0
    IL_0214: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0219: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_021e: ret

  .method EnergyCore::OnDestroy()  // token 0x060006B1 rva 0x1dbb4 attrs Family, Virtual, HideBySig
    // code size 67 (0x43), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool Coin::registerInTagManager  /*0x04000403*/
    IL_0006: brfalse.s IL_0025
    IL_0008: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_000d: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0012: brfalse.s IL_0025
    IL_0014: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0019: ldfld List<EnergyCore> TagManager::freeEnergyCores  /*0x04001095*/
    IL_001e: ldarg.0
    IL_001f: callvirt bool System.Collections.Generic.List<EnergyCore>::Remove(!0)  /*0x0A0002BA*/
    IL_0024: pop
    IL_0025: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_002a: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002f: brfalse.s IL_0042
    IL_0031: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0036: ldfld List<EnergyCore> TagManager::energyCores  /*0x04001096*/
    IL_003b: ldarg.0
    IL_003c: callvirt bool System.Collections.Generic.List<EnergyCore>::Remove(!0)  /*0x0A0002BA*/
    IL_0041: pop
    IL_0042: ret

  .method EnergyCore::.ctor()  // token 0x060006B2 rva 0x1dc03 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void Coin::.ctor()  /*0x06000342*/
    IL_0006: ret

