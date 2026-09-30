using System.Diagnostics;
using System.Reflection;
using System.Reflection.Metadata;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Text.Encodings.Web;
using System.Text.Json;

namespace TfMap;

static class Program
{
    static readonly string[] DefaultFull = { "Assembly-CSharp", "Assembly-CSharp-firstpass", "KB.FogRTS.Runtime" };
    static readonly string[] DefaultVendor = { "Epic.OnlineServices", "I2", "Rewired", "NGS", "FlatKit", "Ara", "MoreMountains" };
    static readonly JsonWriterOptions JOpt = new() { Indented = false, Encoder = JavaScriptEncoder.UnsafeRelaxedJsonEscaping };
    static readonly JsonWriterOptions JOptPretty = new() { Indented = true, Encoder = JavaScriptEncoder.UnsafeRelaxedJsonEscaping };

    const string Usage = @"TfMap <ManagedDir> <OutDir> [--full A,B] [--members X,Y] [--vendor NS,NS] [--no-il] [--no-xrefs] [--no-layouts]
  --full     assemblies dumped with IL + xrefs for game namespaces   (default Assembly-CSharp,Assembly-CSharp-firstpass,KB.FogRTS.Runtime)
  --members  assemblies dumped with members only (no IL)              (e.g. AstarPathfindingProject)
  --vendor   namespace prefixes summarised instead of dumped          (default Epic.OnlineServices,I2,Rewired,NGS,FlatKit,Ara,MoreMountains)";

