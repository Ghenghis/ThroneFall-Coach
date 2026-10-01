// ===== Moleman  (token 0x020001FA) =====
  .method Moleman::Start()  // token 0x06000A8C rva 0x3258e attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<PathfindMovementEnemy>  /*0x2B00000E*/
    IL_0007: stfld PathfindMovementEnemy Moleman::enemyMovement  /*0x04000D52*/
    IL_000c: ret

  .method Moleman::Update()  // token 0x06000A8D rva 0x3259c attrs Private, HideBySig
    // code size 81 (0x51), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool Moleman::teleportAnimRunning  /*0x04000D67*/
    IL_0006: brtrue.s IL_0050
    IL_0008: ldarg.0
    IL_0009: ldarg.0
    IL_000a: ldfld float Moleman::nextTeleportIn  /*0x04000D53*/
    IL_000f: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0014: sub
    IL_0015: stfld float Moleman::nextTeleportIn  /*0x04000D53*/
    IL_001a: ldarg.0
    IL_001b: ldfld float Moleman::nextTeleportIn  /*0x04000D53*/
    IL_0020: ldc.r4 0f
    IL_0025: bgt.un.s IL_0050
    IL_0027: ldarg.0
    IL_0028: ldarg.0
    IL_0029: ldfld float Moleman::teleportIntervalMin  /*0x04000D54*/
    IL_002e: ldarg.0
    IL_002f: ldfld float Moleman::teleportIntervalMax  /*0x04000D55*/
    IL_0034: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0039: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_003e: stfld float Moleman::nextTeleportIn  /*0x04000D53*/
    IL_0043: ldarg.0
    IL_0044: ldarg.0
    IL_0045: call IEnumerator Moleman::TeleportAnimation()  /*0x06000A8E*/
    IL_004a: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_004f: pop
    IL_0050: ret

  .method Moleman::TeleportAnimation()  // token 0x06000A8E rva 0x325f9 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void Moleman.<TeleportAnimation>d__24::.ctor(int)  /*0x06000A92*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld Moleman Moleman.<TeleportAnimation>d__24::<>4__this  /*0x04000D6A*/
    IL_000d: ret

  .method Moleman::DigAnimation(float)  // token 0x06000A8F rva 0x32608 attrs Private, HideBySig
    // code size 101 (0x65), max stack 4, init locals
    .locals ([0] float)
    IL_0000: ldarg.0
    IL_0001: ldfld PathfindMovementEnemy Moleman::enemyMovement  /*0x04000D52*/
    IL_0006: callvirt void PathfindMovement::ClearCurrentPath()  /*0x06000B06*/
    IL_000b: ldarg.0
    IL_000c: ldfld Transform Moleman::aliveParent  /*0x04000D5A*/
    IL_0011: ldc.r4 0f
    IL_0016: ldarg.1
    IL_0017: ldc.r4 1000f
    IL_001c: mul
    IL_001d: ldc.r4 0f
    IL_0022: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_0027: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_002c: ldc.r4 1f
    IL_0031: ldarg.1
    IL_0032: sub
    IL_0033: ldarg.1
    IL_0034: ldc.r4 0.3f
    IL_0039: sub
    IL_003a: mul
    IL_003b: ldc.r4 3.333f
    IL_0040: mul
    IL_0041: stloc.0
    IL_0042: ldarg.0
    IL_0043: ldfld Transform Moleman::aliveParent  /*0x04000D5A*/
    IL_0048: ldc.r4 0f
    IL_004d: ldloc.0
    IL_004e: ldarg.0
    IL_004f: ldfld float Moleman::digDepth  /*0x04000D5D*/
    IL_0054: mul
    IL_0055: ldc.r4 0f
    IL_005a: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_005f: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_0064: ret

  .method Moleman::InstantiateHere(UnityEngine.GameObject)  // token 0x06000A90 rva 0x3267c attrs Private, HideBySig
    // code size 63 (0x3f), max stack 3, init locals
    .locals ([0] FireArcherBurn)
    IL_0000: ldarg.1
    IL_0001: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.1
    IL_000a: ldarg.0
    IL_000b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0010: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0015: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_001a: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_001f: callvirt !!0 UnityEngine.GameObject::GetComponent()<FireArcherBurn>  /*0x2B0000A2*/
    IL_0024: stloc.0
    IL_0025: ldloc.0
    IL_0026: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002b: brfalse.s IL_003e
    IL_002d: ldloc.0
    IL_002e: ldarg.0
    IL_002f: call !!0 UnityEngine.Component::GetComponent()<AutoAttack>  /*0x2B0000A3*/
    IL_0034: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_0039: callvirt void WeaponDamageDealer::set_DamageMultiplyer(float)  /*0x060013D3*/
    IL_003e: ret

  .method Moleman::.ctor()  // token 0x06000A91 rva 0x326c8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 138 (0x8a), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 3f
    IL_0006: stfld float Moleman::nextTeleportIn  /*0x04000D53*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 6f
    IL_0011: stfld float Moleman::teleportIntervalMin  /*0x04000D54*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 6f
    IL_001c: stfld float Moleman::teleportIntervalMax  /*0x04000D55*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 0.5f
    IL_0027: stfld float Moleman::teleportTowardsTargetAmount  /*0x04000D56*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 0.5f
    IL_0032: stfld float Moleman::targetDistanceMin  /*0x04000D57*/
    IL_0037: ldarg.0
    IL_0038: ldc.r4 20f
    IL_003d: stfld float Moleman::targetDistanceMax  /*0x04000D58*/
    IL_0042: ldarg.0
    IL_0043: ldc.r4 20f
    IL_0048: stfld float Moleman::maxTunnelingDistance  /*0x04000D59*/
    IL_004d: ldarg.0
    IL_004e: ldc.r4 2.5f
    IL_0053: stfld float Moleman::digDepth  /*0x04000D5D*/
    IL_0058: ldarg.0
    IL_0059: ldc.r4 1f
    IL_005e: ldc.r4 1f
    IL_0063: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0068: stfld Vector2 Moleman::digAudioPitchRange  /*0x04000D63*/
    IL_006d: ldarg.0
    IL_006e: ldc.r4 2f
    IL_0073: stfld float Moleman::animationSpeed  /*0x04000D64*/
    IL_0078: ldarg.0
    IL_0079: ldc.r4 2f
    IL_007e: stfld float Moleman::digTrevelingSpeed  /*0x04000D65*/
    IL_0083: ldarg.0
    IL_0084: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0089: ret

