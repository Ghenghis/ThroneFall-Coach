using System.Collections.Immutable;
using System.Reflection;
using System.Reflection.Metadata;
using System.Reflection.Metadata.Ecma335;
using System.Reflection.PortableExecutable;
using System.Security.Cryptography;

namespace TfMap;

/// <summary>One managed assembly loaded for metadata reading only (never executed).</summary>
sealed class Module
{
    public readonly string Name;
    public readonly string FilePath;
    public readonly PEReader PE;
    public readonly MetadataReader MD;
    public readonly Dictionary<string, TypeDefinitionHandle> Top = new(StringComparer.Ordinal);
    public readonly Dictionary<string, string> Forward = new(StringComparer.Ordinal);
    public readonly string Sha256;
    public readonly long Size;

    public static string Key(string ns, string name) => ns + "\u0000" + name;

    public Module(string path, PEReader pe)
    {
        FilePath = path;
        PE = pe;
        MD = pe.GetMetadataReader();
        Name = MD.IsAssembly ? MD.GetString(MD.GetAssemblyDefinition().Name) : Path.GetFileNameWithoutExtension(path);
        foreach (var h in MD.TypeDefinitions)
        {
            var td = MD.GetTypeDefinition(h);
            if (!td.GetDeclaringType().IsNil) continue;
            Top[Key(MD.GetString(td.Namespace), MD.GetString(td.Name))] = h;
        }
        foreach (var eh in MD.ExportedTypes)
        {
            var et = MD.GetExportedType(eh);
            if (!et.IsForwarder || et.Implementation.Kind != HandleKind.AssemblyReference) continue;
            var ar = MD.GetAssemblyReference((AssemblyReferenceHandle)et.Implementation);
            Forward[Key(MD.GetString(et.Namespace), MD.GetString(et.Name))] = MD.GetString(ar.Name);
        }
        var bytes = File.ReadAllBytes(path);
        Size = bytes.LongLength;
        Sha256 = Convert.ToHexString(SHA256.HashData(bytes));
    }
}

/// <summary>A resolved type definition: module + handle.</summary>
readonly record struct TDef(Module M, TypeDefinitionHandle H)
{
    public TypeDefinition Def => M.MD.GetTypeDefinition(H);
    public string Name => M.MD.GetString(Def.Name);
    public int Token => MetadataTokens.GetToken(H);
    public override string ToString() => $"{M.Name}:{Naming.FullName(this)}";
}

abstract class TypeSig { }
sealed class PrimSig : TypeSig { public readonly PrimitiveTypeCode Code; public PrimSig(PrimitiveTypeCode c) => Code = c; }
sealed class NamedSig : TypeSig
{
    public readonly Module Owner; public readonly EntityHandle Handle; public readonly string Ns; public readonly string Name; public readonly string? Outer;
    public NamedSig(Module owner, EntityHandle h, string ns, string name, string? outer) { Owner = owner; Handle = h; Ns = ns; Name = name; Outer = outer; }
}
sealed class GenInstSig : TypeSig { public readonly TypeSig Def; public readonly TypeSig[] Args; public GenInstSig(TypeSig d, TypeSig[] a) { Def = d; Args = a; } }
sealed class SZArraySig : TypeSig { public readonly TypeSig Elem; public SZArraySig(TypeSig e) => Elem = e; }
sealed class MDArraySig : TypeSig { public readonly TypeSig Elem; public readonly int Rank; public MDArraySig(TypeSig e, int r) { Elem = e; Rank = r; } }
sealed class PtrSig : TypeSig { public readonly TypeSig Elem; public readonly bool ByRef; public PtrSig(TypeSig e, bool byRef) { Elem = e; ByRef = byRef; } }
sealed class GenParamSig : TypeSig { public readonly int Index; public readonly bool Method; public readonly string Label; public GenParamSig(int i, bool m, string l) { Index = i; Method = m; Label = l; } }
sealed class OtherSig : TypeSig { public readonly string Text; public OtherSig(string t) => Text = t; }

/// <summary>Generic-parameter names used only for display.</summary>
sealed record SigCtx(Module M, string[] TypeParams, string[] MethodParams)
{
    public static SigCtx For(Module m) => new(m, Array.Empty<string>(), Array.Empty<string>());
}

