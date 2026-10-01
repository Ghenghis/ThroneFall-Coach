// ===== AutoAttackWithWarning  (token 0x02000072) =====
  .method AutoAttackWithWarning::Start()  // token 0x0600024E rva 0xa9c0 attrs Public, Virtual, HideBySig
    // code size 56 (0x38), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AutoAttack::Start()  /*0x06000233*/
    IL_0006: ldarg.0
    IL_0007: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_000c: stfld TagManager AutoAttackWithWarning::tagManager  /*0x04000328*/
    IL_0011: ldarg.0
    IL_0012: ldfld Line AutoAttackWithWarning::line  /*0x04000325*/
    IL_0017: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001c: ldnull
    IL_001d: callvirt void UnityEngine.Transform::SetParent(UnityEngine.Transform)  /*0x0A000065*/
    IL_0022: ldarg.0
    IL_0023: ldfld Line AutoAttackWithWarning::line  /*0x04000325*/
    IL_0028: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002d: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0032: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0037: ret

  .method AutoAttackWithWarning::Update()  // token 0x0600024F rva 0xa9f9 attrs Public, Virtual, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AutoAttackWithWarning::HandleTargeting()  /*0x06000250*/
    IL_0006: ldarg.0
    IL_0007: call void AutoAttack::Update()  /*0x06000234*/
    IL_000c: ret

  .method AutoAttackWithWarning::HandleTargeting()  // token 0x06000250 rva 0xaa08 attrs Private, HideBySig
    // code size 256 (0x100), max stack 4, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld TaggedObject AutoAttackWithWarning::targeting  /*0x04000326*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_0021
    IL_000d: ldarg.0
    IL_000e: ldnull
    IL_000f: stfld TaggedObject AutoAttackWithWarning::targeting  /*0x04000326*/
    IL_0014: ldarg.0
    IL_0015: ldfld Line AutoAttackWithWarning::line  /*0x04000325*/
    IL_001a: ldc.i4.0
    IL_001b: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0020: ret
    IL_0021: ldarg.0
    IL_0022: ldfld TaggedObject AutoAttackWithWarning::targeting  /*0x04000326*/
    IL_0027: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_002c: ldc.i4.s 10
    IL_002e: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0033: brtrue.s IL_0049
    IL_0035: ldarg.0
    IL_0036: ldnull
    IL_0037: stfld TaggedObject AutoAttackWithWarning::targeting  /*0x04000326*/
    IL_003c: ldarg.0
    IL_003d: ldfld Line AutoAttackWithWarning::line  /*0x04000325*/
    IL_0042: ldc.i4.0
    IL_0043: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0048: ret
    IL_0049: ldarg.0
    IL_004a: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_004f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0054: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0059: ldarg.0
    IL_005a: ldfld float AutoAttack::spawnAttackHeight  /*0x04000304*/
    IL_005f: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0064: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0069: stloc.0
    IL_006a: ldarg.0
    IL_006b: ldfld TagManager AutoAttackWithWarning::tagManager  /*0x04000328*/
    IL_0070: ldarg.0
    IL_0071: ldfld TaggedObject AutoAttackWithWarning::targeting  /*0x04000326*/
    IL_0076: ldloc.0
    IL_0077: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_007c: ldarg.0
    IL_007d: ldfld float AutoAttackWithWarning::breakTargetingDistance  /*0x04000327*/
    IL_0082: ble.un.s IL_0098
    IL_0084: ldarg.0
    IL_0085: ldnull
    IL_0086: stfld TaggedObject AutoAttackWithWarning::targeting  /*0x04000326*/
    IL_008b: ldarg.0
    IL_008c: ldfld Line AutoAttackWithWarning::line  /*0x04000325*/
    IL_0091: ldc.i4.0
    IL_0092: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0097: ret
    IL_0098: ldarg.0
    IL_0099: ldfld TaggedObject AutoAttackWithWarning::targeting  /*0x04000326*/
    IL_009e: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_00a3: ldc.i4.8
    IL_00a4: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_00a9: brfalse.s IL_00b8
    IL_00ab: ldarg.0
    IL_00ac: ldfld Line AutoAttackWithWarning::line  /*0x04000325*/
    IL_00b1: ldc.i4.0
    IL_00b2: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_00b7: ret
    IL_00b8: ldarg.0
    IL_00b9: ldfld Line AutoAttackWithWarning::line  /*0x04000325*/
    IL_00be: ldc.i4.1
    IL_00bf: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_00c4: ldarg.0
    IL_00c5: ldfld Line AutoAttackWithWarning::line  /*0x04000325*/
    IL_00ca: ldloc.0
    IL_00cb: callvirt void Shapes.Line::set_Start(UnityEngine.Vector3)  /*0x0A0000ED*/
    IL_00d0: ldarg.0
    IL_00d1: ldfld Line AutoAttackWithWarning::line  /*0x04000325*/
    IL_00d6: ldarg.0
    IL_00d7: ldfld TaggedObject AutoAttackWithWarning::targeting  /*0x04000326*/
    IL_00dc: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00e1: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00e6: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_00eb: ldc.r4 1f
    IL_00f0: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00f5: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00fa: callvirt void Shapes.Line::set_End(UnityEngine.Vector3)  /*0x0A0000EE*/
    IL_00ff: ret

  .method AutoAttackWithWarning::OnAttack(TaggedObject)  // token 0x06000251 rva 0xab14 attrs Public, Virtual, HideBySig
    // code size 168 (0xa8), max stack 7, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld TaggedObject AutoAttackWithWarning::targeting  /*0x04000326*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0027
    IL_000d: ldarg.1
    IL_000e: ldarg.0
    IL_000f: ldfld TaggedObject AutoAttackWithWarning::targeting  /*0x04000326*/
    IL_0014: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0019: brfalse.s IL_0027
    IL_001b: ldarg.0
    IL_001c: ldarg.0
    IL_001d: ldfld TaggedObject AutoAttackWithWarning::targeting  /*0x04000326*/
    IL_0022: callvirt void AutoAttack::OnAttack(TaggedObject)  /*0x06000235*/
    IL_0027: ldarg.1
    IL_0028: ldarg.0
    IL_0029: ldfld TaggedObject AutoAttackWithWarning::targeting  /*0x04000326*/
    IL_002e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0033: brfalse.s IL_003d
    IL_0035: ldarg.0
    IL_0036: ldarg.1
    IL_0037: stfld TaggedObject AutoAttackWithWarning::targeting  /*0x04000326*/
    IL_003c: ret
    IL_003d: ldarg.0
    IL_003e: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_0043: ldarg.0
    IL_0044: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0049: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_004e: ldarg.0
    IL_004f: ldfld float AutoAttack::spawnAttackHeight  /*0x04000304*/
    IL_0054: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0059: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_005e: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0063: ldarg.1
    IL_0064: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0069: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_006e: ldarg.0
    IL_006f: ldfld TaggedObject AutoAttack::taggedObject  /*0x04000305*/
    IL_0074: ldarg.0
    IL_0075: ldfld float AutoAttack::damageMultiplyer  /*0x04000309*/
    IL_007a: ldc.r4 1f
    IL_007f: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_0084: ldarg.0
    IL_0085: ldarg.1
    IL_0086: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_008b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0090: stfld Vector3 AutoAttack::lastTargetPosition  /*0x0400030C*/
    IL_0095: ldarg.0
    IL_0096: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_009b: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_00a0: ldarg.0
    IL_00a1: ldc.i4.1
    IL_00a2: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_00a7: ret

  .method AutoAttackWithWarning::OnDestroy()  // token 0x06000252 rva 0xabc8 attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Line AutoAttackWithWarning::line  /*0x04000325*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_001d
    IL_000d: ldarg.0
    IL_000e: ldfld Line AutoAttackWithWarning::line  /*0x04000325*/
    IL_0013: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0018: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_001d: ret

  .method AutoAttackWithWarning::.ctor()  // token 0x06000253 rva 0xabe7 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 10f
    IL_0006: stfld float AutoAttackWithWarning::breakTargetingDistance  /*0x04000327*/
    IL_000b: ldarg.0
    IL_000c: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0011: ret

