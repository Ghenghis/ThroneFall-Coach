// ===== KB.FogRTS.Examples.MapMarkersManager  (token 0x02000007) =====
  .method KB.FogRTS.Examples.MapMarkersManager::RegisterMarker(KB.FogRTS.Examples.MapMarker)  // token 0x06000010 rva 0x23c0 attrs Assembly, Static, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldsfld List<MapMarker> KB.FogRTS.Examples.MapMarkersManager::markers  /*0x04000010*/
    IL_0005: ldarg.0
    IL_0006: callvirt void System.Collections.Generic.List<KB.FogRTS.Examples.MapMarker>::Add(!0)  /*0x0A000030*/
    IL_000b: call float UnityEngine.Time::get_time()  /*0x0A000031*/
    IL_0010: stsfld float KB.FogRTS.Examples.MapMarkersManager::markersModifiedTime  /*0x04000011*/
    IL_0015: ret

  .method KB.FogRTS.Examples.MapMarkersManager::UnregisterMarker(KB.FogRTS.Examples.MapMarker)  // token 0x06000011 rva 0x23d7 attrs Assembly, Static, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldsfld List<MapMarker> KB.FogRTS.Examples.MapMarkersManager::markers  /*0x04000010*/
    IL_0005: ldarg.0
    IL_0006: callvirt bool System.Collections.Generic.List<KB.FogRTS.Examples.MapMarker>::Remove(!0)  /*0x0A000032*/
    IL_000b: pop
    IL_000c: call float UnityEngine.Time::get_time()  /*0x0A000031*/
    IL_0011: stsfld float KB.FogRTS.Examples.MapMarkersManager::markersModifiedTime  /*0x04000011*/
    IL_0016: ret

  .method KB.FogRTS.Examples.MapMarkersManager::Awake()  // token 0x06000012 rva 0x23ef attrs Private, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.RectTransform>  /*0x2B000003*/
    IL_0007: stfld RectTransform KB.FogRTS.Examples.MapMarkersManager::markerParent  /*0x04000012*/
    IL_000c: ldarg.0
    IL_000d: ldc.r4 -1f
    IL_0012: stfld float KB.FogRTS.Examples.MapMarkersManager::rebuildTime  /*0x04000013*/
    IL_0017: ret

  .method KB.FogRTS.Examples.MapMarkersManager::LateUpdate()  // token 0x06000013 rva 0x2408 attrs Private, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldsfld float KB.FogRTS.Examples.MapMarkersManager::markersModifiedTime  /*0x04000011*/
    IL_0005: ldarg.0
    IL_0006: ldfld float KB.FogRTS.Examples.MapMarkersManager::rebuildTime  /*0x04000013*/
    IL_000b: ble.un.s IL_001e
    IL_000d: ldarg.0
    IL_000e: call void KB.FogRTS.Examples.MapMarkersManager::SyncMarkers()  /*0x06000014*/
    IL_0013: ldarg.0
    IL_0014: call float UnityEngine.Time::get_time()  /*0x0A000031*/
    IL_0019: stfld float KB.FogRTS.Examples.MapMarkersManager::rebuildTime  /*0x04000013*/
    IL_001e: ldarg.0
    IL_001f: call void KB.FogRTS.Examples.MapMarkersManager::UpdateMarkerPositions()  /*0x06000015*/
    IL_0024: ret

  .method KB.FogRTS.Examples.MapMarkersManager::SyncMarkers()  // token 0x06000014 rva 0x2430 attrs Private, HideBySig
    // code size 199 (0xc7), max stack 3, init locals
    .locals ([0] int, [1] int, [2] GameObject, [3] Image, [4] RectTransform, [5] int)
    IL_0000: ldsfld List<MapMarker> KB.FogRTS.Examples.MapMarkersManager::markers  /*0x04000010*/
    IL_0005: callvirt int System.Collections.Generic.List<KB.FogRTS.Examples.MapMarker>::get_Count()  /*0x0A000034*/
    IL_000a: ldarg.0
    IL_000b: ldfld List<GameObject> KB.FogRTS.Examples.MapMarkersManager::uiMarkers  /*0x04000014*/
    IL_0010: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A000035*/
    IL_0015: sub
    IL_0016: stloc.0
    IL_0017: ldloc.0
    IL_0018: ldc.i4.0
    IL_0019: ble.s IL_008c
    IL_001b: ldc.i4.0
    IL_001c: stloc.1
    IL_001d: br.s IL_0088
    IL_001f: ldstr "MapMarker"
    IL_0024: newobj void UnityEngine.GameObject::.ctor(string)  /*0x0A000036*/
    IL_0029: stloc.2
    IL_002a: ldloc.2
    IL_002b: callvirt !!0 UnityEngine.GameObject::AddComponent()<UnityEngine.UI.Image>  /*0x2B000004*/
    IL_0030: stloc.3
    IL_0031: ldloc.3
    IL_0032: callvirt RectTransform UnityEngine.UI.Graphic::get_rectTransform()  /*0x0A000038*/
    IL_0037: stloc.s 4
    IL_0039: ldloc.s 4
    IL_003b: ldarg.0
    IL_003c: ldfld RectTransform KB.FogRTS.Examples.MapMarkersManager::markerParent  /*0x04000012*/
    IL_0041: ldc.i4.0
    IL_0042: callvirt void UnityEngine.Transform::SetParent(UnityEngine.Transform,bool)  /*0x0A000039*/
    IL_0047: ldloc.s 4
    IL_0049: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A00003A*/
    IL_004e: callvirt void UnityEngine.RectTransform::set_anchorMin(UnityEngine.Vector2)  /*0x0A00003B*/
    IL_0053: ldloc.s 4
    IL_0055: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A00003A*/
    IL_005a: callvirt void UnityEngine.RectTransform::set_anchorMax(UnityEngine.Vector2)  /*0x0A00003C*/
    IL_005f: ldarg.0
    IL_0060: ldfld List<GameObject> KB.FogRTS.Examples.MapMarkersManager::uiMarkers  /*0x04000014*/
    IL_0065: ldloc.2
    IL_0066: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A00003D*/
    IL_006b: ldarg.0
    IL_006c: ldfld List<Image> KB.FogRTS.Examples.MapMarkersManager::uiMarkersImage  /*0x04000015*/
    IL_0071: ldloc.3
    IL_0072: callvirt void System.Collections.Generic.List<UnityEngine.UI.Image>::Add(!0)  /*0x0A00003E*/
    IL_0077: ldarg.0
    IL_0078: ldfld List<RectTransform> KB.FogRTS.Examples.MapMarkersManager::uiMarkersRT  /*0x04000016*/
    IL_007d: ldloc.s 4
    IL_007f: callvirt void System.Collections.Generic.List<UnityEngine.RectTransform>::Add(!0)  /*0x0A00003F*/
    IL_0084: ldloc.1
    IL_0085: ldc.i4.1
    IL_0086: add
    IL_0087: stloc.1
    IL_0088: ldloc.1
    IL_0089: ldloc.0
    IL_008a: blt.s IL_001f
    IL_008c: ldc.i4.0
    IL_008d: stloc.s 5
    IL_008f: br.s IL_00b7
    IL_0091: ldarg.0
    IL_0092: ldfld List<GameObject> KB.FogRTS.Examples.MapMarkersManager::uiMarkers  /*0x04000014*/
    IL_0097: ldloc.s 5
    IL_0099: callvirt !0 System.Collections.Generic.List<UnityEngine.GameObject>::get_Item(int)  /*0x0A000040*/
    IL_009e: ldloc.s 5
    IL_00a0: ldsfld List<MapMarker> KB.FogRTS.Examples.MapMarkersManager::markers  /*0x04000010*/
    IL_00a5: callvirt int System.Collections.Generic.List<KB.FogRTS.Examples.MapMarker>::get_Count()  /*0x0A000034*/
    IL_00aa: clt
    IL_00ac: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000041*/
    IL_00b1: ldloc.s 5
    IL_00b3: ldc.i4.1
    IL_00b4: add
    IL_00b5: stloc.s 5
    IL_00b7: ldloc.s 5
    IL_00b9: ldarg.0
    IL_00ba: ldfld List<GameObject> KB.FogRTS.Examples.MapMarkersManager::uiMarkers  /*0x04000014*/
    IL_00bf: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A000035*/
    IL_00c4: blt.s IL_0091
    IL_00c6: ret

  .method KB.FogRTS.Examples.MapMarkersManager::UpdateMarkerPositions()  // token 0x06000015 rva 0x2504 attrs Private, HideBySig
    // code size 309 (0x135), max stack 4, init locals
    .locals ([0] float, [1] float, [2] int, [3] float, [4] float, [5] Rect)
    IL_0000: ldarg.0
    IL_0001: ldflda Vector4 KB.FogRTS.Examples.MapMarkersManager::mapBordersLRBT  /*0x0400000E*/
    IL_0006: ldfld float UnityEngine.Vector4::y  /*0x0A000042*/
    IL_000b: ldarg.0
    IL_000c: ldflda Vector4 KB.FogRTS.Examples.MapMarkersManager::mapBordersLRBT  /*0x0400000E*/
    IL_0011: ldfld float UnityEngine.Vector4::x  /*0x0A000043*/
    IL_0016: sub
    IL_0017: stloc.0
    IL_0018: ldarg.0
    IL_0019: ldflda Vector4 KB.FogRTS.Examples.MapMarkersManager::mapBordersLRBT  /*0x0400000E*/
    IL_001e: ldfld float UnityEngine.Vector4::w  /*0x0A000044*/
    IL_0023: ldarg.0
    IL_0024: ldflda Vector4 KB.FogRTS.Examples.MapMarkersManager::mapBordersLRBT  /*0x0400000E*/
    IL_0029: ldfld float UnityEngine.Vector4::z  /*0x0A000045*/
    IL_002e: sub
    IL_002f: stloc.1
    IL_0030: ldc.i4.0
    IL_0031: stloc.2
    IL_0032: br IL_0124
    IL_0037: ldarg.0
    IL_0038: ldfld List<Image> KB.FogRTS.Examples.MapMarkersManager::uiMarkersImage  /*0x04000015*/
    IL_003d: ldloc.2
    IL_003e: callvirt !0 System.Collections.Generic.List<UnityEngine.UI.Image>::get_Item(int)  /*0x0A000046*/
    IL_0043: ldsfld List<MapMarker> KB.FogRTS.Examples.MapMarkersManager::markers  /*0x04000010*/
    IL_0048: ldloc.2
    IL_0049: callvirt !0 System.Collections.Generic.List<KB.FogRTS.Examples.MapMarker>::get_Item(int)  /*0x0A000047*/
    IL_004e: callvirt Sprite KB.FogRTS.Examples.MapMarker::get_Sprite()  /*0x06000009*/
    IL_0053: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000048*/
    IL_0058: ldarg.0
    IL_0059: ldfld List<RectTransform> KB.FogRTS.Examples.MapMarkersManager::uiMarkersRT  /*0x04000016*/
    IL_005e: ldloc.2
    IL_005f: callvirt !0 System.Collections.Generic.List<UnityEngine.RectTransform>::get_Item(int)  /*0x0A000049*/
    IL_0064: call Vector2 UnityEngine.Vector2::get_one()  /*0x0A00004A*/
    IL_0069: ldsfld List<MapMarker> KB.FogRTS.Examples.MapMarkersManager::markers  /*0x04000010*/
    IL_006e: ldloc.2
    IL_006f: callvirt !0 System.Collections.Generic.List<KB.FogRTS.Examples.MapMarker>::get_Item(int)  /*0x0A000047*/
    IL_0074: callvirt float KB.FogRTS.Examples.MapMarker::get_Size()  /*0x0600000A*/
    IL_0079: ldarg.0
    IL_007a: ldfld float KB.FogRTS.Examples.MapMarkersManager::markerScale  /*0x0400000F*/
    IL_007f: mul
    IL_0080: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A00004B*/
    IL_0085: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A00004C*/
    IL_008a: ldsfld List<MapMarker> KB.FogRTS.Examples.MapMarkersManager::markers  /*0x04000010*/
    IL_008f: ldloc.2
    IL_0090: callvirt !0 System.Collections.Generic.List<KB.FogRTS.Examples.MapMarker>::get_Item(int)  /*0x0A000047*/
    IL_0095: callvirt Vector3 KB.FogRTS.Examples.MapMarker::get_WorldPosition()  /*0x0600000B*/
    IL_009a: ldfld float UnityEngine.Vector3::x  /*0x0A000014*/
    IL_009f: ldarg.0
    IL_00a0: ldflda Vector4 KB.FogRTS.Examples.MapMarkersManager::mapBordersLRBT  /*0x0400000E*/
    IL_00a5: ldfld float UnityEngine.Vector4::x  /*0x0A000043*/
    IL_00aa: sub
    IL_00ab: ldloc.0
    IL_00ac: div
    IL_00ad: stloc.3
    IL_00ae: ldsfld List<MapMarker> KB.FogRTS.Examples.MapMarkersManager::markers  /*0x04000010*/
    IL_00b3: ldloc.2
    IL_00b4: callvirt !0 System.Collections.Generic.List<KB.FogRTS.Examples.MapMarker>::get_Item(int)  /*0x0A000047*/
    IL_00b9: callvirt Vector3 KB.FogRTS.Examples.MapMarker::get_WorldPosition()  /*0x0600000B*/
    IL_00be: ldfld float UnityEngine.Vector3::z  /*0x0A000016*/
    IL_00c3: ldarg.0
    IL_00c4: ldflda Vector4 KB.FogRTS.Examples.MapMarkersManager::mapBordersLRBT  /*0x0400000E*/
    IL_00c9: ldfld float UnityEngine.Vector4::z  /*0x0A000045*/
    IL_00ce: sub
    IL_00cf: ldloc.1
    IL_00d0: div
    IL_00d1: stloc.s 4
    IL_00d3: ldarg.0
    IL_00d4: ldfld List<RectTransform> KB.FogRTS.Examples.MapMarkersManager::uiMarkersRT  /*0x04000016*/
    IL_00d9: ldloc.2
    IL_00da: callvirt !0 System.Collections.Generic.List<UnityEngine.RectTransform>::get_Item(int)  /*0x0A000049*/
    IL_00df: ldloc.3
    IL_00e0: ldarg.0
    IL_00e1: ldfld RectTransform KB.FogRTS.Examples.MapMarkersManager::markerParent  /*0x04000012*/
    IL_00e6: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A00004D*/
    IL_00eb: stloc.s 5
    IL_00ed: ldloca.s 5
    IL_00ef: call Vector2 UnityEngine.Rect::get_size()  /*0x0A00004E*/
    IL_00f4: ldfld float UnityEngine.Vector2::x  /*0x0A00004F*/
    IL_00f9: mul
    IL_00fa: ldloc.s 4
    IL_00fc: ldarg.0
    IL_00fd: ldfld RectTransform KB.FogRTS.Examples.MapMarkersManager::markerParent  /*0x04000012*/
    IL_0102: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A00004D*/
    IL_0107: stloc.s 5
    IL_0109: ldloca.s 5
    IL_010b: call Vector2 UnityEngine.Rect::get_size()  /*0x0A00004E*/
    IL_0110: ldfld float UnityEngine.Vector2::y  /*0x0A000050*/
    IL_0115: mul
    IL_0116: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000051*/
    IL_011b: callvirt void UnityEngine.RectTransform::set_anchoredPosition(UnityEngine.Vector2)  /*0x0A000052*/
    IL_0120: ldloc.2
    IL_0121: ldc.i4.1
    IL_0122: add
    IL_0123: stloc.2
    IL_0124: ldloc.2
    IL_0125: ldsfld List<MapMarker> KB.FogRTS.Examples.MapMarkersManager::markers  /*0x04000010*/
    IL_012a: callvirt int System.Collections.Generic.List<KB.FogRTS.Examples.MapMarker>::get_Count()  /*0x0A000034*/
    IL_012f: blt IL_0037
    IL_0134: ret

  .method KB.FogRTS.Examples.MapMarkersManager::.ctor()  // token 0x06000016 rva 0x2648 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 82 (0x52), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 -50f
    IL_0006: ldc.r4 50f
    IL_000b: ldc.r4 -50f
    IL_0010: ldc.r4 50f
    IL_0015: newobj void UnityEngine.Vector4::.ctor(float,float,float,float)  /*0x0A000053*/
    IL_001a: stfld Vector4 KB.FogRTS.Examples.MapMarkersManager::mapBordersLRBT  /*0x0400000E*/
    IL_001f: ldarg.0
    IL_0020: ldc.r4 1f
    IL_0025: stfld float KB.FogRTS.Examples.MapMarkersManager::markerScale  /*0x0400000F*/
    IL_002a: ldarg.0
    IL_002b: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000054*/
    IL_0030: stfld List<GameObject> KB.FogRTS.Examples.MapMarkersManager::uiMarkers  /*0x04000014*/
    IL_0035: ldarg.0
    IL_0036: newobj void System.Collections.Generic.List<UnityEngine.UI.Image>::.ctor()  /*0x0A000055*/
    IL_003b: stfld List<Image> KB.FogRTS.Examples.MapMarkersManager::uiMarkersImage  /*0x04000015*/
    IL_0040: ldarg.0
    IL_0041: newobj void System.Collections.Generic.List<UnityEngine.RectTransform>::.ctor()  /*0x0A000056*/
    IL_0046: stfld List<RectTransform> KB.FogRTS.Examples.MapMarkersManager::uiMarkersRT  /*0x04000016*/
    IL_004b: ldarg.0
    IL_004c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000018*/
    IL_0051: ret

  .method KB.FogRTS.Examples.MapMarkersManager::.cctor()  // token 0x06000017 rva 0x26a6 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: newobj void System.Collections.Generic.List<KB.FogRTS.Examples.MapMarker>::.ctor()  /*0x0A000057*/
    IL_0005: stsfld List<MapMarker> KB.FogRTS.Examples.MapMarkersManager::markers  /*0x04000010*/
    IL_000a: ldc.r4 0f
    IL_000f: stsfld float KB.FogRTS.Examples.MapMarkersManager::markersModifiedTime  /*0x04000011*/
    IL_0014: ret

