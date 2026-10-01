// ===== ScoreTag  (token 0x0200033B) =====
  .method ScoreTag::SetNameAndScore(string,int,int,bool)  // token 0x060011AA rva 0x55874 attrs Public, HideBySig
    // code size 72 (0x48), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ScoreTag::highlight  /*0x04001561*/
    IL_0006: ldarg.s 4
    IL_0008: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000d: ldarg.0
    IL_000e: ldfld TMP_Text ScoreTag::rank  /*0x04001562*/
    IL_0013: ldarga.s 3
    IL_0015: call string System.Int32::ToString()  /*0x0A000031*/
    IL_001a: ldstr "."
    IL_001f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0024: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0029: ldarg.0
    IL_002a: ldfld TMP_Text ScoreTag::username  /*0x04001563*/
    IL_002f: ldarg.1
    IL_0030: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0035: ldarg.0
    IL_0036: ldfld TMP_Text ScoreTag::score  /*0x04001564*/
    IL_003b: ldarga.s 2
    IL_003d: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0042: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0047: ret

  .method ScoreTag::.ctor()  // token 0x060011AB rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

