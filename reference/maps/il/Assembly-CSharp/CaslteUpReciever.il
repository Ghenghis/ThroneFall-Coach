// ===== CaslteUpReciever  (token 0x02000098) =====
  .method CaslteUpReciever::Start()  // token 0x06000336 rva 0xe5c0 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot CaslteUpReciever::buildSlot  /*0x040003F5*/
    IL_0006: ldfld UnityEvent BuildSlot::OnUpgradeEarly  /*0x040003AF*/
    IL_000b: ldarg.0
    IL_000c: ldftn void CaslteUpReciever::OnBuild()  /*0x06000337*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method CaslteUpReciever::OnBuild()  // token 0x06000337 rva 0xe5de attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldsfld UpgradeCastleUp UpgradeCastleUp::instance  /*0x04000F0E*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_001c
    IL_000c: ldsfld UpgradeCastleUp UpgradeCastleUp::instance  /*0x04000F0E*/
    IL_0011: ldarg.0
    IL_0012: ldfld BuildSlot CaslteUpReciever::buildSlot  /*0x040003F5*/
    IL_0017: callvirt void UpgradeCastleUp::DecreasePriceOfWallOrTower(BuildSlot)  /*0x06000C52*/
    IL_001c: ret

  .method CaslteUpReciever::.ctor()  // token 0x06000338 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