sealed class SigProvider : ISignatureTypeProvider<TypeSig, SigCtx>, ICustomAttributeTypeProvider<TypeSig>
{
    readonly World W;
    public SigProvider(World w) => W = w;

    public TypeSig GetPrimitiveType(PrimitiveTypeCode typeCode) => new PrimSig(typeCode);
    public TypeSig GetSZArrayType(TypeSig elementType) => new SZArraySig(elementType);
    public TypeSig GetArrayType(TypeSig elementType, ArrayShape shape) => new MDArraySig(elementType, shape.Rank);
    public TypeSig GetByReferenceType(TypeSig elementType) => new PtrSig(elementType, true);
    public TypeSig GetPointerType(TypeSig elementType) => new PtrSig(elementType, false);
    public TypeSig GetPinnedType(TypeSig elementType) => elementType;
    public TypeSig GetModifiedType(TypeSig modifier, TypeSig unmodifiedType, bool isRequired) => unmodifiedType;
    public TypeSig GetFunctionPointerType(MethodSignature<TypeSig> signature) => new OtherSig("fnptr");
    public TypeSig GetGenericInstantiation(TypeSig genericType, ImmutableArray<TypeSig> typeArguments) => new GenInstSig(genericType, typeArguments.ToArray());
    public TypeSig GetGenericTypeParameter(SigCtx ctx, int index) =>
        new GenParamSig(index, false, ctx != null && index < ctx.TypeParams.Length ? ctx.TypeParams[index] : "!" + index);
    public TypeSig GetGenericMethodParameter(SigCtx ctx, int index) =>
        new GenParamSig(index, true, ctx != null && index < ctx.MethodParams.Length ? ctx.MethodParams[index] : "!!" + index);

    public TypeSig GetTypeFromDefinition(MetadataReader reader, TypeDefinitionHandle handle, byte rawTypeKind)
    {
        var m = W.Of(reader);
        var td = reader.GetTypeDefinition(handle);
        var decl = td.GetDeclaringType();
        string? outer = decl.IsNil ? null : Naming.FullName(new TDef(m, decl));
        string ns = decl.IsNil ? reader.GetString(td.Namespace) : "";
        return new NamedSig(m, handle, ns, reader.GetString(td.Name), outer);
    }

    public TypeSig GetTypeFromReference(MetadataReader reader, TypeReferenceHandle handle, byte rawTypeKind)
    {
        var m = W.Of(reader);
        var tr = reader.GetTypeReference(handle);
        string? outer = null;
        if (tr.ResolutionScope.Kind == HandleKind.TypeReference)
            outer = Naming.RefFullName(reader, (TypeReferenceHandle)tr.ResolutionScope);
        return new NamedSig(m, handle, reader.GetString(tr.Namespace), reader.GetString(tr.Name), outer);
    }

    public TypeSig GetTypeFromSpecification(MetadataReader reader, SigCtx ctx, TypeSpecificationHandle handle, byte rawTypeKind) =>
        reader.GetTypeSpecification(handle).DecodeSignature(this, ctx ?? SigCtx.For(W.Of(reader)));

    // ICustomAttributeTypeProvider
    public TypeSig GetSystemType() => new OtherSig("System.Type");
    public bool IsSystemType(TypeSig type) => type is OtherSig { Text: "System.Type" } || (type is NamedSig n && n.Ns == "System" && n.Name == "Type");
    public TypeSig GetTypeFromSerializedName(string name) => new OtherSig(name);
    public PrimitiveTypeCode GetUnderlyingEnumType(TypeSig type)
    {
        var d = W.ResolveSig(type);
        if (d is null) return PrimitiveTypeCode.Int32;
        var info = W.Info(d.Value);
        return info.IsEnum ? info.EnumUnderlying : PrimitiveTypeCode.Int32;
    }
}

