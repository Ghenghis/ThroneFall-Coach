// ===== TextMirror  (token 0x02000346) =====
  .method TextMirror::Update()  // token 0x060011CB rva 0x561a6 attrs Private, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TextMeshProUGUI TextMirror::ownTMP  /*0x04001593*/
    IL_0006: ldarg.0
    IL_0007: ldfld TextMeshProUGUI TextMirror::toMirror  /*0x04001592*/
    IL_000c: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_0011: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0016: ret

  .method TextMirror::.ctor()  // token 0x060011CC rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

