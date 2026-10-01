// ===== DamageIndicatorUIHandler  (token 0x020002EF) =====
  .method DamageIndicatorUIHandler::Start()  // token 0x06001035 rva 0x4a0c4 attrs Private, HideBySig
    // code size 96 (0x60), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000133*/
    IL_0006: stfld List<GameObject> DamageIndicatorUIHandler::damageIndicatorPool  /*0x0400131E*/
    IL_000b: ldarg.0
    IL_000c: ldfld Hp DamageIndicatorUIHandler::target  /*0x04001319*/
    IL_0011: ldfld UnityEvent<float> Hp::OnHPValueChanged  /*0x04000A3F*/
    IL_0016: ldarg.0
    IL_0017: ldftn void DamageIndicatorUIHandler::DamageTaken(float)  /*0x06001038*/
    IL_001d: newobj void UnityEngine.Events.UnityAction<float>::.ctor(object,IntPtr)  /*0x0A000660*/
    IL_0022: callvirt void UnityEngine.Events.UnityEvent<float>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A000661*/
    IL_0027: ldarg.0
    IL_0028: ldarg.0
    IL_0029: ldfld Hp DamageIndicatorUIHandler::target  /*0x04001319*/
    IL_002e: ldfld bool Hp::getsKnockedOutInsteadOfDying  /*0x04000A2D*/
    IL_0033: ldc.i4.0
    IL_0034: ceq
    IL_0036: stfld bool DamageIndicatorUIHandler::shouldUnparentAndDestroyOnDeath  /*0x0400131F*/
    IL_003b: ldarg.0
    IL_003c: ldfld bool DamageIndicatorUIHandler::shouldUnparentAndDestroyOnDeath  /*0x0400131F*/
    IL_0041: brfalse.s IL_005f
    IL_0043: ldarg.0
    IL_0044: ldfld Hp DamageIndicatorUIHandler::target  /*0x04001319*/
    IL_0049: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_004e: ldarg.0
    IL_004f: ldftn void DamageIndicatorUIHandler::UnparentItself()  /*0x0600103B*/
    IL_0055: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_005a: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_005f: ret

  .method DamageIndicatorUIHandler::InstantiateDamageIndicator(float)  // token 0x06001036 rva 0x4a130 attrs Private, HideBySig
    // code size 275 (0x113), max stack 5, init locals
    .locals ([0] GameObject, [1] DamageIndicatorUI, [2] List.Enumerator<GameObject>, [3] GameObject)
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse IL_0112
    IL_000f: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0014: callvirt bool SettingsManager::get_EnableUnitDamageStats()  /*0x06000DAE*/
    IL_0019: brfalse.s IL_0023
    IL_001b: ldarg.0
    IL_001c: ldfld bool DamageIndicatorUIHandler::isPlayerUnit  /*0x0400131C*/
    IL_0021: brtrue.s IL_003d
    IL_0023: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0028: callvirt bool SettingsManager::get_EnableEnemyUnitDamageStats()  /*0x06000DAF*/
    IL_002d: brfalse IL_0112
    IL_0032: ldarg.0
    IL_0033: ldfld bool DamageIndicatorUIHandler::isPlayerUnit  /*0x0400131C*/
    IL_0038: brtrue IL_0112
    IL_003d: ldnull
    IL_003e: stloc.0
    IL_003f: ldarg.0
    IL_0040: ldfld List<GameObject> DamageIndicatorUIHandler::damageIndicatorPool  /*0x0400131E*/
    IL_0045: ldsfld Predicate<GameObject> DamageIndicatorUIHandler.<>c::<>9__8_0  /*0x04001321*/
    IL_004a: dup
    IL_004b: brtrue.s IL_0064
    IL_004d: pop
    IL_004e: ldsfld DamageIndicatorUIHandler.<>c DamageIndicatorUIHandler.<>c::<>9  /*0x04001320*/
    IL_0053: ldftn bool DamageIndicatorUIHandler.<>c::<InstantiateDamageIndicator>b__8_0(UnityEngine.GameObject)  /*0x0600103F*/
    IL_0059: newobj void System.Predicate<UnityEngine.GameObject>::.ctor(object,IntPtr)  /*0x0A000662*/
    IL_005e: dup
    IL_005f: stsfld Predicate<GameObject> DamageIndicatorUIHandler.<>c::<>9__8_0  /*0x04001321*/
    IL_0064: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::RemoveAll(System.Predicate<!0>)  /*0x0A000663*/
    IL_0069: pop
    IL_006a: ldarg.0
    IL_006b: ldfld List<GameObject> DamageIndicatorUIHandler::damageIndicatorPool  /*0x0400131E*/
    IL_0070: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_0075: stloc.2
    IL_0076: br.s IL_00a9
    IL_0078: ldloca.s 2
    IL_007a: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_007f: stloc.3
    IL_0080: ldloc.3
    IL_0081: ldnull
    IL_0082: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0087: brfalse.s IL_009c
    IL_0089: ldloc.3
    IL_008a: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_008f: brtrue.s IL_00a9
    IL_0091: ldloc.3
    IL_0092: stloc.0
    IL_0093: ldloc.0
    IL_0094: ldc.i4.1
    IL_0095: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_009a: leave.s IL_00c2
    IL_009c: ldarg.0
    IL_009d: ldfld List<GameObject> DamageIndicatorUIHandler::damageIndicatorPool  /*0x0400131E*/
    IL_00a2: ldloc.3
    IL_00a3: callvirt bool System.Collections.Generic.List<UnityEngine.GameObject>::Remove(!0)  /*0x0A000664*/
    IL_00a8: pop
    IL_00a9: ldloca.s 2
    IL_00ab: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_00b0: brtrue.s IL_0078
    IL_00b2: leave.s IL_00c2
    IL_00b4: ldloca.s 2
    IL_00b6: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_00bc: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00c1: endfinally
    IL_00c2: ldloc.0
    IL_00c3: ldnull
    IL_00c4: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00c9: brfalse.s IL_00ee
    IL_00cb: ldarg.0
    IL_00cc: ldfld GameObject DamageIndicatorUIHandler::damageIndicatorUIPrefab  /*0x0400131A*/
    IL_00d1: ldarg.0
    IL_00d2: ldfld GameObject DamageIndicatorUIHandler::canvas  /*0x0400131B*/
    IL_00d7: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00dc: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_00e1: stloc.0
    IL_00e2: ldarg.0
    IL_00e3: ldfld List<GameObject> DamageIndicatorUIHandler::damageIndicatorPool  /*0x0400131E*/
    IL_00e8: ldloc.0
    IL_00e9: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_00ee: ldloc.0
    IL_00ef: callvirt !!0 UnityEngine.GameObject::GetComponent()<DamageIndicatorUI>  /*0x2B0000E5*/
    IL_00f4: stloc.1
    IL_00f5: ldloc.1
    IL_00f6: ldnull
    IL_00f7: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00fc: brfalse.s IL_0112
    IL_00fe: ldloc.1
    IL_00ff: ldarg.1
    IL_0100: ldarg.0
    IL_0101: ldfld bool DamageIndicatorUIHandler::isPlayerUnit  /*0x0400131C*/
    IL_0106: ldarg.0
    IL_0107: ldfld bool DamageIndicatorUIHandler::isBuilding  /*0x0400131D*/
    IL_010c: ldarg.0
    IL_010d: callvirt void DamageIndicatorUI::SetStat(float,bool,bool,DamageIndicatorUIHandler)  /*0x06001030*/
    IL_0112: ret
    .try IL_0076-IL_00b4 finally handler IL_00b4-IL_00c2

  .method DamageIndicatorUIHandler::RemoveDamageIndicatorFromPool(UnityEngine.GameObject)  // token 0x06001037 rva 0x4a260 attrs Public, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<GameObject> DamageIndicatorUIHandler::damageIndicatorPool  /*0x0400131E*/
    IL_0006: ldarg.1
    IL_0007: callvirt bool System.Collections.Generic.List<UnityEngine.GameObject>::Remove(!0)  /*0x0A000664*/
    IL_000c: pop
    IL_000d: ret

  .method DamageIndicatorUIHandler::DamageTaken(float)  // token 0x06001038 rva 0x4a26f attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void DamageIndicatorUIHandler::InstantiateDamageIndicator(float)  /*0x06001036*/
    IL_0007: ret

  .method DamageIndicatorUIHandler::WaitForDamageUItoFinish()  // token 0x06001039 rva 0x4a278 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::.ctor(int)  /*0x06001040*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld DamageIndicatorUIHandler DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::<>4__this  /*0x04001324*/
    IL_000d: ret

  .method DamageIndicatorUIHandler::AllObjectsInactive()  // token 0x0600103A rva 0x4a288 attrs Private, HideBySig
    // code size 72 (0x48), max stack 2, init locals
    .locals ([0] List.Enumerator<GameObject>, [1] GameObject, [2] bool)
    IL_0000: ldarg.0
    IL_0001: ldfld List<GameObject> DamageIndicatorUIHandler::damageIndicatorPool  /*0x0400131E*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_000b: stloc.0
    IL_000c: br.s IL_002b
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_0015: stloc.1
    IL_0016: ldloc.1
    IL_0017: ldnull
    IL_0018: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001d: brfalse.s IL_002b
    IL_001f: ldloc.1
    IL_0020: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0025: brfalse.s IL_002b
    IL_0027: ldc.i4.0
    IL_0028: stloc.2
    IL_0029: leave.s IL_0046
    IL_002b: ldloca.s 0
    IL_002d: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_0032: brtrue.s IL_000e
    IL_0034: leave.s IL_0044
    IL_0036: ldloca.s 0
    IL_0038: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_003e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0043: endfinally
    IL_0044: ldc.i4.1
    IL_0045: ret
    IL_0046: ldloc.2
    IL_0047: ret
    .try IL_000c-IL_0036 finally handler IL_0036-IL_0044

  .method DamageIndicatorUIHandler::UnparentItself()  // token 0x0600103B rva 0x4a2ec attrs Private, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: ldnull
    IL_0007: callvirt void UnityEngine.Transform::SetParent(UnityEngine.Transform)  /*0x0A000065*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: call IEnumerator DamageIndicatorUIHandler::WaitForDamageUItoFinish()  /*0x06001039*/
    IL_0013: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0018: pop
    IL_0019: ret

  .method DamageIndicatorUIHandler::.ctor()  // token 0x0600103C rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== DamageIndicatorUIHandler/<>c  (token 0x020002F0) =====
  .method DamageIndicatorUIHandler.<>c::.cctor()  // token 0x0600103D rva 0x4a307 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void DamageIndicatorUIHandler.<>c::.ctor()  /*0x0600103E*/
    IL_0005: stsfld DamageIndicatorUIHandler.<>c DamageIndicatorUIHandler.<>c::<>9  /*0x04001320*/
    IL_000a: ret

  .method DamageIndicatorUIHandler.<>c::.ctor()  // token 0x0600103E rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method DamageIndicatorUIHandler.<>c::<InstantiateDamageIndicator>b__8_0(UnityEngine.GameObject)  // token 0x0600103F rva 0x4a313 attrs Assembly, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldnull
    IL_0002: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0007: ret