/// <summary>Everything the mappers need to know about one type definition (computed once).</summary>
sealed class TInfo
{
    public TDef T;
    public string FullName = "";
    public string Ns = "";
    public string Name = "";
    public TypeSig? BaseSig;
    public List<string> BaseChain = new();
    public bool IsEnum, IsValueType, IsInterface, IsDelegate, IsAbstract, IsSealed, IsStatic, IsSerializableFlag;
    public int GenericParamCount;
    public string[] GenericParamNames = Array.Empty<string>();
    public bool IsUnityObject, IsMonoBehaviour, IsScriptableObject;
    public PrimitiveTypeCode EnumUnderlying = PrimitiveTypeCode.Int32;
}

sealed class World
{
    public readonly Dictionary<string, Module> Mods = new(StringComparer.OrdinalIgnoreCase);
    readonly Dictionary<MetadataReader, Module> byReader = new();
    readonly Dictionary<(Module, TypeReferenceHandle), TDef?> refCache = new();
    readonly Dictionary<TDef, TInfo> infoCache = new();
    public readonly SigProvider P;
    public readonly List<string> Skipped = new();

    public World(string managedDir)
    {
        P = new SigProvider(this);
        foreach (var path in Directory.GetFiles(managedDir, "*.dll").OrderBy(p => p, StringComparer.OrdinalIgnoreCase))
        {
            try
            {
                var pe = new PEReader(File.OpenRead(path));
                if (!pe.HasMetadata) { Skipped.Add(Path.GetFileName(path) + " (native)"); pe.Dispose(); continue; }
                var m = new Module(path, pe);
                if (Mods.ContainsKey(m.Name)) { Skipped.Add(Path.GetFileName(path) + " (duplicate name)"); continue; }
                Mods[m.Name] = m;
                byReader[m.MD] = m;
            }
            catch (Exception e) { Skipped.Add(Path.GetFileName(path) + " (" + e.GetType().Name + ")"); }
        }
    }

    public Module Of(MetadataReader r) => byReader[r];

    public TDef? FindTop(string asm, string ns, string name, int hops = 0)
    {
        if (hops > 8 || !Mods.TryGetValue(asm, out var m)) return null;
        var key = Module.Key(ns, name);
        if (m.Top.TryGetValue(key, out var h)) return new TDef(m, h);
        if (m.Forward.TryGetValue(key, out var fwd)) return FindTop(fwd, ns, name, hops + 1);
        return null;
    }

    /// <summary>Find a type by full name in any loaded assembly (first match, forwarders ignored).</summary>
    public TDef? FindAnywhere(string ns, string name)
    {
        var key = Module.Key(ns, name);
        foreach (var m in Mods.Values) if (m.Top.TryGetValue(key, out var h)) return new TDef(m, h);
        return null;
    }

    public TDef? ResolveRef(Module m, TypeReferenceHandle h)
    {
        if (refCache.TryGetValue((m, h), out var hit)) return hit;
        TDef? result = null;
        var tr = m.MD.GetTypeReference(h);
        string ns = m.MD.GetString(tr.Namespace), name = m.MD.GetString(tr.Name);
        var scope = tr.ResolutionScope;
        switch (scope.Kind)
        {
            case HandleKind.AssemblyReference:
                result = FindTop(m.MD.GetString(m.MD.GetAssemblyReference((AssemblyReferenceHandle)scope).Name), ns, name);
                break;
            case HandleKind.TypeReference:
                var outer = ResolveRef(m, (TypeReferenceHandle)scope);
                if (outer is { } o)
                    foreach (var nh in o.Def.GetNestedTypes())
                        if (o.M.MD.GetString(o.M.MD.GetTypeDefinition(nh).Name) == name) { result = new TDef(o.M, nh); break; }
                break;
            case HandleKind.ModuleDefinition:
            case HandleKind.ModuleReference:
                result = FindTop(m.Name, ns, name);
                break;
        }
        result ??= FindAnywhere(ns, name);
        refCache[(m, h)] = result;
        return result;
    }

    public TDef? ResolveHandle(Module m, EntityHandle h) => h.Kind switch
    {
        HandleKind.TypeDefinition => new TDef(m, (TypeDefinitionHandle)h),
        HandleKind.TypeReference => ResolveRef(m, (TypeReferenceHandle)h),
        HandleKind.TypeSpecification => ResolveSig(DecodeSpec(m, (TypeSpecificationHandle)h, SigCtx.For(m))),
        _ => null
    };

