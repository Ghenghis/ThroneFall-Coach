using System.Reflection;
using System.Reflection.Metadata;
using System.Reflection.Metadata.Ecma335;
using System.Text.Json;

namespace TfMap;

/// <summary>Writes one JSON line per type: members, flags, attributes, Unity roles.</summary>
static class Dump
{
    static readonly HashSet<string> UnityMessages = new(StringComparer.Ordinal)
    {
        "Awake","Start","Update","FixedUpdate","LateUpdate","OnEnable","OnDisable","OnDestroy","OnGUI","OnValidate","Reset",
        "OnApplicationFocus","OnApplicationPause","OnApplicationQuit","OnBecameVisible","OnBecameInvisible",
        "OnCollisionEnter","OnCollisionStay","OnCollisionExit","OnCollisionEnter2D","OnCollisionStay2D","OnCollisionExit2D",
        "OnTriggerEnter","OnTriggerStay","OnTriggerExit","OnTriggerEnter2D","OnTriggerStay2D","OnTriggerExit2D",
        "OnMouseDown","OnMouseUp","OnMouseEnter","OnMouseExit","OnMouseOver","OnMouseDrag","OnMouseUpAsButton",
        "OnDrawGizmos","OnDrawGizmosSelected","OnParticleCollision","OnParticleTrigger","OnTransformParentChanged","OnTransformChildrenChanged",
        "OnBeforeTransformParentChanged","OnRenderObject","OnPreRender","OnPostRender","OnPreCull","OnRenderImage","OnWillRenderObject",
        "OnAnimatorMove","OnAnimatorIK","OnAudioFilterRead","OnJointBreak","OnControllerColliderHit","OnDidApplyAnimationProperties","OnRectTransformDimensionsChange"
    };

    static readonly string[] SingletonNames = { "instance", "singleton", "current" };

    public static string Vis(TypeAttributes a) => (a & TypeAttributes.VisibilityMask) switch
    {
        TypeAttributes.Public => "public",
        TypeAttributes.NestedPublic => "public",
        TypeAttributes.NestedPrivate => "private",
        TypeAttributes.NestedFamily => "protected",
        TypeAttributes.NestedAssembly => "internal",
        TypeAttributes.NestedFamANDAssem => "private protected",
        TypeAttributes.NestedFamORAssem => "protected internal",
        _ => "internal"
    };

    static string Access(MethodAttributes a) => (a & MethodAttributes.MemberAccessMask) switch
    {
        MethodAttributes.Public => "public",
        MethodAttributes.Family => "protected",
        MethodAttributes.Assembly => "internal",
        MethodAttributes.FamORAssem => "protected internal",
        MethodAttributes.FamANDAssem => "private protected",
        _ => "private"
    };

    static string Access(FieldAttributes a) => (a & FieldAttributes.FieldAccessMask) switch
    {
        FieldAttributes.Public => "public",
        FieldAttributes.Family => "protected",
        FieldAttributes.Assembly => "internal",
        FieldAttributes.FamORAssem => "protected internal",
        FieldAttributes.FamANDAssem => "private protected",
        _ => "private"
    };

    public static string Kind(TInfo i) => i.IsEnum ? "enum" : i.IsInterface ? "interface" : i.IsDelegate ? "delegate" : i.IsValueType ? "struct" : "class";

    public static string TokenHex(int token) => "0x" + token.ToString("X8");

    static void Strs(Utf8JsonWriter j, string name, IEnumerable<string> items)
    {
        var list = items.ToList();
        if (list.Count == 0) return;
        j.WriteStartArray(name);
        foreach (var s in list) j.WriteStringValue(s);
        j.WriteEndArray();
    }

