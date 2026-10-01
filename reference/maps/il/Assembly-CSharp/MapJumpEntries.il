// ===== MapJumpEntries  (token 0x02000103) =====
  .method MapJumpEntries::Start()  // token 0x0600055B rva 0x17484 attrs Private, HideBySig
    // code size 48 (0x30), max stack 2, init locals
    .locals ([0] int, [1] Transform)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_0021
    IL_0004: ldarg.0
    IL_0005: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000a: ldloc.0
    IL_000b: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0010: stloc.1
    IL_0011: ldarg.0
    IL_0012: ldfld List<Transform> MapJumpEntries::points  /*0x040006EB*/
    IL_0017: ldloc.1
    IL_0018: callvirt void System.Collections.Generic.List<UnityEngine.Transform>::Add(!0)  /*0x0A000235*/
    IL_001d: ldloc.0
    IL_001e: ldc.i4.1
    IL_001f: add
    IL_0020: stloc.0
    IL_0021: ldloc.0
    IL_0022: ldarg.0
    IL_0023: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0028: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_002d: blt.s IL_0004
    IL_002f: ret

  .method MapJumpEntries::NextJumpPoint()  // token 0x0600055C rva 0x174c0 attrs Public, HideBySig
    // code size 146 (0x92), max stack 3, init locals
    .locals ([0] MapJumpEntries.NextPointSelectionType)
    IL_0000: ldarg.0
    IL_0001: ldfld List<Transform> MapJumpEntries::points  /*0x040006EB*/
    IL_0006: callvirt int System.Collections.Generic.List<UnityEngine.Transform>::get_Count()  /*0x0A000236*/
    IL_000b: ldc.i4.0
    IL_000c: ble.s IL_008c
    IL_000e: ldarg.0
    IL_000f: ldfld MapJumpEntries.NextPointSelectionType MapJumpEntries::nextPointSelectionType  /*0x040006EA*/
    IL_0014: stloc.0
    IL_0015: ldloc.0
    IL_0016: switch (IL_0029, IL_0045, IL_005e)
    IL_0027: br.s IL_0075
    IL_0029: ldarg.0
    IL_002a: ldarg.0
    IL_002b: ldfld int MapJumpEntries::nextPointIndex  /*0x040006EC*/
    IL_0030: ldc.i4.1
    IL_0031: add
    IL_0032: ldarg.0
    IL_0033: ldfld List<Transform> MapJumpEntries::points  /*0x040006EB*/
    IL_0038: callvirt int System.Collections.Generic.List<UnityEngine.Transform>::get_Count()  /*0x0A000236*/
    IL_003d: rem
    IL_003e: stfld int MapJumpEntries::nextPointIndex  /*0x040006EC*/
    IL_0043: br.s IL_0075
    IL_0045: ldarg.0
    IL_0046: ldc.i4.0
    IL_0047: ldarg.0
    IL_0048: ldfld List<Transform> MapJumpEntries::points  /*0x040006EB*/
    IL_004d: callvirt int System.Collections.Generic.List<UnityEngine.Transform>::get_Count()  /*0x0A000236*/
    IL_0052: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_0057: stfld int MapJumpEntries::nextPointIndex  /*0x040006EC*/
    IL_005c: br.s IL_0075
    IL_005e: ldarg.0
    IL_005f: ldarg.0
    IL_0060: ldarg.0
    IL_0061: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0066: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_006b: call int MapJumpEntries::FindFarthestPoint(UnityEngine.Vector3)  /*0x0600055D*/
    IL_0070: stfld int MapJumpEntries::nextPointIndex  /*0x040006EC*/
    IL_0075: ldarg.0
    IL_0076: ldfld List<Transform> MapJumpEntries::points  /*0x040006EB*/
    IL_007b: ldarg.0
    IL_007c: ldfld int MapJumpEntries::nextPointIndex  /*0x040006EC*/
    IL_0081: callvirt !0 System.Collections.Generic.List<UnityEngine.Transform>::get_Item(int)  /*0x0A000237*/
    IL_0086: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_008b: ret
    IL_008c: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0091: ret

  .method MapJumpEntries::FindFarthestPoint(UnityEngine.Vector3)  // token 0x0600055D rva 0x17560 attrs Private, HideBySig
    // code size 73 (0x49), max stack 2, init locals
    .locals ([0] int, [1] float, [2] int, [3] float, [4] Vector3)
    IL_0000: ldc.i4.m1
    IL_0001: stloc.0
    IL_0002: ldc.r4 -3.4028235E+38f
    IL_0007: stloc.1
    IL_0008: ldc.i4.0
    IL_0009: stloc.2
    IL_000a: br.s IL_0039
    IL_000c: ldarg.0
    IL_000d: ldfld List<Transform> MapJumpEntries::points  /*0x040006EB*/
    IL_0012: ldloc.2
    IL_0013: callvirt !0 System.Collections.Generic.List<UnityEngine.Transform>::get_Item(int)  /*0x0A000237*/
    IL_0018: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_001d: ldarg.1
    IL_001e: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0023: stloc.s 4
    IL_0025: ldloca.s 4
    IL_0027: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_002c: stloc.3
    IL_002d: ldloc.3
    IL_002e: ldloc.1
    IL_002f: ble.un.s IL_0035
    IL_0031: ldloc.2
    IL_0032: stloc.0
    IL_0033: ldloc.3
    IL_0034: stloc.1
    IL_0035: ldloc.2
    IL_0036: ldc.i4.1
    IL_0037: add
    IL_0038: stloc.2
    IL_0039: ldloc.2
    IL_003a: ldarg.0
    IL_003b: ldfld List<Transform> MapJumpEntries::points  /*0x040006EB*/
    IL_0040: callvirt int System.Collections.Generic.List<UnityEngine.Transform>::get_Count()  /*0x0A000236*/
    IL_0045: blt.s IL_000c
    IL_0047: ldloc.0
    IL_0048: ret

  .method MapJumpEntries::GetJumpPoint(int)  // token 0x0600055E rva 0x175b5 attrs Public, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldc.i4.0
    IL_0002: blt.s IL_0024
    IL_0004: ldarg.1
    IL_0005: ldarg.0
    IL_0006: ldfld List<Transform> MapJumpEntries::points  /*0x040006EB*/
    IL_000b: callvirt int System.Collections.Generic.List<UnityEngine.Transform>::get_Count()  /*0x0A000236*/
    IL_0010: bge.s IL_0024
    IL_0012: ldarg.0
    IL_0013: ldfld List<Transform> MapJumpEntries::points  /*0x040006EB*/
    IL_0018: ldarg.1
    IL_0019: callvirt !0 System.Collections.Generic.List<UnityEngine.Transform>::get_Item(int)  /*0x0A000237*/
    IL_001e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0023: ret
    IL_0024: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0029: ret

  .method MapJumpEntries::.ctor()  // token 0x0600055F rva 0x175e0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.2
    IL_0002: stfld MapJumpEntries.NextPointSelectionType MapJumpEntries::nextPointSelectionType  /*0x040006EA*/
    IL_0007: ldarg.0
    IL_0008: newobj void System.Collections.Generic.List<UnityEngine.Transform>::.ctor()  /*0x0A000238*/
    IL_000d: stfld List<Transform> MapJumpEntries::points  /*0x040006EB*/
    IL_0012: ldarg.0
    IL_0013: ldc.i4.m1
    IL_0014: stfld int MapJumpEntries::nextPointIndex  /*0x040006EC*/
    IL_0019: ldarg.0
    IL_001a: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001f: ret

// ===== MapJumpEntries/NextPointSelectionType  (token 0x02000104) =====
