// ===== KB.FogRTS.Runtime.FogOfWarManager  (token 0x0200000C) =====
  .method KB.FogRTS.Runtime.FogOfWarManager::set_Instance(KB.FogRTS.Runtime.FogOfWarManager)  // token 0x06000047 rva 0x321c attrs Private, Static, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld FogOfWarManager KB.FogRTS.Runtime.FogOfWarManager::<Instance>k__BackingField  /*0x04000054*/
    IL_0006: ret

  .method KB.FogRTS.Runtime.FogOfWarManager::get_Instance()  // token 0x06000048 rva 0x3224 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld FogOfWarManager KB.FogRTS.Runtime.FogOfWarManager::<Instance>k__BackingField  /*0x04000054*/
    IL_0005: ret

  .method KB.FogRTS.Runtime.FogOfWarManager::RefreshThisFrame()  // token 0x06000049 rva 0x322b attrs Public, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: call float UnityEngine.Time::get_time()  /*0x0A00006E*/
    IL_0006: stfld float KB.FogRTS.Runtime.FogOfWarManager::nextRefreshTime  /*0x04000052*/
    IL_000b: ret

  .method KB.FogRTS.Runtime.FogOfWarManager::GetDataToSave()  // token 0x0600004A rva 0x3238 attrs Public, HideBySig
    // code size 257 (0x101), max stack 5, init locals
    .locals ([0] Texture2D, [1] RenderTexture, [2] NativeArray<ushort>, [3] List<Vector2Int>, [4] bool, [5] int, [6] int)
    IL_0000: ldarg.0
    IL_0001: ldflda Vector2Int KB.FogRTS.Runtime.FogOfWarManager::textureSize  /*0x04000049*/
    IL_0006: call int UnityEngine.Vector2Int::get_x()  /*0x0A000064*/
    IL_000b: ldarg.0
    IL_000c: ldflda Vector2Int KB.FogRTS.Runtime.FogOfWarManager::textureSize  /*0x04000049*/
    IL_0011: call int UnityEngine.Vector2Int::get_y()  /*0x0A000066*/
    IL_0016: ldc.i4.6
    IL_0017: ldc.i4.0
    IL_0018: newobj void UnityEngine.Texture2D::.ctor(int,int,UnityEngine.Experimental.Rendering.GraphicsFormat,UnityEngine.Experimental.Rendering.TextureCreationFlags)  /*0x0A000093*/
    IL_001d: stloc.0
    IL_001e: call RenderTexture UnityEngine.RenderTexture::get_active()  /*0x0A000094*/
    IL_0023: stloc.1
    IL_0024: ldarg.0
    IL_0025: ldfld RTHandle KB.FogRTS.Runtime.FogOfWarManager::fogMask  /*0x04000051*/
    IL_002a: call RenderTexture UnityEngine.Rendering.RTHandle::op_Implicit(UnityEngine.Rendering.RTHandle)  /*0x0A000095*/
    IL_002f: call void UnityEngine.RenderTexture::set_active(UnityEngine.RenderTexture)  /*0x0A000096*/
    IL_0034: ldloc.0
    IL_0035: ldc.r4 0f
    IL_003a: ldc.r4 0f
    IL_003f: ldarg.0
    IL_0040: ldflda Vector2Int KB.FogRTS.Runtime.FogOfWarManager::textureSize  /*0x04000049*/
    IL_0045: call int UnityEngine.Vector2Int::get_x()  /*0x0A000064*/
    IL_004a: conv.r4
    IL_004b: ldarg.0
    IL_004c: ldflda Vector2Int KB.FogRTS.Runtime.FogOfWarManager::textureSize  /*0x04000049*/
    IL_0051: call int UnityEngine.Vector2Int::get_y()  /*0x0A000066*/
    IL_0056: conv.r4
    IL_0057: newobj void UnityEngine.Rect::.ctor(float,float,float,float)  /*0x0A000097*/
    IL_005c: ldc.i4.0
    IL_005d: ldc.i4.0
    IL_005e: callvirt void UnityEngine.Texture2D::ReadPixels(UnityEngine.Rect,int,int)  /*0x0A000098*/
    IL_0063: ldloc.0
    IL_0064: callvirt void UnityEngine.Texture2D::Apply()  /*0x0A000099*/
    IL_0069: ldloc.1
    IL_006a: call void UnityEngine.RenderTexture::set_active(UnityEngine.RenderTexture)  /*0x0A000096*/
    IL_006f: ldloc.0
    IL_0070: callvirt NativeArray<!!0> UnityEngine.Texture2D::GetRawTextureData()<ushort>  /*0x2B000008*/
    IL_0075: stloc.2
    IL_0076: newobj void System.Collections.Generic.List<UnityEngine.Vector2Int>::.ctor()  /*0x0A00009B*/
    IL_007b: stloc.3
    IL_007c: ldloca.s 2
    IL_007e: ldc.i4.0
    IL_007f: call !0 Unity.Collections.NativeArray<ushort>::get_Item(int)  /*0x0A00009C*/
    IL_0084: ldc.i4.0
    IL_0085: cgt
    IL_0087: stloc.s 4
    IL_0089: ldc.i4.0
    IL_008a: stloc.s 5
    IL_008c: ldc.i4.1
    IL_008d: stloc.s 6
    IL_008f: br.s IL_00d1
    IL_0091: ldloc.s 4
    IL_0093: brfalse.s IL_00b4
    IL_0095: ldloca.s 2
    IL_0097: ldloc.s 6
    IL_0099: call !0 Unity.Collections.NativeArray<ushort>::get_Item(int)  /*0x0A00009C*/
    IL_009e: brtrue.s IL_00b4
    IL_00a0: ldloc.3
    IL_00a1: ldloc.s 5
    IL_00a3: ldloc.s 6
    IL_00a5: newobj void UnityEngine.Vector2Int::.ctor(int,int)  /*0x0A00009D*/
    IL_00aa: callvirt void System.Collections.Generic.List<UnityEngine.Vector2Int>::Add(!0)  /*0x0A00009E*/
    IL_00af: ldc.i4.0
    IL_00b0: stloc.s 4
    IL_00b2: br.s IL_00cb
    IL_00b4: ldloc.s 4
    IL_00b6: brtrue.s IL_00cb
    IL_00b8: ldloca.s 2
    IL_00ba: ldloc.s 6
    IL_00bc: call !0 Unity.Collections.NativeArray<ushort>::get_Item(int)  /*0x0A00009C*/
    IL_00c1: ldc.i4.0
    IL_00c2: ble.s IL_00cb
    IL_00c4: ldloc.s 6
    IL_00c6: stloc.s 5
    IL_00c8: ldc.i4.1
    IL_00c9: stloc.s 4
    IL_00cb: ldloc.s 6
    IL_00cd: ldc.i4.1
    IL_00ce: add
    IL_00cf: stloc.s 6
    IL_00d1: ldloc.s 6
    IL_00d3: ldloca.s 2
    IL_00d5: call int Unity.Collections.NativeArray<ushort>::get_Length()  /*0x0A00009F*/
    IL_00da: blt.s IL_0091
    IL_00dc: ldloc.s 4
    IL_00de: brfalse.s IL_00f4
    IL_00e0: ldloc.3
    IL_00e1: ldloc.s 5
    IL_00e3: ldloca.s 2
    IL_00e5: call int Unity.Collections.NativeArray<ushort>::get_Length()  /*0x0A00009F*/
    IL_00ea: newobj void UnityEngine.Vector2Int::.ctor(int,int)  /*0x0A00009D*/
    IL_00ef: callvirt void System.Collections.Generic.List<UnityEngine.Vector2Int>::Add(!0)  /*0x0A00009E*/
    IL_00f4: ldloc.0
    IL_00f5: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A0000A0*/
    IL_00fa: ldloc.3
    IL_00fb: callvirt !0[] System.Collections.Generic.List<UnityEngine.Vector2Int>::ToArray()  /*0x0A0000A1*/
    IL_0100: ret

  .method KB.FogRTS.Runtime.FogOfWarManager::Load(UnityEngine.Vector2Int[])  // token 0x0600004B rva 0x3348 attrs Public, HideBySig
    // code size 252 (0xfc), max stack 5, init locals
    .locals ([0] Texture2D, [1] Color32[], [2] Vector2Int[], [3] int, [4] Vector2Int, [5] int)
    IL_0000: ldarg.0
    IL_0001: ldflda Vector2Int KB.FogRTS.Runtime.FogOfWarManager::textureSize  /*0x04000049*/
    IL_0006: call int UnityEngine.Vector2Int::get_x()  /*0x0A000064*/
    IL_000b: ldarg.0
    IL_000c: ldflda Vector2Int KB.FogRTS.Runtime.FogOfWarManager::textureSize  /*0x04000049*/
    IL_0011: call int UnityEngine.Vector2Int::get_y()  /*0x0A000066*/
    IL_0016: ldc.i4.5
    IL_0017: ldc.i4.0
    IL_0018: newobj void UnityEngine.Texture2D::.ctor(int,int,UnityEngine.Experimental.Rendering.GraphicsFormat,UnityEngine.Experimental.Rendering.TextureCreationFlags)  /*0x0A000093*/
    IL_001d: stloc.0
    IL_001e: ldarg.0
    IL_001f: ldflda Vector2Int KB.FogRTS.Runtime.FogOfWarManager::textureSize  /*0x04000049*/
    IL_0024: call int UnityEngine.Vector2Int::get_x()  /*0x0A000064*/
    IL_0029: ldarg.0
    IL_002a: ldflda Vector2Int KB.FogRTS.Runtime.FogOfWarManager::textureSize  /*0x04000049*/
    IL_002f: call int UnityEngine.Vector2Int::get_y()  /*0x0A000066*/
    IL_0034: mul
    IL_0035: newarr UnityEngine.Color32  /*0x0100003A*/
    IL_003a: stloc.1
    IL_003b: ldarg.1
    IL_003c: stloc.2
    IL_003d: ldc.i4.0
    IL_003e: stloc.3
    IL_003f: br.s IL_007c
    IL_0041: ldloc.2
    IL_0042: ldloc.3
    IL_0043: ldelem UnityEngine.Vector2Int  /*0x01000024*/
    IL_0048: stloc.s 4
    IL_004a: ldloca.s 4
    IL_004c: call int UnityEngine.Vector2Int::get_x()  /*0x0A000064*/
    IL_0051: stloc.s 5
    IL_0053: br.s IL_006d
    IL_0055: ldloc.1
    IL_0056: ldloc.s 5
    IL_0058: call Color UnityEngine.Color::get_grey()  /*0x0A0000A2*/
    IL_005d: call Color32 UnityEngine.Color32::op_Implicit(UnityEngine.Color)  /*0x0A0000A3*/
    IL_0062: stelem UnityEngine.Color32  /*0x0100003A*/
    IL_0067: ldloc.s 5
    IL_0069: ldc.i4.1
    IL_006a: add
    IL_006b: stloc.s 5
    IL_006d: ldloc.s 5
    IL_006f: ldloca.s 4
    IL_0071: call int UnityEngine.Vector2Int::get_y()  /*0x0A000066*/
    IL_0076: blt.s IL_0055
    IL_0078: ldloc.3
    IL_0079: ldc.i4.1
    IL_007a: add
    IL_007b: stloc.3
    IL_007c: ldloc.3
    IL_007d: ldloc.2
    IL_007e: ldlen
    IL_007f: conv.i4
    IL_0080: blt.s IL_0041
    IL_0082: ldloc.0
    IL_0083: ldloc.1
    IL_0084: callvirt void UnityEngine.Texture2D::SetPixels32(UnityEngine.Color32[])  /*0x0A0000A4*/
    IL_0089: ldloc.0
    IL_008a: callvirt void UnityEngine.Texture2D::Apply()  /*0x0A000099*/
    IL_008f: call ComputeShader KB.FogRTS.Runtime.FogResources::GetLoadFog()  /*0x0600005A*/
    IL_0094: ldc.i4.0
    IL_0095: ldstr "Input"
    IL_009a: ldloc.0
    IL_009b: callvirt void UnityEngine.ComputeShader::SetTexture(int,string,UnityEngine.Texture)  /*0x0A000067*/
    IL_00a0: call ComputeShader KB.FogRTS.Runtime.FogResources::GetLoadFog()  /*0x0600005A*/
    IL_00a5: ldc.i4.0
    IL_00a6: ldstr "Output"
    IL_00ab: ldarg.0
    IL_00ac: ldfld RTHandle KB.FogRTS.Runtime.FogOfWarManager::fogMask  /*0x04000051*/
    IL_00b1: call Texture UnityEngine.Rendering.RTHandle::op_Implicit(UnityEngine.Rendering.RTHandle)  /*0x0A000068*/
    IL_00b6: callvirt void UnityEngine.ComputeShader::SetTexture(int,string,UnityEngine.Texture)  /*0x0A000067*/
    IL_00bb: call ComputeShader KB.FogRTS.Runtime.FogResources::GetLoadFog()  /*0x0600005A*/
    IL_00c0: ldc.i4.0
    IL_00c1: ldarg.0
    IL_00c2: ldflda Vector2Int KB.FogRTS.Runtime.FogOfWarManager::textureSize  /*0x04000049*/
    IL_00c7: call int UnityEngine.Vector2Int::get_x()  /*0x0A000064*/
    IL_00cc: conv.r4
    IL_00cd: ldc.r4 8f
    IL_00d2: div
    IL_00d3: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000065*/
    IL_00d8: ldarg.0
    IL_00d9: ldflda Vector2Int KB.FogRTS.Runtime.FogOfWarManager::textureSize  /*0x04000049*/
    IL_00de: call int UnityEngine.Vector2Int::get_y()  /*0x0A000066*/
    IL_00e3: conv.r4
    IL_00e4: ldc.r4 8f
    IL_00e9: div
    IL_00ea: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000065*/
    IL_00ef: ldc.i4.1
    IL_00f0: callvirt void UnityEngine.ComputeShader::Dispatch(int,int,int,int)  /*0x0A0000A5*/
    IL_00f5: ldloc.0
    IL_00f6: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A0000A0*/
    IL_00fb: ret

  .method KB.FogRTS.Runtime.FogOfWarManager::Awake()  // token 0x0600004C rva 0x3450 attrs Private, HideBySig
    // code size 38 (0x26), max stack 8
    IL_0000: call FogOfWarManager KB.FogRTS.Runtime.FogOfWarManager::get_Instance()  /*0x06000048*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000082*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A0000A6*/
    IL_0013: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A0000A0*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: call void KB.FogRTS.Runtime.FogOfWarManager::set_Instance(KB.FogRTS.Runtime.FogOfWarManager)  /*0x06000047*/
    IL_001f: ldarg.0
    IL_0020: call void KB.FogRTS.Runtime.FogOfWarManager::Init()  /*0x06000052*/
    IL_0025: ret

  .method KB.FogRTS.Runtime.FogOfWarManager::OnEnable()  // token 0x0600004D rva 0x3477 attrs Private, HideBySig
    // code size 61 (0x3d), max stack 8
    IL_0000: call FogOfWarManager KB.FogRTS.Runtime.FogOfWarManager::get_Instance()  /*0x06000048*/
    IL_0005: ldarg.0
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000082*/
    IL_000b: brfalse.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: ldfld DrawVisionPass KB.FogRTS.Runtime.FogOfWarManager::drawVisionPass  /*0x0400004E*/
    IL_0014: callvirt void KB.FogRTS.Runtime.DrawVisionPass::Enable()  /*0x06000034*/
    IL_0019: ldarg.0
    IL_001a: ldfld float KB.FogRTS.Runtime.FogOfWarManager::blurStrength  /*0x04000047*/
    IL_001f: ldc.r4 0f
    IL_0024: ble.un.s IL_0031
    IL_0026: ldarg.0
    IL_0027: ldfld BlurPass KB.FogRTS.Runtime.FogOfWarManager::blurPass  /*0x0400004F*/
    IL_002c: callvirt void KB.FogRTS.Runtime.BlurPass::Enable()  /*0x0600002D*/
    IL_0031: ldarg.0
    IL_0032: ldfld ScreenEffectPass KB.FogRTS.Runtime.FogOfWarManager::screenEffectPass  /*0x04000050*/
    IL_0037: callvirt void KB.FogRTS.Runtime.ScreenEffectPass::Enable()  /*0x0600003A*/
    IL_003c: ret

  .method KB.FogRTS.Runtime.FogOfWarManager::OnDisable()  // token 0x0600004E rva 0x34b8 attrs Private, HideBySig
    // code size 66 (0x42), max stack 2, init locals
    IL_0000: call FogOfWarManager KB.FogRTS.Runtime.FogOfWarManager::get_Instance()  /*0x06000048*/
    IL_0005: ldarg.0
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000082*/
    IL_000b: brfalse.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: ldfld DrawVisionPass KB.FogRTS.Runtime.FogOfWarManager::drawVisionPass  /*0x0400004E*/
    IL_0014: callvirt void KB.FogRTS.Runtime.DrawVisionPass::Disable()  /*0x06000035*/
    IL_0019: ldarg.0
    IL_001a: ldfld float KB.FogRTS.Runtime.FogOfWarManager::blurStrength  /*0x04000047*/
    IL_001f: ldc.r4 0f
    IL_0024: ble.un.s IL_0031
    IL_0026: ldarg.0
    IL_0027: ldfld BlurPass KB.FogRTS.Runtime.FogOfWarManager::blurPass  /*0x0400004F*/
    IL_002c: callvirt void KB.FogRTS.Runtime.BlurPass::Disable()  /*0x0600002E*/
    IL_0031: ldarg.0
    IL_0032: ldfld ScreenEffectPass KB.FogRTS.Runtime.FogOfWarManager::screenEffectPass  /*0x04000050*/
    IL_0037: callvirt void KB.FogRTS.Runtime.ScreenEffectPass::Disable()  /*0x0600003B*/
    IL_003c: call void KB.FogRTS.Runtime.CheckPointContainer::NotifyDetectionSkipped()  /*0x06000010*/
    IL_0041: ret

  .method KB.FogRTS.Runtime.FogOfWarManager::Update()  // token 0x0600004F rva 0x3508 attrs Private, HideBySig
    // code size 32 (0x20), max stack 2, init locals
    .locals ([0] JobHandle)
    IL_0000: call float UnityEngine.Time::get_time()  /*0x0A00006E*/
    IL_0005: ldarg.0
    IL_0006: ldfld float KB.FogRTS.Runtime.FogOfWarManager::nextRefreshTime  /*0x04000052*/
    IL_000b: blt.un.s IL_001f
    IL_000d: call JobHandle KB.FogRTS.Runtime.VisionContainer::ScheduleJob()  /*0x06000025*/
    IL_0012: stloc.0
    IL_0013: ldarg.0
    IL_0014: ldloc.0
    IL_0015: call JobHandle KB.FogRTS.Runtime.CheckPointContainer::ScheduleJob(Unity.Jobs.JobHandle)  /*0x0600000E*/
    IL_001a: stfld JobHandle KB.FogRTS.Runtime.FogOfWarManager::jobsChain  /*0x04000053*/
    IL_001f: ret

  .method KB.FogRTS.Runtime.FogOfWarManager::LateUpdate()  // token 0x06000050 rva 0x3534 attrs Private, HideBySig
    // code size 114 (0x72), max stack 3, init locals
    IL_0000: call float UnityEngine.Time::get_time()  /*0x0A00006E*/
    IL_0005: ldarg.0
    IL_0006: ldfld float KB.FogRTS.Runtime.FogOfWarManager::nextRefreshTime  /*0x04000052*/
    IL_000b: blt.un.s IL_0067
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld float KB.FogRTS.Runtime.FogOfWarManager::nextRefreshTime  /*0x04000052*/
    IL_0014: ldarg.0
    IL_0015: ldfld bool KB.FogRTS.Runtime.FogOfWarManager::manualRefresh  /*0x0400004C*/
    IL_001a: brtrue.s IL_0024
    IL_001c: ldarg.0
    IL_001d: ldfld float KB.FogRTS.Runtime.FogOfWarManager::refreshRate  /*0x0400004D*/
    IL_0022: br.s IL_0029
    IL_0024: ldc.r4 Infinityf
    IL_0029: add
    IL_002a: stfld float KB.FogRTS.Runtime.FogOfWarManager::nextRefreshTime  /*0x04000052*/
    IL_002f: ldarg.0
    IL_0030: ldflda JobHandle KB.FogRTS.Runtime.FogOfWarManager::jobsChain  /*0x04000053*/
    IL_0035: call void Unity.Jobs.JobHandle::Complete()  /*0x0A0000A7*/
    IL_003a: call void KB.FogRTS.Runtime.VisionContainer::UpdateVisionPositionsInShader()  /*0x06000026*/
    IL_003f: call void KB.FogRTS.Runtime.CheckPointContainer::PerformObjectDetection()  /*0x0600000F*/
    IL_0044: ldarg.0
    IL_0045: ldfld DrawVisionPass KB.FogRTS.Runtime.FogOfWarManager::drawVisionPass  /*0x0400004E*/
    IL_004a: callvirt void KB.FogRTS.Runtime.DrawVisionPass::MarkForExecution()  /*0x06000033*/
    IL_004f: ldarg.0
    IL_0050: ldfld float KB.FogRTS.Runtime.FogOfWarManager::blurStrength  /*0x04000047*/
    IL_0055: ldc.r4 0f
    IL_005a: ble.un.s IL_0067
    IL_005c: ldarg.0
    IL_005d: ldfld BlurPass KB.FogRTS.Runtime.FogOfWarManager::blurPass  /*0x0400004F*/
    IL_0062: callvirt void KB.FogRTS.Runtime.BlurPass::MarkForExecution()  /*0x0600002C*/
    IL_0067: call float UnityEngine.Time::get_deltaTime()  /*0x0A0000A8*/
    IL_006c: call void KB.FogRTS.Runtime.FaderContainer::UpdateFaders(float)  /*0x06000017*/
    IL_0071: ret

  .method KB.FogRTS.Runtime.FogOfWarManager::OnDestroy()  // token 0x06000051 rva 0x35b2 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void KB.FogRTS.Runtime.FogOfWarManager::Dispose()  /*0x06000053*/
    IL_0006: ret

  .method KB.FogRTS.Runtime.FogOfWarManager::Init()  // token 0x06000052 rva 0x35bc attrs Private, HideBySig
    // code size 239 (0xef), max stack 10, init locals
    .locals ([0] RTHandle)
    IL_0000: ldarg.0
    IL_0001: ldfld bool KB.FogRTS.Runtime.FogOfWarManager::manualRefresh  /*0x0400004C*/
    IL_0006: brfalse.s IL_0013
    IL_0008: ldarg.0
    IL_0009: ldc.r4 Infinityf
    IL_000e: stfld float KB.FogRTS.Runtime.FogOfWarManager::nextRefreshTime  /*0x04000052*/
    IL_0013: ldarg.0
    IL_0014: ldfld int KB.FogRTS.Runtime.FogOfWarManager::maxVisions  /*0x0400004A*/
    IL_0019: ldarg.0
    IL_001a: ldfld bool KB.FogRTS.Runtime.FogOfWarManager::orientationXZ  /*0x0400003C*/
    IL_001f: call void KB.FogRTS.Runtime.VisionContainer::Init(int,bool)  /*0x06000021*/
    IL_0024: ldarg.0
    IL_0025: ldfld int KB.FogRTS.Runtime.FogOfWarManager::maxCheckPoints  /*0x0400004B*/
    IL_002a: ldarg.0
    IL_002b: ldfld bool KB.FogRTS.Runtime.FogOfWarManager::orientationXZ  /*0x0400003C*/
    IL_0030: call void KB.FogRTS.Runtime.CheckPointContainer::Init(int,bool)  /*0x0600000B*/
    IL_0035: ldarg.0
    IL_0036: ldarg.0
    IL_0037: ldfld DrawVisionPass KB.FogRTS.Runtime.FogOfWarManager::drawVisionPass  /*0x0400004E*/
    IL_003c: ldarg.0
    IL_003d: ldfld Vector4 KB.FogRTS.Runtime.FogOfWarManager::mapSizeLeftRightBotTop  /*0x0400003D*/
    IL_0042: ldarg.0
    IL_0043: ldfld Vector2Int KB.FogRTS.Runtime.FogOfWarManager::textureSize  /*0x04000049*/
    IL_0048: ldarg.0
    IL_0049: ldfld float KB.FogRTS.Runtime.FogOfWarManager::fadeInDuration  /*0x04000044*/
    IL_004e: ldarg.0
    IL_004f: ldfld float KB.FogRTS.Runtime.FogOfWarManager::fadeOutDuration  /*0x04000045*/
    IL_0054: ldarg.0
    IL_0055: ldfld Texture KB.FogRTS.Runtime.FogOfWarManager::layers  /*0x04000048*/
    IL_005a: ldnull
    IL_005b: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A00003A*/
    IL_0060: brtrue.s IL_006a
    IL_0062: ldarg.0
    IL_0063: ldfld Texture KB.FogRTS.Runtime.FogOfWarManager::layers  /*0x04000048*/
    IL_0068: br.s IL_006f
    IL_006a: call Texture2D UnityEngine.Texture2D::get_whiteTexture()  /*0x0A000083*/
    IL_006f: callvirt RTHandle KB.FogRTS.Runtime.DrawVisionPass::Init(UnityEngine.Vector4,UnityEngine.Vector2Int,float,float,UnityEngine.Texture)  /*0x06000032*/
    IL_0074: stfld RTHandle KB.FogRTS.Runtime.FogOfWarManager::fogMask  /*0x04000051*/
    IL_0079: ldarg.0
    IL_007a: ldfld float KB.FogRTS.Runtime.FogOfWarManager::blurStrength  /*0x04000047*/
    IL_007f: ldc.r4 0f
    IL_0084: bgt.s IL_008e
    IL_0086: ldarg.0
    IL_0087: ldfld RTHandle KB.FogRTS.Runtime.FogOfWarManager::fogMask  /*0x04000051*/
    IL_008c: br.s IL_00b1
    IL_008e: ldarg.0
    IL_008f: ldfld BlurPass KB.FogRTS.Runtime.FogOfWarManager::blurPass  /*0x0400004F*/
    IL_0094: ldarg.0
    IL_0095: ldfld float KB.FogRTS.Runtime.FogOfWarManager::blurStrength  /*0x04000047*/
    IL_009a: ldarg.0
    IL_009b: ldfld Vector2Int KB.FogRTS.Runtime.FogOfWarManager::textureSize  /*0x04000049*/
    IL_00a0: ldarg.0
    IL_00a1: ldfld FilterMode KB.FogRTS.Runtime.FogOfWarManager::filterMode  /*0x04000046*/
    IL_00a6: ldarg.0
    IL_00a7: ldfld RTHandle KB.FogRTS.Runtime.FogOfWarManager::fogMask  /*0x04000051*/
    IL_00ac: callvirt RTHandle KB.FogRTS.Runtime.BlurPass::Init(float,UnityEngine.Vector2Int,UnityEngine.FilterMode,UnityEngine.Rendering.RTHandle)  /*0x0600002B*/
    IL_00b1: stloc.0
    IL_00b2: ldarg.0
    IL_00b3: ldfld ScreenEffectPass KB.FogRTS.Runtime.FogOfWarManager::screenEffectPass  /*0x04000050*/
    IL_00b8: ldarg.0
    IL_00b9: ldfld FogOfWarManager.InjectionPoint KB.FogRTS.Runtime.FogOfWarManager::injectionPoint  /*0x0400003F*/
    IL_00be: ldarg.0
    IL_00bf: ldfld Camera KB.FogRTS.Runtime.FogOfWarManager::targetCamera  /*0x0400003E*/
    IL_00c4: ldarg.0
    IL_00c5: ldfld Vector4 KB.FogRTS.Runtime.FogOfWarManager::mapSizeLeftRightBotTop  /*0x0400003D*/
    IL_00ca: ldarg.0
    IL_00cb: ldfld bool KB.FogRTS.Runtime.FogOfWarManager::orientationXZ  /*0x0400003C*/
    IL_00d0: ldloc.0
    IL_00d1: ldarg.0
    IL_00d2: ldfld Texture KB.FogRTS.Runtime.FogOfWarManager::fogTexture  /*0x04000040*/
    IL_00d7: ldarg.0
    IL_00d8: ldfld Color KB.FogRTS.Runtime.FogOfWarManager::fogColor  /*0x04000041*/
    IL_00dd: ldarg.0
    IL_00de: ldfld Texture KB.FogRTS.Runtime.FogOfWarManager::exploredFog  /*0x04000042*/
    IL_00e3: ldarg.0
    IL_00e4: ldfld Color KB.FogRTS.Runtime.FogOfWarManager::exploredFogColor  /*0x04000043*/
    IL_00e9: callvirt void KB.FogRTS.Runtime.ScreenEffectPass::Init(UnityEngine.Rendering.Universal.RenderPassEvent,UnityEngine.Camera,UnityEngine.Vector4,bool,UnityEngine.Rendering.RTHandle,UnityEngine.Texture,UnityEngine.Color,UnityEngine.Texture,UnityEngine.Color)  /*0x06000039*/
    IL_00ee: ret

  .method KB.FogRTS.Runtime.FogOfWarManager::Dispose()  // token 0x06000053 rva 0x36b7 attrs Private, HideBySig
    // code size 50 (0x32), max stack 8
    IL_0000: call FogOfWarManager KB.FogRTS.Runtime.FogOfWarManager::get_Instance()  /*0x06000048*/
    IL_0005: ldarg.0
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000082*/
    IL_000b: brfalse.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: ldfld DrawVisionPass KB.FogRTS.Runtime.FogOfWarManager::drawVisionPass  /*0x0400004E*/
    IL_0014: callvirt void KB.FogRTS.Runtime.DrawVisionPass::Dispose()  /*0x06000036*/
    IL_0019: ldarg.0
    IL_001a: ldfld float KB.FogRTS.Runtime.FogOfWarManager::blurStrength  /*0x04000047*/
    IL_001f: ldc.r4 0f
    IL_0024: ble.un.s IL_0031
    IL_0026: ldarg.0
    IL_0027: ldfld BlurPass KB.FogRTS.Runtime.FogOfWarManager::blurPass  /*0x0400004F*/
    IL_002c: callvirt void KB.FogRTS.Runtime.BlurPass::Dispose()  /*0x0600002F*/
    IL_0031: ret

  .method KB.FogRTS.Runtime.FogOfWarManager::.ctor()  // token 0x06000054 rva 0x36ec attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 228 (0xe4), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool KB.FogRTS.Runtime.FogOfWarManager::orientationXZ  /*0x0400003C*/
    IL_0007: ldarg.0
    IL_0008: ldc.r4 -5f
    IL_000d: ldc.r4 5f
    IL_0012: ldc.r4 -5f
    IL_0017: ldc.r4 5f
    IL_001c: newobj void UnityEngine.Vector4::.ctor(float,float,float,float)  /*0x0A00007F*/
    IL_0021: stfld Vector4 KB.FogRTS.Runtime.FogOfWarManager::mapSizeLeftRightBotTop  /*0x0400003D*/
    IL_0026: ldarg.0
    IL_0027: ldc.i4 600
    IL_002c: stfld FogOfWarManager.InjectionPoint KB.FogRTS.Runtime.FogOfWarManager::injectionPoint  /*0x0400003F*/
    IL_0031: ldarg.0
    IL_0032: ldc.r4 1f
    IL_0037: ldc.r4 1f
    IL_003c: ldc.r4 1f
    IL_0041: ldc.r4 1f
    IL_0046: newobj void UnityEngine.Color::.ctor(float,float,float,float)  /*0x0A0000A9*/
    IL_004b: stfld Color KB.FogRTS.Runtime.FogOfWarManager::fogColor  /*0x04000041*/
    IL_0050: ldarg.0
    IL_0051: ldc.r4 0.5f
    IL_0056: ldc.r4 0.5f
    IL_005b: ldc.r4 0.5f
    IL_0060: ldc.r4 0.5f
    IL_0065: newobj void UnityEngine.Color::.ctor(float,float,float,float)  /*0x0A0000A9*/
    IL_006a: stfld Color KB.FogRTS.Runtime.FogOfWarManager::exploredFogColor  /*0x04000043*/
    IL_006f: ldarg.0
    IL_0070: ldc.r4 0.2f
    IL_0075: stfld float KB.FogRTS.Runtime.FogOfWarManager::fadeInDuration  /*0x04000044*/
    IL_007a: ldarg.0
    IL_007b: ldc.r4 0.2f
    IL_0080: stfld float KB.FogRTS.Runtime.FogOfWarManager::fadeOutDuration  /*0x04000045*/
    IL_0085: ldarg.0
    IL_0086: ldc.i4.1
    IL_0087: stfld FilterMode KB.FogRTS.Runtime.FogOfWarManager::filterMode  /*0x04000046*/
    IL_008c: ldarg.0
    IL_008d: ldc.r4 3f
    IL_0092: stfld float KB.FogRTS.Runtime.FogOfWarManager::blurStrength  /*0x04000047*/
    IL_0097: ldarg.0
    IL_0098: ldc.i4 1024
    IL_009d: ldc.i4 1024
    IL_00a2: newobj void UnityEngine.Vector2Int::.ctor(int,int)  /*0x0A00009D*/
    IL_00a7: stfld Vector2Int KB.FogRTS.Runtime.FogOfWarManager::textureSize  /*0x04000049*/
    IL_00ac: ldarg.0
    IL_00ad: ldc.i4.s 100
    IL_00af: stfld int KB.FogRTS.Runtime.FogOfWarManager::maxVisions  /*0x0400004A*/
    IL_00b4: ldarg.0
    IL_00b5: ldc.i4.s 100
    IL_00b7: stfld int KB.FogRTS.Runtime.FogOfWarManager::maxCheckPoints  /*0x0400004B*/
    IL_00bc: ldarg.0
    IL_00bd: newobj void KB.FogRTS.Runtime.DrawVisionPass::.ctor()  /*0x06000038*/
    IL_00c2: stfld DrawVisionPass KB.FogRTS.Runtime.FogOfWarManager::drawVisionPass  /*0x0400004E*/
    IL_00c7: ldarg.0
    IL_00c8: newobj void KB.FogRTS.Runtime.BlurPass::.ctor()  /*0x06000031*/
    IL_00cd: stfld BlurPass KB.FogRTS.Runtime.FogOfWarManager::blurPass  /*0x0400004F*/
    IL_00d2: ldarg.0
    IL_00d3: newobj void KB.FogRTS.Runtime.ScreenEffectPass::.ctor()  /*0x0600003E*/
    IL_00d8: stfld ScreenEffectPass KB.FogRTS.Runtime.FogOfWarManager::screenEffectPass  /*0x04000050*/
    IL_00dd: ldarg.0
    IL_00de: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000092*/
    IL_00e3: ret

// ===== KB.FogRTS.Runtime.FogOfWarManager/InjectionPoint  (token 0x0200001C) =====
