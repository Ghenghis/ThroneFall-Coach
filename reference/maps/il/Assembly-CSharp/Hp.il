// ===== Hp  (token 0x02000192) =====
  .method Hp::get_Elite()  // token 0x06000810 rva 0x27b6f attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool Hp::elite  /*0x04000A2E*/
    IL_0006: ret

  .method Hp::set_Elite(bool)  // token 0x06000811 rva 0x27b77 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool Hp::elite  /*0x04000A2E*/
    IL_0007: ret

  .method Hp::get_HpValue()  // token 0x06000812 rva 0x27b80 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float Hp::hp  /*0x04000A2F*/
    IL_0006: ret

  .method Hp::get_HpPercentage()  // token 0x06000813 rva 0x27b88 attrs Public, HideBySig, SpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float Hp::hp  /*0x04000A2F*/
    IL_0006: ldarg.0
    IL_0007: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_000c: div
    IL_000d: ret

  .method Hp::set_HpPercentage(float)  // token 0x06000814 rva 0x27b97 attrs Public, HideBySig, SpecialName
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0007: ldarg.1
    IL_0008: mul
    IL_0009: stfld float Hp::hp  /*0x04000A2F*/
    IL_000e: ret

  .method Hp::get_KnockedOut()  // token 0x06000815 rva 0x27ba7 attrs Public, HideBySig, SpecialName
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float Hp::hp  /*0x04000A2F*/
    IL_0006: ldc.r4 0f
    IL_000b: cgt.un
    IL_000d: ldc.i4.0
    IL_000e: ceq
    IL_0010: ret

  .method Hp::get_TaggedObj()  // token 0x06000816 rva 0x27bb9 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TaggedObject Hp::taggedObject  /*0x04000A31*/
    IL_0006: ret

  .method Hp::get_AutoAttacks()  // token 0x06000817 rva 0x27bc1 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttack[] Hp::autoAttacks  /*0x04000A41*/
    IL_0006: ret

  .method Hp::get_PathfindMovement()  // token 0x06000818 rva 0x27bc9 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld PathfindMovement Hp::pathfindMovement  /*0x04000A43*/
    IL_0006: ret

  .method Hp::get_SpwanAttackOnDeath()  // token 0x06000819 rva 0x27bd1 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Weapon Hp::spwanAttackOnDeath  /*0x04000A4C*/
    IL_0006: ret

  .method Hp::set_SpwanAttackOnDeath(Weapon)  // token 0x0600081A rva 0x27bd9 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Weapon Hp::spwanAttackOnDeath  /*0x04000A4C*/
    IL_0007: ret

  .method Hp::get_DamageMultiplyer()  // token 0x0600081B rva 0x27be2 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float Hp::damageMultiplyer  /*0x04000A4D*/
    IL_0006: ret

  .method Hp::set_DamageMultiplyer(float)  // token 0x0600081C rva 0x27bea attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float Hp::damageMultiplyer  /*0x04000A4D*/
    IL_0007: ret

  .method Hp::get_Alive()  // token 0x0600081D rva 0x27bf3 attrs Public, HideBySig, SpecialName
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float Hp::hp  /*0x04000A2F*/
    IL_0006: ldc.r4 0f
    IL_000b: clt.un
    IL_000d: ldc.i4.0
    IL_000e: ceq
    IL_0010: ret

  .method Hp::get_HpOriginal()  // token 0x0600081E rva 0x27c05 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float Hp::hpOritinal  /*0x04000A50*/
    IL_0006: ret

  .method Hp::set_HpOriginal(float)  // token 0x0600081F rva 0x27c0d attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float Hp::hpOritinal  /*0x04000A50*/
    IL_0007: ret

  .method Hp::OnBeforeMainLoadPass(string)  // token 0x06000820 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Hp::OnAfterMainLoadPass(string)  // token 0x06000821 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Hp::OnLoad(string)  // token 0x06000822 rva 0x27c18 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 46 (0x2e), max stack 4, init locals
    .locals ([0] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldarg.0
    IL_0003: ldarg.1
    IL_0004: ldarg.0
    IL_0005: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000a: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_000f: ldstr "_hp"
    IL_0014: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0019: ldloca.s 0
    IL_001b: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_0020: stfld bool Hp::gotLoadedHpValue  /*0x04000A30*/
    IL_0025: ldarg.0
    IL_0026: ldloc.0
    IL_0027: conv.r4
    IL_0028: stfld float Hp::hp  /*0x04000A2F*/
    IL_002d: ret

  .method Hp::OnSave(string)  // token 0x06000823 rva 0x27c52 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0007: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_000c: ldstr "_hp"
    IL_0011: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0016: ldarg.0
    IL_0017: ldfld float Hp::hp  /*0x04000A2F*/
    IL_001c: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0021: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_0026: ret

  .method Hp::ScaleHp(float)  // token 0x06000824 rva 0x27c7a attrs Public, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float Hp::hp  /*0x04000A2F*/
    IL_0007: ldarg.1
    IL_0008: mul
    IL_0009: stfld float Hp::hp  /*0x04000A2F*/
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0015: ldarg.1
    IL_0016: mul
    IL_0017: stfld float Hp::maxHp  /*0x04000A2C*/
    IL_001c: ret

  .method Hp::SetHpToMaxHp()  // token 0x06000825 rva 0x27c98 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0007: stfld float Hp::hp  /*0x04000A2F*/
    IL_000c: ret

  .method Hp::Initialize()  // token 0x06000826 rva 0x27ca8 attrs Private, HideBySig
    // code size 146 (0x92), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool Hp::initilaized  /*0x04000A51*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.i4.1
    IL_000b: stfld bool Hp::initilaized  /*0x04000A51*/
    IL_0010: ldarg.0
    IL_0011: ldarg.0
    IL_0012: call !!0 UnityEngine.Component::GetComponent()<PlayerInteraction>  /*0x2B00002E*/
    IL_0017: stfld PlayerInteraction Hp::playerInteraction  /*0x04000A47*/
    IL_001c: ldarg.0
    IL_001d: ldarg.0
    IL_001e: call !!0 UnityEngine.Component::GetComponent()<TaggedObject>  /*0x2B000005*/
    IL_0023: stfld TaggedObject Hp::taggedObject  /*0x04000A31*/
    IL_0028: ldarg.0
    IL_0029: ldarg.0
    IL_002a: call !!0[] UnityEngine.Component::GetComponents()<AutoAttack>  /*0x2B00008D*/
    IL_002f: stfld AutoAttack[] Hp::autoAttacks  /*0x04000A41*/
    IL_0034: ldarg.0
    IL_0035: ldarg.0
    IL_0036: call !!0[] UnityEngine.Component::GetComponents()<ManualAttack>  /*0x2B00008E*/
    IL_003b: stfld ManualAttack[] Hp::manualAttacks  /*0x04000A42*/
    IL_0040: ldarg.0
    IL_0041: ldarg.0
    IL_0042: call !!0 UnityEngine.Component::GetComponent()<PathfindMovement>  /*0x2B00008F*/
    IL_0047: stfld PathfindMovement Hp::pathfindMovement  /*0x04000A43*/
    IL_004c: ldarg.0
    IL_004d: ldarg.0
    IL_004e: call !!0 UnityEngine.Component::GetComponent()<Pathfinding.RVO.RVOController>  /*0x2B000090*/
    IL_0053: stfld RVOController Hp::rvoController  /*0x04000A44*/
    IL_0058: ldarg.0
    IL_0059: ldarg.0
    IL_005a: call !!0 UnityEngine.Component::GetComponent()<PlayerMovement>  /*0x2B00002D*/
    IL_005f: stfld PlayerMovement Hp::playerMovement  /*0x04000A45*/
    IL_0064: ldarg.0
    IL_0065: ldarg.0
    IL_0066: call !!0[] UnityEngine.Component::GetComponentsInChildren()<Pathfinding.NavmeshCut>  /*0x2B000091*/
    IL_006b: stfld NavmeshCut[] Hp::navmeshCut  /*0x04000A46*/
    IL_0070: ldarg.0
    IL_0071: ldarg.0
    IL_0072: call !!0 UnityEngine.Component::GetComponentInChildren()<UnitGroupIndicator>  /*0x2B000092*/
    IL_0077: stfld UnitGroupIndicator Hp::unitGroupIndicator  /*0x04000A48*/
    IL_007c: ldarg.0
    IL_007d: ldfld bool Hp::gotLoadedHpValue  /*0x04000A30*/
    IL_0082: brtrue.s IL_0091
    IL_0084: ldarg.0
    IL_0085: ldfld TaggedObject Hp::taggedObject  /*0x04000A31*/
    IL_008a: ldc.i4.s 10
    IL_008c: callvirt void TaggedObject::AddTag(TagManager.ETag)  /*0x06000E49*/
    IL_0091: ret

  .method Hp::Start()  // token 0x06000827 rva 0x27d48 attrs Private, HideBySig
    // code size 136 (0x88), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call void Hp::Initialize()  /*0x06000826*/
    IL_0006: ldarg.0
    IL_0007: ldfld bool Hp::gotLoadedHpValue  /*0x04000A30*/
    IL_000c: brtrue.s IL_001a
    IL_000e: ldarg.0
    IL_000f: ldc.i4.0
    IL_0010: ldc.r4 1f
    IL_0015: call void Hp::Revive(bool,float)  /*0x0600082A*/
    IL_001a: ldarg.0
    IL_001b: ldarg.0
    IL_001c: ldfld float Hp::hp  /*0x04000A2F*/
    IL_0021: ldc.r4 0f
    IL_0026: cgt
    IL_0028: call void Hp::ActivateAndDeactivateChildrenAndCompements(bool)  /*0x06000829*/
    IL_002d: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0032: callvirt bool PerkManager::get_HealingSpiritsActive()  /*0x06000982*/
    IL_0037: brfalse.s IL_0070
    IL_0039: ldarg.0
    IL_003a: ldfld TaggedObject Hp::taggedObject  /*0x04000A31*/
    IL_003f: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0044: brfalse.s IL_0070
    IL_0046: ldarg.0
    IL_0047: ldfld TaggedObject Hp::taggedObject  /*0x04000A31*/
    IL_004c: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0051: ldc.i4.0
    IL_0052: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0057: brfalse.s IL_0070
    IL_0059: ldarg.0
    IL_005a: ldarg.0
    IL_005b: ldfld float Hp::healingMultiplyer  /*0x04000A4E*/
    IL_0060: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0065: ldfld float PerkManager::healingSpirits_healMulti  /*0x04000C0C*/
    IL_006a: mul
    IL_006b: stfld float Hp::healingMultiplyer  /*0x04000A4E*/
    IL_0070: ldsfld Camera Hp::cameraMain  /*0x04000A52*/
    IL_0075: ldnull
    IL_0076: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_007b: brfalse.s IL_0087
    IL_007d: call Camera UnityEngine.Camera::get_main()  /*0x0A000107*/
    IL_0082: stsfld Camera Hp::cameraMain  /*0x04000A52*/
    IL_0087: ret

  .method Hp::OnScreen()  // token 0x06000828 rva 0x27ddc attrs Private, HideBySig
    // code size 79 (0x4f), max stack 2, init locals
    .locals ([0] Vector3)
    IL_0000: ldsfld Camera Hp::cameraMain  /*0x04000A52*/
    IL_0005: ldarg.0
    IL_0006: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0010: callvirt Vector3 UnityEngine.Camera::WorldToScreenPoint(UnityEngine.Vector3)  /*0x0A0003B6*/
    IL_0015: stloc.0
    IL_0016: ldloc.0
    IL_0017: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_001c: ldc.r4 0f
    IL_0021: ble.un.s IL_004d
    IL_0023: ldloc.0
    IL_0024: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0029: call int UnityEngine.Screen::get_width()  /*0x0A0003B7*/
    IL_002e: conv.r4
    IL_002f: bge.un.s IL_004d
    IL_0031: ldloc.0
    IL_0032: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0037: ldc.r4 0f
    IL_003c: ble.un.s IL_004d
    IL_003e: ldloc.0
    IL_003f: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0044: call int UnityEngine.Screen::get_height()  /*0x0A0003B8*/
    IL_0049: conv.r4
    IL_004a: clt
    IL_004c: ret
    IL_004d: ldc.i4.0
    IL_004e: ret

  .method Hp::ActivateAndDeactivateChildrenAndCompements(bool)  // token 0x06000829 rva 0x27e38 attrs Private, HideBySig
    // code size 310 (0x136), max stack 3, init locals
    .locals ([0] AutoAttack[], [1] int, [2] ManualAttack[], [3] NavmeshCut[])
    IL_0000: ldarg.0
    IL_0001: call void Hp::Initialize()  /*0x06000826*/
    IL_0006: ldarg.0
    IL_0007: ldfld GameObject Hp::aliveVisuals  /*0x04000A33*/
    IL_000c: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0011: brfalse.s IL_001f
    IL_0013: ldarg.0
    IL_0014: ldfld GameObject Hp::aliveVisuals  /*0x04000A33*/
    IL_0019: ldarg.1
    IL_001a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001f: ldarg.0
    IL_0020: ldfld GameObject Hp::knockedOutVisuals  /*0x04000A34*/
    IL_0025: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002a: brfalse.s IL_003b
    IL_002c: ldarg.0
    IL_002d: ldfld GameObject Hp::knockedOutVisuals  /*0x04000A34*/
    IL_0032: ldarg.1
    IL_0033: ldc.i4.0
    IL_0034: ceq
    IL_0036: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003b: ldarg.0
    IL_003c: ldfld AutoAttack[] Hp::autoAttacks  /*0x04000A41*/
    IL_0041: ldlen
    IL_0042: brfalse.s IL_0062
    IL_0044: ldarg.0
    IL_0045: ldfld AutoAttack[] Hp::autoAttacks  /*0x04000A41*/
    IL_004a: stloc.0
    IL_004b: ldc.i4.0
    IL_004c: stloc.1
    IL_004d: br.s IL_005c
    IL_004f: ldloc.0
    IL_0050: ldloc.1
    IL_0051: ldelem.ref
    IL_0052: ldarg.1
    IL_0053: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0058: ldloc.1
    IL_0059: ldc.i4.1
    IL_005a: add
    IL_005b: stloc.1
    IL_005c: ldloc.1
    IL_005d: ldloc.0
    IL_005e: ldlen
    IL_005f: conv.i4
    IL_0060: blt.s IL_004f
    IL_0062: ldarg.0
    IL_0063: ldfld ManualAttack[] Hp::manualAttacks  /*0x04000A42*/
    IL_0068: ldlen
    IL_0069: brfalse.s IL_0089
    IL_006b: ldarg.0
    IL_006c: ldfld ManualAttack[] Hp::manualAttacks  /*0x04000A42*/
    IL_0071: stloc.2
    IL_0072: ldc.i4.0
    IL_0073: stloc.1
    IL_0074: br.s IL_0083
    IL_0076: ldloc.2
    IL_0077: ldloc.1
    IL_0078: ldelem.ref
    IL_0079: ldarg.1
    IL_007a: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_007f: ldloc.1
    IL_0080: ldc.i4.1
    IL_0081: add
    IL_0082: stloc.1
    IL_0083: ldloc.1
    IL_0084: ldloc.2
    IL_0085: ldlen
    IL_0086: conv.i4
    IL_0087: blt.s IL_0076
    IL_0089: ldarg.0
    IL_008a: ldfld PathfindMovement Hp::pathfindMovement  /*0x04000A43*/
    IL_008f: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0094: brfalse.s IL_00b0
    IL_0096: ldarg.0
    IL_0097: ldfld PathfindMovement Hp::pathfindMovement  /*0x04000A43*/
    IL_009c: ldarg.1
    IL_009d: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_00a2: ldarg.1
    IL_00a3: brtrue.s IL_00b0
    IL_00a5: ldarg.0
    IL_00a6: ldfld PathfindMovement Hp::pathfindMovement  /*0x04000A43*/
    IL_00ab: callvirt void PathfindMovement::ClearCurrentPath()  /*0x06000B06*/
    IL_00b0: ldarg.0
    IL_00b1: ldfld RVOController Hp::rvoController  /*0x04000A44*/
    IL_00b6: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00bb: brfalse.s IL_00c9
    IL_00bd: ldarg.0
    IL_00be: ldfld RVOController Hp::rvoController  /*0x04000A44*/
    IL_00c3: ldarg.1
    IL_00c4: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_00c9: ldarg.0
    IL_00ca: ldfld PlayerMovement Hp::playerMovement  /*0x04000A45*/
    IL_00cf: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00d4: brfalse.s IL_00e5
    IL_00d6: ldarg.0
    IL_00d7: ldfld PlayerMovement Hp::playerMovement  /*0x04000A45*/
    IL_00dc: ldarg.1
    IL_00dd: ldc.i4.0
    IL_00de: ceq
    IL_00e0: callvirt void PlayerMovement::set_Dead(bool)  /*0x06000C20*/
    IL_00e5: ldarg.0
    IL_00e6: ldfld NavmeshCut[] Hp::navmeshCut  /*0x04000A46*/
    IL_00eb: stloc.3
    IL_00ec: ldc.i4.0
    IL_00ed: stloc.1
    IL_00ee: br.s IL_00fd
    IL_00f0: ldloc.3
    IL_00f1: ldloc.1
    IL_00f2: ldelem.ref
    IL_00f3: ldarg.1
    IL_00f4: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_00f9: ldloc.1
    IL_00fa: ldc.i4.1
    IL_00fb: add
    IL_00fc: stloc.1
    IL_00fd: ldloc.1
    IL_00fe: ldloc.3
    IL_00ff: ldlen
    IL_0100: conv.i4
    IL_0101: blt.s IL_00f0
    IL_0103: ldarg.0
    IL_0104: ldfld PlayerInteraction Hp::playerInteraction  /*0x04000A47*/
    IL_0109: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_010e: brfalse.s IL_011c
    IL_0110: ldarg.0
    IL_0111: ldfld PlayerInteraction Hp::playerInteraction  /*0x04000A47*/
    IL_0116: ldarg.1
    IL_0117: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_011c: ldarg.0
    IL_011d: ldfld UnitGroupIndicator Hp::unitGroupIndicator  /*0x04000A48*/
    IL_0122: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0127: brfalse.s IL_0135
    IL_0129: ldarg.0
    IL_012a: ldfld UnitGroupIndicator Hp::unitGroupIndicator  /*0x04000A48*/
    IL_012f: ldarg.1
    IL_0130: callvirt void UnitGroupIndicator::SetUnitGroupIndicatorVisible(bool)  /*0x060013E0*/
    IL_0135: ret

  .method Hp::Revive(bool,float)  // token 0x0600082A rva 0x27f7c attrs Public, HideBySig
    // code size 229 (0xe5), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: call void Hp::Initialize()  /*0x06000826*/
    IL_0006: ldarg.0
    IL_0007: ldfld float Hp::hp  /*0x04000A2F*/
    IL_000c: ldc.r4 0f
    IL_0011: bgt.un.s IL_0091
    IL_0013: ldarg.1
    IL_0014: brfalse.s IL_0021
    IL_0016: ldarg.0
    IL_0017: ldfld UnityEvent Hp::OnRevive  /*0x04000A3B*/
    IL_001c: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0021: ldarg.0
    IL_0022: ldfld TaggedObject Hp::taggedObject  /*0x04000A31*/
    IL_0027: ldc.i4.s 11
    IL_0029: callvirt void TaggedObject::RemoveTag(TagManager.ETag)  /*0x06000E4A*/
    IL_002e: ldarg.0
    IL_002f: ldfld TaggedObject Hp::taggedObject  /*0x04000A31*/
    IL_0034: ldc.i4.s 10
    IL_0036: callvirt void TaggedObject::AddTag(TagManager.ETag)  /*0x06000E49*/
    IL_003b: ldarg.0
    IL_003c: ldfld GameObject Hp::fxToSpawnOnRevive  /*0x04000A36*/
    IL_0041: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0046: ldarg.1
    IL_0047: and
    IL_0048: brfalse.s IL_007d
    IL_004a: ldarg.0
    IL_004b: ldfld GameObject Hp::fxToSpawnOnRevive  /*0x04000A36*/
    IL_0050: ldarg.0
    IL_0051: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0056: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_005b: ldarg.0
    IL_005c: ldfld Vector3 Hp::deathFxSpawnOffset  /*0x04000A38*/
    IL_0061: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0066: ldarg.0
    IL_0067: ldfld GameObject Hp::fxToSpawnOnRevive  /*0x04000A36*/
    IL_006c: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0071: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0076: ldnull
    IL_0077: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B00000C*/
    IL_007c: pop
    IL_007d: ldarg.0
    IL_007e: ldc.i4.1
    IL_007f: call void Hp::ActivateAndDeactivateChildrenAndCompements(bool)  /*0x06000829*/
    IL_0084: ldarg.0
    IL_0085: ldc.r4 0f
    IL_008a: stfld float Hp::hp  /*0x04000A2F*/
    IL_008f: br.s IL_00aa
    IL_0091: ldarg.0
    IL_0092: ldfld float Hp::hp  /*0x04000A2F*/
    IL_0097: ldarg.0
    IL_0098: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_009d: bge.un.s IL_00aa
    IL_009f: ldarg.0
    IL_00a0: ldfld UnityEvent Hp::OnHeal  /*0x04000A3C*/
    IL_00a5: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_00aa: ldarg.0
    IL_00ab: ldarg.0
    IL_00ac: ldfld float Hp::hp  /*0x04000A2F*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_00b7: ldarg.2
    IL_00b8: mul
    IL_00b9: add
    IL_00ba: stfld float Hp::hp  /*0x04000A2F*/
    IL_00bf: ldarg.0
    IL_00c0: ldfld float Hp::hp  /*0x04000A2F*/
    IL_00c5: ldarg.0
    IL_00c6: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_00cb: ble.un.s IL_00d9
    IL_00cd: ldarg.0
    IL_00ce: ldarg.0
    IL_00cf: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_00d4: stfld float Hp::hp  /*0x04000A2F*/
    IL_00d9: ldarg.0
    IL_00da: ldfld UnityEvent Hp::OnHpChange  /*0x04000A3A*/
    IL_00df: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_00e4: ret

  .method Hp::MakeInvulerable(bool)  // token 0x0600082B rva 0x2806d attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0007: ret

  .method Hp::TakeDamageSelfDrained(float)  // token 0x0600082C rva 0x28078 attrs Public, HideBySig
    // code size 56 (0x38), max stack 5, init locals
    .locals ([0] bool)
    IL_0000: ldarg.0
    IL_0001: ldfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldc.i4.0
    IL_0009: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_000e: ldarg.1
    IL_000f: ldarg.0
    IL_0010: ldfld float Hp::hp  /*0x04000A2F*/
    IL_0015: blt.un.s IL_0025
    IL_0017: ldarg.0
    IL_0018: ldfld float Hp::hp  /*0x04000A2F*/
    IL_001d: ldc.r4 1f
    IL_0022: sub
    IL_0023: starg.s 1
    IL_0025: ldarg.0
    IL_0026: ldarg.1
    IL_0027: ldnull
    IL_0028: ldc.i4.0
    IL_0029: ldc.i4.0
    IL_002a: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_002f: pop
    IL_0030: ldarg.0
    IL_0031: ldloc.0
    IL_0032: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0037: ret

  .method Hp::TakeDamage(float,TaggedObject,bool,bool)  // token 0x0600082D rva 0x280bc attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 685 (0x2ad), max stack 7, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld float Hp::hp  /*0x04000A2F*/
    IL_0006: ldc.r4 0f
    IL_000b: bgt.un.s IL_000f
    IL_000d: ldc.i4.0
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0015: brfalse.s IL_0019
    IL_0017: ldc.i4.0
    IL_0018: ret
    IL_0019: ldarg.1
    IL_001a: ldc.r4 0f
    IL_001f: bgt.un.s IL_002b
    IL_0021: ldarg.0
    IL_0022: ldarg.1
    IL_0023: neg
    IL_0024: call void Hp::Heal(float)  /*0x0600082E*/
    IL_0029: ldc.i4.0
    IL_002a: ret
    IL_002b: ldarg.0
    IL_002c: ldfld PathfindMovement Hp::pathfindMovement  /*0x04000A43*/
    IL_0031: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0036: brfalse.s IL_0044
    IL_0038: ldarg.0
    IL_0039: ldfld PathfindMovement Hp::pathfindMovement  /*0x04000A43*/
    IL_003e: ldarg.2
    IL_003f: callvirt void PathfindMovement::GetAgroFromObject(TaggedObject)  /*0x06000B08*/
    IL_0044: ldarg.0
    IL_0045: ldarg.0
    IL_0046: ldfld float Hp::hp  /*0x04000A2F*/
    IL_004b: ldarg.1
    IL_004c: sub
    IL_004d: stfld float Hp::hp  /*0x04000A2F*/
    IL_0052: ldarg.s 4
    IL_0054: brfalse.s IL_0062
    IL_0056: ldarg.0
    IL_0057: ldfld UnityEvent<bool> Hp::OnReceiveDamage  /*0x04000A3D*/
    IL_005c: ldarg.3
    IL_005d: callvirt void UnityEngine.Events.UnityEvent<bool>::Invoke(!0)  /*0x0A00027A*/
    IL_0062: ldarg.0
    IL_0063: ldfld UnityEvent Hp::OnHpChange  /*0x04000A3A*/
    IL_0068: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_006d: ldarg.0
    IL_006e: ldfld UnityEvent<float> Hp::OnHPValueChanged  /*0x04000A3F*/
    IL_0073: ldarg.1
    IL_0074: callvirt void UnityEngine.Events.UnityEvent<float>::Invoke(!0)  /*0x0A0003B9*/
    IL_0079: ldarg.0
    IL_007a: ldfld float Hp::hp  /*0x04000A2F*/
    IL_007f: ldc.r4 0f
    IL_0084: bgt.un IL_02ab
    IL_0089: ldarg.0
    IL_008a: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_008f: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0094: ldarg.0
    IL_0095: ldfld UnityEvent<TaggedObject> Hp::OnKillOrKnockoutDetailed  /*0x04000A40*/
    IL_009a: ldarg.0
    IL_009b: ldfld TaggedObject Hp::taggedObject  /*0x04000A31*/
    IL_00a0: callvirt void UnityEngine.Events.UnityEvent<TaggedObject>::Invoke(!0)  /*0x0A000231*/
    IL_00a5: ldarg.0
    IL_00a6: ldfld GameObject Hp::fxToSpawnOnDeath  /*0x04000A35*/
    IL_00ab: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00b0: brfalse.s IL_012a
    IL_00b2: ldarg.0
    IL_00b3: call bool Hp::OnScreen()  /*0x06000828*/
    IL_00b8: brfalse.s IL_012a
    IL_00ba: ldarg.0
    IL_00bb: ldfld Transform Hp::deathFxSpawnWithPosAndRotOf  /*0x04000A39*/
    IL_00c0: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00c5: brfalse.s IL_00f7
    IL_00c7: ldarg.0
    IL_00c8: ldfld GameObject Hp::fxToSpawnOnDeath  /*0x04000A35*/
    IL_00cd: ldarg.0
    IL_00ce: ldfld Transform Hp::deathFxSpawnWithPosAndRotOf  /*0x04000A39*/
    IL_00d3: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00d8: ldarg.0
    IL_00d9: ldfld Vector3 Hp::deathFxSpawnOffset  /*0x04000A38*/
    IL_00de: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00e3: ldarg.0
    IL_00e4: ldfld Transform Hp::deathFxSpawnWithPosAndRotOf  /*0x04000A39*/
    IL_00e9: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_00ee: ldnull
    IL_00ef: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B00000C*/
    IL_00f4: pop
    IL_00f5: br.s IL_012a
    IL_00f7: ldarg.0
    IL_00f8: ldfld GameObject Hp::fxToSpawnOnDeath  /*0x04000A35*/
    IL_00fd: ldarg.0
    IL_00fe: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0103: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0108: ldarg.0
    IL_0109: ldfld Vector3 Hp::deathFxSpawnOffset  /*0x04000A38*/
    IL_010e: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0113: ldarg.0
    IL_0114: ldfld GameObject Hp::fxToSpawnOnDeath  /*0x04000A35*/
    IL_0119: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_011e: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0123: ldnull
    IL_0124: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B00000C*/
    IL_0129: pop
    IL_012a: ldarg.0
    IL_012b: ldfld GameObject Hp::enemyToSpawnOnDeath  /*0x04000A37*/
    IL_0130: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0135: brfalse.s IL_0164
    IL_0137: ldarg.0
    IL_0138: ldfld GameObject Hp::enemyToSpawnOnDeath  /*0x04000A37*/
    IL_013d: ldarg.0
    IL_013e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0143: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0148: ldarg.0
    IL_0149: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_014e: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0153: ldnull
    IL_0154: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B00000C*/
    IL_0159: ldarg.0
    IL_015a: ldfld bool Hp::elite  /*0x04000A2E*/
    IL_015f: call void Spawn::AdjustEnemyParametersAfterSpawn(UnityEngine.GameObject,bool)  /*0x060006AA*/
    IL_0164: ldarg.0
    IL_0165: ldfld bool Hp::getsKnockedOutInsteadOfDying  /*0x04000A2D*/
    IL_016a: brfalse.s IL_018f
    IL_016c: ldarg.0
    IL_016d: ldfld TaggedObject Hp::taggedObject  /*0x04000A31*/
    IL_0172: ldc.i4.s 10
    IL_0174: callvirt void TaggedObject::RemoveTag(TagManager.ETag)  /*0x06000E4A*/
    IL_0179: ldarg.0
    IL_017a: ldfld TaggedObject Hp::taggedObject  /*0x04000A31*/
    IL_017f: ldc.i4.s 11
    IL_0181: callvirt void TaggedObject::AddTag(TagManager.ETag)  /*0x06000E49*/
    IL_0186: ldarg.0
    IL_0187: ldc.i4.0
    IL_0188: call void Hp::ActivateAndDeactivateChildrenAndCompements(bool)  /*0x06000829*/
    IL_018d: br.s IL_01b0
    IL_018f: ldarg.0
    IL_0190: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0195: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_019a: ldarg.0
    IL_019b: call float Hp::get_HpOriginal()  /*0x0600081E*/
    IL_01a0: call void Shrine::DeathOfUnitAt(UnityEngine.Vector3,float)  /*0x06000E1A*/
    IL_01a5: ldarg.0
    IL_01a6: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01ab: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_01b0: ldarg.0
    IL_01b1: ldfld GameObject Hp::coin  /*0x04000A49*/
    IL_01b6: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_01bb: brfalse IL_026f
    IL_01c0: ldc.i4.0
    IL_01c1: stloc.0
    IL_01c2: br IL_0263
    IL_01c7: ldloc.0
    IL_01c8: ldc.i4.1
    IL_01c9: blt.s IL_022e
    IL_01cb: ldarg.0
    IL_01cc: ldfld GameObject Hp::coin  /*0x04000A49*/
    IL_01d1: ldarg.0
    IL_01d2: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01d7: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01dc: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_01e1: ldarg.0
    IL_01e2: ldfld float Hp::coinSpawnOffset  /*0x04000A4A*/
    IL_01e7: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_01ec: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_01f1: ldc.r4 0f
    IL_01f6: ldc.r4 45f
    IL_01fb: ldloc.0
    IL_01fc: conv.r4
    IL_01fd: mul
    IL_01fe: ldc.r4 0f
    IL_0203: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_0208: call Vector3 UnityEngine.Vector3::get_forward()  /*0x0A000278*/
    IL_020d: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_0212: ldc.r4 2f
    IL_0217: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_021c: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0221: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0226: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_022b: pop
    IL_022c: br.s IL_025f
    IL_022e: ldarg.0
    IL_022f: ldfld GameObject Hp::coin  /*0x04000A49*/
    IL_0234: ldarg.0
    IL_0235: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_023a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_023f: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0244: ldarg.0
    IL_0245: ldfld float Hp::coinSpawnOffset  /*0x04000A4A*/
    IL_024a: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_024f: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0254: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0259: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_025e: pop
    IL_025f: ldloc.0
    IL_0260: ldc.i4.1
    IL_0261: add
    IL_0262: stloc.0
    IL_0263: ldloc.0
    IL_0264: ldarg.0
    IL_0265: ldfld int Hp::coinCount  /*0x04000A4B*/
    IL_026a: blt IL_01c7
    IL_026f: ldarg.0
    IL_0270: ldfld Weapon Hp::spwanAttackOnDeath  /*0x04000A4C*/
    IL_0275: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_027a: brfalse.s IL_02a9
    IL_027c: ldarg.0
    IL_027d: ldfld Weapon Hp::spwanAttackOnDeath  /*0x04000A4C*/
    IL_0282: ldarg.0
    IL_0283: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0288: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_028d: ldnull
    IL_028e: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0293: ldarg.0
    IL_0294: ldfld TaggedObject Hp::taggedObject  /*0x04000A31*/
    IL_0299: ldarg.0
    IL_029a: ldfld float Hp::damageMultiplyer  /*0x04000A4D*/
    IL_029f: ldc.r4 1f
    IL_02a4: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_02a9: ldc.i4.1
    IL_02aa: ret
    IL_02ab: ldc.i4.0
    IL_02ac: ret

  .method Hp::Heal(float)  // token 0x0600082E rva 0x28378 attrs Public, HideBySig
    // code size 82 (0x52), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld float Hp::hp  /*0x04000A2F*/
    IL_0006: ldc.r4 0f
    IL_000b: bgt.un.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.1
    IL_000f: ldc.r4 0f
    IL_0014: bgt.un.s IL_0017
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldarg.0
    IL_0019: ldfld float Hp::hp  /*0x04000A2F*/
    IL_001e: ldarg.1
    IL_001f: ldarg.0
    IL_0020: ldfld float Hp::healingMultiplyer  /*0x04000A4E*/
    IL_0025: mul
    IL_0026: add
    IL_0027: stfld float Hp::hp  /*0x04000A2F*/
    IL_002c: ldarg.0
    IL_002d: ldfld float Hp::hp  /*0x04000A2F*/
    IL_0032: ldarg.0
    IL_0033: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0038: ble.un.s IL_0046
    IL_003a: ldarg.0
    IL_003b: ldarg.0
    IL_003c: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0041: stfld float Hp::hp  /*0x04000A2F*/
    IL_0046: ldarg.0
    IL_0047: ldfld UnityEvent Hp::OnHpChange  /*0x04000A3A*/
    IL_004c: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0051: ret

  .method Hp::SetHpTo(float)  // token 0x0600082F rva 0x283d6 attrs Public, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float Hp::hp  /*0x04000A2F*/
    IL_0007: ldarg.0
    IL_0008: ldfld UnityEvent Hp::OnHpChange  /*0x04000A3A*/
    IL_000d: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0012: ret

  .method Hp::ReviveAllUnitsWithTag(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,float)  // token 0x06000830 rva 0x283ec attrs Public, Static, HideBySig
    // code size 56 (0x38), max stack 4, init locals
    .locals ([0] List<TaggedObject>, [1] int)
    IL_0000: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0005: stloc.0
    IL_0006: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_000b: ldloc.0
    IL_000c: ldarg.0
    IL_000d: ldarg.1
    IL_000e: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0013: ldc.i4.0
    IL_0014: stloc.1
    IL_0015: br.s IL_002e
    IL_0017: ldloc.0
    IL_0018: ldloc.1
    IL_0019: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_001e: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0023: ldc.i4.1
    IL_0024: ldarg.2
    IL_0025: callvirt void Hp::Revive(bool,float)  /*0x0600082A*/
    IL_002a: ldloc.1
    IL_002b: ldc.i4.1
    IL_002c: add
    IL_002d: stloc.1
    IL_002e: ldloc.1
    IL_002f: ldloc.0
    IL_0030: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0035: blt.s IL_0017
    IL_0037: ret

  .method Hp::SetAllUnitsWithTagInvulnerable(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,bool)  // token 0x06000831 rva 0x28430 attrs Public, Static, HideBySig
    // code size 55 (0x37), max stack 4, init locals
    .locals ([0] List<TaggedObject>, [1] int)
    IL_0000: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0005: stloc.0
    IL_0006: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_000b: ldloc.0
    IL_000c: ldarg.0
    IL_000d: ldarg.1
    IL_000e: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0013: ldc.i4.0
    IL_0014: stloc.1
    IL_0015: br.s IL_002d
    IL_0017: ldloc.0
    IL_0018: ldloc.1
    IL_0019: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_001e: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0023: ldarg.2
    IL_0024: callvirt void Hp::MakeInvulerable(bool)  /*0x0600082B*/
    IL_0029: ldloc.1
    IL_002a: ldc.i4.1
    IL_002b: add
    IL_002c: stloc.1
    IL_002d: ldloc.1
    IL_002e: ldloc.0
    IL_002f: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0034: blt.s IL_0017
    IL_0036: ret

  .method Hp::MarkDestroyedBuildingsAsDontRevive(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,float)  // token 0x06000832 rva 0x28474 attrs Public, Static, HideBySig
    // code size 142 (0x8e), max stack 4, init locals
    .locals ([0] List<TaggedObject>, [1] int)
    IL_0000: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0005: stloc.0
    IL_0006: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_000b: ldloc.0
    IL_000c: ldarg.0
    IL_000d: ldarg.1
    IL_000e: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0013: ldc.i4.0
    IL_0014: stloc.1
    IL_0015: br.s IL_0084
    IL_0017: ldloc.0
    IL_0018: ldloc.1
    IL_0019: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_001e: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0023: ldc.i4.s 11
    IL_0025: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_002a: brfalse.s IL_0080
    IL_002c: ldloc.0
    IL_002d: ldloc.1
    IL_002e: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0033: callvirt !!0 UnityEngine.Component::GetComponentInParent()<BuildSlot>  /*0x2B000004*/
    IL_0038: callvirt BuildingInteractor BuildSlot::get_Interactor()  /*0x060002D6*/
    IL_003d: callvirt void BuildingInteractor::OnKnockOut()  /*0x06000BC1*/
    IL_0042: ldloc.0
    IL_0043: ldloc.1
    IL_0044: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0049: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_004e: ldc.i4.s 25
    IL_0050: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0055: brtrue.s IL_006c
    IL_0057: ldloc.0
    IL_0058: ldloc.1
    IL_0059: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_005e: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0063: ldc.i4.s 25
    IL_0065: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_006a: br.s IL_0080
    IL_006c: ldloc.0
    IL_006d: ldloc.1
    IL_006e: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0073: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0078: ldc.i4.s 25
    IL_007a: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Remove(!0)  /*0x0A0003BA*/
    IL_007f: pop
    IL_0080: ldloc.1
    IL_0081: ldc.i4.1
    IL_0082: add
    IL_0083: stloc.1
    IL_0084: ldloc.1
    IL_0085: ldloc.0
    IL_0086: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_008b: blt.s IL_0017
    IL_008d: ret

  .method Hp::KillAllUnitsWithTag(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  // token 0x06000833 rva 0x28510 attrs Public, Static, HideBySig
    // code size 63 (0x3f), max stack 5, init locals
    .locals ([0] List<TaggedObject>, [1] int)
    IL_0000: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0005: stloc.0
    IL_0006: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_000b: ldloc.0
    IL_000c: ldarg.0
    IL_000d: ldarg.1
    IL_000e: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0013: ldc.i4.0
    IL_0014: stloc.1
    IL_0015: br.s IL_0035
    IL_0017: ldloc.0
    IL_0018: ldloc.1
    IL_0019: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_001e: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0023: ldc.r4 3.4028235E+38f
    IL_0028: ldnull
    IL_0029: ldc.i4.0
    IL_002a: ldc.i4.1
    IL_002b: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0030: pop
    IL_0031: ldloc.1
    IL_0032: ldc.i4.1
    IL_0033: add
    IL_0034: stloc.1
    IL_0035: ldloc.1
    IL_0036: ldloc.0
    IL_0037: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_003c: blt.s IL_0017
    IL_003e: ret

  .method Hp::ReviveAllKnockedOutPlayerUnitsAndBuildings()  // token 0x06000834 rva 0x2855c attrs Public, Static, HideBySig
    // code size 193 (0xc1), max stack 4, init locals
    .locals ([0] List<TagManager.ETag>, [1] List<TagManager.ETag>)
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: callvirt bool PerkManager::get_DestructionGodActive()  /*0x0600098A*/
    IL_000a: brtrue.s IL_003a
    IL_000c: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0011: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0016: stloc.0
    IL_0017: dup
    IL_0018: ldc.i4.0
    IL_0019: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_001e: ldloc.0
    IL_001f: ldc.i4.s 25
    IL_0021: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0026: dup
    IL_0027: ldloc.0
    IL_0028: ldc.r4 1f
    IL_002d: call void Hp::ReviveAllUnitsWithTag(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,float)  /*0x06000830*/
    IL_0032: ldloc.0
    IL_0033: ldc.i4.1
    IL_0034: call void Hp::SetAllUnitsWithTagInvulnerable(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,bool)  /*0x06000831*/
    IL_0039: ret
    IL_003a: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_003f: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0044: stloc.1
    IL_0045: dup
    IL_0046: ldc.i4.0
    IL_0047: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_004c: dup
    IL_004d: ldc.i4.8
    IL_004e: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0053: ldloc.1
    IL_0054: ldc.r4 1f
    IL_0059: call void Hp::MarkDestroyedBuildingsAsDontRevive(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,float)  /*0x06000832*/
    IL_005e: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0063: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0068: stloc.1
    IL_0069: dup
    IL_006a: ldc.i4.0
    IL_006b: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0070: ldloc.1
    IL_0071: ldc.i4.8
    IL_0072: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0077: ldloc.1
    IL_0078: ldc.i4.s 25
    IL_007a: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_007f: dup
    IL_0080: ldloc.1
    IL_0081: ldc.r4 1f
    IL_0086: call void Hp::ReviveAllUnitsWithTag(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,float)  /*0x06000830*/
    IL_008b: dup
    IL_008c: ldloc.1
    IL_008d: ldc.i4.1
    IL_008e: call void Hp::SetAllUnitsWithTagInvulnerable(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,bool)  /*0x06000831*/
    IL_0093: ldloc.1
    IL_0094: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_0099: ldloc.1
    IL_009a: ldc.i4.s 25
    IL_009c: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_00a1: dup
    IL_00a2: ldc.i4.8
    IL_00a3: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_00a8: dup
    IL_00a9: ldloc.1
    IL_00aa: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00af: ldfld float PerkManager::destructionGodHealthRegen  /*0x04000C22*/
    IL_00b4: call void Hp::ReviveAllUnitsWithTag(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,float)  /*0x06000830*/
    IL_00b9: ldloc.1
    IL_00ba: ldc.i4.1
    IL_00bb: call void Hp::SetAllUnitsWithTagInvulnerable(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,bool)  /*0x06000831*/
    IL_00c0: ret

  .method Hp::KillAllEnemyUnits()  // token 0x06000835 rva 0x2862c attrs Public, Static, HideBySig
    // code size 25 (0x19), max stack 3, init locals
    .locals ([0] List<TagManager.ETag>)
    IL_0000: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0005: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_000a: stloc.0
    IL_000b: dup
    IL_000c: ldc.i4.1
    IL_000d: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0012: ldloc.0
    IL_0013: call void Hp::KillAllUnitsWithTag(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000833*/
    IL_0018: ret

  .method Hp::KillAllPlayerUnits()  // token 0x06000836 rva 0x28654 attrs Public, Static, HideBySig
    // code size 25 (0x19), max stack 3, init locals
    .locals ([0] List<TagManager.ETag>)
    IL_0000: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0005: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_000a: stloc.0
    IL_000b: dup
    IL_000c: ldc.i4.7
    IL_000d: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0012: ldloc.0
    IL_0013: call void Hp::KillAllUnitsWithTag(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000833*/
    IL_0018: ret

  .method Hp::.ctor()  // token 0x06000837 rva 0x2867c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 106 (0x6a), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0006: stfld UnityEvent Hp::OnHpChange  /*0x04000A3A*/
    IL_000b: ldarg.0
    IL_000c: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0011: stfld UnityEvent Hp::OnRevive  /*0x04000A3B*/
    IL_0016: ldarg.0
    IL_0017: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_001c: stfld UnityEvent Hp::OnHeal  /*0x04000A3C*/
    IL_0021: ldarg.0
    IL_0022: newobj void UnityEngine.Events.UnityEvent<bool>::.ctor()  /*0x0A00027C*/
    IL_0027: stfld UnityEvent<bool> Hp::OnReceiveDamage  /*0x04000A3D*/
    IL_002c: ldarg.0
    IL_002d: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0032: stfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_0037: ldarg.0
    IL_0038: newobj void UnityEngine.Events.UnityEvent<float>::.ctor()  /*0x0A0003BB*/
    IL_003d: stfld UnityEvent<float> Hp::OnHPValueChanged  /*0x04000A3F*/
    IL_0042: ldarg.0
    IL_0043: newobj void UnityEngine.Events.UnityEvent<TaggedObject>::.ctor()  /*0x0A0003BC*/
    IL_0048: stfld UnityEvent<TaggedObject> Hp::OnKillOrKnockoutDetailed  /*0x04000A40*/
    IL_004d: ldarg.0
    IL_004e: ldc.r4 1f
    IL_0053: stfld float Hp::damageMultiplyer  /*0x04000A4D*/
    IL_0058: ldarg.0
    IL_0059: ldc.r4 1f
    IL_005e: stfld float Hp::healingMultiplyer  /*0x04000A4E*/
    IL_0063: ldarg.0
    IL_0064: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0069: ret

