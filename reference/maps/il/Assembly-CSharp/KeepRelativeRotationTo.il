// ===== KeepRelativeRotationTo  (token 0x02000030) =====
  .method KeepRelativeRotationTo::PrepareData()  // token 0x060000FD rva 0x5e38 attrs Private, HideBySig
    // code size 136 (0x88), max stack 3, init locals
    .locals ([0] Matrix4x4)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_000b: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0010: brfalse.s IL_0059
    IL_0012: ldarg.0
    IL_0013: ldarg.0
    IL_0014: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0019: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_001e: stfld Vector3 KeepRelativeRotationTo::selfPosition  /*0x04000126*/
    IL_0023: ldarg.0
    IL_0024: ldarg.0
    IL_0025: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002a: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_002f: callvirt Matrix4x4 UnityEngine.Transform::get_worldToLocalMatrix()  /*0x0A0000A4*/
    IL_0034: stloc.0
    IL_0035: ldloca.s 0
    IL_0037: ldarg.0
    IL_0038: ldfld Transform KeepRelativeRotationTo::transformToKeepRelativeRotationTo  /*0x04000123*/
    IL_003d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0042: call Vector3 UnityEngine.Matrix4x4::MultiplyPoint(UnityEngine.Vector3)  /*0x0A0000A5*/
    IL_0047: stfld Vector3 KeepRelativeRotationTo::otherPosition  /*0x04000127*/
    IL_004c: ldarg.0
    IL_004d: ldarg.0
    IL_004e: ldfld Vector3 KeepRelativeRotationTo::upVector  /*0x04000124*/
    IL_0053: stfld Vector3 KeepRelativeRotationTo::upVectorAdjusted  /*0x04000129*/
    IL_0058: ret
    IL_0059: ldarg.0
    IL_005a: ldarg.0
    IL_005b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0060: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0065: stfld Vector3 KeepRelativeRotationTo::selfPosition  /*0x04000126*/
    IL_006a: ldarg.0
    IL_006b: ldarg.0
    IL_006c: ldfld Transform KeepRelativeRotationTo::transformToKeepRelativeRotationTo  /*0x04000123*/
    IL_0071: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0076: stfld Vector3 KeepRelativeRotationTo::otherPosition  /*0x04000127*/
    IL_007b: ldarg.0
    IL_007c: ldarg.0
    IL_007d: ldfld Vector3 KeepRelativeRotationTo::upVector  /*0x04000124*/
    IL_0082: stfld Vector3 KeepRelativeRotationTo::upVectorAdjusted  /*0x04000129*/
    IL_0087: ret

  .method KeepRelativeRotationTo::Start()  // token 0x060000FE rva 0x5ecc attrs Private, HideBySig
    // code size 165 (0xa5), max stack 3, init locals
    .locals ([0] Matrix4x4)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_000b: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0010: brfalse.s IL_0066
    IL_0012: ldarg.0
    IL_0013: ldarg.0
    IL_0014: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0019: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_001e: stloc.0
    IL_001f: ldloca.s 0
    IL_0021: ldarg.0
    IL_0022: ldfld Vector3 KeepRelativeRotationTo::upVector  /*0x04000124*/
    IL_0027: call Vector3 UnityEngine.Matrix4x4::MultiplyVector(UnityEngine.Vector3)  /*0x0A0000A7*/
    IL_002c: stfld Vector3 KeepRelativeRotationTo::upVector  /*0x04000124*/
    IL_0031: ldarg.0
    IL_0032: ldarg.0
    IL_0033: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0038: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_003d: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_0042: stloc.0
    IL_0043: ldloca.s 0
    IL_0045: ldarg.0
    IL_0046: ldfld Vector3 KeepRelativeRotationTo::upVector  /*0x04000124*/
    IL_004b: call Vector3 UnityEngine.Matrix4x4::MultiplyVector(UnityEngine.Vector3)  /*0x0A0000A7*/
    IL_0050: stfld Vector3 KeepRelativeRotationTo::upVector  /*0x04000124*/
    IL_0055: ldarg.0
    IL_0056: ldarg.0
    IL_0057: ldflda Vector3 KeepRelativeRotationTo::upVector  /*0x04000124*/
    IL_005c: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_0061: stfld Vector3 KeepRelativeRotationTo::upVector  /*0x04000124*/
    IL_0066: ldarg.0
    IL_0067: ldarg.0
    IL_0068: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_006d: callvirt Quaternion UnityEngine.Transform::get_localRotation()  /*0x0A00008D*/
    IL_0072: stfld Quaternion KeepRelativeRotationTo::localRotationStart  /*0x04000128*/
    IL_0077: ldarg.0
    IL_0078: call void KeepRelativeRotationTo::PrepareData()  /*0x060000FD*/
    IL_007d: ldarg.0
    IL_007e: ldarg.0
    IL_007f: ldfld Vector3 KeepRelativeRotationTo::otherPosition  /*0x04000127*/
    IL_0084: ldarg.0
    IL_0085: ldfld Vector3 KeepRelativeRotationTo::selfPosition  /*0x04000126*/
    IL_008a: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_008f: ldarg.0
    IL_0090: ldfld Vector3 KeepRelativeRotationTo::upVectorAdjusted  /*0x04000129*/
    IL_0095: call Quaternion UnityEngine.Quaternion::LookRotation(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000070*/
    IL_009a: call Quaternion UnityEngine.Quaternion::Inverse(UnityEngine.Quaternion)  /*0x0A0000A8*/
    IL_009f: stfld Quaternion KeepRelativeRotationTo::initialOffset  /*0x04000125*/
    IL_00a4: ret

  .method KeepRelativeRotationTo::Update()  // token 0x060000FF rva 0x5f80 attrs Private, HideBySig
    // code size 84 (0x54), max stack 3, init locals
    .locals ([0] Quaternion)
    IL_0000: ldarg.0
    IL_0001: ldfld Transform KeepRelativeRotationTo::transformToKeepRelativeRotationTo  /*0x04000123*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: call void KeepRelativeRotationTo::PrepareData()  /*0x060000FD*/
    IL_0014: ldarg.0
    IL_0015: ldfld Vector3 KeepRelativeRotationTo::otherPosition  /*0x04000127*/
    IL_001a: ldarg.0
    IL_001b: ldfld Vector3 KeepRelativeRotationTo::selfPosition  /*0x04000126*/
    IL_0020: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0025: ldarg.0
    IL_0026: ldfld Vector3 KeepRelativeRotationTo::upVectorAdjusted  /*0x04000129*/
    IL_002b: call Quaternion UnityEngine.Quaternion::LookRotation(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000070*/
    IL_0030: stloc.0
    IL_0031: ldarg.0
    IL_0032: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0037: ldloc.0
    IL_0038: ldarg.0
    IL_0039: ldfld Quaternion KeepRelativeRotationTo::initialOffset  /*0x04000125*/
    IL_003e: call Quaternion UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Quaternion)  /*0x0A00007F*/
    IL_0043: ldarg.0
    IL_0044: ldfld Quaternion KeepRelativeRotationTo::localRotationStart  /*0x04000128*/
    IL_0049: call Quaternion UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Quaternion)  /*0x0A00007F*/
    IL_004e: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_0053: ret

  .method KeepRelativeRotationTo::.ctor()  // token 0x06000100 rva 0x5fe0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0006: stfld Vector3 KeepRelativeRotationTo::upVector  /*0x04000124*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

