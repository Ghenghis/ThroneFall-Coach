// ===== GateOpener  (token 0x02000183) =====
  .method GateOpener::get_isDoor()  // token 0x060007CE rva 0x262ff attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GateOpener.Mode GateOpener::mode  /*0x040009B0*/
    IL_0006: ldc.i4.0
    IL_0007: ceq
    IL_0009: ret

  .method GateOpener::get_isBars()  // token 0x060007CF rva 0x2630a attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GateOpener.Mode GateOpener::mode  /*0x040009B0*/
    IL_0006: ldc.i4.1
    IL_0007: ceq
    IL_0009: ret

  .method GateOpener::Start()  // token 0x060007D0 rva 0x26318 attrs Private, HideBySig
    // code size 167 (0xa7), max stack 2, init locals
    .locals ([0] Quaternion)
    IL_0000: ldarg.0
    IL_0001: ldfld Transform GateOpener::doorL  /*0x040009B1*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0026
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld Transform GateOpener::doorL  /*0x040009B1*/
    IL_0014: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0019: stloc.0
    IL_001a: ldloca.s 0
    IL_001c: call Vector3 UnityEngine.Quaternion::get_eulerAngles()  /*0x0A0000B9*/
    IL_0021: stfld Vector3 GateOpener::doorLInitRotation  /*0x040009BC*/
    IL_0026: ldarg.0
    IL_0027: ldfld Transform GateOpener::doorR  /*0x040009B2*/
    IL_002c: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0031: brfalse.s IL_004c
    IL_0033: ldarg.0
    IL_0034: ldarg.0
    IL_0035: ldfld Transform GateOpener::doorR  /*0x040009B2*/
    IL_003a: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_003f: stloc.0
    IL_0040: ldloca.s 0
    IL_0042: call Vector3 UnityEngine.Quaternion::get_eulerAngles()  /*0x0A0000B9*/
    IL_0047: stfld Vector3 GateOpener::doorRInitRotation  /*0x040009BD*/
    IL_004c: ldarg.0
    IL_004d: ldfld Transform GateOpener::bars  /*0x040009B4*/
    IL_0052: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0057: brfalse.s IL_006f
    IL_0059: ldarg.0
    IL_005a: ldarg.0
    IL_005b: ldfld Transform GateOpener::bars  /*0x040009B4*/
    IL_0060: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0065: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_006a: stfld Vector3 GateOpener::barsInitPosition  /*0x040009BE*/
    IL_006f: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0074: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0079: brtrue.s IL_0086
    IL_007b: ldstr "No Tag Manager in scene."
    IL_0080: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0085: ret
    IL_0086: ldarg.0
    IL_0087: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_008c: callvirt IReadOnlyList<TaggedObject> TagManager::get_PlayerUnits()  /*0x06000E52*/
    IL_0091: stfld IReadOnlyList<TaggedObject> GateOpener::playerUnits  /*0x040009BA*/
    IL_0096: ldarg.0
    IL_0097: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_009c: callvirt IReadOnlyList<TaggedObject> TagManager::get_Players()  /*0x06000E54*/
    IL_00a1: stfld IReadOnlyList<TaggedObject> GateOpener::players  /*0x040009BB*/
    IL_00a6: ret

  .method GateOpener::Update()  // token 0x060007D1 rva 0x263cc attrs Private, HideBySig
    // code size 935 (0x3a7), max stack 5, init locals
    .locals ([0] int, [1] int, [2] TaggedObject, [3] Vector3, [4] bool, [5] int, [6] int, [7] int, [8] int, [9] float, [10] GateOpener.Mode)
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brtrue.s IL_000d
    IL_000c: ret
    IL_000d: ldarg.0
    IL_000e: ldfld IReadOnlyList<TaggedObject> GateOpener::playerUnits  /*0x040009BA*/
    IL_0013: callvirt int System.Collections.Generic.IReadOnlyCollection<TaggedObject>::get_Count()  /*0x0A0003A7*/
    IL_0018: stloc.0
    IL_0019: ldarg.0
    IL_001a: ldfld IReadOnlyList<TaggedObject> GateOpener::players  /*0x040009BB*/
    IL_001f: callvirt int System.Collections.Generic.IReadOnlyCollection<TaggedObject>::get_Count()  /*0x0A0003A7*/
    IL_0024: stloc.1
    IL_0025: ldarg.0
    IL_0026: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0030: stloc.3
    IL_0031: ldarg.0
    IL_0032: ldarg.0
    IL_0033: ldfld float GateOpener::checkOpenCloseStateCooldown  /*0x040009C0*/
    IL_0038: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_003d: sub
    IL_003e: stfld float GateOpener::checkOpenCloseStateCooldown  /*0x040009C0*/
    IL_0043: ldarg.0
    IL_0044: ldfld float GateOpener::checkOpenCloseStateCooldown  /*0x040009C0*/
    IL_0049: ldc.r4 0f
    IL_004e: bgt.un IL_0269
    IL_0053: ldarg.0
    IL_0054: ldc.r4 0.33f
    IL_0059: stfld float GateOpener::checkOpenCloseStateCooldown  /*0x040009C0*/
    IL_005e: ldarg.0
    IL_005f: ldfld bool GateOpener::open  /*0x040009B7*/
    IL_0064: brfalse IL_0171
    IL_0069: ldc.i4.1
    IL_006a: stloc.s 4
    IL_006c: ldc.i4.0
    IL_006d: stloc.s 5
    IL_006f: br IL_00f5
    IL_0074: ldarg.0
    IL_0075: ldfld IReadOnlyList<TaggedObject> GateOpener::playerUnits  /*0x040009BA*/
    IL_007a: ldloc.s 5
    IL_007c: callvirt !0 System.Collections.Generic.IReadOnlyList<TaggedObject>::get_Item(int)  /*0x0A00019F*/
    IL_0081: stloc.2
    IL_0082: ldloc.2
    IL_0083: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0088: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_008d: brfalse.s IL_00ef
    IL_008f: ldloc.3
    IL_0090: ldloc.2
    IL_0091: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0096: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_009b: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_00a0: call float UnityEngine.Vector3::SqrMagnitude(UnityEngine.Vector3)  /*0x0A0003A8*/
    IL_00a5: ldarg.0
    IL_00a6: ldfld float GateOpener::clearDistance  /*0x040009AF*/
    IL_00ab: ldarg.0
    IL_00ac: ldfld float GateOpener::clearDistance  /*0x040009AF*/
    IL_00b1: mul
    IL_00b2: bgt.un.s IL_00ef
    IL_00b4: ldloc.2
    IL_00b5: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_00ba: ldc.i4.s 10
    IL_00bc: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_00c1: brfalse.s IL_00ef
    IL_00c3: ldloc.2
    IL_00c4: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00c9: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00ce: ldloc.2
    IL_00cf: callvirt !!0 UnityEngine.Component::GetComponent()<PathfindMovementPlayerunit>  /*0x2B00008A*/
    IL_00d4: callvirt Vector3 PathfindMovementPlayerunit::get_HomePosition()  /*0x06000B2A*/
    IL_00d9: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_00de: call float UnityEngine.Vector3::SqrMagnitude(UnityEngine.Vector3)  /*0x0A0003A8*/
    IL_00e3: ldc.r4 0.25f
    IL_00e8: blt.s IL_00ef
    IL_00ea: ldc.i4.0
    IL_00eb: stloc.s 4
    IL_00ed: br.s IL_00fd
    IL_00ef: ldloc.s 5
    IL_00f1: ldc.i4.1
    IL_00f2: add
    IL_00f3: stloc.s 5
    IL_00f5: ldloc.s 5
    IL_00f7: ldloc.0
    IL_00f8: blt IL_0074
    IL_00fd: ldc.i4.0
    IL_00fe: stloc.s 6
    IL_0100: br.s IL_015a
    IL_0102: ldarg.0
    IL_0103: ldfld IReadOnlyList<TaggedObject> GateOpener::players  /*0x040009BB*/
    IL_0108: ldloc.s 6
    IL_010a: callvirt !0 System.Collections.Generic.IReadOnlyList<TaggedObject>::get_Item(int)  /*0x0A00019F*/
    IL_010f: stloc.2
    IL_0110: ldloc.2
    IL_0111: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0116: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_011b: brfalse.s IL_0154
    IL_011d: ldloc.3
    IL_011e: ldloc.2
    IL_011f: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0124: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0129: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_012e: call float UnityEngine.Vector3::SqrMagnitude(UnityEngine.Vector3)  /*0x0A0003A8*/
    IL_0133: ldarg.0
    IL_0134: ldfld float GateOpener::openDistance  /*0x040009AE*/
    IL_0139: ldarg.0
    IL_013a: ldfld float GateOpener::openDistance  /*0x040009AE*/
    IL_013f: mul
    IL_0140: bgt.un.s IL_0154
    IL_0142: ldloc.2
    IL_0143: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0148: ldc.i4.s 10
    IL_014a: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_014f: brfalse.s IL_0154
    IL_0151: ldc.i4.0
    IL_0152: stloc.s 4
    IL_0154: ldloc.s 6
    IL_0156: ldc.i4.1
    IL_0157: add
    IL_0158: stloc.s 6
    IL_015a: ldloc.s 6
    IL_015c: ldloc.1
    IL_015d: blt.s IL_0102
    IL_015f: ldloc.s 4
    IL_0161: brfalse IL_0269
    IL_0166: ldarg.0
    IL_0167: call void GateOpener::Close()  /*0x060007D2*/
    IL_016c: br IL_0269
    IL_0171: ldc.i4.0
    IL_0172: stloc.s 7
    IL_0174: br IL_01fc
    IL_0179: ldarg.0
    IL_017a: ldfld IReadOnlyList<TaggedObject> GateOpener::playerUnits  /*0x040009BA*/
    IL_017f: ldloc.s 7
    IL_0181: callvirt !0 System.Collections.Generic.IReadOnlyList<TaggedObject>::get_Item(int)  /*0x0A00019F*/
    IL_0186: stloc.2
    IL_0187: ldloc.2
    IL_0188: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_018d: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0192: brfalse.s IL_01f6
    IL_0194: ldloc.3
    IL_0195: ldloc.2
    IL_0196: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_019b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01a0: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_01a5: call float UnityEngine.Vector3::SqrMagnitude(UnityEngine.Vector3)  /*0x0A0003A8*/
    IL_01aa: ldarg.0
    IL_01ab: ldfld float GateOpener::openDistance  /*0x040009AE*/
    IL_01b0: ldarg.0
    IL_01b1: ldfld float GateOpener::openDistance  /*0x040009AE*/
    IL_01b6: mul
    IL_01b7: bgt.un.s IL_01f6
    IL_01b9: ldloc.2
    IL_01ba: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_01bf: ldc.i4.s 10
    IL_01c1: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_01c6: brfalse.s IL_01f6
    IL_01c8: ldloc.2
    IL_01c9: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01ce: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01d3: ldloc.2
    IL_01d4: callvirt !!0 UnityEngine.Component::GetComponent()<PathfindMovementPlayerunit>  /*0x2B00008A*/
    IL_01d9: callvirt Vector3 PathfindMovementPlayerunit::get_HomePosition()  /*0x06000B2A*/
    IL_01de: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_01e3: call float UnityEngine.Vector3::SqrMagnitude(UnityEngine.Vector3)  /*0x0A0003A8*/
    IL_01e8: ldc.r4 0.25f
    IL_01ed: blt.s IL_01f6
    IL_01ef: ldarg.0
    IL_01f0: call void GateOpener::Open()  /*0x060007D3*/
    IL_01f5: ret
    IL_01f6: ldloc.s 7
    IL_01f8: ldc.i4.1
    IL_01f9: add
    IL_01fa: stloc.s 7
    IL_01fc: ldloc.s 7
    IL_01fe: ldloc.0
    IL_01ff: blt IL_0179
    IL_0204: ldc.i4.0
    IL_0205: stloc.s 8
    IL_0207: br.s IL_0264
    IL_0209: ldarg.0
    IL_020a: ldfld IReadOnlyList<TaggedObject> GateOpener::players  /*0x040009BB*/
    IL_020f: ldloc.s 8
    IL_0211: callvirt !0 System.Collections.Generic.IReadOnlyList<TaggedObject>::get_Item(int)  /*0x0A00019F*/
    IL_0216: stloc.2
    IL_0217: ldloc.2
    IL_0218: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_021d: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0222: brfalse.s IL_025e
    IL_0224: ldloc.3
    IL_0225: ldloc.2
    IL_0226: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_022b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0230: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0235: call float UnityEngine.Vector3::SqrMagnitude(UnityEngine.Vector3)  /*0x0A0003A8*/
    IL_023a: ldarg.0
    IL_023b: ldfld float GateOpener::openDistance  /*0x040009AE*/
    IL_0240: ldarg.0
    IL_0241: ldfld float GateOpener::openDistance  /*0x040009AE*/
    IL_0246: mul
    IL_0247: bgt.un.s IL_025e
    IL_0249: ldloc.2
    IL_024a: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_024f: ldc.i4.s 10
    IL_0251: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0256: brfalse.s IL_025e
    IL_0258: ldarg.0
    IL_0259: call void GateOpener::Open()  /*0x060007D3*/
    IL_025e: ldloc.s 8
    IL_0260: ldc.i4.1
    IL_0261: add
    IL_0262: stloc.s 8
    IL_0264: ldloc.s 8
    IL_0266: ldloc.1
    IL_0267: blt.s IL_0209
    IL_0269: ldarg.0
    IL_026a: ldfld bool GateOpener::open  /*0x040009B7*/
    IL_026f: brfalse.s IL_02ad
    IL_0271: ldarg.0
    IL_0272: ldfld float GateOpener::openAnimationClock  /*0x040009B9*/
    IL_0277: ldarg.0
    IL_0278: ldfld float GateOpener::animationTime  /*0x040009B6*/
    IL_027d: bge.un.s IL_02ad
    IL_027f: ldarg.0
    IL_0280: ldarg.0
    IL_0281: ldfld float GateOpener::openAnimationClock  /*0x040009B9*/
    IL_0286: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_028b: add
    IL_028c: stfld float GateOpener::openAnimationClock  /*0x040009B9*/
    IL_0291: ldarg.0
    IL_0292: ldfld float GateOpener::openAnimationClock  /*0x040009B9*/
    IL_0297: ldarg.0
    IL_0298: ldfld float GateOpener::animationTime  /*0x040009B6*/
    IL_029d: ble.un.s IL_02ec
    IL_029f: ldarg.0
    IL_02a0: ldarg.0
    IL_02a1: ldfld float GateOpener::animationTime  /*0x040009B6*/
    IL_02a6: stfld float GateOpener::openAnimationClock  /*0x040009B9*/
    IL_02ab: br.s IL_02ec
    IL_02ad: ldarg.0
    IL_02ae: ldfld bool GateOpener::open  /*0x040009B7*/
    IL_02b3: brtrue.s IL_02ec
    IL_02b5: ldarg.0
    IL_02b6: ldfld float GateOpener::openAnimationClock  /*0x040009B9*/
    IL_02bb: ldc.r4 0f
    IL_02c0: ble.un.s IL_02ec
    IL_02c2: ldarg.0
    IL_02c3: ldarg.0
    IL_02c4: ldfld float GateOpener::openAnimationClock  /*0x040009B9*/
    IL_02c9: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_02ce: sub
    IL_02cf: stfld float GateOpener::openAnimationClock  /*0x040009B9*/
    IL_02d4: ldarg.0
    IL_02d5: ldfld float GateOpener::openAnimationClock  /*0x040009B9*/
    IL_02da: ldc.r4 0f
    IL_02df: bge.un.s IL_02ec
    IL_02e1: ldarg.0
    IL_02e2: ldc.r4 0f
    IL_02e7: stfld float GateOpener::openAnimationClock  /*0x040009B9*/
    IL_02ec: ldarg.0
    IL_02ed: ldfld GateOpener.Mode GateOpener::mode  /*0x040009B0*/
    IL_02f2: stloc.s 10
    IL_02f4: ldloc.s 10
    IL_02f6: brfalse.s IL_02fe
    IL_02f8: ldloc.s 10
    IL_02fa: ldc.i4.1
    IL_02fb: beq.s IL_036d
    IL_02fd: ret
    IL_02fe: ldc.r4 0f
    IL_0303: ldarg.0
    IL_0304: ldfld float GateOpener::maxAngle  /*0x040009B3*/
    IL_0309: ldarg.0
    IL_030a: ldfld float GateOpener::openAnimationClock  /*0x040009B9*/
    IL_030f: ldarg.0
    IL_0310: ldfld float GateOpener::animationTime  /*0x040009B6*/
    IL_0315: div
    IL_0316: call float UnityEngine.Mathf::SmoothStep(float,float,float)  /*0x0A0003A9*/
    IL_031b: stloc.s 9
    IL_031d: ldarg.0
    IL_031e: ldfld Transform GateOpener::doorL  /*0x040009B1*/
    IL_0323: ldarg.0
    IL_0324: ldfld Vector3 GateOpener::doorLInitRotation  /*0x040009BC*/
    IL_0329: call Vector3 UnityEngine.Vector3::get_forward()  /*0x0A000278*/
    IL_032e: ldloc.s 9
    IL_0330: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0335: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_033a: call Quaternion UnityEngine.Quaternion::Euler(UnityEngine.Vector3)  /*0x0A0000B6*/
    IL_033f: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0344: ldarg.0
    IL_0345: ldfld Transform GateOpener::doorR  /*0x040009B2*/
    IL_034a: ldarg.0
    IL_034b: ldfld Vector3 GateOpener::doorRInitRotation  /*0x040009BD*/
    IL_0350: call Vector3 UnityEngine.Vector3::get_forward()  /*0x0A000278*/
    IL_0355: ldloc.s 9
    IL_0357: neg
    IL_0358: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_035d: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0362: call Quaternion UnityEngine.Quaternion::Euler(UnityEngine.Vector3)  /*0x0A0000B6*/
    IL_0367: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_036c: ret
    IL_036d: ldarg.0
    IL_036e: ldfld Transform GateOpener::bars  /*0x040009B4*/
    IL_0373: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0378: ldarg.0
    IL_0379: ldfld Vector3 GateOpener::barsInitPosition  /*0x040009BE*/
    IL_037e: ldarg.0
    IL_037f: ldfld Vector3 GateOpener::barsInitPosition  /*0x040009BE*/
    IL_0384: ldarg.0
    IL_0385: ldfld Vector3 GateOpener::openPositionOffset  /*0x040009B5*/
    IL_038a: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_038f: ldarg.0
    IL_0390: ldfld float GateOpener::openAnimationClock  /*0x040009B9*/
    IL_0395: ldarg.0
    IL_0396: ldfld float GateOpener::animationTime  /*0x040009B6*/
    IL_039b: div
    IL_039c: call Vector3 UnityEngine.Vector3::Slerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A0003AA*/
    IL_03a1: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_03a6: ret

  .method GateOpener::Close()  // token 0x060007D2 rva 0x2677f attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool GateOpener::open  /*0x040009B7*/
    IL_0007: ret

  .method GateOpener::Open()  // token 0x060007D3 rva 0x26788 attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool GateOpener::open  /*0x040009B7*/
    IL_0007: ret

  .method GateOpener::OnDrawGizmosSelected()  // token 0x060007D4 rva 0x26794 attrs Private, HideBySig
    // code size 65 (0x41), max stack 2, init locals
    IL_0000: call Color UnityEngine.Color::get_yellow()  /*0x0A000181*/
    IL_0005: call void UnityEngine.Gizmos::set_color(UnityEngine.Color)  /*0x0A0003AB*/
    IL_000a: ldarg.0
    IL_000b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0010: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0015: ldarg.0
    IL_0016: ldfld float GateOpener::openDistance  /*0x040009AE*/
    IL_001b: call void UnityEngine.Gizmos::DrawWireSphere(UnityEngine.Vector3,float)  /*0x0A0003AC*/
    IL_0020: call Color UnityEngine.Color::get_red()  /*0x0A00015E*/
    IL_0025: call void UnityEngine.Gizmos::set_color(UnityEngine.Color)  /*0x0A0003AB*/
    IL_002a: ldarg.0
    IL_002b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0030: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0035: ldarg.0
    IL_0036: ldfld float GateOpener::clearDistance  /*0x040009AF*/
    IL_003b: call void UnityEngine.Gizmos::DrawWireSphere(UnityEngine.Vector3,float)  /*0x0A0003AC*/
    IL_0040: ret

  .method GateOpener::.ctor()  // token 0x060007D5 rva 0x267e4 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 91 (0x5b), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 5f
    IL_0006: stfld float GateOpener::openDistance  /*0x040009AE*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 10f
    IL_0011: stfld float GateOpener::clearDistance  /*0x040009AF*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0f
    IL_001c: ldc.r4 -3.6f
    IL_0021: ldc.r4 0f
    IL_0026: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_002b: stfld Vector3 GateOpener::openPositionOffset  /*0x040009B5*/
    IL_0030: ldarg.0
    IL_0031: ldc.r4 1f
    IL_0036: stfld float GateOpener::animationTime  /*0x040009B6*/
    IL_003b: ldarg.0
    IL_003c: ldc.i4.2
    IL_003d: newarr TagManager.ETag  /*0x0200029A*/
    IL_0042: dup
    IL_0043: ldc.i4.0
    IL_0044: ldc.i4.2
    IL_0045: stelem.i4
    IL_0046: dup
    IL_0047: ldc.i4.1
    IL_0048: ldc.i4.7
    IL_0049: stelem.i4
    IL_004a: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0003AD*/
    IL_004f: stfld List<TagManager.ETag> GateOpener::tagList  /*0x040009B8*/
    IL_0054: ldarg.0
    IL_0055: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_005a: ret

// ===== GateOpener/Mode  (token 0x02000184) =====
