// ===== BuildSlot  (token 0x0200008B) =====
  .method BuildSlot::get_LOCIDENTIFIER_NAME()  // token 0x060002C2 rva 0xc0da attrs Public, HideBySig, SpecialName
    // code size 17 (0x11), max stack 8
    IL_0000: ldstr "Building/"
    IL_0005: ldarg.0
    IL_0006: ldfld string BuildSlot::buildingName  /*0x04000391*/
    IL_000b: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0010: ret

  .method BuildSlot::GET_LOCIDENTIFIER_UPGRADE(int)  // token 0x060002C3 rva 0xc0ec attrs Public, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: call string BuildSlot::get_LOCIDENTIFIER_NAME()  /*0x060002C2*/
    IL_0006: ldstr " Upgrade "
    IL_000b: ldarga.s 1
    IL_000d: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0012: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0017: ret

  .method BuildSlot::GET_LOCIDENTIFIER_CHOICENAME(Choice)  // token 0x060002C4 rva 0xc105 attrs Public, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: call string BuildSlot::get_LOCIDENTIFIER_NAME()  /*0x060002C2*/
    IL_0006: ldstr " Choice "
    IL_000b: ldarg.1
    IL_000c: ldfld string Choice::name  /*0x04000B92*/
    IL_0011: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0016: ret

  .method BuildSlot::GET_LOCIDENTIFIER_CHOICEDESCRIPTION(Choice)  // token 0x060002C5 rva 0xc11d attrs Public, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call string BuildSlot::GET_LOCIDENTIFIER_CHOICENAME(Choice)  /*0x060002C4*/
    IL_0007: ldstr " Description"
    IL_000c: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0011: ret

  .method BuildSlot::get_RequiredRootLevelDifference()  // token 0x060002C6 rva 0xc130 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int BuildSlot::requiredRootLevelDifference  /*0x04000392*/
    IL_0006: ret

  .method BuildSlot::SetRequiredRootLevelDifference(int)  // token 0x060002C7 rva 0xc138 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld int BuildSlot::requiredRootLevelDifference  /*0x04000392*/
    IL_0007: ret

  .method BuildSlot::get_IsRootOf()  // token 0x060002C8 rva 0xc141 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<BuildSlot> BuildSlot::isRootOf  /*0x04000394*/
    IL_0006: ret

  .method BuildSlot::get_IsActivatorOf()  // token 0x060002C9 rva 0xc149 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<BuildSlot> BuildSlot::isActivatorOf  /*0x04000395*/
    IL_0006: ret

  .method BuildSlot::get_ActivatorBuilding()  // token 0x060002CA rva 0xc151 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_0006: ret

  .method BuildSlot::SetActivatorBuilding(BuildSlot)  // token 0x060002CB rva 0xc159 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_0007: ret

  .method BuildSlot::get_StartDeactivated()  // token 0x060002CC rva 0xc162 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildSlot::startDeactivated  /*0x04000397*/
    IL_0006: ret

  .method BuildSlot::set_StartDeactivated(bool)  // token 0x060002CD rva 0xc16a attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool BuildSlot::startDeactivated  /*0x04000397*/
    IL_0007: ret

  .method BuildSlot::get_ActivatorLevel()  // token 0x060002CE rva 0xc173 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int BuildSlot::activatorLevel  /*0x04000399*/
    IL_0006: ret

  .method BuildSlot::set_ActivatorLevel(int)  // token 0x060002CF rva 0xc17b attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld int BuildSlot::activatorLevel  /*0x04000399*/
    IL_0007: ret

  .method BuildSlot::get_ActivatorUpgradesThis()  // token 0x060002D0 rva 0xc184 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildSlot::activatorUpgradesThis  /*0x0400039A*/
    IL_0006: ret

  .method BuildSlot::get_Upgrades()  // token 0x060002D1 rva 0xc18c attrs Public, HideBySig, SpecialName
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildSlot::activatorUpgradesThis  /*0x0400039A*/
    IL_0006: brtrue.s IL_000f
    IL_0008: ldarg.0
    IL_0009: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_0015: callvirt List<BuildSlot.Upgrade> BuildSlot::get_Upgrades()  /*0x060002D1*/
    IL_001a: ret

  .method BuildSlot::get_OwnUpgrades()  // token 0x060002D2 rva 0xc1a8 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0006: ret

  .method BuildSlot::get_Level()  // token 0x060002D3 rva 0xc1b0 attrs Public, HideBySig, SpecialName
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildSlot::activatorUpgradesThis  /*0x0400039A*/
    IL_0006: brtrue.s IL_000f
    IL_0008: ldarg.0
    IL_0009: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_0015: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_001a: ret

  .method BuildSlot::get_AppliedUpgrades()  // token 0x060002D4 rva 0xc1cc attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<int> BuildSlot::appliedUpgrades  /*0x0400039D*/
    IL_0006: ret

  .method BuildSlot::get_HpParent()  // token 0x060002D5 rva 0xc1d4 attrs Private, HideBySig, SpecialName
    // code size 50 (0x32), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Hp BuildSlot::hpParent  /*0x0400039F*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_002b
    IL_000d: ldarg.0
    IL_000e: ldfld GameObject BuildSlot::buildingParent  /*0x040003A0*/
    IL_0013: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0018: brfalse.s IL_002b
    IL_001a: ldarg.0
    IL_001b: ldarg.0
    IL_001c: ldfld GameObject BuildSlot::buildingParent  /*0x040003A0*/
    IL_0021: callvirt !!0 UnityEngine.GameObject::GetComponent()<Hp>  /*0x2B000021*/
    IL_0026: stfld Hp BuildSlot::hpParent  /*0x0400039F*/
    IL_002b: ldarg.0
    IL_002c: ldfld Hp BuildSlot::hpParent  /*0x0400039F*/
    IL_0031: ret

  .method BuildSlot::get_Interactor()  // token 0x060002D6 rva 0xc207 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildingInteractor BuildSlot::interactor  /*0x040003A2*/
    IL_0006: ret

  .method BuildSlot::get_MainMesh()  // token 0x060002D7 rva 0xc20f attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MeshFilter BuildSlot::mainMesh  /*0x040003A3*/
    IL_0006: ret

  .method BuildSlot::get_UpgradesWithCostsLoadedFromSave()  // token 0x060002D8 rva 0xc217 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<BuildSlot.Upgrade> BuildSlot::upgradesWithCostsLoadedFromSave  /*0x040003AE*/
    IL_0006: callvirt ReadOnlyCollection<!0> System.Collections.Generic.List<BuildSlot.Upgrade>::AsReadOnly()  /*0x0A000117*/
    IL_000b: ret

  .method BuildSlot::get_State()  // token 0x060002D9 rva 0xc224 attrs Public, HideBySig, SpecialName
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0006: ldc.i4.1
    IL_0007: bge.s IL_000b
    IL_0009: ldc.i4.0
    IL_000a: ret
    IL_000b: ldc.i4.1
    IL_000c: ret

  .method BuildSlot::get_GoldIncome()  // token 0x060002DA rva 0xc232 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int BuildSlot::goldIncome  /*0x040003AC*/
    IL_0006: ret

  .method BuildSlot::set_GoldIncome(int)  // token 0x060002DB rva 0xc23a attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld int BuildSlot::goldIncome  /*0x040003AC*/
    IL_0007: ret

  .method BuildSlot::get_EnergyCoreIncome()  // token 0x060002DC rva 0xc243 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int BuildSlot::energyCoreIncome  /*0x040003AD*/
    IL_0006: ret

  .method BuildSlot::set_EnergyCoreIncome(int)  // token 0x060002DD rva 0xc24b attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld int BuildSlot::energyCoreIncome  /*0x040003AD*/
    IL_0007: ret

  .method BuildSlot::get_CanBeUpgraded()  // token 0x060002DE rva 0xc254 attrs Public, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 139 (0x8b), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildSlot::activatorUpgradesThis  /*0x0400039A*/
    IL_0006: brfalse.s IL_0014
    IL_0008: ldarg.0
    IL_0009: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_000e: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_001a: ldarg.0
    IL_001b: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0020: callvirt int System.Collections.Generic.List<BuildSlot.Upgrade>::get_Count()  /*0x0A000118*/
    IL_0025: blt.s IL_0029
    IL_0027: ldc.i4.0
    IL_0028: ret
    IL_0029: ldarg.0
    IL_002a: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_002f: ldarg.0
    IL_0030: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0035: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_003a: ldfld bool BuildSlot.Upgrade::disableInThisMode  /*0x040003BD*/
    IL_003f: brfalse.s IL_0043
    IL_0041: ldc.i4.0
    IL_0042: ret
    IL_0043: ldarg.0
    IL_0044: ldfld BuildSlot BuildSlot::requiredRoot  /*0x04000393*/
    IL_0049: ldnull
    IL_004a: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_004f: brfalse.s IL_0065
    IL_0051: ldarg.0
    IL_0052: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0057: ldarg.0
    IL_0058: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_005d: callvirt int System.Collections.Generic.List<BuildSlot.Upgrade>::get_Count()  /*0x0A000118*/
    IL_0062: clt
    IL_0064: ret
    IL_0065: ldarg.0
    IL_0066: ldfld BuildSlot BuildSlot::requiredRoot  /*0x04000393*/
    IL_006b: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0070: ldarg.0
    IL_0071: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0076: ldarg.0
    IL_0077: ldfld int BuildSlot::requiredRootLevelDifference  /*0x04000392*/
    IL_007c: add
    IL_007d: bgt.s IL_0089
    IL_007f: ldarg.0
    IL_0080: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0085: ldc.i4.0
    IL_0086: ceq
    IL_0088: ret
    IL_0089: ldc.i4.1
    IL_008a: ret

  .method BuildSlot::OnBeforeMainLoadPass(string)  // token 0x060002DF rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BuildSlot::OnAfterMainLoadPass(string)  // token 0x060002E0 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BuildSlot::OnLoad(string)  // token 0x060002E1 rva 0xc2ec attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 252 (0xfc), max stack 3, init locals
    .locals ([0] int[], [1] int, [2] int, [3] bool, [4] Scene)
    IL_0000: ldarg.1
    IL_0001: ldstr "level"
    IL_0006: ldarg.0
    IL_0007: ldflda int BuildSlot::level  /*0x0400039C*/
    IL_000c: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_0011: brfalse.s IL_001a
    IL_0013: ldarg.0
    IL_0014: ldc.i4.0
    IL_0015: stfld bool BuildSlot::startDeactivated  /*0x04000397*/
    IL_001a: ldc.i4.0
    IL_001b: newarr System.Int32  /*0x01000026*/
    IL_0020: stloc.0
    IL_0021: ldarg.1
    IL_0022: ldstr "appliedUpgrades"
    IL_0027: ldloca.s 0
    IL_0029: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int[]>  /*0x2B000022*/
    IL_002e: pop
    IL_002f: ldloc.0
    IL_0030: ldlen
    IL_0031: brfalse.s IL_003f
    IL_0033: ldarg.0
    IL_0034: ldloc.0
    IL_0035: newobj void System.Collections.Generic.List<int>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000119*/
    IL_003a: stfld List<int> BuildSlot::appliedUpgrades  /*0x0400039D*/
    IL_003f: ldc.i4.0
    IL_0040: stloc.1
    IL_0041: ldarg.1
    IL_0042: ldstr "NextUpgradeOrBuildCost"
    IL_0047: ldloca.s 1
    IL_0049: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_004e: pop
    IL_004f: ldc.i4.0
    IL_0050: stloc.2
    IL_0051: ldc.i4.0
    IL_0052: ldarg.0
    IL_0053: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0058: callvirt Scene UnityEngine.GameObject::get_scene()  /*0x0A00011A*/
    IL_005d: stloc.s 4
    IL_005f: ldloca.s 4
    IL_0061: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_0066: call bool DlcConfiguration::IsDlcMap(IDlcProvider.DlcId,string)  /*0x0600001D*/
    IL_006b: brfalse.s IL_0075
    IL_006d: ldc.i4.0
    IL_006e: call bool DlcConfiguration::IsDlcAvailable(IDlcProvider.DlcId)  /*0x0600001C*/
    IL_0073: br.s IL_0076
    IL_0075: ldc.i4.0
    IL_0076: stloc.3
    IL_0077: ldloc.3
    IL_0078: brfalse.s IL_0088
    IL_007a: ldarg.1
    IL_007b: ldstr "NextUpgradeOrBuildEnergyCoreCost"
    IL_0080: ldloca.s 2
    IL_0082: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_0087: pop
    IL_0088: ldloc.1
    IL_0089: brfalse.s IL_00ee
    IL_008b: ldarg.0
    IL_008c: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0091: ldarg.0
    IL_0092: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0097: callvirt int System.Collections.Generic.List<BuildSlot.Upgrade>::get_Count()  /*0x0A000118*/
    IL_009c: bge.s IL_00ee
    IL_009e: ldarg.0
    IL_009f: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_00a4: ldarg.0
    IL_00a5: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_00aa: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_00af: ldloc.1
    IL_00b0: stfld int BuildSlot.Upgrade::cost  /*0x040003BB*/
    IL_00b5: ldloc.3
    IL_00b6: brfalse.s IL_00d2
    IL_00b8: ldloc.2
    IL_00b9: brfalse.s IL_00d2
    IL_00bb: ldarg.0
    IL_00bc: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_00c1: ldarg.0
    IL_00c2: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_00c7: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_00cc: ldloc.2
    IL_00cd: stfld int BuildSlot.Upgrade::energyCoreCost  /*0x040003BC*/
    IL_00d2: ldarg.0
    IL_00d3: ldfld List<BuildSlot.Upgrade> BuildSlot::upgradesWithCostsLoadedFromSave  /*0x040003AE*/
    IL_00d8: ldarg.0
    IL_00d9: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_00de: ldarg.0
    IL_00df: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_00e4: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_00e9: callvirt void System.Collections.Generic.List<BuildSlot.Upgrade>::Add(!0)  /*0x0A00011C*/
    IL_00ee: ldarg.0
    IL_00ef: ldarg.0
    IL_00f0: call IEnumerator BuildSlot::ApplyLoadedUpgradesDelayed()  /*0x060002E2*/
    IL_00f5: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_00fa: pop
    IL_00fb: ret

  .method BuildSlot::ApplyLoadedUpgradesDelayed()  // token 0x060002E2 rva 0xc3f4 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::.ctor(int)  /*0x0600030B*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld BuildSlot BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::<>4__this  /*0x040003CC*/
    IL_000d: ret

  .method BuildSlot::OnSave(string)  // token 0x060002E3 rva 0xc404 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 160 (0xa0), max stack 4, init locals
    .locals ([0] Scene)
    IL_0000: ldarg.1
    IL_0001: ldstr "level"
    IL_0006: ldarg.0
    IL_0007: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_000c: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_0011: ldarg.1
    IL_0012: ldstr "appliedUpgrades"
    IL_0017: ldarg.0
    IL_0018: ldfld List<int> BuildSlot::appliedUpgrades  /*0x0400039D*/
    IL_001d: callvirt !0[] System.Collections.Generic.List<int>::ToArray()  /*0x0A00011D*/
    IL_0022: call void MatchSaveLoadHandler::SaveValue(string,string,int[])  /*0x06000CF9*/
    IL_0027: ldarg.0
    IL_0028: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_002d: ldarg.0
    IL_002e: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0033: callvirt int System.Collections.Generic.List<BuildSlot.Upgrade>::get_Count()  /*0x0A000118*/
    IL_0038: bge.s IL_009f
    IL_003a: ldarg.1
    IL_003b: ldstr "NextUpgradeOrBuildCost"
    IL_0040: ldarg.0
    IL_0041: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0046: ldarg.0
    IL_0047: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_004c: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0051: ldfld int BuildSlot.Upgrade::cost  /*0x040003BB*/
    IL_0056: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_005b: ldc.i4.0
    IL_005c: ldarg.0
    IL_005d: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0062: callvirt Scene UnityEngine.GameObject::get_scene()  /*0x0A00011A*/
    IL_0067: stloc.0
    IL_0068: ldloca.s 0
    IL_006a: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_006f: call bool DlcConfiguration::IsDlcMap(IDlcProvider.DlcId,string)  /*0x0600001D*/
    IL_0074: brfalse.s IL_009f
    IL_0076: ldc.i4.0
    IL_0077: call bool DlcConfiguration::IsDlcAvailable(IDlcProvider.DlcId)  /*0x0600001C*/
    IL_007c: brfalse.s IL_009f
    IL_007e: ldarg.1
    IL_007f: ldstr "NextUpgradeOrBuildEnergyCoreCost"
    IL_0084: ldarg.0
    IL_0085: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_008a: ldarg.0
    IL_008b: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0090: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0095: ldfld int BuildSlot.Upgrade::energyCoreCost  /*0x040003BC*/
    IL_009a: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_009f: ret

  .method BuildSlot::get_NextUpgradeIsChoice()  // token 0x060002E4 rva 0xc4b0 attrs Public, HideBySig, SpecialName
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_0006: brfalse.s IL_0027
    IL_0008: ldarg.0
    IL_0009: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_000e: ldarg.0
    IL_000f: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0014: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0019: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_001e: callvirt int System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Count()  /*0x0A00011E*/
    IL_0023: ldc.i4.1
    IL_0024: cgt
    IL_0026: ret
    IL_0027: ldc.i4.0
    IL_0028: ret

  .method BuildSlot::ReturnTooltip()  // token 0x060002E5 rva 0xc4dc attrs Public, HideBySig
    // code size 879 (0x36f), max stack 8, init locals
    .locals ([0] string, [1] string, [2] int, [3] Hp, [4] List<int>, [5] List<int>, [6] string, [7] string, [8] List.Enumerator<BuildSlot.UpgradeBranch>, [9] BuildSlot.UpgradeBranch, [10] int, [11] int, [12] int, [13] int, [14] int)
    IL_0000: ldarg.0
    IL_0001: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldstr ""
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0014: ldc.i4.0
    IL_0015: ble.s IL_0028
    IL_0017: ldstr "Tooltip/Upgrade Building"
    IL_001c: ldc.i4.1
    IL_001d: ldc.i4.0
    IL_001e: ldc.i4.1
    IL_001f: ldc.i4.1
    IL_0020: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0025: stloc.0
    IL_0026: br.s IL_0037
    IL_0028: ldstr "Tooltip/Build"
    IL_002d: ldc.i4.1
    IL_002e: ldc.i4.0
    IL_002f: ldc.i4.1
    IL_0030: ldc.i4.1
    IL_0031: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0036: stloc.0
    IL_0037: ldc.i4.5
    IL_0038: newarr System.String  /*0x0100001D*/
    IL_003d: dup
    IL_003e: ldc.i4.0
    IL_003f: ldstr "<style=\"Tooltip Header\">"
    IL_0044: stelem.ref
    IL_0045: dup
    IL_0046: ldc.i4.1
    IL_0047: ldloc.0
    IL_0048: stelem.ref
    IL_0049: dup
    IL_004a: ldc.i4.2
    IL_004b: ldstr " "
    IL_0050: stelem.ref
    IL_0051: dup
    IL_0052: ldc.i4.3
    IL_0053: ldarg.0
    IL_0054: call string BuildSlot::get_LOCIDENTIFIER_NAME()  /*0x060002C2*/
    IL_0059: ldc.i4.1
    IL_005a: ldc.i4.0
    IL_005b: ldc.i4.1
    IL_005c: ldc.i4.1
    IL_005d: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0062: stelem.ref
    IL_0063: dup
    IL_0064: ldc.i4.4
    IL_0065: ldstr ":\n"
    IL_006a: stelem.ref
    IL_006b: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_0070: stloc.1
    IL_0071: ldloc.1
    IL_0072: ldstr "<style=\"Tooltip Default\">"
    IL_0077: ldarg.0
    IL_0078: ldarg.0
    IL_0079: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_007e: call string BuildSlot::GET_LOCIDENTIFIER_UPGRADE(int)  /*0x060002C3*/
    IL_0083: ldc.i4.1
    IL_0084: ldc.i4.0
    IL_0085: ldc.i4.1
    IL_0086: ldc.i4.1
    IL_0087: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_008c: ldstr "\n"
    IL_0091: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0096: stloc.1
    IL_0097: ldloc.1
    IL_0098: ldstr "<style=\"Tooltip Numerals\">"
    IL_009d: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00a2: stloc.1
    IL_00a3: ldc.i4.0
    IL_00a4: stloc.2
    IL_00a5: ldarg.0
    IL_00a6: ldc.i4.1
    IL_00a7: call !!0 UnityEngine.Component::GetComponentInChildren(bool)<Hp>  /*0x2B000023*/
    IL_00ac: stloc.3
    IL_00ad: ldloc.3
    IL_00ae: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00b3: brfalse.s IL_00bd
    IL_00b5: ldloc.3
    IL_00b6: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_00bb: conv.i4
    IL_00bc: stloc.2
    IL_00bd: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_00c2: stloc.s 4
    IL_00c4: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_00c9: stloc.s 5
    IL_00cb: ldarg.0
    IL_00cc: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_00d1: ldarg.0
    IL_00d2: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_00d7: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_00dc: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_00e1: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot.UpgradeBranch>::GetEnumerator()  /*0x0A000121*/
    IL_00e6: stloc.s 8
    IL_00e8: br.s IL_0136
    IL_00ea: ldloca.s 8
    IL_00ec: call !0 System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::get_Current()  /*0x0A000122*/
    IL_00f1: stloc.s 9
    IL_00f3: ldarg.0
    IL_00f4: ldfld int BuildSlot::goldIncome  /*0x040003AC*/
    IL_00f9: ldloc.s 9
    IL_00fb: ldfld int BuildSlot.UpgradeBranch::goldIncomeChange  /*0x040003C1*/
    IL_0100: add
    IL_0101: stloc.s 10
    IL_0103: ldloc.s 4
    IL_0105: ldloc.s 10
    IL_0107: callvirt bool System.Collections.Generic.List<int>::Contains(!0)  /*0x0A000123*/
    IL_010c: brtrue.s IL_0117
    IL_010e: ldloc.s 4
    IL_0110: ldloc.s 10
    IL_0112: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0117: ldloc.2
    IL_0118: ldloc.s 9
    IL_011a: ldfld int BuildSlot.UpgradeBranch::hpChange  /*0x040003C3*/
    IL_011f: add
    IL_0120: stloc.s 11
    IL_0122: ldloc.s 5
    IL_0124: ldloc.s 11
    IL_0126: callvirt bool System.Collections.Generic.List<int>::Contains(!0)  /*0x0A000123*/
    IL_012b: brtrue.s IL_0136
    IL_012d: ldloc.s 5
    IL_012f: ldloc.s 11
    IL_0131: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0136: ldloca.s 8
    IL_0138: call bool System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::MoveNext()  /*0x0A000125*/
    IL_013d: brtrue.s IL_00ea
    IL_013f: leave.s IL_014f
    IL_0141: ldloca.s 8
    IL_0143: constrained. System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>  /*0x1B000022*/
    IL_0149: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_014e: endfinally
    IL_014f: ldloc.s 5
    IL_0151: callvirt void System.Collections.Generic.List<int>::Sort()  /*0x0A000126*/
    IL_0156: ldloc.s 4
    IL_0158: callvirt void System.Collections.Generic.List<int>::Sort()  /*0x0A000126*/
    IL_015d: ldstr ""
    IL_0162: stloc.s 6
    IL_0164: ldstr ""
    IL_0169: stloc.s 7
    IL_016b: ldc.i4.0
    IL_016c: stloc.s 12
    IL_016e: br.s IL_01a4
    IL_0170: ldloc.s 12
    IL_0172: ldc.i4.0
    IL_0173: ble.s IL_0183
    IL_0175: ldloc.s 6
    IL_0177: ldstr "/"
    IL_017c: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0181: stloc.s 6
    IL_0183: ldloc.s 6
    IL_0185: ldloc.s 4
    IL_0187: ldloc.s 12
    IL_0189: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_018e: stloc.s 13
    IL_0190: ldloca.s 13
    IL_0192: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0197: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_019c: stloc.s 6
    IL_019e: ldloc.s 12
    IL_01a0: ldc.i4.1
    IL_01a1: add
    IL_01a2: stloc.s 12
    IL_01a4: ldloc.s 12
    IL_01a6: ldloc.s 4
    IL_01a8: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_01ad: blt.s IL_0170
    IL_01af: ldc.i4.0
    IL_01b0: stloc.s 14
    IL_01b2: br.s IL_01e8
    IL_01b4: ldloc.s 14
    IL_01b6: ldc.i4.0
    IL_01b7: ble.s IL_01c7
    IL_01b9: ldloc.s 7
    IL_01bb: ldstr "/"
    IL_01c0: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_01c5: stloc.s 7
    IL_01c7: ldloc.s 7
    IL_01c9: ldloc.s 5
    IL_01cb: ldloc.s 14
    IL_01cd: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_01d2: stloc.s 13
    IL_01d4: ldloca.s 13
    IL_01d6: call string System.Int32::ToString()  /*0x0A000031*/
    IL_01db: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_01e0: stloc.s 7
    IL_01e2: ldloc.s 14
    IL_01e4: ldc.i4.1
    IL_01e5: add
    IL_01e6: stloc.s 14
    IL_01e8: ldloc.s 14
    IL_01ea: ldloc.s 5
    IL_01ec: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_01f1: blt.s IL_01b4
    IL_01f3: ldarg.0
    IL_01f4: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_01f9: ldc.i4.0
    IL_01fa: ble IL_02e0
    IL_01ff: ldloc.s 5
    IL_0201: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0206: ldc.i4.1
    IL_0207: bgt.s IL_0214
    IL_0209: ldloc.s 5
    IL_020b: ldc.i4.0
    IL_020c: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0211: ldloc.2
    IL_0212: beq.s IL_024d
    IL_0214: ldc.i4.6
    IL_0215: newarr System.String  /*0x0100001D*/
    IL_021a: dup
    IL_021b: ldc.i4.0
    IL_021c: ldloc.1
    IL_021d: stelem.ref
    IL_021e: dup
    IL_021f: ldc.i4.1
    IL_0220: ldstr "\n"
    IL_0225: stelem.ref
    IL_0226: dup
    IL_0227: ldc.i4.2
    IL_0228: ldloca.s 2
    IL_022a: call string System.Int32::ToString()  /*0x0A000031*/
    IL_022f: stelem.ref
    IL_0230: dup
    IL_0231: ldc.i4.3
    IL_0232: ldstr "<sprite name=\"heart\"> <sprite name=\"arrow_right\"> "
    IL_0237: stelem.ref
    IL_0238: dup
    IL_0239: ldc.i4.4
    IL_023a: ldloc.s 7
    IL_023c: stelem.ref
    IL_023d: dup
    IL_023e: ldc.i4.5
    IL_023f: ldstr "<sprite name=\"heart\">"
    IL_0244: stelem.ref
    IL_0245: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_024a: stloc.1
    IL_024b: br.s IL_0265
    IL_024d: ldloc.1
    IL_024e: ldstr "\n"
    IL_0253: ldloca.s 2
    IL_0255: call string System.Int32::ToString()  /*0x0A000031*/
    IL_025a: ldstr "<sprite name=\"heart\">"
    IL_025f: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0264: stloc.1
    IL_0265: ldloc.s 4
    IL_0267: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_026c: ldc.i4.1
    IL_026d: bgt.s IL_027f
    IL_026f: ldloc.s 4
    IL_0271: ldc.i4.0
    IL_0272: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0277: ldarg.0
    IL_0278: ldfld int BuildSlot::goldIncome  /*0x040003AC*/
    IL_027d: beq.s IL_02bf
    IL_027f: ldc.i4.6
    IL_0280: newarr System.String  /*0x0100001D*/
    IL_0285: dup
    IL_0286: ldc.i4.0
    IL_0287: ldloc.1
    IL_0288: stelem.ref
    IL_0289: dup
    IL_028a: ldc.i4.1
    IL_028b: ldstr "\n"
    IL_0290: stelem.ref
    IL_0291: dup
    IL_0292: ldc.i4.2
    IL_0293: ldarg.0
    IL_0294: ldflda int BuildSlot::goldIncome  /*0x040003AC*/
    IL_0299: call string System.Int32::ToString()  /*0x0A000031*/
    IL_029e: stelem.ref
    IL_029f: dup
    IL_02a0: ldc.i4.3
    IL_02a1: ldstr "<sprite name=\"coin\"> <sprite name=\"arrow_right\"> "
    IL_02a6: stelem.ref
    IL_02a7: dup
    IL_02a8: ldc.i4.4
    IL_02a9: ldloc.s 6
    IL_02ab: stelem.ref
    IL_02ac: dup
    IL_02ad: ldc.i4.5
    IL_02ae: ldstr "<sprite name=\"coin\">"
    IL_02b3: stelem.ref
    IL_02b4: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_02b9: stloc.1
    IL_02ba: br IL_036d
    IL_02bf: ldloc.1
    IL_02c0: ldstr "\n"
    IL_02c5: ldarg.0
    IL_02c6: ldflda int BuildSlot::goldIncome  /*0x040003AC*/
    IL_02cb: call string System.Int32::ToString()  /*0x0A000031*/
    IL_02d0: ldstr "<sprite name=\"coin\">"
    IL_02d5: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_02da: stloc.1
    IL_02db: br IL_036d
    IL_02e0: ldloc.s 5
    IL_02e2: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_02e7: ldc.i4.1
    IL_02e8: bgt.s IL_02f5
    IL_02ea: ldloc.s 5
    IL_02ec: ldc.i4.0
    IL_02ed: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_02f2: ldloc.2
    IL_02f3: beq.s IL_030a
    IL_02f5: ldloc.1
    IL_02f6: ldstr "\n<sprite name=\"arrow_right\"> "
    IL_02fb: ldloc.s 7
    IL_02fd: ldstr "<sprite name=\"heart\">"
    IL_0302: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0307: stloc.1
    IL_0308: br.s IL_0322
    IL_030a: ldloc.1
    IL_030b: ldstr "\n<sprite name=\"arrow_right\"> "
    IL_0310: ldloca.s 2
    IL_0312: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0317: ldstr "<sprite name=\"heart\">"
    IL_031c: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0321: stloc.1
    IL_0322: ldloc.s 4
    IL_0324: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0329: ldc.i4.1
    IL_032a: bgt.s IL_033c
    IL_032c: ldloc.s 4
    IL_032e: ldc.i4.0
    IL_032f: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0334: ldarg.0
    IL_0335: ldfld int BuildSlot::goldIncome  /*0x040003AC*/
    IL_033a: beq.s IL_0351
    IL_033c: ldloc.1
    IL_033d: ldstr "\n<sprite name=\"arrow_right\"> "
    IL_0342: ldloc.s 6
    IL_0344: ldstr "<sprite name=\"coin\">"
    IL_0349: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_034e: stloc.1
    IL_034f: br.s IL_036d
    IL_0351: ldloc.1
    IL_0352: ldstr "\n<sprite name=\"arrow_right\"> "
    IL_0357: ldarg.0
    IL_0358: ldflda int BuildSlot::goldIncome  /*0x040003AC*/
    IL_035d: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0362: ldstr "<sprite name=\"coin\">"
    IL_0367: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_036c: stloc.1
    IL_036d: ldloc.1
    IL_036e: ret
    .try IL_00e8-IL_0141 finally handler IL_0141-IL_014f

  .method BuildSlot::get_NextUpgradeOrBuildCost()  // token 0x060002E6 rva 0xc868 attrs Public, HideBySig, SpecialName
    // code size 54 (0x36), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildSlot::activatorUpgradesThis  /*0x0400039A*/
    IL_0006: brfalse.s IL_0014
    IL_0008: ldarg.0
    IL_0009: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_000e: callvirt int BuildSlot::get_NextUpgradeOrBuildCost()  /*0x060002E6*/
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_001a: brfalse.s IL_0033
    IL_001c: ldarg.0
    IL_001d: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0022: ldarg.0
    IL_0023: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0028: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_002d: ldfld int BuildSlot.Upgrade::cost  /*0x040003BB*/
    IL_0032: ret
    IL_0033: ldc.i4.s 100
    IL_0035: ret

  .method BuildSlot::set_NextUpgradeOrBuildCost(int)  // token 0x060002E7 rva 0xc89f attrs Public, HideBySig, SpecialName
    // code size 52 (0x34), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildSlot::activatorUpgradesThis  /*0x0400039A*/
    IL_0006: brfalse.s IL_0014
    IL_0008: ldarg.0
    IL_0009: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_000e: ldarg.1
    IL_000f: callvirt void BuildSlot::set_NextUpgradeOrBuildCost(int)  /*0x060002E7*/
    IL_0014: ldarg.0
    IL_0015: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_001a: brfalse.s IL_0033
    IL_001c: ldarg.0
    IL_001d: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0022: ldarg.0
    IL_0023: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0028: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_002d: ldarg.1
    IL_002e: stfld int BuildSlot.Upgrade::cost  /*0x040003BB*/
    IL_0033: ret

  .method BuildSlot::get_NextUpgradeOrBuildEnergyCoreCost()  // token 0x060002E8 rva 0xc8d4 attrs Public, HideBySig, SpecialName
    // code size 54 (0x36), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildSlot::activatorUpgradesThis  /*0x0400039A*/
    IL_0006: brfalse.s IL_0014
    IL_0008: ldarg.0
    IL_0009: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_000e: callvirt int BuildSlot::get_NextUpgradeOrBuildEnergyCoreCost()  /*0x060002E8*/
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_001a: brfalse.s IL_0033
    IL_001c: ldarg.0
    IL_001d: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0022: ldarg.0
    IL_0023: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0028: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_002d: ldfld int BuildSlot.Upgrade::energyCoreCost  /*0x040003BC*/
    IL_0032: ret
    IL_0033: ldc.i4.s 100
    IL_0035: ret

  .method BuildSlot::set_NextUpgradeOrBuildEnergyCoreCost(int)  // token 0x060002E9 rva 0xc90b attrs Public, HideBySig, SpecialName
    // code size 52 (0x34), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildSlot::activatorUpgradesThis  /*0x0400039A*/
    IL_0006: brfalse.s IL_0014
    IL_0008: ldarg.0
    IL_0009: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_000e: ldarg.1
    IL_000f: callvirt void BuildSlot::set_NextUpgradeOrBuildEnergyCoreCost(int)  /*0x060002E9*/
    IL_0014: ldarg.0
    IL_0015: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_001a: brfalse.s IL_0033
    IL_001c: ldarg.0
    IL_001d: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0022: ldarg.0
    IL_0023: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0028: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_002d: ldarg.1
    IL_002e: stfld int BuildSlot.Upgrade::energyCoreCost  /*0x040003BC*/
    IL_0033: ret

  .method BuildSlot::get_BuildingParent()  // token 0x060002EA rva 0xc940 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject BuildSlot::buildingParent  /*0x040003A0*/
    IL_0006: ret

  .method BuildSlot::get_IsBlueprint()  // token 0x060002EB rva 0xc948 attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0006: ldc.i4.0
    IL_0007: ceq
    IL_0009: ret

  .method BuildSlot::get_BuiltSlotsThatRelyOnThisBuilding()  // token 0x060002EC rva 0xc953 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_0006: ret

  .method BuildSlot::OnEnable()  // token 0x060002ED rva 0xc95c attrs Private, HideBySig
    // code size 166 (0xa6), max stack 2, init locals
    .locals ([0] List.Enumerator<BuildSlot.Upgrade>, [1] List.Enumerator<BuildSlot.UpgradeBranch>, [2] List.Enumerator<GameObject>, [3] GameObject)
    IL_0000: ldarg.0
    IL_0001: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot.Upgrade>::GetEnumerator()  /*0x0A000127*/
    IL_000b: stloc.0
    IL_000c: br.s IL_007f
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<BuildSlot.Upgrade>::get_Current()  /*0x0A000128*/
    IL_0015: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_001a: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot.UpgradeBranch>::GetEnumerator()  /*0x0A000121*/
    IL_001f: stloc.1
    IL_0020: br.s IL_0066
    IL_0022: ldloca.s 1
    IL_0024: call !0 System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::get_Current()  /*0x0A000122*/
    IL_0029: ldfld List<GameObject> BuildSlot.UpgradeBranch::objectsToActivate  /*0x040003C4*/
    IL_002e: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_0033: stloc.2
    IL_0034: br.s IL_004d
    IL_0036: ldloca.s 2
    IL_0038: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_003d: stloc.3
    IL_003e: ldloc.3
    IL_003f: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0044: brfalse.s IL_004d
    IL_0046: ldloc.3
    IL_0047: ldc.i4.0
    IL_0048: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_004d: ldloca.s 2
    IL_004f: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_0054: brtrue.s IL_0036
    IL_0056: leave.s IL_0066
    IL_0058: ldloca.s 2
    IL_005a: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_0060: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0065: endfinally
    IL_0066: ldloca.s 1
    IL_0068: call bool System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::MoveNext()  /*0x0A000125*/
    IL_006d: brtrue.s IL_0022
    IL_006f: leave.s IL_007f
    IL_0071: ldloca.s 1
    IL_0073: constrained. System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>  /*0x1B000022*/
    IL_0079: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_007e: endfinally
    IL_007f: ldloca.s 0
    IL_0081: call bool System.Collections.Generic.List.Enumerator<BuildSlot.Upgrade>::MoveNext()  /*0x0A00012C*/
    IL_0086: brtrue.s IL_000e
    IL_0088: leave.s IL_0098
    IL_008a: ldloca.s 0
    IL_008c: constrained. System.Collections.Generic.List.Enumerator<BuildSlot.Upgrade>  /*0x1B000023*/
    IL_0092: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0097: endfinally
    IL_0098: ldarg.0
    IL_0099: ldarg.0
    IL_009a: call IEnumerator BuildSlot::GodOfChoiceHandling()  /*0x060002EE*/
    IL_009f: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_00a4: pop
    IL_00a5: ret
    .try IL_0034-IL_0058 finally handler IL_0058-IL_0066
    .try IL_0020-IL_0071 finally handler IL_0071-IL_007f
    .try IL_000c-IL_008a finally handler IL_008a-IL_0098

  .method BuildSlot::GodOfChoiceHandling()  // token 0x060002EE rva 0xca38 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void BuildSlot.<GodOfChoiceHandling>d__109::.ctor(int)  /*0x06000311*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld BuildSlot BuildSlot.<GodOfChoiceHandling>d__109::<>4__this  /*0x040003CF*/
    IL_000d: ret

  .method BuildSlot::GetBuildSlotsThatWillUnlockWhenUpgraded()  // token 0x060002EF rva 0xca48 attrs Public, HideBySig
    // code size 73 (0x49), max stack 3, init locals
    .locals ([0] List<BuildSlot>, [1] int)
    IL_0000: newobj void System.Collections.Generic.List<BuildSlot>::.ctor()  /*0x0A00012D*/
    IL_0005: stloc.0
    IL_0006: ldc.i4.0
    IL_0007: stloc.1
    IL_0008: br.s IL_0039
    IL_000a: ldarg.0
    IL_000b: ldfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_0010: ldloc.1
    IL_0011: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_0016: ldfld int BuildSlot::activatorLevel  /*0x04000399*/
    IL_001b: ldarg.0
    IL_001c: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0021: bne.un.s IL_0035
    IL_0023: ldloc.0
    IL_0024: ldarg.0
    IL_0025: ldfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_002a: ldloc.1
    IL_002b: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_0030: callvirt void System.Collections.Generic.List<BuildSlot>::Add(!0)  /*0x0A00012E*/
    IL_0035: ldloc.1
    IL_0036: ldc.i4.1
    IL_0037: add
    IL_0038: stloc.1
    IL_0039: ldloc.1
    IL_003a: ldarg.0
    IL_003b: ldfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_0040: callvirt int System.Collections.Generic.List<BuildSlot>::get_Count()  /*0x0A000053*/
    IL_0045: blt.s IL_000a
    IL_0047: ldloc.0
    IL_0048: ret

  .method BuildSlot::GetBlueprintPreviewsThatWillUnlockWhenUpgraded(System.Collections.Generic.List<UnityEngine.MeshFilter>)  // token 0x060002F0 rva 0xcaa0 attrs Public, HideBySig
    // code size 189 (0xbd), max stack 3, init locals
    .locals ([0] int)
    IL_0000: ldarg.1
    IL_0001: callvirt void System.Collections.Generic.List<UnityEngine.MeshFilter>::Clear()  /*0x0A00012F*/
    IL_0006: ldc.i4.0
    IL_0007: stloc.0
    IL_0008: br IL_00a5
    IL_000d: ldarg.0
    IL_000e: ldfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_0013: ldloc.0
    IL_0014: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_0019: ldfld int BuildSlot::activatorLevel  /*0x04000399*/
    IL_001e: ldarg.0
    IL_001f: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0024: bne.un.s IL_00a1
    IL_0026: ldarg.0
    IL_0027: ldfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_002c: ldloc.0
    IL_002d: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_0032: callvirt BuildSlot.BuildingState BuildSlot::get_State()  /*0x060002D9*/
    IL_0037: ldc.i4.1
    IL_0038: beq.s IL_004d
    IL_003a: ldarg.0
    IL_003b: ldfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_0040: ldloc.0
    IL_0041: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_0046: ldfld bool BuildSlot::activatorUpgradesThis  /*0x0400039A*/
    IL_004b: brfalse.s IL_0078
    IL_004d: ldarg.0
    IL_004e: ldfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_0053: ldloc.0
    IL_0054: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_0059: ldfld GameObject BuildSlot::buildingParent  /*0x040003A0*/
    IL_005e: ldc.i4.0
    IL_005f: ldarg.0
    IL_0060: ldfld List<MeshFilter> BuildSlot::meshFilter  /*0x04000396*/
    IL_0065: callvirt void UnityEngine.GameObject::GetComponentsInChildren(bool,System.Collections.Generic.List<!!0>)<UnityEngine.MeshFilter>  /*0x2B000024*/
    IL_006a: ldarg.1
    IL_006b: ldarg.0
    IL_006c: ldfld List<MeshFilter> BuildSlot::meshFilter  /*0x04000396*/
    IL_0071: callvirt void System.Collections.Generic.List<UnityEngine.MeshFilter>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000131*/
    IL_0076: br.s IL_00a1
    IL_0078: ldarg.0
    IL_0079: ldfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_007e: ldloc.0
    IL_007f: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_0084: ldfld GameObject BuildSlot::bluepringParent  /*0x040003A1*/
    IL_0089: ldc.i4.0
    IL_008a: ldarg.0
    IL_008b: ldfld List<MeshFilter> BuildSlot::meshFilter  /*0x04000396*/
    IL_0090: callvirt void UnityEngine.GameObject::GetComponentsInChildren(bool,System.Collections.Generic.List<!!0>)<UnityEngine.MeshFilter>  /*0x2B000024*/
    IL_0095: ldarg.1
    IL_0096: ldarg.0
    IL_0097: ldfld List<MeshFilter> BuildSlot::meshFilter  /*0x04000396*/
    IL_009c: callvirt void System.Collections.Generic.List<UnityEngine.MeshFilter>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000131*/
    IL_00a1: ldloc.0
    IL_00a2: ldc.i4.1
    IL_00a3: add
    IL_00a4: stloc.0
    IL_00a5: ldloc.0
    IL_00a6: ldarg.0
    IL_00a7: ldfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_00ac: callvirt int System.Collections.Generic.List<BuildSlot>::get_Count()  /*0x0A000053*/
    IL_00b1: blt IL_000d
    IL_00b6: ldarg.1
    IL_00b7: callvirt int System.Collections.Generic.List<UnityEngine.MeshFilter>::get_Count()  /*0x0A000132*/
    IL_00bc: ret

  .method BuildSlot::GetGameObjectsThatWillUnlockWhenUpgraded(int)  // token 0x060002F1 rva 0xcb6c attrs Public, HideBySig
    // code size 87 (0x57), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0006: ldarg.0
    IL_0007: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_000c: callvirt int System.Collections.Generic.List<BuildSlot.Upgrade>::get_Count()  /*0x0A000118*/
    IL_0011: blt.s IL_0019
    IL_0013: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000133*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_001f: ldarg.0
    IL_0020: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0025: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_002a: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_002f: ldarg.1
    IL_0030: ldarg.0
    IL_0031: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0036: ldarg.0
    IL_0037: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_003c: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0041: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0046: callvirt int System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Count()  /*0x0A00011E*/
    IL_004b: rem
    IL_004c: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_0051: ldfld List<GameObject> BuildSlot.UpgradeBranch::objectsToActivate  /*0x040003C4*/
    IL_0056: ret

  .method BuildSlot::Start()  // token 0x060002F2 rva 0xcbd0 attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 217 (0xd9), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: stfld BuildSlot BuildSlot::requiredRoot  /*0x04000393*/
    IL_0007: ldarg.0
    IL_0008: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_000d: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0012: brfalse.s IL_0038
    IL_0014: ldarg.0
    IL_0015: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_001a: ldfld List<BuildSlot> BuildSlot::isActivatorOf  /*0x04000395*/
    IL_001f: ldarg.0
    IL_0020: callvirt void System.Collections.Generic.List<BuildSlot>::Add(!0)  /*0x0A00012E*/
    IL_0025: br.s IL_0038
    IL_0027: ldarg.0
    IL_0028: ldarg.0
    IL_0029: ldfld BuildSlot BuildSlot::requiredRoot  /*0x04000393*/
    IL_002e: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_0033: stfld BuildSlot BuildSlot::requiredRoot  /*0x04000393*/
    IL_0038: ldarg.0
    IL_0039: ldfld BuildSlot BuildSlot::requiredRoot  /*0x04000393*/
    IL_003e: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_0043: ldnull
    IL_0044: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0049: brtrue.s IL_0027
    IL_004b: ldarg.0
    IL_004c: ldfld BuildSlot BuildSlot::requiredRoot  /*0x04000393*/
    IL_0051: ldarg.0
    IL_0052: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0057: brfalse.s IL_006a
    IL_0059: ldarg.0
    IL_005a: ldfld BuildSlot BuildSlot::requiredRoot  /*0x04000393*/
    IL_005f: ldfld List<BuildSlot> BuildSlot::isRootOf  /*0x04000394*/
    IL_0064: ldarg.0
    IL_0065: callvirt void System.Collections.Generic.List<BuildSlot>::Add(!0)  /*0x0A00012E*/
    IL_006a: ldarg.0
    IL_006b: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_0070: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0075: brfalse.s IL_0088
    IL_0077: ldarg.0
    IL_0078: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_007d: ldfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_0082: ldarg.0
    IL_0083: callvirt void System.Collections.Generic.List<BuildSlot>::Add(!0)  /*0x0A00012E*/
    IL_0088: ldarg.0
    IL_0089: ldfld bool BuildSlot::startDeactivated  /*0x04000397*/
    IL_008e: brfalse.s IL_00c7
    IL_0090: ldarg.0
    IL_0091: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0096: ldc.i4.0
    IL_0097: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_009c: ldarg.0
    IL_009d: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_00a2: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00a7: brfalse.s IL_00cd
    IL_00a9: ldarg.0
    IL_00aa: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_00af: ldfld UnityEvent BuildSlot::OnUpgrade  /*0x040003B0*/
    IL_00b4: ldarg.0
    IL_00b5: ldftn void BuildSlot::Activate()  /*0x060002F3*/
    IL_00bb: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00c0: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00c5: br.s IL_00cd
    IL_00c7: ldarg.0
    IL_00c8: call void BuildSlot::Activate()  /*0x060002F3*/
    IL_00cd: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_00d2: ldarg.0
    IL_00d3: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_00d8: ret

  .method BuildSlot::Activate()  // token 0x060002F3 rva 0xccb8 attrs Public, HideBySig
    // code size 68 (0x44), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildSlot::gotActivated  /*0x040003B4*/
    IL_0006: brtrue.s IL_0023
    IL_0008: ldarg.0
    IL_0009: ldfld bool BuildSlot::startDeactivated  /*0x04000397*/
    IL_000e: brfalse.s IL_0024
    IL_0010: ldarg.0
    IL_0011: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_0016: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_001b: ldarg.0
    IL_001c: ldfld int BuildSlot::activatorLevel  /*0x04000399*/
    IL_0021: bgt.s IL_0024
    IL_0023: ret
    IL_0024: ldarg.0
    IL_0025: ldc.i4.1
    IL_0026: stfld bool BuildSlot::gotActivated  /*0x040003B4*/
    IL_002b: ldarg.0
    IL_002c: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0031: ldc.i4.1
    IL_0032: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0037: ldarg.0
    IL_0038: ldarg.0
    IL_0039: call BuildSlot.BuildingState BuildSlot::get_State()  /*0x060002D9*/
    IL_003e: call void BuildSlot::ActivateOrDeactivateBuliding(BuildSlot.BuildingState)  /*0x060002F5*/
    IL_0043: ret

  .method BuildSlot::ActivateIgrnoringActivatorLevel()  // token 0x060002F4 rva 0xcd08 attrs Public, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildSlot::gotActivated  /*0x040003B4*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.i4.1
    IL_000b: stfld bool BuildSlot::gotActivated  /*0x040003B4*/
    IL_0010: ldarg.0
    IL_0011: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0016: ldc.i4.1
    IL_0017: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001c: ldarg.0
    IL_001d: ldarg.0
    IL_001e: call BuildSlot.BuildingState BuildSlot::get_State()  /*0x060002D9*/
    IL_0023: call void BuildSlot::ActivateOrDeactivateBuliding(BuildSlot.BuildingState)  /*0x060002F5*/
    IL_0028: ret

  .method BuildSlot::ActivateOrDeactivateBuliding(BuildSlot.BuildingState)  // token 0x060002F5 rva 0xcd34 attrs Private, HideBySig
    // code size 110 (0x6e), max stack 2, init locals
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_0008
    IL_0003: ldarg.1
    IL_0004: ldc.i4.1
    IL_0005: beq.s IL_003b
    IL_0007: ret
    IL_0008: ldarg.0
    IL_0009: ldfld GameObject BuildSlot::buildingParent  /*0x040003A0*/
    IL_000e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0013: brfalse.s IL_0021
    IL_0015: ldarg.0
    IL_0016: ldfld GameObject BuildSlot::buildingParent  /*0x040003A0*/
    IL_001b: ldc.i4.0
    IL_001c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0021: ldarg.0
    IL_0022: ldfld GameObject BuildSlot::bluepringParent  /*0x040003A1*/
    IL_0027: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002c: brfalse.s IL_006d
    IL_002e: ldarg.0
    IL_002f: ldfld GameObject BuildSlot::bluepringParent  /*0x040003A1*/
    IL_0034: ldc.i4.1
    IL_0035: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003a: ret
    IL_003b: ldarg.0
    IL_003c: ldfld GameObject BuildSlot::buildingParent  /*0x040003A0*/
    IL_0041: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0046: brfalse.s IL_0054
    IL_0048: ldarg.0
    IL_0049: ldfld GameObject BuildSlot::buildingParent  /*0x040003A0*/
    IL_004e: ldc.i4.1
    IL_004f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0054: ldarg.0
    IL_0055: ldfld GameObject BuildSlot::bluepringParent  /*0x040003A1*/
    IL_005a: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_005f: brfalse.s IL_006d
    IL_0061: ldarg.0
    IL_0062: ldfld GameObject BuildSlot::bluepringParent  /*0x040003A1*/
    IL_0067: ldc.i4.0
    IL_0068: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_006d: ret

  .method BuildSlot::TryToBuildOrUpgradeAndPay(PlayerInteraction,bool)  // token 0x060002F6 rva 0xcdb0 attrs Public, HideBySig
    // code size 204 (0xcc), max stack 3, init locals
    .locals ([0] int, [1] BuildSlot, [2] int, [3] BuildSlot)
    IL_0000: ldarg.0
    IL_0001: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld bool BuildSlot::activatorUpgradesThis  /*0x0400039A*/
    IL_000f: brfalse.s IL_001f
    IL_0011: ldarg.0
    IL_0012: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_0017: ldarg.1
    IL_0018: ldarg.2
    IL_0019: callvirt void BuildSlot::TryToBuildOrUpgradeAndPay(PlayerInteraction,bool)  /*0x060002F6*/
    IL_001e: ret
    IL_001f: ldc.i4.0
    IL_0020: stloc.0
    IL_0021: br.s IL_005e
    IL_0023: ldarg.0
    IL_0024: ldfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_0029: ldloc.0
    IL_002a: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_002f: stloc.1
    IL_0030: ldloc.1
    IL_0031: callvirt bool BuildSlot::get_ActivatorUpgradesThis()  /*0x060002D0*/
    IL_0036: brfalse.s IL_005a
    IL_0038: ldloc.1
    IL_0039: ldfld BuildSlot BuildSlot::activatorBuilding  /*0x04000398*/
    IL_003e: ldarg.0
    IL_003f: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0044: brfalse.s IL_005a
    IL_0046: ldloc.1
    IL_0047: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_004c: ldc.i4.1
    IL_004d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0052: ldloc.1
    IL_0053: ldarg.1
    IL_0054: ldc.i4.0
    IL_0055: callvirt void BuildSlot::ExecuteBuildOrUpgrade(PlayerInteraction,bool)  /*0x060002F7*/
    IL_005a: ldloc.0
    IL_005b: ldc.i4.1
    IL_005c: add
    IL_005d: stloc.0
    IL_005e: ldloc.0
    IL_005f: ldarg.0
    IL_0060: ldfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_0065: callvirt int System.Collections.Generic.List<BuildSlot>::get_Count()  /*0x0A000053*/
    IL_006a: blt.s IL_0023
    IL_006c: ldarg.0
    IL_006d: ldarg.1
    IL_006e: ldarg.2
    IL_006f: call void BuildSlot::ExecuteBuildOrUpgrade(PlayerInteraction,bool)  /*0x060002F7*/
    IL_0074: ldc.i4.0
    IL_0075: stloc.2
    IL_0076: br.s IL_00a3
    IL_0078: ldarg.0
    IL_0079: ldfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_007e: ldloc.2
    IL_007f: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_0084: stloc.3
    IL_0085: ldloc.3
    IL_0086: ldfld BuildingInteractor BuildSlot::buildingInteractor  /*0x040003AB*/
    IL_008b: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0090: brfalse.s IL_009f
    IL_0092: ldloc.3
    IL_0093: ldfld BuildingInteractor BuildSlot::buildingInteractor  /*0x040003AB*/
    IL_0098: ldc.i4.0
    IL_0099: ldc.i4.0
    IL_009a: callvirt void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_009f: ldloc.2
    IL_00a0: ldc.i4.1
    IL_00a1: add
    IL_00a2: stloc.2
    IL_00a3: ldloc.2
    IL_00a4: ldarg.0
    IL_00a5: ldfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_00aa: callvirt int System.Collections.Generic.List<BuildSlot>::get_Count()  /*0x0A000053*/
    IL_00af: blt.s IL_0078
    IL_00b1: ldarg.0
    IL_00b2: ldfld BuildingInteractor BuildSlot::buildingInteractor  /*0x040003AB*/
    IL_00b7: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00bc: brfalse.s IL_00cb
    IL_00be: ldarg.0
    IL_00bf: ldfld BuildingInteractor BuildSlot::buildingInteractor  /*0x040003AB*/
    IL_00c4: ldc.i4.0
    IL_00c5: ldc.i4.0
    IL_00c6: callvirt void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_00cb: ret

  .method BuildSlot::ExecuteBuildOrUpgrade(PlayerInteraction,bool)  // token 0x060002F7 rva 0xce88 attrs Public, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0010: ldarg.0
    IL_0011: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0016: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_001b: ldarg.1
    IL_001c: ldarg.2
    IL_001d: call void BuildSlot::ExecuteUpgrade(BuildSlot.Upgrade,PlayerInteraction,bool)  /*0x060002F8*/
    IL_0022: ret

  .method BuildSlot::ExecuteUpgrade(BuildSlot.Upgrade,PlayerInteraction,bool)  // token 0x060002F8 rva 0xceac attrs Private, HideBySig
    // code size 161 (0xa1), max stack 5, init locals
    .locals ([0] List<Choice>, [1] List.Enumerator<BuildSlot.UpgradeBranch>, [2] BuildSlot.UpgradeBranch)
    IL_0000: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_0005: callvirt bool ChoiceManager::get_ChoiceCoroutineRunning()  /*0x0600091E*/
    IL_000a: brfalse.s IL_000d
    IL_000c: ret
    IL_000d: newobj void System.Collections.Generic.List<Choice>::.ctor()  /*0x0A000134*/
    IL_0012: stloc.0
    IL_0013: ldarg.1
    IL_0014: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0019: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot.UpgradeBranch>::GetEnumerator()  /*0x0A000121*/
    IL_001e: stloc.1
    IL_001f: br.s IL_0035
    IL_0021: ldloca.s 1
    IL_0023: call !0 System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::get_Current()  /*0x0A000122*/
    IL_0028: stloc.2
    IL_0029: ldloc.0
    IL_002a: ldloc.2
    IL_002b: ldfld Choice BuildSlot.UpgradeBranch::choiceDetails  /*0x040003BF*/
    IL_0030: callvirt void System.Collections.Generic.List<Choice>::Add(!0)  /*0x0A000135*/
    IL_0035: ldloca.s 1
    IL_0037: call bool System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::MoveNext()  /*0x0A000125*/
    IL_003c: brtrue.s IL_0021
    IL_003e: leave.s IL_004e
    IL_0040: ldloca.s 1
    IL_0042: constrained. System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>  /*0x1B000022*/
    IL_0048: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_004d: endfinally
    IL_004e: ldarg.0
    IL_004f: ldarg.1
    IL_0050: stfld BuildSlot.Upgrade BuildSlot::upgradeSelected  /*0x040003B5*/
    IL_0055: ldarg.0
    IL_0056: ldarg.2
    IL_0057: stfld PlayerInteraction BuildSlot::playerInteractionSelected  /*0x040003B6*/
    IL_005c: ldarg.3
    IL_005d: brfalse.s IL_0079
    IL_005f: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_0064: ldloc.0
    IL_0065: ldarg.0
    IL_0066: ldarg.0
    IL_0067: dup
    IL_0068: ldvirtftn void BuildSlot::OnUpgradeChoiceComplete(Choice)  /*0x060002F9*/
    IL_006e: newobj void System.Action<Choice>::.ctor(object,IntPtr)  /*0x0A000136*/
    IL_0073: callvirt void ChoiceManager::PresentChoices(System.Collections.Generic.List<Choice>,BuildSlot,System.Action<Choice>)  /*0x06000921*/
    IL_0078: ret
    IL_0079: ldarg.0
    IL_007a: ldarg.1
    IL_007b: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0080: ldc.i4.0
    IL_0081: ldarg.1
    IL_0082: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0087: callvirt int System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Count()  /*0x0A00011E*/
    IL_008c: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_0091: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_0096: ldfld Choice BuildSlot.UpgradeBranch::choiceDetails  /*0x040003BF*/
    IL_009b: callvirt void BuildSlot::OnUpgradeChoiceComplete(Choice)  /*0x060002F9*/
    IL_00a0: ret
    .try IL_001f-IL_0040 finally handler IL_0040-IL_004e

  .method BuildSlot::OnUpgradeChoiceComplete(Choice)  // token 0x060002F9 rva 0xcf6c attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 301 (0x12d), max stack 3, init locals
    .locals ([0] BuildSlot.UpgradeBranch, [1] int, [2] List.Enumerator<BuildSlot.UpgradeBranch>, [3] BuildSlot.UpgradeBranch, [4] List.Enumerator<BuildSlot>, [5] BuildSlot, [6] BuildingInteractor[], [7] int, [8] BuildingInteractor)
    IL_0000: ldarg.1
    IL_0001: brtrue.s IL_000f
    IL_0003: ldarg.0
    IL_0004: ldfld UnityEvent BuildSlot::OnUpgradeCancel  /*0x040003B2*/
    IL_0009: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0015: brtrue.s IL_001e
    IL_0017: ldarg.0
    IL_0018: ldc.i4.1
    IL_0019: call void BuildSlot::ActivateOrDeactivateBuliding(BuildSlot.BuildingState)  /*0x060002F5*/
    IL_001e: ldarg.0
    IL_001f: ldarg.0
    IL_0020: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0025: ldc.i4.1
    IL_0026: add
    IL_0027: stfld int BuildSlot::level  /*0x0400039C*/
    IL_002c: ldnull
    IL_002d: stloc.0
    IL_002e: ldc.i4.0
    IL_002f: stloc.1
    IL_0030: ldarg.0
    IL_0031: ldfld BuildSlot.Upgrade BuildSlot::upgradeSelected  /*0x040003B5*/
    IL_0036: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_003b: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot.UpgradeBranch>::GetEnumerator()  /*0x0A000121*/
    IL_0040: stloc.2
    IL_0041: br.s IL_0066
    IL_0043: ldloca.s 2
    IL_0045: call !0 System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::get_Current()  /*0x0A000122*/
    IL_004a: stloc.3
    IL_004b: ldloc.3
    IL_004c: ldfld Choice BuildSlot.UpgradeBranch::choiceDetails  /*0x040003BF*/
    IL_0051: ldarg.1
    IL_0052: bne.un.s IL_0062
    IL_0054: ldloc.3
    IL_0055: stloc.0
    IL_0056: ldarg.0
    IL_0057: ldfld List<int> BuildSlot::appliedUpgrades  /*0x0400039D*/
    IL_005c: ldloc.1
    IL_005d: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0062: ldloc.1
    IL_0063: ldc.i4.1
    IL_0064: add
    IL_0065: stloc.1
    IL_0066: ldloca.s 2
    IL_0068: call bool System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::MoveNext()  /*0x0A000125*/
    IL_006d: brtrue.s IL_0043
    IL_006f: leave.s IL_007f
    IL_0071: ldloca.s 2
    IL_0073: constrained. System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>  /*0x1B000022*/
    IL_0079: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_007e: endfinally
    IL_007f: ldarg.0
    IL_0080: ldloc.0
    IL_0081: ldc.i4.0
    IL_0082: call void BuildSlot::ApplyLocalUpgradeChanges(BuildSlot.UpgradeBranch,bool)  /*0x060002FB*/
    IL_0087: ldarg.0
    IL_0088: ldfld List<BuildSlot> BuildSlot::isRootOf  /*0x04000394*/
    IL_008d: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot>::GetEnumerator()  /*0x0A000137*/
    IL_0092: stloc.s 4
    IL_0094: br.s IL_00df
    IL_0096: ldloca.s 4
    IL_0098: call !0 System.Collections.Generic.List.Enumerator<BuildSlot>::get_Current()  /*0x0A000138*/
    IL_009d: stloc.s 5
    IL_009f: ldloc.s 5
    IL_00a1: ldnull
    IL_00a2: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00a7: brtrue.s IL_00df
    IL_00a9: ldloc.s 5
    IL_00ab: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren()<BuildingInteractor>  /*0x2B000025*/
    IL_00b0: stloc.s 6
    IL_00b2: ldc.i4.0
    IL_00b3: stloc.s 7
    IL_00b5: br.s IL_00d7
    IL_00b7: ldloc.s 6
    IL_00b9: ldloc.s 7
    IL_00bb: ldelem.ref
    IL_00bc: stloc.s 8
    IL_00be: ldloc.s 8
    IL_00c0: ldnull
    IL_00c1: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00c6: brtrue.s IL_00d1
    IL_00c8: ldloc.s 8
    IL_00ca: ldc.i4.0
    IL_00cb: ldc.i4.0
    IL_00cc: callvirt void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_00d1: ldloc.s 7
    IL_00d3: ldc.i4.1
    IL_00d4: add
    IL_00d5: stloc.s 7
    IL_00d7: ldloc.s 7
    IL_00d9: ldloc.s 6
    IL_00db: ldlen
    IL_00dc: conv.i4
    IL_00dd: blt.s IL_00b7
    IL_00df: ldloca.s 4
    IL_00e1: call bool System.Collections.Generic.List.Enumerator<BuildSlot>::MoveNext()  /*0x0A000139*/
    IL_00e6: brtrue.s IL_0096
    IL_00e8: leave.s IL_00f8
    IL_00ea: ldloca.s 4
    IL_00ec: constrained. System.Collections.Generic.List.Enumerator<BuildSlot>  /*0x1B000029*/
    IL_00f2: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00f7: endfinally
    IL_00f8: ldarg.0
    IL_00f9: ldfld bool BuildSlot::activatorUpgradesThis  /*0x0400039A*/
    IL_00fe: brfalse.s IL_010c
    IL_0100: ldarg.0
    IL_0101: ldfld UnityEvent BuildSlot::OnParentUpgrade  /*0x040003B1*/
    IL_0106: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_010b: ret
    IL_010c: ldarg.0
    IL_010d: ldfld UnityEvent BuildSlot::OnUpgradeEarly  /*0x040003AF*/
    IL_0112: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0117: ldarg.0
    IL_0118: ldfld UnityEvent BuildSlot::OnUpgrade  /*0x040003B0*/
    IL_011d: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0122: ldsfld TooltipManager TooltipManager::instance  /*0x04001167*/
    IL_0127: callvirt void TooltipManager::SetInteractorRefreshFlag()  /*0x06000F14*/
    IL_012c: ret
    .try IL_0041-IL_0071 finally handler IL_0071-IL_007f
    .try IL_0094-IL_00ea finally handler IL_00ea-IL_00f8

  .method BuildSlot::ForceManualUpgradeWithoutFeedbackEffects(BuildSlot.UpgradeBranch)  // token 0x060002FA rva 0xd0c4 attrs Public, HideBySig
    // code size 325 (0x145), max stack 3, init locals
    .locals ([0] BuildSlot.<>c__DisplayClass123_0, [1] int, [2] List.Enumerator<BuildSlot>, [3] BuildSlot, [4] BuildingInteractor[], [5] int, [6] BuildingInteractor)
    IL_0000: newobj void BuildSlot.<>c__DisplayClass123_0::.ctor()  /*0x06000309*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldarg.1
    IL_0008: stfld BuildSlot.UpgradeBranch BuildSlot.<>c__DisplayClass123_0::upgBranch  /*0x040003C9*/
    IL_000d: ldloc.0
    IL_000e: ldfld BuildSlot.UpgradeBranch BuildSlot.<>c__DisplayClass123_0::upgBranch  /*0x040003C9*/
    IL_0013: brtrue.s IL_002c
    IL_0015: ldarg.0
    IL_0016: ldfld UnityEvent BuildSlot::OnUpgradeEarly  /*0x040003AF*/
    IL_001b: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0020: ldarg.0
    IL_0021: ldfld UnityEvent BuildSlot::OnUpgradeCancel  /*0x040003B2*/
    IL_0026: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_002b: ret
    IL_002c: ldarg.0
    IL_002d: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0032: brtrue.s IL_003b
    IL_0034: ldarg.0
    IL_0035: ldc.i4.1
    IL_0036: call void BuildSlot::ActivateOrDeactivateBuliding(BuildSlot.BuildingState)  /*0x060002F5*/
    IL_003b: ldarg.0
    IL_003c: ldarg.0
    IL_003d: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0042: ldc.i4.1
    IL_0043: add
    IL_0044: stfld int BuildSlot::level  /*0x0400039C*/
    IL_0049: ldarg.0
    IL_004a: ldloc.0
    IL_004b: ldfld BuildSlot.UpgradeBranch BuildSlot.<>c__DisplayClass123_0::upgBranch  /*0x040003C9*/
    IL_0050: ldc.i4.0
    IL_0051: call void BuildSlot::ApplyLocalUpgradeChanges(BuildSlot.UpgradeBranch,bool)  /*0x060002FB*/
    IL_0056: ldarg.0
    IL_0057: ldfld List<BuildSlot> BuildSlot::isRootOf  /*0x04000394*/
    IL_005c: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot>::GetEnumerator()  /*0x0A000137*/
    IL_0061: stloc.2
    IL_0062: br.s IL_00aa
    IL_0064: ldloca.s 2
    IL_0066: call !0 System.Collections.Generic.List.Enumerator<BuildSlot>::get_Current()  /*0x0A000138*/
    IL_006b: stloc.3
    IL_006c: ldloc.3
    IL_006d: ldnull
    IL_006e: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0073: brtrue.s IL_00aa
    IL_0075: ldloc.3
    IL_0076: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren()<BuildingInteractor>  /*0x2B000025*/
    IL_007b: stloc.s 4
    IL_007d: ldc.i4.0
    IL_007e: stloc.s 5
    IL_0080: br.s IL_00a2
    IL_0082: ldloc.s 4
    IL_0084: ldloc.s 5
    IL_0086: ldelem.ref
    IL_0087: stloc.s 6
    IL_0089: ldloc.s 6
    IL_008b: ldnull
    IL_008c: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0091: brtrue.s IL_009c
    IL_0093: ldloc.s 6
    IL_0095: ldc.i4.0
    IL_0096: ldc.i4.0
    IL_0097: callvirt void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_009c: ldloc.s 5
    IL_009e: ldc.i4.1
    IL_009f: add
    IL_00a0: stloc.s 5
    IL_00a2: ldloc.s 5
    IL_00a4: ldloc.s 4
    IL_00a6: ldlen
    IL_00a7: conv.i4
    IL_00a8: blt.s IL_0082
    IL_00aa: ldloca.s 2
    IL_00ac: call bool System.Collections.Generic.List.Enumerator<BuildSlot>::MoveNext()  /*0x0A000139*/
    IL_00b1: brtrue.s IL_0064
    IL_00b3: leave.s IL_00c3
    IL_00b5: ldloca.s 2
    IL_00b7: constrained. System.Collections.Generic.List.Enumerator<BuildSlot>  /*0x1B000029*/
    IL_00bd: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00c2: endfinally
    IL_00c3: ldarg.0
    IL_00c4: ldfld List<BuildSlot> BuildSlot::isActivatorOf  /*0x04000395*/
    IL_00c9: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot>::GetEnumerator()  /*0x0A000137*/
    IL_00ce: stloc.2
    IL_00cf: br.s IL_00dd
    IL_00d1: ldloca.s 2
    IL_00d3: call !0 System.Collections.Generic.List.Enumerator<BuildSlot>::get_Current()  /*0x0A000138*/
    IL_00d8: callvirt void BuildSlot::Activate()  /*0x060002F3*/
    IL_00dd: ldloca.s 2
    IL_00df: call bool System.Collections.Generic.List.Enumerator<BuildSlot>::MoveNext()  /*0x0A000139*/
    IL_00e4: brtrue.s IL_00d1
    IL_00e6: leave.s IL_00f6
    IL_00e8: ldloca.s 2
    IL_00ea: constrained. System.Collections.Generic.List.Enumerator<BuildSlot>  /*0x1B000029*/
    IL_00f0: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00f5: endfinally
    IL_00f6: ldarg.0
    IL_00f7: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_00fc: ldarg.0
    IL_00fd: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_0102: ldc.i4.1
    IL_0103: sub
    IL_0104: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0109: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_010e: ldloc.0
    IL_010f: ldftn bool BuildSlot.<>c__DisplayClass123_0::<ForceManualUpgradeWithoutFeedbackEffects>b__0(BuildSlot.UpgradeBranch)  /*0x0600030A*/
    IL_0115: newobj void System.Predicate<BuildSlot.UpgradeBranch>::.ctor(object,IntPtr)  /*0x0A00013A*/
    IL_011a: callvirt int System.Collections.Generic.List<BuildSlot.UpgradeBranch>::FindIndex(System.Predicate<!0>)  /*0x0A00013B*/
    IL_011f: stloc.1
    IL_0120: ldloc.1
    IL_0121: ldc.i4.m1
    IL_0122: bne.un.s IL_0126
    IL_0124: ldc.i4.0
    IL_0125: stloc.1
    IL_0126: ldarg.0
    IL_0127: ldfld List<int> BuildSlot::appliedUpgrades  /*0x0400039D*/
    IL_012c: ldloc.1
    IL_012d: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0132: ldarg.0
    IL_0133: ldfld bool BuildSlot::activatorUpgradesThis  /*0x0400039A*/
    IL_0138: brtrue.s IL_0144
    IL_013a: ldsfld TooltipManager TooltipManager::instance  /*0x04001167*/
    IL_013f: callvirt void TooltipManager::SetInteractorRefreshFlag()  /*0x06000F14*/
    IL_0144: ret
    .try IL_0062-IL_00b5 finally handler IL_00b5-IL_00c3
    .try IL_00cf-IL_00e8 finally handler IL_00e8-IL_00f6

  .method BuildSlot::ApplyLocalUpgradeChanges(BuildSlot.UpgradeBranch,bool)  // token 0x060002FB rva 0xd234 attrs Public, HideBySig
    // code size 474 (0x1da), max stack 3, init locals
    .locals ([0] Scene, [1] List.Enumerator<GameObject>, [2] GameObject, [3] GameObject)
    IL_0000: ldarg.1
    IL_0001: brtrue.s IL_0004
    IL_0003: ret
    IL_0004: ldarg.0
    IL_0005: ldfld BuildingMeshTracker BuildSlot::buildingMeshTracker  /*0x040003AA*/
    IL_000a: callvirt void BuildingMeshTracker::Unfreeze()  /*0x060002B8*/
    IL_000f: ldarg.0
    IL_0010: ldfld BuildingMeshTracker BuildSlot::buildingMeshTracker  /*0x040003AA*/
    IL_0015: callvirt void BuildingMeshTracker::FreezeMeshWithDelay()  /*0x060002B9*/
    IL_001a: ldarg.1
    IL_001b: ldfld Mesh BuildSlot.UpgradeBranch::replacementMesh  /*0x040003C0*/
    IL_0020: ldnull
    IL_0021: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0026: brfalse.s IL_0039
    IL_0028: ldarg.0
    IL_0029: ldfld MeshFilter BuildSlot::mainMesh  /*0x040003A3*/
    IL_002e: ldarg.1
    IL_002f: ldfld Mesh BuildSlot.UpgradeBranch::replacementMesh  /*0x040003C0*/
    IL_0034: callvirt void UnityEngine.MeshFilter::set_mesh(UnityEngine.Mesh)  /*0x0A00013C*/
    IL_0039: ldarg.0
    IL_003a: ldarg.0
    IL_003b: ldfld int BuildSlot::goldIncome  /*0x040003AC*/
    IL_0040: ldarg.1
    IL_0041: ldfld int BuildSlot.UpgradeBranch::goldIncomeChange  /*0x040003C1*/
    IL_0046: add
    IL_0047: stfld int BuildSlot::goldIncome  /*0x040003AC*/
    IL_004c: ldc.i4.0
    IL_004d: ldarg.0
    IL_004e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0053: callvirt Scene UnityEngine.GameObject::get_scene()  /*0x0A00011A*/
    IL_0058: stloc.0
    IL_0059: ldloca.s 0
    IL_005b: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_0060: call bool DlcConfiguration::IsDlcMap(IDlcProvider.DlcId,string)  /*0x0600001D*/
    IL_0065: brfalse.s IL_0082
    IL_0067: ldc.i4.0
    IL_0068: call bool DlcConfiguration::IsDlcAvailable(IDlcProvider.DlcId)  /*0x0600001C*/
    IL_006d: brfalse.s IL_0082
    IL_006f: ldarg.0
    IL_0070: ldarg.0
    IL_0071: ldfld int BuildSlot::energyCoreIncome  /*0x040003AD*/
    IL_0076: ldarg.1
    IL_0077: ldfld int BuildSlot.UpgradeBranch::energyCoreIncomeChange  /*0x040003C2*/
    IL_007c: add
    IL_007d: stfld int BuildSlot::energyCoreIncome  /*0x040003AD*/
    IL_0082: ldarg.0
    IL_0083: call Hp BuildSlot::get_HpParent()  /*0x060002D5*/
    IL_0088: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_008d: brfalse IL_0125
    IL_0092: ldarg.2
    IL_0093: brtrue IL_0125
    IL_0098: ldarg.0
    IL_0099: call Hp BuildSlot::get_HpParent()  /*0x060002D5*/
    IL_009e: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_00a3: ldc.r4 0f
    IL_00a8: bgt.un.s IL_00d4
    IL_00aa: ldarg.0
    IL_00ab: ldfld int BuildSlot::level  /*0x0400039C*/
    IL_00b0: ldc.i4.1
    IL_00b1: ble.s IL_00d4
    IL_00b3: ldarg.0
    IL_00b4: call Hp BuildSlot::get_HpParent()  /*0x060002D5*/
    IL_00b9: ldc.i4.1
    IL_00ba: ldc.r4 1f
    IL_00bf: callvirt void Hp::Revive(bool,float)  /*0x0600082A*/
    IL_00c4: ldarg.0
    IL_00c5: call Hp BuildSlot::get_HpParent()  /*0x060002D5*/
    IL_00ca: ldc.r4 1f
    IL_00cf: callvirt void Hp::SetHpTo(float)  /*0x0600082F*/
    IL_00d4: ldarg.0
    IL_00d5: call Hp BuildSlot::get_HpParent()  /*0x060002D5*/
    IL_00da: dup
    IL_00db: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_00e0: ldarg.1
    IL_00e1: ldfld int BuildSlot.UpgradeBranch::hpChange  /*0x040003C3*/
    IL_00e6: conv.r4
    IL_00e7: add
    IL_00e8: stfld float Hp::maxHp  /*0x04000A2C*/
    IL_00ed: ldarg.0
    IL_00ee: call Hp BuildSlot::get_HpParent()  /*0x060002D5*/
    IL_00f3: ldarg.1
    IL_00f4: ldfld int BuildSlot.UpgradeBranch::hpChange  /*0x040003C3*/
    IL_00f9: conv.r4
    IL_00fa: callvirt void Hp::Heal(float)  /*0x0600082E*/
    IL_00ff: ldarg.0
    IL_0100: call Hp BuildSlot::get_HpParent()  /*0x060002D5*/
    IL_0105: callvirt TaggedObject Hp::get_TaggedObj()  /*0x06000816*/
    IL_010a: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_010f: brfalse.s IL_015b
    IL_0111: ldarg.0
    IL_0112: call Hp BuildSlot::get_HpParent()  /*0x060002D5*/
    IL_0117: callvirt TaggedObject Hp::get_TaggedObj()  /*0x06000816*/
    IL_011c: ldc.i4.s 25
    IL_011e: callvirt void TaggedObject::RemoveTag(TagManager.ETag)  /*0x06000E4A*/
    IL_0123: br.s IL_015b
    IL_0125: ldarg.0
    IL_0126: call Hp BuildSlot::get_HpParent()  /*0x060002D5*/
    IL_012b: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0130: brfalse.s IL_015b
    IL_0132: ldarg.0
    IL_0133: call Hp BuildSlot::get_HpParent()  /*0x060002D5*/
    IL_0138: dup
    IL_0139: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_013e: ldarg.1
    IL_013f: ldfld int BuildSlot.UpgradeBranch::hpChange  /*0x040003C3*/
    IL_0144: conv.r4
    IL_0145: add
    IL_0146: stfld float Hp::maxHp  /*0x04000A2C*/
    IL_014b: ldarg.0
    IL_014c: call Hp BuildSlot::get_HpParent()  /*0x060002D5*/
    IL_0151: ldfld UnityEvent Hp::OnHpChange  /*0x04000A3A*/
    IL_0156: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_015b: ldarg.1
    IL_015c: ldfld List<GameObject> BuildSlot.UpgradeBranch::objectsToActivate  /*0x040003C4*/
    IL_0161: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_0166: stloc.1
    IL_0167: br.s IL_0181
    IL_0169: ldloca.s 1
    IL_016b: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_0170: stloc.2
    IL_0171: ldloc.2
    IL_0172: ldnull
    IL_0173: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0178: brfalse.s IL_0181
    IL_017a: ldloc.2
    IL_017b: ldc.i4.1
    IL_017c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0181: ldloca.s 1
    IL_0183: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_0188: brtrue.s IL_0169
    IL_018a: leave.s IL_019a
    IL_018c: ldloca.s 1
    IL_018e: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_0194: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0199: endfinally
    IL_019a: ldarg.1
    IL_019b: ldfld List<GameObject> BuildSlot.UpgradeBranch::objectsToDisable  /*0x040003C5*/
    IL_01a0: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_01a5: stloc.1
    IL_01a6: br.s IL_01c0
    IL_01a8: ldloca.s 1
    IL_01aa: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_01af: stloc.3
    IL_01b0: ldloc.3
    IL_01b1: ldnull
    IL_01b2: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_01b7: brfalse.s IL_01c0
    IL_01b9: ldloc.3
    IL_01ba: ldc.i4.0
    IL_01bb: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01c0: ldloca.s 1
    IL_01c2: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_01c7: brtrue.s IL_01a8
    IL_01c9: leave.s IL_01d9
    IL_01cb: ldloca.s 1
    IL_01cd: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_01d3: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01d8: endfinally
    IL_01d9: ret
    .try IL_0167-IL_018c finally handler IL_018c-IL_019a
    .try IL_01a6-IL_01cb finally handler IL_01cb-IL_01d9

  .method BuildSlot::ReplaceMeshExternal(UnityEngine.Mesh)  // token 0x060002FC rva 0xd438 attrs Public, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildingMeshTracker BuildSlot::buildingMeshTracker  /*0x040003AA*/
    IL_0006: callvirt void BuildingMeshTracker::Unfreeze()  /*0x060002B8*/
    IL_000b: ldarg.0
    IL_000c: ldfld BuildingMeshTracker BuildSlot::buildingMeshTracker  /*0x040003AA*/
    IL_0011: callvirt void BuildingMeshTracker::FreezeMeshWithDelay()  /*0x060002B9*/
    IL_0016: ldarg.0
    IL_0017: ldfld MeshFilter BuildSlot::mainMesh  /*0x040003A3*/
    IL_001c: ldarg.1
    IL_001d: callvirt void UnityEngine.MeshFilter::set_mesh(UnityEngine.Mesh)  /*0x0A00013C*/
    IL_0022: ret

  .method BuildSlot::DEBUGUpgradeToMax()  // token 0x060002FD rva 0xd45c attrs Public, HideBySig
    // code size 45 (0x2d), max stack 8
    IL_0000: br.s IL_000a
    IL_0002: ldarg.0
    IL_0003: ldnull
    IL_0004: ldc.i4.0
    IL_0005: call void BuildSlot::TryToBuildOrUpgradeAndPay(PlayerInteraction,bool)  /*0x060002F6*/
    IL_000a: ldarg.0
    IL_000b: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_0010: brtrue.s IL_0002
    IL_0012: ldarg.0
    IL_0013: ldfld BuildingInteractor BuildSlot::interactor  /*0x040003A2*/
    IL_0018: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_001d: brfalse.s IL_002c
    IL_001f: ldarg.0
    IL_0020: ldfld BuildingInteractor BuildSlot::interactor  /*0x040003A2*/
    IL_0025: ldc.i4.0
    IL_0026: ldc.i4.0
    IL_0027: callvirt void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_002c: ret

  .method BuildSlot::OnDusk()  // token 0x060002FE rva 0xd48a attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool BuildSlot::get_IsBlueprint()  /*0x060002EB*/
    IL_0006: brfalse.s IL_0021
    IL_0008: ldarg.0
    IL_0009: ldfld GameObject BuildSlot::bluepringParent  /*0x040003A1*/
    IL_000e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0013: brfalse.s IL_0021
    IL_0015: ldarg.0
    IL_0016: ldfld GameObject BuildSlot::bluepringParent  /*0x040003A1*/
    IL_001b: ldc.i4.0
    IL_001c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0021: ret

  .method BuildSlot::OnDawn_AfterSunrise()  // token 0x060002FF rva 0xd4ad attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool BuildSlot::get_IsBlueprint()  /*0x060002EB*/
    IL_0006: brfalse.s IL_0021
    IL_0008: ldarg.0
    IL_0009: ldfld GameObject BuildSlot::bluepringParent  /*0x040003A1*/
    IL_000e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0013: brfalse.s IL_0021
    IL_0015: ldarg.0
    IL_0016: ldfld GameObject BuildSlot::bluepringParent  /*0x040003A1*/
    IL_001b: ldc.i4.1
    IL_001c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0021: ret

  .method BuildSlot::OnDawn_BeforeSunrise()  // token 0x06000300 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BuildSlot::OnDuskEarly()  // token 0x06000301 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BuildSlot::.ctor()  // token 0x06000302 rva 0xd4d0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 165 (0xa5), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.s -100
    IL_0003: stfld int BuildSlot::requiredRootLevelDifference  /*0x04000392*/
    IL_0008: ldarg.0
    IL_0009: newobj void System.Collections.Generic.List<BuildSlot>::.ctor()  /*0x0A00012D*/
    IL_000e: stfld List<BuildSlot> BuildSlot::isRootOf  /*0x04000394*/
    IL_0013: ldarg.0
    IL_0014: newobj void System.Collections.Generic.List<BuildSlot>::.ctor()  /*0x0A00012D*/
    IL_0019: stfld List<BuildSlot> BuildSlot::isActivatorOf  /*0x04000395*/
    IL_001e: ldarg.0
    IL_001f: newobj void System.Collections.Generic.List<UnityEngine.MeshFilter>::.ctor()  /*0x0A00013D*/
    IL_0024: stfld List<MeshFilter> BuildSlot::meshFilter  /*0x04000396*/
    IL_0029: ldarg.0
    IL_002a: ldc.i4.1
    IL_002b: stfld bool BuildSlot::startDeactivated  /*0x04000397*/
    IL_0030: ldarg.0
    IL_0031: newobj void System.Collections.Generic.List<BuildSlot.Upgrade>::.ctor()  /*0x0A00013E*/
    IL_0036: stfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_003b: ldarg.0
    IL_003c: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0041: stfld List<int> BuildSlot::appliedUpgrades  /*0x0400039D*/
    IL_0046: ldarg.0
    IL_0047: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_004c: stfld UnityEvent BuildSlot::OnAfterDelayedLoadFinished  /*0x0400039E*/
    IL_0051: ldarg.0
    IL_0052: ldc.r4 1f
    IL_0057: stfld float BuildSlot::navmeshCutPadding  /*0x040003A9*/
    IL_005c: ldarg.0
    IL_005d: newobj void System.Collections.Generic.List<BuildSlot.Upgrade>::.ctor()  /*0x0A00013E*/
    IL_0062: stfld List<BuildSlot.Upgrade> BuildSlot::upgradesWithCostsLoadedFromSave  /*0x040003AE*/
    IL_0067: ldarg.0
    IL_0068: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_006d: stfld UnityEvent BuildSlot::OnUpgradeEarly  /*0x040003AF*/
    IL_0072: ldarg.0
    IL_0073: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0078: stfld UnityEvent BuildSlot::OnUpgrade  /*0x040003B0*/
    IL_007d: ldarg.0
    IL_007e: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0083: stfld UnityEvent BuildSlot::OnParentUpgrade  /*0x040003B1*/
    IL_0088: ldarg.0
    IL_0089: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_008e: stfld UnityEvent BuildSlot::OnUpgradeCancel  /*0x040003B2*/
    IL_0093: ldarg.0
    IL_0094: newobj void System.Collections.Generic.List<BuildSlot>::.ctor()  /*0x0A00012D*/
    IL_0099: stfld List<BuildSlot> BuildSlot::builtSlotsThatRelyOnThisBuilding  /*0x040003B3*/
    IL_009e: ldarg.0
    IL_009f: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_00a4: ret

