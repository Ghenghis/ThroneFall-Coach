// ===== Shrine  (token 0x0200028F) =====
  .method Shrine::get_CollectionRange()  // token 0x06000E10 rva 0x3efa6 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float Shrine::collectionRange  /*0x04001063*/
    IL_0006: ret

  .method Shrine::set_CollectionRange(float)  // token 0x06000E11 rva 0x3efae attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float Shrine::collectionRange  /*0x04001063*/
    IL_0007: ret

  .method Shrine::get_IncomeOnceUnlocked()  // token 0x06000E12 rva 0x3efb7 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int Shrine::incomeOnceUnlocked  /*0x04001064*/
    IL_0006: ret

  .method Shrine::get_ParentBuildSlot()  // token 0x06000E13 rva 0x3efbf attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot Shrine::parentBuildSlot  /*0x04001068*/
    IL_0006: ret

  .method Shrine::get_ShrineHasBeenActivated()  // token 0x06000E14 rva 0x3efc7 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool Shrine::shrineHasBeenActivated  /*0x0400106C*/
    IL_0006: ret

  .method Shrine::Start()  // token 0x06000E15 rva 0x3efcf attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0f
    IL_0006: call void Shrine::MakeProgressAndUpdateBar(float)  /*0x06000E17*/
    IL_000b: ret

  .method Shrine::AdjustRequiredXp(float)  // token 0x06000E16 rva 0x3efdc attrs Public, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float Shrine::maxXp  /*0x04001062*/
    IL_0007: ldarg.1
    IL_0008: mul
    IL_0009: stfld float Shrine::maxXp  /*0x04001062*/
    IL_000e: ldarg.0
    IL_000f: ldc.r4 0f
    IL_0014: call void Shrine::MakeProgressAndUpdateBar(float)  /*0x06000E17*/
    IL_0019: ret

  .method Shrine::MakeProgressAndUpdateBar(float)  // token 0x06000E17 rva 0x3eff8 attrs Public, HideBySig
    // code size 87 (0x57), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool Shrine::shrineHasBeenActivated  /*0x0400106C*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: ldfld float Shrine::currentXp  /*0x04001061*/
    IL_0010: ldarg.1
    IL_0011: add
    IL_0012: stfld float Shrine::currentXp  /*0x04001061*/
    IL_0017: ldarg.0
    IL_0018: ldfld ParticleSystem Shrine::levelParticle  /*0x0400106B*/
    IL_001d: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_0022: ldarg.0
    IL_0023: ldfld float Shrine::currentXp  /*0x04001061*/
    IL_0028: ldarg.0
    IL_0029: ldfld float Shrine::maxXp  /*0x04001062*/
    IL_002e: blt.un.s IL_0038
    IL_0030: ldarg.0
    IL_0031: ldc.i4.0
    IL_0032: call void Shrine::ActivateShrine(bool)  /*0x06000E19*/
    IL_0037: ret
    IL_0038: ldarg.0
    IL_0039: ldfld ProductionBar Shrine::productionBar  /*0x04001060*/
    IL_003e: ldarg.0
    IL_003f: ldfld float Shrine::currentXp  /*0x04001061*/
    IL_0044: ldarg.0
    IL_0045: ldfld float Shrine::maxXp  /*0x04001062*/
    IL_004a: div
    IL_004b: ldc.r4 0.001f
    IL_0050: add
    IL_0051: callvirt void ProductionBar::UpdateVisual(float)  /*0x06000C97*/
    IL_0056: ret

  .method Shrine::DebugActivate()  // token 0x06000E18 rva 0x3f05b attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: call void Shrine::ActivateShrine(bool)  /*0x06000E19*/
    IL_0007: ret

  .method Shrine::ActivateShrine(bool)  // token 0x06000E19 rva 0x3f064 attrs Private, HideBySig
    // code size 448 (0x1c0), max stack 4, init locals
    .locals ([0] List.Enumerator<GameObject>, [1] List.Enumerator<TaggedObject>, [2] Shrine, [3] Shrine)
    IL_0000: ldarg.0
    IL_0001: ldfld bool Shrine::shrineHasBeenActivated  /*0x0400106C*/
    IL_0006: brfalse.s IL_000c
    IL_0008: ldarg.1
    IL_0009: brtrue.s IL_000c
    IL_000b: ret
    IL_000c: ldsfld TagManager Shrine::tagManager  /*0x0400105B*/
    IL_0011: ldnull
    IL_0012: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0017: brfalse.s IL_0023
    IL_0019: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_001e: stsfld TagManager Shrine::tagManager  /*0x0400105B*/
    IL_0023: ldarg.0
    IL_0024: ldfld ParticleSystem Shrine::upgradeParticles  /*0x0400106A*/
    IL_0029: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_002e: ldarg.0
    IL_002f: ldfld List<GameObject> Shrine::disableOnComplete  /*0x04001066*/
    IL_0034: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_0039: stloc.0
    IL_003a: br.s IL_0049
    IL_003c: ldloca.s 0
    IL_003e: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_0043: ldc.i4.0
    IL_0044: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0049: ldloca.s 0
    IL_004b: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_0050: brtrue.s IL_003c
    IL_0052: leave.s IL_0062
    IL_0054: ldloca.s 0
    IL_0056: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_005c: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0061: endfinally
    IL_0062: ldarg.0
    IL_0063: ldfld List<GameObject> Shrine::enableOnComplete  /*0x04001067*/
    IL_0068: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_006d: stloc.0
    IL_006e: br.s IL_007d
    IL_0070: ldloca.s 0
    IL_0072: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_0077: ldc.i4.1
    IL_0078: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_007d: ldloca.s 0
    IL_007f: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_0084: brtrue.s IL_0070
    IL_0086: leave.s IL_0096
    IL_0088: ldloca.s 0
    IL_008a: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_0090: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0095: endfinally
    IL_0096: ldarg.0
    IL_0097: call !!0 UnityEngine.Component::GetComponentInParent()<BuildSlot>  /*0x2B000004*/
    IL_009c: dup
    IL_009d: callvirt int BuildSlot::get_GoldIncome()  /*0x060002DA*/
    IL_00a2: ldarg.0
    IL_00a3: ldfld int Shrine::incomeOnceUnlocked  /*0x04001064*/
    IL_00a8: add
    IL_00a9: callvirt void BuildSlot::set_GoldIncome(int)  /*0x060002DB*/
    IL_00ae: ldarg.0
    IL_00af: ldfld BuildSlot Shrine::parentBuildSlot  /*0x04001068*/
    IL_00b4: ldarg.0
    IL_00b5: ldfld Mesh Shrine::replacementMesh  /*0x04001069*/
    IL_00ba: callvirt void BuildSlot::ReplaceMeshExternal(UnityEngine.Mesh)  /*0x060002FC*/
    IL_00bf: ldarg.0
    IL_00c0: ldc.i4.1
    IL_00c1: stfld bool Shrine::shrineHasBeenActivated  /*0x0400106C*/
    IL_00c6: ldsfld List<TagManager.ETag> Shrine::mustHaveTags  /*0x0400105E*/
    IL_00cb: callvirt int System.Collections.Generic.List<TagManager.ETag>::get_Count()  /*0x0A00019C*/
    IL_00d0: ldc.i4.1
    IL_00d1: bne.un.s IL_00df
    IL_00d3: ldsfld TagManager Shrine::tagManager  /*0x0400105B*/
    IL_00d8: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00dd: brtrue.s IL_0109
    IL_00df: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_00e4: stsfld TagManager Shrine::tagManager  /*0x0400105B*/
    IL_00e9: ldsfld List<TagManager.ETag> Shrine::mustHaveTags  /*0x0400105E*/
    IL_00ee: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_00f3: ldsfld List<TagManager.ETag> Shrine::mustHaveTags  /*0x0400105E*/
    IL_00f8: ldc.i4.s 35
    IL_00fa: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_00ff: ldsfld List<TagManager.ETag> Shrine::mayNotHaveTags  /*0x0400105F*/
    IL_0104: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_0109: ldsfld TagManager Shrine::tagManager  /*0x0400105B*/
    IL_010e: ldsfld List<TaggedObject> Shrine::shrinesFoundB  /*0x0400105D*/
    IL_0113: ldsfld List<TagManager.ETag> Shrine::mustHaveTags  /*0x0400105E*/
    IL_0118: ldsfld List<TagManager.ETag> Shrine::mayNotHaveTags  /*0x0400105F*/
    IL_011d: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0122: ldarg.1
    IL_0123: brtrue.s IL_0175
    IL_0125: ldsfld List<TaggedObject> Shrine::shrinesFoundB  /*0x0400105D*/
    IL_012a: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_012f: stloc.1
    IL_0130: br.s IL_015c
    IL_0132: ldloca.s 1
    IL_0134: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_0139: callvirt !!0 UnityEngine.Component::GetComponent()<Shrine>  /*0x2B0000C9*/
    IL_013e: stloc.2
    IL_013f: ldloc.2
    IL_0140: ldarg.0
    IL_0141: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0146: brtrue.s IL_015c
    IL_0148: ldloc.2
    IL_0149: callvirt bool Shrine::get_ShrineHasBeenActivated()  /*0x06000E14*/
    IL_014e: brfalse.s IL_015c
    IL_0150: ldarg.0
    IL_0151: call void Shrine::UpgradeMyPower()  /*0x06000E20*/
    IL_0156: ldloc.2
    IL_0157: callvirt void Shrine::UpgradeMyPower()  /*0x06000E20*/
    IL_015c: ldloca.s 1
    IL_015e: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0163: brtrue.s IL_0132
    IL_0165: leave.s IL_01bf
    IL_0167: ldloca.s 1
    IL_0169: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_016f: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0174: endfinally
    IL_0175: ldsfld List<TaggedObject> Shrine::shrinesFoundB  /*0x0400105D*/
    IL_017a: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_017f: stloc.1
    IL_0180: br.s IL_01a6
    IL_0182: ldloca.s 1
    IL_0184: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_0189: callvirt !!0 UnityEngine.Component::GetComponent()<Shrine>  /*0x2B0000C9*/
    IL_018e: stloc.3
    IL_018f: ldloc.3
    IL_0190: ldarg.0
    IL_0191: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0196: brtrue.s IL_01a6
    IL_0198: ldloc.3
    IL_0199: callvirt bool Shrine::get_ShrineHasBeenActivated()  /*0x06000E14*/
    IL_019e: brfalse.s IL_01a6
    IL_01a0: ldarg.0
    IL_01a1: call void Shrine::UpgradeMyPower()  /*0x06000E20*/
    IL_01a6: ldloca.s 1
    IL_01a8: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_01ad: brtrue.s IL_0182
    IL_01af: leave.s IL_01bf
    IL_01b1: ldloca.s 1
    IL_01b3: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_01b9: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01be: endfinally
    IL_01bf: ret
    .try IL_003a-IL_0054 finally handler IL_0054-IL_0062
    .try IL_006e-IL_0088 finally handler IL_0088-IL_0096
    .try IL_0130-IL_0167 finally handler IL_0167-IL_0175
    .try IL_0180-IL_01b1 finally handler IL_01b1-IL_01bf

  .method Shrine::DeathOfUnitAt(UnityEngine.Vector3,float)  // token 0x06000E1A rva 0x3f264 attrs Public, Static, HideBySig
    // code size 171 (0xab), max stack 4, init locals
    .locals ([0] List.Enumerator<TaggedObject>, [1] Shrine, [2] Vector3)
    IL_0000: ldsfld TagManager Shrine::tagManager  /*0x0400105B*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brtrue.s IL_0036
    IL_000c: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0011: stsfld TagManager Shrine::tagManager  /*0x0400105B*/
    IL_0016: ldsfld List<TagManager.ETag> Shrine::mustHaveTags  /*0x0400105E*/
    IL_001b: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_0020: ldsfld List<TagManager.ETag> Shrine::mustHaveTags  /*0x0400105E*/
    IL_0025: ldc.i4.s 35
    IL_0027: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_002c: ldsfld List<TagManager.ETag> Shrine::mayNotHaveTags  /*0x0400105F*/
    IL_0031: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_0036: ldsfld TagManager Shrine::tagManager  /*0x0400105B*/
    IL_003b: ldsfld List<TaggedObject> Shrine::shrinesFound  /*0x0400105C*/
    IL_0040: ldsfld List<TagManager.ETag> Shrine::mustHaveTags  /*0x0400105E*/
    IL_0045: ldsfld List<TagManager.ETag> Shrine::mayNotHaveTags  /*0x0400105F*/
    IL_004a: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_004f: ldsfld List<TaggedObject> Shrine::shrinesFound  /*0x0400105C*/
    IL_0054: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0059: stloc.0
    IL_005a: br.s IL_0091
    IL_005c: ldloca.s 0
    IL_005e: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_0063: callvirt Shrine TaggedObject::get_Shrine()  /*0x06000E42*/
    IL_0068: stloc.1
    IL_0069: ldarg.0
    IL_006a: ldloc.1
    IL_006b: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0070: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0075: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_007a: stloc.2
    IL_007b: ldloca.s 2
    IL_007d: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0082: ldloc.1
    IL_0083: ldfld float Shrine::collectionRange  /*0x04001063*/
    IL_0088: bgt.un.s IL_0091
    IL_008a: ldloc.1
    IL_008b: ldarg.1
    IL_008c: callvirt void Shrine::MakeProgressAndUpdateBar(float)  /*0x06000E17*/
    IL_0091: ldloca.s 0
    IL_0093: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0098: brtrue.s IL_005c
    IL_009a: leave.s IL_00aa
    IL_009c: ldloca.s 0
    IL_009e: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_00a4: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00a9: endfinally
    IL_00aa: ret
    .try IL_005a-IL_009c finally handler IL_009c-IL_00aa

  .method Shrine::OnBeforeMainLoadPass(string)  // token 0x06000E1B rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Shrine::OnAfterMainLoadPass(string)  // token 0x06000E1C rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Shrine::OnSave(string)  // token 0x06000E1D rva 0x3f32c attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldstr "currentXp"
    IL_0006: ldarg.0
    IL_0007: ldfld float Shrine::currentXp  /*0x04001061*/
    IL_000c: call void MatchSaveLoadHandler::SaveValue(string,string,float)  /*0x06000CF7*/
    IL_0011: ldarg.1
    IL_0012: ldstr "shrineHasBeenActivated"
    IL_0017: ldarg.0
    IL_0018: ldfld bool Shrine::shrineHasBeenActivated  /*0x0400106C*/
    IL_001d: call void MatchSaveLoadHandler::SaveValue(string,string,bool)  /*0x06000CF8*/
    IL_0022: ret

  .method Shrine::OnLoad(string)  // token 0x06000E1E rva 0x3f350 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 58 (0x3a), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldstr "currentXp"
    IL_0006: ldarg.0
    IL_0007: ldflda float Shrine::currentXp  /*0x04001061*/
    IL_000c: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<float>  /*0x2B0000CA*/
    IL_0011: pop
    IL_0012: ldarg.1
    IL_0013: ldstr "shrineHasBeenActivated"
    IL_0018: ldarg.0
    IL_0019: ldflda bool Shrine::shrineHasBeenActivated  /*0x0400106C*/
    IL_001e: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<bool>  /*0x2B000047*/
    IL_0023: pop
    IL_0024: ldarg.0
    IL_0025: ldfld bool Shrine::shrineHasBeenActivated  /*0x0400106C*/
    IL_002a: brfalse.s IL_0039
    IL_002c: ldarg.0
    IL_002d: ldarg.0
    IL_002e: call IEnumerator Shrine::ActivateShrineDelayedInSaveLoad()  /*0x06000E1F*/
    IL_0033: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0038: pop
    IL_0039: ret

  .method Shrine::ActivateShrineDelayedInSaveLoad()  // token 0x06000E1F rva 0x3f38b attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void Shrine.<ActivateShrineDelayedInSaveLoad>d__37::.ctor(int)  /*0x06000E23*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld Shrine Shrine.<ActivateShrineDelayedInSaveLoad>d__37::<>4__this  /*0x0400106F*/
    IL_000d: ret

  .method Shrine::UpgradeMyPower()  // token 0x06000E20 rva 0x3f39c attrs Public, HideBySig
    // code size 43 (0x2b), max stack 3, init locals
    .locals ([0] AutoAttack[], [1] int)
    IL_0000: ldarg.0
    IL_0001: call !!0[] UnityEngine.Component::GetComponentsInChildren()<AutoAttack>  /*0x2B000015*/
    IL_0006: stloc.0
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: br.s IL_0024
    IL_000b: ldloc.0
    IL_000c: ldloc.1
    IL_000d: ldelem.ref
    IL_000e: dup
    IL_000f: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_0014: ldarg.0
    IL_0015: ldfld float Shrine::strengthBonusOnAdditionalShrine  /*0x04001065*/
    IL_001a: mul
    IL_001b: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_0020: ldloc.1
    IL_0021: ldc.i4.1
    IL_0022: add
    IL_0023: stloc.1
    IL_0024: ldloc.1
    IL_0025: ldloc.0
    IL_0026: ldlen
    IL_0027: conv.i4
    IL_0028: blt.s IL_000b
    IL_002a: ret

  .method Shrine::.ctor()  // token 0x06000E21 rva 0x3f3d3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 47 (0x2f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1000f
    IL_0006: stfld float Shrine::maxXp  /*0x04001062*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 10f
    IL_0011: stfld float Shrine::collectionRange  /*0x04001063*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.2
    IL_0018: stfld int Shrine::incomeOnceUnlocked  /*0x04001064*/
    IL_001d: ldarg.0
    IL_001e: ldc.r4 1.2f
    IL_0023: stfld float Shrine::strengthBonusOnAdditionalShrine  /*0x04001065*/
    IL_0028: ldarg.0
    IL_0029: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_002e: ret

  .method Shrine::.cctor()  // token 0x06000E22 rva 0x3f403 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 41 (0x29), max stack 8
    IL_0000: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0005: stsfld List<TaggedObject> Shrine::shrinesFound  /*0x0400105C*/
    IL_000a: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_000f: stsfld List<TaggedObject> Shrine::shrinesFoundB  /*0x0400105D*/
    IL_0014: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0019: stsfld List<TagManager.ETag> Shrine::mustHaveTags  /*0x0400105E*/
    IL_001e: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0023: stsfld List<TagManager.ETag> Shrine::mayNotHaveTags  /*0x0400105F*/
    IL_0028: ret