    static void WriteValue(Utf8JsonWriter j, string name, object? v)
    {
        switch (v)
        {
            case null: return;
            case bool b: j.WriteBoolean(name, b); break;
            case string s: j.WriteString(name, s); break;
            case float f: if (float.IsFinite(f)) j.WriteNumber(name, f); else j.WriteString(name, f.ToString()); break;
            case double d: if (double.IsFinite(d)) j.WriteNumber(name, d); else j.WriteString(name, d.ToString()); break;
            case ulong ul: j.WriteNumber(name, ul); break;
            case long l: j.WriteNumber(name, l); break;
            case uint ui: j.WriteNumber(name, ui); break;
            case int i: j.WriteNumber(name, i); break;
            case short sh: j.WriteNumber(name, sh); break;
            case ushort us: j.WriteNumber(name, us); break;
            case byte by: j.WriteNumber(name, by); break;
            case sbyte sb: j.WriteNumber(name, sb); break;
            default: j.WriteString(name, Convert.ToString(v, System.Globalization.CultureInfo.InvariantCulture)); break;
        }
    }

    /// <summary>Compiler-generated logical owner: "&lt;Foo&gt;d__3" / "&lt;Foo&gt;b__0" → "Foo".</summary>
    public static string LogicalName(string typeName, string methodName)
    {
        static string? Inner(string s)
        {
            if (s.Length < 3 || s[0] != '<') return null;
            int e = s.IndexOf('>');
            return e > 1 ? s[1..e] : null;
        }
        return Inner(methodName) ?? Inner(typeName) ?? methodName;
    }

    /// <summary>Top-level non-compiler-generated type that encloses a (possibly nested) compiler-generated type.</summary>
    public static TDef Enclosing(TDef t)
    {
        var cur = t;
        while (true)
        {
            var decl = cur.Def.GetDeclaringType();
            if (decl.IsNil) return cur;
            var name = cur.M.MD.GetString(cur.Def.Name);
            if (!name.StartsWith("<") && !name.Contains("d__") && !name.Contains("DisplayClass")) return cur;
            cur = new TDef(cur.M, decl);
        }
    }

