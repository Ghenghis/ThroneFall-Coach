// ===== VersionNumberDisplay  (token 0x0200037A) =====
  .method VersionNumberDisplay::OnEnable()  // token 0x0600132B rva 0x5b446 attrs Private, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TextMeshProUGUI VersionNumberDisplay::display  /*0x0400172D*/
    IL_0006: ldstr "version "
    IL_000b: call string UnityEngine.Application::get_version()  /*0x0A000757*/
    IL_0010: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0015: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_001a: ret

  .method VersionNumberDisplay::.ctor()  // token 0x0600132C rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

