// ===== BuildingFXProcessor  (token 0x02000085) =====
  .method BuildingFXProcessor::Start()  // token 0x060002A0 rva 0xbcd8 attrs Private, HideBySig
    // code size 98 (0x62), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot BuildingFXProcessor::targetBuilding  /*0x0400037B*/
    IL_0006: ldfld UnityEvent BuildSlot::OnUpgrade  /*0x040003B0*/
    IL_000b: ldarg.0
    IL_000c: ldftn void BuildingFXProcessor::OnBuildingUpgrade()  /*0x060002A1*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ldarg.0
    IL_001d: ldfld BuildSlot BuildingFXProcessor::targetBuilding  /*0x0400037B*/
    IL_0022: ldfld UnityEvent BuildSlot::OnParentUpgrade  /*0x040003B1*/
    IL_0027: ldarg.0
    IL_0028: ldftn void BuildingFXProcessor::OnParentBuildingUpgrade()  /*0x060002A2*/
    IL_002e: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0033: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0038: ldarg.0
    IL_0039: ldfld Hp BuildingFXProcessor::targetHp  /*0x0400037C*/
    IL_003e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0043: brfalse.s IL_0061
    IL_0045: ldarg.0
    IL_0046: ldfld Hp BuildingFXProcessor::targetHp  /*0x0400037C*/
    IL_004b: ldfld UnityEvent Hp::OnRevive  /*0x04000A3B*/
    IL_0050: ldarg.0
    IL_0051: ldftn void BuildingFXProcessor::OnBuildingRevive()  /*0x060002A4*/
    IL_0057: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_005c: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0061: ret

  .method BuildingFXProcessor::OnBuildingUpgrade()  // token 0x060002A1 rva 0xbd46 attrs Private, HideBySig
    // code size 52 (0x34), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot BuildingFXProcessor::targetBuilding  /*0x0400037B*/
    IL_0006: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_000b: ldc.i4.1
    IL_000c: bne.un.s IL_001a
    IL_000e: ldarg.0
    IL_000f: ldfld MMF_Player BuildingFXProcessor::onBuildFX  /*0x0400037D*/
    IL_0014: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldfld BuildSlot BuildingFXProcessor::targetBuilding  /*0x0400037B*/
    IL_0020: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0025: ldc.i4.1
    IL_0026: ble.s IL_0033
    IL_0028: ldarg.0
    IL_0029: ldfld MMF_Player BuildingFXProcessor::onUpgradeFX  /*0x0400037F*/
    IL_002e: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0033: ret

  .method BuildingFXProcessor::OnParentBuildingUpgrade()  // token 0x060002A2 rva 0xbd7b attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call IEnumerator BuildingFXProcessor::PlayDelayedParentUpgradeFeedback()  /*0x060002A3*/
    IL_0007: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_000c: pop
    IL_000d: ret

  .method BuildingFXProcessor::PlayDelayedParentUpgradeFeedback()  // token 0x060002A3 rva 0xbd8a attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::.ctor(int)  /*0x060002A6*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld BuildingFXProcessor BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::<>4__this  /*0x04000384*/
    IL_000d: ret

  .method BuildingFXProcessor::OnBuildingRevive()  // token 0x060002A4 rva 0xbd99 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MMF_Player BuildingFXProcessor::onReviveFX  /*0x04000381*/
    IL_0006: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_000b: ret

  .method BuildingFXProcessor::.ctor()  // token 0x060002A5 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== BuildingFXProcessor/<PlayDelayedParentUpgradeFeedback>d__10  (token 0x02000086) =====
  .method BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::.ctor(int)  // token 0x060002A6 rva 0xbda6 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::<>1__state  /*0x04000382*/
    IL_000d: ret

  .method BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::System.IDisposable.Dispose()  // token 0x060002A7 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::MoveNext()  // token 0x060002A8 rva 0xbdb8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 107 (0x6b), max stack 2, init locals
    .locals ([0] int, [1] BuildingFXProcessor)
    IL_0000: ldarg.0
    IL_0001: ldfld int BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::<>1__state  /*0x04000382*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld BuildingFXProcessor BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::<>4__this  /*0x04000384*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_002e
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::<>1__state  /*0x04000382*/
    IL_001e: ldarg.0
    IL_001f: ldnull
    IL_0020: stfld object BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::<>2__current  /*0x04000383*/
    IL_0025: ldarg.0
    IL_0026: ldc.i4.1
    IL_0027: stfld int BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::<>1__state  /*0x04000382*/
    IL_002c: ldc.i4.1
    IL_002d: ret
    IL_002e: ldarg.0
    IL_002f: ldc.i4.m1
    IL_0030: stfld int BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::<>1__state  /*0x04000382*/
    IL_0035: ldloc.1
    IL_0036: ldfld BuildSlot BuildingFXProcessor::targetBuilding  /*0x0400037B*/
    IL_003b: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0040: ldc.i4.1
    IL_0041: bne.un.s IL_0050
    IL_0043: ldloc.1
    IL_0044: ldfld MMF_Player BuildingFXProcessor::onParentBuildFX  /*0x0400037E*/
    IL_0049: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_004e: br.s IL_0069
    IL_0050: ldloc.1
    IL_0051: ldfld BuildSlot BuildingFXProcessor::targetBuilding  /*0x0400037B*/
    IL_0056: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_005b: ldc.i4.1
    IL_005c: ble.s IL_0069
    IL_005e: ldloc.1
    IL_005f: ldfld MMF_Player BuildingFXProcessor::onParentUpgradeFX  /*0x04000380*/
    IL_0064: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0069: ldc.i4.0
    IL_006a: ret

  .method BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060002A9 rva 0xbe2f attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::<>2__current  /*0x04000383*/
    IL_0006: ret

  .method BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::System.Collections.IEnumerator.Reset()  // token 0x060002AA rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::System.Collections.IEnumerator.get_Current()  // token 0x060002AB rva 0xbe2f attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BuildingFXProcessor.<PlayDelayedParentUpgradeFeedback>d__10::<>2__current  /*0x04000383*/
    IL_0006: ret

