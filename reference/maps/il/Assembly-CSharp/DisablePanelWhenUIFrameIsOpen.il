// ===== DisablePanelWhenUIFrameIsOpen  (token 0x020002F5) =====
  .method DisablePanelWhenUIFrameIsOpen::Start()  // token 0x0600104E rva 0x4a4f5 attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.Canvas>  /*0x2B0000E6*/
    IL_0007: stfld Canvas DisablePanelWhenUIFrameIsOpen::targetCanvas  /*0x0400132C*/
    IL_000c: ret

  .method DisablePanelWhenUIFrameIsOpen::Update()  // token 0x0600104F rva 0x4a503 attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Canvas DisablePanelWhenUIFrameIsOpen::targetCanvas  /*0x0400132C*/
    IL_0006: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_000b: callvirt UIFrame UIFrameManager::get_ActiveFrame()  /*0x060012F9*/
    IL_0010: ldnull
    IL_0011: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0016: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_001b: ret

  .method DisablePanelWhenUIFrameIsOpen::.ctor()  // token 0x06001050 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

