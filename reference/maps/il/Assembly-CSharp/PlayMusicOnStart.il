// ===== PlayMusicOnStart  (token 0x02000246) =====
  .method PlayMusicOnStart::Start()  // token 0x06000C84 rva 0x39ac0 attrs Private, HideBySig
    // code size 71 (0x47), max stack 3, init locals
    .locals ([0] MusicManager)
    IL_0000: ldsfld MusicManager MusicManager::instance  /*0x04000BC8*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldnull
    IL_0008: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000d: brfalse.s IL_0023
    IL_000f: ldloc.0
    IL_0010: ldarg.0
    IL_0011: ldfld AudioClip PlayMusicOnStart::audioClip  /*0x04000F30*/
    IL_0016: ldarg.0
    IL_0017: ldfld float PlayMusicOnStart::fadeDuration  /*0x04000F31*/
    IL_001c: callvirt void MusicManager::PlayMusic(UnityEngine.AudioClip,float)  /*0x0600095A*/
    IL_0021: br.s IL_002d
    IL_0023: ldstr "MusicManager instance not found."
    IL_0028: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_002d: ldarg.0
    IL_002e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0033: ldarg.0
    IL_0034: ldfld bool PlayMusicOnStart::destroyEntireGameObject  /*0x04000F32*/
    IL_0039: brfalse.s IL_0046
    IL_003b: ldarg.0
    IL_003c: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0041: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0046: ret

  .method PlayMusicOnStart::.ctor()  // token 0x06000C85 rva 0x39b13 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 4f
    IL_0006: stfld float PlayMusicOnStart::fadeDuration  /*0x04000F31*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.1
    IL_000d: stfld bool PlayMusicOnStart::destroyEntireGameObject  /*0x04000F32*/
    IL_0012: ldarg.0
    IL_0013: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0018: ret