    static int Main(string[] args)
    {
        var pos = new List<string>();
        var opts = new Dictionary<string, string>();
        var flags = new HashSet<string>();
        for (int i = 0; i < args.Length; i++)
        {
            var a = args[i];
            if (a.StartsWith("--"))
            {
                if (a is "--full" or "--members" or "--vendor" && i + 1 < args.Length) opts[a] = args[++i];
                else flags.Add(a);
            }
            else pos.Add(a);
        }
        if (pos.Count < 2) { Console.Error.WriteLine(Usage); return 2; }

        string managed = pos[0], outDir = pos[1];
        var full = (opts.TryGetValue("--full", out var f) ? f.Split(',', StringSplitOptions.RemoveEmptyEntries) : DefaultFull).ToHashSet(StringComparer.OrdinalIgnoreCase);
        var members = (opts.TryGetValue("--members", out var mm) ? mm.Split(',', StringSplitOptions.RemoveEmptyEntries) : Array.Empty<string>()).ToHashSet(StringComparer.OrdinalIgnoreCase);
        var vendor = opts.TryGetValue("--vendor", out var v) ? v.Split(',', StringSplitOptions.RemoveEmptyEntries) : DefaultVendor;
        bool doIl = !flags.Contains("--no-il"), doX = !flags.Contains("--no-xrefs"), doLayouts = !flags.Contains("--no-layouts");

        var sw = Stopwatch.StartNew();
        Directory.CreateDirectory(outDir);
        var W = new World(managed);
        Console.WriteLine($"loaded {W.Mods.Count} managed assemblies from {managed} in {sw.ElapsedMilliseconds} ms; skipped {W.Skipped.Count}");

        var summary = new SortedDictionary<string, object?>
        {
            ["managedDir"] = managed, ["assemblies"] = W.Mods.Count, ["skipped"] = W.Skipped,
            ["full"] = full.ToArray(), ["members"] = members.ToArray(), ["vendorPrefixes"] = vendor
        };

        WriteAssemblies(W, Path.Combine(outDir, "assemblies.json"), full, members);

        var dis = new Disassembler(W);
        int nextId = 0;
        var callers = new SortedDictionary<string, SortedSet<int>>(StringComparer.Ordinal);
        var fieldR = new SortedDictionary<string, SortedSet<int>>(StringComparer.Ordinal);
        var fieldW = new SortedDictionary<string, SortedSet<int>>(StringComparer.Ordinal);
        long typeCount = 0, methodCount = 0, ilBytes = 0, bodies = 0;
        Directory.CreateDirectory(Path.Combine(outDir, "code"));

        foreach (var m in W.Mods.Values.Where(x => full.Contains(x.Name) || members.Contains(x.Name)))
        {
            bool isFull = full.Contains(m.Name);
            var codeDir = Path.Combine(outDir, "code");
            var ilDir = Path.Combine(outDir, "il", m.Name);
            if (isFull && doIl) Directory.CreateDirectory(ilDir);
            var ilByOuter = new Dictionary<TypeDefinitionHandle, StringBuilder>();
            var xmethods = new List<XMethod>();
            var xOf = new Dictionary<MethodDefinitionHandle, XMethod>();

            using var typesStream = File.Create(Path.Combine(codeDir, m.Name + ".types.jsonl"));
            var jw = new Utf8JsonWriter(typesStream, JOpt);

            foreach (var th in m.MD.TypeDefinitions)
            {
                var t = new TDef(m, th);
                var info = W.Info(t);
                bool isVendor = IsVendor(info.Ns, vendor);
                typeCount++;
                if (isFull && !isVendor && (doIl || doX))
                {
                    var outer = th;
                    while (!m.MD.GetTypeDefinition(outer).GetDeclaringType().IsNil) outer = m.MD.GetTypeDefinition(outer).GetDeclaringType();
                    if (!ilByOuter.TryGetValue(outer, out var sb)) ilByOuter[outer] = sb = new StringBuilder();
                    if (doIl) sb.AppendLine($"// ===== {info.FullName}  (token {Dump.TokenHex(t.Token)}) =====");
                    var encl = Dump.Enclosing(t);
                    foreach (var mh in t.Def.GetMethods())
                    {
                        var def = m.MD.GetMethodDefinition(mh);
                        var name = m.MD.GetString(def.Name);
                        var x = new XMethod { Id = nextId++, Token = MetadataTokens.GetToken(mh), Key = dis.DefKey(m, mh), TypeKey = info.FullName };
                        x.Logical = W.Info(encl).FullName + "::" + Dump.LogicalName(info.Name, name);
                        xOf[mh] = x;
                        methodCount++;
                        StringBuilder? body = doIl ? new StringBuilder() : null;
                        bool has = dis.Decode(m, mh, doX ? x : null, body);
                        if (doIl)
                        {
                            sb.AppendLine($"  .method {x.Key}  // token {Dump.TokenHex(x.Token)} rva 0x{def.RelativeVirtualAddress:x} attrs {def.Attributes}");
                            if (has) sb.Append(body); else sb.AppendLine("    // no body (abstract / extern / interface)");
                            sb.AppendLine();
                        }
                        if (has) { bodies++; ilBytes += x.IlSize; }
                        if (doX)
                        {
                            xmethods.Add(x);
                            foreach (var c in x.Calls) Add(callers, c.callee, x.Id);
                            foreach (var fa in x.Fields) Add(fa.mode == 'w' ? fieldW : fieldR, fa.field, x.Id);
                        }
                    }
                }
                jw.Reset(typesStream);
                Dump.WriteType(jw, W, dis, t, info, summaryOnly: isVendor, mh => xOf.TryGetValue(mh, out var xm) ? xm : null);
                jw.Flush();
                typesStream.WriteByte((byte)'\n');
            }
            jw.Dispose();

            if (isFull && doIl)
            {
                var used = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
                var index = new StringBuilder();
                foreach (var kv in ilByOuter.OrderBy(k => W.Info(new TDef(m, k.Key)).FullName, StringComparer.Ordinal))
                {
                    var full0 = W.Info(new TDef(m, kv.Key)).FullName;
                    var file = Sanitize(full0);
                    if (!used.Add(file)) file += "__" + Dump.TokenHex(MetadataTokens.GetToken(kv.Key));
                    used.Add(file);
                    File.WriteAllText(Path.Combine(ilDir, file + ".il"), kv.Value.ToString(), new UTF8Encoding(false));
                    index.AppendLine($"{file}.il\t{full0}\t{kv.Value.Length}");
                }
                File.WriteAllText(Path.Combine(ilDir, "_index.tsv"), index.ToString(), new UTF8Encoding(false));
            }

            if (isFull && doX)
            {
                using var tsv = new StreamWriter(Path.Combine(codeDir, m.Name + ".methods.tsv"), false, new UTF8Encoding(false));
                tsv.WriteLine("id\ttoken\ttype\tkey\tlogical\till\tlocals\tmaxstack\teh");
                foreach (var x in xmethods)
                    tsv.WriteLine($"{x.Id}\t{Dump.TokenHex(x.Token)}\t{x.TypeKey}\t{x.Key}\t{x.Logical}\t{x.IlSize}\t{x.Locals}\t{x.MaxStack}\t{x.EhCount}");

                using var xs = File.Create(Path.Combine(codeDir, m.Name + ".xrefs.jsonl"));
                var xw = new Utf8JsonWriter(xs, JOpt);
                foreach (var x in xmethods)
                {
                    if (x.Calls.Count + x.Fields.Count + x.Strings.Count + x.Types.Count == 0) continue;
                    xw.Reset(xs);
                    xw.WriteStartObject();
                    xw.WriteNumber("id", x.Id);
                    if (x.Calls.Count > 0) { xw.WriteStartArray("calls"); foreach (var c in x.Calls) { xw.WriteStartArray(); xw.WriteStringValue(c.callee); xw.WriteNumberValue(c.off); xw.WriteStringValue(c.op); xw.WriteEndArray(); } xw.WriteEndArray(); }
                    if (x.Fields.Count > 0) { xw.WriteStartArray("fields"); foreach (var c in x.Fields) { xw.WriteStartArray(); xw.WriteStringValue(c.field); xw.WriteNumberValue(c.off); xw.WriteStringValue(c.mode.ToString()); xw.WriteEndArray(); } xw.WriteEndArray(); }
                    if (x.Strings.Count > 0) { xw.WriteStartArray("strings"); foreach (var c in x.Strings) { xw.WriteStartArray(); xw.WriteNumberValue(c.off); xw.WriteStringValue(c.text); xw.WriteEndArray(); } xw.WriteEndArray(); }
                    if (x.Types.Count > 0) { xw.WriteStartArray("types"); foreach (var c in x.Types) { xw.WriteStartArray(); xw.WriteStringValue(c.type); xw.WriteNumberValue(c.off); xw.WriteStringValue(c.kind); xw.WriteEndArray(); } xw.WriteEndArray(); }
                    xw.WriteEndObject();
                    xw.Flush();
                    xs.WriteByte((byte)'\n');
                }
                xw.Dispose();
            }
            Console.WriteLine($"  {m.Name}: {typeCount} types so far, {methodCount} methods with ids, {bodies} bodies, {ilBytes:N0} IL bytes  [{sw.Elapsed.TotalSeconds:F1}s]");
        }

        if (doX)
        {
            WriteIndex(Path.Combine(outDir, "code", "callers.json"), callers);
            WriteIndex(Path.Combine(outDir, "code", "field_readers.json"), fieldR);
            WriteIndex(Path.Combine(outDir, "code", "field_writers.json"), fieldW);
            summary["callees"] = callers.Count;
            summary["fieldsRead"] = fieldR.Count;
            summary["fieldsWritten"] = fieldW.Count;
        }

        summary["types"] = typeCount; summary["methodsWithIds"] = methodCount; summary["methodBodies"] = bodies; summary["ilBytes"] = ilBytes;
        summary["enumsAllAssemblies"] = WriteAllEnums(W, Path.Combine(outDir, "code", "enums_all.json"));

        if (doLayouts) WriteLayouts(W, outDir, summary);

        summary["elapsedSeconds"] = Math.Round(sw.Elapsed.TotalSeconds, 1);
        File.WriteAllText(Path.Combine(outDir, "summary.json"), JsonSerializer.Serialize(summary, new JsonSerializerOptions { WriteIndented = true }), new UTF8Encoding(false));
        Console.WriteLine($"done in {sw.Elapsed.TotalSeconds:F1}s → {outDir}");
        return 0;
    }

