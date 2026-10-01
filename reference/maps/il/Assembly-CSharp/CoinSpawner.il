// ===== CoinSpawner  (token 0x0200009B) =====
  .method CoinSpawner::get_CoinsLeft()  // token 0x06000343 rva 0xea5b attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int CoinSpawner::coinsLeft  /*0x04000411*/
    IL_0006: ret

  .method CoinSpawner::OnEnable()  // token 0x06000344 rva 0xea63 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldsfld List<CoinSpawner> CoinSpawner::allCoinSpawners  /*0x04000412*/
    IL_0005: ldarg.0
    IL_0006: callvirt void System.Collections.Generic.List<CoinSpawner>::Add(!0)  /*0x0A000175*/
    IL_000b: ret

  .method CoinSpawner::OnDisable()  // token 0x06000345 rva 0xea70 attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldsfld List<CoinSpawner> CoinSpawner::allCoinSpawners  /*0x04000412*/
    IL_0005: ldarg.0
    IL_0006: callvirt bool System.Collections.Generic.List<CoinSpawner>::Remove(!0)  /*0x0A000176*/
    IL_000b: pop
    IL_000c: ret

  .method CoinSpawner::get_AllCoinsLeftToBeSpawned()  // token 0x06000346 rva 0xea80 attrs Public, Static, HideBySig, SpecialName
    // code size 78 (0x4e), max stack 3, init locals
    .locals ([0] int, [1] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldsfld List<CoinSpawner> CoinSpawner::allCoinSpawners  /*0x04000412*/
    IL_0007: callvirt int System.Collections.Generic.List<CoinSpawner>::get_Count()  /*0x0A000177*/
    IL_000c: ldc.i4.1
    IL_000d: sub
    IL_000e: stloc.1
    IL_000f: br.s IL_0048
    IL_0011: ldsfld List<CoinSpawner> CoinSpawner::allCoinSpawners  /*0x04000412*/
    IL_0016: ldloc.1
    IL_0017: callvirt !0 System.Collections.Generic.List<CoinSpawner>::get_Item(int)  /*0x0A000178*/
    IL_001c: ldnull
    IL_001d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0022: brfalse.s IL_0031
    IL_0024: ldsfld List<CoinSpawner> CoinSpawner::allCoinSpawners  /*0x04000412*/
    IL_0029: ldloc.1
    IL_002a: callvirt void System.Collections.Generic.List<CoinSpawner>::RemoveAt(int)  /*0x0A000179*/
    IL_002f: br.s IL_0044
    IL_0031: ldloc.0
    IL_0032: ldsfld List<CoinSpawner> CoinSpawner::allCoinSpawners  /*0x04000412*/
    IL_0037: ldloc.1
    IL_0038: callvirt !0 System.Collections.Generic.List<CoinSpawner>::get_Item(int)  /*0x0A000178*/
    IL_003d: callvirt int CoinSpawner::get_CoinsLeft()  /*0x06000343*/
    IL_0042: add
    IL_0043: stloc.0
    IL_0044: ldloc.1
    IL_0045: ldc.i4.1
    IL_0046: sub
    IL_0047: stloc.1
    IL_0048: ldloc.1
    IL_0049: ldc.i4.0
    IL_004a: bge.s IL_0011
    IL_004c: ldloc.0
    IL_004d: ret

  .method CoinSpawner::TriggerCoinSpawn(int,PlayerInteraction)  // token 0x06000347 rva 0xeada attrs Public, HideBySig
    // code size 48 (0x30), max stack 8
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_000b: brfalse.s IL_002f
    IL_000d: ldarg.0
    IL_000e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0013: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0018: brfalse.s IL_002f
    IL_001a: ldarg.0
    IL_001b: ldarg.0
    IL_001c: ldarg.1
    IL_001d: ldarg.0
    IL_001e: ldfld float CoinSpawner::interval  /*0x04000410*/
    IL_0023: ldarg.2
    IL_0024: call IEnumerator CoinSpawner::SpawnCoins(int,float,PlayerInteraction)  /*0x06000348*/
    IL_0029: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_002e: pop
    IL_002f: ret

  .method CoinSpawner::SpawnCoins(int,float,PlayerInteraction)  // token 0x06000348 rva 0xeb0b attrs Private, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void CoinSpawner.<SpawnCoins>d__11::.ctor(int)  /*0x0600034B*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld CoinSpawner CoinSpawner.<SpawnCoins>d__11::<>4__this  /*0x04000415*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld int CoinSpawner.<SpawnCoins>d__11::amount  /*0x04000416*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld float CoinSpawner.<SpawnCoins>d__11::delay  /*0x04000417*/
    IL_001b: dup
    IL_001c: ldarg.3
    IL_001d: stfld PlayerInteraction CoinSpawner.<SpawnCoins>d__11::player  /*0x04000418*/
    IL_0022: ret

  .method CoinSpawner::.ctor()  // token 0x06000349 rva 0xeb2f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.5f
    IL_0006: stfld float CoinSpawner::interval  /*0x04000410*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

  .method CoinSpawner::.cctor()  // token 0x0600034A rva 0xeb42 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void System.Collections.Generic.List<CoinSpawner>::.ctor()  /*0x0A00017A*/
    IL_0005: stsfld List<CoinSpawner> CoinSpawner::allCoinSpawners  /*0x04000412*/
    IL_000a: ret

// ===== CoinSpawner/<SpawnCoins>d__11  (token 0x0200009C) =====
  .method CoinSpawner.<SpawnCoins>d__11::.ctor(int)  // token 0x0600034B rva 0xeb4e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int CoinSpawner.<SpawnCoins>d__11::<>1__state  /*0x04000413*/
    IL_000d: ret

  .method CoinSpawner.<SpawnCoins>d__11::System.IDisposable.Dispose()  // token 0x0600034C rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CoinSpawner.<SpawnCoins>d__11::MoveNext()  // token 0x0600034D rva 0xeb60 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 216 (0xd8), max stack 3, init locals
    .locals ([0] int, [1] CoinSpawner, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int CoinSpawner.<SpawnCoins>d__11::<>1__state  /*0x04000413*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld CoinSpawner CoinSpawner.<SpawnCoins>d__11::<>4__this  /*0x04000415*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_00ae
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int CoinSpawner.<SpawnCoins>d__11::<>1__state  /*0x04000413*/
    IL_0021: ldloc.1
    IL_0022: ldarg.0
    IL_0023: ldfld int CoinSpawner.<SpawnCoins>d__11::amount  /*0x04000416*/
    IL_0028: stfld int CoinSpawner::coinsLeft  /*0x04000411*/
    IL_002d: ldarg.0
    IL_002e: ldarg.0
    IL_002f: ldfld float CoinSpawner.<SpawnCoins>d__11::delay  /*0x04000417*/
    IL_0034: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0039: stfld WaitForSeconds CoinSpawner.<SpawnCoins>d__11::<wait>5__2  /*0x04000419*/
    IL_003e: ldarg.0
    IL_003f: ldc.i4.0
    IL_0040: stfld int CoinSpawner.<SpawnCoins>d__11::<i>5__3  /*0x0400041A*/
    IL_0045: br.s IL_00c5
    IL_0047: ldloc.1
    IL_0048: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_004d: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_0052: brtrue.s IL_0060
    IL_0054: ldstr "SpawnCoins gameObject.activeInHierarchy not inactive"
    IL_0059: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_005e: ldc.i4.0
    IL_005f: ret
    IL_0060: ldloc.1
    IL_0061: ldloc.1
    IL_0062: ldfld int CoinSpawner::coinsLeft  /*0x04000411*/
    IL_0067: ldc.i4.1
    IL_0068: sub
    IL_0069: stfld int CoinSpawner::coinsLeft  /*0x04000411*/
    IL_006e: ldloc.1
    IL_006f: ldfld GameObject CoinSpawner::coinPrefab  /*0x0400040F*/
    IL_0074: ldloc.1
    IL_0075: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_007a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_007f: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0084: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_0089: callvirt !!0 UnityEngine.GameObject::GetComponent()<Coin>  /*0x2B000029*/
    IL_008e: ldarg.0
    IL_008f: ldfld PlayerInteraction CoinSpawner.<SpawnCoins>d__11::player  /*0x04000418*/
    IL_0094: callvirt void Coin::SetTarget(PlayerInteraction)  /*0x06000340*/
    IL_0099: ldarg.0
    IL_009a: ldarg.0
    IL_009b: ldfld WaitForSeconds CoinSpawner.<SpawnCoins>d__11::<wait>5__2  /*0x04000419*/
    IL_00a0: stfld object CoinSpawner.<SpawnCoins>d__11::<>2__current  /*0x04000414*/
    IL_00a5: ldarg.0
    IL_00a6: ldc.i4.1
    IL_00a7: stfld int CoinSpawner.<SpawnCoins>d__11::<>1__state  /*0x04000413*/
    IL_00ac: ldc.i4.1
    IL_00ad: ret
    IL_00ae: ldarg.0
    IL_00af: ldc.i4.m1
    IL_00b0: stfld int CoinSpawner.<SpawnCoins>d__11::<>1__state  /*0x04000413*/
    IL_00b5: ldarg.0
    IL_00b6: ldfld int CoinSpawner.<SpawnCoins>d__11::<i>5__3  /*0x0400041A*/
    IL_00bb: stloc.2
    IL_00bc: ldarg.0
    IL_00bd: ldloc.2
    IL_00be: ldc.i4.1
    IL_00bf: add
    IL_00c0: stfld int CoinSpawner.<SpawnCoins>d__11::<i>5__3  /*0x0400041A*/
    IL_00c5: ldarg.0
    IL_00c6: ldfld int CoinSpawner.<SpawnCoins>d__11::<i>5__3  /*0x0400041A*/
    IL_00cb: ldarg.0
    IL_00cc: ldfld int CoinSpawner.<SpawnCoins>d__11::amount  /*0x04000416*/
    IL_00d1: blt IL_0047
    IL_00d6: ldc.i4.0
    IL_00d7: ret

  .method CoinSpawner.<SpawnCoins>d__11::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600034E rva 0xec44 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object CoinSpawner.<SpawnCoins>d__11::<>2__current  /*0x04000414*/
    IL_0006: ret

  .method CoinSpawner.<SpawnCoins>d__11::System.Collections.IEnumerator.Reset()  // token 0x0600034F rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method CoinSpawner.<SpawnCoins>d__11::System.Collections.IEnumerator.get_Current()  // token 0x06000350 rva 0xec44 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object CoinSpawner.<SpawnCoins>d__11::<>2__current  /*0x04000414*/
    IL_0006: ret

