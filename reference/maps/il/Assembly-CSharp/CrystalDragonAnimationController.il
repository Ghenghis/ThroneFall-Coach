// ===== CrystalDragonAnimationController  (token 0x020000D5) =====
  .method CrystalDragonAnimationController::Start()  // token 0x06000468 rva 0x13914 attrs Private, HideBySig
    // code size 253 (0xfd), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld CrystalDragonPhasing CrystalDragonAnimationController::crystalDragonPhases  /*0x0400059C*/
    IL_0006: ldfld UnityEvent CrystalDragonPhasing::FlyEvent  /*0x040005C8*/
    IL_000b: ldarg.0
    IL_000c: ldftn void CrystalDragonAnimationController::OnFlyEvent()  /*0x06000469*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ldarg.0
    IL_001d: ldfld CrystalDragonPhasing CrystalDragonAnimationController::crystalDragonPhases  /*0x0400059C*/
    IL_0022: ldfld UnityEvent<int> CrystalDragonPhasing::ChangePhaseEvent  /*0x040005C9*/
    IL_0027: ldarg.0
    IL_0028: ldftn void CrystalDragonAnimationController::OnChangePhaseEvent(int)  /*0x0600046A*/
    IL_002e: newobj void UnityEngine.Events.UnityAction<int>::.ctor(object,IntPtr)  /*0x0A000204*/
    IL_0033: callvirt void UnityEngine.Events.UnityEvent<int>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A000205*/
    IL_0038: ldarg.0
    IL_0039: ldfld CrystalDragonPhasing CrystalDragonAnimationController::crystalDragonPhases  /*0x0400059C*/
    IL_003e: ldfld UnityEvent CrystalDragonPhasing::CrystalStompAttackTrigger  /*0x040005C1*/
    IL_0043: ldarg.0
    IL_0044: ldftn void CrystalDragonAnimationController::OnCrystalStompAttackTrigger()  /*0x0600046B*/
    IL_004a: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_004f: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0054: ldarg.0
    IL_0055: ldfld CrystalDragonPhasing CrystalDragonAnimationController::crystalDragonPhases  /*0x0400059C*/
    IL_005a: ldfld UnityEvent CrystalDragonPhasing::BellySmashAttackTrigger  /*0x040005C2*/
    IL_005f: ldarg.0
    IL_0060: ldftn void CrystalDragonAnimationController::OnBellySmashAttackTrigger()  /*0x0600046C*/
    IL_0066: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_006b: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0070: ldarg.0
    IL_0071: ldfld CrystalDragonPhasing CrystalDragonAnimationController::crystalDragonPhases  /*0x0400059C*/
    IL_0076: ldfld UnityEvent CrystalDragonPhasing::FlameSpitterBeforeAttackTrigger  /*0x040005C3*/
    IL_007b: ldarg.0
    IL_007c: ldftn void CrystalDragonAnimationController::OnFlameSpitterBeforeAttackTrigger()  /*0x0600046D*/
    IL_0082: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0087: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_008c: ldarg.0
    IL_008d: ldfld CrystalDragonPhasing CrystalDragonAnimationController::crystalDragonPhases  /*0x0400059C*/
    IL_0092: ldfld UnityEvent CrystalDragonPhasing::FlameSpitterActualAttackTrigger  /*0x040005C4*/
    IL_0097: ldarg.0
    IL_0098: ldftn void CrystalDragonAnimationController::OnFlameSpitterActualAttackTrigger()  /*0x0600046E*/
    IL_009e: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00a3: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00a8: ldarg.0
    IL_00a9: ldfld CrystalDragonPhasing CrystalDragonAnimationController::crystalDragonPhases  /*0x0400059C*/
    IL_00ae: ldfld UnityEvent CrystalDragonPhasing::FireballAttackTrigger  /*0x040005C5*/
    IL_00b3: ldarg.0
    IL_00b4: ldftn void CrystalDragonAnimationController::OnFireballAttackTrigger()  /*0x0600046F*/
    IL_00ba: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00bf: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00c4: ldarg.0
    IL_00c5: ldfld CrystalDragonPhasing CrystalDragonAnimationController::crystalDragonPhases  /*0x0400059C*/
    IL_00ca: ldfld UnityEvent CrystalDragonPhasing::FireTrailAttackTrigger  /*0x040005C6*/
    IL_00cf: ldarg.0
    IL_00d0: ldftn void CrystalDragonAnimationController::OnFireTrailAttackTrigger()  /*0x06000470*/
    IL_00d6: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00db: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00e0: ldarg.0
    IL_00e1: ldfld CrystalDragonPhasing CrystalDragonAnimationController::crystalDragonPhases  /*0x0400059C*/
    IL_00e6: ldfld UnityEvent CrystalDragonPhasing::MinionsSpawnTrigger  /*0x040005C7*/
    IL_00eb: ldarg.0
    IL_00ec: ldftn void CrystalDragonAnimationController::OnMinionsSpawnTrigger()  /*0x06000471*/
    IL_00f2: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00f7: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00fc: ret

  .method CrystalDragonAnimationController::OnFlyEvent()  // token 0x06000469 rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CrystalDragonAnimationController::OnChangePhaseEvent(int)  // token 0x0600046A rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CrystalDragonAnimationController::OnCrystalStompAttackTrigger()  // token 0x0600046B rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CrystalDragonAnimationController::OnBellySmashAttackTrigger()  // token 0x0600046C rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CrystalDragonAnimationController::OnFlameSpitterBeforeAttackTrigger()  // token 0x0600046D rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CrystalDragonAnimationController::OnFlameSpitterActualAttackTrigger()  // token 0x0600046E rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CrystalDragonAnimationController::OnFireballAttackTrigger()  // token 0x0600046F rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CrystalDragonAnimationController::OnFireTrailAttackTrigger()  // token 0x06000470 rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CrystalDragonAnimationController::OnMinionsSpawnTrigger()  // token 0x06000471 rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CrystalDragonAnimationController::.ctor()  // token 0x06000472 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