    /// <summary>Every enum of every loaded assembly (Unity, Rewired, game): { "Assembly|Full.Name": { "underlying": "int", "values": [[name, value], ...] } }.</summary>
    static int WriteAllEnums(World W, string path)
    {
        int n = 0;
        using var fs = File.Create(path);
        using var j = new Utf8JsonWriter(fs, JOpt);
        j.WriteStartObject();
        foreach (var m in W.Mods.Values.OrderBy(x => x.Name, StringComparer.OrdinalIgnoreCase))
            foreach (var th in m.MD.TypeDefinitions)
            {
                var t = new TDef(m, th);
                var info = W.Info(t);
                if (!info.IsEnum) continue;
                n++;
                j.WriteStartObject(m.Name + "|" + info.FullName);
                j.WriteString("underlying", info.EnumUnderlying.ToString());
                j.WriteStartArray("values");
                foreach (var fh in t.Def.GetFields())
                {
                    var f = m.MD.GetFieldDefinition(fh);
                    if ((f.Attributes & FieldAttributes.Literal) == 0) continue;
                    j.WriteStartArray();
                    j.WriteStringValue(m.MD.GetString(f.Name));
                    switch (Attrs.Constant(m.MD, f.GetDefaultValue()))
                    {
                        case long l: j.WriteNumberValue(l); break;
                        case ulong ul: j.WriteNumberValue(ul); break;
                        case int i: j.WriteNumberValue(i); break;
                        case uint ui: j.WriteNumberValue(ui); break;
                        case short s: j.WriteNumberValue(s); break;
                        case ushort us: j.WriteNumberValue(us); break;
                        case byte b: j.WriteNumberValue(b); break;
                        case sbyte sb: j.WriteNumberValue(sb); break;
                        default: j.WriteNullValue(); break;
                    }
                    j.WriteEndArray();
                }
                j.WriteEndArray();
                j.WriteEndObject();
            }
        j.WriteEndObject();
        return n;
    }

