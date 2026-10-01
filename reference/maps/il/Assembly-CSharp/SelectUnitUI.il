// ===== SelectUnitUI  (token 0x0200033F) =====
  .method SelectUnitUI::UpdateState(bool,UnityEngine.Sprite,float)  // token 0x060011B8 rva 0x55c4a attrs Public, HideBySig
    // code size 48 (0x30), max stack 8
    IL_0000: ldarg.3
    IL_0001: ldc.r4 0.99f
    IL_0006: ble.un.s IL_000b
    IL_0008: ldc.i4.0
    IL_0009: starg.s 1
    IL_000b: ldarg.0
    IL_000c: ldfld GameObject SelectUnitUI::canvas  /*0x04001575*/
    IL_0011: ldarg.1
    IL_0012: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0017: ldarg.0
    IL_0018: ldfld Image SelectUnitUI::image  /*0x04001576*/
    IL_001d: ldarg.2
    IL_001e: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0023: ldarg.0
    IL_0024: ldfld MPImage SelectUnitUI::mpImage  /*0x04001577*/
    IL_0029: ldarg.3
    IL_002a: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_002f: ret

  .method SelectUnitUI::.ctor()  // token 0x060011B9 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

