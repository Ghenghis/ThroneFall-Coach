// ===== WardrobeInteractor  (token 0x020001B0) =====
  .method WardrobeInteractor::InteractionBegin(PlayerInteraction)  // token 0x060008C9 rva 0x2a6aa attrs Public, Virtual, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldstr "Interacted with wardrobe"
    IL_0005: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_000a: call bool UIFrameManager::TryOpenWardrobe()  /*0x0600130F*/
    IL_000f: pop
    IL_0010: ret

  .method WardrobeInteractor::Focus(PlayerInteraction)  // token 0x060008CA rva 0x2a6bc attrs Public, Virtual, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject WardrobeInteractor::focusPanel  /*0x04000B08*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method WardrobeInteractor::Unfocus(PlayerInteraction)  // token 0x060008CB rva 0x2a6ca attrs Public, Virtual, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject WardrobeInteractor::focusPanel  /*0x04000B08*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method WardrobeInteractor::.ctor()  // token 0x060008CC rva 0x2743 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void InteractorBase::.ctor()  /*0x06000BEE*/
    IL_0006: ret

