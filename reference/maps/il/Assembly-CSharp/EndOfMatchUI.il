// ===== EndOfMatchUI  (token 0x02000301) =====
  .method EndOfMatchUI::Start()  // token 0x060010A5 rva 0x4c86c attrs Private, HideBySig
    // code size 81 (0x51), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject EndOfMatchUI::victoryScreen  /*0x040013C3*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: ldfld GameObject EndOfMatchUI::defeatScreen  /*0x040013C4*/
    IL_0012: ldc.i4.0
    IL_0013: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0018: ldarg.0
    IL_0019: ldfld TextMeshProUGUI EndOfMatchUI::scorePanel  /*0x040013C5*/
    IL_001e: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0023: ldc.i4.0
    IL_0024: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0029: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_002e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0033: brfalse.s IL_0050
    IL_0035: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_003a: ldfld UnityEvent LocalGamestate::OnGameStateChange  /*0x04000B48*/
    IL_003f: ldarg.0
    IL_0040: ldftn void EndOfMatchUI::GamestateHasChanged()  /*0x060010A6*/
    IL_0046: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_004b: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0050: ret

  .method EndOfMatchUI::GamestateHasChanged()  // token 0x060010A6 rva 0x4c8cc attrs Private, HideBySig
    // code size 160 (0xa0), max stack 3, init locals
    .locals ([0] LocalGamestate.State, [1] int)
    IL_0000: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0005: callvirt LocalGamestate.State LocalGamestate::get_CurrentState()  /*0x060008FD*/
    IL_000a: stloc.0
    IL_000b: ldloc.0
    IL_000c: ldc.i4.2
    IL_000d: beq.s IL_005b
    IL_000f: ldloc.0
    IL_0010: ldc.i4.3
    IL_0011: bne.un IL_009f
    IL_0016: ldarg.0
    IL_0017: ldfld GameObject EndOfMatchUI::defeatScreen  /*0x040013C4*/
    IL_001c: ldc.i4.1
    IL_001d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0022: ldarg.0
    IL_0023: ldfld TextMeshProUGUI EndOfMatchUI::scorePanel  /*0x040013C5*/
    IL_0028: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002d: ldc.i4.1
    IL_002e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0033: ldarg.0
    IL_0034: ldfld TextMeshProUGUI EndOfMatchUI::scorePanel  /*0x040013C5*/
    IL_0039: ldstr "score: "
    IL_003e: call ScoreManager ScoreManager::get_Instance()  /*0x06000D10*/
    IL_0043: callvirt int ScoreManager::get_CurrentScore()  /*0x06000D11*/
    IL_0048: stloc.1
    IL_0049: ldloca.s 1
    IL_004b: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0050: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0055: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_005a: ret
    IL_005b: ldarg.0
    IL_005c: ldfld GameObject EndOfMatchUI::victoryScreen  /*0x040013C3*/
    IL_0061: ldc.i4.1
    IL_0062: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0067: ldarg.0
    IL_0068: ldfld TextMeshProUGUI EndOfMatchUI::scorePanel  /*0x040013C5*/
    IL_006d: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0072: ldc.i4.1
    IL_0073: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0078: ldarg.0
    IL_0079: ldfld TextMeshProUGUI EndOfMatchUI::scorePanel  /*0x040013C5*/
    IL_007e: ldstr "score: "
    IL_0083: call ScoreManager ScoreManager::get_Instance()  /*0x06000D10*/
    IL_0088: callvirt int ScoreManager::get_CurrentScore()  /*0x06000D11*/
    IL_008d: stloc.1
    IL_008e: ldloca.s 1
    IL_0090: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0095: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_009a: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_009f: ret

  .method EndOfMatchUI::.ctor()  // token 0x060010A7 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