    public TypeSig DecodeSpec(Module m, TypeSpecificationHandle h, SigCtx ctx) => m.MD.GetTypeSpecification(h).DecodeSignature(P, ctx);

    /// <summary>Type handle (def/ref/spec) → TypeSig.</summary>
    public TypeSig SigOf(Module m, EntityHandle h, SigCtx ctx) => h.Kind switch
    {
        HandleKind.TypeDefinition => P.GetTypeFromDefinition(m.MD, (TypeDefinitionHandle)h, 0),
        HandleKind.TypeReference => P.GetTypeFromReference(m.MD, (TypeReferenceHandle)h, 0),
        HandleKind.TypeSpecification => DecodeSpec(m, (TypeSpecificationHandle)h, ctx),
        _ => new OtherSig("?" + h.Kind)
    };

    public TDef? ResolveSig(TypeSig s) => s switch
    {
        NamedSig n => ResolveHandle(n.Owner, n.Handle),
        GenInstSig g => ResolveSig(g.Def),
        _ => null
    };

    public SigCtx CtxFor(TDef t, string[]? methodParams = null)
    {
        var info = Info(t);
        return new SigCtx(t.M, info.GenericParamNames, methodParams ?? Array.Empty<string>());
    }

    public TInfo Info(TDef t)
    {
        if (infoCache.TryGetValue(t, out var hit)) return hit;
        var md = t.M.MD;
        var td = t.Def;
        var info = new TInfo { T = t, Name = md.GetString(td.Name) };
        infoCache[t] = info; // guard recursion
        info.FullName = Naming.FullName(t);
        info.Ns = Naming.TopNamespace(t);
        var a = td.Attributes;
        info.IsInterface = (a & TypeAttributes.Interface) != 0;
        info.IsAbstract = (a & TypeAttributes.Abstract) != 0;
        info.IsSealed = (a & TypeAttributes.Sealed) != 0;
        info.IsStatic = info.IsAbstract && info.IsSealed;
        info.IsSerializableFlag = (a & TypeAttributes.Serializable) != 0;
        var gps = td.GetGenericParameters();
        info.GenericParamCount = gps.Count;
        info.GenericParamNames = gps.Select(g => md.GetString(md.GetGenericParameter(g).Name)).ToArray();
        if (!td.BaseType.IsNil)
        {
            info.BaseSig = SigOf(t.M, td.BaseType, new SigCtx(t.M, info.GenericParamNames, Array.Empty<string>()));
            var cur = ResolveSig(info.BaseSig);
            int guard = 0;
            while (cur is { } c && guard++ < 64)
            {
                var fn = Naming.FullName(c);
                info.BaseChain.Add(fn);
                var cd = c.Def;
                if (cd.BaseType.IsNil) break;
                cur = ResolveHandle(c.M, cd.BaseType);
            }
        }
        var first = info.BaseChain.Count > 0 ? info.BaseChain[0] : "";
        info.IsEnum = first == "System.Enum";
        info.IsValueType = first == "System.ValueType" || info.IsEnum;
        info.IsDelegate = first == "System.MulticastDelegate" || first == "System.Delegate";
        info.IsUnityObject = info.FullName == "UnityEngine.Object" || info.BaseChain.Contains("UnityEngine.Object");
        info.IsMonoBehaviour = info.BaseChain.Contains("UnityEngine.MonoBehaviour");
        info.IsScriptableObject = info.BaseChain.Contains("UnityEngine.ScriptableObject");
        if (info.IsEnum)
        {
            foreach (var fh in td.GetFields())
            {
                var f = md.GetFieldDefinition(fh);
                if ((f.Attributes & FieldAttributes.Static) != 0) continue;
                if (f.DecodeSignature(P, SigCtx.For(t.M)) is PrimSig p) info.EnumUnderlying = p.Code;
            }
        }
        return info;
    }
}

static class Naming
{
    public static string FullName(TDef t)
    {
        var md = t.M.MD;
        var td = t.Def;
        var decl = td.GetDeclaringType();
        if (!decl.IsNil) return FullName(new TDef(t.M, decl)) + "/" + md.GetString(td.Name);
        var ns = md.GetString(td.Namespace);
        return ns.Length == 0 ? md.GetString(td.Name) : ns + "." + md.GetString(td.Name);
    }

