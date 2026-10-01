// ===== MineShaft  (token 0x020001F6) =====
  .method MineShaft::get_MyBuildSlot()  // token 0x06000A5D rva 0x30ec4 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot MineShaft::myBuildSlot  /*0x04000D2D*/
    IL_0006: ret

  .method MineShaft::SetCooldown(float)  // token 0x06000A5E rva 0x30ecc attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float MineShaft::cooldown  /*0x04000D2E*/
    IL_0007: ret

  .method MineShaft::Initialize()  // token 0x06000A5F rva 0x30ed5 attrs Private, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool MineShaft::initialized  /*0x04000D31*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: call !!0 UnityEngine.Component::GetComponent()<BuildSlot>  /*0x2B00001A*/
    IL_0010: stfld BuildSlot MineShaft::myBuildSlot  /*0x04000D2D*/
    IL_0015: ldarg.0
    IL_0016: ldfld BuildSlot MineShaft::myBuildSlot  /*0x04000D2D*/
    IL_001b: callvirt BuildingInteractor BuildSlot::get_Interactor()  /*0x060002D6*/
    IL_0020: callvirt List<IncomeModifyer> BuildingInteractor::get_IncomeModifiers()  /*0x06000BA1*/
    IL_0025: ldarg.0
    IL_0026: callvirt void System.Collections.Generic.List<IncomeModifyer>::Add(!0)  /*0x0A000363*/
    IL_002b: ldarg.0
    IL_002c: ldc.i4.1
    IL_002d: stfld bool MineShaft::initialized  /*0x04000D31*/
    IL_0032: ret

  .method MineShaft::Start()  // token 0x06000A60 rva 0x30f0c attrs Private, HideBySig
    // code size 121 (0x79), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: call PlayerManager PlayerManager::get_Instance()  /*0x06000C14*/
    IL_0006: stfld PlayerManager MineShaft::playerManager  /*0x04000D25*/
    IL_000b: ldarg.0
    IL_000c: ldfld bool MineShaft::initialized  /*0x04000D31*/
    IL_0011: brtrue.s IL_0019
    IL_0013: ldarg.0
    IL_0014: call void MineShaft::Initialize()  /*0x06000A5F*/
    IL_0019: ldarg.0
    IL_001a: ldarg.0
    IL_001b: ldfld float MineShaft::playerEnterTimerMax  /*0x04000D29*/
    IL_0020: stfld float MineShaft::playerEnterTimer  /*0x04000D2B*/
    IL_0025: ldsfld List<MineShaft> MineShaft::allMineShafts  /*0x04000D2C*/
    IL_002a: ldarg.0
    IL_002b: callvirt bool System.Collections.Generic.List<MineShaft>::Contains(!0)  /*0x0A000485*/
    IL_0030: brtrue.s IL_003d
    IL_0032: ldsfld List<MineShaft> MineShaft::allMineShafts  /*0x04000D2C*/
    IL_0037: ldarg.0
    IL_0038: callvirt void System.Collections.Generic.List<MineShaft>::Add(!0)  /*0x0A000486*/
    IL_003d: ldsfld List<MineShaft> MineShaft::allMineShafts  /*0x04000D2C*/
    IL_0042: callvirt int System.Collections.Generic.List<MineShaft>::get_Count()  /*0x0A000487*/
    IL_0047: ldc.i4.1
    IL_0048: sub
    IL_0049: stloc.0
    IL_004a: br.s IL_006e
    IL_004c: ldsfld List<MineShaft> MineShaft::allMineShafts  /*0x04000D2C*/
    IL_0051: ldloc.0
    IL_0052: callvirt !0 System.Collections.Generic.List<MineShaft>::get_Item(int)  /*0x0A000488*/
    IL_0057: ldnull
    IL_0058: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_005d: brfalse.s IL_006a
    IL_005f: ldsfld List<MineShaft> MineShaft::allMineShafts  /*0x04000D2C*/
    IL_0064: ldloc.0
    IL_0065: callvirt void System.Collections.Generic.List<MineShaft>::RemoveAt(int)  /*0x0A000489*/
    IL_006a: ldloc.0
    IL_006b: ldc.i4.1
    IL_006c: sub
    IL_006d: stloc.0
    IL_006e: ldloc.0
    IL_006f: ldc.i4.0
    IL_0070: bge.s IL_004c
    IL_0072: ldarg.0
    IL_0073: call void MineShaft::SortAllMineShafts()  /*0x06000A61*/
    IL_0078: ret

  .method MineShaft::SortAllMineShafts()  // token 0x06000A61 rva 0x30f91 attrs Private, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldsfld List<MineShaft> MineShaft::allMineShafts  /*0x04000D2C*/
    IL_0005: ldsfld Comparison<MineShaft> MineShaft.<>c::<>9__23_0  /*0x04000D33*/
    IL_000a: dup
    IL_000b: brtrue.s IL_0024
    IL_000d: pop
    IL_000e: ldsfld MineShaft.<>c MineShaft.<>c::<>9  /*0x04000D32*/
    IL_0013: ldftn int MineShaft.<>c::<SortAllMineShafts>b__23_0(MineShaft,MineShaft)  /*0x06000A71*/
    IL_0019: newobj void System.Comparison<MineShaft>::.ctor(object,IntPtr)  /*0x0A00048A*/
    IL_001e: dup
    IL_001f: stsfld Comparison<MineShaft> MineShaft.<>c::<>9__23_0  /*0x04000D33*/
    IL_0024: callvirt void System.Collections.Generic.List<MineShaft>::Sort(System.Comparison<!0>)  /*0x0A00048B*/
    IL_0029: ret

  .method MineShaft::FindNextMineShaftAfter(int)  // token 0x06000A62 rva 0x30fbc attrs Public, Static, HideBySig
    // code size 96 (0x60), max stack 2, init locals
    .locals ([0] int, [1] MineShaft)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: add
    IL_0003: ldsfld List<MineShaft> MineShaft::allMineShafts  /*0x04000D2C*/
    IL_0008: callvirt int System.Collections.Generic.List<MineShaft>::get_Count()  /*0x0A000487*/
    IL_000d: rem
    IL_000e: stloc.0
    IL_000f: br.s IL_005a
    IL_0011: ldsfld List<MineShaft> MineShaft::allMineShafts  /*0x04000D2C*/
    IL_0016: ldloc.0
    IL_0017: callvirt !0 System.Collections.Generic.List<MineShaft>::get_Item(int)  /*0x0A000488*/
    IL_001c: stloc.1
    IL_001d: ldloc.1
    IL_001e: callvirt BuildSlot MineShaft::get_MyBuildSlot()  /*0x06000A5D*/
    IL_0023: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0028: ldc.i4.0
    IL_0029: ble.s IL_004b
    IL_002b: ldloc.1
    IL_002c: ldfld BuildingInteractor IncomeModifyer::buildingInteractor  /*0x04000A57*/
    IL_0031: ldfld Hp BuildingInteractor::buildingHP  /*0x04000E8A*/
    IL_0036: callvirt TaggedObject Hp::get_TaggedObj()  /*0x06000816*/
    IL_003b: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0040: ldc.i4.s 10
    IL_0042: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0047: brfalse.s IL_004b
    IL_0049: ldloc.1
    IL_004a: ret
    IL_004b: ldloc.0
    IL_004c: ldc.i4.1
    IL_004d: add
    IL_004e: ldsfld List<MineShaft> MineShaft::allMineShafts  /*0x04000D2C*/
    IL_0053: callvirt int System.Collections.Generic.List<MineShaft>::get_Count()  /*0x0A000487*/
    IL_0058: rem
    IL_0059: stloc.0
    IL_005a: ldloc.0
    IL_005b: ldarg.0
    IL_005c: bne.un.s IL_0011
    IL_005e: ldnull
    IL_005f: ret

  .method MineShaft::Update()  // token 0x06000A63 rva 0x31028 attrs Private, HideBySig
    // code size 415 (0x19f), max stack 5, init locals
    .locals ([0] bool, [1] PlayerMovement[], [2] int, [3] PlayerMovement, [4] Vector3, [5] Matrix4x4, [6] MineShaft, [7] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float MineShaft::cooldown  /*0x04000D2E*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float MineShaft::cooldown  /*0x04000D2E*/
    IL_0012: ldarg.0
    IL_0013: call BuildSlot MineShaft::get_MyBuildSlot()  /*0x06000A5D*/
    IL_0018: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_001d: ldc.i4.0
    IL_001e: ble.s IL_003e
    IL_0020: ldarg.0
    IL_0021: ldfld BuildingInteractor IncomeModifyer::buildingInteractor  /*0x04000A57*/
    IL_0026: ldfld Hp BuildingInteractor::buildingHP  /*0x04000E8A*/
    IL_002b: callvirt TaggedObject Hp::get_TaggedObj()  /*0x06000816*/
    IL_0030: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0035: ldc.i4.s 10
    IL_0037: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_003c: brtrue.s IL_003f
    IL_003e: ret
    IL_003f: ldarg.0
    IL_0040: ldfld float MineShaft::cooldown  /*0x04000D2E*/
    IL_0045: ldc.r4 0f
    IL_004a: ble.un.s IL_004d
    IL_004c: ret
    IL_004d: ldc.i4.0
    IL_004e: stloc.0
    IL_004f: ldarg.0
    IL_0050: ldfld PlayerManager MineShaft::playerManager  /*0x04000D25*/
    IL_0055: callvirt PlayerMovement[] PlayerManager::get_RegisteredPlayers()  /*0x06000C15*/
    IL_005a: stloc.1
    IL_005b: ldc.i4.0
    IL_005c: stloc.2
    IL_005d: br IL_0186
    IL_0062: ldloc.1
    IL_0063: ldloc.2
    IL_0064: ldelem.ref
    IL_0065: stloc.3
    IL_0066: ldarg.0
    IL_0067: ldfld Transform MineShaft::mineEntrance  /*0x04000D26*/
    IL_006c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0071: ldloc.3
    IL_0072: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0077: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_007c: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0081: stloc.s 4
    IL_0083: ldloca.s 4
    IL_0085: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_008a: ldarg.0
    IL_008b: ldfld float MineShaft::mineEnterDistance  /*0x04000D27*/
    IL_0090: bge.un IL_0182
    IL_0095: ldarg.0
    IL_0096: ldfld Transform MineShaft::mineEntrance  /*0x04000D26*/
    IL_009b: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_00a0: stloc.s 5
    IL_00a2: ldloca.s 5
    IL_00a4: ldc.r4 0f
    IL_00a9: ldc.r4 0f
    IL_00ae: ldc.r4 1f
    IL_00b3: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_00b8: call Vector3 UnityEngine.Matrix4x4::MultiplyVector(UnityEngine.Vector3)  /*0x0A0000A7*/
    IL_00bd: stloc.s 4
    IL_00bf: ldloca.s 4
    IL_00c1: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_00c6: ldloc.3
    IL_00c7: callvirt Vector3 PlayerMovement::get_Velocity()  /*0x06000C26*/
    IL_00cc: stloc.s 4
    IL_00ce: ldloca.s 4
    IL_00d0: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_00d5: call float UnityEngine.Vector3::Dot(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0001A1*/
    IL_00da: ldarg.0
    IL_00db: ldfld float MineShaft::mineEnterAngleDotProd  /*0x04000D28*/
    IL_00e0: ble.un IL_0182
    IL_00e5: ldarg.0
    IL_00e6: ldarg.0
    IL_00e7: ldfld float MineShaft::playerEnterTimer  /*0x04000D2B*/
    IL_00ec: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00f1: sub
    IL_00f2: stfld float MineShaft::playerEnterTimer  /*0x04000D2B*/
    IL_00f7: ldc.i4.1
    IL_00f8: stloc.0
    IL_00f9: ldarg.0
    IL_00fa: ldfld float MineShaft::playerEnterTimer  /*0x04000D2B*/
    IL_00ff: ldc.r4 0f
    IL_0104: bgt.un.s IL_0182
    IL_0106: ldsfld List<MineShaft> MineShaft::allMineShafts  /*0x04000D2C*/
    IL_010b: ldarg.0
    IL_010c: callvirt int System.Collections.Generic.List<MineShaft>::IndexOf(!0)  /*0x0A00048C*/
    IL_0111: call MineShaft MineShaft::FindNextMineShaftAfter(int)  /*0x06000A62*/
    IL_0116: stloc.s 6
    IL_0118: ldloc.s 6
    IL_011a: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_011f: brfalse.s IL_0182
    IL_0121: ldloc.s 6
    IL_0123: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0128: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_012d: stloc.s 7
    IL_012f: ldloc.s 7
    IL_0131: ldloc.s 6
    IL_0133: ldfld Transform MineShaft::mineEntrance  /*0x04000D26*/
    IL_0138: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_013d: stloc.s 5
    IL_013f: ldloca.s 5
    IL_0141: ldc.r4 0f
    IL_0146: ldc.r4 0f
    IL_014b: ldc.r4 -1f
    IL_0150: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0155: call Vector3 UnityEngine.Matrix4x4::MultiplyVector(UnityEngine.Vector3)  /*0x0A0000A7*/
    IL_015a: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_015f: stloc.s 7
    IL_0161: ldloc.3
    IL_0162: ldloc.s 7
    IL_0164: callvirt void PlayerMovement::TeleportTo(UnityEngine.Vector3)  /*0x06000C22*/
    IL_0169: ldloc.s 6
    IL_016b: ldarg.0
    IL_016c: ldfld float MineShaft::cooldownAfterTeleport  /*0x04000D2A*/
    IL_0171: callvirt void MineShaft::SetCooldown(float)  /*0x06000A5E*/
    IL_0176: ldarg.0
    IL_0177: ldarg.0
    IL_0178: ldfld float MineShaft::cooldownAfterTeleport  /*0x04000D2A*/
    IL_017d: call void MineShaft::SetCooldown(float)  /*0x06000A5E*/
    IL_0182: ldloc.2
    IL_0183: ldc.i4.1
    IL_0184: add
    IL_0185: stloc.2
    IL_0186: ldloc.2
    IL_0187: ldloc.1
    IL_0188: ldlen
    IL_0189: conv.i4
    IL_018a: blt IL_0062
    IL_018f: ldloc.0
    IL_0190: brtrue.s IL_019e
    IL_0192: ldarg.0
    IL_0193: ldarg.0
    IL_0194: ldfld float MineShaft::playerEnterTimerMax  /*0x04000D29*/
    IL_0199: stfld float MineShaft::playerEnterTimer  /*0x04000D2B*/
    IL_019e: ret

  .method MineShaft::OnDawn()  // token 0x06000A64 rva 0x311d3 attrs Public, Virtual, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void MineShaft::DecreaseIncome()  /*0x06000A65*/
    IL_0006: ret

  .method MineShaft::DecreaseIncome()  // token 0x06000A65 rva 0x311dc attrs Private, HideBySig
    // code size 94 (0x5e), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot MineShaft::myBuildSlot  /*0x04000D2D*/
    IL_0006: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_000b: ldc.i4.0
    IL_000c: bgt.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld BuildingInteractor IncomeModifyer::buildingInteractor  /*0x04000A57*/
    IL_0015: callvirt bool BuildingInteractor::get_KnockedOutTonight()  /*0x06000BA2*/
    IL_001a: brfalse.s IL_0049
    IL_001c: ldarg.0
    IL_001d: ldfld Equippable MineShaft::sustainableMiningPerk  /*0x04000D22*/
    IL_0022: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0027: brfalse.s IL_0048
    IL_0029: ldarg.0
    IL_002a: ldc.i4.0
    IL_002b: stfld int MineShaft::currentIncomeDecreaseLevel  /*0x04000D30*/
    IL_0030: ldarg.0
    IL_0031: ldc.i4.0
    IL_0032: stfld int MineShaft::loadedIncomeDecreaseLevel  /*0x04000D2F*/
    IL_0037: ldarg.0
    IL_0038: ldfld BuildSlot MineShaft::myBuildSlot  /*0x04000D2D*/
    IL_003d: ldarg.0
    IL_003e: ldfld int MineShaft::resetIncomeSustainableMining  /*0x04000D24*/
    IL_0043: callvirt void BuildSlot::set_GoldIncome(int)  /*0x060002DB*/
    IL_0048: ret
    IL_0049: ldarg.0
    IL_004a: ldarg.0
    IL_004b: ldfld int MineShaft::currentIncomeDecreaseLevel  /*0x04000D30*/
    IL_0050: ldc.i4.1
    IL_0051: add
    IL_0052: stfld int MineShaft::currentIncomeDecreaseLevel  /*0x04000D30*/
    IL_0057: ldarg.0
    IL_0058: call void MineShaft::SetIncome()  /*0x06000A67*/
    IL_005d: ret

  .method MineShaft::ForceDecreaseIncome()  // token 0x06000A66 rva 0x31246 attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int MineShaft::currentIncomeDecreaseLevel  /*0x04000D30*/
    IL_0007: ldc.i4.1
    IL_0008: add
    IL_0009: stfld int MineShaft::currentIncomeDecreaseLevel  /*0x04000D30*/
    IL_000e: ldarg.0
    IL_000f: call void MineShaft::SetIncome()  /*0x06000A67*/
    IL_0014: ret

  .method MineShaft::SetIncome()  // token 0x06000A67 rva 0x3125c attrs Private, HideBySig
    // code size 95 (0x5f), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable MineShaft::sustainableMiningPerk  /*0x04000D22*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brfalse.s IL_0036
    IL_000d: ldarg.0
    IL_000e: ldfld BuildSlot MineShaft::myBuildSlot  /*0x04000D2D*/
    IL_0013: ldarg.0
    IL_0014: ldfld BuildSlot MineShaft::myBuildSlot  /*0x04000D2D*/
    IL_0019: callvirt int BuildSlot::get_GoldIncome()  /*0x060002DA*/
    IL_001e: ldarg.0
    IL_001f: ldfld int MineShaft::incomeReductionPerTurn  /*0x04000D20*/
    IL_0024: sub
    IL_0025: ldarg.0
    IL_0026: ldfld int MineShaft::minimumIncomeWithSustainableMining  /*0x04000D23*/
    IL_002b: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_0030: callvirt void BuildSlot::set_GoldIncome(int)  /*0x060002DB*/
    IL_0035: ret
    IL_0036: ldarg.0
    IL_0037: ldfld BuildSlot MineShaft::myBuildSlot  /*0x04000D2D*/
    IL_003c: ldarg.0
    IL_003d: ldfld BuildSlot MineShaft::myBuildSlot  /*0x04000D2D*/
    IL_0042: callvirt int BuildSlot::get_GoldIncome()  /*0x060002DA*/
    IL_0047: ldarg.0
    IL_0048: ldfld int MineShaft::incomeReductionPerTurn  /*0x04000D20*/
    IL_004d: sub
    IL_004e: ldarg.0
    IL_004f: ldfld int MineShaft::minimumIncome  /*0x04000D21*/
    IL_0054: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_0059: callvirt void BuildSlot::set_GoldIncome(int)  /*0x060002DB*/
    IL_005e: ret

  .method MineShaft::OnBeforeMainLoadPass(string)  // token 0x06000A68 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method MineShaft::OnAfterMainLoadPass(string)  // token 0x06000A69 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method MineShaft::OnLoad(string)  // token 0x06000A6A rva 0x312c8 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 68 (0x44), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool MineShaft::initialized  /*0x04000D31*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void MineShaft::Initialize()  /*0x06000A5F*/
    IL_000e: ldarg.0
    IL_000f: ldc.i4.0
    IL_0010: stfld int MineShaft::loadedIncomeDecreaseLevel  /*0x04000D2F*/
    IL_0015: ldarg.1
    IL_0016: ldstr "currentIncomeDecreaseLevel"
    IL_001b: ldarg.0
    IL_001c: ldflda int MineShaft::loadedIncomeDecreaseLevel  /*0x04000D2F*/
    IL_0021: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_0026: pop
    IL_0027: ldarg.0
    IL_0028: ldfld BuildSlot MineShaft::myBuildSlot  /*0x04000D2D*/
    IL_002d: ldfld UnityEvent BuildSlot::OnAfterDelayedLoadFinished  /*0x0400039E*/
    IL_0032: ldarg.0
    IL_0033: ldftn void MineShaft::ExecuteDelayedLoad()  /*0x06000A6B*/
    IL_0039: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_003e: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0043: ret

  .method MineShaft::ExecuteDelayedLoad()  // token 0x06000A6B rva 0x31318 attrs Private, HideBySig
    // code size 38 (0x26), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld bool MineShaft::initialized  /*0x04000D31*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void MineShaft::Initialize()  /*0x06000A5F*/
    IL_000e: ldc.i4.0
    IL_000f: stloc.0
    IL_0010: br.s IL_001c
    IL_0012: ldarg.0
    IL_0013: call void MineShaft::ForceDecreaseIncome()  /*0x06000A66*/
    IL_0018: ldloc.0
    IL_0019: ldc.i4.1
    IL_001a: add
    IL_001b: stloc.0
    IL_001c: ldloc.0
    IL_001d: ldarg.0
    IL_001e: ldfld int MineShaft::loadedIncomeDecreaseLevel  /*0x04000D2F*/
    IL_0023: blt.s IL_0012
    IL_0025: ret

  .method MineShaft::OnSave(string)  // token 0x06000A6C rva 0x3134a attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldstr "currentIncomeDecreaseLevel"
    IL_0006: ldarg.0
    IL_0007: ldfld int MineShaft::currentIncomeDecreaseLevel  /*0x04000D30*/
    IL_000c: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_0011: ret

  .method MineShaft::.ctor()  // token 0x06000A6D rva 0x31360 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 79 (0x4f), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld int MineShaft::incomeReductionPerTurn  /*0x04000D20*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: stfld int MineShaft::minimumIncome  /*0x04000D21*/
    IL_000e: ldarg.0
    IL_000f: ldc.i4.3
    IL_0010: stfld int MineShaft::minimumIncomeWithSustainableMining  /*0x04000D23*/
    IL_0015: ldarg.0
    IL_0016: ldc.i4.6
    IL_0017: stfld int MineShaft::resetIncomeSustainableMining  /*0x04000D24*/
    IL_001c: ldarg.0
    IL_001d: ldc.r4 3f
    IL_0022: stfld float MineShaft::mineEnterDistance  /*0x04000D27*/
    IL_0027: ldarg.0
    IL_0028: ldc.r4 0.8f
    IL_002d: stfld float MineShaft::mineEnterAngleDotProd  /*0x04000D28*/
    IL_0032: ldarg.0
    IL_0033: ldc.r4 0.75f
    IL_0038: stfld float MineShaft::playerEnterTimerMax  /*0x04000D29*/
    IL_003d: ldarg.0
    IL_003e: ldc.r4 1f
    IL_0043: stfld float MineShaft::cooldownAfterTeleport  /*0x04000D2A*/
    IL_0048: ldarg.0
    IL_0049: call void IncomeModifyer::.ctor()  /*0x0600083B*/
    IL_004e: ret

  .method MineShaft::.cctor()  // token 0x06000A6E rva 0x313bb attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void System.Collections.Generic.List<MineShaft>::.ctor()  /*0x0A00048D*/
    IL_0005: stsfld List<MineShaft> MineShaft::allMineShafts  /*0x04000D2C*/
    IL_000a: ret

// ===== MineShaft/<>c  (token 0x020001F7) =====
  .method MineShaft.<>c::.cctor()  // token 0x06000A6F rva 0x313c7 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void MineShaft.<>c::.ctor()  /*0x06000A70*/
    IL_0005: stsfld MineShaft.<>c MineShaft.<>c::<>9  /*0x04000D32*/
    IL_000a: ret

  .method MineShaft.<>c::.ctor()  // token 0x06000A70 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method MineShaft.<>c::<SortAllMineShafts>b__23_0(MineShaft,MineShaft)  // token 0x06000A71 rva 0x313d4 attrs Assembly, HideBySig
    // code size 101 (0x65), max stack 2, init locals
    .locals ([0] Vector3, [1] Vector3, [2] int, [3] int)
    IL_0000: ldarg.1
    IL_0001: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_000b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0010: stloc.0
    IL_0011: ldarg.2
    IL_0012: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0017: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_001c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0021: stloc.1
    IL_0022: ldloca.s 0
    IL_0024: ldflda float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0029: ldloc.1
    IL_002a: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_002f: call int System.Single::CompareTo(float)  /*0x0A000276*/
    IL_0034: stloc.2
    IL_0035: ldloc.2
    IL_0036: brfalse.s IL_003a
    IL_0038: ldloc.2
    IL_0039: ret
    IL_003a: ldloca.s 0
    IL_003c: ldflda float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0041: ldloc.1
    IL_0042: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0047: call int System.Single::CompareTo(float)  /*0x0A000276*/
    IL_004c: stloc.3
    IL_004d: ldloc.3
    IL_004e: brfalse.s IL_0052
    IL_0050: ldloc.3
    IL_0051: ret
    IL_0052: ldloca.s 0
    IL_0054: ldflda float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0059: ldloc.1
    IL_005a: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_005f: call int System.Single::CompareTo(float)  /*0x0A000276*/
    IL_0064: ret

