using System.Reflection;
using System.Reflection.Metadata;

namespace TfMap;

/// <summary>One Unity type-tree node (same shape UnityPy's TypeTreeNode.from_list accepts).</summary>
readonly record struct Node(int Level, string Type, string Name, int Meta);

/// <summary>A (possibly generic) instantiation of a type definition.</summary>
sealed record GenType(TDef Def, TypeSig[] Args);

/// <summary>
/// Generates Unity 2022.3 serialization layouts (type trees) for MonoBehaviour / ScriptableObject classes
/// from assembly metadata, following Unity's managed serialization rules:
///  - instance fields that are public, [SerializeField] or [SerializeReference]; never static/const/readonly/[NonSerialized]
///  - primitives, string, enums (underlying type), UnityEngine.Object refs (PPtr), [Serializable] non-abstract classes/structs
///    (closed generics allowed), T[] and List&lt;T&gt; (no nested collections), built-in Unity structs with native layouts
///  - sub-4-byte primitives are followed by 4-byte alignment unless they are array elements; arrays align after the data
///  - base classes first, declaration order within a class; a field whose type equals its declaring type is skipped
/// Every generated layout is later checked byte-exactly against the real objects in the asset files.
/// </summary>
sealed class LayoutBuilder
{
    public const int Align = 0x4000;
    const int MaxDepth = 10;
    readonly World W;
    public readonly List<string> Notes = new();
    public bool UsesManagedRefs;

    public LayoutBuilder(World w) => W = w;

    static readonly HashSet<string> UnityBoundary = new()
    {
        "UnityEngine.MonoBehaviour", "UnityEngine.ScriptableObject", "UnityEngine.Behaviour", "UnityEngine.Component", "UnityEngine.Object"
    };

    public List<Node> BuildScript(TDef t)
    {
        Notes.Clear();
        UsesManagedRefs = false;
        var nodes = new List<Node> { new(0, "MonoBehaviour", "Base", 0) };
        AddPPtr(nodes, 1, "GameObject", "m_GameObject");
        nodes.Add(new(1, "UInt8", "m_Enabled", Align));
        AddPPtr(nodes, 1, "MonoScript", "m_Script");
        AddString(nodes, 1, "m_Name");
        EmitClassFields(nodes, 1, new GenType(t, Array.Empty<TypeSig>()), 0, stopAtUnity: true);
        if (UsesManagedRefs) AddRegistry(nodes, 1);
        return nodes;
    }

    /// <summary>Layout of a plain [Serializable] class/struct as it appears inside a SerializeReference registry entry.</summary>
    public List<Node>? BuildClass(TDef t)
    {
        Notes.Clear();
        UsesManagedRefs = false;
        var info = W.Info(t);
        // [SerializeReference] targets need no [Serializable] attribute; they only have to be concrete, non-generic managed classes.
        if (info.IsInterface || info.IsAbstract || info.IsDelegate || info.IsEnum || info.GenericParamCount > 0) return null;
        var nodes = new List<Node> { new(0, info.Name, "data", 0) };
        EmitClassFields(nodes, 1, new GenType(t, Array.Empty<TypeSig>()), 0, stopAtUnity: false);
        return nodes;
    }

    // ---------------------------------------------------------------- class walking

    void EmitClassFields(List<Node> nodes, int level, GenType gt, int depth, bool stopAtUnity)
    {
        var chain = new List<GenType>();
        GenType? cur = gt;
        int guard = 0;
        while (cur != null && guard++ < 32)
        {
            var fn = W.Info(cur.Def).FullName;
            if (stopAtUnity && UnityBoundary.Contains(fn)) break;
            if (!stopAtUnity && (fn == "System.Object" || fn == "System.ValueType")) break;
            chain.Add(cur);
            cur = BaseOf(cur);
        }
        chain.Reverse();
        foreach (var c in chain)
        {
            var md = c.Def.M.MD;
            var ctx = W.CtxFor(c.Def);
            foreach (var fh in c.Def.Def.GetFields())
            {
                var f = md.GetFieldDefinition(fh);
                if (!IsSerializedDecl(c.Def.M, f, out bool serRef)) continue;
                var name = md.GetString(f.Name);
                TypeSig ft;
                try { ft = Subst(f.DecodeSignature(W.P, ctx), c.Args); }
                catch (Exception e) { Notes.Add($"{name}: signature decode failed ({e.GetType().Name})"); continue; }
                if (serRef) { EmitManagedRef(nodes, level, ft, name); continue; }
                if (IsSelfType(ft, c.Def)) { Notes.Add($"{name}: skipped (field type equals declaring type)"); continue; }
                if (!EmitField(nodes, level, ft, name, depth, isElement: false))
                {
                    bool isPublic = (f.Attributes & FieldAttributes.FieldAccessMask) == FieldAttributes.Public;
                    Notes.Add($"{name}: not serialized ({Naming.Show(ft)}){(isPublic ? "" : " [SerializeField]")}");
                }
            }
        }
    }