    public static string TopNamespace(TDef t)
    {
        var cur = t;
        while (!cur.Def.GetDeclaringType().IsNil) cur = new TDef(cur.M, cur.Def.GetDeclaringType());
        return cur.M.MD.GetString(cur.Def.Namespace);
    }

    public static string RefFullName(MetadataReader md, TypeReferenceHandle h)
    {
        var tr = md.GetTypeReference(h);
        var name = md.GetString(tr.Name);
        if (tr.ResolutionScope.Kind == HandleKind.TypeReference) return RefFullName(md, (TypeReferenceHandle)tr.ResolutionScope) + "/" + name;
        var ns = md.GetString(tr.Namespace);
        return ns.Length == 0 ? name : ns + "." + name;
    }

    static readonly System.Text.RegularExpressions.Regex ArityRx = new(@"`\d+", System.Text.RegularExpressions.RegexOptions.Compiled);

    /// <summary>Removes every generic-arity marker (`1, `2 …), also inside nested type paths.</summary>
    public static string StripArity(string n) => n.IndexOf('`') < 0 ? n : ArityRx.Replace(n, "");

    static readonly Dictionary<PrimitiveTypeCode, string> Kw = new()
    {
        [PrimitiveTypeCode.Boolean] = "bool", [PrimitiveTypeCode.Byte] = "byte", [PrimitiveTypeCode.SByte] = "sbyte",
        [PrimitiveTypeCode.Char] = "char", [PrimitiveTypeCode.Int16] = "short", [PrimitiveTypeCode.UInt16] = "ushort",
        [PrimitiveTypeCode.Int32] = "int", [PrimitiveTypeCode.UInt32] = "uint", [PrimitiveTypeCode.Int64] = "long",
        [PrimitiveTypeCode.UInt64] = "ulong", [PrimitiveTypeCode.Single] = "float", [PrimitiveTypeCode.Double] = "double",
        [PrimitiveTypeCode.String] = "string", [PrimitiveTypeCode.Object] = "object", [PrimitiveTypeCode.Void] = "void",
        [PrimitiveTypeCode.IntPtr] = "IntPtr", [PrimitiveTypeCode.UIntPtr] = "UIntPtr", [PrimitiveTypeCode.TypedReference] = "TypedReference",
    };

    /// <summary>Short C#-like display: List&lt;Wave&gt;, int[], Outer.Inner.</summary>
    public static string Show(TypeSig t, bool full = false) => t switch
    {
        PrimSig p => Kw.TryGetValue(p.Code, out var k) ? k : p.Code.ToString(),
        NamedSig n => StripArity(n.Outer != null ? (full ? n.Outer.Replace('/', '.') : ShortOuter(n.Outer)) + "." + n.Name
                                                 : (full && n.Ns.Length > 0 ? n.Ns + "." + n.Name : n.Name)),
        GenInstSig g => Show(g.Def, full) + "<" + string.Join(", ", g.Args.Select(a => Show(a, full))) + ">",
        SZArraySig a => Show(a.Elem, full) + "[]",
        MDArraySig a => Show(a.Elem, full) + "[" + new string(',', Math.Max(0, a.Rank - 1)) + "]",
        PtrSig p => p.ByRef ? "ref " + Show(p.Elem, full) : Show(p.Elem, full) + "*",
        GenParamSig g => g.Label,
        OtherSig o => o.Text,
        _ => "?"
    };

    static string ShortOuter(string outer)
    {
        var parts = outer.Split('/');
        var first = parts[0];
        var dot = first.LastIndexOf('.');
        if (dot >= 0) parts[0] = first[(dot + 1)..];
        return string.Join(".", parts.Select(StripArity));
    }
}

