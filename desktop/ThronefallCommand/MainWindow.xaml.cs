using System.Diagnostics;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Text.Json;
using System.Windows;
using System.Windows.Controls;
using Microsoft.Web.WebView2.Core;

namespace ThronefallCommand
{
    public partial class MainWindow : Window
    {
        static readonly string AppDir =
            Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData),
                         "ThronefallCommand");
        static readonly string SettingsPath = Path.Combine(AppDir, "settings.json");
        static readonly string ProfilesDir = Path.Combine(AppDir, "profiles");

        class Cfg
        {
            public int Port { get; set; } = 8099;
            public string TrainerRoot { get; set; } = @"K:\Downloads-IDM\Thronefall\Trainer";
            public double Zoom { get; set; } = 1.0;
            public bool TopMost { get; set; }
            public bool Locked { get; set; }
            public double Left { get; set; } = double.NaN;
            public double Top { get; set; } = double.NaN;
            public double Width { get; set; }
            public double Height { get; set; }
            public string Profile { get; set; } = "default";
        }
        Cfg _cfg = new Cfg();
        Process _server;

        public MainWindow()
        {
            InitializeComponent();
            LoadSettings();
            Directory.CreateDirectory(AppDir);
            Directory.CreateDirectory(ProfilesDir);

            // Default: ~40% of the desktop — sits beside the game window.
            var wa = SystemParameters.WorkArea;
            double w = _cfg.Width > 0 ? _cfg.Width : wa.Width * 0.40;
            double h = _cfg.Height > 0 ? _cfg.Height : wa.Height * 0.55;
            Width = w; Height = h;
            if (!double.IsNaN(_cfg.Left)) { Left = _cfg.Left; Top = _cfg.Top; }
            else { Left = wa.Right - w - 24; Top = wa.Top + 24; }

            RootBox.Text = _cfg.TrainerRoot;
            ZoomSlider.Value = _cfg.Zoom;
            TopMostBox.IsChecked = _cfg.TopMost;
            Topmost = _cfg.TopMost;
            if (_cfg.Locked) ApplyLock();
            RefreshProfileBox();
            RefreshPorts();
            Loaded += async (_, __) => { await InitWeb(); ConnectNow(); };
            Closing += (_, __) => SaveSettings();
        }

        // ---------- settings / profiles ----------
        void LoadSettings()
        {
            try
            {
                if (File.Exists(SettingsPath))
                    _cfg = JsonSerializer.Deserialize<Cfg>(File.ReadAllText(SettingsPath)) ?? new Cfg();
            }
            catch { }
        }
        void SaveSettings()
        {
            try
            {
                _cfg.Left = Left; _cfg.Top = Top;
                _cfg.Width = Width; _cfg.Height = Height;
                _cfg.Port = Port();
                _cfg.Zoom = ZoomSlider.Value;
                _cfg.TopMost = Topmost;
                _cfg.TrainerRoot = RootBox.Text;
                File.WriteAllText(SettingsPath, JsonSerializer.Serialize(_cfg));
            }
            catch { }
        }
        void RefreshProfileBox()
        {
            ProfileBox.Items.Clear();
            try
            {
                foreach (var f in Directory.GetFiles(ProfilesDir, "*.json"))
                    ProfileBox.Items.Add(Path.GetFileNameWithoutExtension(f));
            }
            catch { }
            ProfileBox.Text = _cfg.Profile;
            ProfileLabel.Text = "profile: " + _cfg.Profile;
        }

        // ---------- ports ----------
        int Port() => int.TryParse(PortBox.Text, out var p) && p > 0 && p < 65536 ? p : 8099;

        static List<int> FreePorts()
        {
            // Ports LISTENING on localhost are taken — offer bindable ones only.
            var taken = new HashSet<int>();
            try
            {
                foreach (var t in IPGlobalProperties.GetIPGlobalProperties()
                             .GetActiveTcpListeners()) taken.Add(t.Port);
            }
            catch { }
            var free = new List<int>();
            for (int p = 8090; p <= 8140 && free.Count < 24; p++)
                if (!taken.Contains(p)) free.Add(p);
            return free;
        }
        void RefreshPorts()
        {
            var keep = PortBox.Text;
            PortBox.Items.Clear();
            PortBox.Items.Add("auto");
            foreach (var p in FreePorts()) PortBox.Items.Add(p.ToString());
            PortBox.Text = string.IsNullOrEmpty(keep) ? _cfg.Port.ToString() : keep;
        }
        void RefreshPorts_Click(object s, RoutedEventArgs e) => RefreshPorts();

        int ResolvePort()
        {
            // "auto" = first free port ≥8090; keeps the saved port if listed.
            if (PortBox.Text.Trim().ToLowerInvariant() == "auto")
                return FreePorts().FirstOrDefault(8099);
            return Port();
        }

        // ---------- server lifecycle ----------
        static readonly HttpClient _http = new HttpClient
        { Timeout = TimeSpan.FromSeconds(2) };

        static async Task<bool> ServerUp(int port)
        {
            try
            {
                var r = await _http.GetAsync($"http://127.0.0.1:{port}/health");
                return r.IsSuccessStatusCode;
            }
            catch { return false; }
        }
        void StartServer(int port)
        {
            var script = Path.Combine(_cfg.TrainerRoot, "tools", "coach-server.py");
            if (!File.Exists(script)) { Status.Text = $"no coach-server.py at {_cfg.TrainerRoot}"; return; }
            try
            {
                // No stdio redirects: unread pipes fill (~4 KB) and deadlocked
                // the python child (audit finding).
                _server = Process.Start(new ProcessStartInfo("python", $"\"{script}\" --port {port}")
                {
                    WorkingDirectory = _cfg.TrainerRoot,
                    UseShellExecute = false,
                    CreateNoWindow = true
                });
                Status.Text = $"coach-server.py launched on :{port} (PID {_server?.Id})";
            }
            catch (Exception ex) { Status.Text = "server start failed: " + ex.Message; }
        }

        async void ConnectNow()
        {
            int port = ResolvePort();
            // 'auto' must ATTACH to an already-running server before spawning a
            // second one — a duplicate watch loop doubles MiniMax spend and the
            // two writers duel over coach-commands.json (audit finding).
            if (PortBox.Text.Trim().ToLowerInvariant() == "auto")
                for (int p = 8090; p <= 8140; p++)
                    if (await ServerUp(p)) { port = p; break; }
            PortBox.Text = port.ToString();
            if (!await ServerUp(port))
            {
                Status.Text = "starting coach-server…";
                StartServer(port);
                for (int i = 0; i < 40 && !await ServerUp(port); i++)
                    await Task.Delay(500);
            }
            if (await ServerUp(port))
            {
                Web.Source = new Uri($"http://127.0.0.1:{port}/");
                Status.Text = $"connected :{port}";
            }
            else Status.Text = $"server not responding on :{port}";
        }
        void Connect_Click(object s, RoutedEventArgs e) { SaveSettings(); ConnectNow(); }

        // ---------- WebView ----------
        async Task InitWeb()
        {
            // Per-user data folder → localStorage (panel state, pins) persists
            // across launches — the web app's layout memory lives here.
            var env = await CoreWebView2Environment.CreateAsync(
                userDataFolder: Path.Combine(AppDir, "webview"));
            await Web.EnsureCoreWebView2Async(env);
            Web.ZoomFactor = ZoomSlider.Value;
        }

        // ---------- toolbar ----------
        void Zoom_Changed(object s, RoutedPropertyChangedEventArgs<double> e)
        {
            if (Web?.CoreWebView2 != null) Web.ZoomFactor = e.NewValue;
        }
        void Top_Changed(object s, RoutedEventArgs e) => Topmost = TopMostBox.IsChecked == true;
        void Full_Click(object s, RoutedEventArgs e)
        {
            if (WindowStyle == WindowStyle.None)
            { WindowStyle = WindowStyle.SingleBorderWindow; WindowState = WindowState.Normal; }
            else { WindowStyle = WindowStyle.None; WindowState = WindowState.Maximized; }
        }
        void Compact_Click(object s, RoutedEventArgs e)
        {
            var wa = SystemParameters.WorkArea;
            WindowStyle = WindowStyle.SingleBorderWindow; WindowState = WindowState.Normal;
            Width = wa.Width * 0.40; Height = wa.Height * 0.55;
            Left = wa.Right - Width - 24; Top = wa.Top + 24;
        }
        void ApplyLock() => ResizeMode = _cfg.Locked ? ResizeMode.NoResize : ResizeMode.CanResize;
        void Lock_Click(object s, RoutedEventArgs e)
        {
            _cfg.Locked = !_cfg.Locked;
            ApplyLock();
            Status.Text = _cfg.Locked ? "window size locked" : "window unlocked";
        }
        void Gear_Click(object s, RoutedEventArgs e) =>
            SettingsFlyout.Visibility = SettingsFlyout.Visibility == Visibility.Collapsed
                ? Visibility.Visible : Visibility.Collapsed;

        // ---------- profiles ----------
        void SaveProfile_Click(object s, RoutedEventArgs e)
        {
            SaveSettings();
            var name = string.IsNullOrWhiteSpace(ProfileBox.Text) ? "default" : ProfileBox.Text.Trim();
            try
            {
                File.WriteAllText(Path.Combine(ProfilesDir, name + ".json"),
                    JsonSerializer.Serialize(_cfg));
                _cfg.Profile = name; RefreshProfileBox();
                Status.Text = "profile saved: " + name;
            }
            catch (Exception ex) { Status.Text = "save failed: " + ex.Message; }
        }
        void LoadProfile_Click(object s, RoutedEventArgs e)
        {
            var name = string.IsNullOrWhiteSpace(ProfileBox.Text) ? "default" : ProfileBox.Text.Trim();
            // Sanitize — profile names come from a free-text combo; '../' must
            // never escape the profiles dir (audit finding).
            name = Path.GetFileName(name);
            var f = Path.Combine(ProfilesDir, name + ".json");
            if (!File.Exists(f)) { Status.Text = "no profile: " + name; return; }
            try
            {
                _cfg = JsonSerializer.Deserialize<Cfg>(File.ReadAllText(f)) ?? _cfg;
                _cfg.Profile = name;
                RootBox.Text = _cfg.TrainerRoot; ZoomSlider.Value = _cfg.Zoom;
                TopMostBox.IsChecked = _cfg.TopMost; Topmost = _cfg.TopMost;
                if (_cfg.Width > 0) { Width = _cfg.Width; Height = _cfg.Height; }
                PortBox.Text = _cfg.Port.ToString();
                ApplyLock(); RefreshProfileBox();
                Status.Text = "profile loaded: " + name;
            }
            catch (Exception ex) { Status.Text = "load failed: " + ex.Message; }
        }
        void Apply_Click(object s, RoutedEventArgs e) { SaveSettings(); ConnectNow(); }
    }
}