    static void Add(SortedDictionary<string, SortedSet<int>> d, string key, int id)
    {
        if (!d.TryGetValue(key, out var set)) d[key] = set = new SortedSet<int>();
        set.Add(id);
    }

    static void WriteIndex(string path, SortedDictionary<string, SortedSet<int>> d)
    {
        using var fs = File.Create(path);
        using var j = new Utf8JsonWriter(fs, JOpt);
        j.WriteStartObject();
        foreach (var kv in d)
        {
            j.WriteStartArray(kv.Key);
            foreach (var id in kv.Value) j.WriteNumberValue(id);
            j.WriteEndArray();
        }
        j.WriteEndObject();
    }

    static bool IsVendor(string ns, string[] prefixes) => prefixes.Any(p => ns == p || ns.StartsWith(p + ".", StringComparison.Ordinal));

    static string Sanitize(string s)
    {
        var sb = new StringBuilder(s.Length);
        foreach (var c in s) sb.Append(Path.GetInvalidFileNameChars().Contains(c) || c is '<' or '>' or '"' ? '_' : c);
        var r = sb.ToString();
        return r.Length > 150 ? r[..150] : r;
    }

    static void WriteAssemblies(World W, string path, HashSet<string> full, HashSet<string> members)
    {
        using var fs = File.Create(path);
        using var j = new Utf8JsonWriter(fs, JOptPretty);
        j.WriteStartObject();
        j.WriteStartArray("assemblies");
        foreach (var m in W.Mods.Values.OrderBy(x => x.Name, StringComparer.OrdinalIgnoreCase))
        {
            var md = m.MD;
            j.WriteStartObject();
            j.WriteString("name", m.Name);
            j.WriteString("file", Path.GetFileName(m.FilePath));
            j.WriteNumber("size", m.Size);
            j.WriteString("sha256", m.Sha256);
            j.WriteString("lastWriteUtc", File.GetLastWriteTimeUtc(m.FilePath).ToString("u"));
            if (md.IsAssembly) j.WriteString("version", md.GetAssemblyDefinition().Version.ToString());
            j.WriteString("mvid", md.GetGuid(md.GetModuleDefinition().Mvid).ToString());
            j.WriteNumber("types", md.TypeDefinitions.Count);
            j.WriteNumber("methods", md.MethodDefinitions.Count);
            j.WriteNumber("fields", md.FieldDefinitions.Count);
            j.WriteString("dump", full.Contains(m.Name) ? "full" : members.Contains(m.Name) ? "members" : "none");
            j.WriteStartArray("references");
            foreach (var rh in md.AssemblyReferences) j.WriteStringValue(md.GetString(md.GetAssemblyReference(rh).Name));
            j.WriteEndArray();
            j.WriteEndObject();
        }
        j.WriteEndArray();
        j.WriteStartArray("skipped");
        foreach (var s in W.Skipped) j.WriteStringValue(s);
        j.WriteEndArray();
        j.WriteEndObject();
    }

