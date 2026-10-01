// ===== ExplosionDamageDealer  (token 0x020000F6) =====
  .method ExplosionDamageDealer::OnEnable()  // token 0x0600052C rva 0x16b5f attrs Private, HideBySig
    // code size 57 (0x39), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ExplosionWeapon ExplosionDamageDealer::explosionWeapon  /*0x040006B9*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld ExplosionWeapon ExplosionDamageDealer::explosionWeapon  /*0x040006B9*/
    IL_0015: ldarg.0
    IL_0016: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001b: ldarg.0
    IL_001c: ldftn void ExplosionDamageDealer::PlayAttemptEffect()  /*0x0600052D*/
    IL_0022: newobj void System.Action::.ctor(object,IntPtr)  /*0x0A0000E8*/
    IL_0027: ldarg.0
    IL_0028: ldftn void ExplosionDamageDealer::PlayApplyEffect()  /*0x0600052E*/
    IL_002e: newobj void System.Action::.ctor(object,IntPtr)  /*0x0A0000E8*/
    IL_0033: callvirt void ExplosionWeapon::Explode(UnityEngine.Transform,System.Action,System.Action)  /*0x06000530*/
    IL_0038: ret

  .method ExplosionDamageDealer::PlayAttemptEffect()  // token 0x0600052D rva 0x16b99 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent ExplosionDamageDealer::knockBackAttempt  /*0x040006BA*/
    IL_0006: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_000b: ret

  .method ExplosionDamageDealer::PlayApplyEffect()  // token 0x0600052E rva 0x16ba6 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent ExplosionDamageDealer::knockBackApply  /*0x040006BB*/
    IL_0006: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_000b: ret

  .method ExplosionDamageDealer::.ctor()  // token 0x0600052F rva 0x16bb3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0006: stfld UnityEvent ExplosionDamageDealer::knockBackAttempt  /*0x040006BA*/
    IL_000b: ldarg.0
    IL_000c: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0011: stfld UnityEvent ExplosionDamageDealer::knockBackApply  /*0x040006BB*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

