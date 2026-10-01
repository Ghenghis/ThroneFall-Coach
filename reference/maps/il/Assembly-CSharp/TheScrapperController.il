// ===== TheScrapperController  (token 0x020000EA) =====
  .method TheScrapperController::Start()  // token 0x060004FC rva 0x15a0c attrs Private, HideBySig
    // code size 397 (0x18d), max stack 5, init locals
    IL_0000: ldsfld UnityEvent TheScrapperAnimatorHandler::OnSwitchPhase  /*0x0400065C*/
    IL_0005: ldarg.0
    IL_0006: ldftn void TheScrapperController::ActivateCurrentPhase()  /*0x06000500*/
    IL_000c: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0011: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0016: ldarg.0
    IL_0017: ldfld Transform TheScrapperController::healthbar  /*0x0400066E*/
    IL_001c: ldnull
    IL_001d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0022: brfalse.s IL_002f
    IL_0024: ldstr "The Scrapper Controller requires healthbar transform to be assigned"
    IL_0029: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_002e: ret
    IL_002f: ldarg.0
    IL_0030: ldfld Transform TheScrapperController::dmgIndicator  /*0x0400066F*/
    IL_0035: ldnull
    IL_0036: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_003b: brfalse.s IL_0048
    IL_003d: ldstr "The Scrapper Controller requires damage indicator transform to be assigned"
    IL_0042: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0047: ret
    IL_0048: ldarg.0
    IL_0049: ldfld TheScrapperAutoAttack TheScrapperController::attack  /*0x04000670*/
    IL_004e: ldnull
    IL_004f: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0054: brfalse.s IL_0061
    IL_0056: ldstr "The Scrapper Controller requires attack to be assigned"
    IL_005b: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0060: ret
    IL_0061: ldarg.0
    IL_0062: ldfld Hp TheScrapperController::hp  /*0x04000671*/
    IL_0067: ldnull
    IL_0068: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_006d: brfalse.s IL_007a
    IL_006f: ldstr "The Scrapper Controller requires hp to be assigned"
    IL_0074: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0079: ret
    IL_007a: ldarg.0
    IL_007b: ldfld PathfindMovementEnemy TheScrapperController::pathfind  /*0x04000672*/
    IL_0080: ldnull
    IL_0081: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0086: brfalse.s IL_0093
    IL_0088: ldstr "The Scrapper Controller requires pathfind to be assigned"
    IL_008d: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0092: ret
    IL_0093: ldarg.0
    IL_0094: ldfld JumpBehaviour TheScrapperController::jumpBehaviour  /*0x04000674*/
    IL_0099: ldnull
    IL_009a: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_009f: brfalse.s IL_00ac
    IL_00a1: ldstr "The Scrapper Controller requires jumpBehaviour to be assigned"
    IL_00a6: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_00ab: ret
    IL_00ac: ldarg.0
    IL_00ad: ldfld MapJumpEntries TheScrapperController::jumpEntries  /*0x04000675*/
    IL_00b2: ldnull
    IL_00b3: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00b8: brfalse.s IL_00c4
    IL_00ba: ldstr "The Scrapper Controller may not use jumpEntries - in this case spawn point will be returned for each NextJumpPosition"
    IL_00bf: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_00c4: ldarg.0
    IL_00c5: call bool TheScrapperController::CalculateAccumulatedPhasesChanges()  /*0x060004FD*/
    IL_00ca: brtrue.s IL_00cd
    IL_00cc: ret
    IL_00cd: ldarg.0
    IL_00ce: ldarg.0
    IL_00cf: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00d4: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00d9: stfld Vector3 TheScrapperController::spawnPoint  /*0x04000676*/
    IL_00de: ldarg.0
    IL_00df: ldarg.0
    IL_00e0: ldfld Hp TheScrapperController::hp  /*0x04000671*/
    IL_00e5: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_00ea: stfld float TheScrapperController::prevHpValue  /*0x04000680*/
    IL_00ef: ldarg.0
    IL_00f0: ldfld Hp TheScrapperController::hp  /*0x04000671*/
    IL_00f5: ldfld UnityEvent Hp::OnHpChange  /*0x04000A3A*/
    IL_00fa: ldarg.0
    IL_00fb: ldftn void TheScrapperController::HpChangedCallback()  /*0x06000506*/
    IL_0101: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0106: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_010b: ldarg.0
    IL_010c: ldarg.0
    IL_010d: ldfld Hp TheScrapperController::hp  /*0x04000671*/
    IL_0112: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0117: stfld float TheScrapperController::defaultHpMax  /*0x0400067A*/
    IL_011c: ldarg.0
    IL_011d: ldarg.0
    IL_011e: ldfld PathfindMovementEnemy TheScrapperController::pathfind  /*0x04000672*/
    IL_0123: ldfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_0128: stfld float TheScrapperController::defaultMovementSpeed  /*0x0400067B*/
    IL_012d: ldarg.0
    IL_012e: ldc.r4 1f
    IL_0133: ldarg.0
    IL_0134: ldfld TheScrapperAutoAttack TheScrapperController::attack  /*0x04000670*/
    IL_0139: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_013e: ldc.r4 1E-07f
    IL_0143: ldc.r4 10000000f
    IL_0148: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_014d: div
    IL_014e: stfld float TheScrapperController::defaultAttackSpeed  /*0x0400067C*/
    IL_0153: ldarg.0
    IL_0154: ldarg.0
    IL_0155: ldfld Transform TheScrapperController::healthbar  /*0x0400066E*/
    IL_015a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_015f: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0164: stfld float TheScrapperController::healthbarDefaultPositionY  /*0x04000678*/
    IL_0169: ldarg.0
    IL_016a: ldarg.0
    IL_016b: ldfld Transform TheScrapperController::dmgIndicator  /*0x0400066F*/
    IL_0170: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0175: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_017a: stfld float TheScrapperController::dmgIndicatorDefaultPositionY  /*0x04000679*/
    IL_017f: ldarg.0
    IL_0180: ldc.i4.1
    IL_0181: stfld bool TheScrapperController::inited  /*0x04000681*/
    IL_0186: ldarg.0
    IL_0187: call void TheScrapperController::ActivateCurrentPhase()  /*0x06000500*/
    IL_018c: ret

  .method TheScrapperController::CalculateAccumulatedPhasesChanges()  // token 0x060004FD rva 0x15ba8 attrs Private, HideBySig
    // code size 280 (0x118), max stack 3, init locals
    .locals ([0] float, [1] float, [2] float, [3] int)
    IL_0000: ldc.r4 0f
    IL_0005: stloc.0
    IL_0006: ldc.r4 0f
    IL_000b: stloc.1
    IL_000c: ldc.r4 0f
    IL_0011: stloc.2
    IL_0012: ldc.i4.0
    IL_0013: stloc.3
    IL_0014: br IL_0105
    IL_0019: ldarg.0
    IL_001a: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_001f: ldloc.3
    IL_0020: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_0025: callvirt bool TheScrapperPhase::get_IsValid()  /*0x0600050B*/
    IL_002a: brtrue.s IL_0043
    IL_002c: ldstr "The Scrapper Phase {0} requires visuals and data assigned"
    IL_0031: ldloc.3
    IL_0032: box System.Int32  /*0x01000026*/
    IL_0037: call string System.String::Format(string,object)  /*0x0A00021A*/
    IL_003c: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0041: ldc.i4.0
    IL_0042: ret
    IL_0043: ldarg.0
    IL_0044: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_0049: ldloc.3
    IL_004a: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_004f: ldfld TheScrapperPhaseData TheScrapperPhase::data  /*0x0400068D*/
    IL_0054: callvirt bool TheScrapperPhaseData::get_IsValid()  /*0x06000511*/
    IL_0059: brtrue.s IL_0072
    IL_005b: ldstr "The Scrapper Phase {0} data requires weapon assigned"
    IL_0060: ldloc.3
    IL_0061: box System.Int32  /*0x01000026*/
    IL_0066: call string System.String::Format(string,object)  /*0x0A00021A*/
    IL_006b: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0070: ldc.i4.0
    IL_0071: ret
    IL_0072: ldloc.2
    IL_0073: ldarg.0
    IL_0074: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_0079: ldloc.3
    IL_007a: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_007f: ldfld TheScrapperPhaseData TheScrapperPhase::data  /*0x0400068D*/
    IL_0084: ldfld float TheScrapperPhaseData::hpGrowthAddition  /*0x04000693*/
    IL_0089: add
    IL_008a: stloc.2
    IL_008b: ldarg.0
    IL_008c: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_0091: ldloc.3
    IL_0092: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_0097: ldloc.2
    IL_0098: stfld float TheScrapperPhase::accumulatedHpGrowthAddition  /*0x0400068E*/
    IL_009d: ldloc.0
    IL_009e: ldarg.0
    IL_009f: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_00a4: ldloc.3
    IL_00a5: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_00aa: ldfld TheScrapperPhaseData TheScrapperPhase::data  /*0x0400068D*/
    IL_00af: ldfld float TheScrapperPhaseData::movementSpeedReductionRate  /*0x04000694*/
    IL_00b4: add
    IL_00b5: stloc.0
    IL_00b6: ldloc.0
    IL_00b7: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_00bc: stloc.0
    IL_00bd: ldarg.0
    IL_00be: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_00c3: ldloc.3
    IL_00c4: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_00c9: ldloc.0
    IL_00ca: stfld float TheScrapperPhase::accumulatedMovementSpeedReductionRate  /*0x0400068F*/
    IL_00cf: ldloc.1
    IL_00d0: ldarg.0
    IL_00d1: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_00d6: ldloc.3
    IL_00d7: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_00dc: ldfld TheScrapperPhaseData TheScrapperPhase::data  /*0x0400068D*/
    IL_00e1: ldfld float TheScrapperPhaseData::attackSpeedReductionRate  /*0x04000695*/
    IL_00e6: add
    IL_00e7: stloc.1
    IL_00e8: ldloc.1
    IL_00e9: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_00ee: stloc.1
    IL_00ef: ldarg.0
    IL_00f0: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_00f5: ldloc.3
    IL_00f6: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_00fb: ldloc.1
    IL_00fc: stfld float TheScrapperPhase::accumulatedAttackSpeedReductionRate  /*0x04000690*/
    IL_0101: ldloc.3
    IL_0102: ldc.i4.1
    IL_0103: add
    IL_0104: stloc.3
    IL_0105: ldloc.3
    IL_0106: ldarg.0
    IL_0107: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_010c: callvirt int System.Collections.Generic.List<TheScrapperPhase>::get_Count()  /*0x0A00021B*/
    IL_0111: blt IL_0019
    IL_0116: ldc.i4.1
    IL_0117: ret

  .method TheScrapperController::DeactivatePhaseVisualsExceptCurrent()  // token 0x060004FE rva 0x15ccc attrs Private, HideBySig
    // code size 114 (0x72), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_0035
    IL_0004: ldloc.0
    IL_0005: ldarg.0
    IL_0006: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_000b: beq.s IL_0031
    IL_000d: ldarg.0
    IL_000e: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_0013: ldloc.0
    IL_0014: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_0019: callvirt bool TheScrapperPhase::get_IsActive()  /*0x0600050C*/
    IL_001e: brfalse.s IL_0031
    IL_0020: ldarg.0
    IL_0021: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_0026: ldloc.0
    IL_0027: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_002c: callvirt void TheScrapperPhase::DeactivateVisuals()  /*0x0600050F*/
    IL_0031: ldloc.0
    IL_0032: ldc.i4.1
    IL_0033: add
    IL_0034: stloc.0
    IL_0035: ldloc.0
    IL_0036: ldarg.0
    IL_0037: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_003c: callvirt int System.Collections.Generic.List<TheScrapperPhase>::get_Count()  /*0x0A00021B*/
    IL_0041: blt.s IL_0004
    IL_0043: ldarg.0
    IL_0044: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_0049: ldarg.0
    IL_004a: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_004f: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_0054: callvirt bool TheScrapperPhase::get_IsActive()  /*0x0600050C*/
    IL_0059: brtrue.s IL_0071
    IL_005b: ldarg.0
    IL_005c: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_0061: ldarg.0
    IL_0062: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_0067: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_006c: callvirt void TheScrapperPhase::ActivateVisuals()  /*0x0600050E*/
    IL_0071: ret

  .method TheScrapperController::HealScrapper(float)  // token 0x060004FF rva 0x15d4c attrs Private, HideBySig
    // code size 58 (0x3a), max stack 3, init locals
    .locals ([0] float)
    IL_0000: ldarg.1
    IL_0001: ldc.r4 0f
    IL_0006: ble.un.s IL_0039
    IL_0008: ldarg.0
    IL_0009: ldfld Hp TheScrapperController::hp  /*0x04000671*/
    IL_000e: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0013: ldarg.1
    IL_0014: add
    IL_0015: stloc.0
    IL_0016: ldloc.0
    IL_0017: ldc.r4 0f
    IL_001c: ldarg.0
    IL_001d: ldfld Hp TheScrapperController::hp  /*0x04000671*/
    IL_0022: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0027: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_002c: stloc.0
    IL_002d: ldarg.0
    IL_002e: ldfld Hp TheScrapperController::hp  /*0x04000671*/
    IL_0033: ldloc.0
    IL_0034: callvirt void Hp::SetHpTo(float)  /*0x0600082F*/
    IL_0039: ret

  .method TheScrapperController::ActivateCurrentPhase()  // token 0x06000500 rva 0x15d94 attrs Public, HideBySig
    // code size 463 (0x1cf), max stack 5, init locals
    .locals ([0] float, [1] float)
    IL_0000: ldarg.0
    IL_0001: ldfld bool TheScrapperController::inited  /*0x04000681*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_000f: ldc.i4.0
    IL_0010: blt IL_01ce
    IL_0015: ldarg.0
    IL_0016: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_001b: ldarg.0
    IL_001c: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_0021: callvirt int System.Collections.Generic.List<TheScrapperPhase>::get_Count()  /*0x0A00021B*/
    IL_0026: bge IL_01ce
    IL_002b: ldarg.0
    IL_002c: call void TheScrapperController::DeactivatePhaseVisualsExceptCurrent()  /*0x060004FE*/
    IL_0031: ldarg.0
    IL_0032: ldfld Transform TheScrapperController::healthbar  /*0x0400066E*/
    IL_0037: ldarg.0
    IL_0038: ldfld Transform TheScrapperController::healthbar  /*0x0400066E*/
    IL_003d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0042: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0047: ldarg.0
    IL_0048: ldfld float TheScrapperController::healthbarDefaultPositionY  /*0x04000678*/
    IL_004d: ldarg.0
    IL_004e: ldfld float TheScrapperController::verticalOffsetStep  /*0x04000677*/
    IL_0053: ldarg.0
    IL_0054: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_0059: conv.r4
    IL_005a: mul
    IL_005b: add
    IL_005c: ldarg.0
    IL_005d: ldfld Transform TheScrapperController::healthbar  /*0x0400066E*/
    IL_0062: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0067: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_006c: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0071: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0076: ldarg.0
    IL_0077: ldfld Transform TheScrapperController::dmgIndicator  /*0x0400066F*/
    IL_007c: ldarg.0
    IL_007d: ldfld Transform TheScrapperController::dmgIndicator  /*0x0400066F*/
    IL_0082: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0087: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_008c: ldarg.0
    IL_008d: ldfld float TheScrapperController::dmgIndicatorDefaultPositionY  /*0x04000679*/
    IL_0092: ldarg.0
    IL_0093: ldfld float TheScrapperController::verticalOffsetStep  /*0x04000677*/
    IL_0098: ldarg.0
    IL_0099: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_009e: conv.r4
    IL_009f: mul
    IL_00a0: add
    IL_00a1: ldarg.0
    IL_00a2: ldfld Transform TheScrapperController::dmgIndicator  /*0x0400066F*/
    IL_00a7: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00ac: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_00b1: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_00b6: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_00bb: ldarg.0
    IL_00bc: ldfld TheScrapperAutoAttack TheScrapperController::attack  /*0x04000670*/
    IL_00c1: ldarg.0
    IL_00c2: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_00c7: ldarg.0
    IL_00c8: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_00cd: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_00d2: ldfld TheScrapperPhaseData TheScrapperPhase::data  /*0x0400068D*/
    IL_00d7: ldfld Weapon TheScrapperPhaseData::weapon  /*0x04000692*/
    IL_00dc: stfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_00e1: ldarg.0
    IL_00e2: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_00e7: ldarg.0
    IL_00e8: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_00ed: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_00f2: ldfld float TheScrapperPhase::accumulatedHpGrowthAddition  /*0x0400068E*/
    IL_00f7: stloc.0
    IL_00f8: ldarg.0
    IL_00f9: ldfld Hp TheScrapperController::hp  /*0x04000671*/
    IL_00fe: ldarg.0
    IL_00ff: ldfld float TheScrapperController::defaultHpMax  /*0x0400067A*/
    IL_0104: ldloc.0
    IL_0105: add
    IL_0106: stfld float Hp::maxHp  /*0x04000A2C*/
    IL_010b: ldarg.0
    IL_010c: ldloc.0
    IL_010d: call void TheScrapperController::HealScrapper(float)  /*0x060004FF*/
    IL_0112: ldarg.0
    IL_0113: ldfld PathfindMovementEnemy TheScrapperController::pathfind  /*0x04000672*/
    IL_0118: ldarg.0
    IL_0119: ldfld float TheScrapperController::defaultMovementSpeed  /*0x0400067B*/
    IL_011e: ldc.r4 1f
    IL_0123: ldarg.0
    IL_0124: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_0129: ldarg.0
    IL_012a: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_012f: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_0134: ldfld float TheScrapperPhase::accumulatedMovementSpeedReductionRate  /*0x0400068F*/
    IL_0139: sub
    IL_013a: mul
    IL_013b: stfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_0140: ldarg.0
    IL_0141: ldfld float TheScrapperController::defaultAttackSpeed  /*0x0400067C*/
    IL_0146: ldc.r4 1f
    IL_014b: ldarg.0
    IL_014c: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_0151: ldarg.0
    IL_0152: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_0157: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_015c: ldfld float TheScrapperPhase::accumulatedAttackSpeedReductionRate  /*0x04000690*/
    IL_0161: sub
    IL_0162: mul
    IL_0163: stloc.1
    IL_0164: ldarg.0
    IL_0165: ldfld TheScrapperAutoAttack TheScrapperController::attack  /*0x04000670*/
    IL_016a: ldc.r4 1f
    IL_016f: ldloc.1
    IL_0170: ldc.r4 1E-07f
    IL_0175: ldc.r4 10000000f
    IL_017a: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_017f: div
    IL_0180: stfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_0185: ldarg.0
    IL_0186: ldfld TheScrapperAutoAttack TheScrapperController::attack  /*0x04000670*/
    IL_018b: ldarg.0
    IL_018c: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_0191: ldarg.0
    IL_0192: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_0197: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_019c: ldfld List<TheScrapperAttackOrigin> TheScrapperPhase::attackOrigins  /*0x0400068C*/
    IL_01a1: stfld List<TheScrapperAttackOrigin> TheScrapperAutoAttack::attackOrigins  /*0x04000667*/
    IL_01a6: ldarg.0
    IL_01a7: ldfld TheScrapperAutoAttack TheScrapperController::attack  /*0x04000670*/
    IL_01ac: callvirt void TheScrapperAutoAttack::SetRandomAttackOrigin()  /*0x060004F7*/
    IL_01b1: ldarg.0
    IL_01b2: call void TheScrapperController::UntrackAllUnits()  /*0x06000503*/
    IL_01b7: ldarg.0
    IL_01b8: ldfld TheScrapperAutoAttack TheScrapperController::attack  /*0x04000670*/
    IL_01bd: ldarg.0
    IL_01be: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01c3: callvirt void TheScrapperAutoAttack::Explode(UnityEngine.Transform)  /*0x060004F9*/
    IL_01c8: ldarg.0
    IL_01c9: call void TheScrapperController::DetectUnitsInRadius()  /*0x06000505*/
    IL_01ce: ret

  .method TheScrapperController::TrackUnit(TaggedObject)  // token 0x06000501 rva 0x15f6f attrs Private, HideBySig
    // code size 57 (0x39), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld HashSet<TaggedObject> TheScrapperController::trackedUnits  /*0x0400067D*/
    IL_0006: ldarg.1
    IL_0007: callvirt bool System.Collections.Generic.HashSet<TaggedObject>::Contains(!0)  /*0x0A0001EF*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld HashSet<TaggedObject> TheScrapperController::trackedUnits  /*0x0400067D*/
    IL_0015: ldarg.1
    IL_0016: callvirt bool System.Collections.Generic.HashSet<TaggedObject>::Add(!0)  /*0x0A0001F0*/
    IL_001b: pop
    IL_001c: ldarg.1
    IL_001d: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0022: ldfld UnityEvent<TaggedObject> Hp::OnKillOrKnockoutDetailed  /*0x04000A40*/
    IL_0027: ldarg.0
    IL_0028: ldftn void TheScrapperController::OnTrackedUnitDied(TaggedObject)  /*0x06000504*/
    IL_002e: newobj void UnityEngine.Events.UnityAction<TaggedObject>::.ctor(object,IntPtr)  /*0x0A0001D8*/
    IL_0033: callvirt void UnityEngine.Events.UnityEvent<TaggedObject>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A0001D9*/
    IL_0038: ret

  .method TheScrapperController::UntrackUnit(TaggedObject)  // token 0x06000502 rva 0x15fa9 attrs Private, HideBySig
    // code size 57 (0x39), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld HashSet<TaggedObject> TheScrapperController::trackedUnits  /*0x0400067D*/
    IL_0006: ldarg.1
    IL_0007: callvirt bool System.Collections.Generic.HashSet<TaggedObject>::Contains(!0)  /*0x0A0001EF*/
    IL_000c: brtrue.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.1
    IL_0010: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0015: ldfld UnityEvent<TaggedObject> Hp::OnKillOrKnockoutDetailed  /*0x04000A40*/
    IL_001a: ldarg.0
    IL_001b: ldftn void TheScrapperController::OnTrackedUnitDied(TaggedObject)  /*0x06000504*/
    IL_0021: newobj void UnityEngine.Events.UnityAction<TaggedObject>::.ctor(object,IntPtr)  /*0x0A0001D8*/
    IL_0026: callvirt void UnityEngine.Events.UnityEvent<TaggedObject>::RemoveListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A0001F1*/
    IL_002b: ldarg.0
    IL_002c: ldfld HashSet<TaggedObject> TheScrapperController::trackedUnits  /*0x0400067D*/
    IL_0031: ldarg.1
    IL_0032: callvirt bool System.Collections.Generic.HashSet<TaggedObject>::Remove(!0)  /*0x0A0001F2*/
    IL_0037: pop
    IL_0038: ret

  .method TheScrapperController::UntrackAllUnits()  // token 0x06000503 rva 0x15fe4 attrs Private, HideBySig
    // code size 54 (0x36), max stack 3, init locals
    .locals ([0] List<TaggedObject>, [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld HashSet<TaggedObject> TheScrapperController::trackedUnits  /*0x0400067D*/
    IL_0006: newobj void System.Collections.Generic.List<TaggedObject>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A00021C*/
    IL_000b: stloc.0
    IL_000c: ldc.i4.0
    IL_000d: stloc.1
    IL_000e: br.s IL_0021
    IL_0010: ldarg.0
    IL_0011: ldloc.0
    IL_0012: ldloc.1
    IL_0013: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0018: call void TheScrapperController::UntrackUnit(TaggedObject)  /*0x06000502*/
    IL_001d: ldloc.1
    IL_001e: ldc.i4.1
    IL_001f: add
    IL_0020: stloc.1
    IL_0021: ldloc.1
    IL_0022: ldloc.0
    IL_0023: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0028: blt.s IL_0010
    IL_002a: ldarg.0
    IL_002b: ldfld HashSet<TaggedObject> TheScrapperController::trackedUnits  /*0x0400067D*/
    IL_0030: callvirt void System.Collections.Generic.HashSet<TaggedObject>::Clear()  /*0x0A0001EB*/
    IL_0035: ret

  .method TheScrapperController::OnTrackedUnitDied(TaggedObject)  // token 0x06000504 rva 0x16028 attrs Private, HideBySig
    // code size 343 (0x157), max stack 4, init locals
    .locals ([0] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void TheScrapperController::UntrackUnit(TaggedObject)  /*0x06000502*/
    IL_0007: ldarg.0
    IL_0008: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_000d: ldarg.0
    IL_000e: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_0013: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_0018: ldfld TheScrapperPhaseData TheScrapperPhase::data  /*0x0400068D*/
    IL_001d: ldfld float TheScrapperPhaseData::destroyedEnemiesDetectionRadius  /*0x04000696*/
    IL_0022: stloc.0
    IL_0023: ldarg.1
    IL_0024: ldarg.0
    IL_0025: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002f: callvirt float TaggedObject::GetSqrDistance(UnityEngine.Vector3)  /*0x06000E50*/
    IL_0034: ldloc.0
    IL_0035: ldloc.0
    IL_0036: mul
    IL_0037: ble.un.s IL_003a
    IL_0039: ret
    IL_003a: ldarg.0
    IL_003b: ldarg.0
    IL_003c: ldfld int TheScrapperController::destroyedEnemiesCount  /*0x0400067F*/
    IL_0041: ldc.i4.1
    IL_0042: add
    IL_0043: stfld int TheScrapperController::destroyedEnemiesCount  /*0x0400067F*/
    IL_0048: ldstr "[The Scrapper Controller] player unit '"
    IL_004d: ldarg.1
    IL_004e: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0053: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0058: ldstr "' died in radius"
    IL_005d: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0062: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_0067: ldarg.0
    IL_0068: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_006d: ldarg.0
    IL_006e: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_0073: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_0078: ldfld TheScrapperPhaseData TheScrapperPhase::data  /*0x0400068D*/
    IL_007d: ldfld float TheScrapperPhaseData::destroyedEnemiesHpUsageRate  /*0x04000697*/
    IL_0082: ldc.r4 0f
    IL_0087: ble.un.s IL_00b8
    IL_0089: ldarg.0
    IL_008a: ldarg.1
    IL_008b: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0090: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0095: ldarg.0
    IL_0096: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_009b: ldarg.0
    IL_009c: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_00a1: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_00a6: ldfld TheScrapperPhaseData TheScrapperPhase::data  /*0x0400068D*/
    IL_00ab: ldfld float TheScrapperPhaseData::destroyedEnemiesHpUsageRate  /*0x04000697*/
    IL_00b0: mul
    IL_00b1: call void TheScrapperController::HealScrapper(float)  /*0x060004FF*/
    IL_00b6: br.s IL_00d9
    IL_00b8: ldarg.0
    IL_00b9: ldarg.0
    IL_00ba: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_00bf: ldarg.0
    IL_00c0: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_00c5: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_00ca: ldfld TheScrapperPhaseData TheScrapperPhase::data  /*0x0400068D*/
    IL_00cf: ldfld float TheScrapperPhaseData::destroyedEnemiesHpRecoveryAmount  /*0x04000698*/
    IL_00d4: call void TheScrapperController::HealScrapper(float)  /*0x060004FF*/
    IL_00d9: ldarg.0
    IL_00da: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_00df: ldarg.0
    IL_00e0: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_00e5: callvirt int System.Collections.Generic.List<TheScrapperPhase>::get_Count()  /*0x0A00021B*/
    IL_00ea: ldc.i4.1
    IL_00eb: sub
    IL_00ec: clt
    IL_00ee: brfalse.s IL_0156
    IL_00f0: ldarg.0
    IL_00f1: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_00f6: ldarg.0
    IL_00f7: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_00fc: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_0101: ldfld TheScrapperPhaseData TheScrapperPhase::data  /*0x0400068D*/
    IL_0106: ldfld int TheScrapperPhaseData::destroyedEnemiesNextPhaseThreshold  /*0x04000699*/
    IL_010b: ldc.i4.0
    IL_010c: ble.s IL_0156
    IL_010e: ldarg.0
    IL_010f: ldfld int TheScrapperController::destroyedEnemiesCount  /*0x0400067F*/
    IL_0114: ldarg.0
    IL_0115: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_011a: ldarg.0
    IL_011b: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_0120: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_0125: ldfld TheScrapperPhaseData TheScrapperPhase::data  /*0x0400068D*/
    IL_012a: ldfld int TheScrapperPhaseData::destroyedEnemiesNextPhaseThreshold  /*0x04000699*/
    IL_012f: blt.s IL_0156
    IL_0131: ldarg.0
    IL_0132: ldc.i4.0
    IL_0133: stfld int TheScrapperController::destroyedEnemiesCount  /*0x0400067F*/
    IL_0138: ldarg.0
    IL_0139: ldarg.0
    IL_013a: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_013f: ldc.i4.1
    IL_0140: add
    IL_0141: stfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_0146: ldarg.0
    IL_0147: ldfld UnityEvent TheScrapperController::OnActivateCurrentPhase  /*0x04000682*/
    IL_014c: dup
    IL_014d: brtrue.s IL_0151
    IL_014f: pop
    IL_0150: ret
    IL_0151: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0156: ret

  .method TheScrapperController::DetectUnitsInRadius()  // token 0x06000505 rva 0x1618c attrs Private, HideBySig
    // code size 226 (0xe2), max stack 5, init locals
    .locals ([0] float, [1] List<TaggedObject>, [2] int, [3] HashSet.Enumerator<TaggedObject>, [4] TaggedObject, [5] int)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_0006: ldarg.0
    IL_0007: ldfld int TheScrapperController::currentPhase  /*0x0400066C*/
    IL_000c: callvirt !0 System.Collections.Generic.List<TheScrapperPhase>::get_Item(int)  /*0x0A000219*/
    IL_0011: ldfld TheScrapperPhaseData TheScrapperPhase::data  /*0x0400068D*/
    IL_0016: ldfld float TheScrapperPhaseData::destroyedEnemiesDetectionRadius  /*0x04000696*/
    IL_001b: stloc.0
    IL_001c: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0021: ldarg.0
    IL_0022: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0027: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002c: ldarg.0
    IL_002d: ldfld List<TagManager.ETag> TheScrapperController::playerOwnedObjects  /*0x04000683*/
    IL_0032: ldnull
    IL_0033: ldloc.0
    IL_0034: callvirt List<TaggedObject> TagManager::FindUnsortedTaggedObjectsInRange(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,float)  /*0x06000E60*/
    IL_0039: stloc.1
    IL_003a: ldc.i4.0
    IL_003b: stloc.2
    IL_003c: br.s IL_004f
    IL_003e: ldarg.0
    IL_003f: ldloc.1
    IL_0040: ldloc.2
    IL_0041: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0046: call void TheScrapperController::TrackUnit(TaggedObject)  /*0x06000501*/
    IL_004b: ldloc.2
    IL_004c: ldc.i4.1
    IL_004d: add
    IL_004e: stloc.2
    IL_004f: ldloc.2
    IL_0050: ldloc.1
    IL_0051: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0056: blt.s IL_003e
    IL_0058: ldarg.0
    IL_0059: ldfld List<TaggedObject> TheScrapperController::unitsToUntrack  /*0x04000684*/
    IL_005e: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_0063: ldarg.0
    IL_0064: ldfld HashSet<TaggedObject> TheScrapperController::trackedUnits  /*0x0400067D*/
    IL_0069: callvirt HashSet.Enumerator<!0> System.Collections.Generic.HashSet<TaggedObject>::GetEnumerator()  /*0x0A0001E8*/
    IL_006e: stloc.3
    IL_006f: br.s IL_009b
    IL_0071: ldloca.s 3
    IL_0073: call !0 System.Collections.Generic.HashSet.Enumerator<TaggedObject>::get_Current()  /*0x0A0001E9*/
    IL_0078: stloc.s 4
    IL_007a: ldloc.s 4
    IL_007c: ldnull
    IL_007d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0082: brtrue.s IL_008e
    IL_0084: ldloc.1
    IL_0085: ldloc.s 4
    IL_0087: callvirt bool System.Collections.Generic.List<TaggedObject>::Contains(!0)  /*0x0A00021D*/
    IL_008c: brtrue.s IL_009b
    IL_008e: ldarg.0
    IL_008f: ldfld List<TaggedObject> TheScrapperController::unitsToUntrack  /*0x04000684*/
    IL_0094: ldloc.s 4
    IL_0096: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_009b: ldloca.s 3
    IL_009d: call bool System.Collections.Generic.HashSet.Enumerator<TaggedObject>::MoveNext()  /*0x0A0001EA*/
    IL_00a2: brtrue.s IL_0071
    IL_00a4: leave.s IL_00b4
    IL_00a6: ldloca.s 3
    IL_00a8: constrained. System.Collections.Generic.HashSet.Enumerator<TaggedObject>  /*0x1B00004A*/
    IL_00ae: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00b3: endfinally
    IL_00b4: ldc.i4.0
    IL_00b5: stloc.s 5
    IL_00b7: br.s IL_00d2
    IL_00b9: ldarg.0
    IL_00ba: ldarg.0
    IL_00bb: ldfld List<TaggedObject> TheScrapperController::unitsToUntrack  /*0x04000684*/
    IL_00c0: ldloc.s 5
    IL_00c2: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_00c7: call void TheScrapperController::UntrackUnit(TaggedObject)  /*0x06000502*/
    IL_00cc: ldloc.s 5
    IL_00ce: ldc.i4.1
    IL_00cf: add
    IL_00d0: stloc.s 5
    IL_00d2: ldloc.s 5
    IL_00d4: ldarg.0
    IL_00d5: ldfld List<TaggedObject> TheScrapperController::unitsToUntrack  /*0x04000684*/
    IL_00da: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_00df: blt.s IL_00b9
    IL_00e1: ret
    .try IL_006f-IL_00a6 finally handler IL_00a6-IL_00b4

  .method TheScrapperController::HpChangedCallback()  // token 0x06000506 rva 0x1628c attrs Private, HideBySig
    // code size 120 (0x78), max stack 4, init locals
    .locals ([0] bool, [1] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld Hp TheScrapperController::hp  /*0x04000671*/
    IL_0006: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_000b: ldarg.0
    IL_000c: ldfld float TheScrapperController::prevHpValue  /*0x04000680*/
    IL_0011: bge.un.s IL_0066
    IL_0013: ldarg.0
    IL_0014: ldfld Hp TheScrapperController::hp  /*0x04000671*/
    IL_0019: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_001e: ldarg.0
    IL_001f: ldfld Hp TheScrapperController::hp  /*0x04000671*/
    IL_0024: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0029: ldc.r4 0.5f
    IL_002e: mul
    IL_002f: cgt.un
    IL_0031: ldc.i4.0
    IL_0032: ceq
    IL_0034: ldarg.0
    IL_0035: ldfld float TheScrapperController::prevHpValue  /*0x04000680*/
    IL_003a: ldarg.0
    IL_003b: ldfld Hp TheScrapperController::hp  /*0x04000671*/
    IL_0040: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0045: ldc.r4 0.5f
    IL_004a: mul
    IL_004b: cgt
    IL_004d: stloc.0
    IL_004e: ldloc.0
    IL_004f: and
    IL_0050: brfalse.s IL_0066
    IL_0052: ldarg.0
    IL_0053: call Vector3 TheScrapperController::NextJumpPosition()  /*0x06000507*/
    IL_0058: stloc.1
    IL_0059: ldarg.0
    IL_005a: ldfld JumpBehaviour TheScrapperController::jumpBehaviour  /*0x04000674*/
    IL_005f: ldloc.1
    IL_0060: ldc.i4.1
    IL_0061: callvirt void JumpBehaviour::RequestJump(UnityEngine.Vector3,bool)  /*0x060004A9*/
    IL_0066: ldarg.0
    IL_0067: ldarg.0
    IL_0068: ldfld Hp TheScrapperController::hp  /*0x04000671*/
    IL_006d: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0072: stfld float TheScrapperController::prevHpValue  /*0x04000680*/
    IL_0077: ret

  .method TheScrapperController::NextJumpPosition()  // token 0x06000507 rva 0x16310 attrs Private, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MapJumpEntries TheScrapperController::jumpEntries  /*0x04000675*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_001a
    IL_000e: ldarg.0
    IL_000f: ldfld MapJumpEntries TheScrapperController::jumpEntries  /*0x04000675*/
    IL_0014: callvirt Vector3 MapJumpEntries::NextJumpPoint()  /*0x0600055C*/
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldfld Vector3 TheScrapperController::spawnPoint  /*0x04000676*/
    IL_0020: ret

  .method TheScrapperController::Update()  // token 0x06000508 rva 0x16334 attrs Private, HideBySig
    // code size 66 (0x42), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool TheScrapperController::inited  /*0x04000681*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: ldfld float TheScrapperController::detectionTimer  /*0x0400067E*/
    IL_0010: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0015: sub
    IL_0016: stfld float TheScrapperController::detectionTimer  /*0x0400067E*/
    IL_001b: ldarg.0
    IL_001c: ldfld float TheScrapperController::detectionTimer  /*0x0400067E*/
    IL_0021: ldc.r4 0f
    IL_0026: bgt.un.s IL_0041
    IL_0028: ldarg.0
    IL_0029: ldarg.0
    IL_002a: ldfld float TheScrapperController::detectionTimer  /*0x0400067E*/
    IL_002f: ldarg.0
    IL_0030: ldfld float TheScrapperController::detectionCooldown  /*0x04000673*/
    IL_0035: add
    IL_0036: stfld float TheScrapperController::detectionTimer  /*0x0400067E*/
    IL_003b: ldarg.0
    IL_003c: call void TheScrapperController::DetectUnitsInRadius()  /*0x06000505*/
    IL_0041: ret

  .method TheScrapperController::.ctor()  // token 0x06000509 rva 0x16384 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 80 (0x50), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TheScrapperPhase>::.ctor()  /*0x0A00021E*/
    IL_0006: stfld List<TheScrapperPhase> TheScrapperController::phases  /*0x0400066D*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.5f
    IL_0011: stfld float TheScrapperController::detectionCooldown  /*0x04000673*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.54206264f
    IL_001c: stfld float TheScrapperController::verticalOffsetStep  /*0x04000677*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.HashSet<TaggedObject>::.ctor()  /*0x0A0001F3*/
    IL_0027: stfld HashSet<TaggedObject> TheScrapperController::trackedUnits  /*0x0400067D*/
    IL_002c: ldarg.0
    IL_002d: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0032: dup
    IL_0033: ldc.i4.0
    IL_0034: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0039: stfld List<TagManager.ETag> TheScrapperController::playerOwnedObjects  /*0x04000683*/
    IL_003e: ldarg.0
    IL_003f: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0044: stfld List<TaggedObject> TheScrapperController::unitsToUntrack  /*0x04000684*/
    IL_0049: ldarg.0
    IL_004a: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_004f: ret