    // ------------------------------------------------------------------ serialization layouts

    static bool LayoutAssembly(string n) =>
        !(n == "mscorlib" || n == "netstandard" || n.StartsWith("System", StringComparison.Ordinal) || n.StartsWith("Mono.", StringComparison.Ordinal)
          || n.StartsWith("Microsoft.", StringComparison.Ordinal) || n == "UnityEngine"
          || (n.StartsWith("UnityEngine.", StringComparison.Ordinal) && n.EndsWith("Module", StringComparison.Ordinal)));

    static void WriteLayouts(World W, string outDir, SortedDictionary<string, object?> summary)
    {
        var dir = Path.Combine(outDir, "serialization");
        Directory.CreateDirectory(dir);
        var lb = new LayoutBuilder(W);
        int scripts = 0, withNotes = 0, withRefs = 0;
        var txt = new StringBuilder();

        using (var fs = File.Create(Path.Combine(dir, "layouts.json")))
        using (var j = new Utf8JsonWriter(fs, JOpt))
        {
            j.WriteStartObject();
            foreach (var m in W.Mods.Values.Where(x => LayoutAssembly(x.Name)).OrderBy(x => x.Name, StringComparer.OrdinalIgnoreCase))
            {
                foreach (var th in m.MD.TypeDefinitions)
                {
                    var t = new TDef(m, th);
                    if (!t.Def.GetDeclaringType().IsNil) continue;
                    var info = W.Info(t);
                    if (!(info.IsMonoBehaviour || info.IsScriptableObject) || info.IsAbstract || info.IsInterface || info.GenericParamCount > 0) continue;
                    var nodes = lb.BuildScript(t);
                    var key = $"{m.Name}.dll|{info.Ns}|{info.Name}";
                    scripts++;
                    if (lb.Notes.Count > 0) withNotes++;
                    if (lb.UsesManagedRefs) withRefs++;
                    j.WriteStartObject(key);
                    j.WriteStartArray("nodes");
                    foreach (var n in nodes) { j.WriteStartArray(); j.WriteNumberValue(n.Level); j.WriteStringValue(n.Type); j.WriteStringValue(n.Name); j.WriteNumberValue(n.Meta); j.WriteEndArray(); }
                    j.WriteEndArray();
                    if (lb.Notes.Count > 0) { j.WriteStartArray("notes"); foreach (var s in lb.Notes) j.WriteStringValue(s); j.WriteEndArray(); }
                    if (lb.UsesManagedRefs) j.WriteBoolean("managedRefs", true);
                    j.WriteEndObject();

                    txt.AppendLine($"### {key}   base: {string.Join(" > ", info.BaseChain.Take(3))}{(lb.UsesManagedRefs ? "   [SerializeReference]" : "")}");
                    foreach (var n in nodes) txt.AppendLine($"{new string(' ', n.Level * 2)}{n.Type} {n.Name}{((n.Meta & LayoutBuilder.Align) != 0 ? "   (align)" : "")}");
                    foreach (var s in lb.Notes) txt.AppendLine("  ! " + s);
                    txt.AppendLine();
                }
            }
            j.WriteEndObject();
        }
        File.WriteAllText(Path.Combine(dir, "layouts.txt"), txt.ToString(), new UTF8Encoding(false));
        summary["scriptLayouts"] = scripts; summary["scriptLayoutsWithNotes"] = withNotes; summary["scriptLayoutsWithManagedRefs"] = withRefs;
        Console.WriteLine($"layouts: {scripts} script classes ({withNotes} with skipped-field notes, {withRefs} using SerializeReference)");

        WriteClassLayouts(W, dir, lb, summary);
    }