    public static void WriteType(Utf8JsonWriter j, World w, Disassembler dis, TDef t, TInfo info, bool summaryOnly,
        Func<MethodDefinitionHandle, XMethod?> xOf)
    {
        var m = t.M;
        var md = m.MD;
        var td = t.Def;
        j.WriteStartObject();
        j.WriteString("tok", TokenHex(t.Token));
        j.WriteString("asm", m.Name);
        j.WriteString("ns", info.Ns);
        j.WriteString("name", info.Name);
        j.WriteString("full", info.FullName);
        j.WriteString("kind", Kind(info));
        j.WriteString("vis", Vis(td.Attributes));
        if (summaryOnly) { j.WriteBoolean("vendor", true); j.WriteEndObject(); return; }

        var fl = new List<string>();
        if (info.IsStatic) fl.Add("static"); else { if (info.IsAbstract && !info.IsInterface) fl.Add("abstract"); if (info.IsSealed && !info.IsValueType) fl.Add("sealed"); }
        if (info.IsSerializableFlag) fl.Add("serializable");
        Strs(j, "flags", fl);
        if (info.BaseChain.Count > 0) j.WriteString("base", info.BaseChain[0]);
        if (info.BaseChain.Count > 1) Strs(j, "baseChain", info.BaseChain);
        var ifaces = td.GetInterfaceImplementations().Select(ih =>
        {
            try { return Naming.Show(w.SigOf(m, md.GetInterfaceImplementation(ih).Interface, w.CtxFor(t)), true); } catch { return "?"; }
        });
        Strs(j, "interfaces", ifaces);
        Strs(j, "generic", info.GenericParamNames);
        string? role = info.IsMonoBehaviour ? "MonoBehaviour" : info.IsScriptableObject ? "ScriptableObject" : info.IsUnityObject ? "UnityObject" : null;
        if (role != null) j.WriteString("unity", role);
        var decl = td.GetDeclaringType();
        if (!decl.IsNil) j.WriteString("declaring", Naming.FullName(new TDef(m, decl)));
        Strs(j, "attrs", Attrs.Describe(w, m, td.GetCustomAttributes()));

        // enum members
        if (info.IsEnum)
        {
            j.WriteStartArray("values");
            foreach (var fh in td.GetFields())
            {
                var f = md.GetFieldDefinition(fh);
                if ((f.Attributes & FieldAttributes.Literal) == 0) continue;
                j.WriteStartObject();
                j.WriteString("n", md.GetString(f.Name));
                WriteValue(j, "v", Attrs.Constant(md, f.GetDefaultValue()));
                j.WriteEndObject();
            }
            j.WriteEndArray();
            j.WriteEndObject();
            return;
        }

        var ctx = w.CtxFor(t);
        string? singleton = null;

        // fields
        j.WriteStartArray("fields");
        foreach (var fh in td.GetFields())
        {
            var f = md.GetFieldDefinition(fh);
            var name = md.GetString(f.Name);
            TypeSig ft;
            try { ft = f.DecodeSignature(w.P, ctx); } catch { ft = new OtherSig("?"); }
            j.WriteStartObject();
            j.WriteString("tok", TokenHex(MetadataTokens.GetToken(fh)));
            j.WriteString("n", name);
            j.WriteString("t", Naming.Show(ft, true));
            var ff = new List<string> { Access(f.Attributes) };
            if ((f.Attributes & FieldAttributes.Static) != 0) ff.Add("static");
            if ((f.Attributes & FieldAttributes.Literal) != 0) ff.Add("const");
            else if ((f.Attributes & FieldAttributes.InitOnly) != 0) ff.Add("readonly");
            if ((f.Attributes & FieldAttributes.NotSerialized) != 0) ff.Add("nonserialized");
            Strs(j, "fl", ff);
            if ((info.IsUnityObject || info.IsSerializableFlag) && LayoutBuilder.IsSerializedDecl(m, f, out bool serRef))
            {
                j.WriteBoolean("ser", true);
                if (serRef) j.WriteBoolean("serRef", true);
            }
            Strs(j, "attrs", Attrs.Describe(w, m, f.GetCustomAttributes()));
            if ((f.Attributes & FieldAttributes.Literal) != 0) WriteValue(j, "const", Attrs.Constant(md, f.GetDefaultValue()));
            j.WriteEndObject();

            if (singleton == null && (f.Attributes & FieldAttributes.Static) != 0 && ft is NamedSig ns2
                && ns2.Name == info.Name.Split('`')[0] && SingletonNames.Any(s => name.Contains(s, StringComparison.OrdinalIgnoreCase)))
                singleton = "field:" + name;
        }
        j.WriteEndArray();

        // properties
        var props = td.GetProperties().ToList();
        if (props.Count > 0)
        {
            j.WriteStartArray("props");
            foreach (var ph in props)
            {
                var p = md.GetPropertyDefinition(ph);
                var acc = p.GetAccessors();
                TypeSig pt;
                try { pt = p.DecodeSignature(w.P, ctx).ReturnType; } catch { pt = new OtherSig("?"); }
                var pname = md.GetString(p.Name);
                j.WriteStartObject();
                j.WriteString("n", pname);
                j.WriteString("t", Naming.Show(pt, true));
                if (!acc.Getter.IsNil) j.WriteString("get", TokenHex(MetadataTokens.GetToken(acc.Getter)));
                if (!acc.Setter.IsNil) j.WriteString("set", TokenHex(MetadataTokens.GetToken(acc.Setter)));
                j.WriteEndObject();
                if (singleton == null && !acc.Getter.IsNil && pt is NamedSig pn && pn.Name == info.Name.Split('`')[0]
                    && (md.GetMethodDefinition(acc.Getter).Attributes & MethodAttributes.Static) != 0
                    && SingletonNames.Any(s => pname.Contains(s, StringComparison.OrdinalIgnoreCase)))
                    singleton = "property:" + pname;
            }
            j.WriteEndArray();
        }
        if (singleton != null) j.WriteString("singleton", singleton);

        // events
        var evs = td.GetEvents().ToList();
        if (evs.Count > 0)
        {
            j.WriteStartArray("events");
            foreach (var eh in evs)
            {
                var e = md.GetEventDefinition(eh);
                j.WriteStartObject();
                j.WriteString("n", md.GetString(e.Name));
                try { j.WriteString("t", Naming.Show(w.SigOf(m, e.Type, ctx), true)); } catch { }
                j.WriteEndObject();
            }
            j.WriteEndArray();
        }

        // methods
        j.WriteStartArray("methods");
        foreach (var mh in td.GetMethods())
        {
            var def = md.GetMethodDefinition(mh);
            var name = md.GetString(def.Name);
            MethodSignature<TypeSig> sig;
            string[] gpNames = def.GetGenericParameters().Select(g => md.GetString(md.GetGenericParameter(g).Name)).ToArray();
            try { sig = def.DecodeSignature(w.P, new SigCtx(m, info.GenericParamNames, gpNames)); }
            catch { continue; }
            var pnames = new string[sig.ParameterTypes.Length];
            foreach (var ph in def.GetParameters())
            {
                var par = md.GetParameter(ph);
                if (par.SequenceNumber >= 1 && par.SequenceNumber <= pnames.Length) pnames[par.SequenceNumber - 1] = md.GetString(par.Name);
            }
            var ps = sig.ParameterTypes.Select((pt, i) => $"{Naming.Show(pt)} {pnames[i] ?? "p" + i}");
            var generic = gpNames.Length > 0 ? "<" + string.Join(",", gpNames) + ">" : "";
            j.WriteStartObject();
            j.WriteString("tok", TokenHex(MetadataTokens.GetToken(mh)));
            j.WriteString("n", name);
            j.WriteString("sig", $"{Naming.Show(sig.ReturnType)} {name}{generic}({string.Join(", ", ps)})");
            j.WriteString("key", dis.DefKey(m, mh));
            var a = def.Attributes;
            var mf = new List<string> { Access(a) };
            if ((a & MethodAttributes.Static) != 0) mf.Add("static");
            bool isVirtual = (a & MethodAttributes.Virtual) != 0;
            if ((a & MethodAttributes.Abstract) != 0) mf.Add("abstract");
            else if (isVirtual) mf.Add((a & MethodAttributes.NewSlot) != 0 ? "virtual" : "override");
            if ((a & MethodAttributes.Final) != 0) mf.Add("final");
            if ((a & MethodAttributes.PinvokeImpl) != 0) mf.Add("extern");
            var impl = def.ImplAttributes;
            if ((impl & MethodImplAttributes.NoInlining) != 0) mf.Add("noinlining");
            if ((impl & MethodImplAttributes.AggressiveInlining) != 0) mf.Add("aggressiveinlining");
            if ((impl & MethodImplAttributes.InternalCall) != 0) mf.Add("internalcall");
            Strs(j, "fl", mf);
            j.WriteNumber("rva", def.RelativeVirtualAddress);
            bool unityMsg = (info.IsMonoBehaviour || info.IsScriptableObject) && UnityMessages.Contains(name);
            if (unityMsg) j.WriteBoolean("unityMsg", true);
            var x = xOf(mh);
            if (x != null)
            {
                j.WriteNumber("id", x.Id);
                if (x.HasBody)
                {
                    j.WriteNumber("il", x.IlSize);
                    if (x.EhCount > 0) j.WriteNumber("eh", x.EhCount);
                    // Heuristic (NOT measured): Mono may inline short, non-virtual, EH-free methods, which makes a Harmony patch miss those call sites.
                    bool risk = !isVirtual && (a & MethodAttributes.Abstract) == 0 && x.IlSize <= 32 && x.EhCount == 0 && (impl & MethodImplAttributes.NoInlining) == 0
                                && (impl & MethodImplAttributes.InternalCall) == 0;
                    if (risk) j.WriteBoolean("inlineRisk", true);
                }
                if (x.Logical != info.FullName + "::" + name) j.WriteString("logical", x.Logical);
            }
            Strs(j, "attrs", Attrs.Describe(w, m, def.GetCustomAttributes()));
            j.WriteEndObject();
        }
        j.WriteEndArray();

        var nested = td.GetNestedTypes().Select(n => md.GetString(md.GetTypeDefinition(n).Name)).ToList();
        Strs(j, "nested", nested);
        j.WriteEndObject();
    }
}
