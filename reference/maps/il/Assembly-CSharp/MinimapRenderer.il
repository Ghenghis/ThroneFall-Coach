// ===== MinimapRenderer  (token 0x020001F8) =====
  .method MinimapRenderer::Awake()  // token 0x06000A72 rva 0x31445 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld MinimapRenderer MinimapRenderer::instance  /*0x04000D34*/
    IL_0006: ret

  .method MinimapRenderer::Start()  // token 0x06000A73 rva 0x31450 attrs Public, HideBySig
    // code size 250 (0xfa), max stack 5, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float MinimapRenderer::playerCircleRadius  /*0x04000D37*/
    IL_0007: ldarg.0
    IL_0008: ldfld RenderTexture MinimapRenderer::renderTexture  /*0x04000D35*/
    IL_000d: callvirt int UnityEngine.Texture::get_width()  /*0x0A00048E*/
    IL_0012: conv.r4
    IL_0013: ldc.r4 512f
    IL_0018: div
    IL_0019: mul
    IL_001a: stfld float MinimapRenderer::playerCircleRadius  /*0x04000D37*/
    IL_001f: ldarg.0
    IL_0020: ldarg.0
    IL_0021: ldfld float MinimapRenderer::enemyCircleRadius  /*0x04000D38*/
    IL_0026: ldarg.0
    IL_0027: ldfld RenderTexture MinimapRenderer::renderTexture  /*0x04000D35*/
    IL_002c: callvirt int UnityEngine.Texture::get_width()  /*0x0A00048E*/
    IL_0031: conv.r4
    IL_0032: ldc.r4 512f
    IL_0037: div
    IL_0038: mul
    IL_0039: stfld float MinimapRenderer::enemyCircleRadius  /*0x04000D38*/
    IL_003e: ldarg.0
    IL_003f: ldarg.0
    IL_0040: ldfld float MinimapRenderer::allyCircleRadius  /*0x04000D39*/
    IL_0045: ldarg.0
    IL_0046: ldfld RenderTexture MinimapRenderer::renderTexture  /*0x04000D35*/
    IL_004b: callvirt int UnityEngine.Texture::get_width()  /*0x0A00048E*/
    IL_0050: conv.r4
    IL_0051: ldc.r4 512f
    IL_0056: div
    IL_0057: mul
    IL_0058: stfld float MinimapRenderer::allyCircleRadius  /*0x04000D39*/
    IL_005d: ldarg.0
    IL_005e: ldfld Material MinimapRenderer::matBackground  /*0x04000D3D*/
    IL_0063: ldarg.0
    IL_0064: ldfld Color MinimapRenderer::backgroundColor  /*0x04000D3B*/
    IL_0069: callvirt void UnityEngine.Material::set_color(UnityEngine.Color)  /*0x0A00048F*/
    IL_006e: ldarg.0
    IL_006f: ldarg.0
    IL_0070: ldarg.0
    IL_0071: ldfld Camera MinimapRenderer::virtualCamera  /*0x04000D3A*/
    IL_0076: callvirt Matrix4x4 UnityEngine.Camera::get_projectionMatrix()  /*0x0A000490*/
    IL_007b: ldarg.0
    IL_007c: ldfld Camera MinimapRenderer::virtualCamera  /*0x04000D3A*/
    IL_0081: callvirt Matrix4x4 UnityEngine.Camera::get_worldToCameraMatrix()  /*0x0A000491*/
    IL_0086: call Matrix4x4 UnityEngine.Matrix4x4::op_Multiply(UnityEngine.Matrix4x4,UnityEngine.Matrix4x4)  /*0x0A000492*/
    IL_008b: ldarg.0
    IL_008c: ldfld RenderTexture MinimapRenderer::renderTexture  /*0x04000D35*/
    IL_0091: callvirt int UnityEngine.Texture::get_width()  /*0x0A00048E*/
    IL_0096: ldarg.0
    IL_0097: ldfld RenderTexture MinimapRenderer::renderTexture  /*0x04000D35*/
    IL_009c: callvirt int UnityEngine.Texture::get_height()  /*0x0A000493*/
    IL_00a1: call Matrix4x4 MinimapRenderer::GetScreenSpaceMatrix(UnityEngine.Matrix4x4,int,int)  /*0x06000A77*/
    IL_00a6: stfld Matrix4x4 MinimapRenderer::worldToRenderTextureMatrix  /*0x04000D45*/
    IL_00ab: ldc.i4.0
    IL_00ac: stloc.0
    IL_00ad: br.s IL_00e4
    IL_00af: ldarg.0
    IL_00b0: ldfld List<float> MinimapRenderer::cosValues  /*0x04000D47*/
    IL_00b5: ldloc.0
    IL_00b6: conv.r4
    IL_00b7: ldc.r4 0.017453292f
    IL_00bc: mul
    IL_00bd: call float UnityEngine.Mathf::Cos(float)  /*0x0A0001BF*/
    IL_00c2: callvirt void System.Collections.Generic.List<float>::Add(!0)  /*0x0A000309*/
    IL_00c7: ldarg.0
    IL_00c8: ldfld List<float> MinimapRenderer::sinValues  /*0x04000D48*/
    IL_00cd: ldloc.0
    IL_00ce: conv.r4
    IL_00cf: ldc.r4 0.017453292f
    IL_00d4: mul
    IL_00d5: call float UnityEngine.Mathf::Sin(float)  /*0x0A0000AB*/
    IL_00da: callvirt void System.Collections.Generic.List<float>::Add(!0)  /*0x0A000309*/
    IL_00df: ldloc.0
    IL_00e0: ldc.i4.s 30
    IL_00e2: add
    IL_00e3: stloc.0
    IL_00e4: ldloc.0
    IL_00e5: ldc.i4 360
    IL_00ea: blt.s IL_00af
    IL_00ec: ldarg.0
    IL_00ed: ldarg.0
    IL_00ee: call IEnumerator MinimapRenderer::PeriodicallyUpdateMinimap()  /*0x06000A84*/
    IL_00f3: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_00f8: pop
    IL_00f9: ret

  .method MinimapRenderer::DrawCircle(float,float,float)  // token 0x06000A74 rva 0x31558 attrs Private, HideBySig
    // code size 146 (0x92), max stack 4, init locals
    .locals ([0] int, [1] int, [2] float, [3] float, [4] float)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_0080
    IL_0004: ldloc.0
    IL_0005: ldc.i4.1
    IL_0006: add
    IL_0007: ldarg.0
    IL_0008: ldfld List<float> MinimapRenderer::cosValues  /*0x04000D47*/
    IL_000d: callvirt int System.Collections.Generic.List<float>::get_Count()  /*0x0A000494*/
    IL_0012: rem
    IL_0013: stloc.1
    IL_0014: ldarg.0
    IL_0015: ldfld List<float> MinimapRenderer::cosValues  /*0x04000D47*/
    IL_001a: ldloc.0
    IL_001b: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0020: ldarg.3
    IL_0021: mul
    IL_0022: ldarg.1
    IL_0023: add
    IL_0024: stloc.2
    IL_0025: ldarg.0
    IL_0026: ldfld List<float> MinimapRenderer::sinValues  /*0x04000D48*/
    IL_002b: ldloc.0
    IL_002c: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0031: ldarg.3
    IL_0032: mul
    IL_0033: ldarg.2
    IL_0034: add
    IL_0035: stloc.3
    IL_0036: ldarg.0
    IL_0037: ldfld List<float> MinimapRenderer::cosValues  /*0x04000D47*/
    IL_003c: ldloc.1
    IL_003d: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0042: ldarg.3
    IL_0043: mul
    IL_0044: ldarg.1
    IL_0045: add
    IL_0046: ldarg.0
    IL_0047: ldfld List<float> MinimapRenderer::sinValues  /*0x04000D48*/
    IL_004c: ldloc.1
    IL_004d: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0052: ldarg.3
    IL_0053: mul
    IL_0054: ldarg.2
    IL_0055: add
    IL_0056: stloc.s 4
    IL_0058: ldarg.1
    IL_0059: ldarg.2
    IL_005a: ldc.r4 0f
    IL_005f: call void UnityEngine.GL::Vertex3(float,float,float)  /*0x0A000495*/
    IL_0064: ldloc.2
    IL_0065: ldloc.3
    IL_0066: ldc.r4 0f
    IL_006b: call void UnityEngine.GL::Vertex3(float,float,float)  /*0x0A000495*/
    IL_0070: ldloc.s 4
    IL_0072: ldc.r4 0f
    IL_0077: call void UnityEngine.GL::Vertex3(float,float,float)  /*0x0A000495*/
    IL_007c: ldloc.0
    IL_007d: ldc.i4.1
    IL_007e: add
    IL_007f: stloc.0
    IL_0080: ldloc.0
    IL_0081: ldarg.0
    IL_0082: ldfld List<float> MinimapRenderer::cosValues  /*0x04000D47*/
    IL_0087: callvirt int System.Collections.Generic.List<float>::get_Count()  /*0x0A000494*/
    IL_008c: blt IL_0004
    IL_0091: ret

  .method MinimapRenderer::RenderBackground()  // token 0x06000A75 rva 0x315f8 attrs Private, HideBySig
    // code size 155 (0x9b), max stack 7, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld RenderTexture MinimapRenderer::backgroundRenderTexture  /*0x04000D46*/
    IL_0006: call void UnityEngine.RenderTexture::set_active(UnityEngine.RenderTexture)  /*0x0A000496*/
    IL_000b: ldc.i4.1
    IL_000c: ldc.i4.1
    IL_000d: ldarg.0
    IL_000e: ldfld Color MinimapRenderer::backgroundColor  /*0x04000D3B*/
    IL_0013: call void UnityEngine.GL::Clear(bool,bool,UnityEngine.Color)  /*0x0A000497*/
    IL_0018: ldnull
    IL_0019: call void UnityEngine.RenderTexture::set_active(UnityEngine.RenderTexture)  /*0x0A000496*/
    IL_001e: ldarg.0
    IL_001f: ldfld RenderTexture MinimapRenderer::renderTexture  /*0x04000D35*/
    IL_0024: call void UnityEngine.RenderTexture::set_active(UnityEngine.RenderTexture)  /*0x0A000496*/
    IL_0029: ldc.i4.1
    IL_002a: ldc.i4.1
    IL_002b: ldarg.0
    IL_002c: ldfld Color MinimapRenderer::backgroundColor  /*0x04000D3B*/
    IL_0031: call void UnityEngine.GL::Clear(bool,bool,UnityEngine.Color)  /*0x0A000497*/
    IL_0036: ldnull
    IL_0037: call void UnityEngine.RenderTexture::set_active(UnityEngine.RenderTexture)  /*0x0A000496*/
    IL_003c: ldarg.0
    IL_003d: ldarg.0
    IL_003e: ldfld Mesh MinimapRenderer::navMesh  /*0x04000D44*/
    IL_0043: ldarg.0
    IL_0044: ldfld Material MinimapRenderer::matShadows  /*0x04000D43*/
    IL_0049: ldarg.0
    IL_004a: ldfld RenderTexture MinimapRenderer::backgroundRenderTexture  /*0x04000D46*/
    IL_004f: ldarg.0
    IL_0050: ldfld RenderTexture MinimapRenderer::renderTexture  /*0x04000D35*/
    IL_0055: callvirt int UnityEngine.Texture::get_width()  /*0x0A00048E*/
    IL_005a: conv.r4
    IL_005b: ldc.r4 0.01f
    IL_0060: mul
    IL_0061: ldarg.0
    IL_0062: ldfld RenderTexture MinimapRenderer::renderTexture  /*0x04000D35*/
    IL_0067: callvirt int UnityEngine.Texture::get_width()  /*0x0A00048E*/
    IL_006c: conv.r4
    IL_006d: ldc.r4 0.01f
    IL_0072: mul
    IL_0073: call void MinimapRenderer::RenderMesh(UnityEngine.Mesh,UnityEngine.Material,UnityEngine.RenderTexture,float,float)  /*0x06000A7A*/
    IL_0078: ldarg.0
    IL_0079: ldarg.0
    IL_007a: ldfld Mesh MinimapRenderer::navMesh  /*0x04000D44*/
    IL_007f: ldarg.0
    IL_0080: ldfld Material MinimapRenderer::matTerrain  /*0x04000D40*/
    IL_0085: ldarg.0
    IL_0086: ldfld RenderTexture MinimapRenderer::backgroundRenderTexture  /*0x04000D46*/
    IL_008b: ldc.r4 0f
    IL_0090: ldc.r4 0f
    IL_0095: call void MinimapRenderer::RenderMesh(UnityEngine.Mesh,UnityEngine.Material,UnityEngine.RenderTexture,float,float)  /*0x06000A7A*/
    IL_009a: ret

  .method MinimapRenderer::GenerateGroundMesh()  // token 0x06000A76 rva 0x316a0 attrs Private, HideBySig
    // code size 221 (0xdd), max stack 3, init locals
    .locals ([0] Mesh, [1] List<GraphNode>, [2] List<Vector3>, [3] List<int>, [4] List.Enumerator<GraphNode>, [5] TriangleMeshNode, [6] int)
    IL_0000: newobj void UnityEngine.Mesh::.ctor()  /*0x0A000498*/
    IL_0005: stloc.0
    IL_0006: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_000b: callvirt NavGraph[] AstarPath::get_graphs()  /*0x0A000499*/
    IL_0010: ldc.i4.0
    IL_0011: ldelem.ref
    IL_0012: newobj void System.Collections.Generic.List<Pathfinding.GraphNode>::.ctor()  /*0x0A00049A*/
    IL_0017: stloc.1
    IL_0018: ldloc.1
    IL_0019: dup
    IL_001a: ldvirtftn void System.Collections.Generic.List<Pathfinding.GraphNode>::Add(!0)  /*0x0A00049B*/
    IL_0020: newobj void System.Action<Pathfinding.GraphNode>::.ctor(object,IntPtr)  /*0x0A00049C*/
    IL_0025: callvirt void Pathfinding.NavGraph::GetNodes(System.Action<Pathfinding.GraphNode>)  /*0x0A00049D*/
    IL_002a: newobj void System.Collections.Generic.List<UnityEngine.Vector3>::.ctor()  /*0x0A00029A*/
    IL_002f: stloc.2
    IL_0030: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0035: stloc.3
    IL_0036: ldloc.1
    IL_0037: callvirt List.Enumerator<!0> System.Collections.Generic.List<Pathfinding.GraphNode>::GetEnumerator()  /*0x0A00049E*/
    IL_003c: stloc.s 4
    IL_003e: br.s IL_00ad
    IL_0040: ldloca.s 4
    IL_0042: call !0 System.Collections.Generic.List.Enumerator<Pathfinding.GraphNode>::get_Current()  /*0x0A00049F*/
    IL_0047: castclass Pathfinding.TriangleMeshNode  /*0x010000F3*/
    IL_004c: stloc.s 5
    IL_004e: ldloc.2
    IL_004f: ldloc.s 5
    IL_0051: ldc.i4.0
    IL_0052: callvirt Int3 Pathfinding.MeshNode::GetVertex(int)  /*0x0A0004A0*/
    IL_0057: call Vector3 Pathfinding.Int3::op_Explicit(Pathfinding.Int3)  /*0x0A0004A1*/
    IL_005c: callvirt void System.Collections.Generic.List<UnityEngine.Vector3>::Add(!0)  /*0x0A00029C*/
    IL_0061: ldloc.2
    IL_0062: ldloc.s 5
    IL_0064: ldc.i4.1
    IL_0065: callvirt Int3 Pathfinding.MeshNode::GetVertex(int)  /*0x0A0004A0*/
    IL_006a: call Vector3 Pathfinding.Int3::op_Explicit(Pathfinding.Int3)  /*0x0A0004A1*/
    IL_006f: callvirt void System.Collections.Generic.List<UnityEngine.Vector3>::Add(!0)  /*0x0A00029C*/
    IL_0074: ldloc.2
    IL_0075: ldloc.s 5
    IL_0077: ldc.i4.2
    IL_0078: callvirt Int3 Pathfinding.MeshNode::GetVertex(int)  /*0x0A0004A0*/
    IL_007d: call Vector3 Pathfinding.Int3::op_Explicit(Pathfinding.Int3)  /*0x0A0004A1*/
    IL_0082: callvirt void System.Collections.Generic.List<UnityEngine.Vector3>::Add(!0)  /*0x0A00029C*/
    IL_0087: ldloc.2
    IL_0088: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_008d: ldc.i4.3
    IL_008e: sub
    IL_008f: stloc.s 6
    IL_0091: ldloc.3
    IL_0092: ldloc.s 6
    IL_0094: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0099: ldloc.3
    IL_009a: ldloc.s 6
    IL_009c: ldc.i4.1
    IL_009d: add
    IL_009e: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_00a3: ldloc.3
    IL_00a4: ldloc.s 6
    IL_00a6: ldc.i4.2
    IL_00a7: add
    IL_00a8: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_00ad: ldloca.s 4
    IL_00af: call bool System.Collections.Generic.List.Enumerator<Pathfinding.GraphNode>::MoveNext()  /*0x0A0004A3*/
    IL_00b4: brtrue.s IL_0040
    IL_00b6: leave.s IL_00c6
    IL_00b8: ldloca.s 4
    IL_00ba: constrained. System.Collections.Generic.List.Enumerator<Pathfinding.GraphNode>  /*0x1B0000D8*/
    IL_00c0: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00c5: endfinally
    IL_00c6: ldloc.0
    IL_00c7: ldloc.2
    IL_00c8: callvirt void UnityEngine.Mesh::SetVertices(System.Collections.Generic.List<UnityEngine.Vector3>)  /*0x0A0004A4*/
    IL_00cd: ldloc.0
    IL_00ce: ldloc.3
    IL_00cf: ldc.i4.0
    IL_00d0: callvirt void UnityEngine.Mesh::SetTriangles(System.Collections.Generic.List<int>,int)  /*0x0A0004A5*/
    IL_00d5: ldloc.0
    IL_00d6: callvirt void UnityEngine.Mesh::RecalculateNormals()  /*0x0A0004A6*/
    IL_00db: ldloc.0
    IL_00dc: ret
    .try IL_003e-IL_00b8 finally handler IL_00b8-IL_00c6

  .method MinimapRenderer::GetScreenSpaceMatrix(UnityEngine.Matrix4x4,int,int)  // token 0x06000A77 rva 0x3179c attrs Private, HideBySig
    // code size 75 (0x4b), max stack 3, init locals
    .locals ([0] Matrix4x4)
    IL_0000: call Matrix4x4 UnityEngine.Matrix4x4::get_identity()  /*0x0A000414*/
    IL_0005: stloc.0
    IL_0006: ldloca.s 0
    IL_0008: ldarg.2
    IL_0009: conv.r4
    IL_000a: ldc.r4 2f
    IL_000f: div
    IL_0010: stfld float UnityEngine.Matrix4x4::m00  /*0x0A0004A7*/
    IL_0015: ldloca.s 0
    IL_0017: ldarg.3
    IL_0018: neg
    IL_0019: conv.r4
    IL_001a: ldc.r4 2f
    IL_001f: div
    IL_0020: stfld float UnityEngine.Matrix4x4::m11  /*0x0A0004A8*/
    IL_0025: ldloca.s 0
    IL_0027: ldarg.2
    IL_0028: conv.r4
    IL_0029: ldc.r4 2f
    IL_002e: div
    IL_002f: stfld float UnityEngine.Matrix4x4::m03  /*0x0A0004A9*/
    IL_0034: ldloca.s 0
    IL_0036: ldarg.3
    IL_0037: conv.r4
    IL_0038: ldc.r4 2f
    IL_003d: div
    IL_003e: stfld float UnityEngine.Matrix4x4::m13  /*0x0A0004AA*/
    IL_0043: ldloc.0
    IL_0044: ldarg.1
    IL_0045: call Matrix4x4 UnityEngine.Matrix4x4::op_Multiply(UnityEngine.Matrix4x4,UnityEngine.Matrix4x4)  /*0x0A000492*/
    IL_004a: ret

  .method MinimapRenderer::DrawPlayer()  // token 0x06000A78 rva 0x317f4 attrs Private, HideBySig
    // code size 99 (0x63), max stack 5, init locals
    .locals ([0] Vector3, [1] Vector4)
    IL_0000: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_0005: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000f: stloc.0
    IL_0010: ldarg.0
    IL_0011: ldfld Matrix4x4 MinimapRenderer::worldToRenderTextureMatrix  /*0x04000D45*/
    IL_0016: ldloc.0
    IL_0017: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_001c: ldloc.0
    IL_001d: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0022: ldloc.0
    IL_0023: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0028: ldc.r4 1f
    IL_002d: newobj void UnityEngine.Vector4::.ctor(float,float,float,float)  /*0x0A0004AB*/
    IL_0032: call Vector4 UnityEngine.Matrix4x4::op_Multiply(UnityEngine.Matrix4x4,UnityEngine.Vector4)  /*0x0A0004AC*/
    IL_0037: stloc.1
    IL_0038: ldarg.0
    IL_0039: ldarg.0
    IL_003a: ldfld Material MinimapRenderer::matPlayer  /*0x04000D3F*/
    IL_003f: call void MinimapRenderer::StartTrianglesDrawCall(UnityEngine.Material)  /*0x06000A7C*/
    IL_0044: ldarg.0
    IL_0045: ldloc.1
    IL_0046: ldfld float UnityEngine.Vector4::x  /*0x0A0004AD*/
    IL_004b: ldloc.1
    IL_004c: ldfld float UnityEngine.Vector4::y  /*0x0A0004AE*/
    IL_0051: ldarg.0
    IL_0052: ldfld float MinimapRenderer::playerCircleRadius  /*0x04000D37*/
    IL_0057: call void MinimapRenderer::DrawCircle(float,float,float)  /*0x06000A74*/
    IL_005c: ldarg.0
    IL_005d: call void MinimapRenderer::EndTrianglesDrawCall()  /*0x06000A7D*/
    IL_0062: ret

  .method MinimapRenderer::DrawEnemies()  // token 0x06000A79 rva 0x31864 attrs Private, HideBySig
    // code size 157 (0x9d), max stack 5, init locals
    .locals ([0] List.Enumerator<TaggedObject>, [1] Vector3, [2] Vector4)
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: ldarg.0
    IL_0006: ldfld List<TaggedObject> MinimapRenderer::enemies  /*0x04000D49*/
    IL_000b: ldc.i4.1
    IL_000c: callvirt void TagManager::FindAllTaggedObjectsWithTag(System.Collections.Generic.List<TaggedObject>,TagManager.ETag)  /*0x06000E5C*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: ldfld Material MinimapRenderer::matEnemies  /*0x04000D3E*/
    IL_0018: call void MinimapRenderer::StartTrianglesDrawCall(UnityEngine.Material)  /*0x06000A7C*/
    IL_001d: ldarg.0
    IL_001e: ldfld List<TaggedObject> MinimapRenderer::enemies  /*0x04000D49*/
    IL_0023: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0028: stloc.0
    IL_0029: br.s IL_007d
    IL_002b: ldloca.s 0
    IL_002d: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_0032: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0037: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_003c: stloc.1
    IL_003d: ldarg.0
    IL_003e: ldfld Matrix4x4 MinimapRenderer::worldToRenderTextureMatrix  /*0x04000D45*/
    IL_0043: ldloc.1
    IL_0044: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0049: ldloc.1
    IL_004a: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_004f: ldloc.1
    IL_0050: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0055: ldc.r4 1f
    IL_005a: newobj void UnityEngine.Vector4::.ctor(float,float,float,float)  /*0x0A0004AB*/
    IL_005f: call Vector4 UnityEngine.Matrix4x4::op_Multiply(UnityEngine.Matrix4x4,UnityEngine.Vector4)  /*0x0A0004AC*/
    IL_0064: stloc.2
    IL_0065: ldarg.0
    IL_0066: ldloc.2
    IL_0067: ldfld float UnityEngine.Vector4::x  /*0x0A0004AD*/
    IL_006c: ldloc.2
    IL_006d: ldfld float UnityEngine.Vector4::y  /*0x0A0004AE*/
    IL_0072: ldarg.0
    IL_0073: ldfld float MinimapRenderer::enemyCircleRadius  /*0x04000D38*/
    IL_0078: call void MinimapRenderer::DrawCircle(float,float,float)  /*0x06000A74*/
    IL_007d: ldloca.s 0
    IL_007f: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0084: brtrue.s IL_002b
    IL_0086: leave.s IL_0096
    IL_0088: ldloca.s 0
    IL_008a: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0090: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0095: endfinally
    IL_0096: ldarg.0
    IL_0097: call void MinimapRenderer::EndTrianglesDrawCall()  /*0x06000A7D*/
    IL_009c: ret
    .try IL_0029-IL_0088 finally handler IL_0088-IL_0096

  .method MinimapRenderer::RenderMesh(UnityEngine.Mesh,UnityEngine.Material,UnityEngine.RenderTexture,float,float)  // token 0x06000A7A rva 0x31920 attrs Private, HideBySig
    // code size 466 (0x1d2), max stack 5, init locals
    .locals ([0] Vector3[], [1] int[], [2] Vector3, [3] Vector3, [4] Vector3, [5] Vector4, [6] Vector2, [7] Vector2, [8] Vector2, [9] int)
    IL_0000: ldarg.1
    IL_0001: callvirt Vector3[] UnityEngine.Mesh::get_vertices()  /*0x0A0004AF*/
    IL_0006: stloc.0
    IL_0007: ldarg.1
    IL_0008: callvirt int[] UnityEngine.Mesh::get_triangles()  /*0x0A0004B0*/
    IL_000d: stloc.1
    IL_000e: ldarg.3
    IL_000f: call void UnityEngine.RenderTexture::set_active(UnityEngine.RenderTexture)  /*0x0A000496*/
    IL_0014: call void UnityEngine.GL::PushMatrix()  /*0x0A0004B1*/
    IL_0019: ldc.r4 0f
    IL_001e: ldarg.3
    IL_001f: callvirt int UnityEngine.Texture::get_width()  /*0x0A00048E*/
    IL_0024: conv.r4
    IL_0025: ldarg.3
    IL_0026: callvirt int UnityEngine.Texture::get_height()  /*0x0A000493*/
    IL_002b: conv.r4
    IL_002c: ldc.r4 0f
    IL_0031: call void UnityEngine.GL::LoadPixelMatrix(float,float,float,float)  /*0x0A0004B2*/
    IL_0036: ldarg.2
    IL_0037: ldc.i4.0
    IL_0038: callvirt bool UnityEngine.Material::SetPass(int)  /*0x0A0004B3*/
    IL_003d: pop
    IL_003e: ldc.i4.4
    IL_003f: call void UnityEngine.GL::Begin(int)  /*0x0A0004B4*/
    IL_0044: call Vector4 UnityEngine.Vector4::get_zero()  /*0x0A0004B5*/
    IL_0049: stloc.s 5
    IL_004b: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0004B6*/
    IL_0050: stloc.s 6
    IL_0052: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0004B6*/
    IL_0057: stloc.s 7
    IL_0059: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0004B6*/
    IL_005e: stloc.s 8
    IL_0060: ldc.i4.0
    IL_0061: stloc.s 9
    IL_0063: br IL_01b7
    IL_0068: ldloc.0
    IL_0069: ldloc.1
    IL_006a: ldloc.s 9
    IL_006c: ldelem.i4
    IL_006d: ldelem UnityEngine.Vector3  /*0x01000028*/
    IL_0072: stloc.2
    IL_0073: ldloc.0
    IL_0074: ldloc.1
    IL_0075: ldloc.s 9
    IL_0077: ldc.i4.1
    IL_0078: add
    IL_0079: ldelem.i4
    IL_007a: ldelem UnityEngine.Vector3  /*0x01000028*/
    IL_007f: stloc.3
    IL_0080: ldloc.0
    IL_0081: ldloc.1
    IL_0082: ldloc.s 9
    IL_0084: ldc.i4.2
    IL_0085: add
    IL_0086: ldelem.i4
    IL_0087: ldelem UnityEngine.Vector3  /*0x01000028*/
    IL_008c: stloc.s 4
    IL_008e: ldloca.s 5
    IL_0090: ldloc.2
    IL_0091: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0096: ldloc.2
    IL_0097: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_009c: ldloc.2
    IL_009d: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_00a2: ldc.r4 1f
    IL_00a7: call void UnityEngine.Vector4::Set(float,float,float,float)  /*0x0A0004B7*/
    IL_00ac: ldarg.0
    IL_00ad: ldfld Matrix4x4 MinimapRenderer::worldToRenderTextureMatrix  /*0x04000D45*/
    IL_00b2: ldloc.s 5
    IL_00b4: call Vector4 UnityEngine.Matrix4x4::op_Multiply(UnityEngine.Matrix4x4,UnityEngine.Vector4)  /*0x0A0004AC*/
    IL_00b9: stloc.s 5
    IL_00bb: ldloca.s 6
    IL_00bd: ldloc.s 5
    IL_00bf: ldfld float UnityEngine.Vector4::x  /*0x0A0004AD*/
    IL_00c4: ldloc.s 5
    IL_00c6: ldfld float UnityEngine.Vector4::y  /*0x0A0004AE*/
    IL_00cb: call void UnityEngine.Vector2::Set(float,float)  /*0x0A0004B8*/
    IL_00d0: ldloca.s 5
    IL_00d2: ldloc.3
    IL_00d3: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_00d8: ldloc.3
    IL_00d9: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_00de: ldloc.3
    IL_00df: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_00e4: ldc.r4 1f
    IL_00e9: call void UnityEngine.Vector4::Set(float,float,float,float)  /*0x0A0004B7*/
    IL_00ee: ldarg.0
    IL_00ef: ldfld Matrix4x4 MinimapRenderer::worldToRenderTextureMatrix  /*0x04000D45*/
    IL_00f4: ldloc.s 5
    IL_00f6: call Vector4 UnityEngine.Matrix4x4::op_Multiply(UnityEngine.Matrix4x4,UnityEngine.Vector4)  /*0x0A0004AC*/
    IL_00fb: stloc.s 5
    IL_00fd: ldloca.s 7
    IL_00ff: ldloc.s 5
    IL_0101: ldfld float UnityEngine.Vector4::x  /*0x0A0004AD*/
    IL_0106: ldloc.s 5
    IL_0108: ldfld float UnityEngine.Vector4::y  /*0x0A0004AE*/
    IL_010d: call void UnityEngine.Vector2::Set(float,float)  /*0x0A0004B8*/
    IL_0112: ldloca.s 5
    IL_0114: ldloc.s 4
    IL_0116: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_011b: ldloc.s 4
    IL_011d: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0122: ldloc.s 4
    IL_0124: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0129: ldc.r4 1f
    IL_012e: call void UnityEngine.Vector4::Set(float,float,float,float)  /*0x0A0004B7*/
    IL_0133: ldarg.0
    IL_0134: ldfld Matrix4x4 MinimapRenderer::worldToRenderTextureMatrix  /*0x04000D45*/
    IL_0139: ldloc.s 5
    IL_013b: call Vector4 UnityEngine.Matrix4x4::op_Multiply(UnityEngine.Matrix4x4,UnityEngine.Vector4)  /*0x0A0004AC*/
    IL_0140: stloc.s 5
    IL_0142: ldloca.s 8
    IL_0144: ldloc.s 5
    IL_0146: ldfld float UnityEngine.Vector4::x  /*0x0A0004AD*/
    IL_014b: ldloc.s 5
    IL_014d: ldfld float UnityEngine.Vector4::y  /*0x0A0004AE*/
    IL_0152: call void UnityEngine.Vector2::Set(float,float)  /*0x0A0004B8*/
    IL_0157: ldloc.s 6
    IL_0159: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_015e: ldarg.s 4
    IL_0160: add
    IL_0161: ldloc.s 6
    IL_0163: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0168: ldarg.s 5
    IL_016a: add
    IL_016b: ldc.r4 0f
    IL_0170: call void UnityEngine.GL::Vertex3(float,float,float)  /*0x0A000495*/
    IL_0175: ldloc.s 7
    IL_0177: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_017c: ldarg.s 4
    IL_017e: add
    IL_017f: ldloc.s 7
    IL_0181: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0186: ldarg.s 5
    IL_0188: add
    IL_0189: ldc.r4 0f
    IL_018e: call void UnityEngine.GL::Vertex3(float,float,float)  /*0x0A000495*/
    IL_0193: ldloc.s 8
    IL_0195: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_019a: ldarg.s 4
    IL_019c: add
    IL_019d: ldloc.s 8
    IL_019f: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_01a4: ldarg.s 5
    IL_01a6: add
    IL_01a7: ldc.r4 0f
    IL_01ac: call void UnityEngine.GL::Vertex3(float,float,float)  /*0x0A000495*/
    IL_01b1: ldloc.s 9
    IL_01b3: ldc.i4.3
    IL_01b4: add
    IL_01b5: stloc.s 9
    IL_01b7: ldloc.s 9
    IL_01b9: ldloc.1
    IL_01ba: ldlen
    IL_01bb: conv.i4
    IL_01bc: blt IL_0068
    IL_01c1: call void UnityEngine.GL::End()  /*0x0A0004B9*/
    IL_01c6: call void UnityEngine.GL::PopMatrix()  /*0x0A0004BA*/
    IL_01cb: ldnull
    IL_01cc: call void UnityEngine.RenderTexture::set_active(UnityEngine.RenderTexture)  /*0x0A000496*/
    IL_01d1: ret

  .method MinimapRenderer::RenderBotOfBox(UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Quaternion)  // token 0x06000A7B rva 0x31b00 attrs Private, HideBySig
    // code size 759 (0x2f7), max stack 7, init locals
    .locals ([0] Vector3, [1] Vector4, [2] Vector2, [3] Vector2, [4] Vector2, [5] Vector2)
    IL_0000: ldarg.2
    IL_0001: ldc.r4 0.5f
    IL_0006: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_000b: stloc.0
    IL_000c: ldarg.0
    IL_000d: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_0012: ldc.i4.0
    IL_0013: ldarg.1
    IL_0014: ldarg.3
    IL_0015: ldloc.0
    IL_0016: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_001b: neg
    IL_001c: ldloc.0
    IL_001d: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0022: neg
    IL_0023: ldloc.0
    IL_0024: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0029: neg
    IL_002a: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_002f: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_0034: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0039: stelem UnityEngine.Vector3  /*0x01000028*/
    IL_003e: ldarg.0
    IL_003f: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_0044: ldc.i4.1
    IL_0045: ldarg.1
    IL_0046: ldarg.3
    IL_0047: ldloc.0
    IL_0048: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_004d: ldloc.0
    IL_004e: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0053: neg
    IL_0054: ldloc.0
    IL_0055: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_005a: neg
    IL_005b: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0060: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_0065: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_006a: stelem UnityEngine.Vector3  /*0x01000028*/
    IL_006f: ldarg.0
    IL_0070: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_0075: ldc.i4.2
    IL_0076: ldarg.1
    IL_0077: ldarg.3
    IL_0078: ldloc.0
    IL_0079: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_007e: ldloc.0
    IL_007f: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0084: neg
    IL_0085: ldloc.0
    IL_0086: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_008b: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0090: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_0095: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_009a: stelem UnityEngine.Vector3  /*0x01000028*/
    IL_009f: ldarg.0
    IL_00a0: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_00a5: ldc.i4.3
    IL_00a6: ldarg.1
    IL_00a7: ldarg.3
    IL_00a8: ldloc.0
    IL_00a9: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_00ae: neg
    IL_00af: ldloc.0
    IL_00b0: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_00b5: neg
    IL_00b6: ldloc.0
    IL_00b7: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_00bc: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_00c1: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_00c6: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00cb: stelem UnityEngine.Vector3  /*0x01000028*/
    IL_00d0: call Vector4 UnityEngine.Vector4::get_zero()  /*0x0A0004B5*/
    IL_00d5: stloc.1
    IL_00d6: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0004B6*/
    IL_00db: stloc.2
    IL_00dc: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0004B6*/
    IL_00e1: stloc.3
    IL_00e2: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0004B6*/
    IL_00e7: stloc.s 4
    IL_00e9: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0004B6*/
    IL_00ee: stloc.s 5
    IL_00f0: ldloca.s 1
    IL_00f2: ldarg.0
    IL_00f3: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_00f8: ldc.i4.0
    IL_00f9: ldelema UnityEngine.Vector3  /*0x01000028*/
    IL_00fe: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0103: ldarg.0
    IL_0104: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_0109: ldc.i4.0
    IL_010a: ldelema UnityEngine.Vector3  /*0x01000028*/
    IL_010f: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0114: ldarg.0
    IL_0115: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_011a: ldc.i4.0
    IL_011b: ldelema UnityEngine.Vector3  /*0x01000028*/
    IL_0120: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0125: ldc.r4 1f
    IL_012a: call void UnityEngine.Vector4::Set(float,float,float,float)  /*0x0A0004B7*/
    IL_012f: ldarg.0
    IL_0130: ldfld Matrix4x4 MinimapRenderer::worldToRenderTextureMatrix  /*0x04000D45*/
    IL_0135: ldloc.1
    IL_0136: call Vector4 UnityEngine.Matrix4x4::op_Multiply(UnityEngine.Matrix4x4,UnityEngine.Vector4)  /*0x0A0004AC*/
    IL_013b: stloc.1
    IL_013c: ldloca.s 2
    IL_013e: ldloc.1
    IL_013f: ldfld float UnityEngine.Vector4::x  /*0x0A0004AD*/
    IL_0144: ldloc.1
    IL_0145: ldfld float UnityEngine.Vector4::y  /*0x0A0004AE*/
    IL_014a: call void UnityEngine.Vector2::Set(float,float)  /*0x0A0004B8*/
    IL_014f: ldloca.s 1
    IL_0151: ldarg.0
    IL_0152: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_0157: ldc.i4.1
    IL_0158: ldelema UnityEngine.Vector3  /*0x01000028*/
    IL_015d: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0162: ldarg.0
    IL_0163: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_0168: ldc.i4.1
    IL_0169: ldelema UnityEngine.Vector3  /*0x01000028*/
    IL_016e: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0173: ldarg.0
    IL_0174: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_0179: ldc.i4.1
    IL_017a: ldelema UnityEngine.Vector3  /*0x01000028*/
    IL_017f: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0184: ldc.r4 1f
    IL_0189: call void UnityEngine.Vector4::Set(float,float,float,float)  /*0x0A0004B7*/
    IL_018e: ldarg.0
    IL_018f: ldfld Matrix4x4 MinimapRenderer::worldToRenderTextureMatrix  /*0x04000D45*/
    IL_0194: ldloc.1
    IL_0195: call Vector4 UnityEngine.Matrix4x4::op_Multiply(UnityEngine.Matrix4x4,UnityEngine.Vector4)  /*0x0A0004AC*/
    IL_019a: stloc.1
    IL_019b: ldloca.s 3
    IL_019d: ldloc.1
    IL_019e: ldfld float UnityEngine.Vector4::x  /*0x0A0004AD*/
    IL_01a3: ldloc.1
    IL_01a4: ldfld float UnityEngine.Vector4::y  /*0x0A0004AE*/
    IL_01a9: call void UnityEngine.Vector2::Set(float,float)  /*0x0A0004B8*/
    IL_01ae: ldloca.s 1
    IL_01b0: ldarg.0
    IL_01b1: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_01b6: ldc.i4.2
    IL_01b7: ldelema UnityEngine.Vector3  /*0x01000028*/
    IL_01bc: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_01c1: ldarg.0
    IL_01c2: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_01c7: ldc.i4.2
    IL_01c8: ldelema UnityEngine.Vector3  /*0x01000028*/
    IL_01cd: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_01d2: ldarg.0
    IL_01d3: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_01d8: ldc.i4.2
    IL_01d9: ldelema UnityEngine.Vector3  /*0x01000028*/
    IL_01de: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_01e3: ldc.r4 1f
    IL_01e8: call void UnityEngine.Vector4::Set(float,float,float,float)  /*0x0A0004B7*/
    IL_01ed: ldarg.0
    IL_01ee: ldfld Matrix4x4 MinimapRenderer::worldToRenderTextureMatrix  /*0x04000D45*/
    IL_01f3: ldloc.1
    IL_01f4: call Vector4 UnityEngine.Matrix4x4::op_Multiply(UnityEngine.Matrix4x4,UnityEngine.Vector4)  /*0x0A0004AC*/
    IL_01f9: stloc.1
    IL_01fa: ldloca.s 4
    IL_01fc: ldloc.1
    IL_01fd: ldfld float UnityEngine.Vector4::x  /*0x0A0004AD*/
    IL_0202: ldloc.1
    IL_0203: ldfld float UnityEngine.Vector4::y  /*0x0A0004AE*/
    IL_0208: call void UnityEngine.Vector2::Set(float,float)  /*0x0A0004B8*/
    IL_020d: ldloca.s 1
    IL_020f: ldarg.0
    IL_0210: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_0215: ldc.i4.3
    IL_0216: ldelema UnityEngine.Vector3  /*0x01000028*/
    IL_021b: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0220: ldarg.0
    IL_0221: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_0226: ldc.i4.3
    IL_0227: ldelema UnityEngine.Vector3  /*0x01000028*/
    IL_022c: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0231: ldarg.0
    IL_0232: ldfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_0237: ldc.i4.3
    IL_0238: ldelema UnityEngine.Vector3  /*0x01000028*/
    IL_023d: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0242: ldc.r4 1f
    IL_0247: call void UnityEngine.Vector4::Set(float,float,float,float)  /*0x0A0004B7*/
    IL_024c: ldarg.0
    IL_024d: ldfld Matrix4x4 MinimapRenderer::worldToRenderTextureMatrix  /*0x04000D45*/
    IL_0252: ldloc.1
    IL_0253: call Vector4 UnityEngine.Matrix4x4::op_Multiply(UnityEngine.Matrix4x4,UnityEngine.Vector4)  /*0x0A0004AC*/
    IL_0258: stloc.1
    IL_0259: ldloca.s 5
    IL_025b: ldloc.1
    IL_025c: ldfld float UnityEngine.Vector4::x  /*0x0A0004AD*/
    IL_0261: ldloc.1
    IL_0262: ldfld float UnityEngine.Vector4::y  /*0x0A0004AE*/
    IL_0267: call void UnityEngine.Vector2::Set(float,float)  /*0x0A0004B8*/
    IL_026c: ldloc.s 4
    IL_026e: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0273: ldloc.s 4
    IL_0275: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_027a: ldc.r4 0f
    IL_027f: call void UnityEngine.GL::Vertex3(float,float,float)  /*0x0A000495*/
    IL_0284: ldloc.3
    IL_0285: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_028a: ldloc.3
    IL_028b: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0290: ldc.r4 0f
    IL_0295: call void UnityEngine.GL::Vertex3(float,float,float)  /*0x0A000495*/
    IL_029a: ldloc.2
    IL_029b: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_02a0: ldloc.2
    IL_02a1: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_02a6: ldc.r4 0f
    IL_02ab: call void UnityEngine.GL::Vertex3(float,float,float)  /*0x0A000495*/
    IL_02b0: ldloc.s 5
    IL_02b2: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_02b7: ldloc.s 5
    IL_02b9: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_02be: ldc.r4 0f
    IL_02c3: call void UnityEngine.GL::Vertex3(float,float,float)  /*0x0A000495*/
    IL_02c8: ldloc.s 4
    IL_02ca: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_02cf: ldloc.s 4
    IL_02d1: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_02d6: ldc.r4 0f
    IL_02db: call void UnityEngine.GL::Vertex3(float,float,float)  /*0x0A000495*/
    IL_02e0: ldloc.2
    IL_02e1: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_02e6: ldloc.2
    IL_02e7: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_02ec: ldc.r4 0f
    IL_02f1: call void UnityEngine.GL::Vertex3(float,float,float)  /*0x0A000495*/
    IL_02f6: ret

  .method MinimapRenderer::StartTrianglesDrawCall(UnityEngine.Material)  // token 0x06000A7C rva 0x31e04 attrs Private, HideBySig
    // code size 70 (0x46), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld RenderTexture MinimapRenderer::renderTexture  /*0x04000D35*/
    IL_0006: call void UnityEngine.RenderTexture::set_active(UnityEngine.RenderTexture)  /*0x0A000496*/
    IL_000b: call void UnityEngine.GL::PushMatrix()  /*0x0A0004B1*/
    IL_0010: ldc.r4 0f
    IL_0015: ldarg.0
    IL_0016: ldfld RenderTexture MinimapRenderer::renderTexture  /*0x04000D35*/
    IL_001b: callvirt int UnityEngine.Texture::get_width()  /*0x0A00048E*/
    IL_0020: conv.r4
    IL_0021: ldarg.0
    IL_0022: ldfld RenderTexture MinimapRenderer::renderTexture  /*0x04000D35*/
    IL_0027: callvirt int UnityEngine.Texture::get_height()  /*0x0A000493*/
    IL_002c: conv.r4
    IL_002d: ldc.r4 0f
    IL_0032: call void UnityEngine.GL::LoadPixelMatrix(float,float,float,float)  /*0x0A0004B2*/
    IL_0037: ldarg.1
    IL_0038: ldc.i4.0
    IL_0039: callvirt bool UnityEngine.Material::SetPass(int)  /*0x0A0004B3*/
    IL_003e: pop
    IL_003f: ldc.i4.4
    IL_0040: call void UnityEngine.GL::Begin(int)  /*0x0A0004B4*/
    IL_0045: ret

  .method MinimapRenderer::EndTrianglesDrawCall()  // token 0x06000A7D rva 0x31e56 attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: call void UnityEngine.GL::End()  /*0x0A0004B9*/
    IL_0005: call void UnityEngine.GL::PopMatrix()  /*0x0A0004BA*/
    IL_000a: ldnull
    IL_000b: call void UnityEngine.RenderTexture::set_active(UnityEngine.RenderTexture)  /*0x0A000496*/
    IL_0010: ret

  .method MinimapRenderer::DrawAllies(TagManager.ETag,UnityEngine.Material)  // token 0x06000A7E rva 0x31e68 attrs Private, HideBySig
    // code size 368 (0x170), max stack 5, init locals
    .locals ([0] List.Enumerator<TaggedObject>, [1] TaggedObject, [2] Vector3, [3] Vector4, [4] Collider, [5] BoxCollider, [6] Vector3, [7] Vector3, [8] Quaternion, [9] Matrix4x4)
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: ldarg.0
    IL_0006: ldfld List<TaggedObject> MinimapRenderer::allies  /*0x04000D4D*/
    IL_000b: ldarg.1
    IL_000c: callvirt void TagManager::FindAllTaggedObjectsWithTag(System.Collections.Generic.List<TaggedObject>,TagManager.ETag)  /*0x06000E5C*/
    IL_0011: ldarg.0
    IL_0012: ldfld List<TaggedObject> MinimapRenderer::allies  /*0x04000D4D*/
    IL_0017: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_001c: ldc.i4.0
    IL_001d: bgt.s IL_0020
    IL_001f: ret
    IL_0020: ldarg.0
    IL_0021: ldarg.2
    IL_0022: call void MinimapRenderer::StartTrianglesDrawCall(UnityEngine.Material)  /*0x06000A7C*/
    IL_0027: ldarg.0
    IL_0028: ldfld List<TaggedObject> MinimapRenderer::allies  /*0x04000D4D*/
    IL_002d: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0032: stloc.0
    IL_0033: br IL_014d
    IL_0038: ldloca.s 0
    IL_003a: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_003f: stloc.1
    IL_0040: ldloc.1
    IL_0041: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0046: ldc.i4.s 10
    IL_0048: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_004d: brfalse IL_014d
    IL_0052: ldloc.1
    IL_0053: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0058: ldnull
    IL_0059: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_005e: brfalse.s IL_00b1
    IL_0060: ldloc.1
    IL_0061: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0066: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_006b: stloc.2
    IL_006c: ldarg.0
    IL_006d: ldfld Matrix4x4 MinimapRenderer::worldToRenderTextureMatrix  /*0x04000D45*/
    IL_0072: ldloc.2
    IL_0073: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0078: ldloc.2
    IL_0079: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_007e: ldloc.2
    IL_007f: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0084: ldc.r4 1f
    IL_0089: newobj void UnityEngine.Vector4::.ctor(float,float,float,float)  /*0x0A0004AB*/
    IL_008e: call Vector4 UnityEngine.Matrix4x4::op_Multiply(UnityEngine.Matrix4x4,UnityEngine.Vector4)  /*0x0A0004AC*/
    IL_0093: stloc.3
    IL_0094: ldarg.0
    IL_0095: ldloc.3
    IL_0096: ldfld float UnityEngine.Vector4::x  /*0x0A0004AD*/
    IL_009b: ldloc.3
    IL_009c: ldfld float UnityEngine.Vector4::y  /*0x0A0004AE*/
    IL_00a1: ldarg.0
    IL_00a2: ldfld float MinimapRenderer::allyCircleRadius  /*0x04000D39*/
    IL_00a7: call void MinimapRenderer::DrawCircle(float,float,float)  /*0x06000A74*/
    IL_00ac: br IL_014d
    IL_00b1: ldloc.1
    IL_00b2: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_00b7: stloc.s 4
    IL_00b9: ldloc.s 4
    IL_00bb: callvirt Type System.Object::GetType()  /*0x0A0002B4*/
    IL_00c0: ldtoken UnityEngine.BoxCollider  /*0x01000056*/
    IL_00c5: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_00ca: call bool System.Type::op_Equality(System.Type,System.Type)  /*0x0A0002B6*/
    IL_00cf: brfalse.s IL_014d
    IL_00d1: ldloc.s 4
    IL_00d3: castclass UnityEngine.BoxCollider  /*0x01000056*/
    IL_00d8: stloc.s 5
    IL_00da: ldloc.s 4
    IL_00dc: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00e1: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_00e6: stloc.s 9
    IL_00e8: ldloca.s 9
    IL_00ea: ldloc.s 5
    IL_00ec: callvirt Vector3 UnityEngine.BoxCollider::get_center()  /*0x0A0004BB*/
    IL_00f1: call Vector3 UnityEngine.Matrix4x4::MultiplyPoint(UnityEngine.Vector3)  /*0x0A0000A5*/
    IL_00f6: stloc.s 6
    IL_00f8: ldloc.s 5
    IL_00fa: callvirt Vector3 UnityEngine.BoxCollider::get_size()  /*0x0A000103*/
    IL_00ff: stloc.s 7
    IL_0101: ldloca.s 7
    IL_0103: ldloc.s 7
    IL_0105: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_010a: ldarg.0
    IL_010b: ldfld float MinimapRenderer::minBuildingSize  /*0x04000D3C*/
    IL_0110: call float UnityEngine.Mathf::Max(float,float)  /*0x0A00004B*/
    IL_0115: ldloc.s 7
    IL_0117: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_011c: ldloc.s 7
    IL_011e: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0123: ldarg.0
    IL_0124: ldfld float MinimapRenderer::minBuildingSize  /*0x04000D3C*/
    IL_0129: call float UnityEngine.Mathf::Max(float,float)  /*0x0A00004B*/
    IL_012e: call void UnityEngine.Vector3::Set(float,float,float)  /*0x0A0004BC*/
    IL_0133: ldloc.s 4
    IL_0135: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_013a: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_013f: stloc.s 8
    IL_0141: ldarg.0
    IL_0142: ldloc.s 6
    IL_0144: ldloc.s 7
    IL_0146: ldloc.s 8
    IL_0148: call void MinimapRenderer::RenderBotOfBox(UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Quaternion)  /*0x06000A7B*/
    IL_014d: ldloca.s 0
    IL_014f: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0154: brtrue IL_0038
    IL_0159: leave.s IL_0169
    IL_015b: ldloca.s 0
    IL_015d: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0163: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0168: endfinally
    IL_0169: ldarg.0
    IL_016a: call void MinimapRenderer::EndTrianglesDrawCall()  /*0x06000A7D*/
    IL_016f: ret
    .try IL_0033-IL_015b finally handler IL_015b-IL_0169

  .method MinimapRenderer::Saturate(UnityEngine.Color,float)  // token 0x06000A7F rva 0x32000 attrs Private, HideBySig
    // code size 151 (0x97), max stack 5, init locals
    .locals ([0] float, [1] float, [2] float, [3] float, [4] float)
    IL_0000: ldc.i4.3
    IL_0001: newarr System.Single  /*0x01000052*/
    IL_0006: dup
    IL_0007: ldc.i4.0
    IL_0008: ldarg.1
    IL_0009: ldfld float UnityEngine.Color::r  /*0x0A00018B*/
    IL_000e: stelem.r4
    IL_000f: dup
    IL_0010: ldc.i4.1
    IL_0011: ldarg.1
    IL_0012: ldfld float UnityEngine.Color::g  /*0x0A00018C*/
    IL_0017: stelem.r4
    IL_0018: dup
    IL_0019: ldc.i4.2
    IL_001a: ldarg.1
    IL_001b: ldfld float UnityEngine.Color::b  /*0x0A00018D*/
    IL_0020: stelem.r4
    IL_0021: call float UnityEngine.Mathf::Min(float[])  /*0x0A0004BD*/
    IL_0026: stloc.0
    IL_0027: ldc.i4.4
    IL_0028: newarr System.Single  /*0x01000052*/
    IL_002d: dup
    IL_002e: ldc.i4.0
    IL_002f: ldarg.1
    IL_0030: ldfld float UnityEngine.Color::r  /*0x0A00018B*/
    IL_0035: stelem.r4
    IL_0036: dup
    IL_0037: ldc.i4.1
    IL_0038: ldarg.1
    IL_0039: ldfld float UnityEngine.Color::g  /*0x0A00018C*/
    IL_003e: stelem.r4
    IL_003f: dup
    IL_0040: ldc.i4.2
    IL_0041: ldarg.1
    IL_0042: ldfld float UnityEngine.Color::b  /*0x0A00018D*/
    IL_0047: stelem.r4
    IL_0048: dup
    IL_0049: ldc.i4.3
    IL_004a: ldloc.0
    IL_004b: ldc.r4 0.0001f
    IL_0050: add
    IL_0051: stelem.r4
    IL_0052: call float UnityEngine.Mathf::Max(float[])  /*0x0A0004BE*/
    IL_0057: stloc.1
    IL_0058: ldarg.1
    IL_0059: ldfld float UnityEngine.Color::r  /*0x0A00018B*/
    IL_005e: ldloc.0
    IL_005f: sub
    IL_0060: ldloc.1
    IL_0061: ldloc.0
    IL_0062: sub
    IL_0063: div
    IL_0064: ldloc.1
    IL_0065: mul
    IL_0066: stloc.2
    IL_0067: ldarg.1
    IL_0068: ldfld float UnityEngine.Color::g  /*0x0A00018C*/
    IL_006d: ldloc.0
    IL_006e: sub
    IL_006f: ldloc.1
    IL_0070: ldloc.0
    IL_0071: sub
    IL_0072: div
    IL_0073: ldloc.1
    IL_0074: mul
    IL_0075: stloc.3
    IL_0076: ldarg.1
    IL_0077: ldfld float UnityEngine.Color::b  /*0x0A00018D*/
    IL_007c: ldloc.0
    IL_007d: sub
    IL_007e: ldloc.1
    IL_007f: ldloc.0
    IL_0080: sub
    IL_0081: div
    IL_0082: ldloc.1
    IL_0083: mul
    IL_0084: stloc.s 4
    IL_0086: ldarg.1
    IL_0087: ldloc.2
    IL_0088: ldloc.3
    IL_0089: ldloc.s 4
    IL_008b: newobj void UnityEngine.Color::.ctor(float,float,float)  /*0x0A00018A*/
    IL_0090: ldarg.2
    IL_0091: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0096: ret

  .method MinimapRenderer::EnsureColorIsDifferentFrom(UnityEngine.Color,UnityEngine.Color,float)  // token 0x06000A80 rva 0x320a4 attrs Public, Static, HideBySig
    // code size 245 (0xf5), max stack 4, init locals
    .locals ([0] float, [1] Vector3, [2] int, [3] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call float MinimapRenderer::ColorDistance(UnityEngine.Color,UnityEngine.Color)  /*0x06000A81*/
    IL_0007: stloc.0
    IL_0008: ldloc.0
    IL_0009: ldarg.2
    IL_000a: blt.un.s IL_000e
    IL_000c: ldarg.0
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: ldfld float UnityEngine.Color::r  /*0x0A00018B*/
    IL_0014: ldarg.0
    IL_0015: ldfld float UnityEngine.Color::g  /*0x0A00018C*/
    IL_001a: ldarg.0
    IL_001b: ldfld float UnityEngine.Color::b  /*0x0A00018D*/
    IL_0020: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0025: ldarg.1
    IL_0026: ldfld float UnityEngine.Color::r  /*0x0A00018B*/
    IL_002b: ldarg.1
    IL_002c: ldfld float UnityEngine.Color::g  /*0x0A00018C*/
    IL_0031: ldarg.1
    IL_0032: ldfld float UnityEngine.Color::b  /*0x0A00018D*/
    IL_0037: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_003c: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0041: stloc.3
    IL_0042: ldloca.s 3
    IL_0044: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_0049: stloc.1
    IL_004a: ldarg.0
    IL_004b: ldarg.1
    IL_004c: call bool UnityEngine.Color::op_Equality(UnityEngine.Color,UnityEngine.Color)  /*0x0A0003B3*/
    IL_0051: brfalse.s IL_0059
    IL_0053: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0058: stloc.1
    IL_0059: ldc.i4.s 100
    IL_005b: stloc.2
    IL_005c: br IL_00ec
    IL_0061: ldarga.s 0
    IL_0063: ldflda float UnityEngine.Color::r  /*0x0A00018B*/
    IL_0068: dup
    IL_0069: ldind.r4
    IL_006a: ldloc.1
    IL_006b: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0070: ldc.r4 0.01f
    IL_0075: mul
    IL_0076: add
    IL_0077: stind.r4
    IL_0078: ldarga.s 0
    IL_007a: ldflda float UnityEngine.Color::g  /*0x0A00018C*/
    IL_007f: dup
    IL_0080: ldind.r4
    IL_0081: ldloc.1
    IL_0082: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0087: ldc.r4 0.01f
    IL_008c: mul
    IL_008d: add
    IL_008e: stind.r4
    IL_008f: ldarga.s 0
    IL_0091: ldflda float UnityEngine.Color::b  /*0x0A00018D*/
    IL_0096: dup
    IL_0097: ldind.r4
    IL_0098: ldloc.1
    IL_0099: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_009e: ldc.r4 0.01f
    IL_00a3: mul
    IL_00a4: add
    IL_00a5: stind.r4
    IL_00a6: ldarga.s 0
    IL_00a8: ldarg.0
    IL_00a9: ldfld float UnityEngine.Color::r  /*0x0A00018B*/
    IL_00ae: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_00b3: stfld float UnityEngine.Color::r  /*0x0A00018B*/
    IL_00b8: ldarga.s 0
    IL_00ba: ldarg.0
    IL_00bb: ldfld float UnityEngine.Color::g  /*0x0A00018C*/
    IL_00c0: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_00c5: stfld float UnityEngine.Color::g  /*0x0A00018C*/
    IL_00ca: ldarga.s 0
    IL_00cc: ldarg.0
    IL_00cd: ldfld float UnityEngine.Color::b  /*0x0A00018D*/
    IL_00d2: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_00d7: stfld float UnityEngine.Color::b  /*0x0A00018D*/
    IL_00dc: ldarg.0
    IL_00dd: ldarg.1
    IL_00de: call float MinimapRenderer::ColorDistance(UnityEngine.Color,UnityEngine.Color)  /*0x06000A81*/
    IL_00e3: stloc.0
    IL_00e4: ldloc.2
    IL_00e5: ldc.i4.1
    IL_00e6: sub
    IL_00e7: stloc.2
    IL_00e8: ldloc.2
    IL_00e9: ldc.i4.0
    IL_00ea: ble.s IL_00f3
    IL_00ec: ldloc.0
    IL_00ed: ldarg.2
    IL_00ee: blt IL_0061
    IL_00f3: ldarg.0
    IL_00f4: ret

  .method MinimapRenderer::ColorDistance(UnityEngine.Color,UnityEngine.Color)  // token 0x06000A81 rva 0x321a8 attrs Private, Static, HideBySig
    // code size 77 (0x4d), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld float UnityEngine.Color::r  /*0x0A00018B*/
    IL_0006: ldarg.1
    IL_0007: ldfld float UnityEngine.Color::r  /*0x0A00018B*/
    IL_000c: sub
    IL_000d: ldc.r4 2f
    IL_0012: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0017: ldarg.0
    IL_0018: ldfld float UnityEngine.Color::g  /*0x0A00018C*/
    IL_001d: ldarg.1
    IL_001e: ldfld float UnityEngine.Color::g  /*0x0A00018C*/
    IL_0023: sub
    IL_0024: ldc.r4 2f
    IL_0029: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_002e: add
    IL_002f: ldarg.0
    IL_0030: ldfld float UnityEngine.Color::b  /*0x0A00018D*/
    IL_0035: ldarg.1
    IL_0036: ldfld float UnityEngine.Color::b  /*0x0A00018D*/
    IL_003b: sub
    IL_003c: ldc.r4 2f
    IL_0041: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0046: add
    IL_0047: call float UnityEngine.Mathf::Sqrt(float)  /*0x0A000332*/
    IL_004c: ret

  .method MinimapRenderer::GrabColorsFromCurrentColorScheme()  // token 0x06000A82 rva 0x32204 attrs Private, HideBySig
    // code size 320 (0x140), max stack 5, init locals
    .locals ([0] Colorscheme)
    IL_0000: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_0005: callvirt Colorscheme ColorAndLightManager::get_CurrentColorScheme()  /*0x06000354*/
    IL_000a: stloc.0
    IL_000b: ldarg.0
    IL_000c: ldfld Material MinimapRenderer::matShadows  /*0x04000D43*/
    IL_0011: ldloc.0
    IL_0012: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0017: call Color UnityEngine.Color::get_black()  /*0x0A0004BF*/
    IL_001c: ldc.r4 0.5f
    IL_0021: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0026: callvirt void UnityEngine.Material::set_color(UnityEngine.Color)  /*0x0A00048F*/
    IL_002b: ldarg.0
    IL_002c: ldfld Material MinimapRenderer::matEnemies  /*0x04000D3E*/
    IL_0031: ldarg.0
    IL_0032: ldloc.0
    IL_0033: ldfld Color Colorscheme::enemyMidColor  /*0x0400045E*/
    IL_0038: ldloc.0
    IL_0039: ldfld Color Colorscheme::enemyLightColor  /*0x0400045D*/
    IL_003e: ldc.r4 0.5f
    IL_0043: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0048: ldc.r4 0.75f
    IL_004d: call Color MinimapRenderer::Saturate(UnityEngine.Color,float)  /*0x06000A7F*/
    IL_0052: callvirt void UnityEngine.Material::set_color(UnityEngine.Color)  /*0x0A00048F*/
    IL_0057: ldarg.0
    IL_0058: ldfld Material MinimapRenderer::matAlliesUnits  /*0x04000D41*/
    IL_005d: ldarg.0
    IL_005e: ldloc.0
    IL_005f: ldfld Color Colorscheme::allyMidColor  /*0x04000460*/
    IL_0064: ldloc.0
    IL_0065: ldfld Color Colorscheme::allyLightColor  /*0x0400045F*/
    IL_006a: ldc.r4 0.5f
    IL_006f: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0074: ldc.r4 0.75f
    IL_0079: call Color MinimapRenderer::Saturate(UnityEngine.Color,float)  /*0x06000A7F*/
    IL_007e: callvirt void UnityEngine.Material::set_color(UnityEngine.Color)  /*0x0A00048F*/
    IL_0083: ldarg.0
    IL_0084: ldfld Material MinimapRenderer::matTerrain  /*0x04000D40*/
    IL_0089: ldloc.0
    IL_008a: ldfld Color Colorscheme::groundColor  /*0x04000471*/
    IL_008f: ldloc.0
    IL_0090: ldfld Color Colorscheme::nightLightColor  /*0x0400045A*/
    IL_0095: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_009a: ldc.r4 0.1f
    IL_009f: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_00a4: call Color UnityEngine.Color::op_Multiply(UnityEngine.Color,UnityEngine.Color)  /*0x0A000192*/
    IL_00a9: callvirt void UnityEngine.Material::set_color(UnityEngine.Color)  /*0x0A00048F*/
    IL_00ae: ldarg.0
    IL_00af: ldfld Material MinimapRenderer::matAlliesBuildings  /*0x04000D42*/
    IL_00b4: ldarg.0
    IL_00b5: ldfld Material MinimapRenderer::matAlliesUnits  /*0x04000D41*/
    IL_00ba: callvirt Color UnityEngine.Material::get_color()  /*0x0A0004C0*/
    IL_00bf: ldarg.0
    IL_00c0: ldfld Material MinimapRenderer::matTerrain  /*0x04000D40*/
    IL_00c5: callvirt Color UnityEngine.Material::get_color()  /*0x0A0004C0*/
    IL_00ca: ldc.r4 0.5f
    IL_00cf: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_00d4: callvirt void UnityEngine.Material::set_color(UnityEngine.Color)  /*0x0A00048F*/
    IL_00d9: ldarg.0
    IL_00da: ldfld Material MinimapRenderer::matAlliesBuildings  /*0x04000D42*/
    IL_00df: ldarg.0
    IL_00e0: ldfld Material MinimapRenderer::matAlliesBuildings  /*0x04000D42*/
    IL_00e5: callvirt Color UnityEngine.Material::get_color()  /*0x0A0004C0*/
    IL_00ea: ldarg.0
    IL_00eb: ldfld Material MinimapRenderer::matTerrain  /*0x04000D40*/
    IL_00f0: callvirt Color UnityEngine.Material::get_color()  /*0x0A0004C0*/
    IL_00f5: ldc.r4 0.25f
    IL_00fa: call Color MinimapRenderer::EnsureColorIsDifferentFrom(UnityEngine.Color,UnityEngine.Color,float)  /*0x06000A80*/
    IL_00ff: callvirt void UnityEngine.Material::set_color(UnityEngine.Color)  /*0x0A00048F*/
    IL_0104: ldarg.0
    IL_0105: ldfld Material MinimapRenderer::matAlliesUnits  /*0x04000D41*/
    IL_010a: ldarg.0
    IL_010b: ldfld Material MinimapRenderer::matAlliesUnits  /*0x04000D41*/
    IL_0110: callvirt Color UnityEngine.Material::get_color()  /*0x0A0004C0*/
    IL_0115: ldarg.0
    IL_0116: ldfld Material MinimapRenderer::matAlliesBuildings  /*0x04000D42*/
    IL_011b: callvirt Color UnityEngine.Material::get_color()  /*0x0A0004C0*/
    IL_0120: ldc.r4 0.25f
    IL_0125: call Color MinimapRenderer::EnsureColorIsDifferentFrom(UnityEngine.Color,UnityEngine.Color,float)  /*0x06000A80*/
    IL_012a: callvirt void UnityEngine.Material::set_color(UnityEngine.Color)  /*0x0A00048F*/
    IL_012f: ldarg.0
    IL_0130: ldfld Material MinimapRenderer::matPlayer  /*0x04000D3F*/
    IL_0135: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_013a: callvirt void UnityEngine.Material::set_color(UnityEngine.Color)  /*0x0A00048F*/
    IL_013f: ret

  .method MinimapRenderer::ClearMinimap()  // token 0x06000A83 rva 0x32350 attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld RenderTexture MinimapRenderer::backgroundRenderTexture  /*0x04000D46*/
    IL_0006: ldarg.0
    IL_0007: ldfld RenderTexture MinimapRenderer::renderTexture  /*0x04000D35*/
    IL_000c: call void UnityEngine.Graphics::Blit(UnityEngine.Texture,UnityEngine.RenderTexture)  /*0x0A0004C1*/
    IL_0011: ret

  .method MinimapRenderer::PeriodicallyUpdateMinimap()  // token 0x06000A84 rva 0x32363 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::.ctor(int)  /*0x06000A86*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld MinimapRenderer MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>4__this  /*0x04000D50*/
    IL_000d: ret

  .method MinimapRenderer::.ctor()  // token 0x06000A85 rva 0x32374 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 115 (0x73), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.s 10
    IL_0003: stfld int MinimapRenderer::updateInterval  /*0x04000D36*/
    IL_0008: ldarg.0
    IL_0009: ldc.r4 10f
    IL_000e: stfld float MinimapRenderer::playerCircleRadius  /*0x04000D37*/
    IL_0013: ldarg.0
    IL_0014: ldc.r4 10f
    IL_0019: stfld float MinimapRenderer::enemyCircleRadius  /*0x04000D38*/
    IL_001e: ldarg.0
    IL_001f: ldc.r4 10f
    IL_0024: stfld float MinimapRenderer::allyCircleRadius  /*0x04000D39*/
    IL_0029: ldarg.0
    IL_002a: ldc.r4 2f
    IL_002f: stfld float MinimapRenderer::minBuildingSize  /*0x04000D3C*/
    IL_0034: ldarg.0
    IL_0035: newobj void System.Collections.Generic.List<float>::.ctor()  /*0x0A0002D3*/
    IL_003a: stfld List<float> MinimapRenderer::cosValues  /*0x04000D47*/
    IL_003f: ldarg.0
    IL_0040: newobj void System.Collections.Generic.List<float>::.ctor()  /*0x0A0002D3*/
    IL_0045: stfld List<float> MinimapRenderer::sinValues  /*0x04000D48*/
    IL_004a: ldarg.0
    IL_004b: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0050: stfld List<TaggedObject> MinimapRenderer::enemies  /*0x04000D49*/
    IL_0055: ldarg.0
    IL_0056: ldc.i4.4
    IL_0057: newarr UnityEngine.Vector3  /*0x01000028*/
    IL_005c: stfld Vector3[] MinimapRenderer::corners  /*0x04000D4A*/
    IL_0061: ldarg.0
    IL_0062: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0067: stfld List<TaggedObject> MinimapRenderer::allies  /*0x04000D4D*/
    IL_006c: ldarg.0
    IL_006d: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0072: ret

// ===== MinimapRenderer/<PeriodicallyUpdateMinimap>d__44  (token 0x020001F9) =====
  .method MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::.ctor(int)  // token 0x06000A86 rva 0x323f3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>1__state  /*0x04000D4E*/
    IL_000d: ret

  .method MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::System.IDisposable.Dispose()  // token 0x06000A87 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::MoveNext()  // token 0x06000A88 rva 0x32404 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 374 (0x176), max stack 3, init locals
    .locals ([0] int, [1] MinimapRenderer, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>1__state  /*0x04000D4E*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld MinimapRenderer MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>4__this  /*0x04000D50*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_002e, IL_0045, IL_006e, IL_010a, IL_0130, IL_016a)
    IL_002c: ldc.i4.0
    IL_002d: ret
    IL_002e: ldarg.0
    IL_002f: ldc.i4.m1
    IL_0030: stfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>1__state  /*0x04000D4E*/
    IL_0035: ldarg.0
    IL_0036: ldnull
    IL_0037: stfld object MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>2__current  /*0x04000D4F*/
    IL_003c: ldarg.0
    IL_003d: ldc.i4.1
    IL_003e: stfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>1__state  /*0x04000D4E*/
    IL_0043: ldc.i4.1
    IL_0044: ret
    IL_0045: ldarg.0
    IL_0046: ldc.i4.m1
    IL_0047: stfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>1__state  /*0x04000D4E*/
    IL_004c: ldloc.1
    IL_004d: ldloc.1
    IL_004e: call Mesh MinimapRenderer::GenerateGroundMesh()  /*0x06000A76*/
    IL_0053: stfld Mesh MinimapRenderer::navMesh  /*0x04000D44*/
    IL_0058: ldloc.1
    IL_0059: call void MinimapRenderer::GrabColorsFromCurrentColorScheme()  /*0x06000A82*/
    IL_005e: ldarg.0
    IL_005f: ldnull
    IL_0060: stfld object MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>2__current  /*0x04000D4F*/
    IL_0065: ldarg.0
    IL_0066: ldc.i4.2
    IL_0067: stfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>1__state  /*0x04000D4E*/
    IL_006c: ldc.i4.1
    IL_006d: ret
    IL_006e: ldarg.0
    IL_006f: ldc.i4.m1
    IL_0070: stfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>1__state  /*0x04000D4E*/
    IL_0075: ldloc.1
    IL_0076: call void MinimapRenderer::RenderBackground()  /*0x06000A75*/
    IL_007b: ldloc.1
    IL_007c: ldfld DayNightCycle MinimapRenderer::dnc  /*0x04000D4B*/
    IL_0081: ldnull
    IL_0082: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0087: brfalse.s IL_0094
    IL_0089: ldloc.1
    IL_008a: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_008f: stfld DayNightCycle MinimapRenderer::dnc  /*0x04000D4B*/
    IL_0094: ldloc.1
    IL_0095: ldfld bool MinimapRenderer::warpDebugDisableDrawMap  /*0x04000D4C*/
    IL_009a: brtrue IL_015a
    IL_009f: ldloc.1
    IL_00a0: ldfld DayNightCycle MinimapRenderer::dnc  /*0x04000D4B*/
    IL_00a5: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00aa: brfalse IL_015a
    IL_00af: ldloc.1
    IL_00b0: ldfld DayNightCycle MinimapRenderer::dnc  /*0x04000D4B*/
    IL_00b5: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_00ba: ldc.i4.1
    IL_00bb: bne.un IL_015a
    IL_00c0: ldloc.1
    IL_00c1: call void MinimapRenderer::ClearMinimap()  /*0x06000A83*/
    IL_00c6: ldloc.1
    IL_00c7: ldc.i4.8
    IL_00c8: ldloc.1
    IL_00c9: ldfld Material MinimapRenderer::matAlliesBuildings  /*0x04000D42*/
    IL_00ce: call void MinimapRenderer::DrawAllies(TagManager.ETag,UnityEngine.Material)  /*0x06000A7E*/
    IL_00d3: ldloc.1
    IL_00d4: ldc.i4.7
    IL_00d5: ldloc.1
    IL_00d6: ldfld Material MinimapRenderer::matAlliesUnits  /*0x04000D41*/
    IL_00db: call void MinimapRenderer::DrawAllies(TagManager.ETag,UnityEngine.Material)  /*0x06000A7E*/
    IL_00e0: ldloc.1
    IL_00e1: ldc.i4.s 22
    IL_00e3: ldloc.1
    IL_00e4: ldfld Material MinimapRenderer::matPlayer  /*0x04000D3F*/
    IL_00e9: call void MinimapRenderer::DrawAllies(TagManager.ETag,UnityEngine.Material)  /*0x06000A7E*/
    IL_00ee: ldloc.1
    IL_00ef: call void MinimapRenderer::DrawEnemies()  /*0x06000A79*/
    IL_00f4: ldloc.1
    IL_00f5: call void MinimapRenderer::DrawPlayer()  /*0x06000A78*/
    IL_00fa: ldarg.0
    IL_00fb: ldnull
    IL_00fc: stfld object MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>2__current  /*0x04000D4F*/
    IL_0101: ldarg.0
    IL_0102: ldc.i4.3
    IL_0103: stfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>1__state  /*0x04000D4E*/
    IL_0108: ldc.i4.1
    IL_0109: ret
    IL_010a: ldarg.0
    IL_010b: ldc.i4.m1
    IL_010c: stfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>1__state  /*0x04000D4E*/
    IL_0111: ldarg.0
    IL_0112: ldc.i4.0
    IL_0113: stfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<i>5__2  /*0x04000D51*/
    IL_0118: br.s IL_0147
    IL_011a: ldloc.1
    IL_011b: call void MinimapRenderer::DrawPlayer()  /*0x06000A78*/
    IL_0120: ldarg.0
    IL_0121: ldnull
    IL_0122: stfld object MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>2__current  /*0x04000D4F*/
    IL_0127: ldarg.0
    IL_0128: ldc.i4.4
    IL_0129: stfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>1__state  /*0x04000D4E*/
    IL_012e: ldc.i4.1
    IL_012f: ret
    IL_0130: ldarg.0
    IL_0131: ldc.i4.m1
    IL_0132: stfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>1__state  /*0x04000D4E*/
    IL_0137: ldarg.0
    IL_0138: ldfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<i>5__2  /*0x04000D51*/
    IL_013d: stloc.2
    IL_013e: ldarg.0
    IL_013f: ldloc.2
    IL_0140: ldc.i4.1
    IL_0141: add
    IL_0142: stfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<i>5__2  /*0x04000D51*/
    IL_0147: ldarg.0
    IL_0148: ldfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<i>5__2  /*0x04000D51*/
    IL_014d: ldloc.1
    IL_014e: ldfld int MinimapRenderer::updateInterval  /*0x04000D36*/
    IL_0153: blt.s IL_011a
    IL_0155: br IL_0094
    IL_015a: ldarg.0
    IL_015b: ldnull
    IL_015c: stfld object MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>2__current  /*0x04000D4F*/
    IL_0161: ldarg.0
    IL_0162: ldc.i4.5
    IL_0163: stfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>1__state  /*0x04000D4E*/
    IL_0168: ldc.i4.1
    IL_0169: ret
    IL_016a: ldarg.0
    IL_016b: ldc.i4.m1
    IL_016c: stfld int MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>1__state  /*0x04000D4E*/
    IL_0171: br IL_0094

  .method MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000A89 rva 0x32586 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>2__current  /*0x04000D4F*/
    IL_0006: ret

  .method MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::System.Collections.IEnumerator.Reset()  // token 0x06000A8A rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::System.Collections.IEnumerator.get_Current()  // token 0x06000A8B rva 0x32586 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object MinimapRenderer.<PeriodicallyUpdateMinimap>d__44::<>2__current  /*0x04000D4F*/
    IL_0006: ret

