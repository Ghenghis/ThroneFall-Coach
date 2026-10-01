// ===== BlockProjectiles  (token 0x02000081) =====
  .method BlockProjectiles::Start()  // token 0x06000293 rva 0xb818 attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: stfld TagManager BlockProjectiles::tagManager  /*0x04000366*/
    IL_000b: ldarg.0
    IL_000c: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0011: ldarg.0
    IL_0012: ldfld float BlockProjectiles::blockInterval  /*0x04000362*/
    IL_0017: mul
    IL_0018: stfld float BlockProjectiles::cooldown  /*0x04000365*/
    IL_001d: ret

  .method BlockProjectiles::Update()  // token 0x06000294 rva 0xb837 attrs Private, HideBySig
    // code size 59 (0x3b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float BlockProjectiles::cooldown  /*0x04000365*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float BlockProjectiles::cooldown  /*0x04000365*/
    IL_0012: br.s IL_002d
    IL_0014: ldarg.0
    IL_0015: call void BlockProjectiles::BlockAnArrow()  /*0x06000295*/
    IL_001a: ldarg.0
    IL_001b: ldarg.0
    IL_001c: ldfld float BlockProjectiles::cooldown  /*0x04000365*/
    IL_0021: ldarg.0
    IL_0022: ldfld float BlockProjectiles::blockInterval  /*0x04000362*/
    IL_0027: add
    IL_0028: stfld float BlockProjectiles::cooldown  /*0x04000365*/
    IL_002d: ldarg.0
    IL_002e: ldfld float BlockProjectiles::cooldown  /*0x04000365*/
    IL_0033: ldc.r4 0f
    IL_0038: ble.s IL_0014
    IL_003a: ret

  .method BlockProjectiles::BlockAnArrow()  // token 0x06000295 rva 0xb874 attrs Private, HideBySig
    // code size 172 (0xac), max stack 4, init locals
    .locals ([0] TaggedObject, [1] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld TagManager BlockProjectiles::tagManager  /*0x04000366*/
    IL_0006: ldarg.0
    IL_0007: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0011: ldarg.0
    IL_0012: ldfld List<TagManager.ETag> BlockProjectiles::mustHaveTags  /*0x04000367*/
    IL_0017: ldarg.0
    IL_0018: ldfld List<TagManager.ETag> BlockProjectiles::mayNotHaveTags  /*0x04000368*/
    IL_001d: callvirt TaggedObject TagManager::FindClosestTaggedObjectWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5E*/
    IL_0022: stloc.0
    IL_0023: ldloc.0
    IL_0024: ldnull
    IL_0025: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_002a: brfalse.s IL_002d
    IL_002c: ret
    IL_002d: ldloc.0
    IL_002e: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0033: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0038: ldarg.0
    IL_0039: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0043: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0048: stloc.1
    IL_0049: ldloca.s 1
    IL_004b: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0050: ldarg.0
    IL_0051: ldfld float BlockProjectiles::range  /*0x04000363*/
    IL_0056: bge.un.s IL_00ab
    IL_0058: ldarg.0
    IL_0059: ldfld GameObject BlockProjectiles::fxBlockProjectile  /*0x04000364*/
    IL_005e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0063: brfalse.s IL_0081
    IL_0065: ldarg.0
    IL_0066: ldfld GameObject BlockProjectiles::fxBlockProjectile  /*0x04000364*/
    IL_006b: ldloc.0
    IL_006c: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0071: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0076: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_007b: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_0080: pop
    IL_0081: ldloc.0
    IL_0082: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0087: callvirt !!0 UnityEngine.GameObject::GetComponent()<ReturnGameObjectToPool>  /*0x2B000020*/
    IL_008c: ldnull
    IL_008d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0092: brfalse.s IL_00a0
    IL_0094: ldloc.0
    IL_0095: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_009a: call void ObjectPools::ReleasePooledItemByObject(UnityEngine.GameObject)  /*0x06000E9B*/
    IL_009f: ret
    IL_00a0: ldloc.0
    IL_00a1: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00a6: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_00ab: ret

  .method BlockProjectiles::.ctor()  // token 0x06000296 rva 0xb92c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float BlockProjectiles::blockInterval  /*0x04000362*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 30f
    IL_0011: stfld float BlockProjectiles::range  /*0x04000363*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_001c: stfld List<TagManager.ETag> BlockProjectiles::mustHaveTags  /*0x04000367*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0027: stfld List<TagManager.ETag> BlockProjectiles::mayNotHaveTags  /*0x04000368*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0032: ret