    GenType? BaseOf(GenType g)
    {
        var td = g.Def.Def;
        if (td.BaseType.IsNil) return null;
        var bs = Subst(W.SigOf(g.Def.M, td.BaseType, W.CtxFor(g.Def)), g.Args);
        return ToGenType(bs);
    }

    GenType? ToGenType(TypeSig t)
    {
        switch (t)
        {
            case NamedSig n:
                var d = W.ResolveHandle(n.Owner, n.Handle);
                return d is { } dd ? new GenType(dd, Array.Empty<TypeSig>()) : null;
            case GenInstSig g:
                var gd = W.ResolveSig(g.Def);
                return gd is { } gdd ? new GenType(gdd, g.Args) : null;
            default:
                return null;
        }
    }

    static TypeSig Subst(TypeSig t, TypeSig[] args)
    {
        if (args.Length == 0) return t;
        return t switch
        {
            GenParamSig p when !p.Method && p.Index < args.Length => args[p.Index],
            GenInstSig g => new GenInstSig(Subst(g.Def, args), g.Args.Select(a => Subst(a, args)).ToArray()),
            SZArraySig a => new SZArraySig(Subst(a.Elem, args)),
            MDArraySig a => new MDArraySig(Subst(a.Elem, args), a.Rank),
            PtrSig p => new PtrSig(Subst(p.Elem, args), p.ByRef),
            _ => t
        };
    }

    bool IsSelfType(TypeSig ft, TDef declaring)
    {
        var d = W.ResolveSig(ft);
        if (d is not { } dd) return false;
        if (W.Info(dd).IsUnityObject) return false;
        return dd.Equals(declaring) && ft is NamedSig;
    }

    public static bool IsSerializedDecl(Module m, FieldDefinition f, out bool serRef)
    {
        serRef = false;
        var a = f.Attributes;
        if ((a & (FieldAttributes.Static | FieldAttributes.Literal | FieldAttributes.InitOnly | FieldAttributes.NotSerialized)) != 0) return false;
        var attrs = f.GetCustomAttributes();
        serRef = Attrs.Has(m, attrs, "UnityEngine", "SerializeReference");
        bool isPublic = (a & FieldAttributes.FieldAccessMask) == FieldAttributes.Public;
        return isPublic || serRef || Attrs.Has(m, attrs, "UnityEngine", "SerializeField");
    }

    // ---------------------------------------------------------------- fields

    bool EmitField(List<Node> nodes, int level, TypeSig t, string name, int depth, bool isElement)
    {
        switch (t)
        {
            case PrimSig p:
                if (p.Code == PrimitiveTypeCode.String) { AddString(nodes, level, name); return true; }
                var pn = PrimName(p.Code);
                if (pn == null) return false;
                nodes.Add(new(level, pn, name, !isElement && IsSmall(p.Code) ? Align : 0));
                return true;
            case SZArraySig a:
                return EmitCollection(nodes, level, a.Elem, name, depth);
            case GenInstSig g when IsList(g):
                return EmitCollection(nodes, level, g.Args[0], name, depth);
            case NamedSig or GenInstSig:
                var gt = ToGenType(t);
                if (gt == null) { Notes.Add($"{name}: unresolved type {Naming.Show(t, true)}"); return false; }
                var info = W.Info(gt.Def);
                if (Builtins.TryGetValue(info.FullName, out var emit)) { emit(nodes, level, name); return true; }
                if (info.IsEnum)
                {
                    var en = PrimName(info.EnumUnderlying) ?? "int";
                    nodes.Add(new(level, en, name, !isElement && IsSmall(info.EnumUnderlying) ? Align : 0));
                    return true;
                }
                if (info.IsUnityObject) { AddPPtr(nodes, level, Naming.StripArity(info.Name), name); return true; }
                if (!IsSerializableCustom(info, gt)) return false;
                if (depth >= MaxDepth) { Notes.Add($"{name}: depth limit {MaxDepth} reached"); return false; }
                nodes.Add(new(level, Naming.Show(t), name, info.IsValueType ? Align : 0));
                EmitClassFields(nodes, level + 1, gt, depth + 1, stopAtUnity: false);
                return true;
            default:
                return false;
        }
    }