static class Attrs
{
    public static (string ns, string name) TypeOf(Module m, CustomAttribute ca)
    {
        var md = m.MD;
        EntityHandle parent = default;
        if (ca.Constructor.Kind == HandleKind.MemberReference) parent = md.GetMemberReference((MemberReferenceHandle)ca.Constructor).Parent;
        else if (ca.Constructor.Kind == HandleKind.MethodDefinition) parent = md.GetMethodDefinition((MethodDefinitionHandle)ca.Constructor).GetDeclaringType();
        switch (parent.Kind)
        {
            case HandleKind.TypeReference:
                var tr = md.GetTypeReference((TypeReferenceHandle)parent);
                return (md.GetString(tr.Namespace), md.GetString(tr.Name));
            case HandleKind.TypeDefinition:
                var td = md.GetTypeDefinition((TypeDefinitionHandle)parent);
                return (md.GetString(td.Namespace), md.GetString(td.Name));
            default:
                return ("", "?");
        }
    }

    public static bool Has(Module m, CustomAttributeHandleCollection attrs, string ns, string name)
    {
        foreach (var h in attrs)
        {
            var (n, t) = TypeOf(m, m.MD.GetCustomAttribute(h));
            if (t == name && n == ns) return true;
        }
        return false;
    }

    /// <summary>Decoded attributes as compact strings, e.g. Tooltip("Seconds between spawns").</summary>
    public static List<string> Describe(World w, Module m, CustomAttributeHandleCollection attrs)
    {
        var list = new List<string>();
        foreach (var h in attrs)
        {
            var ca = m.MD.GetCustomAttribute(h);
            var (ns, name) = TypeOf(m, ca);
            if (name is "CompilerGeneratedAttribute" or "DebuggerBrowsableAttribute" or "DebuggerHiddenAttribute" or "DebuggerStepThroughAttribute"
                or "NullableAttribute" or "NullableContextAttribute" or "IsReadOnlyAttribute" or "AsyncStateMachineAttribute" or "IteratorStateMachineAttribute"
                or "TupleElementNamesAttribute" or "ParamArrayAttribute") continue;
            var shortName = name.EndsWith("Attribute") ? name[..^9] : name;
            string args = "";
            try
            {
                var v = ca.DecodeValue(w.P);
                var parts = v.FixedArguments.Select(a => Fmt(a.Value)).Concat(v.NamedArguments.Select(a => a.Name + "=" + Fmt(a.Value)));
                args = string.Join(", ", parts);
            }
            catch { args = "…"; }
            list.Add(args.Length > 0 ? $"{shortName}({args})" : shortName);
        }
        return list;
    }

    static string Fmt(object? v) => v switch
    {
        null => "null",
        string s => "\"" + s.Replace("\"", "\\\"") + "\"",
        TypeSig t => "typeof(" + Naming.Show(t) + ")",
        ImmutableArray<CustomAttributeTypedArgument<TypeSig>> arr => "[" + string.Join(", ", arr.Select(x => Fmt(x.Value))) + "]",
        bool b => b ? "true" : "false",
        float f => f.ToString("R", System.Globalization.CultureInfo.InvariantCulture) + "f",
        double d => d.ToString("R", System.Globalization.CultureInfo.InvariantCulture),
        _ => Convert.ToString(v, System.Globalization.CultureInfo.InvariantCulture) ?? "?"
    };

    public static object? Constant(MetadataReader md, ConstantHandle h)
    {
        if (h.IsNil) return null;
        var c = md.GetConstant(h);
        var br = md.GetBlobReader(c.Value);
        return c.TypeCode switch
        {
            ConstantTypeCode.Boolean => br.ReadBoolean(),
            ConstantTypeCode.Char => (int)br.ReadChar(),
            ConstantTypeCode.SByte => br.ReadSByte(),
            ConstantTypeCode.Byte => br.ReadByte(),
            ConstantTypeCode.Int16 => br.ReadInt16(),
            ConstantTypeCode.UInt16 => br.ReadUInt16(),
            ConstantTypeCode.Int32 => br.ReadInt32(),
            ConstantTypeCode.UInt32 => br.ReadUInt32(),
            ConstantTypeCode.Int64 => br.ReadInt64(),
            ConstantTypeCode.UInt64 => br.ReadUInt64(),
            ConstantTypeCode.Single => br.ReadSingle(),
            ConstantTypeCode.Double => br.ReadDouble(),
            ConstantTypeCode.String => br.ReadUTF16(br.Length),
            _ => null
        };
    }
}
