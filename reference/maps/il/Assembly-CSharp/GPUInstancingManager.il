// ===== GPUInstancingManager  (token 0x020001CC) =====
  .method GPUInstancingManager::Awake()  // token 0x0600093C rva 0x2c054 attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool GPUInstancingManager::gpuInstancingEnabled  /*0x04000BAB*/
    IL_0006: brfalse.s IL_0010
    IL_0008: ldarg.0
    IL_0009: stsfld GPUInstancingManager GPUInstancingManager::Instance  /*0x04000BAA*/
    IL_000e: br.s IL_0016
    IL_0010: ldnull
    IL_0011: stsfld GPUInstancingManager GPUInstancingManager::Instance  /*0x04000BAA*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.Dictionary<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>::.ctor()  /*0x0A00040F*/
    IL_001c: stfld Dictionary<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair> GPUInstancingManager::matMeshPairToRenderersDictionary  /*0x04000BAD*/
    IL_0021: ret

  .method GPUInstancingManager::Update()  // token 0x0600093D rva 0x2c078 attrs Private, HideBySig
    // code size 448 (0x1c0), max stack 6, init locals
    .locals ([0] int, [1] int, [2] Camera, [3] bool, [4] Dictionary.Enumerator<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>, [5] KeyValuePair<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>, [6] GPUInstancingManager.TransformMatrixPair, [7] int, [8] int, [9] Transform, [10] Vector3, [11] float)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldc.i4.0
    IL_0003: stloc.1
    IL_0004: call Camera UnityEngine.Camera::get_main()  /*0x0A000107*/
    IL_0009: stloc.2
    IL_000a: ldloc.2
    IL_000b: ldnull
    IL_000c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0011: stloc.3
    IL_0012: ldloc.3
    IL_0013: brfalse.s IL_0021
    IL_0015: ldarg.0
    IL_0016: ldloc.2
    IL_0017: call Plane[] UnityEngine.GeometryUtility::CalculateFrustumPlanes(UnityEngine.Camera)  /*0x0A000410*/
    IL_001c: stfld Plane[] GPUInstancingManager::frustumPlanes  /*0x04000BAF*/
    IL_0021: ldarg.0
    IL_0022: ldfld Dictionary<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair> GPUInstancingManager::matMeshPairToRenderersDictionary  /*0x04000BAD*/
    IL_0027: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>::GetEnumerator()  /*0x0A000411*/
    IL_002c: stloc.s 4
    IL_002e: br IL_01a3
    IL_0033: ldloca.s 4
    IL_0035: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>::get_Current()  /*0x0A000412*/
    IL_003a: stloc.s 5
    IL_003c: ldloca.s 5
    IL_003e: call !1 System.Collections.Generic.KeyValuePair<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>::get_Value()  /*0x0A000413*/
    IL_0043: stloc.s 6
    IL_0045: ldc.i4.0
    IL_0046: stloc.s 7
    IL_0048: ldc.i4.0
    IL_0049: stloc.s 8
    IL_004b: br IL_00e4
    IL_0050: ldloc.s 6
    IL_0052: ldfld List<Transform> GPUInstancingManager.TransformMatrixPair::transforms  /*0x04000BB3*/
    IL_0057: ldloc.s 8
    IL_0059: callvirt !0 System.Collections.Generic.List<UnityEngine.Transform>::get_Item(int)  /*0x0A000237*/
    IL_005e: stloc.s 9
    IL_0060: ldloc.s 9
    IL_0062: ldnull
    IL_0063: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0068: brfalse.s IL_007f
    IL_006a: ldloc.s 6
    IL_006c: ldfld List<Matrix4x4> GPUInstancingManager.TransformMatrixPair::matrices  /*0x04000BB4*/
    IL_0071: ldloc.s 8
    IL_0073: call Matrix4x4 UnityEngine.Matrix4x4::get_identity()  /*0x0A000414*/
    IL_0078: callvirt void System.Collections.Generic.List<UnityEngine.Matrix4x4>::set_Item(int,!0)  /*0x0A000415*/
    IL_007d: br.s IL_00de
    IL_007f: ldloc.s 6
    IL_0081: ldfld List<Matrix4x4> GPUInstancingManager.TransformMatrixPair::matrices  /*0x04000BB4*/
    IL_0086: ldloc.s 8
    IL_0088: ldloc.s 9
    IL_008a: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_008f: callvirt void System.Collections.Generic.List<UnityEngine.Matrix4x4>::set_Item(int,!0)  /*0x0A000415*/
    IL_0094: ldloc.3
    IL_0095: brfalse.s IL_00de
    IL_0097: ldloc.s 9
    IL_0099: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_009e: stloc.s 10
    IL_00a0: ldc.r4 2f
    IL_00a5: stloc.s 11
    IL_00a7: ldarg.0
    IL_00a8: ldfld Plane[] GPUInstancingManager::frustumPlanes  /*0x04000BAF*/
    IL_00ad: ldloc.s 10
    IL_00af: ldloc.s 11
    IL_00b1: ldc.r4 2f
    IL_00b6: mul
    IL_00b7: ldloc.s 11
    IL_00b9: ldc.r4 2f
    IL_00be: mul
    IL_00bf: ldloc.s 11
    IL_00c1: ldc.r4 2f
    IL_00c6: mul
    IL_00c7: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_00cc: newobj void UnityEngine.Bounds::.ctor(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000416*/
    IL_00d1: call bool UnityEngine.GeometryUtility::TestPlanesAABB(UnityEngine.Plane[],UnityEngine.Bounds)  /*0x0A000417*/
    IL_00d6: brfalse.s IL_00de
    IL_00d8: ldloc.s 7
    IL_00da: ldc.i4.1
    IL_00db: add
    IL_00dc: stloc.s 7
    IL_00de: ldloc.s 8
    IL_00e0: ldc.i4.1
    IL_00e1: add
    IL_00e2: stloc.s 8
    IL_00e4: ldloc.s 8
    IL_00e6: ldloc.s 6
    IL_00e8: ldfld List<Transform> GPUInstancingManager.TransformMatrixPair::transforms  /*0x04000BB3*/
    IL_00ed: callvirt int System.Collections.Generic.List<UnityEngine.Transform>::get_Count()  /*0x0A000236*/
    IL_00f2: blt IL_0050
    IL_00f7: ldloc.3
    IL_00f8: brfalse.s IL_010b
    IL_00fa: ldloc.s 7
    IL_00fc: ldc.i4.0
    IL_00fd: bgt.s IL_010b
    IL_00ff: ldloc.s 6
    IL_0101: ldfld bool GPUInstancingManager.TransformMatrixPair::bCullingEnabled  /*0x04000BB5*/
    IL_0106: brtrue IL_019f
    IL_010b: ldloc.s 6
    IL_010d: ldfld List<Matrix4x4> GPUInstancingManager.TransformMatrixPair::matrices  /*0x04000BB4*/
    IL_0112: callvirt int System.Collections.Generic.List<UnityEngine.Matrix4x4>::get_Count()  /*0x0A000418*/
    IL_0117: ldc.i4 1024
    IL_011c: blt.s IL_013e
    IL_011e: ldstr "Drawing too many meshes with mesh: "
    IL_0123: ldloca.s 5
    IL_0125: call !0 System.Collections.Generic.KeyValuePair<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>::get_Key()  /*0x0A000419*/
    IL_012a: ldfld Mesh GPUInstancingManager.MaterialMeshPair::mesh  /*0x04000BB2*/
    IL_012f: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_0134: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0139: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_013e: nop
    IL_013f: ldloca.s 5
    IL_0141: call !0 System.Collections.Generic.KeyValuePair<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>::get_Key()  /*0x0A000419*/
    IL_0146: ldfld Mesh GPUInstancingManager.MaterialMeshPair::mesh  /*0x04000BB2*/
    IL_014b: ldc.i4.0
    IL_014c: ldloca.s 5
    IL_014e: call !0 System.Collections.Generic.KeyValuePair<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>::get_Key()  /*0x0A000419*/
    IL_0153: ldfld Material GPUInstancingManager.MaterialMeshPair::material  /*0x04000BB1*/
    IL_0158: ldloc.s 6
    IL_015a: ldfld List<Matrix4x4> GPUInstancingManager.TransformMatrixPair::matrices  /*0x04000BB4*/
    IL_015f: call void UnityEngine.Graphics::DrawMeshInstanced(UnityEngine.Mesh,int,UnityEngine.Material,System.Collections.Generic.List<UnityEngine.Matrix4x4>)  /*0x0A00041A*/
    IL_0164: leave.s IL_0189
    IL_0166: pop
    IL_0167: ldstr "GPU instancing with material failed: "
    IL_016c: ldloca.s 5
    IL_016e: call !0 System.Collections.Generic.KeyValuePair<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>::get_Key()  /*0x0A000419*/
    IL_0173: ldfld Material GPUInstancingManager.MaterialMeshPair::material  /*0x04000BB1*/
    IL_0178: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_017d: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0182: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0187: leave.s IL_0189
    IL_0189: ldloc.0
    IL_018a: ldloc.3
    IL_018b: brtrue.s IL_019b
    IL_018d: ldloc.s 6
    IL_018f: ldfld List<Transform> GPUInstancingManager.TransformMatrixPair::transforms  /*0x04000BB3*/
    IL_0194: callvirt int System.Collections.Generic.List<UnityEngine.Transform>::get_Count()  /*0x0A000236*/
    IL_0199: br.s IL_019d
    IL_019b: ldloc.s 7
    IL_019d: add
    IL_019e: stloc.0
    IL_019f: ldloc.1
    IL_01a0: ldc.i4.1
    IL_01a1: add
    IL_01a2: stloc.1
    IL_01a3: ldloca.s 4
    IL_01a5: call bool System.Collections.Generic.Dictionary.Enumerator<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>::MoveNext()  /*0x0A00041B*/
    IL_01aa: brtrue IL_0033
    IL_01af: leave.s IL_01bf
    IL_01b1: ldloca.s 4
    IL_01b3: constrained. System.Collections.Generic.Dictionary.Enumerator<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>  /*0x1B0000BC*/
    IL_01b9: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01be: endfinally
    IL_01bf: ret
    .try IL_013f-IL_0166 catch System.Object handler IL_0166-IL_0189
    .try IL_002e-IL_01b1 finally handler IL_01b1-IL_01bf

  .method GPUInstancingManager::AddVirtualMeshRenderer(UnityEngine.Mesh,UnityEngine.Material,UnityEngine.Transform,bool)  // token 0x0600093E rva 0x2c278 attrs Public, HideBySig
    // code size 118 (0x76), max stack 3, init locals
    .locals ([0] GPUInstancingManager.MaterialMeshPair, [1] GPUInstancingManager.TransformMatrixPair, [2] GPUInstancingManager.TransformMatrixPair)
    IL_0000: ldloca.s 0
    IL_0002: ldarg.2
    IL_0003: stfld Material GPUInstancingManager.MaterialMeshPair::material  /*0x04000BB1*/
    IL_0008: ldloca.s 0
    IL_000a: ldarg.1
    IL_000b: stfld Mesh GPUInstancingManager.MaterialMeshPair::mesh  /*0x04000BB2*/
    IL_0010: ldarg.0
    IL_0011: ldfld Dictionary<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair> GPUInstancingManager::matMeshPairToRenderersDictionary  /*0x04000BAD*/
    IL_0016: ldloc.0
    IL_0017: ldloca.s 1
    IL_0019: callvirt bool System.Collections.Generic.Dictionary<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>::TryGetValue(!0,ref !1)  /*0x0A00041C*/
    IL_001e: brtrue.s IL_0058
    IL_0020: ldloca.s 2
    IL_0022: initobj GPUInstancingManager.TransformMatrixPair  /*0x020001CE*/
    IL_0028: ldloca.s 2
    IL_002a: newobj void System.Collections.Generic.List<UnityEngine.Transform>::.ctor()  /*0x0A000238*/
    IL_002f: stfld List<Transform> GPUInstancingManager.TransformMatrixPair::transforms  /*0x04000BB3*/
    IL_0034: ldloca.s 2
    IL_0036: newobj void System.Collections.Generic.List<UnityEngine.Matrix4x4>::.ctor()  /*0x0A00041D*/
    IL_003b: stfld List<Matrix4x4> GPUInstancingManager.TransformMatrixPair::matrices  /*0x04000BB4*/
    IL_0040: ldloca.s 2
    IL_0042: ldarg.s 4
    IL_0044: stfld bool GPUInstancingManager.TransformMatrixPair::bCullingEnabled  /*0x04000BB5*/
    IL_0049: ldloc.2
    IL_004a: stloc.1
    IL_004b: ldarg.0
    IL_004c: ldfld Dictionary<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair> GPUInstancingManager::matMeshPairToRenderersDictionary  /*0x04000BAD*/
    IL_0051: ldloc.0
    IL_0052: ldloc.1
    IL_0053: callvirt void System.Collections.Generic.Dictionary<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>::set_Item(!0,!1)  /*0x0A00041E*/
    IL_0058: ldloc.1
    IL_0059: ldfld List<Transform> GPUInstancingManager.TransformMatrixPair::transforms  /*0x04000BB3*/
    IL_005e: ldarg.3
    IL_005f: callvirt void System.Collections.Generic.List<UnityEngine.Transform>::Add(!0)  /*0x0A000235*/
    IL_0064: ldloc.1
    IL_0065: ldfld List<Matrix4x4> GPUInstancingManager.TransformMatrixPair::matrices  /*0x04000BB4*/
    IL_006a: ldarg.3
    IL_006b: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_0070: callvirt void System.Collections.Generic.List<UnityEngine.Matrix4x4>::Add(!0)  /*0x0A00041F*/
    IL_0075: ret

  .method GPUInstancingManager::RemoveVirtualMeshRenderer(UnityEngine.Mesh,UnityEngine.Material,UnityEngine.Transform)  // token 0x0600093F rva 0x2c2fc attrs Public, HideBySig
    // code size 100 (0x64), max stack 3, init locals
    .locals ([0] GPUInstancingManager.MaterialMeshPair, [1] GPUInstancingManager.TransformMatrixPair, [2] int)
    IL_0000: ldloca.s 0
    IL_0002: ldarg.2
    IL_0003: stfld Material GPUInstancingManager.MaterialMeshPair::material  /*0x04000BB1*/
    IL_0008: ldloca.s 0
    IL_000a: ldarg.1
    IL_000b: stfld Mesh GPUInstancingManager.MaterialMeshPair::mesh  /*0x04000BB2*/
    IL_0010: ldarg.0
    IL_0011: ldfld Dictionary<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair> GPUInstancingManager::matMeshPairToRenderersDictionary  /*0x04000BAD*/
    IL_0016: ldloc.0
    IL_0017: ldloca.s 1
    IL_0019: callvirt bool System.Collections.Generic.Dictionary<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>::TryGetValue(!0,ref !1)  /*0x0A00041C*/
    IL_001e: brfalse.s IL_0063
    IL_0020: ldloc.1
    IL_0021: ldfld List<Transform> GPUInstancingManager.TransformMatrixPair::transforms  /*0x04000BB3*/
    IL_0026: ldarg.3
    IL_0027: callvirt int System.Collections.Generic.List<UnityEngine.Transform>::IndexOf(!0)  /*0x0A000420*/
    IL_002c: stloc.2
    IL_002d: ldloc.2
    IL_002e: ldc.i4.m1
    IL_002f: beq.s IL_0049
    IL_0031: ldloc.1
    IL_0032: ldfld List<Transform> GPUInstancingManager.TransformMatrixPair::transforms  /*0x04000BB3*/
    IL_0037: ldloc.2
    IL_0038: callvirt void System.Collections.Generic.List<UnityEngine.Transform>::RemoveAt(int)  /*0x0A000421*/
    IL_003d: ldloc.1
    IL_003e: ldfld List<Matrix4x4> GPUInstancingManager.TransformMatrixPair::matrices  /*0x04000BB4*/
    IL_0043: ldloc.2
    IL_0044: callvirt void System.Collections.Generic.List<UnityEngine.Matrix4x4>::RemoveAt(int)  /*0x0A000422*/
    IL_0049: ldloc.1
    IL_004a: ldfld List<Transform> GPUInstancingManager.TransformMatrixPair::transforms  /*0x04000BB3*/
    IL_004f: callvirt int System.Collections.Generic.List<UnityEngine.Transform>::get_Count()  /*0x0A000236*/
    IL_0054: brtrue.s IL_0063
    IL_0056: ldarg.0
    IL_0057: ldfld Dictionary<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair> GPUInstancingManager::matMeshPairToRenderersDictionary  /*0x04000BAD*/
    IL_005c: ldloc.0
    IL_005d: callvirt bool System.Collections.Generic.Dictionary<GPUInstancingManager.MaterialMeshPair, GPUInstancingManager.TransformMatrixPair>::Remove(!0)  /*0x0A000423*/
    IL_0062: pop
    IL_0063: ret

  .method GPUInstancingManager::UpdateVirtualMeshRenderer(UnityEngine.Mesh,UnityEngine.Material,UnityEngine.Mesh,UnityEngine.Material,UnityEngine.Transform,bool)  // token 0x06000940 rva 0x2c36c attrs Public, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: ldarg.2
    IL_0003: ldarg.s 5
    IL_0005: call void GPUInstancingManager::RemoveVirtualMeshRenderer(UnityEngine.Mesh,UnityEngine.Material,UnityEngine.Transform)  /*0x0600093F*/
    IL_000a: ldarg.0
    IL_000b: ldarg.3
    IL_000c: ldarg.s 4
    IL_000e: ldarg.s 5
    IL_0010: ldarg.s 6
    IL_0012: call void GPUInstancingManager::AddVirtualMeshRenderer(UnityEngine.Mesh,UnityEngine.Material,UnityEngine.Transform,bool)  /*0x0600093E*/
    IL_0017: ret

  .method GPUInstancingManager::.ctor()  // token 0x06000941 rva 0x2c385 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 48 (0x30), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool GPUInstancingManager::gpuInstancingEnabled  /*0x04000BAB*/
    IL_0007: ldarg.0
    IL_0008: newobj void System.Collections.Generic.List<UnityEngine.Matrix4x4>::.ctor()  /*0x0A00041D*/
    IL_000d: stfld List<Matrix4x4> GPUInstancingManager::transformMatricesBuffer  /*0x04000BAE*/
    IL_0012: ldarg.0
    IL_0013: ldc.i4.6
    IL_0014: newarr UnityEngine.Plane  /*0x010000DF*/
    IL_0019: stfld Plane[] GPUInstancingManager::frustumPlanes  /*0x04000BAF*/
    IL_001e: ldarg.0
    IL_001f: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0024: stfld List<int> GPUInstancingManager::visibleIndices  /*0x04000BB0*/
    IL_0029: ldarg.0
    IL_002a: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_002f: ret

// ===== GPUInstancingManager/MaterialMeshPair  (token 0x020001CD) =====
// ===== GPUInstancingManager/TransformMatrixPair  (token 0x020001CE) =====
