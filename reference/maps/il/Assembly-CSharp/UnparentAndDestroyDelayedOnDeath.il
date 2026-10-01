// ===== UnparentAndDestroyDelayedOnDeath  (token 0x0200017E) =====
  .method UnparentAndDestroyDelayedOnDeath::Start()  // token 0x060007A4 rva 0x25ce2 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Hp UnparentAndDestroyDelayedOnDeath::target  /*0x04000997*/
    IL_0006: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_000b: ldarg.0
    IL_000c: ldftn void UnparentAndDestroyDelayedOnDeath::Trigger()  /*0x060007A5*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method UnparentAndDestroyDelayedOnDeath::Trigger()  // token 0x060007A5 rva 0x25d00 attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: ldnull
    IL_0007: callvirt void UnityEngine.Transform::set_parent(UnityEngine.Transform)  /*0x0A0000E2*/
    IL_000c: ldarg.0
    IL_000d: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0012: ldarg.0
    IL_0013: ldfld float UnparentAndDestroyDelayedOnDeath::extraLifetime  /*0x04000998*/
    IL_0018: call void UnityEngine.Object::Destroy(UnityEngine.Object,float)  /*0x0A000077*/
    IL_001d: ret

  .method UnparentAndDestroyDelayedOnDeath::.ctor()  // token 0x060007A6 rva 0x25d1f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 4f
    IL_0006: stfld float UnparentAndDestroyDelayedOnDeath::extraLifetime  /*0x04000998*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

