// ===== KnockbackUtils  (token 0x02000397) =====
  .method KnockbackUtils::ApplyKnockback(KnockbackUtils.KnockbackData,System.Action,System.Action)  // token 0x060013B2 rva 0x5d7c8 attrs Public, Static, HideBySig
    // code size 359 (0x167), max stack 8, init locals
    .locals ([0] List<TaggedObject>, [1] bool, [2] List<TaggedObject>, [3] int, [4] bool, [5] float, [6] List.Enumerator<TaggedObject>, [7] TaggedObject, [8] Vector3, [9] float, [10] KnockbackBehavior, [11] ValueTuple<Vector3, float>)
    IL_0000: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0005: stloc.0
    IL_0006: ldc.i4.0
    IL_0007: stloc.1
    IL_0008: ldarg.0
    IL_0009: ldfld TagManager KnockbackUtils.KnockbackData::tagManager  /*0x040017FE*/
    IL_000e: ldloc.0
    IL_000f: ldarg.0
    IL_0010: ldfld List<TagManager.ETag> KnockbackUtils.KnockbackData::mustHaveTags  /*0x040017FF*/
    IL_0015: ldarg.0
    IL_0016: ldfld List<TagManager.ETag> KnockbackUtils.KnockbackData::mayNotHaveTags  /*0x04001800*/
    IL_001b: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0020: ldarg.1
    IL_0021: brfalse.s IL_0029
    IL_0023: ldarg.1
    IL_0024: callvirt void System.Action::Invoke()  /*0x0A00037F*/
    IL_0029: ldloc.0
    IL_002a: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_002f: brtrue.s IL_0033
    IL_0031: ldc.i4.0
    IL_0032: ret
    IL_0033: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0038: stloc.2
    IL_0039: ldc.i4.0
    IL_003a: stloc.3
    IL_003b: br.s IL_0073
    IL_003d: ldarg.0
    IL_003e: ldloc.0
    IL_003f: ldloc.3
    IL_0040: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0045: ldloca.s 5
    IL_0047: call bool KnockbackUtils::IsInShape(KnockbackUtils.KnockbackData,TaggedObject,ref float)  /*0x060013B6*/
    IL_004c: stloc.s 4
    IL_004e: ldloc.s 4
    IL_0050: brfalse.s IL_006f
    IL_0052: ldloc.s 4
    IL_0054: brfalse.s IL_0062
    IL_0056: ldloc.s 5
    IL_0058: ldarg.0
    IL_0059: ldfld float KnockbackUtils.KnockbackData::minRange  /*0x04001802*/
    IL_005e: bgt.un.s IL_0062
    IL_0060: ldc.i4.1
    IL_0061: stloc.1
    IL_0062: ldloc.2
    IL_0063: ldloc.0
    IL_0064: ldloc.3
    IL_0065: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_006a: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_006f: ldloc.3
    IL_0070: ldc.i4.1
    IL_0071: add
    IL_0072: stloc.3
    IL_0073: ldloc.3
    IL_0074: ldloc.0
    IL_0075: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_007a: blt.s IL_003d
    IL_007c: ldloc.1
    IL_007d: brfalse IL_0165
    IL_0082: ldarg.2
    IL_0083: brfalse.s IL_008b
    IL_0085: ldarg.2
    IL_0086: callvirt void System.Action::Invoke()  /*0x0A00037F*/
    IL_008b: ldloc.2
    IL_008c: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0091: stloc.s 6
    IL_0093: br IL_0149
    IL_0098: ldloca.s 6
    IL_009a: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_009f: stloc.s 7
    IL_00a1: ldarg.0
    IL_00a2: ldfld KnockbackUtils.KnockbackShapeType KnockbackUtils.KnockbackData::shapeType  /*0x040017FD*/
    IL_00a7: brfalse.s IL_00cc
    IL_00a9: ldloc.s 7
    IL_00ab: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00b0: ldarg.0
    IL_00b1: call ValueTuple<Vector3, float> KnockbackUtils::GetLinearDirectionAndForce(UnityEngine.Transform,KnockbackUtils.KnockbackData)  /*0x060013B5*/
    IL_00b6: stloc.s 11
    IL_00b8: ldloc.s 11
    IL_00ba: ldfld !0 System.ValueTuple<UnityEngine.Vector3, float>::Item1  /*0x0A0001C3*/
    IL_00bf: stloc.s 8
    IL_00c1: ldloc.s 11
    IL_00c3: ldfld !1 System.ValueTuple<UnityEngine.Vector3, float>::Item2  /*0x0A0001C4*/
    IL_00c8: stloc.s 9
    IL_00ca: br.s IL_00ed
    IL_00cc: ldloc.s 7
    IL_00ce: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00d3: ldarg.0
    IL_00d4: call ValueTuple<Vector3, float> KnockbackUtils::GetRadialDirectionAndForce(UnityEngine.Transform,KnockbackUtils.KnockbackData)  /*0x060013B4*/
    IL_00d9: stloc.s 11
    IL_00db: ldloc.s 11
    IL_00dd: ldfld !0 System.ValueTuple<UnityEngine.Vector3, float>::Item1  /*0x0A0001C3*/
    IL_00e2: stloc.s 8
    IL_00e4: ldloc.s 11
    IL_00e6: ldfld !1 System.ValueTuple<UnityEngine.Vector3, float>::Item2  /*0x0A0001C4*/
    IL_00eb: stloc.s 9
    IL_00ed: ldloc.s 7
    IL_00ef: callvirt !!0 UnityEngine.Component::GetComponent()<KnockbackBehavior>  /*0x2B00004A*/
    IL_00f4: stloc.s 10
    IL_00f6: ldloc.s 10
    IL_00f8: ldnull
    IL_00f9: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00fe: brtrue.s IL_0149
    IL_0100: ldloc.s 10
    IL_0102: callvirt bool UnityEngine.Behaviour::get_enabled()  /*0x0A0001B4*/
    IL_0107: brfalse.s IL_0149
    IL_0109: ldloc.s 10
    IL_010b: ldloc.s 8
    IL_010d: ldarg.0
    IL_010e: ldfld float KnockbackUtils.KnockbackData::maxRange  /*0x04001803*/
    IL_0113: ldloc.s 9
    IL_0115: ldarg.0
    IL_0116: ldfld float KnockbackUtils.KnockbackData::maxForce  /*0x04001804*/
    IL_011b: ldloc.s 7
    IL_011d: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0122: callvirt PathfindMovement Hp::get_PathfindMovement()  /*0x06000818*/
    IL_0127: ldloc.s 7
    IL_0129: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_012e: callvirt PathfindMovement Hp::get_PathfindMovement()  /*0x06000818*/
    IL_0133: callvirt RVOController PathfindMovement::get_RVO()  /*0x06000B0A*/
    IL_0138: ldloc.s 7
    IL_013a: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_013f: callvirt AutoAttack[] Hp::get_AutoAttacks()  /*0x06000817*/
    IL_0144: callvirt void KnockbackBehavior::ApplyKnockback(UnityEngine.Vector3,float,float,float,PathfindMovement,Pathfinding.RVO.RVOController,AutoAttack[])  /*0x06000875*/
    IL_0149: ldloca.s 6
    IL_014b: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0150: brtrue IL_0098
    IL_0155: leave.s IL_0165
    IL_0157: ldloca.s 6
    IL_0159: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_015f: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0164: endfinally
    IL_0165: ldloc.1
    IL_0166: ret
    .try IL_0093-IL_0157 finally handler IL_0157-IL_0165

  .method KnockbackUtils::ApplyRadialKnockback(KnockbackUtils.KnockbackData,System.Collections.Generic.List<TaggedObject>,System.Action,System.Action)  // token 0x060013B3 rva 0x5d94c attrs Public, Static, HideBySig
    // code size 181 (0xb5), max stack 8, init locals
    .locals ([0] List.Enumerator<TaggedObject>, [1] TaggedObject, [2] KnockbackBehavior, [3] Vector3, [4] float)
    IL_0000: ldarg.2
    IL_0001: brfalse.s IL_0009
    IL_0003: ldarg.2
    IL_0004: callvirt void System.Action::Invoke()  /*0x0A00037F*/
    IL_0009: ldarg.1
    IL_000a: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_000f: brtrue.s IL_0013
    IL_0011: ldc.i4.0
    IL_0012: ret
    IL_0013: ldarg.3
    IL_0014: brfalse.s IL_001c
    IL_0016: ldarg.3
    IL_0017: callvirt void System.Action::Invoke()  /*0x0A00037F*/
    IL_001c: ldarg.1
    IL_001d: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0022: stloc.0
    IL_0023: br.s IL_009a
    IL_0025: ldloca.s 0
    IL_0027: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_002c: stloc.1
    IL_002d: ldloc.1
    IL_002e: callvirt !!0 UnityEngine.Component::GetComponent()<KnockbackBehavior>  /*0x2B00004A*/
    IL_0033: stloc.2
    IL_0034: ldloc.2
    IL_0035: ldnull
    IL_0036: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_003b: brtrue.s IL_009a
    IL_003d: ldloc.2
    IL_003e: callvirt bool UnityEngine.Behaviour::get_enabled()  /*0x0A0001B4*/
    IL_0043: brfalse.s IL_009a
    IL_0045: ldloc.1
    IL_0046: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_004b: ldarg.0
    IL_004c: call ValueTuple<Vector3, float> KnockbackUtils::GetRadialDirectionAndForce(UnityEngine.Transform,KnockbackUtils.KnockbackData)  /*0x060013B4*/
    IL_0051: dup
    IL_0052: ldfld !0 System.ValueTuple<UnityEngine.Vector3, float>::Item1  /*0x0A0001C3*/
    IL_0057: stloc.3
    IL_0058: ldfld !1 System.ValueTuple<UnityEngine.Vector3, float>::Item2  /*0x0A0001C4*/
    IL_005d: stloc.s 4
    IL_005f: ldloc.2
    IL_0060: ldloc.3
    IL_0061: ldarg.0
    IL_0062: ldfld float KnockbackUtils.KnockbackData::maxRange  /*0x04001803*/
    IL_0067: ldloc.s 4
    IL_0069: ldarg.0
    IL_006a: ldfld float KnockbackUtils.KnockbackData::maxForce  /*0x04001804*/
    IL_006f: ldloc.1
    IL_0070: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0075: callvirt PathfindMovement Hp::get_PathfindMovement()  /*0x06000818*/
    IL_007a: ldloc.1
    IL_007b: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0080: callvirt PathfindMovement Hp::get_PathfindMovement()  /*0x06000818*/
    IL_0085: callvirt RVOController PathfindMovement::get_RVO()  /*0x06000B0A*/
    IL_008a: ldloc.1
    IL_008b: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0090: callvirt AutoAttack[] Hp::get_AutoAttacks()  /*0x06000817*/
    IL_0095: callvirt void KnockbackBehavior::ApplyKnockback(UnityEngine.Vector3,float,float,float,PathfindMovement,Pathfinding.RVO.RVOController,AutoAttack[])  /*0x06000875*/
    IL_009a: ldloca.s 0
    IL_009c: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_00a1: brtrue.s IL_0025
    IL_00a3: leave.s IL_00b3
    IL_00a5: ldloca.s 0
    IL_00a7: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_00ad: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00b2: endfinally
    IL_00b3: ldc.i4.1
    IL_00b4: ret
    .try IL_0023-IL_00a5 finally handler IL_00a5-IL_00b3

  .method KnockbackUtils::GetRadialDirectionAndForce(UnityEngine.Transform,KnockbackUtils.KnockbackData)  // token 0x060013B4 rva 0x5da20 attrs Private, Static, HideBySig
    // code size 116 (0x74), max stack 2, init locals
    .locals ([0] float, [1] float, [2] float, [3] Vector3)
    IL_0000: ldarg.0
    IL_0001: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: ldarg.1
    IL_000c: ldfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_0011: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0016: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_001b: ldarg.1
    IL_001c: ldfld float KnockbackUtils.KnockbackData::maxRange  /*0x04001803*/
    IL_0021: div
    IL_0022: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_0027: stloc.0
    IL_0028: ldc.r4 1f
    IL_002d: ldloc.0
    IL_002e: sub
    IL_002f: stloc.1
    IL_0030: ldloc.1
    IL_0031: ldloc.1
    IL_0032: mul
    IL_0033: stloc.1
    IL_0034: ldarg.1
    IL_0035: ldfld float KnockbackUtils.KnockbackData::maxForce  /*0x04001804*/
    IL_003a: ldloc.1
    IL_003b: mul
    IL_003c: stloc.2
    IL_003d: ldarg.0
    IL_003e: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0043: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0048: ldarg.1
    IL_0049: ldfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_004e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0053: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0058: stloc.3
    IL_0059: ldloca.s 3
    IL_005b: ldc.r4 0f
    IL_0060: stfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0065: ldloca.s 3
    IL_0067: call void UnityEngine.Vector3::Normalize()  /*0x0A0000A0*/
    IL_006c: ldloc.3
    IL_006d: ldloc.2
    IL_006e: newobj void System.ValueTuple<UnityEngine.Vector3, float>::.ctor(!0,!1)  /*0x0A0001C0*/
    IL_0073: ret

  .method KnockbackUtils::GetLinearDirectionAndForce(UnityEngine.Transform,KnockbackUtils.KnockbackData)  // token 0x060013B5 rva 0x5daa0 attrs Private, Static, HideBySig
    // code size 179 (0xb3), max stack 4, init locals
    .locals ([0] Vector3, [1] Vector3, [2] float, [3] float, [4] float, [5] float)
    IL_0000: ldarga.s 1
    IL_0002: call Vector3 KnockbackUtils.KnockbackData::get_EffectiveForward()  /*0x060013BA*/
    IL_0007: stloc.0
    IL_0008: ldarg.1
    IL_0009: ldfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_000e: callvirt Vector3 UnityEngine.Transform::get_up()  /*0x0A00077D*/
    IL_0013: ldloc.0
    IL_0014: call Vector3 UnityEngine.Vector3::Cross(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0005F8*/
    IL_0019: stloc.1
    IL_001a: ldarg.0
    IL_001b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0020: ldarg.1
    IL_0021: ldfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_0026: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002b: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0030: dup
    IL_0031: ldloc.1
    IL_0032: call float UnityEngine.Vector3::Dot(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0001A1*/
    IL_0037: stloc.2
    IL_0038: ldloc.0
    IL_0039: call float UnityEngine.Vector3::Dot(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0001A1*/
    IL_003e: ldloc.2
    IL_003f: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_0044: ldarg.1
    IL_0045: ldfld float KnockbackUtils.KnockbackData::width  /*0x04001806*/
    IL_004a: ldc.r4 0.5f
    IL_004f: mul
    IL_0050: div
    IL_0051: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_0056: ldarg.1
    IL_0057: ldfld float KnockbackUtils.KnockbackData::maxEdgeAngle  /*0x04001809*/
    IL_005c: mul
    IL_005d: ldloc.2
    IL_005e: call float UnityEngine.Mathf::Sign(float)  /*0x0A00077E*/
    IL_0063: mul
    IL_0064: stloc.3
    IL_0065: ldarg.1
    IL_0066: ldfld float KnockbackUtils.KnockbackData::offset  /*0x04001808*/
    IL_006b: sub
    IL_006c: ldarg.1
    IL_006d: ldfld float KnockbackUtils.KnockbackData::depth  /*0x04001807*/
    IL_0072: div
    IL_0073: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_0078: stloc.s 4
    IL_007a: ldarg.1
    IL_007b: ldfld float KnockbackUtils.KnockbackData::maxForce  /*0x04001804*/
    IL_0080: ldc.r4 1f
    IL_0085: ldloc.s 4
    IL_0087: sub
    IL_0088: mul
    IL_0089: ldc.r4 1f
    IL_008e: ldloc.s 4
    IL_0090: sub
    IL_0091: mul
    IL_0092: stloc.s 5
    IL_0094: ldloc.3
    IL_0095: ldarg.1
    IL_0096: ldfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_009b: callvirt Vector3 UnityEngine.Transform::get_up()  /*0x0A00077D*/
    IL_00a0: call Quaternion UnityEngine.Quaternion::AngleAxis(float,UnityEngine.Vector3)  /*0x0A0004D3*/
    IL_00a5: ldloc.0
    IL_00a6: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_00ab: ldloc.s 5
    IL_00ad: newobj void System.ValueTuple<UnityEngine.Vector3, float>::.ctor(!0,!1)  /*0x0A0001C0*/
    IL_00b2: ret

  .method KnockbackUtils::IsInShape(KnockbackUtils.KnockbackData,TaggedObject,ref float)  // token 0x060013B6 rva 0x5db5f attrs Private, Static, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld KnockbackUtils.KnockbackShapeType KnockbackUtils.KnockbackData::shapeType  /*0x040017FD*/
    IL_0006: brtrue.s IL_0011
    IL_0008: ldarg.0
    IL_0009: ldarg.1
    IL_000a: ldarg.2
    IL_000b: call bool KnockbackUtils::IsInRadialShape(KnockbackUtils.KnockbackData,TaggedObject,ref float)  /*0x060013B7*/
    IL_0010: ret
    IL_0011: ldarg.0
    IL_0012: ldfld KnockbackUtils.KnockbackShapeType KnockbackUtils.KnockbackData::shapeType  /*0x040017FD*/
    IL_0017: ldc.i4.1
    IL_0018: bne.un.s IL_0023
    IL_001a: ldarg.0
    IL_001b: ldarg.1
    IL_001c: ldarg.2
    IL_001d: call bool KnockbackUtils::IsInLinearShape(KnockbackUtils.KnockbackData,TaggedObject,ref float)  /*0x060013B8*/
    IL_0022: ret
    IL_0023: ldarg.2
    IL_0024: ldc.r4 0f
    IL_0029: stind.r4
    IL_002a: ldc.i4.0
    IL_002b: ret

  .method KnockbackUtils::IsInRadialShape(KnockbackUtils.KnockbackData,TaggedObject,ref float)  // token 0x060013B7 rva 0x5db8c attrs Private, Static, HideBySig
    // code size 115 (0x73), max stack 3, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld TagManager KnockbackUtils.KnockbackData::tagManager  /*0x040017FE*/
    IL_0006: ldarg.1
    IL_0007: ldarg.0
    IL_0008: ldfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_000d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0012: callvirt Vector3 TagManager::MeasureDirectionToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E64*/
    IL_0017: stloc.0
    IL_0018: ldloc.0
    IL_0019: ldarg.0
    IL_001a: ldfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_001f: callvirt Vector3 UnityEngine.Transform::get_up()  /*0x0A00077D*/
    IL_0024: call Vector3 UnityEngine.Vector3::ProjectOnPlane(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0004ED*/
    IL_0029: stloc.0
    IL_002a: ldarg.0
    IL_002b: ldfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_0030: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0035: ldarg.0
    IL_0036: ldfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_003b: callvirt Vector3 UnityEngine.Transform::get_up()  /*0x0A00077D*/
    IL_0040: call Vector3 UnityEngine.Vector3::ProjectOnPlane(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0004ED*/
    IL_0045: ldloc.0
    IL_0046: call float UnityEngine.Vector3::Angle(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0000AD*/
    IL_004b: ldarg.2
    IL_004c: ldloca.s 0
    IL_004e: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0053: stind.r4
    IL_0054: ldarg.0
    IL_0055: ldfld int KnockbackUtils.KnockbackData::angle  /*0x04001805*/
    IL_005a: conv.r4
    IL_005b: ldc.r4 0.5f
    IL_0060: mul
    IL_0061: bgt.un.s IL_0071
    IL_0063: ldarg.2
    IL_0064: ldind.r4
    IL_0065: ldarg.0
    IL_0066: ldfld float KnockbackUtils.KnockbackData::maxRange  /*0x04001803*/
    IL_006b: cgt.un
    IL_006d: ldc.i4.0
    IL_006e: ceq
    IL_0070: ret
    IL_0071: ldc.i4.0
    IL_0072: ret

  .method KnockbackUtils::IsInLinearShape(KnockbackUtils.KnockbackData,TaggedObject,ref float)  // token 0x060013B8 rva 0x5dc0c attrs Private, Static, HideBySig
    // code size 144 (0x90), max stack 4, init locals
    .locals ([0] Vector3, [1] Vector3, [2] float, [3] float)
    IL_0000: ldarga.s 0
    IL_0002: call Vector3 KnockbackUtils.KnockbackData::get_EffectiveForward()  /*0x060013BA*/
    IL_0007: stloc.0
    IL_0008: ldarg.0
    IL_0009: ldfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_000e: callvirt Vector3 UnityEngine.Transform::get_up()  /*0x0A00077D*/
    IL_0013: ldloc.0
    IL_0014: call Vector3 UnityEngine.Vector3::Cross(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0005F8*/
    IL_0019: stloc.1
    IL_001a: ldarg.1
    IL_001b: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0020: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0025: ldarg.0
    IL_0026: ldfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_002b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0030: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0035: dup
    IL_0036: ldloc.0
    IL_0037: call float UnityEngine.Vector3::Dot(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0001A1*/
    IL_003c: stloc.2
    IL_003d: ldloc.1
    IL_003e: call float UnityEngine.Vector3::Dot(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0001A1*/
    IL_0043: stloc.3
    IL_0044: ldarg.2
    IL_0045: ldarg.0
    IL_0046: ldfld TagManager KnockbackUtils.KnockbackData::tagManager  /*0x040017FE*/
    IL_004b: ldarg.1
    IL_004c: ldarg.0
    IL_004d: ldfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_0052: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0057: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_005c: stind.r4
    IL_005d: ldloc.2
    IL_005e: ldarg.0
    IL_005f: ldfld float KnockbackUtils.KnockbackData::offset  /*0x04001808*/
    IL_0064: blt.s IL_0076
    IL_0066: ldloc.2
    IL_0067: ldarg.0
    IL_0068: ldfld float KnockbackUtils.KnockbackData::offset  /*0x04001808*/
    IL_006d: ldarg.0
    IL_006e: ldfld float KnockbackUtils.KnockbackData::depth  /*0x04001807*/
    IL_0073: add
    IL_0074: ble.un.s IL_0078
    IL_0076: ldc.i4.0
    IL_0077: ret
    IL_0078: ldloc.3
    IL_0079: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_007e: ldarg.0
    IL_007f: ldfld float KnockbackUtils.KnockbackData::width  /*0x04001806*/
    IL_0084: ldc.r4 0.5f
    IL_0089: mul
    IL_008a: ble.un.s IL_008e
    IL_008c: ldc.i4.0
    IL_008d: ret
    IL_008e: ldc.i4.1
    IL_008f: ret

  .method KnockbackUtils::.ctor()  // token 0x060013B9 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

// ===== KnockbackUtils/KnockbackShapeType  (token 0x02000398) =====
// ===== KnockbackUtils/KnockbackData  (token 0x02000399) =====
  .method KnockbackUtils.KnockbackData::get_EffectiveForward()  // token 0x060013BA rva 0x5dca8 attrs Public, HideBySig, SpecialName
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool KnockbackUtils.KnockbackData::invertedForward  /*0x0400180A*/
    IL_0006: brtrue.s IL_0014
    IL_0008: ldarg.0
    IL_0009: ldfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_000e: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: ldfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_001a: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_001f: call Vector3 UnityEngine.Vector3::op_UnaryNegation(UnityEngine.Vector3)  /*0x0A0005FA*/
    IL_0024: ret

  .method KnockbackUtils.KnockbackData::Radial(TagManager,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,UnityEngine.Transform,float,float,float,int)  // token 0x060013BB rva 0x5dcd0 attrs Public, Static, HideBySig
    // code size 86 (0x56), max stack 2, init locals
    .locals ([0] KnockbackUtils.KnockbackData)
    IL_0000: ldloca.s 0
    IL_0002: initobj KnockbackUtils.KnockbackData  /*0x02000399*/
    IL_0008: ldloca.s 0
    IL_000a: ldc.i4.0
    IL_000b: stfld KnockbackUtils.KnockbackShapeType KnockbackUtils.KnockbackData::shapeType  /*0x040017FD*/
    IL_0010: ldloca.s 0
    IL_0012: ldarg.0
    IL_0013: stfld TagManager KnockbackUtils.KnockbackData::tagManager  /*0x040017FE*/
    IL_0018: ldloca.s 0
    IL_001a: ldarg.1
    IL_001b: stfld List<TagManager.ETag> KnockbackUtils.KnockbackData::mustHaveTags  /*0x040017FF*/
    IL_0020: ldloca.s 0
    IL_0022: ldarg.2
    IL_0023: stfld List<TagManager.ETag> KnockbackUtils.KnockbackData::mayNotHaveTags  /*0x04001800*/
    IL_0028: ldloca.s 0
    IL_002a: ldarg.3
    IL_002b: stfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_0030: ldloca.s 0
    IL_0032: ldarg.s 4
    IL_0034: stfld float KnockbackUtils.KnockbackData::minRange  /*0x04001802*/
    IL_0039: ldloca.s 0
    IL_003b: ldarg.s 5
    IL_003d: stfld float KnockbackUtils.KnockbackData::maxRange  /*0x04001803*/
    IL_0042: ldloca.s 0
    IL_0044: ldarg.s 6
    IL_0046: stfld float KnockbackUtils.KnockbackData::maxForce  /*0x04001804*/
    IL_004b: ldloca.s 0
    IL_004d: ldarg.s 7
    IL_004f: stfld int KnockbackUtils.KnockbackData::angle  /*0x04001805*/
    IL_0054: ldloc.0
    IL_0055: ret

  .method KnockbackUtils.KnockbackData::FullCircle(UnityEngine.Transform,float,float)  // token 0x060013BC rva 0x5dd34 attrs Public, Static, HideBySig
    // code size 86 (0x56), max stack 2, init locals
    .locals ([0] KnockbackUtils.KnockbackData)
    IL_0000: ldloca.s 0
    IL_0002: initobj KnockbackUtils.KnockbackData  /*0x02000399*/
    IL_0008: ldloca.s 0
    IL_000a: ldc.i4.0
    IL_000b: stfld KnockbackUtils.KnockbackShapeType KnockbackUtils.KnockbackData::shapeType  /*0x040017FD*/
    IL_0010: ldloca.s 0
    IL_0012: ldnull
    IL_0013: stfld TagManager KnockbackUtils.KnockbackData::tagManager  /*0x040017FE*/
    IL_0018: ldloca.s 0
    IL_001a: ldnull
    IL_001b: stfld List<TagManager.ETag> KnockbackUtils.KnockbackData::mustHaveTags  /*0x040017FF*/
    IL_0020: ldloca.s 0
    IL_0022: ldnull
    IL_0023: stfld List<TagManager.ETag> KnockbackUtils.KnockbackData::mayNotHaveTags  /*0x04001800*/
    IL_0028: ldloca.s 0
    IL_002a: ldarg.0
    IL_002b: stfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_0030: ldloca.s 0
    IL_0032: ldarg.1
    IL_0033: stfld float KnockbackUtils.KnockbackData::minRange  /*0x04001802*/
    IL_0038: ldloca.s 0
    IL_003a: ldarg.1
    IL_003b: stfld float KnockbackUtils.KnockbackData::maxRange  /*0x04001803*/
    IL_0040: ldloca.s 0
    IL_0042: ldarg.2
    IL_0043: stfld float KnockbackUtils.KnockbackData::maxForce  /*0x04001804*/
    IL_0048: ldloca.s 0
    IL_004a: ldc.i4 360
    IL_004f: stfld int KnockbackUtils.KnockbackData::angle  /*0x04001805*/
    IL_0054: ldloc.0
    IL_0055: ret

  .method KnockbackUtils.KnockbackData::Linear(TagManager,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,UnityEngine.Transform,float,float,float,float,float,float,float,bool)  // token 0x060013BD rva 0x5dd98 attrs Public, Static, HideBySig
    // code size 122 (0x7a), max stack 2, init locals
    .locals ([0] KnockbackUtils.KnockbackData)
    IL_0000: ldloca.s 0
    IL_0002: initobj KnockbackUtils.KnockbackData  /*0x02000399*/
    IL_0008: ldloca.s 0
    IL_000a: ldc.i4.1
    IL_000b: stfld KnockbackUtils.KnockbackShapeType KnockbackUtils.KnockbackData::shapeType  /*0x040017FD*/
    IL_0010: ldloca.s 0
    IL_0012: ldarg.0
    IL_0013: stfld TagManager KnockbackUtils.KnockbackData::tagManager  /*0x040017FE*/
    IL_0018: ldloca.s 0
    IL_001a: ldarg.1
    IL_001b: stfld List<TagManager.ETag> KnockbackUtils.KnockbackData::mustHaveTags  /*0x040017FF*/
    IL_0020: ldloca.s 0
    IL_0022: ldarg.2
    IL_0023: stfld List<TagManager.ETag> KnockbackUtils.KnockbackData::mayNotHaveTags  /*0x04001800*/
    IL_0028: ldloca.s 0
    IL_002a: ldarg.3
    IL_002b: stfld Transform KnockbackUtils.KnockbackData::source  /*0x04001801*/
    IL_0030: ldloca.s 0
    IL_0032: ldarg.s 4
    IL_0034: stfld float KnockbackUtils.KnockbackData::minRange  /*0x04001802*/
    IL_0039: ldloca.s 0
    IL_003b: ldarg.s 5
    IL_003d: stfld float KnockbackUtils.KnockbackData::maxRange  /*0x04001803*/
    IL_0042: ldloca.s 0
    IL_0044: ldarg.s 6
    IL_0046: stfld float KnockbackUtils.KnockbackData::maxForce  /*0x04001804*/
    IL_004b: ldloca.s 0
    IL_004d: ldarg.s 7
    IL_004f: stfld float KnockbackUtils.KnockbackData::width  /*0x04001806*/
    IL_0054: ldloca.s 0
    IL_0056: ldarg.s 8
    IL_0058: stfld float KnockbackUtils.KnockbackData::depth  /*0x04001807*/
    IL_005d: ldloca.s 0
    IL_005f: ldarg.s 9
    IL_0061: stfld float KnockbackUtils.KnockbackData::offset  /*0x04001808*/
    IL_0066: ldloca.s 0
    IL_0068: ldarg.s 10
    IL_006a: stfld float KnockbackUtils.KnockbackData::maxEdgeAngle  /*0x04001809*/
    IL_006f: ldloca.s 0
    IL_0071: ldarg.s 11
    IL_0073: stfld bool KnockbackUtils.KnockbackData::invertedForward  /*0x0400180A*/
    IL_0078: ldloc.0
    IL_0079: ret

