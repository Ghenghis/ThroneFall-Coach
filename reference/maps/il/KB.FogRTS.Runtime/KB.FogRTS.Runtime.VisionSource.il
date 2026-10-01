// ===== KB.FogRTS.Runtime.VisionSource  (token 0x02000015) =====
  .method KB.FogRTS.Runtime.VisionSource::get_Shape()  // token 0x0600007A rva 0x3edc attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld VisionSource.VisionShape KB.FogRTS.Runtime.VisionSource::shape  /*0x04000076*/
    IL_0006: ret

  .method KB.FogRTS.Runtime.VisionSource::set_Shape(KB.FogRTS.Runtime.VisionSource.VisionShape)  // token 0x0600007B rva 0x3ee4 attrs Public, HideBySig, SpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld VisionSource.VisionShape KB.FogRTS.Runtime.VisionSource::shape  /*0x04000076*/
    IL_0007: ldarg.0
    IL_0008: call void KB.FogRTS.Runtime.VisionSource::UpdateData()  /*0x06000089*/
    IL_000d: ret

  .method KB.FogRTS.Runtime.VisionSource::get_Layer()  // token 0x0600007C rva 0x3ef3 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld VisionLayer KB.FogRTS.Runtime.VisionSource::layer  /*0x04000077*/
    IL_0006: ret

  .method KB.FogRTS.Runtime.VisionSource::set_Layer(KB.FogRTS.Runtime.VisionLayer)  // token 0x0600007D rva 0x3efb attrs Public, HideBySig, SpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld VisionLayer KB.FogRTS.Runtime.VisionSource::layer  /*0x04000077*/
    IL_0007: ldarg.0
    IL_0008: call void KB.FogRTS.Runtime.VisionSource::UpdateData()  /*0x06000089*/
    IL_000d: ret

  .method KB.FogRTS.Runtime.VisionSource::get_PositionOffset()  // token 0x0600007E rva 0x3f0a attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector2 KB.FogRTS.Runtime.VisionSource::positionOffset  /*0x04000078*/
    IL_0006: ret

  .method KB.FogRTS.Runtime.VisionSource::set_PositionOffset(UnityEngine.Vector2)  // token 0x0600007F rva 0x3f12 attrs Public, HideBySig, SpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Vector2 KB.FogRTS.Runtime.VisionSource::positionOffset  /*0x04000078*/
    IL_0007: ldarg.0
    IL_0008: call void KB.FogRTS.Runtime.VisionSource::UpdateData()  /*0x06000089*/
    IL_000d: ret

  .method KB.FogRTS.Runtime.VisionSource::get_RotationOffset()  // token 0x06000080 rva 0x3f21 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float KB.FogRTS.Runtime.VisionSource::rotationOffset  /*0x04000079*/
    IL_0006: ret

  .method KB.FogRTS.Runtime.VisionSource::set_RotationOffset(float)  // token 0x06000081 rva 0x3f29 attrs Public, HideBySig, SpecialName
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: ldc.r4 360f
    IL_0007: rem
    IL_0008: stfld float KB.FogRTS.Runtime.VisionSource::rotationOffset  /*0x04000079*/
    IL_000d: ldarg.0
    IL_000e: call void KB.FogRTS.Runtime.VisionSource::UpdateData()  /*0x06000089*/
    IL_0013: ret

  .method KB.FogRTS.Runtime.VisionSource::get_Scale()  // token 0x06000082 rva 0x3f3e attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector2 KB.FogRTS.Runtime.VisionSource::scale  /*0x0400007A*/
    IL_0006: ret

  .method KB.FogRTS.Runtime.VisionSource::set_Scale(UnityEngine.Vector2)  // token 0x06000083 rva 0x3f46 attrs Public, HideBySig, SpecialName
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0000C3*/
    IL_0006: ldarg.1
    IL_0007: call Vector2 UnityEngine.Vector2::Max(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A0000C5*/
    IL_000c: stfld Vector2 KB.FogRTS.Runtime.VisionSource::scale  /*0x0400007A*/
    IL_0011: ldarg.0
    IL_0012: call void KB.FogRTS.Runtime.VisionSource::UpdateData()  /*0x06000089*/
    IL_0017: ret

  .method KB.FogRTS.Runtime.VisionSource::set_Transform(UnityEngine.Transform)  // token 0x06000084 rva 0x3f5f attrs Private, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Transform KB.FogRTS.Runtime.VisionSource::<Transform>k__BackingField  /*0x0400007B*/
    IL_0007: ret

  .method KB.FogRTS.Runtime.VisionSource::get_Transform()  // token 0x06000085 rva 0x3f68 attrs Assembly, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Transform KB.FogRTS.Runtime.VisionSource::<Transform>k__BackingField  /*0x0400007B*/
    IL_0006: ret

  .method KB.FogRTS.Runtime.VisionSource::Awake()  // token 0x06000086 rva 0x3f70 attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call Transform UnityEngine.Component::get_transform()  /*0x0A0000C1*/
    IL_0007: call void KB.FogRTS.Runtime.VisionSource::set_Transform(UnityEngine.Transform)  /*0x06000084*/
    IL_000c: ret

  .method KB.FogRTS.Runtime.VisionSource::OnEnable()  // token 0x06000087 rva 0x3f7e attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void KB.FogRTS.Runtime.VisionContainer::Add(KB.FogRTS.Runtime.VisionSource)  /*0x06000022*/
    IL_0006: ret

  .method KB.FogRTS.Runtime.VisionSource::OnDisable()  // token 0x06000088 rva 0x3f86 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void KB.FogRTS.Runtime.VisionContainer::Remove(KB.FogRTS.Runtime.VisionSource)  /*0x06000024*/
    IL_0006: ret

  .method KB.FogRTS.Runtime.VisionSource::UpdateData()  // token 0x06000089 rva 0x3f8e attrs Private, HideBySig
    // code size 6 (0x6), max stack 8
    IL_0000: call void KB.FogRTS.Runtime.VisionContainer::UpdateElement()  /*0x06000023*/
    IL_0005: ret

  .method KB.FogRTS.Runtime.VisionSource::.ctor()  // token 0x0600008A rva 0x3f95 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld VisionLayer KB.FogRTS.Runtime.VisionSource::layer  /*0x04000077*/
    IL_0007: ldarg.0
    IL_0008: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0000C3*/
    IL_000d: stfld Vector2 KB.FogRTS.Runtime.VisionSource::positionOffset  /*0x04000078*/
    IL_0012: ldarg.0
    IL_0013: call Vector2 UnityEngine.Vector2::get_one()  /*0x0A000055*/
    IL_0018: stfld Vector2 KB.FogRTS.Runtime.VisionSource::scale  /*0x0400007A*/
    IL_001d: ldarg.0
    IL_001e: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000092*/
    IL_0023: ret

// ===== KB.FogRTS.Runtime.VisionSource/VisionShape  (token 0x0200001D) =====