// ===== DamageIndicatorUIHandler/<WaitForDamageUItoFinish>d__11  (token 0x020002F1) =====
  .method DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::.ctor(int)  // token 0x06001040 rva 0x4a31c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::<>1__state  /*0x04001322*/
    IL_000d: ret

  .method DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::System.IDisposable.Dispose()  // token 0x06001041 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::MoveNext()  // token 0x06001042 rva 0x4a32c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 76 (0x4c), max stack 2, init locals
    .locals ([0] int, [1] DamageIndicatorUIHandler)
    IL_0000: ldarg.0
    IL_0001: ldfld int DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::<>1__state  /*0x04001322*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld DamageIndicatorUIHandler DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::<>4__this  /*0x04001324*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0030
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::<>1__state  /*0x04001322*/
    IL_001e: br.s IL_0037
    IL_0020: ldarg.0
    IL_0021: ldnull
    IL_0022: stfld object DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::<>2__current  /*0x04001323*/
    IL_0027: ldarg.0
    IL_0028: ldc.i4.1
    IL_0029: stfld int DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::<>1__state  /*0x04001322*/
    IL_002e: ldc.i4.1
    IL_002f: ret
    IL_0030: ldarg.0
    IL_0031: ldc.i4.m1
    IL_0032: stfld int DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::<>1__state  /*0x04001322*/
    IL_0037: ldloc.1
    IL_0038: call bool DamageIndicatorUIHandler::AllObjectsInactive()  /*0x0600103A*/
    IL_003d: brfalse.s IL_0020
    IL_003f: ldloc.1
    IL_0040: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0045: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_004a: ldc.i4.0
    IL_004b: ret

  .method DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06001043 rva 0x4a384 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::<>2__current  /*0x04001323*/
    IL_0006: ret

  .method DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::System.Collections.IEnumerator.Reset()  // token 0x06001044 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::System.Collections.IEnumerator.get_Current()  // token 0x06001045 rva 0x4a384 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object DamageIndicatorUIHandler.<WaitForDamageUItoFinish>d__11::<>2__current  /*0x04001323*/
    IL_0006: ret

