// ===== PerkSelectionGroup  (token 0x020001AC) =====
  .method PerkSelectionGroup::Start()  // token 0x060008B7 rva 0x2a017 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void PerkSelectionGroup::UpdateVisuals()  /*0x060008B8*/
    IL_0006: ret

  .method PerkSelectionGroup::UpdateVisuals()  // token 0x060008B8 rva 0x2a020 attrs Public, HideBySig
    // code size 763 (0x2fb), max stack 4, init locals
    .locals ([0] int, [1] int, [2] List.Enumerator<Equippable>, [3] Equippable, [4] Equippable, [5] LevelInfo, [6] int, [7] Equippable)
    IL_0000: ldarg.0
    IL_0001: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0006: stfld PerkManager PerkSelectionGroup::perkManager  /*0x04000AEC*/
    IL_000b: ldc.i4.0
    IL_000c: stloc.0
    IL_000d: ldarg.0
    IL_000e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0013: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0018: ldc.i4.1
    IL_0019: sub
    IL_001a: stloc.1
    IL_001b: br.s IL_0037
    IL_001d: ldarg.0
    IL_001e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0023: ldloc.1
    IL_0024: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0029: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0033: ldloc.1
    IL_0034: ldc.i4.1
    IL_0035: sub
    IL_0036: stloc.1
    IL_0037: ldloc.1
    IL_0038: ldc.i4.0
    IL_0039: bge.s IL_001d
    IL_003b: ldarg.0
    IL_003c: ldc.i4.0
    IL_003d: stfld int PerkSelectionGroup::unlockedPerks  /*0x04000AF6*/
    IL_0042: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0047: ldfld List<Equippable> PerkManager::allEquippables  /*0x04000BE8*/
    IL_004c: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_0051: stloc.2
    IL_0052: br IL_010e
    IL_0057: ldloca.s 2
    IL_0059: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_005e: stloc.3
    IL_005f: ldloc.3
    IL_0060: callvirt bool Equippable::get_IsUnlocked()  /*0x06000B54*/
    IL_0065: brfalse IL_010e
    IL_006a: ldloc.3
    IL_006b: callvirt Type System.Object::GetType()  /*0x0A0002B4*/
    IL_0070: ldtoken PerkPoint  /*0x0200021C*/
    IL_0075: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_007a: call bool System.Type::op_Equality(System.Type,System.Type)  /*0x0A0002B6*/
    IL_007f: brfalse.s IL_0085
    IL_0081: ldloc.0
    IL_0082: ldc.i4.1
    IL_0083: add
    IL_0084: stloc.0
    IL_0085: ldarg.0
    IL_0086: ldfld PerkSelectionGroup.Type PerkSelectionGroup::type  /*0x04000AEB*/
    IL_008b: brtrue.s IL_00a4
    IL_008d: ldloc.3
    IL_008e: callvirt Type System.Object::GetType()  /*0x0A0002B4*/
    IL_0093: ldtoken EquippableWeapon  /*0x0200021B*/
    IL_0098: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_009d: call bool System.Type::op_Equality(System.Type,System.Type)  /*0x0A0002B6*/
    IL_00a2: brtrue.s IL_00e4
    IL_00a4: ldarg.0
    IL_00a5: ldfld PerkSelectionGroup.Type PerkSelectionGroup::type  /*0x04000AEB*/
    IL_00aa: ldc.i4.1
    IL_00ab: bne.un.s IL_00c4
    IL_00ad: ldloc.3
    IL_00ae: callvirt Type System.Object::GetType()  /*0x0A0002B4*/
    IL_00b3: ldtoken EquippablePerk  /*0x0200021A*/
    IL_00b8: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_00bd: call bool System.Type::op_Equality(System.Type,System.Type)  /*0x0A0002B6*/
    IL_00c2: brtrue.s IL_00e4
    IL_00c4: ldarg.0
    IL_00c5: ldfld PerkSelectionGroup.Type PerkSelectionGroup::type  /*0x04000AEB*/
    IL_00ca: ldc.i4.2
    IL_00cb: bne.un.s IL_010e
    IL_00cd: ldloc.3
    IL_00ce: callvirt Type System.Object::GetType()  /*0x0A0002B4*/
    IL_00d3: ldtoken EquippableMutation  /*0x02000219*/
    IL_00d8: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_00dd: call bool System.Type::op_Equality(System.Type,System.Type)  /*0x0A0002B6*/
    IL_00e2: brfalse.s IL_010e
    IL_00e4: ldarg.0
    IL_00e5: ldfld GameObject PerkSelectionGroup::perkSelectionItemPrefab  /*0x04000AE9*/
    IL_00ea: ldarg.0
    IL_00eb: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00f0: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_00f5: callvirt !!0 UnityEngine.GameObject::GetComponent()<PerkSelectionItem>  /*0x2B000096*/
    IL_00fa: ldloc.3
    IL_00fb: callvirt void PerkSelectionItem::Initialize(Equippable)  /*0x060008C2*/
    IL_0100: ldarg.0
    IL_0101: ldarg.0
    IL_0102: ldfld int PerkSelectionGroup::unlockedPerks  /*0x04000AF6*/
    IL_0107: ldc.i4.1
    IL_0108: add
    IL_0109: stfld int PerkSelectionGroup::unlockedPerks  /*0x04000AF6*/
    IL_010e: ldloca.s 2
    IL_0110: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_0115: brtrue IL_0057
    IL_011a: leave.s IL_012a
    IL_011c: ldloca.s 2
    IL_011e: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_0124: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0129: endfinally
    IL_012a: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_012f: ldfld List<Equippable> PerkManager::allEquippables  /*0x04000BE8*/
    IL_0134: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_0139: stloc.2
    IL_013a: br IL_01c5
    IL_013f: ldloca.s 2
    IL_0141: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_0146: stloc.s 4
    IL_0148: ldarg.0
    IL_0149: ldfld PerkSelectionGroup.Type PerkSelectionGroup::type  /*0x04000AEB*/
    IL_014e: brtrue.s IL_0168
    IL_0150: ldloc.s 4
    IL_0152: callvirt Type System.Object::GetType()  /*0x0A0002B4*/
    IL_0157: ldtoken EquippableWeapon  /*0x0200021B*/
    IL_015c: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_0161: call bool System.Type::op_Equality(System.Type,System.Type)  /*0x0A0002B6*/
    IL_0166: brtrue.s IL_01aa
    IL_0168: ldarg.0
    IL_0169: ldfld PerkSelectionGroup.Type PerkSelectionGroup::type  /*0x04000AEB*/
    IL_016e: ldc.i4.1
    IL_016f: bne.un.s IL_0189
    IL_0171: ldloc.s 4
    IL_0173: callvirt Type System.Object::GetType()  /*0x0A0002B4*/
    IL_0178: ldtoken EquippablePerk  /*0x0200021A*/
    IL_017d: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_0182: call bool System.Type::op_Equality(System.Type,System.Type)  /*0x0A0002B6*/
    IL_0187: brtrue.s IL_01aa
    IL_0189: ldarg.0
    IL_018a: ldfld PerkSelectionGroup.Type PerkSelectionGroup::type  /*0x04000AEB*/
    IL_018f: ldc.i4.2
    IL_0190: bne.un.s IL_01c5
    IL_0192: ldloc.s 4
    IL_0194: callvirt Type System.Object::GetType()  /*0x0A0002B4*/
    IL_0199: ldtoken EquippableMutation  /*0x02000219*/
    IL_019e: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_01a3: call bool System.Type::op_Equality(System.Type,System.Type)  /*0x0A0002B6*/
    IL_01a8: brfalse.s IL_01c5
    IL_01aa: ldloc.s 4
    IL_01ac: callvirt bool Equippable::get_IsUnlocked()  /*0x06000B54*/
    IL_01b1: brtrue.s IL_01c5
    IL_01b3: ldarg.0
    IL_01b4: ldfld GameObject PerkSelectionGroup::perkLockedPrefab  /*0x04000AEA*/
    IL_01b9: ldarg.0
    IL_01ba: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01bf: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_01c4: pop
    IL_01c5: ldloca.s 2
    IL_01c7: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_01cc: brtrue IL_013f
    IL_01d1: leave.s IL_01e1
    IL_01d3: ldloca.s 2
    IL_01d5: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_01db: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01e0: endfinally
    IL_01e1: ldarg.0
    IL_01e2: ldfld PerkSelectionGroup.Type PerkSelectionGroup::type  /*0x04000AEB*/
    IL_01e7: ldc.i4.3
    IL_01e8: bne.un.s IL_0262
    IL_01ea: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_01ef: ldnull
    IL_01f0: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_01f5: brfalse.s IL_0262
    IL_01f7: ldarg.0
    IL_01f8: ldc.i4.0
    IL_01f9: stfld int PerkSelectionGroup::selectableAmount  /*0x04000AED*/
    IL_01fe: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_0203: stloc.s 5
    IL_0205: ldc.i4.0
    IL_0206: stloc.s 6
    IL_0208: br.s IL_0252
    IL_020a: ldloc.s 5
    IL_020c: ldfld List<Equippable> LevelInfo::fixedLoadout  /*0x04000B2A*/
    IL_0211: ldloc.s 6
    IL_0213: callvirt !0 System.Collections.Generic.List<Equippable>::get_Item(int)  /*0x0A0002DA*/
    IL_0218: stloc.s 7
    IL_021a: ldarg.0
    IL_021b: ldfld GameObject PerkSelectionGroup::perkSelectionItemPrefab  /*0x04000AE9*/
    IL_0220: ldarg.0
    IL_0221: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0226: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_022b: callvirt !!0 UnityEngine.GameObject::GetComponent()<PerkSelectionItem>  /*0x2B000096*/
    IL_0230: dup
    IL_0231: ldc.i4.1
    IL_0232: callvirt void PerkSelectionItem::set_Selected(bool)  /*0x060008C0*/
    IL_0237: ldloc.s 7
    IL_0239: callvirt void PerkSelectionItem::Initialize(Equippable)  /*0x060008C2*/
    IL_023e: ldarg.0
    IL_023f: ldarg.0
    IL_0240: ldfld int PerkSelectionGroup::selectableAmount  /*0x04000AED*/
    IL_0245: ldc.i4.1
    IL_0246: add
    IL_0247: stfld int PerkSelectionGroup::selectableAmount  /*0x04000AED*/
    IL_024c: ldloc.s 6
    IL_024e: ldc.i4.1
    IL_024f: add
    IL_0250: stloc.s 6
    IL_0252: ldloc.s 6
    IL_0254: ldloc.s 5
    IL_0256: ldfld List<Equippable> LevelInfo::fixedLoadout  /*0x04000B2A*/
    IL_025b: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_0260: blt.s IL_020a
    IL_0262: ldarg.0
    IL_0263: ldfld PerkSelectionGroup.Type PerkSelectionGroup::type  /*0x04000AEB*/
    IL_0268: brtrue.s IL_0271
    IL_026a: ldarg.0
    IL_026b: ldc.i4.1
    IL_026c: stfld int PerkSelectionGroup::selectableAmount  /*0x04000AED*/
    IL_0271: ldarg.0
    IL_0272: ldfld PerkSelectionGroup.Type PerkSelectionGroup::type  /*0x04000AEB*/
    IL_0277: ldc.i4.1
    IL_0278: bne.un.s IL_0281
    IL_027a: ldarg.0
    IL_027b: ldloc.0
    IL_027c: stfld int PerkSelectionGroup::selectableAmount  /*0x04000AED*/
    IL_0281: ldarg.0
    IL_0282: ldfld PerkSelectionGroup.Type PerkSelectionGroup::type  /*0x04000AEB*/
    IL_0287: ldc.i4.2
    IL_0288: bne.un.s IL_0295
    IL_028a: ldarg.0
    IL_028b: ldc.i4 10000
    IL_0290: stfld int PerkSelectionGroup::selectableAmount  /*0x04000AED*/
    IL_0295: ldarg.0
    IL_0296: ldfld int PerkSelectionGroup::selectableAmount  /*0x04000AED*/
    IL_029b: ldc.i4.0
    IL_029c: ble.s IL_02a7
    IL_029e: ldarg.0
    IL_029f: ldfld int PerkSelectionGroup::unlockedPerks  /*0x04000AF6*/
    IL_02a4: ldc.i4.0
    IL_02a5: bgt.s IL_02b9
    IL_02a7: ldarg.0
    IL_02a8: ldfld TMP_Text PerkSelectionGroup::headerText  /*0x04000AEF*/
    IL_02ad: ldarg.0
    IL_02ae: ldfld string PerkSelectionGroup::selectNone  /*0x04000AF0*/
    IL_02b3: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_02b8: ret
    IL_02b9: ldarg.0
    IL_02ba: ldfld int PerkSelectionGroup::selectableAmount  /*0x04000AED*/
    IL_02bf: ldc.i4.1
    IL_02c0: bne.un.s IL_02d4
    IL_02c2: ldarg.0
    IL_02c3: ldfld TMP_Text PerkSelectionGroup::headerText  /*0x04000AEF*/
    IL_02c8: ldarg.0
    IL_02c9: ldfld string PerkSelectionGroup::selectOne  /*0x04000AF1*/
    IL_02ce: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_02d3: ret
    IL_02d4: ldarg.0
    IL_02d5: ldfld TMP_Text PerkSelectionGroup::headerText  /*0x04000AEF*/
    IL_02da: ldarg.0
    IL_02db: ldfld string PerkSelectionGroup::selectMulti  /*0x04000AF2*/
    IL_02e0: ldstr "<n>"
    IL_02e5: ldarg.0
    IL_02e6: ldflda int PerkSelectionGroup::selectableAmount  /*0x04000AED*/
    IL_02eb: call string System.Int32::ToString()  /*0x0A000031*/
    IL_02f0: callvirt string System.String::Replace(string,string)  /*0x0A0003CD*/
    IL_02f5: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_02fa: ret
    .try IL_0052-IL_011c finally handler IL_011c-IL_012a
    .try IL_013a-IL_01d3 finally handler IL_01d3-IL_01e1

  .method PerkSelectionGroup::Update()  // token 0x060008B9 rva 0x2a344 attrs Private, HideBySig
    // code size 66 (0x42), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld List<PerkSelectionItem> PerkSelectionGroup::selectedInMyGroup  /*0x04000AEE*/
    IL_0006: callvirt int System.Collections.Generic.List<PerkSelectionItem>::get_Count()  /*0x0A0003CE*/
    IL_000b: ldarg.0
    IL_000c: ldfld int PerkSelectionGroup::unlockedPerks  /*0x04000AF6*/
    IL_0011: ldarg.0
    IL_0012: ldfld int PerkSelectionGroup::selectableAmount  /*0x04000AED*/
    IL_0017: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_001c: bge.s IL_0030
    IL_001e: ldarg.0
    IL_001f: ldfld TMP_Text PerkSelectionGroup::headerText  /*0x04000AEF*/
    IL_0024: ldarg.0
    IL_0025: ldfld Color PerkSelectionGroup::textColorWarning  /*0x04000AF5*/
    IL_002a: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_002f: ret
    IL_0030: ldarg.0
    IL_0031: ldfld TMP_Text PerkSelectionGroup::headerText  /*0x04000AEF*/
    IL_0036: ldarg.0
    IL_0037: ldfld Color PerkSelectionGroup::textColorNormal  /*0x04000AF4*/
    IL_003c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0041: ret

  .method PerkSelectionGroup::SelectPerk(PerkSelectionItem)  // token 0x060008BA rva 0x2a394 attrs Public, HideBySig
    // code size 214 (0xd6), max stack 3, init locals
    .locals ([0] PerkSelectionItem)
    IL_0000: ldarg.0
    IL_0001: ldfld bool PerkSelectionGroup::canDeselectPerks  /*0x04000AF3*/
    IL_0006: brtrue.s IL_0011
    IL_0008: ldarg.1
    IL_0009: callvirt bool PerkSelectionItem::get_Selected()  /*0x060008BF*/
    IL_000e: brfalse.s IL_0011
    IL_0010: ret
    IL_0011: ldarg.1
    IL_0012: ldarg.1
    IL_0013: callvirt bool PerkSelectionItem::get_Selected()  /*0x060008BF*/
    IL_0018: ldc.i4.0
    IL_0019: ceq
    IL_001b: callvirt void PerkSelectionItem::set_Selected(bool)  /*0x060008C0*/
    IL_0020: ldarg.1
    IL_0021: callvirt bool PerkSelectionItem::get_Selected()  /*0x060008BF*/
    IL_0026: brfalse IL_00b1
    IL_002b: ldarg.0
    IL_002c: ldfld List<PerkSelectionItem> PerkSelectionGroup::selectedInMyGroup  /*0x04000AEE*/
    IL_0031: ldarg.1
    IL_0032: callvirt void System.Collections.Generic.List<PerkSelectionItem>::Add(!0)  /*0x0A0003CF*/
    IL_0037: ldarg.0
    IL_0038: ldfld PerkManager PerkSelectionGroup::perkManager  /*0x04000AEC*/
    IL_003d: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_0042: ldarg.1
    IL_0043: callvirt Equippable PerkSelectionItem::get_Equippable()  /*0x060008BC*/
    IL_0048: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_004d: brtrue.s IL_0065
    IL_004f: ldarg.0
    IL_0050: ldfld PerkManager PerkSelectionGroup::perkManager  /*0x04000AEC*/
    IL_0055: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_005a: ldarg.1
    IL_005b: callvirt Equippable PerkSelectionItem::get_Equippable()  /*0x060008BC*/
    IL_0060: callvirt void System.Collections.Generic.List<Equippable>::Add(!0)  /*0x0A0003D0*/
    IL_0065: ldarg.0
    IL_0066: ldfld List<PerkSelectionItem> PerkSelectionGroup::selectedInMyGroup  /*0x04000AEE*/
    IL_006b: callvirt int System.Collections.Generic.List<PerkSelectionItem>::get_Count()  /*0x0A0003CE*/
    IL_0070: ldarg.0
    IL_0071: ldfld int PerkSelectionGroup::selectableAmount  /*0x04000AED*/
    IL_0076: ble.s IL_00d5
    IL_0078: ldarg.0
    IL_0079: ldfld List<PerkSelectionItem> PerkSelectionGroup::selectedInMyGroup  /*0x04000AEE*/
    IL_007e: ldc.i4.0
    IL_007f: callvirt !0 System.Collections.Generic.List<PerkSelectionItem>::get_Item(int)  /*0x0A0003D1*/
    IL_0084: stloc.0
    IL_0085: ldloc.0
    IL_0086: ldc.i4.0
    IL_0087: callvirt void PerkSelectionItem::set_Selected(bool)  /*0x060008C0*/
    IL_008c: ldarg.0
    IL_008d: ldfld List<PerkSelectionItem> PerkSelectionGroup::selectedInMyGroup  /*0x04000AEE*/
    IL_0092: ldloc.0
    IL_0093: callvirt bool System.Collections.Generic.List<PerkSelectionItem>::Remove(!0)  /*0x0A0003D2*/
    IL_0098: pop
    IL_0099: ldarg.0
    IL_009a: ldfld PerkManager PerkSelectionGroup::perkManager  /*0x04000AEC*/
    IL_009f: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_00a4: ldloc.0
    IL_00a5: callvirt Equippable PerkSelectionItem::get_Equippable()  /*0x060008BC*/
    IL_00aa: callvirt bool System.Collections.Generic.List<Equippable>::Remove(!0)  /*0x0A0003D3*/
    IL_00af: pop
    IL_00b0: ret
    IL_00b1: ldarg.0
    IL_00b2: ldfld List<PerkSelectionItem> PerkSelectionGroup::selectedInMyGroup  /*0x04000AEE*/
    IL_00b7: ldarg.1
    IL_00b8: callvirt bool System.Collections.Generic.List<PerkSelectionItem>::Remove(!0)  /*0x0A0003D2*/
    IL_00bd: pop
    IL_00be: ldarg.0
    IL_00bf: ldfld PerkManager PerkSelectionGroup::perkManager  /*0x04000AEC*/
    IL_00c4: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_00c9: ldarg.1
    IL_00ca: callvirt Equippable PerkSelectionItem::get_Equippable()  /*0x060008BC*/
    IL_00cf: callvirt bool System.Collections.Generic.List<Equippable>::Remove(!0)  /*0x0A0003D3*/
    IL_00d4: pop
    IL_00d5: ret

  .method PerkSelectionGroup::.ctor()  // token 0x060008BB rva 0x2a478 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 91 (0x5b), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4 10000
    IL_0006: stfld int PerkSelectionGroup::selectableAmount  /*0x04000AED*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<PerkSelectionItem>::.ctor()  /*0x0A0003D4*/
    IL_0011: stfld List<PerkSelectionItem> PerkSelectionGroup::selectedInMyGroup  /*0x04000AEE*/
    IL_0016: ldarg.0
    IL_0017: ldstr "No perks unlocked yet."
    IL_001c: stfld string PerkSelectionGroup::selectNone  /*0x04000AF0*/
    IL_0021: ldarg.0
    IL_0022: ldstr "Select one perk."
    IL_0027: stfld string PerkSelectionGroup::selectOne  /*0x04000AF1*/
    IL_002c: ldarg.0
    IL_002d: ldstr "Select <n> perks."
    IL_0032: stfld string PerkSelectionGroup::selectMulti  /*0x04000AF2*/
    IL_0037: ldarg.0
    IL_0038: ldc.i4.1
    IL_0039: stfld bool PerkSelectionGroup::canDeselectPerks  /*0x04000AF3*/
    IL_003e: ldarg.0
    IL_003f: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0044: stfld Color PerkSelectionGroup::textColorNormal  /*0x04000AF4*/
    IL_0049: ldarg.0
    IL_004a: call Color UnityEngine.Color::get_red()  /*0x0A00015E*/
    IL_004f: stfld Color PerkSelectionGroup::textColorWarning  /*0x04000AF5*/
    IL_0054: ldarg.0
    IL_0055: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_005a: ret

// ===== PerkSelectionGroup/Type  (token 0x020001AD) =====
