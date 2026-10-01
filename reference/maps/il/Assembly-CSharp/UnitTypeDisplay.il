// ===== UnitTypeDisplay  (token 0x02000379) =====
  .method UnitTypeDisplay::SetSelected(bool)  // token 0x06001327 rva 0x5b368 attrs Public, HideBySig
    // code size 38 (0x26), max stack 8
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_0014
    IL_0003: ldarg.0
    IL_0004: ldfld MPImageBasic UnitTypeDisplay::icon  /*0x04001729*/
    IL_0009: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_000e: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: ldfld MPImageBasic UnitTypeDisplay::icon  /*0x04001729*/
    IL_001a: ldarg.0
    IL_001b: ldfld Color UnitTypeDisplay::originalColor  /*0x0400172C*/
    IL_0020: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0025: ret

  .method UnitTypeDisplay::Start()  // token 0x06001328 rva 0x5b390 attrs Private, HideBySig
    // code size 71 (0x47), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldsfld CommandUnits CommandUnits::instance  /*0x04000DAD*/
    IL_0006: stfld CommandUnits UnitTypeDisplay::commandingUnits  /*0x0400172B*/
    IL_000b: ldarg.0
    IL_000c: ldfld bool UnitTypeDisplay::ranged  /*0x04001728*/
    IL_0011: brfalse.s IL_0025
    IL_0013: ldarg.0
    IL_0014: ldsfld Colorscheme ColorAndLightManager::currentColorscheme  /*0x04000448*/
    IL_0019: ldfld Color Colorscheme::allyRangedIndicatorColor  /*0x04000464*/
    IL_001e: stfld Color UnitTypeDisplay::originalColor  /*0x0400172C*/
    IL_0023: br.s IL_0035
    IL_0025: ldarg.0
    IL_0026: ldsfld Colorscheme ColorAndLightManager::currentColorscheme  /*0x04000448*/
    IL_002b: ldfld Color Colorscheme::allyMeleeIndicatorColor  /*0x04000463*/
    IL_0030: stfld Color UnitTypeDisplay::originalColor  /*0x0400172C*/
    IL_0035: ldarg.0
    IL_0036: ldfld MPImageBasic UnitTypeDisplay::icon  /*0x04001729*/
    IL_003b: ldarg.0
    IL_003c: ldfld Color UnitTypeDisplay::originalColor  /*0x0400172C*/
    IL_0041: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0046: ret

  .method UnitTypeDisplay::Update()  // token 0x06001329 rva 0x5b3e4 attrs Private, HideBySig
    // code size 86 (0x56), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Hp UnitTypeDisplay::hp  /*0x0400172A*/
    IL_0006: callvirt bool Hp::get_Alive()  /*0x0600081D*/
    IL_000b: brtrue.s IL_0027
    IL_000d: ldarg.0
    IL_000e: ldfld GameObject UnitTypeDisplay::displayParent  /*0x04001727*/
    IL_0013: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_0018: brfalse.s IL_0026
    IL_001a: ldarg.0
    IL_001b: ldfld GameObject UnitTypeDisplay::displayParent  /*0x04001727*/
    IL_0020: ldc.i4.0
    IL_0021: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0026: ret
    IL_0027: ldarg.0
    IL_0028: ldfld GameObject UnitTypeDisplay::displayParent  /*0x04001727*/
    IL_002d: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_0032: ldarg.0
    IL_0033: ldfld CommandUnits UnitTypeDisplay::commandingUnits  /*0x0400172B*/
    IL_0038: callvirt bool CommandUnits::get_ShouldShowUnitTypes()  /*0x06000AF4*/
    IL_003d: beq.s IL_0055
    IL_003f: ldarg.0
    IL_0040: ldfld GameObject UnitTypeDisplay::displayParent  /*0x04001727*/
    IL_0045: ldarg.0
    IL_0046: ldfld CommandUnits UnitTypeDisplay::commandingUnits  /*0x0400172B*/
    IL_004b: callvirt bool CommandUnits::get_ShouldShowUnitTypes()  /*0x06000AF4*/
    IL_0050: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0055: ret

  .method UnitTypeDisplay::.ctor()  // token 0x0600132A rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