    static void CollectInterfaces(World W, TDef t, HashSet<string> acc, int depth = 0)
    {
        if (depth > 16) return;
        var cur = (TDef?)t;
        int guard = 0;
        while (cur is { } c && guard++ < 32)
        {
            foreach (var ih in c.Def.GetInterfaceImplementations())
            {
                var iface = c.M.MD.GetInterfaceImplementation(ih).Interface;
                var it = W.ResolveHandle(c.M, iface);
                if (it is { } i)
                {
                    if (acc.Add(W.Info(i).FullName)) CollectInterfaces(W, i, acc, depth + 1);
                }
            }
            if (c.Def.BaseType.IsNil) break;
            cur = W.ResolveHandle(c.M, c.Def.BaseType);
        }
    }

    /// <summary>Layouts for classes that can appear behind [SerializeReference] fields (registry entries carry class/ns/asm only).</summary>
    static void WriteClassLayouts(World W, string dir, LayoutBuilder lb, SortedDictionary<string, object?> summary)
    {
        var eligible = W.Mods.Values.Where(x => LayoutAssembly(x.Name)).ToList();
        var targets = new SortedSet<string>(StringComparer.Ordinal);
        foreach (var m in eligible)
            foreach (var th in m.MD.TypeDefinitions)
            {
                var t = new TDef(m, th);
                var info = W.Info(t);
                if (!(info.IsUnityObject || info.IsSerializableFlag)) continue;
                foreach (var fh in t.Def.GetFields())
                {
                    var f = m.MD.GetFieldDefinition(fh);
                    if (!LayoutBuilder.IsSerializedDecl(m, f, out bool serRef) || !serRef) continue;
                    TypeSig ft;
                    try { ft = f.DecodeSignature(W.P, W.CtxFor(t)); } catch { continue; }
                    if (ft is SZArraySig a) ft = a.Elem;
                    else if (ft is GenInstSig g && g.Def is NamedSig n && n.Name == "List`1" && g.Args.Length == 1) ft = g.Args[0];
                    var d = W.ResolveSig(ft);
                    targets.Add(d is { } dd ? W.Info(dd).FullName : Naming.Show(ft, true));
                }
            }
        summary["serializeReferenceTargets"] = targets.ToArray();
        Console.WriteLine($"SerializeReference declared types: {targets.Count}");
        if (targets.Count == 0) { File.WriteAllText(Path.Combine(dir, "class_layouts.json"), "{}"); return; }

        int classes = 0;
        using var fs = File.Create(Path.Combine(dir, "class_layouts.json"));
        using var j = new Utf8JsonWriter(fs, JOpt);
        j.WriteStartObject();
        foreach (var m in eligible.OrderBy(x => x.Name, StringComparer.OrdinalIgnoreCase))
            foreach (var th in m.MD.TypeDefinitions)
            {
                var t = new TDef(m, th);
                var info = W.Info(t);
                if (info.IsAbstract || info.IsInterface || info.IsEnum || info.IsDelegate || info.IsValueType || info.IsUnityObject || info.GenericParamCount > 0) continue;
                var bases = new HashSet<string>(info.BaseChain, StringComparer.Ordinal);
                CollectInterfaces(W, t, bases);
                if (!targets.Any(bases.Contains)) continue;
                var nodes = lb.BuildClass(t);
                if (nodes == null) continue;
                var cls = info.FullName.Substring(info.Ns.Length == 0 ? 0 : info.Ns.Length + 1);
                var key = $"{m.Name}.dll|{info.Ns}|{cls}";
                classes++;
                j.WriteStartObject(key);
                j.WriteStartArray("nodes");
                foreach (var n in nodes) { j.WriteStartArray(); j.WriteNumberValue(n.Level); j.WriteStringValue(n.Type); j.WriteStringValue(n.Name); j.WriteNumberValue(n.Meta); j.WriteEndArray(); }
                j.WriteEndArray();
                if (lb.Notes.Count > 0) { j.WriteStartArray("notes"); foreach (var s in lb.Notes) j.WriteStringValue(s); j.WriteEndArray(); }
                j.WriteEndObject();
            }
        j.WriteEndObject();
        summary["classLayouts"] = classes;
        Console.WriteLine($"class layouts (SerializeReference candidates): {classes}");
    }
}
