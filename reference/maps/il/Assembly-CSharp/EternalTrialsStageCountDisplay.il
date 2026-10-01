// ===== EternalTrialsStageCountDisplay  (token 0x0200030B) =====
  .method EternalTrialsStageCountDisplay::OnEnable()  // token 0x060010D5 rva 0x4db81 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void EternalTrialsStageCountDisplay::Refresh()  /*0x060010D6*/
    IL_0006: ret

  .method EternalTrialsStageCountDisplay::Refresh()  // token 0x060010D6 rva 0x4db8c attrs Public, HideBySig
    // code size 65 (0x41), max stack 3, init locals
    .locals ([0] int)
    IL_0000: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_0005: ldc.i4.1
    IL_0006: bne.un.s IL_0034
    IL_0008: ldarg.0
    IL_0009: ldfld GameObject EternalTrialsStageCountDisplay::toggleObj  /*0x040013FB*/
    IL_000e: ldc.i4.1
    IL_000f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0014: ldarg.0
    IL_0015: ldfld TextMeshProUGUI EternalTrialsStageCountDisplay::targetDisplay  /*0x040013FC*/
    IL_001a: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_001f: ldfld int EternalTrialsRun::stage  /*0x0400084F*/
    IL_0024: ldc.i4.1
    IL_0025: add
    IL_0026: stloc.0
    IL_0027: ldloca.s 0
    IL_0029: call string System.Int32::ToString()  /*0x0A000031*/
    IL_002e: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0033: ret
    IL_0034: ldarg.0
    IL_0035: ldfld GameObject EternalTrialsStageCountDisplay::toggleObj  /*0x040013FB*/
    IL_003a: ldc.i4.0
    IL_003b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0040: ret

  .method EternalTrialsStageCountDisplay::.ctor()  // token 0x060010D7 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

