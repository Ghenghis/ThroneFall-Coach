// ===== Spawn  (token 0x02000138) =====
  .method Spawn::get_SpawnedUnits()  // token 0x060006A2 rva 0x1ca7c attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int Spawn::spawnedUnits  /*0x040007ED*/
    IL_0006: ret

  .method Spawn::get_Finished()  // token 0x060006A3 rva 0x1ca84 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool Spawn::finished  /*0x040007EE*/
    IL_0006: ret

  .method Spawn::.ctor()  // token 0x060006A4 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method Spawn::.ctor(UnityEngine.GameObject,UnityEngine.Transform,int,float,int,float,bool)  // token 0x060006A5 rva 0x1ca8c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 60 (0x3c), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_000d: ldarg.0
    IL_000e: ldarg.2
    IL_000f: stfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_0014: ldarg.0
    IL_0015: ldarg.3
    IL_0016: stfld int Spawn::count  /*0x040007E7*/
    IL_001b: ldarg.0
    IL_001c: ldarg.s 4
    IL_001e: stfld float Spawn::interval  /*0x040007E8*/
    IL_0023: ldarg.0
    IL_0024: ldarg.s 5
    IL_0026: stfld int Spawn::goldCoins  /*0x040007EA*/
    IL_002b: ldarg.0
    IL_002c: ldarg.s 6
    IL_002e: stfld float Spawn::delay  /*0x040007E4*/
    IL_0033: ldarg.0
    IL_0034: ldarg.s 7
    IL_0036: stfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_003b: ret

  .method Spawn::Reset(bool)  // token 0x060006A6 rva 0x1cacc attrs Public, HideBySig
    // code size 391 (0x187), max stack 6, init locals
    .locals ([0] int, [1] int, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0006: ldfld Equippable PerkManager::tigerGodPerk  /*0x04000BFB*/
    IL_000b: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0010: stfld bool Spawn::tauntTheTiger  /*0x040007EF*/
    IL_0015: ldarg.0
    IL_0016: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_001b: ldfld Equippable PerkManager::turtleGodPerk  /*0x04000BFD*/
    IL_0020: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0025: stfld bool Spawn::tauntTheTurtle  /*0x040007F0*/
    IL_002a: ldarg.0
    IL_002b: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0030: ldfld Equippable PerkManager::falconGodPerk  /*0x04000C00*/
    IL_0035: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_003a: stfld bool Spawn::tauntTheFalcon  /*0x040007F1*/
    IL_003f: ldarg.0
    IL_0040: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0045: ldfld Equippable PerkManager::antiAirTelescope  /*0x04000C28*/
    IL_004a: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_004f: stfld bool Spawn::antiAirTelescope  /*0x040007F2*/
    IL_0054: ldarg.0
    IL_0055: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_005a: ldfld Equippable PerkManager::prayToWarGods  /*0x04000C32*/
    IL_005f: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0064: stfld bool Spawn::prayToWarGods  /*0x040007F3*/
    IL_0069: ldarg.0
    IL_006a: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_006f: callvirt bool PerkManager::get_GodOfChaosEquipped()  /*0x0600099A*/
    IL_0074: stfld bool Spawn::godOfChaos  /*0x040007F4*/
    IL_0079: ldarg.0
    IL_007a: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_007f: callvirt bool PerkManager::get_GrowthGodEquipped()  /*0x06000998*/
    IL_0084: stfld bool Spawn::tauntTheGrowth  /*0x040007F5*/
    IL_0089: ldarg.0
    IL_008a: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_008f: callvirt bool PerkManager::get_RangeGodEquipped()  /*0x06000999*/
    IL_0094: stfld bool Spawn::tauntTheRange  /*0x040007F6*/
    IL_0099: ldarg.0
    IL_009a: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_009f: callvirt bool PerkManager::get_GodOfAfterlifeEquipped()  /*0x060009A0*/
    IL_00a4: stfld bool Spawn::godOfAfterlife  /*0x040007F7*/
    IL_00a9: ldarg.0
    IL_00aa: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00af: ldfld float PerkManager::growthGodMaxDamageMulti  /*0x04000C43*/
    IL_00b4: ldc.r4 1f
    IL_00b9: ldc.i4.1
    IL_00ba: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_00bf: callvirt int EnemySpawner::get_WaveCount()  /*0x0600066D*/
    IL_00c4: ldc.i4.1
    IL_00c5: sub
    IL_00c6: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_00cb: conv.r4
    IL_00cc: div
    IL_00cd: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_00d2: stfld float Spawn::addDmgGrowthDiffPerWave  /*0x040007F8*/
    IL_00d7: ldarg.0
    IL_00d8: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00dd: ldfld float PerkManager::growthGodMaxHpMulti  /*0x04000C44*/
    IL_00e2: ldc.r4 1f
    IL_00e7: ldc.i4.1
    IL_00e8: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_00ed: callvirt int EnemySpawner::get_WaveCount()  /*0x0600066D*/
    IL_00f2: ldc.i4.1
    IL_00f3: sub
    IL_00f4: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_00f9: conv.r4
    IL_00fa: div
    IL_00fb: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0100: stfld float Spawn::addHpGrowthDiffPerWave  /*0x040007F9*/
    IL_0105: ldarg.0
    IL_0106: ldarg.0
    IL_0107: ldfld float Spawn::delay  /*0x040007E4*/
    IL_010c: stfld float Spawn::waitBeforeNextSpawn  /*0x040007EC*/
    IL_0111: ldarg.0
    IL_0112: ldc.i4.0
    IL_0113: stfld int Spawn::spawnedUnits  /*0x040007ED*/
    IL_0118: ldarg.0
    IL_0119: ldc.i4.0
    IL_011a: stfld bool Spawn::finished  /*0x040007EE*/
    IL_011f: ldarg.0
    IL_0120: ldarg.0
    IL_0121: ldfld int Spawn::count  /*0x040007E7*/
    IL_0126: newarr System.Int32  /*0x01000026*/
    IL_012b: stfld int[] Spawn::goldCoinsPerEnemy  /*0x040007EB*/
    IL_0130: ldarg.0
    IL_0131: ldfld int Spawn::goldCoins  /*0x040007EA*/
    IL_0136: stloc.0
    IL_0137: ldc.i4.0
    IL_0138: stloc.1
    IL_0139: br.s IL_0155
    IL_013b: ldarg.0
    IL_013c: ldfld int[] Spawn::goldCoinsPerEnemy  /*0x040007EB*/
    IL_0141: ldc.i4.0
    IL_0142: ldarg.0
    IL_0143: ldfld int[] Spawn::goldCoinsPerEnemy  /*0x040007EB*/
    IL_0148: ldlen
    IL_0149: conv.i4
    IL_014a: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_014f: ldc.i4.0
    IL_0150: stelem.i4
    IL_0151: ldloc.1
    IL_0152: ldc.i4.1
    IL_0153: add
    IL_0154: stloc.1
    IL_0155: ldloc.1
    IL_0156: ldloc.0
    IL_0157: blt.s IL_013b
    IL_0159: ldarg.1
    IL_015a: brfalse.s IL_0186
    IL_015c: ldc.i4.0
    IL_015d: stloc.2
    IL_015e: br.s IL_0182
    IL_0160: ldarg.0
    IL_0161: ldfld int[] Spawn::goldCoinsPerEnemy  /*0x040007EB*/
    IL_0166: ldc.i4.0
    IL_0167: ldarg.0
    IL_0168: ldfld int[] Spawn::goldCoinsPerEnemy  /*0x040007EB*/
    IL_016d: ldlen
    IL_016e: conv.i4
    IL_016f: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_0174: ldelema System.Int32  /*0x01000026*/
    IL_0179: dup
    IL_017a: ldind.i4
    IL_017b: ldc.i4.1
    IL_017c: add
    IL_017d: stind.i4
    IL_017e: ldloc.2
    IL_017f: ldc.i4.1
    IL_0180: add
    IL_0181: stloc.2
    IL_0182: ldloc.2
    IL_0183: ldloc.0
    IL_0184: blt.s IL_0160
    IL_0186: ret

  .method Spawn::Update(float)  // token 0x060006A7 rva 0x1cc60 attrs Public, HideBySig
    // code size 1514 (0x5ea), max stack 7, init locals
    .locals ([0] TaggedObject, [1] bool, [2] NNConstraint, [3] Vector3, [4] bool, [5] GameObject, [6] TaggedObject, [7] Hp, [8] float, [9] float, [10] float, [11] float, [12] float, [13] float, [14] bool, [15] Vector3, [16] Scene, [17] EnemySpawnManager, [18] MeshRenderer[], [19] int, [20] MeshRenderer, [21] AutoAttack[], [22] AutoAttack, [23] List.Enumerator<TargetPriority>, [24] PathfindMovementEnemy[])
    IL_0000: ldarg.0
    IL_0001: ldfld bool Spawn::finished  /*0x040007EE*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: ldfld float Spawn::waitBeforeNextSpawn  /*0x040007EC*/
    IL_0010: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0015: sub
    IL_0016: stfld float Spawn::waitBeforeNextSpawn  /*0x040007EC*/
    IL_001b: ldarg.0
    IL_001c: ldfld float Spawn::waitBeforeNextSpawn  /*0x040007EC*/
    IL_0021: ldc.r4 0f
    IL_0026: ble.un.s IL_0029
    IL_0028: ret
    IL_0029: ldarg.0
    IL_002a: ldarg.0
    IL_002b: ldfld float Spawn::interval  /*0x040007E8*/
    IL_0030: stfld float Spawn::waitBeforeNextSpawn  /*0x040007EC*/
    IL_0035: ldarg.0
    IL_0036: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_003b: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<TaggedObject>  /*0x2B000061*/
    IL_0040: stloc.0
    IL_0041: ldloc.0
    IL_0042: ldnull
    IL_0043: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0048: brfalse.s IL_005e
    IL_004a: ldarg.0
    IL_004b: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_0050: ldc.i4.1
    IL_0051: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0056: ldarg.0
    IL_0057: ldc.i4.1
    IL_0058: stfld bool Spawn::finished  /*0x040007EE*/
    IL_005d: ret
    IL_005e: ldloc.0
    IL_005f: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0064: ldc.i4.6
    IL_0065: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_006a: stloc.1
    IL_006b: ldloc.0
    IL_006c: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0071: ldc.i4.s 41
    IL_0073: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0078: brtrue.s IL_0095
    IL_007a: ldloc.1
    IL_007b: brtrue.s IL_0089
    IL_007d: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0082: ldfld NNConstraint EnemySpawner::groundConstraint  /*0x040007DD*/
    IL_0087: br.s IL_009f
    IL_0089: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_008e: ldfld NNConstraint EnemySpawner::flyingConstraint  /*0x040007DC*/
    IL_0093: br.s IL_009f
    IL_0095: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_009a: ldfld NNConstraint EnemySpawner::groundConstraintLarge  /*0x040007DE*/
    IL_009f: stloc.2
    IL_00a0: ldarg.0
    IL_00a1: ldloc.1
    IL_00a2: ldloc.2
    IL_00a3: call Vector3 Spawn::GetRandomPointOnSpawnLine(bool,Pathfinding.NNConstraint)  /*0x060006A8*/
    IL_00a8: stloc.3
    IL_00a9: ldarg.0
    IL_00aa: ldfld bool Spawn::godOfChaos  /*0x040007F4*/
    IL_00af: ldloc.0
    IL_00b0: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_00b5: ldc.i4.s 42
    IL_00b7: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_00bc: ldc.i4.0
    IL_00bd: ceq
    IL_00bf: and
    IL_00c0: stloc.s 4
    IL_00c2: ldloc.s 4
    IL_00c4: brfalse.s IL_0103
    IL_00c6: ldloc.1
    IL_00c7: brtrue.s IL_00d0
    IL_00c9: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_00ce: br.s IL_00df
    IL_00d0: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_00d5: ldc.r4 5f
    IL_00da: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00df: stloc.s 15
    IL_00e1: ldloc.3
    IL_00e2: ldsfld Vector3 CastleCenter::CastleCenterPosition  /*0x040003F6*/
    IL_00e7: ldloc.s 15
    IL_00e9: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00ee: ldarg.0
    IL_00ef: ldfld int Spawn::spawnedUnits  /*0x040007ED*/
    IL_00f4: ldc.i4.5
    IL_00f5: rem
    IL_00f6: conv.r4
    IL_00f7: ldc.r4 5f
    IL_00fc: div
    IL_00fd: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_0102: stloc.3
    IL_0103: ldarg.0
    IL_0104: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_0109: callvirt Scene UnityEngine.GameObject::get_scene()  /*0x0A00011A*/
    IL_010e: stloc.s 16
    IL_0110: ldloca.s 16
    IL_0112: call bool UnityEngine.SceneManagement.Scene::get_isLoaded()  /*0x0A0002A2*/
    IL_0117: brfalse.s IL_0138
    IL_0119: ldarg.0
    IL_011a: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_011f: stloc.s 5
    IL_0121: ldarg.0
    IL_0122: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_0127: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<TaggedObject>  /*0x2B000061*/
    IL_012c: stloc.s 6
    IL_012e: ldloc.s 5
    IL_0130: ldc.i4.1
    IL_0131: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0136: br.s IL_01a9
    IL_0138: ldarg.0
    IL_0139: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_013e: ldloc.3
    IL_013f: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0144: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_0149: stloc.s 5
    IL_014b: ldloc.s 5
    IL_014d: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_0152: stloc.s 6
    IL_0154: ldsfld EnemySpawnManager EnemySpawnManager::instance  /*0x04000B9E*/
    IL_0159: stloc.s 17
    IL_015b: ldloc.s 17
    IL_015d: ldfld Weapon EnemySpawnManager::weaponOnSpawn  /*0x04000BA1*/
    IL_0162: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0167: brfalse.s IL_01a9
    IL_0169: ldloc.s 17
    IL_016b: ldfld Weapon EnemySpawnManager::weaponOnSpawn  /*0x04000BA1*/
    IL_0170: ldloc.s 5
    IL_0172: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0177: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_017c: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0181: ldloc.s 17
    IL_0183: ldfld float EnemySpawnManager::weaponAttackHeight  /*0x04000BA2*/
    IL_0188: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_018d: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0192: ldnull
    IL_0193: call Vector3 UnityEngine.Vector3::get_forward()  /*0x0A000278*/
    IL_0198: ldloc.s 6
    IL_019a: ldc.r4 1f
    IL_019f: ldc.r4 1f
    IL_01a4: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_01a9: ldarg.0
    IL_01aa: ldfld int[] Spawn::goldCoinsPerEnemy  /*0x040007EB*/
    IL_01af: ldlen
    IL_01b0: conv.i4
    IL_01b1: ldarg.0
    IL_01b2: ldfld int Spawn::spawnedUnits  /*0x040007ED*/
    IL_01b7: ble.s IL_01d2
    IL_01b9: ldloc.s 5
    IL_01bb: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<Hp>  /*0x2B00005D*/
    IL_01c0: ldarg.0
    IL_01c1: ldfld int[] Spawn::goldCoinsPerEnemy  /*0x040007EB*/
    IL_01c6: ldarg.0
    IL_01c7: ldfld int Spawn::spawnedUnits  /*0x040007ED*/
    IL_01cc: ldelem.i4
    IL_01cd: stfld int Hp::coinCount  /*0x04000A4B*/
    IL_01d2: ldloc.s 5
    IL_01d4: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<Hp>  /*0x2B00005D*/
    IL_01d9: stloc.s 7
    IL_01db: ldarg.1
    IL_01dc: stloc.s 8
    IL_01de: ldc.r4 1f
    IL_01e3: ldarg.1
    IL_01e4: ldc.r4 0.5f
    IL_01e9: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_01ee: stloc.s 9
    IL_01f0: ldc.r4 1f
    IL_01f5: stloc.s 10
    IL_01f7: ldc.r4 1f
    IL_01fc: stloc.s 11
    IL_01fe: ldc.r4 1f
    IL_0203: stloc.s 12
    IL_0205: ldc.r4 1f
    IL_020a: stloc.s 13
    IL_020c: ldarg.0
    IL_020d: ldfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_0212: brfalse.s IL_0277
    IL_0214: ldloc.s 8
    IL_0216: ldc.r4 4f
    IL_021b: mul
    IL_021c: stloc.s 8
    IL_021e: ldloc.s 9
    IL_0220: ldc.r4 3f
    IL_0225: mul
    IL_0226: stloc.s 9
    IL_0228: ldloc.s 5
    IL_022a: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren()<UnityEngine.MeshRenderer>  /*0x2B000062*/
    IL_022f: stloc.s 18
    IL_0231: ldc.i4.0
    IL_0232: stloc.s 19
    IL_0234: br.s IL_0267
    IL_0236: ldloc.s 18
    IL_0238: ldloc.s 19
    IL_023a: ldelem.ref
    IL_023b: stloc.s 20
    IL_023d: ldloc.s 20
    IL_023f: callvirt Material UnityEngine.Renderer::get_sharedMaterial()  /*0x0A0002B3*/
    IL_0244: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0249: ldstr "Enemy"
    IL_024e: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0253: brfalse.s IL_0261
    IL_0255: ldloc.s 20
    IL_0257: call Material ColorAndLightManager::get_EliteEnemyMaterial()  /*0x06000355*/
    IL_025c: callvirt void UnityEngine.Renderer::set_sharedMaterial(UnityEngine.Material)  /*0x0A000229*/
    IL_0261: ldloc.s 19
    IL_0263: ldc.i4.1
    IL_0264: add
    IL_0265: stloc.s 19
    IL_0267: ldloc.s 19
    IL_0269: ldloc.s 18
    IL_026b: ldlen
    IL_026c: conv.i4
    IL_026d: blt.s IL_0236
    IL_026f: ldloc.s 7
    IL_0271: ldc.i4.1
    IL_0272: callvirt void Hp::set_Elite(bool)  /*0x06000811*/
    IL_0277: ldarg.0
    IL_0278: ldfld bool Spawn::tauntTheTurtle  /*0x040007F0*/
    IL_027d: brfalse.s IL_028e
    IL_027f: ldloc.s 8
    IL_0281: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0286: ldfld float PerkManager::tauntTheTurtle_hpMultiplyer  /*0x04000BFC*/
    IL_028b: mul
    IL_028c: stloc.s 8
    IL_028e: ldarg.0
    IL_028f: ldfld bool Spawn::tauntTheTiger  /*0x040007EF*/
    IL_0294: brfalse.s IL_02a5
    IL_0296: ldloc.s 9
    IL_0298: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_029d: ldfld float PerkManager::tauntTheTiger_damageMultiplyer  /*0x04000BFA*/
    IL_02a2: mul
    IL_02a3: stloc.s 9
    IL_02a5: ldarg.0
    IL_02a6: ldfld bool Spawn::tauntTheFalcon  /*0x040007F1*/
    IL_02ab: brfalse.s IL_02cb
    IL_02ad: ldloc.s 11
    IL_02af: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_02b4: ldfld float PerkManager::tauntTheFalcon_speedMultiplyer  /*0x04000BFE*/
    IL_02b9: mul
    IL_02ba: stloc.s 11
    IL_02bc: ldloc.s 12
    IL_02be: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_02c3: ldfld float PerkManager::tauntTheFalcon_chasePlayerTimeMultiplyer  /*0x04000BFF*/
    IL_02c8: mul
    IL_02c9: stloc.s 12
    IL_02cb: ldarg.0
    IL_02cc: ldfld bool Spawn::antiAirTelescope  /*0x040007F2*/
    IL_02d1: brfalse.s IL_0300
    IL_02d3: ldloc.s 6
    IL_02d5: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_02da: ldc.i4.6
    IL_02db: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_02e0: brfalse.s IL_0300
    IL_02e2: ldloc.s 8
    IL_02e4: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_02e9: ldfld float PerkManager::antiAir_helathMultiplyer  /*0x04000C29*/
    IL_02ee: mul
    IL_02ef: stloc.s 8
    IL_02f1: ldloc.s 9
    IL_02f3: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_02f8: ldfld float PerkManager::antiAir_damageMultiplyer  /*0x04000C2A*/
    IL_02fd: mul
    IL_02fe: stloc.s 9
    IL_0300: ldc.i4.0
    IL_0301: call bool DlcConfiguration::IsDlcAvailable(IDlcProvider.DlcId)  /*0x0600001C*/
    IL_0306: brfalse.s IL_0318
    IL_0308: ldloc.s 6
    IL_030a: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_030f: ldc.i4.s 48
    IL_0311: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0316: br.s IL_0319
    IL_0318: ldc.i4.0
    IL_0319: stloc.s 14
    IL_031b: ldarg.0
    IL_031c: ldfld bool Spawn::godOfAfterlife  /*0x040007F7*/
    IL_0321: brfalse.s IL_0352
    IL_0323: ldloc.s 14
    IL_0325: brtrue.s IL_0352
    IL_0327: ldarg.0
    IL_0328: ldfld int Spawn::spawnedUnits  /*0x040007ED*/
    IL_032d: ldc.i4.2
    IL_032e: rem
    IL_032f: brtrue.s IL_0352
    IL_0331: ldloc.s 6
    IL_0333: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0338: ldc.i4.s 40
    IL_033a: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_033f: brfalse.s IL_0352
    IL_0341: ldloc.s 7
    IL_0343: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0348: ldfld GameObject PerkManager::godOfAfterlifeEnemy  /*0x04000C56*/
    IL_034d: stfld GameObject Hp::enemyToSpawnOnDeath  /*0x04000A37*/
    IL_0352: ldarg.0
    IL_0353: ldfld bool Spawn::prayToWarGods  /*0x040007F3*/
    IL_0358: brfalse.s IL_0378
    IL_035a: ldloc.s 9
    IL_035c: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0361: ldfld float PerkManager::prayWarGods_dmgMulti  /*0x04000C34*/
    IL_0366: mul
    IL_0367: stloc.s 9
    IL_0369: ldloc.s 8
    IL_036b: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0370: ldfld float PerkManager::prayWarGods_hpMulti  /*0x04000C33*/
    IL_0375: mul
    IL_0376: stloc.s 8
    IL_0378: ldarg.0
    IL_0379: ldfld bool Spawn::tauntTheGrowth  /*0x040007F5*/
    IL_037e: brfalse.s IL_03b6
    IL_0380: ldloc.s 9
    IL_0382: ldarg.0
    IL_0383: ldfld float Spawn::addDmgGrowthDiffPerWave  /*0x040007F8*/
    IL_0388: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_038d: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0392: conv.r4
    IL_0393: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0398: mul
    IL_0399: stloc.s 9
    IL_039b: ldloc.s 8
    IL_039d: ldarg.0
    IL_039e: ldfld float Spawn::addHpGrowthDiffPerWave  /*0x040007F9*/
    IL_03a3: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_03a8: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_03ad: conv.r4
    IL_03ae: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_03b3: mul
    IL_03b4: stloc.s 8
    IL_03b6: ldarg.0
    IL_03b7: ldfld bool Spawn::tauntTheRange  /*0x040007F6*/
    IL_03bc: brfalse.s IL_0427
    IL_03be: ldloc.s 6
    IL_03c0: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_03c5: ldc.i4.5
    IL_03c6: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_03cb: brfalse.s IL_0427
    IL_03cd: ldloc.s 6
    IL_03cf: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_03d4: ldc.i4.6
    IL_03d5: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_03da: brtrue.s IL_0427
    IL_03dc: ldloc.s 8
    IL_03de: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_03e3: ldfld float PerkManager::rangeGodHealthMultiplyer  /*0x04000C48*/
    IL_03e8: mul
    IL_03e9: stloc.s 8
    IL_03eb: ldloc.s 9
    IL_03ed: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_03f2: ldfld float PerkManager::rangeGodDamageMultiplyer  /*0x04000C49*/
    IL_03f7: mul
    IL_03f8: stloc.s 9
    IL_03fa: ldloc.s 10
    IL_03fc: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0401: ldfld float PerkManager::rangeGodAttackCooldownMultiplyer  /*0x04000C4A*/
    IL_0406: mul
    IL_0407: stloc.s 10
    IL_0409: ldloc.s 11
    IL_040b: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0410: ldfld float PerkManager::rangeGodMoveSpeedMultiplyer  /*0x04000C47*/
    IL_0415: mul
    IL_0416: stloc.s 11
    IL_0418: ldloc.s 13
    IL_041a: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_041f: ldfld float PerkManager::rangeGodRangeMultiplyer  /*0x04000C46*/
    IL_0424: mul
    IL_0425: stloc.s 13
    IL_0427: ldloc.s 7
    IL_0429: ldloc.s 7
    IL_042b: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0430: callvirt void Hp::set_HpOriginal(float)  /*0x0600081F*/
    IL_0435: ldloc.s 8
    IL_0437: ldc.r4 1f
    IL_043c: beq.s IL_045f
    IL_043e: ldloc.s 7
    IL_0440: ldnull
    IL_0441: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0446: brfalse.s IL_045f
    IL_0448: ldloc.s 7
    IL_044a: dup
    IL_044b: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0450: ldloc.s 8
    IL_0452: mul
    IL_0453: stfld float Hp::maxHp  /*0x04000A2C*/
    IL_0458: ldloc.s 7
    IL_045a: callvirt void Hp::SetHpToMaxHp()  /*0x06000825*/
    IL_045f: ldloc.s 9
    IL_0461: ldc.r4 1f
    IL_0466: bne.un.s IL_0485
    IL_0468: ldloc.s 10
    IL_046a: ldc.r4 1f
    IL_046f: bne.un.s IL_0485
    IL_0471: ldloc.s 13
    IL_0473: ldc.r4 1f
    IL_0478: bne.un.s IL_0485
    IL_047a: ldarg.0
    IL_047b: ldfld bool Spawn::godOfChaos  /*0x040007F4*/
    IL_0480: brfalse IL_0552
    IL_0485: ldloc.s 5
    IL_0487: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren()<AutoAttack>  /*0x2B000053*/
    IL_048c: stloc.s 21
    IL_048e: ldc.i4.0
    IL_048f: stloc.s 19
    IL_0491: br IL_0547
    IL_0496: ldloc.s 21
    IL_0498: ldloc.s 19
    IL_049a: ldelem.ref
    IL_049b: stloc.s 22
    IL_049d: ldloc.s 4
    IL_049f: brfalse.s IL_04ad
    IL_04a1: ldloc.s 22
    IL_04a3: ldc.r4 3f
    IL_04a8: callvirt void AutoAttack::SetCooldownTo(float)  /*0x06000232*/
    IL_04ad: ldloc.s 22
    IL_04af: dup
    IL_04b0: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_04b5: ldloc.s 9
    IL_04b7: mul
    IL_04b8: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_04bd: ldloc.s 22
    IL_04bf: dup
    IL_04c0: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_04c5: ldloc.s 10
    IL_04c7: mul
    IL_04c8: stfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_04cd: ldloc.s 13
    IL_04cf: ldc.r4 1f
    IL_04d4: beq.s IL_0541
    IL_04d6: ldloc.s 22
    IL_04d8: callvirt Type System.Object::GetType()  /*0x0A0002B4*/
    IL_04dd: ldtoken AutoAttackWithWarning  /*0x02000072*/
    IL_04e2: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_04e7: call bool System.Type::op_Equality(System.Type,System.Type)  /*0x0A0002B6*/
    IL_04ec: brfalse.s IL_0503
    IL_04ee: ldloc.s 22
    IL_04f0: castclass AutoAttackWithWarning  /*0x02000072*/
    IL_04f5: dup
    IL_04f6: ldfld float AutoAttackWithWarning::breakTargetingDistance  /*0x04000327*/
    IL_04fb: ldloc.s 13
    IL_04fd: mul
    IL_04fe: stfld float AutoAttackWithWarning::breakTargetingDistance  /*0x04000327*/
    IL_0503: ldloc.s 22
    IL_0505: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_050a: callvirt List.Enumerator<!0> System.Collections.Generic.List<TargetPriority>::GetEnumerator()  /*0x0A0001D1*/
    IL_050f: stloc.s 23
    IL_0511: br.s IL_0528
    IL_0513: ldloca.s 23
    IL_0515: call !0 System.Collections.Generic.List.Enumerator<TargetPriority>::get_Current()  /*0x0A0001D2*/
    IL_051a: dup
    IL_051b: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0520: ldloc.s 13
    IL_0522: mul
    IL_0523: stfld float TargetPriority::range  /*0x040010D2*/
    IL_0528: ldloca.s 23
    IL_052a: call bool System.Collections.Generic.List.Enumerator<TargetPriority>::MoveNext()  /*0x0A0001D6*/
    IL_052f: brtrue.s IL_0513
    IL_0531: leave.s IL_0541
    IL_0533: ldloca.s 23
    IL_0535: constrained. System.Collections.Generic.List.Enumerator<TargetPriority>  /*0x1B000040*/
    IL_053b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0540: endfinally
    IL_0541: ldloc.s 19
    IL_0543: ldc.i4.1
    IL_0544: add
    IL_0545: stloc.s 19
    IL_0547: ldloc.s 19
    IL_0549: ldloc.s 21
    IL_054b: ldlen
    IL_054c: conv.i4
    IL_054d: blt IL_0496
    IL_0552: ldloc.s 11
    IL_0554: ldc.r4 1f
    IL_0559: bne.un.s IL_056d
    IL_055b: ldloc.s 12
    IL_055d: ldc.r4 1f
    IL_0562: bne.un.s IL_056d
    IL_0564: ldloc.s 13
    IL_0566: ldc.r4 1f
    IL_056b: beq.s IL_05ba
    IL_056d: ldloc.s 5
    IL_056f: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren()<PathfindMovementEnemy>  /*0x2B000063*/
    IL_0574: stloc.s 24
    IL_0576: ldc.i4.0
    IL_0577: stloc.s 19
    IL_0579: br.s IL_05b2
    IL_057b: ldloc.s 24
    IL_057d: ldloc.s 19
    IL_057f: ldelem.ref
    IL_0580: dup
    IL_0581: dup
    IL_0582: ldfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_0587: ldloc.s 11
    IL_0589: mul
    IL_058a: stfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_058f: dup
    IL_0590: dup
    IL_0591: ldfld float PathfindMovementEnemy::agroTimeWhenAttackedByPlayer  /*0x04000DDF*/
    IL_0596: ldloc.s 12
    IL_0598: mul
    IL_0599: stfld float PathfindMovementEnemy::agroTimeWhenAttackedByPlayer  /*0x04000DDF*/
    IL_059e: dup
    IL_059f: ldfld float PathfindMovementEnemy::keepDistanceOf  /*0x04000DDA*/
    IL_05a4: ldloc.s 13
    IL_05a6: mul
    IL_05a7: stfld float PathfindMovementEnemy::keepDistanceOf  /*0x04000DDA*/
    IL_05ac: ldloc.s 19
    IL_05ae: ldc.i4.1
    IL_05af: add
    IL_05b0: stloc.s 19
    IL_05b2: ldloc.s 19
    IL_05b4: ldloc.s 24
    IL_05b6: ldlen
    IL_05b7: conv.i4
    IL_05b8: blt.s IL_057b
    IL_05ba: ldsfld int EnemySpawner::totalEnemiesSpawnedThisWave  /*0x040007DA*/
    IL_05bf: ldc.i4.1
    IL_05c0: add
    IL_05c1: stsfld int EnemySpawner::totalEnemiesSpawnedThisWave  /*0x040007DA*/
    IL_05c6: ldarg.0
    IL_05c7: ldarg.0
    IL_05c8: ldfld int Spawn::spawnedUnits  /*0x040007ED*/
    IL_05cd: ldc.i4.1
    IL_05ce: add
    IL_05cf: stfld int Spawn::spawnedUnits  /*0x040007ED*/
    IL_05d4: ldarg.0
    IL_05d5: ldfld int Spawn::spawnedUnits  /*0x040007ED*/
    IL_05da: ldarg.0
    IL_05db: ldfld int Spawn::count  /*0x040007E7*/
    IL_05e0: blt.s IL_05e9
    IL_05e2: ldarg.0
    IL_05e3: ldc.i4.1
    IL_05e4: stfld bool Spawn::finished  /*0x040007EE*/
    IL_05e9: ret
    .try IL_0511-IL_0533 finally handler IL_0533-IL_0541

  .method Spawn::GetRandomPointOnSpawnLine(bool,Pathfinding.NNConstraint)  // token 0x060006A8 rva 0x1d268 attrs Public, HideBySig
    // code size 258 (0x102), max stack 4, init locals
    .locals ([0] float, [1] Vector3, [2] float, [3] int, [4] float, [5] Vector3, [6] float)
    IL_0000: ldarg.0
    IL_0001: call float Spawn::GetTotalSpawnLineLength()  /*0x060006A9*/
    IL_0006: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_000b: mul
    IL_000c: stloc.0
    IL_000d: ldarg.1
    IL_000e: brtrue.s IL_0017
    IL_0010: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0015: br.s IL_0026
    IL_0017: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_001c: ldc.r4 5f
    IL_0021: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0026: stloc.1
    IL_0027: ldc.r4 0f
    IL_002c: stloc.2
    IL_002d: ldc.i4.0
    IL_002e: stloc.3
    IL_002f: br IL_00bd
    IL_0034: ldarg.0
    IL_0035: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_003a: ldloc.3
    IL_003b: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0040: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0045: ldarg.0
    IL_0046: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_004b: ldloc.3
    IL_004c: ldc.i4.1
    IL_004d: add
    IL_004e: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0053: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0058: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_005d: stloc.s 5
    IL_005f: ldloca.s 5
    IL_0061: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0066: stloc.s 4
    IL_0068: ldloc.s 4
    IL_006a: ldc.r4 0f
    IL_006f: beq.s IL_00b9
    IL_0071: ldloc.s 4
    IL_0073: ldloc.2
    IL_0074: add
    IL_0075: ldloc.0
    IL_0076: blt.un.s IL_00b4
    IL_0078: ldloc.0
    IL_0079: ldloc.2
    IL_007a: sub
    IL_007b: stloc.0
    IL_007c: ldloc.0
    IL_007d: ldloc.s 4
    IL_007f: div
    IL_0080: stloc.s 6
    IL_0082: ldarg.0
    IL_0083: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_0088: ldloc.3
    IL_0089: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_008e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0093: ldarg.0
    IL_0094: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_0099: ldloc.3
    IL_009a: ldc.i4.1
    IL_009b: add
    IL_009c: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_00a1: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00a6: ldloc.s 6
    IL_00a8: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_00ad: ldloc.1
    IL_00ae: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00b3: ret
    IL_00b4: ldloc.2
    IL_00b5: ldloc.s 4
    IL_00b7: add
    IL_00b8: stloc.2
    IL_00b9: ldloc.3
    IL_00ba: ldc.i4.1
    IL_00bb: add
    IL_00bc: stloc.3
    IL_00bd: ldloc.3
    IL_00be: ldarg.0
    IL_00bf: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_00c4: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_00c9: ldc.i4.1
    IL_00ca: sub
    IL_00cb: blt IL_0034
    IL_00d0: ldarg.0
    IL_00d1: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_00d6: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_00db: ldc.i4.0
    IL_00dc: ble.s IL_00f6
    IL_00de: ldarg.0
    IL_00df: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_00e4: ldc.i4.0
    IL_00e5: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_00ea: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00ef: ldloc.1
    IL_00f0: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00f5: ret
    IL_00f6: ldarg.0
    IL_00f7: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_00fc: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0101: ret

  .method Spawn::GetTotalSpawnLineLength()  // token 0x060006A9 rva 0x1d378 attrs Public, HideBySig
    // code size 84 (0x54), max stack 5, init locals
    .locals ([0] float, [1] int, [2] Vector3)
    IL_0000: ldc.r4 0f
    IL_0005: stloc.0
    IL_0006: ldc.i4.0
    IL_0007: stloc.1
    IL_0008: br.s IL_0042
    IL_000a: ldloc.0
    IL_000b: ldarg.0
    IL_000c: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_0011: ldloc.1
    IL_0012: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0017: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_001c: ldarg.0
    IL_001d: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_0022: ldloc.1
    IL_0023: ldc.i4.1
    IL_0024: add
    IL_0025: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_002a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002f: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0034: stloc.2
    IL_0035: ldloca.s 2
    IL_0037: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_003c: add
    IL_003d: stloc.0
    IL_003e: ldloc.1
    IL_003f: ldc.i4.1
    IL_0040: add
    IL_0041: stloc.1
    IL_0042: ldloc.1
    IL_0043: ldarg.0
    IL_0044: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_0049: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_004e: ldc.i4.1
    IL_004f: sub
    IL_0050: blt.s IL_000a
    IL_0052: ldloc.0
    IL_0053: ret

  .method Spawn::AdjustEnemyParametersAfterSpawn(UnityEngine.GameObject,bool)  // token 0x060006AA rva 0x1d3d8 attrs Public, Static, HideBySig
    // code size 920 (0x398), max stack 5, init locals
    .locals ([0] float, [1] float, [2] float, [3] float, [4] float, [5] float, [6] TaggedObject, [7] Hp, [8] bool, [9] bool, [10] bool, [11] bool, [12] bool, [13] bool, [14] float, [15] float, [16] MeshRenderer[], [17] int, [18] MeshRenderer, [19] AutoAttack[], [20] AutoAttack, [21] AutoAttackWithWarning, [22] List.Enumerator<TargetPriority>, [23] PathfindMovementEnemy[])
    IL_0000: ldc.r4 1f
    IL_0005: stloc.0
    IL_0006: ldc.r4 1f
    IL_000b: stloc.1
    IL_000c: ldc.r4 1f
    IL_0011: stloc.2
    IL_0012: ldc.r4 1f
    IL_0017: stloc.3
    IL_0018: ldc.r4 1f
    IL_001d: stloc.s 4
    IL_001f: ldc.r4 1f
    IL_0024: stloc.s 5
    IL_0026: ldarg.0
    IL_0027: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<TaggedObject>  /*0x2B000061*/
    IL_002c: stloc.s 6
    IL_002e: ldarg.0
    IL_002f: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<Hp>  /*0x2B00005D*/
    IL_0034: stloc.s 7
    IL_0036: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_003b: ldfld Equippable PerkManager::turtleGodPerk  /*0x04000BFD*/
    IL_0040: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0045: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_004a: ldfld Equippable PerkManager::tigerGodPerk  /*0x04000BFB*/
    IL_004f: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0054: stloc.s 8
    IL_0056: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_005b: ldfld Equippable PerkManager::falconGodPerk  /*0x04000C00*/
    IL_0060: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0065: stloc.s 9
    IL_0067: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_006c: ldfld Equippable PerkManager::antiAirTelescope  /*0x04000C28*/
    IL_0071: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0076: stloc.s 10
    IL_0078: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_007d: ldfld Equippable PerkManager::prayToWarGods  /*0x04000C32*/
    IL_0082: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0087: stloc.s 11
    IL_0089: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_008e: callvirt bool PerkManager::get_GrowthGodEquipped()  /*0x06000998*/
    IL_0093: stloc.s 12
    IL_0095: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_009a: callvirt bool PerkManager::get_RangeGodEquipped()  /*0x06000999*/
    IL_009f: stloc.s 13
    IL_00a1: brfalse.s IL_00b0
    IL_00a3: ldloc.0
    IL_00a4: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00a9: ldfld float PerkManager::tauntTheTurtle_hpMultiplyer  /*0x04000BFC*/
    IL_00ae: mul
    IL_00af: stloc.0
    IL_00b0: ldloc.s 8
    IL_00b2: brfalse.s IL_00c1
    IL_00b4: ldloc.1
    IL_00b5: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00ba: ldfld float PerkManager::tauntTheTiger_damageMultiplyer  /*0x04000BFA*/
    IL_00bf: mul
    IL_00c0: stloc.1
    IL_00c1: ldloc.s 9
    IL_00c3: brfalse.s IL_00e1
    IL_00c5: ldloc.3
    IL_00c6: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00cb: ldfld float PerkManager::tauntTheFalcon_speedMultiplyer  /*0x04000BFE*/
    IL_00d0: mul
    IL_00d1: stloc.3
    IL_00d2: ldloc.s 4
    IL_00d4: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00d9: ldfld float PerkManager::tauntTheFalcon_chasePlayerTimeMultiplyer  /*0x04000BFF*/
    IL_00de: mul
    IL_00df: stloc.s 4
    IL_00e1: ldloc.s 10
    IL_00e3: brfalse.s IL_010e
    IL_00e5: ldloc.s 6
    IL_00e7: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_00ec: ldc.i4.6
    IL_00ed: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_00f2: brfalse.s IL_010e
    IL_00f4: ldloc.0
    IL_00f5: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00fa: ldfld float PerkManager::antiAir_helathMultiplyer  /*0x04000C29*/
    IL_00ff: mul
    IL_0100: stloc.0
    IL_0101: ldloc.1
    IL_0102: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0107: ldfld float PerkManager::antiAir_damageMultiplyer  /*0x04000C2A*/
    IL_010c: mul
    IL_010d: stloc.1
    IL_010e: ldloc.s 11
    IL_0110: brfalse.s IL_012c
    IL_0112: ldloc.1
    IL_0113: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0118: ldfld float PerkManager::prayWarGods_dmgMulti  /*0x04000C34*/
    IL_011d: mul
    IL_011e: stloc.1
    IL_011f: ldloc.0
    IL_0120: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0125: ldfld float PerkManager::prayWarGods_hpMulti  /*0x04000C33*/
    IL_012a: mul
    IL_012b: stloc.0
    IL_012c: ldloc.s 12
    IL_012e: brfalse.s IL_01ae
    IL_0130: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0135: ldfld float PerkManager::growthGodMaxDamageMulti  /*0x04000C43*/
    IL_013a: ldc.r4 1f
    IL_013f: ldc.i4.1
    IL_0140: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0145: callvirt int EnemySpawner::get_WaveCount()  /*0x0600066D*/
    IL_014a: ldc.i4.1
    IL_014b: sub
    IL_014c: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_0151: conv.r4
    IL_0152: div
    IL_0153: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0158: stloc.s 14
    IL_015a: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_015f: ldfld float PerkManager::growthGodMaxHpMulti  /*0x04000C44*/
    IL_0164: ldc.r4 1f
    IL_0169: ldc.i4.1
    IL_016a: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_016f: callvirt int EnemySpawner::get_WaveCount()  /*0x0600066D*/
    IL_0174: ldc.i4.1
    IL_0175: sub
    IL_0176: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_017b: conv.r4
    IL_017c: div
    IL_017d: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0182: stloc.s 15
    IL_0184: ldloc.1
    IL_0185: ldloc.s 14
    IL_0187: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_018c: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0191: conv.r4
    IL_0192: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0197: mul
    IL_0198: stloc.1
    IL_0199: ldloc.0
    IL_019a: ldloc.s 15
    IL_019c: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_01a1: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_01a6: conv.r4
    IL_01a7: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_01ac: mul
    IL_01ad: stloc.0
    IL_01ae: ldloc.s 13
    IL_01b0: brfalse.s IL_0213
    IL_01b2: ldloc.s 6
    IL_01b4: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_01b9: ldc.i4.5
    IL_01ba: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_01bf: brfalse.s IL_0213
    IL_01c1: ldloc.s 6
    IL_01c3: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_01c8: ldc.i4.6
    IL_01c9: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_01ce: brtrue.s IL_0213
    IL_01d0: ldloc.0
    IL_01d1: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_01d6: ldfld float PerkManager::rangeGodHealthMultiplyer  /*0x04000C48*/
    IL_01db: mul
    IL_01dc: stloc.0
    IL_01dd: ldloc.1
    IL_01de: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_01e3: ldfld float PerkManager::rangeGodDamageMultiplyer  /*0x04000C49*/
    IL_01e8: mul
    IL_01e9: stloc.1
    IL_01ea: ldloc.2
    IL_01eb: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_01f0: ldfld float PerkManager::rangeGodAttackCooldownMultiplyer  /*0x04000C4A*/
    IL_01f5: mul
    IL_01f6: stloc.2
    IL_01f7: ldloc.3
    IL_01f8: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_01fd: ldfld float PerkManager::rangeGodMoveSpeedMultiplyer  /*0x04000C47*/
    IL_0202: mul
    IL_0203: stloc.3
    IL_0204: ldloc.s 5
    IL_0206: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_020b: ldfld float PerkManager::rangeGodRangeMultiplyer  /*0x04000C46*/
    IL_0210: mul
    IL_0211: stloc.s 5
    IL_0213: ldarg.1
    IL_0214: brfalse.s IL_0274
    IL_0216: ldloc.0
    IL_0217: ldc.r4 4f
    IL_021c: mul
    IL_021d: stloc.0
    IL_021e: ldloc.1
    IL_021f: ldc.r4 3f
    IL_0224: mul
    IL_0225: stloc.1
    IL_0226: ldarg.0
    IL_0227: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren()<UnityEngine.MeshRenderer>  /*0x2B000062*/
    IL_022c: stloc.s 16
    IL_022e: ldc.i4.0
    IL_022f: stloc.s 17
    IL_0231: br.s IL_0264
    IL_0233: ldloc.s 16
    IL_0235: ldloc.s 17
    IL_0237: ldelem.ref
    IL_0238: stloc.s 18
    IL_023a: ldloc.s 18
    IL_023c: callvirt Material UnityEngine.Renderer::get_sharedMaterial()  /*0x0A0002B3*/
    IL_0241: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0246: ldstr "Enemy"
    IL_024b: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0250: brfalse.s IL_025e
    IL_0252: ldloc.s 18
    IL_0254: call Material ColorAndLightManager::get_EliteEnemyMaterial()  /*0x06000355*/
    IL_0259: callvirt void UnityEngine.Renderer::set_sharedMaterial(UnityEngine.Material)  /*0x0A000229*/
    IL_025e: ldloc.s 17
    IL_0260: ldc.i4.1
    IL_0261: add
    IL_0262: stloc.s 17
    IL_0264: ldloc.s 17
    IL_0266: ldloc.s 16
    IL_0268: ldlen
    IL_0269: conv.i4
    IL_026a: blt.s IL_0233
    IL_026c: ldloc.s 7
    IL_026e: ldc.i4.1
    IL_026f: callvirt void Hp::set_Elite(bool)  /*0x06000811*/
    IL_0274: ldloc.s 7
    IL_0276: ldnull
    IL_0277: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_027c: brfalse.s IL_02a2
    IL_027e: ldloc.s 7
    IL_0280: ldloc.s 7
    IL_0282: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0287: callvirt void Hp::set_HpOriginal(float)  /*0x0600081F*/
    IL_028c: ldloc.s 7
    IL_028e: dup
    IL_028f: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0294: ldloc.0
    IL_0295: mul
    IL_0296: stfld float Hp::maxHp  /*0x04000A2C*/
    IL_029b: ldloc.s 7
    IL_029d: callvirt void Hp::SetHpToMaxHp()  /*0x06000825*/
    IL_02a2: ldarg.0
    IL_02a3: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren()<AutoAttack>  /*0x2B000053*/
    IL_02a8: stloc.s 19
    IL_02aa: ldc.i4.0
    IL_02ab: stloc.s 17
    IL_02ad: br IL_0341
    IL_02b2: ldloc.s 19
    IL_02b4: ldloc.s 17
    IL_02b6: ldelem.ref
    IL_02b7: stloc.s 20
    IL_02b9: ldloc.s 20
    IL_02bb: dup
    IL_02bc: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_02c1: ldloc.1
    IL_02c2: mul
    IL_02c3: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_02c8: ldloc.s 20
    IL_02ca: dup
    IL_02cb: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_02d0: ldloc.2
    IL_02d1: mul
    IL_02d2: stfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_02d7: ldloc.s 5
    IL_02d9: ldc.r4 1f
    IL_02de: beq.s IL_033b
    IL_02e0: ldloc.s 20
    IL_02e2: isinst AutoAttackWithWarning  /*0x02000072*/
    IL_02e7: stloc.s 21
    IL_02e9: ldloc.s 21
    IL_02eb: brfalse.s IL_02fd
    IL_02ed: ldloc.s 21
    IL_02ef: dup
    IL_02f0: ldfld float AutoAttackWithWarning::breakTargetingDistance  /*0x04000327*/
    IL_02f5: ldloc.s 5
    IL_02f7: mul
    IL_02f8: stfld float AutoAttackWithWarning::breakTargetingDistance  /*0x04000327*/
    IL_02fd: ldloc.s 20
    IL_02ff: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0304: callvirt List.Enumerator<!0> System.Collections.Generic.List<TargetPriority>::GetEnumerator()  /*0x0A0001D1*/
    IL_0309: stloc.s 22
    IL_030b: br.s IL_0322
    IL_030d: ldloca.s 22
    IL_030f: call !0 System.Collections.Generic.List.Enumerator<TargetPriority>::get_Current()  /*0x0A0001D2*/
    IL_0314: dup
    IL_0315: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_031a: ldloc.s 5
    IL_031c: mul
    IL_031d: stfld float TargetPriority::range  /*0x040010D2*/
    IL_0322: ldloca.s 22
    IL_0324: call bool System.Collections.Generic.List.Enumerator<TargetPriority>::MoveNext()  /*0x0A0001D6*/
    IL_0329: brtrue.s IL_030d
    IL_032b: leave.s IL_033b
    IL_032d: ldloca.s 22
    IL_032f: constrained. System.Collections.Generic.List.Enumerator<TargetPriority>  /*0x1B000040*/
    IL_0335: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_033a: endfinally
    IL_033b: ldloc.s 17
    IL_033d: ldc.i4.1
    IL_033e: add
    IL_033f: stloc.s 17
    IL_0341: ldloc.s 17
    IL_0343: ldloc.s 19
    IL_0345: ldlen
    IL_0346: conv.i4
    IL_0347: blt IL_02b2
    IL_034c: ldarg.0
    IL_034d: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren()<PathfindMovementEnemy>  /*0x2B000063*/
    IL_0352: stloc.s 23
    IL_0354: ldc.i4.0
    IL_0355: stloc.s 17
    IL_0357: br.s IL_038f
    IL_0359: ldloc.s 23
    IL_035b: ldloc.s 17
    IL_035d: ldelem.ref
    IL_035e: dup
    IL_035f: dup
    IL_0360: ldfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_0365: ldloc.3
    IL_0366: mul
    IL_0367: stfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_036c: dup
    IL_036d: dup
    IL_036e: ldfld float PathfindMovementEnemy::agroTimeWhenAttackedByPlayer  /*0x04000DDF*/
    IL_0373: ldloc.s 4
    IL_0375: mul
    IL_0376: stfld float PathfindMovementEnemy::agroTimeWhenAttackedByPlayer  /*0x04000DDF*/
    IL_037b: dup
    IL_037c: ldfld float PathfindMovementEnemy::keepDistanceOf  /*0x04000DDA*/
    IL_0381: ldloc.s 5
    IL_0383: mul
    IL_0384: stfld float PathfindMovementEnemy::keepDistanceOf  /*0x04000DDA*/
    IL_0389: ldloc.s 17
    IL_038b: ldc.i4.1
    IL_038c: add
    IL_038d: stloc.s 17
    IL_038f: ldloc.s 17
    IL_0391: ldloc.s 23
    IL_0393: ldlen
    IL_0394: conv.i4
    IL_0395: blt.s IL_0359
    IL_0397: ret
    .try IL_030b-IL_032d finally handler IL_032d-IL_033b