// ===== Moleman/<TeleportAnimation>d__24  (token 0x020001FB) =====
  .method Moleman.<TeleportAnimation>d__24::.ctor(int)  // token 0x06000A92 rva 0x3275e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int Moleman.<TeleportAnimation>d__24::<>1__state  /*0x04000D68*/
    IL_000d: ret

  .method Moleman.<TeleportAnimation>d__24::System.IDisposable.Dispose()  // token 0x06000A93 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Moleman.<TeleportAnimation>d__24::MoveNext()  // token 0x06000A94 rva 0x32770 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 893 (0x37d), max stack 5, init locals
    .locals ([0] int, [1] Moleman, [2] float, [3] float, [4] Vector3, [5] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld int Moleman.<TeleportAnimation>d__24::<>1__state  /*0x04000D68*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld Moleman Moleman.<TeleportAnimation>d__24::<>4__this  /*0x04000D6A*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0026, IL_008d, IL_0229, IL_0310)
    IL_0024: ldc.i4.0
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldc.i4.m1
    IL_0028: stfld int Moleman.<TeleportAnimation>d__24::<>1__state  /*0x04000D68*/
    IL_002d: ldloc.1
    IL_002e: ldc.i4.1
    IL_002f: stfld bool Moleman::teleportAnimRunning  /*0x04000D67*/
    IL_0034: ldloc.1
    IL_0035: ldfld AutoAttack Moleman::autoAttack  /*0x04000D5C*/
    IL_003a: ldc.i4.0
    IL_003b: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0040: ldloc.1
    IL_0041: ldloc.1
    IL_0042: ldfld GameObject Moleman::spawnOnDigDown  /*0x04000D5E*/
    IL_0047: call void Moleman::InstantiateHere(UnityEngine.GameObject)  /*0x06000A90*/
    IL_004c: ldloc.1
    IL_004d: ldfld ParticleSystem Moleman::digDownFX  /*0x04000D60*/
    IL_0052: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0057: brfalse.s IL_0064
    IL_0059: ldloc.1
    IL_005a: ldfld ParticleSystem Moleman::digDownFX  /*0x04000D60*/
    IL_005f: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_0064: ldarg.0
    IL_0065: ldc.r4 1f
    IL_006a: stfld float Moleman.<TeleportAnimation>d__24::<t>5__5  /*0x04000D6E*/
    IL_006f: br.s IL_00ad
    IL_0071: ldloc.1
    IL_0072: ldarg.0
    IL_0073: ldfld float Moleman.<TeleportAnimation>d__24::<t>5__5  /*0x04000D6E*/
    IL_0078: call void Moleman::DigAnimation(float)  /*0x06000A8F*/
    IL_007d: ldarg.0
    IL_007e: ldnull
    IL_007f: stfld object Moleman.<TeleportAnimation>d__24::<>2__current  /*0x04000D69*/
    IL_0084: ldarg.0
    IL_0085: ldc.i4.1
    IL_0086: stfld int Moleman.<TeleportAnimation>d__24::<>1__state  /*0x04000D68*/
    IL_008b: ldc.i4.1
    IL_008c: ret
    IL_008d: ldarg.0
    IL_008e: ldc.i4.m1
    IL_008f: stfld int Moleman.<TeleportAnimation>d__24::<>1__state  /*0x04000D68*/
    IL_0094: ldarg.0
    IL_0095: ldarg.0
    IL_0096: ldfld float Moleman.<TeleportAnimation>d__24::<t>5__5  /*0x04000D6E*/
    IL_009b: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00a0: ldloc.1
    IL_00a1: ldfld float Moleman::animationSpeed  /*0x04000D64*/
    IL_00a6: mul
    IL_00a7: sub
    IL_00a8: stfld float Moleman.<TeleportAnimation>d__24::<t>5__5  /*0x04000D6E*/
    IL_00ad: ldarg.0
    IL_00ae: ldfld float Moleman.<TeleportAnimation>d__24::<t>5__5  /*0x04000D6E*/
    IL_00b3: ldc.r4 0f
    IL_00b8: bgt.s IL_0071
    IL_00ba: ldarg.0
    IL_00bb: ldloc.1
    IL_00bc: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00c1: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00c6: ldloc.1
    IL_00c7: ldfld PathfindMovementEnemy Moleman::enemyMovement  /*0x04000D52*/
    IL_00cc: callvirt Vector3 PathfindMovementEnemy::get_SeekToTargetPosSnappedtoNavmesh()  /*0x06000B0D*/
    IL_00d1: ldloc.1
    IL_00d2: ldfld float Moleman::teleportTowardsTargetAmount  /*0x04000D56*/
    IL_00d7: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_00dc: stfld Vector3 Moleman.<TeleportAnimation>d__24::<targetPos>5__2  /*0x04000D6B*/
    IL_00e1: ldc.r4 0f
    IL_00e6: ldc.r4 6.2831855f
    IL_00eb: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_00f0: stloc.2
    IL_00f1: ldloc.1
    IL_00f2: ldfld float Moleman::targetDistanceMin  /*0x04000D57*/
    IL_00f7: ldloc.1
    IL_00f8: ldfld float Moleman::targetDistanceMax  /*0x04000D58*/
    IL_00fd: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0102: stloc.3
    IL_0103: ldloca.s 4
    IL_0105: ldloc.2
    IL_0106: call float UnityEngine.Mathf::Cos(float)  /*0x0A0001BF*/
    IL_010b: ldloc.3
    IL_010c: mul
    IL_010d: ldc.r4 0f
    IL_0112: ldloc.2
    IL_0113: call float UnityEngine.Mathf::Sin(float)  /*0x0A0000AB*/
    IL_0118: ldloc.3
    IL_0119: mul
    IL_011a: call void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_011f: ldarg.0
    IL_0120: ldarg.0
    IL_0121: ldfld Vector3 Moleman.<TeleportAnimation>d__24::<targetPos>5__2  /*0x04000D6B*/
    IL_0126: ldloc.s 4
    IL_0128: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_012d: stfld Vector3 Moleman.<TeleportAnimation>d__24::<targetPos>5__2  /*0x04000D6B*/
    IL_0132: ldarg.0
    IL_0133: ldloc.1
    IL_0134: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0139: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_013e: ldarg.0
    IL_013f: ldfld Vector3 Moleman.<TeleportAnimation>d__24::<targetPos>5__2  /*0x04000D6B*/
    IL_0144: ldloc.1
    IL_0145: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_014a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_014f: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0154: stloc.s 5
    IL_0156: ldloca.s 5
    IL_0158: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_015d: ldarg.0
    IL_015e: ldfld Vector3 Moleman.<TeleportAnimation>d__24::<targetPos>5__2  /*0x04000D6B*/
    IL_0163: ldloc.1
    IL_0164: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0169: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_016e: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0173: stloc.s 5
    IL_0175: ldloca.s 5
    IL_0177: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_017c: ldloc.1
    IL_017d: ldfld float Moleman::maxTunnelingDistance  /*0x04000D59*/
    IL_0182: call float UnityEngine.Mathf::Min(float,float)  /*0x0A000109*/
    IL_0187: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_018c: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0191: stfld Vector3 Moleman.<TeleportAnimation>d__24::<targetPos>5__2  /*0x04000D6B*/
    IL_0196: ldloc.1
    IL_0197: ldfld GameObject Moleman::meshParent  /*0x04000D5B*/
    IL_019c: ldc.i4.0
    IL_019d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01a2: ldarg.0
    IL_01a3: ldloc.1
    IL_01a4: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01a9: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01ae: stfld Vector3 Moleman.<TeleportAnimation>d__24::<startPos>5__3  /*0x04000D6C*/
    IL_01b3: ldarg.0
    IL_01b4: ldloc.1
    IL_01b5: ldfld PathfindMovementEnemy Moleman::enemyMovement  /*0x04000D52*/
    IL_01ba: ldarg.0
    IL_01bb: ldfld Vector3 Moleman.<TeleportAnimation>d__24::<targetPos>5__2  /*0x04000D6B*/
    IL_01c0: callvirt Vector3 PathfindMovementEnemy::GetNearestGroundPosition(UnityEngine.Vector3)  /*0x06000B1B*/
    IL_01c5: stfld Vector3 Moleman.<TeleportAnimation>d__24::<targetPos>5__2  /*0x04000D6B*/
    IL_01ca: ldarg.0
    IL_01cb: ldarg.0
    IL_01cc: ldfld Vector3 Moleman.<TeleportAnimation>d__24::<startPos>5__3  /*0x04000D6C*/
    IL_01d1: ldarg.0
    IL_01d2: ldfld Vector3 Moleman.<TeleportAnimation>d__24::<targetPos>5__2  /*0x04000D6B*/
    IL_01d7: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_01dc: stloc.s 5
    IL_01de: ldloca.s 5
    IL_01e0: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_01e5: stfld float Moleman.<TeleportAnimation>d__24::<distance>5__4  /*0x04000D6D*/
    IL_01ea: ldarg.0
    IL_01eb: ldc.r4 0f
    IL_01f0: stfld float Moleman.<TeleportAnimation>d__24::<t>5__5  /*0x04000D6E*/
    IL_01f5: br.s IL_0250
    IL_01f7: ldloc.1
    IL_01f8: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01fd: ldarg.0
    IL_01fe: ldfld Vector3 Moleman.<TeleportAnimation>d__24::<startPos>5__3  /*0x04000D6C*/
    IL_0203: ldarg.0
    IL_0204: ldfld Vector3 Moleman.<TeleportAnimation>d__24::<targetPos>5__2  /*0x04000D6B*/
    IL_0209: ldarg.0
    IL_020a: ldfld float Moleman.<TeleportAnimation>d__24::<t>5__5  /*0x04000D6E*/
    IL_020f: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_0214: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0219: ldarg.0
    IL_021a: ldnull
    IL_021b: stfld object Moleman.<TeleportAnimation>d__24::<>2__current  /*0x04000D69*/
    IL_0220: ldarg.0
    IL_0221: ldc.i4.2
    IL_0222: stfld int Moleman.<TeleportAnimation>d__24::<>1__state  /*0x04000D68*/
    IL_0227: ldc.i4.1
    IL_0228: ret
    IL_0229: ldarg.0
    IL_022a: ldc.i4.m1
    IL_022b: stfld int Moleman.<TeleportAnimation>d__24::<>1__state  /*0x04000D68*/
    IL_0230: ldarg.0
    IL_0231: ldarg.0
    IL_0232: ldfld float Moleman.<TeleportAnimation>d__24::<t>5__5  /*0x04000D6E*/
    IL_0237: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_023c: ldloc.1
    IL_023d: ldfld float Moleman::digTrevelingSpeed  /*0x04000D65*/
    IL_0242: mul
    IL_0243: ldarg.0
    IL_0244: ldfld float Moleman.<TeleportAnimation>d__24::<distance>5__4  /*0x04000D6D*/
    IL_0249: div
    IL_024a: add
    IL_024b: stfld float Moleman.<TeleportAnimation>d__24::<t>5__5  /*0x04000D6E*/
    IL_0250: ldarg.0
    IL_0251: ldfld float Moleman.<TeleportAnimation>d__24::<t>5__5  /*0x04000D6E*/
    IL_0256: ldc.r4 1f
    IL_025b: blt.s IL_01f7
    IL_025d: ldloc.1
    IL_025e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0263: ldarg.0
    IL_0264: ldfld Vector3 Moleman.<TeleportAnimation>d__24::<targetPos>5__2  /*0x04000D6B*/
    IL_0269: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_026e: ldloc.1
    IL_026f: ldfld GameObject Moleman::meshParent  /*0x04000D5B*/
    IL_0274: ldc.i4.1
    IL_0275: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_027a: ldloc.1
    IL_027b: ldloc.1
    IL_027c: ldfld GameObject Moleman::spawnOnDigUp  /*0x04000D5F*/
    IL_0281: call void Moleman::InstantiateHere(UnityEngine.GameObject)  /*0x06000A90*/
    IL_0286: ldloc.1
    IL_0287: ldfld ParticleSystem Moleman::digUpFX  /*0x04000D61*/
    IL_028c: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0291: brfalse.s IL_029e
    IL_0293: ldloc.1
    IL_0294: ldfld ParticleSystem Moleman::digUpFX  /*0x04000D61*/
    IL_0299: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_029e: ldloc.1
    IL_029f: ldfld AudioSource Moleman::digAudioSource  /*0x04000D62*/
    IL_02a4: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_02a9: brfalse.s IL_02e7
    IL_02ab: ldloc.1
    IL_02ac: ldfld AudioSource Moleman::digAudioSource  /*0x04000D62*/
    IL_02b1: ldloc.1
    IL_02b2: ldflda Vector2 Moleman::digAudioPitchRange  /*0x04000D63*/
    IL_02b7: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_02bc: ldloc.1
    IL_02bd: ldflda Vector2 Moleman::digAudioPitchRange  /*0x04000D63*/
    IL_02c2: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_02c7: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_02cc: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_02d1: ldloc.1
    IL_02d2: ldfld AudioSource Moleman::digAudioSource  /*0x04000D62*/
    IL_02d7: ldloc.1
    IL_02d8: ldfld AudioSource Moleman::digAudioSource  /*0x04000D62*/
    IL_02dd: callvirt AudioClip UnityEngine.AudioSource::get_clip()  /*0x0A0004C2*/
    IL_02e2: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_02e7: ldarg.0
    IL_02e8: ldc.r4 0f
    IL_02ed: stfld float Moleman.<TeleportAnimation>d__24::<t>5__5  /*0x04000D6E*/
    IL_02f2: br.s IL_0330
    IL_02f4: ldloc.1
    IL_02f5: ldarg.0
    IL_02f6: ldfld float Moleman.<TeleportAnimation>d__24::<t>5__5  /*0x04000D6E*/
    IL_02fb: call void Moleman::DigAnimation(float)  /*0x06000A8F*/
    IL_0300: ldarg.0
    IL_0301: ldnull
    IL_0302: stfld object Moleman.<TeleportAnimation>d__24::<>2__current  /*0x04000D69*/
    IL_0307: ldarg.0
    IL_0308: ldc.i4.3
    IL_0309: stfld int Moleman.<TeleportAnimation>d__24::<>1__state  /*0x04000D68*/
    IL_030e: ldc.i4.1
    IL_030f: ret
    IL_0310: ldarg.0
    IL_0311: ldc.i4.m1
    IL_0312: stfld int Moleman.<TeleportAnimation>d__24::<>1__state  /*0x04000D68*/
    IL_0317: ldarg.0
    IL_0318: ldarg.0
    IL_0319: ldfld float Moleman.<TeleportAnimation>d__24::<t>5__5  /*0x04000D6E*/
    IL_031e: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0323: ldloc.1
    IL_0324: ldfld float Moleman::animationSpeed  /*0x04000D64*/
    IL_0329: mul
    IL_032a: add
    IL_032b: stfld float Moleman.<TeleportAnimation>d__24::<t>5__5  /*0x04000D6E*/
    IL_0330: ldarg.0
    IL_0331: ldfld float Moleman.<TeleportAnimation>d__24::<t>5__5  /*0x04000D6E*/
    IL_0336: ldc.r4 1f
    IL_033b: blt.s IL_02f4
    IL_033d: ldloc.1
    IL_033e: ldfld PathfindMovementEnemy Moleman::enemyMovement  /*0x04000D52*/
    IL_0343: callvirt void PathfindMovementEnemy::OriginalPathRequest()  /*0x06000B18*/
    IL_0348: ldloc.1
    IL_0349: ldfld Transform Moleman::aliveParent  /*0x04000D5A*/
    IL_034e: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0353: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_0358: ldloc.1
    IL_0359: ldfld Transform Moleman::aliveParent  /*0x04000D5A*/
    IL_035e: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0363: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_0368: ldloc.1
    IL_0369: ldc.i4.0
    IL_036a: stfld bool Moleman::teleportAnimRunning  /*0x04000D67*/
    IL_036f: ldloc.1
    IL_0370: ldfld AutoAttack Moleman::autoAttack  /*0x04000D5C*/
    IL_0375: ldc.i4.1
    IL_0376: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_037b: ldc.i4.0
    IL_037c: ret

  .method Moleman.<TeleportAnimation>d__24::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000A95 rva 0x32af9 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object Moleman.<TeleportAnimation>d__24::<>2__current  /*0x04000D69*/
    IL_0006: ret

  .method Moleman.<TeleportAnimation>d__24::System.Collections.IEnumerator.Reset()  // token 0x06000A96 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method Moleman.<TeleportAnimation>d__24::System.Collections.IEnumerator.get_Current()  // token 0x06000A97 rva 0x32af9 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object Moleman.<TeleportAnimation>d__24::<>2__current  /*0x04000D69*/
    IL_0006: ret

