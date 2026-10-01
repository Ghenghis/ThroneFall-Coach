// ===== RangeIndicatorHandler  (token 0x02000335) =====
  .method RangeIndicatorHandler::Awake()  // token 0x0600119B rva 0x54d30 attrs Private, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0014
    IL_000d: ldarg.0
    IL_000e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: stsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_001a: ret

  .method RangeIndicatorHandler::Update()  // token 0x0600119C rva 0x54d4c attrs Private, HideBySig
    // code size 1425 (0x591), max stack 4, init locals
    .locals ([0] Dictionary.Enumerator<GameObject, RangeIndicatorHandler.IndicatorHandle>, [1] KeyValuePair<GameObject, RangeIndicatorHandler.IndicatorHandle>, [2] float, [3] KeyValuePair<GameObject, RangeIndicatorHandler.IndicatorHandle>, [4] float, [5] KeyValuePair<GameObject, RangeIndicatorHandler.IndicatorHandle>, [6] float, [7] KeyValuePair<GameObject, RangeIndicatorHandler.IndicatorHandle>, [8] float, [9] KeyValuePair<GameObject, RangeIndicatorHandler.IndicatorHandle>, [10] float, [11] List.Enumerator<GameObject>, [12] GameObject, [13] GameObject, [14] GameObject, [15] GameObject, [16] GameObject)
    IL_0000: ldarg.0
    IL_0001: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtIndicators  /*0x04001547*/
    IL_0006: callvirt int System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Count()  /*0x0A000700*/
    IL_000b: brtrue.s IL_0042
    IL_000d: ldarg.0
    IL_000e: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewIndicators  /*0x04001548*/
    IL_0013: callvirt int System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Count()  /*0x0A000700*/
    IL_0018: brtrue.s IL_0042
    IL_001a: ldarg.0
    IL_001b: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::specialIndicators  /*0x04001549*/
    IL_0020: callvirt int System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Count()  /*0x0A000700*/
    IL_0025: brtrue.s IL_0042
    IL_0027: ldarg.0
    IL_0028: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtAllIndicators  /*0x0400154A*/
    IL_002d: callvirt int System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Count()  /*0x0A000700*/
    IL_0032: brtrue.s IL_0042
    IL_0034: ldarg.0
    IL_0035: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewAllIndicators  /*0x0400154B*/
    IL_003a: callvirt int System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Count()  /*0x0A000700*/
    IL_003f: brtrue.s IL_0042
    IL_0041: ret
    IL_0042: ldarg.0
    IL_0043: ldfld List<GameObject> RangeIndicatorHandler::removeFromBuilt  /*0x0400154C*/
    IL_0048: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Clear()  /*0x0A0001BD*/
    IL_004d: ldarg.0
    IL_004e: ldfld List<GameObject> RangeIndicatorHandler::removeFromPreview  /*0x0400154D*/
    IL_0053: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Clear()  /*0x0A0001BD*/
    IL_0058: ldarg.0
    IL_0059: ldfld List<GameObject> RangeIndicatorHandler::removeFromSpecial  /*0x0400154E*/
    IL_005e: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Clear()  /*0x0A0001BD*/
    IL_0063: ldarg.0
    IL_0064: ldfld List<GameObject> RangeIndicatorHandler::removeFromBuiltAll  /*0x0400154F*/
    IL_0069: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Clear()  /*0x0A0001BD*/
    IL_006e: ldarg.0
    IL_006f: ldfld List<GameObject> RangeIndicatorHandler::removeFromPreviewAll  /*0x04001550*/
    IL_0074: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Clear()  /*0x0A0001BD*/
    IL_0079: ldarg.0
    IL_007a: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtIndicators  /*0x04001547*/
    IL_007f: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::GetEnumerator()  /*0x0A000701*/
    IL_0084: stloc.0
    IL_0085: br IL_011e
    IL_008a: ldloca.s 0
    IL_008c: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Current()  /*0x0A000702*/
    IL_0091: stloc.1
    IL_0092: ldloca.s 1
    IL_0094: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_0099: ldfld Material RangeIndicatorHandler.IndicatorHandle::targetMaterial  /*0x04001553*/
    IL_009e: ldstr "_Intersection_Depth"
    IL_00a3: callvirt float UnityEngine.Material::GetFloat(string)  /*0x0A000193*/
    IL_00a8: stloc.2
    IL_00a9: ldloc.2
    IL_00aa: ldc.r4 0f
    IL_00af: bne.un.s IL_00e9
    IL_00b1: ldloca.s 1
    IL_00b3: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_00b8: ldfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_00bd: ldc.r4 0f
    IL_00c2: bne.un.s IL_00e9
    IL_00c4: ldloca.s 1
    IL_00c6: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_00cb: ldfld GameObject RangeIndicatorHandler.IndicatorHandle::targetObject  /*0x04001551*/
    IL_00d0: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_00d5: ldarg.0
    IL_00d6: ldfld List<GameObject> RangeIndicatorHandler::removeFromBuilt  /*0x0400154C*/
    IL_00db: ldloca.s 1
    IL_00dd: call !0 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Key()  /*0x0A000704*/
    IL_00e2: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_00e7: br.s IL_011e
    IL_00e9: ldloc.2
    IL_00ea: ldloca.s 1
    IL_00ec: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_00f1: ldfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_00f6: ldc.r4 1.75f
    IL_00fb: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0100: mul
    IL_0101: call float UnityEngine.Mathf::MoveTowards(float,float,float)  /*0x0A0000CF*/
    IL_0106: stloc.2
    IL_0107: ldloca.s 1
    IL_0109: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_010e: ldfld Material RangeIndicatorHandler.IndicatorHandle::targetMaterial  /*0x04001553*/
    IL_0113: ldstr "_Intersection_Depth"
    IL_0118: ldloc.2
    IL_0119: callvirt void UnityEngine.Material::SetFloat(string,float)  /*0x0A000191*/
    IL_011e: ldloca.s 0
    IL_0120: call bool System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::MoveNext()  /*0x0A000705*/
    IL_0125: brtrue IL_008a
    IL_012a: leave.s IL_013a
    IL_012c: ldloca.s 0
    IL_012e: constrained. System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>  /*0x1B00014A*/
    IL_0134: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0139: endfinally
    IL_013a: ldarg.0
    IL_013b: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewIndicators  /*0x04001548*/
    IL_0140: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::GetEnumerator()  /*0x0A000701*/
    IL_0145: stloc.0
    IL_0146: br IL_01e4
    IL_014b: ldloca.s 0
    IL_014d: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Current()  /*0x0A000702*/
    IL_0152: stloc.3
    IL_0153: ldloca.s 3
    IL_0155: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_015a: ldfld Material RangeIndicatorHandler.IndicatorHandle::targetMaterial  /*0x04001553*/
    IL_015f: ldstr "_Intersection_Depth"
    IL_0164: callvirt float UnityEngine.Material::GetFloat(string)  /*0x0A000193*/
    IL_0169: stloc.s 4
    IL_016b: ldloc.s 4
    IL_016d: ldc.r4 0f
    IL_0172: bne.un.s IL_01ac
    IL_0174: ldloca.s 3
    IL_0176: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_017b: ldfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_0180: ldc.r4 0f
    IL_0185: bne.un.s IL_01ac
    IL_0187: ldloca.s 3
    IL_0189: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_018e: ldfld GameObject RangeIndicatorHandler.IndicatorHandle::targetObject  /*0x04001551*/
    IL_0193: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0198: ldarg.0
    IL_0199: ldfld List<GameObject> RangeIndicatorHandler::removeFromPreview  /*0x0400154D*/
    IL_019e: ldloca.s 3
    IL_01a0: call !0 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Key()  /*0x0A000704*/
    IL_01a5: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_01aa: br.s IL_01e4
    IL_01ac: ldloc.s 4
    IL_01ae: ldloca.s 3
    IL_01b0: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_01b5: ldfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_01ba: ldc.r4 1.75f
    IL_01bf: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_01c4: mul
    IL_01c5: call float UnityEngine.Mathf::MoveTowards(float,float,float)  /*0x0A0000CF*/
    IL_01ca: stloc.s 4
    IL_01cc: ldloca.s 3
    IL_01ce: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_01d3: ldfld Material RangeIndicatorHandler.IndicatorHandle::targetMaterial  /*0x04001553*/
    IL_01d8: ldstr "_Intersection_Depth"
    IL_01dd: ldloc.s 4
    IL_01df: callvirt void UnityEngine.Material::SetFloat(string,float)  /*0x0A000191*/
    IL_01e4: ldloca.s 0
    IL_01e6: call bool System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::MoveNext()  /*0x0A000705*/
    IL_01eb: brtrue IL_014b
    IL_01f0: leave.s IL_0200
    IL_01f2: ldloca.s 0
    IL_01f4: constrained. System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>  /*0x1B00014A*/
    IL_01fa: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01ff: endfinally
    IL_0200: ldarg.0
    IL_0201: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::specialIndicators  /*0x04001549*/
    IL_0206: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::GetEnumerator()  /*0x0A000701*/
    IL_020b: stloc.0
    IL_020c: br IL_02ab
    IL_0211: ldloca.s 0
    IL_0213: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Current()  /*0x0A000702*/
    IL_0218: stloc.s 5
    IL_021a: ldloca.s 5
    IL_021c: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_0221: ldfld Material RangeIndicatorHandler.IndicatorHandle::targetMaterial  /*0x04001553*/
    IL_0226: ldstr "_Intersection_Depth"
    IL_022b: callvirt float UnityEngine.Material::GetFloat(string)  /*0x0A000193*/
    IL_0230: stloc.s 6
    IL_0232: ldloc.s 6
    IL_0234: ldc.r4 0f
    IL_0239: bne.un.s IL_0273
    IL_023b: ldloca.s 5
    IL_023d: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_0242: ldfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_0247: ldc.r4 0f
    IL_024c: bne.un.s IL_0273
    IL_024e: ldloca.s 5
    IL_0250: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_0255: ldfld GameObject RangeIndicatorHandler.IndicatorHandle::targetObject  /*0x04001551*/
    IL_025a: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_025f: ldarg.0
    IL_0260: ldfld List<GameObject> RangeIndicatorHandler::removeFromSpecial  /*0x0400154E*/
    IL_0265: ldloca.s 5
    IL_0267: call !0 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Key()  /*0x0A000704*/
    IL_026c: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_0271: br.s IL_02ab
    IL_0273: ldloc.s 6
    IL_0275: ldloca.s 5
    IL_0277: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_027c: ldfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_0281: ldc.r4 1.75f
    IL_0286: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_028b: mul
    IL_028c: call float UnityEngine.Mathf::MoveTowards(float,float,float)  /*0x0A0000CF*/
    IL_0291: stloc.s 6
    IL_0293: ldloca.s 5
    IL_0295: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_029a: ldfld Material RangeIndicatorHandler.IndicatorHandle::targetMaterial  /*0x04001553*/
    IL_029f: ldstr "_Intersection_Depth"
    IL_02a4: ldloc.s 6
    IL_02a6: callvirt void UnityEngine.Material::SetFloat(string,float)  /*0x0A000191*/
    IL_02ab: ldloca.s 0
    IL_02ad: call bool System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::MoveNext()  /*0x0A000705*/
    IL_02b2: brtrue IL_0211
    IL_02b7: leave.s IL_02c7
    IL_02b9: ldloca.s 0
    IL_02bb: constrained. System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>  /*0x1B00014A*/
    IL_02c1: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_02c6: endfinally
    IL_02c7: ldarg.0
    IL_02c8: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtAllIndicators  /*0x0400154A*/
    IL_02cd: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::GetEnumerator()  /*0x0A000701*/
    IL_02d2: stloc.0
    IL_02d3: br IL_0372
    IL_02d8: ldloca.s 0
    IL_02da: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Current()  /*0x0A000702*/
    IL_02df: stloc.s 7
    IL_02e1: ldloca.s 7
    IL_02e3: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_02e8: ldfld Material RangeIndicatorHandler.IndicatorHandle::targetMaterial  /*0x04001553*/
    IL_02ed: ldstr "_Intersection_Depth"
    IL_02f2: callvirt float UnityEngine.Material::GetFloat(string)  /*0x0A000193*/
    IL_02f7: stloc.s 8
    IL_02f9: ldloc.s 8
    IL_02fb: ldc.r4 0f
    IL_0300: bne.un.s IL_033a
    IL_0302: ldloca.s 7
    IL_0304: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_0309: ldfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_030e: ldc.r4 0f
    IL_0313: bne.un.s IL_033a
    IL_0315: ldloca.s 7
    IL_0317: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_031c: ldfld GameObject RangeIndicatorHandler.IndicatorHandle::targetObject  /*0x04001551*/
    IL_0321: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0326: ldarg.0
    IL_0327: ldfld List<GameObject> RangeIndicatorHandler::removeFromBuiltAll  /*0x0400154F*/
    IL_032c: ldloca.s 7
    IL_032e: call !0 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Key()  /*0x0A000704*/
    IL_0333: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_0338: br.s IL_0372
    IL_033a: ldloc.s 8
    IL_033c: ldloca.s 7
    IL_033e: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_0343: ldfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_0348: ldc.r4 1.75f
    IL_034d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0352: mul
    IL_0353: call float UnityEngine.Mathf::MoveTowards(float,float,float)  /*0x0A0000CF*/
    IL_0358: stloc.s 8
    IL_035a: ldloca.s 7
    IL_035c: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_0361: ldfld Material RangeIndicatorHandler.IndicatorHandle::targetMaterial  /*0x04001553*/
    IL_0366: ldstr "_Intersection_Depth"
    IL_036b: ldloc.s 8
    IL_036d: callvirt void UnityEngine.Material::SetFloat(string,float)  /*0x0A000191*/
    IL_0372: ldloca.s 0
    IL_0374: call bool System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::MoveNext()  /*0x0A000705*/
    IL_0379: brtrue IL_02d8
    IL_037e: leave.s IL_038e
    IL_0380: ldloca.s 0
    IL_0382: constrained. System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>  /*0x1B00014A*/
    IL_0388: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_038d: endfinally
    IL_038e: ldarg.0
    IL_038f: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewAllIndicators  /*0x0400154B*/
    IL_0394: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::GetEnumerator()  /*0x0A000701*/
    IL_0399: stloc.0
    IL_039a: br IL_0439
    IL_039f: ldloca.s 0
    IL_03a1: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Current()  /*0x0A000702*/
    IL_03a6: stloc.s 9
    IL_03a8: ldloca.s 9
    IL_03aa: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_03af: ldfld Material RangeIndicatorHandler.IndicatorHandle::targetMaterial  /*0x04001553*/
    IL_03b4: ldstr "_Intersection_Depth"
    IL_03b9: callvirt float UnityEngine.Material::GetFloat(string)  /*0x0A000193*/
    IL_03be: stloc.s 10
    IL_03c0: ldloc.s 10
    IL_03c2: ldc.r4 0f
    IL_03c7: bne.un.s IL_0401
    IL_03c9: ldloca.s 9
    IL_03cb: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_03d0: ldfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_03d5: ldc.r4 0f
    IL_03da: bne.un.s IL_0401
    IL_03dc: ldloca.s 9
    IL_03de: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_03e3: ldfld GameObject RangeIndicatorHandler.IndicatorHandle::targetObject  /*0x04001551*/
    IL_03e8: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_03ed: ldarg.0
    IL_03ee: ldfld List<GameObject> RangeIndicatorHandler::removeFromPreviewAll  /*0x04001550*/
    IL_03f3: ldloca.s 9
    IL_03f5: call !0 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Key()  /*0x0A000704*/
    IL_03fa: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_03ff: br.s IL_0439
    IL_0401: ldloc.s 10
    IL_0403: ldloca.s 9
    IL_0405: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_040a: ldfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_040f: ldc.r4 1.75f
    IL_0414: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0419: mul
    IL_041a: call float UnityEngine.Mathf::MoveTowards(float,float,float)  /*0x0A0000CF*/
    IL_041f: stloc.s 10
    IL_0421: ldloca.s 9
    IL_0423: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_0428: ldfld Material RangeIndicatorHandler.IndicatorHandle::targetMaterial  /*0x04001553*/
    IL_042d: ldstr "_Intersection_Depth"
    IL_0432: ldloc.s 10
    IL_0434: callvirt void UnityEngine.Material::SetFloat(string,float)  /*0x0A000191*/
    IL_0439: ldloca.s 0
    IL_043b: call bool System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::MoveNext()  /*0x0A000705*/
    IL_0440: brtrue IL_039f
    IL_0445: leave.s IL_0455
    IL_0447: ldloca.s 0
    IL_0449: constrained. System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>  /*0x1B00014A*/
    IL_044f: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0454: endfinally
    IL_0455: ldarg.0
    IL_0456: ldfld List<GameObject> RangeIndicatorHandler::removeFromBuilt  /*0x0400154C*/
    IL_045b: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_0460: stloc.s 11
    IL_0462: br.s IL_047b
    IL_0464: ldloca.s 11
    IL_0466: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_046b: stloc.s 12
    IL_046d: ldarg.0
    IL_046e: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtIndicators  /*0x04001547*/
    IL_0473: ldloc.s 12
    IL_0475: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::Remove(!0)  /*0x0A000706*/
    IL_047a: pop
    IL_047b: ldloca.s 11
    IL_047d: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_0482: brtrue.s IL_0464
    IL_0484: leave.s IL_0494
    IL_0486: ldloca.s 11
    IL_0488: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_048e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0493: endfinally
    IL_0494: ldarg.0
    IL_0495: ldfld List<GameObject> RangeIndicatorHandler::removeFromPreview  /*0x0400154D*/
    IL_049a: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_049f: stloc.s 11
    IL_04a1: br.s IL_04ba
    IL_04a3: ldloca.s 11
    IL_04a5: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_04aa: stloc.s 13
    IL_04ac: ldarg.0
    IL_04ad: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewIndicators  /*0x04001548*/
    IL_04b2: ldloc.s 13
    IL_04b4: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::Remove(!0)  /*0x0A000706*/
    IL_04b9: pop
    IL_04ba: ldloca.s 11
    IL_04bc: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_04c1: brtrue.s IL_04a3
    IL_04c3: leave.s IL_04d3
    IL_04c5: ldloca.s 11
    IL_04c7: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_04cd: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_04d2: endfinally
    IL_04d3: ldarg.0
    IL_04d4: ldfld List<GameObject> RangeIndicatorHandler::removeFromSpecial  /*0x0400154E*/
    IL_04d9: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_04de: stloc.s 11
    IL_04e0: br.s IL_04f9
    IL_04e2: ldloca.s 11
    IL_04e4: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_04e9: stloc.s 14
    IL_04eb: ldarg.0
    IL_04ec: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::specialIndicators  /*0x04001549*/
    IL_04f1: ldloc.s 14
    IL_04f3: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::Remove(!0)  /*0x0A000706*/
    IL_04f8: pop
    IL_04f9: ldloca.s 11
    IL_04fb: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_0500: brtrue.s IL_04e2
    IL_0502: leave.s IL_0512
    IL_0504: ldloca.s 11
    IL_0506: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_050c: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0511: endfinally
    IL_0512: ldarg.0
    IL_0513: ldfld List<GameObject> RangeIndicatorHandler::removeFromBuiltAll  /*0x0400154F*/
    IL_0518: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_051d: stloc.s 11
    IL_051f: br.s IL_0538
    IL_0521: ldloca.s 11
    IL_0523: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_0528: stloc.s 15
    IL_052a: ldarg.0
    IL_052b: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtAllIndicators  /*0x0400154A*/
    IL_0530: ldloc.s 15
    IL_0532: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::Remove(!0)  /*0x0A000706*/
    IL_0537: pop
    IL_0538: ldloca.s 11
    IL_053a: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_053f: brtrue.s IL_0521
    IL_0541: leave.s IL_0551
    IL_0543: ldloca.s 11
    IL_0545: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_054b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0550: endfinally
    IL_0551: ldarg.0
    IL_0552: ldfld List<GameObject> RangeIndicatorHandler::removeFromPreviewAll  /*0x04001550*/
    IL_0557: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_055c: stloc.s 11
    IL_055e: br.s IL_0577
    IL_0560: ldloca.s 11
    IL_0562: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_0567: stloc.s 16
    IL_0569: ldarg.0
    IL_056a: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewAllIndicators  /*0x0400154B*/
    IL_056f: ldloc.s 16
    IL_0571: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::Remove(!0)  /*0x0A000706*/
    IL_0576: pop
    IL_0577: ldloca.s 11
    IL_0579: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_057e: brtrue.s IL_0560
    IL_0580: leave.s IL_0590
    IL_0582: ldloca.s 11
    IL_0584: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_058a: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_058f: endfinally
    IL_0590: ret
    .try IL_0085-IL_012c finally handler IL_012c-IL_013a
    .try IL_0146-IL_01f2 finally handler IL_01f2-IL_0200
    .try IL_020c-IL_02b9 finally handler IL_02b9-IL_02c7
    .try IL_02d3-IL_0380 finally handler IL_0380-IL_038e
    .try IL_039a-IL_0447 finally handler IL_0447-IL_0455
    .try IL_0462-IL_0486 finally handler IL_0486-IL_0494
    .try IL_04a1-IL_04c5 finally handler IL_04c5-IL_04d3
    .try IL_04e0-IL_0504 finally handler IL_0504-IL_0512
    .try IL_051f-IL_0543 finally handler IL_0543-IL_0551
    .try IL_055e-IL_0582 finally handler IL_0582-IL_0590

  .method RangeIndicatorHandler::ShowIndicator(UnityEngine.Vector3,float,UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  // token 0x0600119D rva 0x55368 attrs Public, HideBySig
    // code size 264 (0x108), max stack 4, init locals
    .locals ([0] Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle>, [1] GameObject, [2] RangeIndicatorHandler.IndicatorHandle)
    IL_0000: ldnull
    IL_0001: stloc.0
    IL_0002: ldnull
    IL_0003: stloc.1
    IL_0004: ldarg.s 4
    IL_0006: switch (IL_0021, IL_0031, IL_0041, IL_0051, IL_0061)
    IL_001f: br.s IL_006f
    IL_0021: ldarg.0
    IL_0022: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtIndicators  /*0x04001547*/
    IL_0027: stloc.0
    IL_0028: ldarg.0
    IL_0029: ldfld GameObject RangeIndicatorHandler::builtIndicatorPrefab  /*0x04001542*/
    IL_002e: stloc.1
    IL_002f: br.s IL_006f
    IL_0031: ldarg.0
    IL_0032: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewIndicators  /*0x04001548*/
    IL_0037: stloc.0
    IL_0038: ldarg.0
    IL_0039: ldfld GameObject RangeIndicatorHandler::previewIndicatorPrefab  /*0x04001543*/
    IL_003e: stloc.1
    IL_003f: br.s IL_006f
    IL_0041: ldarg.0
    IL_0042: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::specialIndicators  /*0x04001549*/
    IL_0047: stloc.0
    IL_0048: ldarg.0
    IL_0049: ldfld GameObject RangeIndicatorHandler::specialIndicatorPrefab  /*0x04001544*/
    IL_004e: stloc.1
    IL_004f: br.s IL_006f
    IL_0051: ldarg.0
    IL_0052: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtAllIndicators  /*0x0400154A*/
    IL_0057: stloc.0
    IL_0058: ldarg.0
    IL_0059: ldfld GameObject RangeIndicatorHandler::builtAllIndicatorPrefab  /*0x04001545*/
    IL_005e: stloc.1
    IL_005f: br.s IL_006f
    IL_0061: ldarg.0
    IL_0062: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewAllIndicators  /*0x0400154B*/
    IL_0067: stloc.0
    IL_0068: ldarg.0
    IL_0069: ldfld GameObject RangeIndicatorHandler::previewAllIndicatorPrefab  /*0x04001546*/
    IL_006e: stloc.1
    IL_006f: ldloc.0
    IL_0070: ldarg.3
    IL_0071: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::ContainsKey(!0)  /*0x0A000707*/
    IL_0076: brfalse.s IL_00c2
    IL_0078: ldloc.0
    IL_0079: ldarg.3
    IL_007a: callvirt !1 System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Item(!0)  /*0x0A000708*/
    IL_007f: dup
    IL_0080: ldfld GameObject RangeIndicatorHandler.IndicatorHandle::targetObject  /*0x04001551*/
    IL_0085: ldc.i4.1
    IL_0086: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_008b: dup
    IL_008c: ldfld Transform RangeIndicatorHandler.IndicatorHandle::targetTransform  /*0x04001552*/
    IL_0091: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0096: ldarg.2
    IL_0097: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_009c: ldc.r4 2f
    IL_00a1: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00a6: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00ab: dup
    IL_00ac: ldfld Transform RangeIndicatorHandler.IndicatorHandle::targetTransform  /*0x04001552*/
    IL_00b1: ldarg.1
    IL_00b2: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_00b7: ldc.r4 0.75f
    IL_00bc: stfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_00c1: ret
    IL_00c2: ldloc.1
    IL_00c3: ldarg.1
    IL_00c4: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_00c9: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_00ce: newobj void RangeIndicatorHandler.IndicatorHandle::.ctor(UnityEngine.GameObject)  /*0x060011A1*/
    IL_00d3: stloc.2
    IL_00d4: ldloc.2
    IL_00d5: ldfld Transform RangeIndicatorHandler.IndicatorHandle::targetTransform  /*0x04001552*/
    IL_00da: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00df: ldarg.2
    IL_00e0: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00e5: ldc.r4 2f
    IL_00ea: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00ef: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00f4: ldloc.2
    IL_00f5: ldc.r4 0.75f
    IL_00fa: stfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_00ff: ldloc.0
    IL_0100: ldarg.3
    IL_0101: ldloc.2
    IL_0102: callvirt void System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::Add(!0,!1)  /*0x0A000709*/
    IL_0107: ret

  .method RangeIndicatorHandler::HideIndicator(UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  // token 0x0600119E rva 0x5547c attrs Public, HideBySig
    // code size 217 (0xd9), max stack 2, init locals
    IL_0000: ldarg.2
    IL_0001: switch (IL_0041, IL_008d, IL_00b3, IL_001b, IL_0067)
    IL_001a: ret
    IL_001b: ldarg.0
    IL_001c: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtAllIndicators  /*0x0400154A*/
    IL_0021: ldarg.1
    IL_0022: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::ContainsKey(!0)  /*0x0A000707*/
    IL_0027: brtrue.s IL_002a
    IL_0029: ret
    IL_002a: ldarg.0
    IL_002b: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtAllIndicators  /*0x0400154A*/
    IL_0030: ldarg.1
    IL_0031: callvirt !1 System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Item(!0)  /*0x0A000708*/
    IL_0036: ldc.r4 0f
    IL_003b: stfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_0040: ret
    IL_0041: ldarg.0
    IL_0042: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtIndicators  /*0x04001547*/
    IL_0047: ldarg.1
    IL_0048: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::ContainsKey(!0)  /*0x0A000707*/
    IL_004d: brtrue.s IL_0050
    IL_004f: ret
    IL_0050: ldarg.0
    IL_0051: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtIndicators  /*0x04001547*/
    IL_0056: ldarg.1
    IL_0057: callvirt !1 System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Item(!0)  /*0x0A000708*/
    IL_005c: ldc.r4 0f
    IL_0061: stfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_0066: ret
    IL_0067: ldarg.0
    IL_0068: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewAllIndicators  /*0x0400154B*/
    IL_006d: ldarg.1
    IL_006e: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::ContainsKey(!0)  /*0x0A000707*/
    IL_0073: brtrue.s IL_0076
    IL_0075: ret
    IL_0076: ldarg.0
    IL_0077: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewAllIndicators  /*0x0400154B*/
    IL_007c: ldarg.1
    IL_007d: callvirt !1 System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Item(!0)  /*0x0A000708*/
    IL_0082: ldc.r4 0f
    IL_0087: stfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_008c: ret
    IL_008d: ldarg.0
    IL_008e: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewIndicators  /*0x04001548*/
    IL_0093: ldarg.1
    IL_0094: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::ContainsKey(!0)  /*0x0A000707*/
    IL_0099: brtrue.s IL_009c
    IL_009b: ret
    IL_009c: ldarg.0
    IL_009d: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewIndicators  /*0x04001548*/
    IL_00a2: ldarg.1
    IL_00a3: callvirt !1 System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Item(!0)  /*0x0A000708*/
    IL_00a8: ldc.r4 0f
    IL_00ad: stfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_00b2: ret
    IL_00b3: ldarg.0
    IL_00b4: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::specialIndicators  /*0x04001549*/
    IL_00b9: ldarg.1
    IL_00ba: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::ContainsKey(!0)  /*0x0A000707*/
    IL_00bf: brtrue.s IL_00c2
    IL_00c1: ret
    IL_00c2: ldarg.0
    IL_00c3: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::specialIndicators  /*0x04001549*/
    IL_00c8: ldarg.1
    IL_00c9: callvirt !1 System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Item(!0)  /*0x0A000708*/
    IL_00ce: ldc.r4 0f
    IL_00d3: stfld float RangeIndicatorHandler.IndicatorHandle::targetFade  /*0x04001554*/
    IL_00d8: ret

  .method RangeIndicatorHandler::OnDisable()  // token 0x0600119F rva 0x55564 attrs Private, HideBySig
    // code size 330 (0x14a), max stack 2, init locals
    .locals ([0] Dictionary.Enumerator<GameObject, RangeIndicatorHandler.IndicatorHandle>, [1] KeyValuePair<GameObject, RangeIndicatorHandler.IndicatorHandle>, [2] KeyValuePair<GameObject, RangeIndicatorHandler.IndicatorHandle>, [3] KeyValuePair<GameObject, RangeIndicatorHandler.IndicatorHandle>, [4] KeyValuePair<GameObject, RangeIndicatorHandler.IndicatorHandle>)
    IL_0000: ldarg.0
    IL_0001: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtIndicators  /*0x04001547*/
    IL_0006: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::GetEnumerator()  /*0x0A000701*/
    IL_000b: stloc.0
    IL_000c: br.s IL_0039
    IL_000e: ldloca.s 0
    IL_0010: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Current()  /*0x0A000702*/
    IL_0015: stloc.1
    IL_0016: ldloca.s 1
    IL_0018: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_001d: ldfld GameObject RangeIndicatorHandler.IndicatorHandle::targetObject  /*0x04001551*/
    IL_0022: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0027: ldarg.0
    IL_0028: ldfld List<GameObject> RangeIndicatorHandler::removeFromBuilt  /*0x0400154C*/
    IL_002d: ldloca.s 1
    IL_002f: call !0 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Key()  /*0x0A000704*/
    IL_0034: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_0039: ldloca.s 0
    IL_003b: call bool System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::MoveNext()  /*0x0A000705*/
    IL_0040: brtrue.s IL_000e
    IL_0042: leave.s IL_0052
    IL_0044: ldloca.s 0
    IL_0046: constrained. System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>  /*0x1B00014A*/
    IL_004c: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0051: endfinally
    IL_0052: ldarg.0
    IL_0053: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewIndicators  /*0x04001548*/
    IL_0058: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::GetEnumerator()  /*0x0A000701*/
    IL_005d: stloc.0
    IL_005e: br.s IL_008b
    IL_0060: ldloca.s 0
    IL_0062: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Current()  /*0x0A000702*/
    IL_0067: stloc.2
    IL_0068: ldloca.s 2
    IL_006a: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_006f: ldfld GameObject RangeIndicatorHandler.IndicatorHandle::targetObject  /*0x04001551*/
    IL_0074: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0079: ldarg.0
    IL_007a: ldfld List<GameObject> RangeIndicatorHandler::removeFromPreview  /*0x0400154D*/
    IL_007f: ldloca.s 2
    IL_0081: call !0 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Key()  /*0x0A000704*/
    IL_0086: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_008b: ldloca.s 0
    IL_008d: call bool System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::MoveNext()  /*0x0A000705*/
    IL_0092: brtrue.s IL_0060
    IL_0094: leave.s IL_00a4
    IL_0096: ldloca.s 0
    IL_0098: constrained. System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>  /*0x1B00014A*/
    IL_009e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00a3: endfinally
    IL_00a4: ldarg.0
    IL_00a5: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtAllIndicators  /*0x0400154A*/
    IL_00aa: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::GetEnumerator()  /*0x0A000701*/
    IL_00af: stloc.0
    IL_00b0: br.s IL_00dd
    IL_00b2: ldloca.s 0
    IL_00b4: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Current()  /*0x0A000702*/
    IL_00b9: stloc.3
    IL_00ba: ldloca.s 3
    IL_00bc: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_00c1: ldfld GameObject RangeIndicatorHandler.IndicatorHandle::targetObject  /*0x04001551*/
    IL_00c6: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_00cb: ldarg.0
    IL_00cc: ldfld List<GameObject> RangeIndicatorHandler::removeFromBuiltAll  /*0x0400154F*/
    IL_00d1: ldloca.s 3
    IL_00d3: call !0 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Key()  /*0x0A000704*/
    IL_00d8: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_00dd: ldloca.s 0
    IL_00df: call bool System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::MoveNext()  /*0x0A000705*/
    IL_00e4: brtrue.s IL_00b2
    IL_00e6: leave.s IL_00f6
    IL_00e8: ldloca.s 0
    IL_00ea: constrained. System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>  /*0x1B00014A*/
    IL_00f0: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00f5: endfinally
    IL_00f6: ldarg.0
    IL_00f7: ldfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewAllIndicators  /*0x0400154B*/
    IL_00fc: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::GetEnumerator()  /*0x0A000701*/
    IL_0101: stloc.0
    IL_0102: br.s IL_0130
    IL_0104: ldloca.s 0
    IL_0106: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Current()  /*0x0A000702*/
    IL_010b: stloc.s 4
    IL_010d: ldloca.s 4
    IL_010f: call !1 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Value()  /*0x0A000703*/
    IL_0114: ldfld GameObject RangeIndicatorHandler.IndicatorHandle::targetObject  /*0x04001551*/
    IL_0119: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_011e: ldarg.0
    IL_011f: ldfld List<GameObject> RangeIndicatorHandler::removeFromPreviewAll  /*0x04001550*/
    IL_0124: ldloca.s 4
    IL_0126: call !0 System.Collections.Generic.KeyValuePair<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::get_Key()  /*0x0A000704*/
    IL_012b: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_0130: ldloca.s 0
    IL_0132: call bool System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::MoveNext()  /*0x0A000705*/
    IL_0137: brtrue.s IL_0104
    IL_0139: leave.s IL_0149
    IL_013b: ldloca.s 0
    IL_013d: constrained. System.Collections.Generic.Dictionary.Enumerator<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>  /*0x1B00014A*/
    IL_0143: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0148: endfinally
    IL_0149: ret
    .try IL_000c-IL_0044 finally handler IL_0044-IL_0052
    .try IL_005e-IL_0096 finally handler IL_0096-IL_00a4
    .try IL_00b0-IL_00e8 finally handler IL_00e8-IL_00f6
    .try IL_0102-IL_013b finally handler IL_013b-IL_0149

  .method RangeIndicatorHandler::.ctor()  // token 0x060011A0 rva 0x556f0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 117 (0x75), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::.ctor()  /*0x0A00070A*/
    IL_0006: stfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtIndicators  /*0x04001547*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::.ctor()  /*0x0A00070A*/
    IL_0011: stfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewIndicators  /*0x04001548*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::.ctor()  /*0x0A00070A*/
    IL_001c: stfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::specialIndicators  /*0x04001549*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::.ctor()  /*0x0A00070A*/
    IL_0027: stfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::builtAllIndicators  /*0x0400154A*/
    IL_002c: ldarg.0
    IL_002d: newobj void System.Collections.Generic.Dictionary<UnityEngine.GameObject, RangeIndicatorHandler.IndicatorHandle>::.ctor()  /*0x0A00070A*/
    IL_0032: stfld Dictionary<GameObject, RangeIndicatorHandler.IndicatorHandle> RangeIndicatorHandler::previewAllIndicators  /*0x0400154B*/
    IL_0037: ldarg.0
    IL_0038: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000133*/
    IL_003d: stfld List<GameObject> RangeIndicatorHandler::removeFromBuilt  /*0x0400154C*/
    IL_0042: ldarg.0
    IL_0043: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000133*/
    IL_0048: stfld List<GameObject> RangeIndicatorHandler::removeFromPreview  /*0x0400154D*/
    IL_004d: ldarg.0
    IL_004e: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000133*/
    IL_0053: stfld List<GameObject> RangeIndicatorHandler::removeFromSpecial  /*0x0400154E*/
    IL_0058: ldarg.0
    IL_0059: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000133*/
    IL_005e: stfld List<GameObject> RangeIndicatorHandler::removeFromBuiltAll  /*0x0400154F*/
    IL_0063: ldarg.0
    IL_0064: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000133*/
    IL_0069: stfld List<GameObject> RangeIndicatorHandler::removeFromPreviewAll  /*0x04001550*/
    IL_006e: ldarg.0
    IL_006f: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0074: ret

// ===== RangeIndicatorHandler/IndicatorHandle  (token 0x02000336) =====
  .method RangeIndicatorHandler.IndicatorHandle::.ctor(UnityEngine.GameObject)  // token 0x060011A1 rva 0x55774 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 64 (0x40), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld GameObject RangeIndicatorHandler.IndicatorHandle::targetObject  /*0x04001551*/
    IL_000d: ldarg.0
    IL_000e: ldarg.1
    IL_000f: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0014: stfld Transform RangeIndicatorHandler.IndicatorHandle::targetTransform  /*0x04001552*/
    IL_0019: ldarg.0
    IL_001a: ldarg.1
    IL_001b: callvirt !!0 UnityEngine.GameObject::GetComponent()<UnityEngine.MeshRenderer>  /*0x2B000103*/
    IL_0020: callvirt Material UnityEngine.Renderer::get_material()  /*0x0A00070B*/
    IL_0025: stfld Material RangeIndicatorHandler.IndicatorHandle::targetMaterial  /*0x04001553*/
    IL_002a: ldarg.0
    IL_002b: ldfld Material RangeIndicatorHandler.IndicatorHandle::targetMaterial  /*0x04001553*/
    IL_0030: ldstr "_Intersection_Depth"
    IL_0035: ldc.r4 0f
    IL_003a: callvirt void UnityEngine.Material::SetFloat(string,float)  /*0x0A000191*/
    IL_003f: ret

// ===== RangeIndicatorHandler/IndicatorType  (token 0x02000337) =====