// ===== BuildSlot/BuildingState  (token 0x0200008C) =====
// ===== BuildSlot/Upgrade  (token 0x0200008D) =====
  .method BuildSlot.Upgrade::.ctor()  // token 0x06000303 rva 0xd581 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.3
    IL_0002: stfld int BuildSlot.Upgrade::cost  /*0x040003BB*/
    IL_0007: ldarg.0
    IL_0008: call void System.Object::.ctor()  /*0x0A000038*/
    IL_000d: ret

// ===== BuildSlot/UpgradeBranch  (token 0x0200008E) =====
  .method BuildSlot.UpgradeBranch::.ctor()  // token 0x06000304 rva 0xd590 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000133*/
    IL_0006: stfld List<GameObject> BuildSlot.UpgradeBranch::objectsToActivate  /*0x040003C4*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000133*/
    IL_0011: stfld List<GameObject> BuildSlot.UpgradeBranch::objectsToDisable  /*0x040003C5*/
    IL_0016: ldarg.0
    IL_0017: call void System.Object::.ctor()  /*0x0A000038*/
    IL_001c: ret

// ===== BuildSlot/<>c  (token 0x0200008F) =====
  .method BuildSlot.<>c::.cctor()  // token 0x06000305 rva 0xd5ae attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void BuildSlot.<>c::.ctor()  /*0x06000306*/
    IL_0005: stsfld BuildSlot.<>c BuildSlot.<>c::<>9  /*0x040003C6*/
    IL_000a: ret

  .method BuildSlot.<>c::.ctor()  // token 0x06000306 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method BuildSlot.<>c::<GodOfChoiceHandling>b__109_1(char)  // token 0x06000307 rva 0xb168 attrs Assembly, HideBySig
    // code size 2 (0x2), max stack 8
    IL_0000: ldarg.1
    IL_0001: ret

  .method BuildSlot.<>c::<GodOfChoiceHandling>b__109_0(BuildSlot.UpgradeBranch)  // token 0x06000308 rva 0xd5ba attrs Assembly, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldfld Choice BuildSlot.UpgradeBranch::choiceDetails  /*0x040003BF*/
    IL_0006: ldfld bool Choice::disabledInThisMode  /*0x04000B91*/
    IL_000b: ret

