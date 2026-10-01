// ===== BalancingParameter  (token 0x0200007A) =====
  .method BalancingParameter::.ctor(BalancingParameter.EType)  // token 0x0600027A rva 0xb159 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Attribute::.ctor()  /*0x0A0000F7*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld BalancingParameter.EType BalancingParameter::type  /*0x04000348*/
    IL_000d: ret

  .method BalancingParameter::ValueToString(string)  // token 0x0600027B rva 0xb168 attrs Public, HideBySig
    // code size 2 (0x2), max stack 8
    IL_0000: ldarg.1
    IL_0001: ret

  .method BalancingParameter::ValueToString(float)  // token 0x0600027C rva 0xb16c attrs Public, HideBySig
    // code size 123 (0x7b), max stack 3, init locals
    .locals ([0] BalancingParameter.EType)
    IL_0000: ldarg.0
    IL_0001: ldfld BalancingParameter.EType BalancingParameter::type  /*0x04000348*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: ldc.i4.1
    IL_0009: beq.s IL_0011
    IL_000b: ldloc.0
    IL_000c: ldc.i4.2
    IL_000d: beq.s IL_0055
    IL_000f: br.s IL_0074
    IL_0011: ldarg.1
    IL_0012: ldc.r4 1f
    IL_0017: sub
    IL_0018: starg.s 1
    IL_001a: ldarg.1
    IL_001b: ldc.r4 0f
    IL_0020: blt.un.s IL_003e
    IL_0022: ldstr "+"
    IL_0027: ldarg.1
    IL_0028: ldc.r4 100f
    IL_002d: mul
    IL_002e: call string BalancingParameter::RoundToQuarterString(float)  /*0x0600027D*/
    IL_0033: ldstr "%"
    IL_0038: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_003d: ret
    IL_003e: ldarg.1
    IL_003f: ldc.r4 100f
    IL_0044: mul
    IL_0045: call string BalancingParameter::RoundToQuarterString(float)  /*0x0600027D*/
    IL_004a: ldstr "%"
    IL_004f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0054: ret
    IL_0055: ldarg.1
    IL_0056: ldc.r4 0f
    IL_005b: pop
    IL_005c: pop
    IL_005d: ldarg.1
    IL_005e: ldc.r4 100f
    IL_0063: mul
    IL_0064: call string BalancingParameter::RoundToQuarterString(float)  /*0x0600027D*/
    IL_0069: ldstr "%"
    IL_006e: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0073: ret
    IL_0074: ldarg.1
    IL_0075: call string BalancingParameter::RoundToQuarterString(float)  /*0x0600027D*/
    IL_007a: ret

  .method BalancingParameter::RoundToQuarterString(float)  // token 0x0600027D rva 0xb1f4 attrs Public, Static, HideBySig
    // code size 71 (0x47), max stack 3, init locals
    .locals ([0] float, [1] int)
    IL_0000: ldarg.0
    IL_0001: ldc.r4 4f
    IL_0006: mul
    IL_0007: call float UnityEngine.Mathf::Round(float)  /*0x0A0000F8*/
    IL_000c: ldc.r4 4f
    IL_0011: div
    IL_0012: stloc.0
    IL_0013: ldloc.0
    IL_0014: ldloc.0
    IL_0015: call float UnityEngine.Mathf::Round(float)  /*0x0A0000F8*/
    IL_001a: call bool UnityEngine.Mathf::Approximately(float,float)  /*0x0A0000F9*/
    IL_001f: brfalse.s IL_0035
    IL_0021: ldloc.0
    IL_0022: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0027: stloc.1
    IL_0028: ldloca.s 1
    IL_002a: call CultureInfo System.Globalization.CultureInfo::get_InvariantCulture()  /*0x0A0000FB*/
    IL_002f: call string System.Int32::ToString(System.IFormatProvider)  /*0x0A0000FC*/
    IL_0034: ret
    IL_0035: ldloca.s 0
    IL_0037: ldstr "F2"
    IL_003c: call CultureInfo System.Globalization.CultureInfo::get_InvariantCulture()  /*0x0A0000FB*/
    IL_0041: call string System.Single::ToString(string,System.IFormatProvider)  /*0x0A0000FD*/
    IL_0046: ret

// ===== BalancingParameter/EType  (token 0x0200007B) =====
