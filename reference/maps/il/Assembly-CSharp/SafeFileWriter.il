// ===== SafeFileWriter  (token 0x02000257) =====
  .method SafeFileWriter::GenerateBackupPath(string)  // token 0x06000CC9 rva 0x3abf4 attrs Private, Static, HideBySig
    // code size 58 (0x3a), max stack 5, init locals
    .locals ([0] string, [1] string, [2] string, [3] DateTime)
    IL_0000: ldarg.0
    IL_0001: call string System.IO.Path::GetDirectoryName(string)  /*0x0A00051D*/
    IL_0006: ldarg.0
    IL_0007: call string System.IO.Path::GetFileNameWithoutExtension(string)  /*0x0A00042C*/
    IL_000c: stloc.0
    IL_000d: ldarg.0
    IL_000e: call string System.IO.Path::GetExtension(string)  /*0x0A00051E*/
    IL_0013: stloc.1
    IL_0014: call DateTime System.DateTime::get_Now()  /*0x0A00051F*/
    IL_0019: stloc.3
    IL_001a: ldloca.s 3
    IL_001c: ldstr "yyyyMMdd_HHmmss"
    IL_0021: call string System.DateTime::ToString(string)  /*0x0A000520*/
    IL_0026: stloc.2
    IL_0027: ldloc.0
    IL_0028: ldstr "_"
    IL_002d: ldloc.2
    IL_002e: ldloc.1
    IL_002f: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0034: call string System.IO.Path::Combine(string,string)  /*0x0A000521*/
    IL_0039: ret

  .method SafeFileWriter::ManageBackups(string)  // token 0x06000CCA rva 0x3ac3c attrs Private, Static, HideBySig
    // code size 150 (0x96), max stack 4, init locals
    .locals ([0] string, [1] string, [2] List<string>, [3] int, [4] int)
    IL_0000: ldarg.0
    IL_0001: call string System.IO.Path::GetDirectoryName(string)  /*0x0A00051D*/
    IL_0006: ldarg.0
    IL_0007: call string System.IO.Path::GetFileNameWithoutExtension(string)  /*0x0A00042C*/
    IL_000c: stloc.0
    IL_000d: ldarg.0
    IL_000e: call string System.IO.Path::GetExtension(string)  /*0x0A00051E*/
    IL_0013: stloc.1
    IL_0014: ldloc.0
    IL_0015: ldstr "_*"
    IL_001a: ldloc.1
    IL_001b: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0020: call string[] System.IO.Directory::GetFiles(string,string)  /*0x0A000522*/
    IL_0025: ldsfld Func<string, string> SafeFileWriter.<>c::<>9__2_0  /*0x04000F80*/
    IL_002a: dup
    IL_002b: brtrue.s IL_0044
    IL_002d: pop
    IL_002e: ldsfld SafeFileWriter.<>c SafeFileWriter.<>c::<>9  /*0x04000F7F*/
    IL_0033: ldftn string SafeFileWriter.<>c::<ManageBackups>b__2_0(string)  /*0x06000CD1*/
    IL_0039: newobj void System.Func<string, string>::.ctor(object,IntPtr)  /*0x0A000523*/
    IL_003e: dup
    IL_003f: stsfld Func<string, string> SafeFileWriter.<>c::<>9__2_0  /*0x04000F80*/
    IL_0044: call IOrderedEnumerable<!!0> System.Linq.Enumerable::OrderByDescending(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, !!1>)<string,string>  /*0x2B0000B9*/
    IL_0049: call List<!!0> System.Linq.Enumerable::ToList(System.Collections.Generic.IEnumerable<!!0>)<string>  /*0x2B0000BA*/
    IL_004e: stloc.2
    IL_004f: ldloc.2
    IL_0050: callvirt int System.Collections.Generic.List<string>::get_Count()  /*0x0A000047*/
    IL_0055: ldsfld int SafeFileWriter::MaxBackups  /*0x04000F7E*/
    IL_005a: ble.s IL_0095
    IL_005c: ldloc.2
    IL_005d: callvirt int System.Collections.Generic.List<string>::get_Count()  /*0x0A000047*/
    IL_0062: ldsfld int SafeFileWriter::MaxBackups  /*0x04000F7E*/
    IL_0067: sub
    IL_0068: stloc.3
    IL_0069: ldc.i4.0
    IL_006a: stloc.s 4
    IL_006c: br.s IL_0090
    IL_006e: ldloc.s 4
    IL_0070: ldc.i4.2
    IL_0071: rem
    IL_0072: brtrue.s IL_008a
    IL_0074: ldloc.2
    IL_0075: ldloc.2
    IL_0076: callvirt int System.Collections.Generic.List<string>::get_Count()  /*0x0A000047*/
    IL_007b: ldc.i4.1
    IL_007c: sub
    IL_007d: ldloc.s 4
    IL_007f: sub
    IL_0080: callvirt !0 System.Collections.Generic.List<string>::get_Item(int)  /*0x0A000362*/
    IL_0085: call void System.IO.File::Delete(string)  /*0x0A000524*/
    IL_008a: ldloc.s 4
    IL_008c: ldc.i4.1
    IL_008d: add
    IL_008e: stloc.s 4
    IL_0090: ldloc.s 4
    IL_0092: ldloc.3
    IL_0093: blt.s IL_006e
    IL_0095: ret

  .method SafeFileWriter::FileWriteAllLinesSafe(string,System.Collections.Generic.IEnumerable<string>)  // token 0x06000CCB rva 0x3ace0 attrs Public, Static, HideBySig
    // code size 67 (0x43), max stack 3, init locals
    .locals ([0] string, [1] Exception)
    IL_0000: ldarg.0
    IL_0001: call string System.IO.Path::GetDirectoryName(string)  /*0x0A00051D*/
    IL_0006: call DirectoryInfo System.IO.Directory::CreateDirectory(string)  /*0x0A000525*/
    IL_000b: pop
    IL_000c: ldarg.0
    IL_000d: ldarg.1
    IL_000e: call void System.IO.File::WriteAllLines(string,System.Collections.Generic.IEnumerable<string>)  /*0x0A000526*/
    IL_0013: ldarg.0
    IL_0014: call string SafeFileWriter::GenerateBackupPath(string)  /*0x06000CC9*/
    IL_0019: stloc.0
    IL_001a: ldarg.0
    IL_001b: ldloc.0
    IL_001c: ldc.i4.1
    IL_001d: call void System.IO.File::Copy(string,string,bool)  /*0x0A000527*/
    IL_0022: ldarg.0
    IL_0023: call void SafeFileWriter::ManageBackups(string)  /*0x06000CCA*/
    IL_0028: leave.s IL_0042
    IL_002a: stloc.1
    IL_002b: ldstr "Error during save: "
    IL_0030: ldloc.1
    IL_0031: callvirt string System.Exception::get_Message()  /*0x0A000528*/
    IL_0036: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_003b: call void System.Console::WriteLine(string)  /*0x0A000529*/
    IL_0040: rethrow
    IL_0042: ret
    .try IL_0000-IL_002a catch System.Exception handler IL_002a-IL_0042

  .method SafeFileWriter::FileReadAllLinesSafe(string)  // token 0x06000CCC rva 0x3ad40 attrs Public, Static, HideBySig
    // code size 68 (0x44), max stack 2, init locals
    .locals ([0] string[], [1] Exception)
    IL_0000: ldarg.0
    IL_0001: call bool System.IO.File::Exists(string)  /*0x0A00052A*/
    IL_0006: brtrue.s IL_0019
    IL_0008: ldstr "Main save file not found."
    IL_000d: call void System.Console::WriteLine(string)  /*0x0A000529*/
    IL_0012: ldarg.0
    IL_0013: call string[] SafeFileWriter::TryLoadFromBackups(string)  /*0x06000CCD*/
    IL_0018: ret
    IL_0019: nop
    IL_001a: ldarg.0
    IL_001b: call string[] System.IO.File::ReadAllLines(string)  /*0x0A00052B*/
    IL_0020: stloc.0
    IL_0021: leave.s IL_0042
    IL_0023: stloc.1
    IL_0024: ldstr "Error loading main save file: "
    IL_0029: ldloc.1
    IL_002a: callvirt string System.Exception::get_Message()  /*0x0A000528*/
    IL_002f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0034: call void System.Console::WriteLine(string)  /*0x0A000529*/
    IL_0039: ldarg.0
    IL_003a: call string[] SafeFileWriter::TryLoadFromBackups(string)  /*0x06000CCD*/
    IL_003f: stloc.0
    IL_0040: leave.s IL_0042
    IL_0042: ldloc.0
    IL_0043: ret
    .try IL_001a-IL_0023 catch System.Exception handler IL_0023-IL_0042

  .method SafeFileWriter::TryLoadFromBackups(string)  // token 0x06000CCD rva 0x3ada0 attrs Private, Static, HideBySig
    // code size 175 (0xaf), max stack 4, init locals
    .locals ([0] string, [1] string, [2] List.Enumerator<string>, [3] string, [4] string[], [5] Exception)
    IL_0000: ldarg.0
    IL_0001: call string System.IO.Path::GetDirectoryName(string)  /*0x0A00051D*/
    IL_0006: ldarg.0
    IL_0007: call string System.IO.Path::GetFileNameWithoutExtension(string)  /*0x0A00042C*/
    IL_000c: stloc.0
    IL_000d: ldarg.0
    IL_000e: call string System.IO.Path::GetExtension(string)  /*0x0A00051E*/
    IL_0013: stloc.1
    IL_0014: ldloc.0
    IL_0015: ldstr "_*"
    IL_001a: ldloc.1
    IL_001b: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0020: call string[] System.IO.Directory::GetFiles(string,string)  /*0x0A000522*/
    IL_0025: ldsfld Func<string, string> SafeFileWriter.<>c::<>9__5_0  /*0x04000F81*/
    IL_002a: dup
    IL_002b: brtrue.s IL_0044
    IL_002d: pop
    IL_002e: ldsfld SafeFileWriter.<>c SafeFileWriter.<>c::<>9  /*0x04000F7F*/
    IL_0033: ldftn string SafeFileWriter.<>c::<TryLoadFromBackups>b__5_0(string)  /*0x06000CD2*/
    IL_0039: newobj void System.Func<string, string>::.ctor(object,IntPtr)  /*0x0A000523*/
    IL_003e: dup
    IL_003f: stsfld Func<string, string> SafeFileWriter.<>c::<>9__5_0  /*0x04000F81*/
    IL_0044: call IOrderedEnumerable<!!0> System.Linq.Enumerable::OrderByDescending(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, !!1>)<string,string>  /*0x2B0000B9*/
    IL_0049: call List<!!0> System.Linq.Enumerable::ToList(System.Collections.Generic.IEnumerable<!!0>)<string>  /*0x2B0000BA*/
    IL_004e: callvirt List.Enumerator<!0> System.Collections.Generic.List<string>::GetEnumerator()  /*0x0A0002EB*/
    IL_0053: stloc.2
    IL_0054: br.s IL_0088
    IL_0056: ldloca.s 2
    IL_0058: call !0 System.Collections.Generic.List.Enumerator<string>::get_Current()  /*0x0A0002EC*/
    IL_005d: stloc.3
    IL_005e: ldloc.3
    IL_005f: call string[] System.IO.File::ReadAllLines(string)  /*0x0A00052B*/
    IL_0064: stloc.s 4
    IL_0066: leave.s IL_00ac
    IL_0068: stloc.s 5
    IL_006a: ldstr "Error loading backup file "
    IL_006f: ldloc.3
    IL_0070: ldstr ": "
    IL_0075: ldloc.s 5
    IL_0077: callvirt string System.Exception::get_Message()  /*0x0A000528*/
    IL_007c: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0081: call void System.Console::WriteLine(string)  /*0x0A000529*/
    IL_0086: leave.s IL_0088
    IL_0088: ldloca.s 2
    IL_008a: call bool System.Collections.Generic.List.Enumerator<string>::MoveNext()  /*0x0A0002ED*/
    IL_008f: brtrue.s IL_0056
    IL_0091: leave.s IL_00a1
    IL_0093: ldloca.s 2
    IL_0095: constrained. System.Collections.Generic.List.Enumerator<string>  /*0x1B000087*/
    IL_009b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00a0: endfinally
    IL_00a1: ldstr "No valid save file or backup found."
    IL_00a6: newobj void System.IO.FileNotFoundException::.ctor(string)  /*0x0A00052C*/
    IL_00ab: throw
    IL_00ac: ldloc.s 4
    IL_00ae: ret
    .try IL_005e-IL_0068 catch System.Exception handler IL_0068-IL_0088
    .try IL_0054-IL_0093 finally handler IL_0093-IL_00a1

  .method SafeFileWriter::.cctor()  // token 0x06000CCE rva 0x3ae78 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldc.i4.s 16
    IL_0002: stsfld int SafeFileWriter::MaxBackups  /*0x04000F7E*/
    IL_0007: ret

// ===== SafeFileWriter/<>c  (token 0x02000258) =====
  .method SafeFileWriter.<>c::.cctor()  // token 0x06000CCF rva 0x3ae81 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void SafeFileWriter.<>c::.ctor()  /*0x06000CD0*/
    IL_0005: stsfld SafeFileWriter.<>c SafeFileWriter.<>c::<>9  /*0x04000F7F*/
    IL_000a: ret

  .method SafeFileWriter.<>c::.ctor()  // token 0x06000CD0 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method SafeFileWriter.<>c::<ManageBackups>b__2_0(string)  // token 0x06000CD1 rva 0xb168 attrs Assembly, HideBySig
    // code size 2 (0x2), max stack 8
    IL_0000: ldarg.1
    IL_0001: ret

  .method SafeFileWriter.<>c::<TryLoadFromBackups>b__5_0(string)  // token 0x06000CD2 rva 0xb168 attrs Assembly, HideBySig
    // code size 2 (0x2), max stack 8
    IL_0000: ldarg.1
    IL_0001: ret

