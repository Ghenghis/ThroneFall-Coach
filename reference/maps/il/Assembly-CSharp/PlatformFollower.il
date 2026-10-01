// ===== PlatformFollower  (token 0x02000106) =====
  .method PlatformFollower::Start()  // token 0x06000567 rva 0x1764c attrs Private, HideBySig
    // code size 72 (0x48), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000c: ldarg.0
    IL_000d: ldfld Transform PlatformFollower::platform  /*0x040006F5*/
    IL_0012: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0017: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_001c: stfld Vector3 PlatformFollower::_positionOffset  /*0x040006F6*/
    IL_0021: ldarg.0
    IL_0022: ldarg.0
    IL_0023: ldfld Transform PlatformFollower::platform  /*0x040006F5*/
    IL_0028: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_002d: call Quaternion UnityEngine.Quaternion::Inverse(UnityEngine.Quaternion)  /*0x0A0000A8*/
    IL_0032: ldarg.0
    IL_0033: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0038: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_003d: call Quaternion UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Quaternion)  /*0x0A00007F*/
    IL_0042: stfld Quaternion PlatformFollower::_rotationOffset  /*0x040006F7*/
    IL_0047: ret

  .method PlatformFollower::OnEnable()  // token 0x06000568 rva 0x176a0 attrs Private, HideBySig
    // code size 83 (0x53), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: ldarg.0
    IL_0007: ldfld Transform PlatformFollower::platform  /*0x040006F5*/
    IL_000c: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0011: ldarg.0
    IL_0012: ldfld Quaternion PlatformFollower::_rotationOffset  /*0x040006F7*/
    IL_0017: call Quaternion UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Quaternion)  /*0x0A00007F*/
    IL_001c: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0021: ldarg.0
    IL_0022: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0027: ldarg.0
    IL_0028: ldfld Transform PlatformFollower::platform  /*0x040006F5*/
    IL_002d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0032: ldarg.0
    IL_0033: ldfld Transform PlatformFollower::platform  /*0x040006F5*/
    IL_0038: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_003d: ldarg.0
    IL_003e: ldfld Vector3 PlatformFollower::_positionOffset  /*0x040006F6*/
    IL_0043: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_0048: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_004d: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0052: ret

  .method PlatformFollower::LateUpdate()  // token 0x06000569 rva 0x17700 attrs Private, HideBySig
    // code size 83 (0x53), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: ldarg.0
    IL_0007: ldfld Transform PlatformFollower::platform  /*0x040006F5*/
    IL_000c: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0011: ldarg.0
    IL_0012: ldfld Quaternion PlatformFollower::_rotationOffset  /*0x040006F7*/
    IL_0017: call Quaternion UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Quaternion)  /*0x0A00007F*/
    IL_001c: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0021: ldarg.0
    IL_0022: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0027: ldarg.0
    IL_0028: ldfld Transform PlatformFollower::platform  /*0x040006F5*/
    IL_002d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0032: ldarg.0
    IL_0033: ldfld Transform PlatformFollower::platform  /*0x040006F5*/
    IL_0038: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_003d: ldarg.0
    IL_003e: ldfld Vector3 PlatformFollower::_positionOffset  /*0x040006F6*/
    IL_0043: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_0048: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_004d: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0052: ret

  .method PlatformFollower::.ctor()  // token 0x0600056A rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