    bool EmitCollection(List<Node> nodes, int level, TypeSig elem, string name, int depth)
    {
        if (elem is SZArraySig || elem is MDArraySig || (elem is GenInstSig g && IsList(g))) return false;
        var tmp = new List<Node>();
        if (!EmitField(tmp, level + 2, elem, "data", depth, isElement: true)) return false;
        nodes.Add(new(level, "vector", name, RequiresAlignment(elem) ? Align : 0));
        nodes.Add(new(level + 1, "Array", "Array", Align));
        nodes.Add(new(level + 2, "int", "size", 0));
        nodes.AddRange(tmp);
        return true;
    }

    void EmitManagedRef(List<Node> nodes, int level, TypeSig t, string name)
    {
        UsesManagedRefs = true;
        if (t is SZArraySig || (t is GenInstSig g && IsList(g)))
        {
            nodes.Add(new(level, "vector", name, 0));
            nodes.Add(new(level + 1, "Array", "Array", Align));
            nodes.Add(new(level + 2, "int", "size", 0));
            nodes.Add(new(level + 2, "managedReference", "data", 0));
            nodes.Add(new(level + 3, "SInt64", "rid", 0));
        }
        else
        {
            nodes.Add(new(level, "managedReference", name, 0));
            nodes.Add(new(level + 1, "SInt64", "rid", 0));
        }
    }

    static void AddRegistry(List<Node> nodes, int level)
    {
        nodes.Add(new(level, "ManagedReferencesRegistry", "references", 0));
        nodes.Add(new(level + 1, "int", "version", 0));
        nodes.Add(new(level + 1, "vector", "RefIds", 0));
        nodes.Add(new(level + 2, "Array", "Array", Align));
        nodes.Add(new(level + 3, "int", "size", 0));
        nodes.Add(new(level + 3, "ReferencedObject", "data", 0));
        nodes.Add(new(level + 4, "SInt64", "rid", 0));
        nodes.Add(new(level + 4, "ReferencedManagedType", "type", 0));
        AddString(nodes, level + 5, "class");
        AddString(nodes, level + 5, "ns");
        AddString(nodes, level + 5, "asm");
        nodes.Add(new(level + 4, "ReferencedObjectData", "data", 0));
    }

    bool IsSerializableCustom(TInfo info, GenType gt)
    {
        if (info.IsInterface || info.IsAbstract || info.IsDelegate || info.IsEnum) return false;
        if (!info.IsSerializableFlag) return false;
        if (info.GenericParamCount > 0 && gt.Args.Length != info.GenericParamCount) return false;
        var ns = info.Ns;
        if (ns == "System" || ns.StartsWith("System.")) return false;
        return true;
    }

    static bool IsList(GenInstSig g) => g.Def is NamedSig n && n.Ns == "System.Collections.Generic" && n.Name == "List`1";

    bool RequiresAlignment(TypeSig elem)
    {
        if (elem is PrimSig p) return IsSmall(p.Code);
        var d = W.ResolveSig(elem);
        if (d is { } dd) { var i = W.Info(dd); if (i.IsEnum) return IsSmall(i.EnumUnderlying); }
        return false;
    }

    static bool IsSmall(PrimitiveTypeCode c) => c is PrimitiveTypeCode.Boolean or PrimitiveTypeCode.Char or PrimitiveTypeCode.SByte
        or PrimitiveTypeCode.Byte or PrimitiveTypeCode.Int16 or PrimitiveTypeCode.UInt16;

    static string? PrimName(PrimitiveTypeCode c) => c switch
    {
        PrimitiveTypeCode.Boolean => "bool",
        PrimitiveTypeCode.Char => "UInt16",
        PrimitiveTypeCode.SByte => "SInt8",
        PrimitiveTypeCode.Byte => "UInt8",
        PrimitiveTypeCode.Int16 => "SInt16",
        PrimitiveTypeCode.UInt16 => "UInt16",
        PrimitiveTypeCode.Int32 => "int",
        PrimitiveTypeCode.UInt32 => "UInt32",
        PrimitiveTypeCode.Int64 => "SInt64",
        PrimitiveTypeCode.UInt64 => "UInt64",
        PrimitiveTypeCode.Single => "float",
        PrimitiveTypeCode.Double => "double",
        _ => null
    };

    // ---------------------------------------------------------------- node helpers / built-ins

    static void AddPPtr(List<Node> n, int level, string target, string name)
    {
        n.Add(new(level, $"PPtr<{target}>", name, 0));
        n.Add(new(level + 1, "int", "m_FileID", 0));
        n.Add(new(level + 1, "SInt64", "m_PathID", 0));
    }

