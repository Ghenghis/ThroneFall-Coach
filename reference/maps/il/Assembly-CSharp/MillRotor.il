// ===== MillRotor  (token 0x020001F1) =====
  .method MillRotor::Start()  // token 0x06000A44 rva 0x3075c attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0006: stfld DayNightCycle MillRotor::daynight  /*0x04000D04*/
    IL_000b: ret

  .method MillRotor::Update()  // token 0x06000A45 rva 0x3076c attrs Private, HideBySig
    // code size 191 (0xbf), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld DayNightCycle MillRotor::daynight  /*0x04000D04*/
    IL_0006: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_000b: brtrue.s IL_0050
    IL_000d: ldarg.0
    IL_000e: ldfld float MillRotor::currentSpeed  /*0x04000D03*/
    IL_0013: ldarg.0
    IL_0014: ldfld float MillRotor::rotationSpeed  /*0x04000D01*/
    IL_0019: bge.un.s IL_0034
    IL_001b: ldarg.0
    IL_001c: ldarg.0
    IL_001d: ldfld float MillRotor::currentSpeed  /*0x04000D03*/
    IL_0022: ldarg.0
    IL_0023: ldfld float MillRotor::acceleration  /*0x04000D02*/
    IL_0028: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_002d: mul
    IL_002e: add
    IL_002f: stfld float MillRotor::currentSpeed  /*0x04000D03*/
    IL_0034: ldarg.0
    IL_0035: ldfld float MillRotor::currentSpeed  /*0x04000D03*/
    IL_003a: ldarg.0
    IL_003b: ldfld float MillRotor::rotationSpeed  /*0x04000D01*/
    IL_0040: ble.un.s IL_009c
    IL_0042: ldarg.0
    IL_0043: ldarg.0
    IL_0044: ldfld float MillRotor::rotationSpeed  /*0x04000D01*/
    IL_0049: stfld float MillRotor::currentSpeed  /*0x04000D03*/
    IL_004e: br.s IL_009c
    IL_0050: ldarg.0
    IL_0051: ldfld DayNightCycle MillRotor::daynight  /*0x04000D04*/
    IL_0056: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_005b: ldc.i4.1
    IL_005c: bne.un.s IL_009c
    IL_005e: ldarg.0
    IL_005f: ldfld float MillRotor::currentSpeed  /*0x04000D03*/
    IL_0064: ldc.r4 0f
    IL_0069: ble.un.s IL_0084
    IL_006b: ldarg.0
    IL_006c: ldarg.0
    IL_006d: ldfld float MillRotor::currentSpeed  /*0x04000D03*/
    IL_0072: ldarg.0
    IL_0073: ldfld float MillRotor::acceleration  /*0x04000D02*/
    IL_0078: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_007d: mul
    IL_007e: sub
    IL_007f: stfld float MillRotor::currentSpeed  /*0x04000D03*/
    IL_0084: ldarg.0
    IL_0085: ldfld float MillRotor::currentSpeed  /*0x04000D03*/
    IL_008a: ldc.r4 0f
    IL_008f: bge.un.s IL_009c
    IL_0091: ldarg.0
    IL_0092: ldc.r4 0f
    IL_0097: stfld float MillRotor::currentSpeed  /*0x04000D03*/
    IL_009c: ldarg.0
    IL_009d: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00a2: ldc.r4 0f
    IL_00a7: ldarg.0
    IL_00a8: ldfld float MillRotor::currentSpeed  /*0x04000D03*/
    IL_00ad: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00b2: mul
    IL_00b3: ldc.r4 0f
    IL_00b8: ldc.i4.1
    IL_00b9: callvirt void UnityEngine.Transform::Rotate(float,float,float,UnityEngine.Space)  /*0x0A0000B1*/
    IL_00be: ret

  .method MillRotor::.ctor()  // token 0x06000A46 rva 0x30837 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 90f
    IL_0006: stfld float MillRotor::rotationSpeed  /*0x04000D01*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 10f
    IL_0011: stfld float MillRotor::acceleration  /*0x04000D02*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

