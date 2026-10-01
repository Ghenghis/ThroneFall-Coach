// ===== FakeChildTo  (token 0x02000162) =====
  .method FakeChildTo::Start()  // token 0x0600073A rva 0x246aa attrs Private, HideBySig
    // code size 53 (0x35), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_000c: stfld Vector3 FakeChildTo::offset  /*0x0400091C*/
    IL_0011: ldarg.0
    IL_0012: ldfld bool FakeChildTo::unparentAtStart  /*0x04000918*/
    IL_0017: brfalse.s IL_0025
    IL_0019: ldarg.0
    IL_001a: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001f: ldnull
    IL_0020: callvirt void UnityEngine.Transform::SetParent(UnityEngine.Transform)  /*0x0A000065*/
    IL_0025: ldarg.0
    IL_0026: ldfld bool FakeChildTo::disableThisComponentAfterStart  /*0x04000919*/
    IL_002b: brfalse.s IL_0034
    IL_002d: ldarg.0
    IL_002e: ldc.i4.0
    IL_002f: call void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0034: ret

  .method FakeChildTo::Update()  // token 0x0600073B rva 0x246e0 attrs Private, HideBySig
    // code size 85 (0x55), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Transform FakeChildTo::fakeParent  /*0x04000917*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_0033
    IL_000d: ldarg.0
    IL_000e: ldfld UnityEvent FakeChildTo::onDestroy  /*0x0400091B*/
    IL_0013: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0018: ldarg.0
    IL_0019: ldfld bool FakeChildTo::destroyWhenParentIsDestroyed  /*0x0400091A*/
    IL_001e: brfalse.s IL_002c
    IL_0020: ldarg.0
    IL_0021: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0026: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_002b: ret
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0032: ret
    IL_0033: ldarg.0
    IL_0034: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0039: ldarg.0
    IL_003a: ldfld Transform FakeChildTo::fakeParent  /*0x04000917*/
    IL_003f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0044: ldarg.0
    IL_0045: ldfld Vector3 FakeChildTo::offset  /*0x0400091C*/
    IL_004a: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_004f: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0054: ret

  .method FakeChildTo::.ctor()  // token 0x0600073C rva 0x24741 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool FakeChildTo::unparentAtStart  /*0x04000918*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: stfld bool FakeChildTo::destroyWhenParentIsDestroyed  /*0x0400091A*/
    IL_000e: ldarg.0
    IL_000f: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0014: ret