// ===== Shrine/<ActivateShrineDelayedInSaveLoad>d__37  (token 0x02000290) =====
  .method Shrine.<ActivateShrineDelayedInSaveLoad>d__37::.ctor(int)  // token 0x06000E23 rva 0x3f42d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int Shrine.<ActivateShrineDelayedInSaveLoad>d__37::<>1__state  /*0x0400106D*/
    IL_000d: ret

  .method Shrine.<ActivateShrineDelayedInSaveLoad>d__37::System.IDisposable.Dispose()  // token 0x06000E24 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Shrine.<ActivateShrineDelayedInSaveLoad>d__37::MoveNext()  // token 0x06000E25 rva 0x3f43c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 96 (0x60), max stack 2, init locals
    .locals ([0] int, [1] Shrine)
    IL_0000: ldarg.0
    IL_0001: ldfld int Shrine.<ActivateShrineDelayedInSaveLoad>d__37::<>1__state  /*0x0400106D*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld Shrine Shrine.<ActivateShrineDelayedInSaveLoad>d__37::<>4__this  /*0x0400106F*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_0039, IL_0050)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int Shrine.<ActivateShrineDelayedInSaveLoad>d__37::<>1__state  /*0x0400106D*/
    IL_0029: ldarg.0
    IL_002a: ldnull
    IL_002b: stfld object Shrine.<ActivateShrineDelayedInSaveLoad>d__37::<>2__current  /*0x0400106E*/
    IL_0030: ldarg.0
    IL_0031: ldc.i4.1
    IL_0032: stfld int Shrine.<ActivateShrineDelayedInSaveLoad>d__37::<>1__state  /*0x0400106D*/
    IL_0037: ldc.i4.1
    IL_0038: ret
    IL_0039: ldarg.0
    IL_003a: ldc.i4.m1
    IL_003b: stfld int Shrine.<ActivateShrineDelayedInSaveLoad>d__37::<>1__state  /*0x0400106D*/
    IL_0040: ldarg.0
    IL_0041: ldnull
    IL_0042: stfld object Shrine.<ActivateShrineDelayedInSaveLoad>d__37::<>2__current  /*0x0400106E*/
    IL_0047: ldarg.0
    IL_0048: ldc.i4.2
    IL_0049: stfld int Shrine.<ActivateShrineDelayedInSaveLoad>d__37::<>1__state  /*0x0400106D*/
    IL_004e: ldc.i4.1
    IL_004f: ret
    IL_0050: ldarg.0
    IL_0051: ldc.i4.m1
    IL_0052: stfld int Shrine.<ActivateShrineDelayedInSaveLoad>d__37::<>1__state  /*0x0400106D*/
    IL_0057: ldloc.1
    IL_0058: ldc.i4.1
    IL_0059: call void Shrine::ActivateShrine(bool)  /*0x06000E19*/
    IL_005e: ldc.i4.0
    IL_005f: ret

  .method Shrine.<ActivateShrineDelayedInSaveLoad>d__37::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000E26 rva 0x3f4a8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object Shrine.<ActivateShrineDelayedInSaveLoad>d__37::<>2__current  /*0x0400106E*/
    IL_0006: ret

  .method Shrine.<ActivateShrineDelayedInSaveLoad>d__37::System.Collections.IEnumerator.Reset()  // token 0x06000E27 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method Shrine.<ActivateShrineDelayedInSaveLoad>d__37::System.Collections.IEnumerator.get_Current()  // token 0x06000E28 rva 0x3f4a8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object Shrine.<ActivateShrineDelayedInSaveLoad>d__37::<>2__current  /*0x0400106E*/
    IL_0006: ret