// ===== BuildSlot/<>c__DisplayClass123_0  (token 0x02000090) =====
  .method BuildSlot.<>c__DisplayClass123_0::.ctor()  // token 0x06000309 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method BuildSlot.<>c__DisplayClass123_0::<ForceManualUpgradeWithoutFeedbackEffects>b__0(BuildSlot.UpgradeBranch)  // token 0x0600030A rva 0xd5c7 attrs Assembly, HideBySig
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld BuildSlot.UpgradeBranch BuildSlot.<>c__DisplayClass123_0::upgBranch  /*0x040003C9*/
    IL_0007: ceq
    IL_0009: ret

// ===== BuildSlot/<ApplyLoadedUpgradesDelayed>d__85  (token 0x02000091) =====
  .method BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::.ctor(int)  // token 0x0600030B rva 0xd5d2 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::<>1__state  /*0x040003CA*/
    IL_000d: ret

  .method BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::System.IDisposable.Dispose()  // token 0x0600030C rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::MoveNext()  // token 0x0600030D rva 0xd5e4 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 147 (0x93), max stack 4, init locals
    .locals ([0] int, [1] BuildSlot, [2] int, [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::<>1__state  /*0x040003CA*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld BuildSlot BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::<>4__this  /*0x040003CC*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_002e
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::<>1__state  /*0x040003CA*/
    IL_001e: ldarg.0
    IL_001f: ldnull
    IL_0020: stfld object BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::<>2__current  /*0x040003CB*/
    IL_0025: ldarg.0
    IL_0026: ldc.i4.1
    IL_0027: stfld int BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::<>1__state  /*0x040003CA*/
    IL_002c: ldc.i4.1
    IL_002d: ret
    IL_002e: ldarg.0
    IL_002f: ldc.i4.m1
    IL_0030: stfld int BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::<>1__state  /*0x040003CA*/
    IL_0035: ldloc.1
    IL_0036: ldfld List<int> BuildSlot::appliedUpgrades  /*0x0400039D*/
    IL_003b: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0040: ldloc.1
    IL_0041: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0046: callvirt int System.Collections.Generic.List<BuildSlot.Upgrade>::get_Count()  /*0x0A000118*/
    IL_004b: call int System.Math::Min(int,int)  /*0x0A000140*/
    IL_0050: stloc.2
    IL_0051: ldc.i4.0
    IL_0052: stloc.3
    IL_0053: br.s IL_0082
    IL_0055: ldloc.1
    IL_0056: ldloc.1
    IL_0057: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_005c: ldloc.3
    IL_005d: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0062: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0067: ldloc.1
    IL_0068: ldfld List<int> BuildSlot::appliedUpgrades  /*0x0400039D*/
    IL_006d: ldloc.3
    IL_006e: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0073: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_0078: ldc.i4.1
    IL_0079: call void BuildSlot::ApplyLocalUpgradeChanges(BuildSlot.UpgradeBranch,bool)  /*0x060002FB*/
    IL_007e: ldloc.3
    IL_007f: ldc.i4.1
    IL_0080: add
    IL_0081: stloc.3
    IL_0082: ldloc.3
    IL_0083: ldloc.2
    IL_0084: blt.s IL_0055
    IL_0086: ldloc.1
    IL_0087: ldfld UnityEvent BuildSlot::OnAfterDelayedLoadFinished  /*0x0400039E*/
    IL_008c: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0091: ldc.i4.0
    IL_0092: ret

  .method BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600030E rva 0xd683 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::<>2__current  /*0x040003CB*/
    IL_0006: ret

  .method BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::System.Collections.IEnumerator.Reset()  // token 0x0600030F rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::System.Collections.IEnumerator.get_Current()  // token 0x06000310 rva 0xd683 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BuildSlot.<ApplyLoadedUpgradesDelayed>d__85::<>2__current  /*0x040003CB*/
    IL_0006: ret

// ===== BuildSlot/<GodOfChoiceHandling>d__109  (token 0x02000092) =====
  .method BuildSlot.<GodOfChoiceHandling>d__109::.ctor(int)  // token 0x06000311 rva 0xd68b attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int BuildSlot.<GodOfChoiceHandling>d__109::<>1__state  /*0x040003CD*/
    IL_000d: ret

  .method BuildSlot.<GodOfChoiceHandling>d__109::System.IDisposable.Dispose()  // token 0x06000312 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BuildSlot.<GodOfChoiceHandling>d__109::MoveNext()  // token 0x06000313 rva 0xd69c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 603 (0x25b), max stack 4, init locals
    .locals ([0] int, [1] BuildSlot, [2] List.Enumerator<BuildSlot.Upgrade>, [3] BuildSlot.Upgrade, [4] string, [5] int, [6] int, [7] int, [8] int, [9] List.Enumerator<BuildSlot.UpgradeBranch>, [10] int, [11] int, [12] int, [13] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int BuildSlot.<GodOfChoiceHandling>d__109::<>1__state  /*0x040003CD*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld BuildSlot BuildSlot.<GodOfChoiceHandling>d__109::<>4__this  /*0x040003CF*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_002e
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int BuildSlot.<GodOfChoiceHandling>d__109::<>1__state  /*0x040003CD*/
    IL_001e: ldarg.0
    IL_001f: ldnull
    IL_0020: stfld object BuildSlot.<GodOfChoiceHandling>d__109::<>2__current  /*0x040003CE*/
    IL_0025: ldarg.0
    IL_0026: ldc.i4.1
    IL_0027: stfld int BuildSlot.<GodOfChoiceHandling>d__109::<>1__state  /*0x040003CD*/
    IL_002c: ldc.i4.1
    IL_002d: ret
    IL_002e: ldarg.0
    IL_002f: ldc.i4.m1
    IL_0030: stfld int BuildSlot.<GodOfChoiceHandling>d__109::<>1__state  /*0x040003CD*/
    IL_0035: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_003a: ldnull
    IL_003b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0040: brfalse IL_0259
    IL_0045: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_004a: callvirt bool PerkManager::get_GodOfChoiceEquipped()  /*0x060009A1*/
    IL_004f: brfalse IL_0259
    IL_0054: ldloc.1
    IL_0055: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_005a: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot.Upgrade>::GetEnumerator()  /*0x0A000127*/
    IL_005f: stloc.2
    IL_0060: br IL_023d
    IL_0065: ldloca.s 2
    IL_0067: call !0 System.Collections.Generic.List.Enumerator<BuildSlot.Upgrade>::get_Current()  /*0x0A000128*/
    IL_006c: stloc.3
    IL_006d: ldloc.3
    IL_006e: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0073: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot.UpgradeBranch>::GetEnumerator()  /*0x0A000121*/
    IL_0078: stloc.s 9
    IL_007a: br.s IL_008e
    IL_007c: ldloca.s 9
    IL_007e: call !0 System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::get_Current()  /*0x0A000122*/
    IL_0083: ldfld Choice BuildSlot.UpgradeBranch::choiceDetails  /*0x040003BF*/
    IL_0088: ldc.i4.0
    IL_0089: stfld bool Choice::disabledInThisMode  /*0x04000B91*/
    IL_008e: ldloca.s 9
    IL_0090: call bool System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::MoveNext()  /*0x0A000125*/
    IL_0095: brtrue.s IL_007c
    IL_0097: leave.s IL_00a7
    IL_0099: ldloca.s 9
    IL_009b: constrained. System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>  /*0x1B000022*/
    IL_00a1: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00a6: endfinally
    IL_00a7: ldloc.1
    IL_00a8: call !!0 UnityEngine.Component::GetComponent()<SaveLoadEntity>  /*0x2B000026*/
    IL_00ad: callvirt string SaveLoadEntity::get_GUID()  /*0x06000D09*/
    IL_00b2: stloc.s 4
    IL_00b4: ldloc.s 4
    IL_00b6: call bool System.String::IsNullOrEmpty(string)  /*0x0A000141*/
    IL_00bb: brfalse.s IL_00de
    IL_00bd: ldstr "GUID is null or empty for upgrade: "
    IL_00c2: ldloc.3
    IL_00c3: dup
    IL_00c4: brtrue.s IL_00ca
    IL_00c6: pop
    IL_00c7: ldnull
    IL_00c8: br.s IL_00cf
    IL_00ca: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_00cf: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00d4: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_00d9: br IL_023d
    IL_00de: ldloc.3
    IL_00df: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_00e4: callvirt int System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Count()  /*0x0A00011E*/
    IL_00e9: stloc.s 5
    IL_00eb: ldloc.s 5
    IL_00ed: conv.r4
    IL_00ee: ldc.r4 2f
    IL_00f3: div
    IL_00f4: call int UnityEngine.Mathf::FloorToInt(float)  /*0x0A000144*/
    IL_00f9: stloc.s 6
    IL_00fb: ldc.i4.0
    IL_00fc: stloc.s 7
    IL_00fe: ldc.i4.0
    IL_00ff: stloc.s 10
    IL_0101: br.s IL_0155
    IL_0103: ldloc.s 4
    IL_0105: ldloc.s 10
    IL_0107: ldloc.s 4
    IL_0109: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_010e: rem
    IL_010f: callvirt char System.String::get_Chars(int)  /*0x0A000146*/
    IL_0114: ldc.i4.2
    IL_0115: rem
    IL_0116: brtrue.s IL_014f
    IL_0118: ldloc.3
    IL_0119: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_011e: ldloc.s 10
    IL_0120: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_0125: ldfld Choice BuildSlot.UpgradeBranch::choiceDetails  /*0x040003BF*/
    IL_012a: ldfld bool Choice::disabledInThisMode  /*0x04000B91*/
    IL_012f: brtrue.s IL_014f
    IL_0131: ldloc.3
    IL_0132: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_0137: ldloc.s 10
    IL_0139: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_013e: ldfld Choice BuildSlot.UpgradeBranch::choiceDetails  /*0x040003BF*/
    IL_0143: ldc.i4.1
    IL_0144: stfld bool Choice::disabledInThisMode  /*0x04000B91*/
    IL_0149: ldloc.s 7
    IL_014b: ldc.i4.1
    IL_014c: add
    IL_014d: stloc.s 7
    IL_014f: ldloc.s 10
    IL_0151: ldc.i4.1
    IL_0152: add
    IL_0153: stloc.s 10
    IL_0155: ldloc.s 10
    IL_0157: ldloc.s 5
    IL_0159: bge.s IL_0161
    IL_015b: ldloc.s 7
    IL_015d: ldloc.s 6
    IL_015f: blt.s IL_0103
    IL_0161: ldloc.s 7
    IL_0163: ldloc.s 6
    IL_0165: bge IL_01ed
    IL_016a: ldloc.s 4
    IL_016c: ldsfld Func<char, int> BuildSlot.<>c::<>9__109_1  /*0x040003C7*/
    IL_0171: dup
    IL_0172: brtrue.s IL_018b
    IL_0174: pop
    IL_0175: ldsfld BuildSlot.<>c BuildSlot.<>c::<>9  /*0x040003C6*/
    IL_017a: ldftn int BuildSlot.<>c::<GodOfChoiceHandling>b__109_1(char)  /*0x06000307*/
    IL_0180: newobj void System.Func<char, int>::.ctor(object,IntPtr)  /*0x0A000147*/
    IL_0185: dup
    IL_0186: stsfld Func<char, int> BuildSlot.<>c::<>9__109_1  /*0x040003C7*/
    IL_018b: call int System.Linq.Enumerable::Sum(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, int>)<char>  /*0x2B000027*/
    IL_0190: ldloc.s 5
    IL_0192: rem
    IL_0193: stloc.s 11
    IL_0195: ldc.i4.0
    IL_0196: stloc.s 12
    IL_0198: br.s IL_01e1
    IL_019a: ldloc.s 11
    IL_019c: ldloc.s 12
    IL_019e: add
    IL_019f: ldloc.s 5
    IL_01a1: rem
    IL_01a2: stloc.s 13
    IL_01a4: ldloc.3
    IL_01a5: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_01aa: ldloc.s 13
    IL_01ac: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_01b1: ldfld Choice BuildSlot.UpgradeBranch::choiceDetails  /*0x040003BF*/
    IL_01b6: ldfld bool Choice::disabledInThisMode  /*0x04000B91*/
    IL_01bb: brtrue.s IL_01db
    IL_01bd: ldloc.3
    IL_01be: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_01c3: ldloc.s 13
    IL_01c5: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_01ca: ldfld Choice BuildSlot.UpgradeBranch::choiceDetails  /*0x040003BF*/
    IL_01cf: ldc.i4.1
    IL_01d0: stfld bool Choice::disabledInThisMode  /*0x04000B91*/
    IL_01d5: ldloc.s 7
    IL_01d7: ldc.i4.1
    IL_01d8: add
    IL_01d9: stloc.s 7
    IL_01db: ldloc.s 12
    IL_01dd: ldc.i4.1
    IL_01de: add
    IL_01df: stloc.s 12
    IL_01e1: ldloc.s 12
    IL_01e3: ldloc.s 5
    IL_01e5: bge.s IL_01ed
    IL_01e7: ldloc.s 7
    IL_01e9: ldloc.s 6
    IL_01eb: blt.s IL_019a
    IL_01ed: ldloc.3
    IL_01ee: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_01f3: ldsfld Func<BuildSlot.UpgradeBranch, bool> BuildSlot.<>c::<>9__109_0  /*0x040003C8*/
    IL_01f8: dup
    IL_01f9: brtrue.s IL_0212
    IL_01fb: pop
    IL_01fc: ldsfld BuildSlot.<>c BuildSlot.<>c::<>9  /*0x040003C6*/
    IL_0201: ldftn bool BuildSlot.<>c::<GodOfChoiceHandling>b__109_0(BuildSlot.UpgradeBranch)  /*0x06000308*/
    IL_0207: newobj void System.Func<BuildSlot.UpgradeBranch, bool>::.ctor(object,IntPtr)  /*0x0A000149*/
    IL_020c: dup
    IL_020d: stsfld Func<BuildSlot.UpgradeBranch, bool> BuildSlot.<>c::<>9__109_0  /*0x040003C8*/
    IL_0212: call int System.Linq.Enumerable::Count(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, bool>)<BuildSlot.UpgradeBranch>  /*0x2B000028*/
    IL_0217: stloc.s 8
    IL_0219: ldloc.s 8
    IL_021b: ldloc.s 6
    IL_021d: beq.s IL_023d
    IL_021f: ldstr "Mismatch in disabled branches for upgrade {0}. Expected: {1}, Actual: {2}"
    IL_0224: ldloc.3
    IL_0225: ldloc.s 6
    IL_0227: box System.Int32  /*0x01000026*/
    IL_022c: ldloc.s 8
    IL_022e: box System.Int32  /*0x01000026*/
    IL_0233: call string System.String::Format(string,object,object,object)  /*0x0A00014B*/
    IL_0238: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_023d: ldloca.s 2
    IL_023f: call bool System.Collections.Generic.List.Enumerator<BuildSlot.Upgrade>::MoveNext()  /*0x0A00012C*/
    IL_0244: brtrue IL_0065
    IL_0249: leave.s IL_0259
    IL_024b: ldloca.s 2
    IL_024d: constrained. System.Collections.Generic.List.Enumerator<BuildSlot.Upgrade>  /*0x1B000023*/
    IL_0253: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0258: endfinally
    IL_0259: ldc.i4.0
    IL_025a: ret
    .try IL_007a-IL_0099 finally handler IL_0099-IL_00a7
    .try IL_0060-IL_024b finally handler IL_024b-IL_0259

  .method BuildSlot.<GodOfChoiceHandling>d__109::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000314 rva 0xd938 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BuildSlot.<GodOfChoiceHandling>d__109::<>2__current  /*0x040003CE*/
    IL_0006: ret

  .method BuildSlot.<GodOfChoiceHandling>d__109::System.Collections.IEnumerator.Reset()  // token 0x06000315 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method BuildSlot.<GodOfChoiceHandling>d__109::System.Collections.IEnumerator.get_Current()  // token 0x06000316 rva 0xd938 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BuildSlot.<GodOfChoiceHandling>d__109::<>2__current  /*0x040003CE*/
    IL_0006: ret

