// ===== MapPointCrystalDragon  (token 0x020000DB) =====
  .method MapPointCrystalDragon::get_CrystalDragonFlyOffPoint()  // token 0x0600049B rva 0x14737 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld Transform MapPointCrystalDragon::<CrystalDragonFlyOffPoint>k__BackingField  /*0x040005EE*/
    IL_0005: ret

  .method MapPointCrystalDragon::set_CrystalDragonFlyOffPoint(UnityEngine.Transform)  // token 0x0600049C rva 0x1473e attrs Private, Static, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld Transform MapPointCrystalDragon::<CrystalDragonFlyOffPoint>k__BackingField  /*0x040005EE*/
    IL_0006: ret

  .method MapPointCrystalDragon::get_CrystalDragonCrystal2PhaseSpawn()  // token 0x0600049D rva 0x14746 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld Transform MapPointCrystalDragon::<CrystalDragonCrystal2PhaseSpawn>k__BackingField  /*0x040005EF*/
    IL_0005: ret

  .method MapPointCrystalDragon::set_CrystalDragonCrystal2PhaseSpawn(UnityEngine.Transform)  // token 0x0600049E rva 0x1474d attrs Private, Static, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld Transform MapPointCrystalDragon::<CrystalDragonCrystal2PhaseSpawn>k__BackingField  /*0x040005EF*/
    IL_0006: ret

  .method MapPointCrystalDragon::Awake()  // token 0x0600049F rva 0x14755 attrs Private, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Transform MapPointCrystalDragon::crystalDragonFlyOffPoint  /*0x040005EC*/
    IL_0006: call void MapPointCrystalDragon::set_CrystalDragonFlyOffPoint(UnityEngine.Transform)  /*0x0600049C*/
    IL_000b: ldarg.0
    IL_000c: ldfld Transform MapPointCrystalDragon::crystalDragonCrystal2PhaseSpawn  /*0x040005ED*/
    IL_0011: call void MapPointCrystalDragon::set_CrystalDragonCrystal2PhaseSpawn(UnityEngine.Transform)  /*0x0600049E*/
    IL_0016: ret

  .method MapPointCrystalDragon::.ctor()  // token 0x060004A0 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

