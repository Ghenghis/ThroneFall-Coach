// ===== QuestConditionEquippable  (token 0x02000330) =====
  .method QuestConditionEquippable::SetData(Equippable)  // token 0x06001190 rva 0x544bc attrs Public, HideBySig
    // code size 93 (0x5d), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Image QuestConditionEquippable::icon  /*0x04001522*/
    IL_0006: ldarg.1
    IL_0007: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_000c: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0011: ldarg.1
    IL_0012: isinst EquippableWeapon  /*0x0200021B*/
    IL_0017: brfalse.s IL_002a
    IL_0019: ldarg.0
    IL_001a: ldfld MPImageBasic QuestConditionEquippable::background  /*0x04001521*/
    IL_001f: ldarg.0
    IL_0020: ldfld Color QuestConditionEquippable::weaponBgColor  /*0x0400151E*/
    IL_0025: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_002a: ldarg.1
    IL_002b: isinst EquippablePerk  /*0x0200021A*/
    IL_0030: brfalse.s IL_0043
    IL_0032: ldarg.0
    IL_0033: ldfld MPImageBasic QuestConditionEquippable::background  /*0x04001521*/
    IL_0038: ldarg.0
    IL_0039: ldfld Color QuestConditionEquippable::perkBgColor  /*0x0400151F*/
    IL_003e: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0043: ldarg.1
    IL_0044: isinst EquippableMutation  /*0x02000219*/
    IL_0049: brfalse.s IL_005c
    IL_004b: ldarg.0
    IL_004c: ldfld MPImageBasic QuestConditionEquippable::background  /*0x04001521*/
    IL_0051: ldarg.0
    IL_0052: ldfld Color QuestConditionEquippable::mutatorBgColor  /*0x04001520*/
    IL_0057: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_005c: ret

  .method QuestConditionEquippable::.ctor()  // token 0x06001191 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

