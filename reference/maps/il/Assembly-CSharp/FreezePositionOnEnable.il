// ===== FreezePositionOnEnable  (token 0x0200016D) =====
  .method FreezePositionOnEnable::OnEnable()  // token 0x0600076C rva 0x251e8 attrs Private, HideBySig
    // code size 88 (0x58), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Transform FreezePositionOnEnable::oldParent  /*0x04000952*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_001f
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0015: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_001a: stfld Transform FreezePositionOnEnable::oldParent  /*0x04000952*/
    IL_001f: ldarg.0
    IL_0020: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0025: ldnull
    IL_0026: callvirt void UnityEngine.Transform::SetParent(UnityEngine.Transform)  /*0x0A000065*/
    IL_002b: ldarg.0
    IL_002c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0031: ldarg.0
    IL_0032: ldfld Transform FreezePositionOnEnable::oldParent  /*0x04000952*/
    IL_0037: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_003c: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0041: ldarg.0
    IL_0042: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0047: ldarg.0
    IL_0048: ldfld Transform FreezePositionOnEnable::oldParent  /*0x04000952*/
    IL_004d: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0052: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0057: ret

  .method FreezePositionOnEnable::Update()  // token 0x0600076D rva 0x2524c attrs Private, HideBySig
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Transform FreezePositionOnEnable::oldParent  /*0x04000952*/
    IL_0006: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000b: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0010: brtrue.s IL_0023
    IL_0012: ldarg.0
    IL_0013: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0018: ldarg.0
    IL_0019: ldfld Transform FreezePositionOnEnable::oldParent  /*0x04000952*/
    IL_001e: callvirt void UnityEngine.Transform::SetParent(UnityEngine.Transform)  /*0x0A000065*/
    IL_0023: ret

  .method FreezePositionOnEnable::.ctor()  // token 0x0600076E rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