    static void AddString(List<Node> n, int level, string name)
    {
        n.Add(new(level, "string", name, 0));
        n.Add(new(level + 1, "Array", "Array", Align));
        n.Add(new(level + 2, "int", "size", 0));
        n.Add(new(level + 2, "char", "data", 0));
    }

    static void Floats(List<Node> n, int level, string type, string name, int meta, params string[] names)
    {
        n.Add(new(level, type, name, meta));
        foreach (var f in names) n.Add(new(level + 1, "float", f, 0));
    }

    static void Ints(List<Node> n, int level, string type, string name, int meta, params string[] names)
    {
        n.Add(new(level, type, name, meta));
        foreach (var f in names) n.Add(new(level + 1, "int", f, 0));
    }

    static readonly Dictionary<string, Action<List<Node>, int, string>> Builtins = new()
    {
        ["UnityEngine.Vector2"] = (n, l, nm) => Floats(n, l, "Vector2f", nm, Align, "x", "y"),
        ["UnityEngine.Vector3"] = (n, l, nm) => Floats(n, l, "Vector3f", nm, Align, "x", "y", "z"),
        ["UnityEngine.Vector4"] = (n, l, nm) => Floats(n, l, "Vector4f", nm, Align, "x", "y", "z", "w"),
        ["UnityEngine.Quaternion"] = (n, l, nm) => Floats(n, l, "Quaternionf", nm, Align, "x", "y", "z", "w"),
        ["UnityEngine.Color"] = (n, l, nm) => Floats(n, l, "ColorRGBA", nm, Align, "r", "g", "b", "a"),
        ["UnityEngine.Rect"] = (n, l, nm) => Floats(n, l, "Rectf", nm, Align, "x", "y", "width", "height"),
        ["UnityEngine.Vector2Int"] = (n, l, nm) => Ints(n, l, "int2_storage", nm, Align, "m_X", "m_Y"),
        ["UnityEngine.Vector3Int"] = (n, l, nm) => Ints(n, l, "int3_storage", nm, Align, "m_X", "m_Y", "m_Z"),
        ["UnityEngine.RectInt"] = (n, l, nm) => Ints(n, l, "RectInt", nm, Align, "x", "y", "width", "height"),
        ["UnityEngine.RectOffset"] = (n, l, nm) => Ints(n, l, "RectOffset", nm, 0, "m_Left", "m_Right", "m_Top", "m_Bottom"),
        ["UnityEngine.Color32"] = (n, l, nm) => { n.Add(new(l, "ColorRGBA", nm, Align)); n.Add(new(l + 1, "UInt32", "rgba", 0)); },
        ["UnityEngine.LayerMask"] = (n, l, nm) => { n.Add(new(l, "BitField", nm, Align)); n.Add(new(l + 1, "UInt32", "m_Bits", 0)); },
        ["UnityEngine.PropertyName"] = (n, l, nm) => AddString(n, l, nm),
        ["UnityEngine.Bounds"] = (n, l, nm) =>
        {
            n.Add(new(l, "AABB", nm, Align));
            Floats(n, l + 1, "Vector3f", "m_Center", 0, "x", "y", "z");
            Floats(n, l + 1, "Vector3f", "m_Extent", 0, "x", "y", "z");
        },
        ["UnityEngine.BoundsInt"] = (n, l, nm) =>
        {
            n.Add(new(l, "BoundsInt", nm, Align));
            Ints(n, l + 1, "int3_storage", "m_Position", 0, "m_X", "m_Y", "m_Z");
            Ints(n, l + 1, "int3_storage", "m_Size", 0, "m_X", "m_Y", "m_Z");
        },
        ["UnityEngine.Matrix4x4"] = (n, l, nm) =>
        {
            n.Add(new(l, "Matrix4x4f", nm, Align));
            for (int r = 0; r < 4; r++) for (int c = 0; c < 4; c++) n.Add(new(l + 1, "float", $"e{r}{c}", 0));
        },
        ["UnityEngine.Hash128"] = (n, l, nm) =>
        {
            n.Add(new(l, "Hash128", nm, Align));
            for (int i = 0; i < 16; i++) n.Add(new(l + 1, "UInt8", $"bytes[{i}]", 0));
        },
        ["UnityEngine.Rendering.SphericalHarmonicsL2"] = (n, l, nm) =>
        {
            n.Add(new(l, "SphericalHarmonicsL2", nm, Align));
            for (int i = 0; i < 27; i++) n.Add(new(l + 1, "float", $"sh[{i,2}]", 0));
        },
        ["UnityEngine.Keyframe"] = (n, l, nm) => AddKeyframe(n, l, nm, Align),
        ["UnityEngine.AnimationCurve"] = (n, l, nm) =>
        {
            n.Add(new(l, "AnimationCurve", nm, 0));
            n.Add(new(l + 1, "vector", "m_Curve", 0));
            n.Add(new(l + 2, "Array", "Array", Align));
            n.Add(new(l + 3, "int", "size", 0));
            AddKeyframe(n, l + 3, "data", 0);
            n.Add(new(l + 1, "int", "m_PreInfinity", 0));
            n.Add(new(l + 1, "int", "m_PostInfinity", 0));
            n.Add(new(l + 1, "int", "m_RotationOrder", 0));
        },
        ["UnityEngine.Gradient"] = (n, l, nm) =>
        {
            // exact 2022.3 layout (verified against UnityPy's TPK for LineRenderer.colorGradient)
            n.Add(new(l, "Gradient", nm, 0));
            for (int i = 0; i < 8; i++) Floats(n, l + 1, "ColorRGBA", $"key{i}", 0, "r", "g", "b", "a");
            for (int i = 0; i < 8; i++) n.Add(new(l + 1, "UInt16", $"ctime{i}", 0));
            for (int i = 0; i < 8; i++) n.Add(new(l + 1, "UInt16", $"atime{i}", 0));
            n.Add(new(l + 1, "UInt8", "m_Mode", 0));
            n.Add(new(l + 1, "SInt8", "m_ColorSpace", 0));
            n.Add(new(l + 1, "UInt8", "m_NumColorKeys", 0));
            n.Add(new(l + 1, "UInt8", "m_NumAlphaKeys", Align));
        },
        ["UnityEngine.GUIStyle"] = AddGUIStyle,
    };

