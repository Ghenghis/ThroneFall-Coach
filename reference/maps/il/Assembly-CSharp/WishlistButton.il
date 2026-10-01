// ===== WishlistButton  (token 0x0200038A) =====
  .method WishlistButton::Wishlist()  // token 0x0600137C rva 0x5c3d2 attrs Public, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: ldstr "steam://openurl/https://store.steampowered.com/app/2239150/Thronefall/"
    IL_0005: call void UnityEngine.Application::OpenURL(string)  /*0x0A00076E*/
    IL_000a: ret

  .method WishlistButton::.ctor()  // token 0x0600137D rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