    static void AddKeyframe(List<Node> n, int l, string nm, int meta)
    {
        n.Add(new(l, "Keyframe", nm, meta));
        n.Add(new(l + 1, "float", "time", 0));
        n.Add(new(l + 1, "float", "value", 0));
        n.Add(new(l + 1, "float", "inSlope", 0));
        n.Add(new(l + 1, "float", "outSlope", 0));
        n.Add(new(l + 1, "int", "weightedMode", 0));
        n.Add(new(l + 1, "float", "inWeight", 0));
        n.Add(new(l + 1, "float", "outWeight", 0));
    }

    static void AddGUIStyle(List<Node> n, int l, string nm)
    {
        n.Add(new(l, "GUIStyle", nm, 0));
        AddString(n, l + 1, "m_Name");
        foreach (var s in new[] { "m_Normal", "m_Hover", "m_Active", "m_Focused", "m_OnNormal", "m_OnHover", "m_OnActive", "m_OnFocused" })
        {
            n.Add(new(l + 1, "GUIStyleState", s, 0));
            AddPPtr(n, l + 2, "Texture2D", "m_Background");
            n.Add(new(l + 2, "vector", "m_ScaledBackgrounds", 0));
            n.Add(new(l + 3, "Array", "Array", Align));
            n.Add(new(l + 4, "int", "size", 0));
            AddPPtr(n, l + 4, "Texture2D", "data");
            Floats(n, l + 2, "ColorRGBA", "m_TextColor", 0, "r", "g", "b", "a");
        }
        foreach (var s in new[] { "m_Border", "m_Margin", "m_Padding", "m_Overflow" })
            Ints(n, l + 1, "RectOffset", s, 0, "m_Left", "m_Right", "m_Top", "m_Bottom");
        AddPPtr(n, l + 1, "Font", "m_Font");
        n.Add(new(l + 1, "int", "m_FontSize", 0));
        n.Add(new(l + 1, "int", "m_FontStyle", 0));
        n.Add(new(l + 1, "int", "m_Alignment", 0));
        n.Add(new(l + 1, "bool", "m_WordWrap", 0));
        n.Add(new(l + 1, "bool", "m_RichText", Align));
        n.Add(new(l + 1, "int", "m_TextClipping", 0));
        n.Add(new(l + 1, "int", "m_ImagePosition", 0));
        Floats(n, l + 1, "Vector2f", "m_ContentOffset", 0, "x", "y");
        n.Add(new(l + 1, "float", "m_FixedWidth", 0));
        n.Add(new(l + 1, "float", "m_FixedHeight", 0));
        n.Add(new(l + 1, "bool", "m_StretchWidth", 0));
        n.Add(new(l + 1, "bool", "m_StretchHeight", Align));
    }
}
