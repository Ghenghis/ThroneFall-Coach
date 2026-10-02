using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Diagnostics;

namespace ThronefallTrainer
{
    /// <summary>The plugin -> livecap socket of live.v1 (TCP client to 127.0.0.1:port). No Unity types in here, so it is tested end to end against
    /// a loopback server in tests/ActLogic.Tests. One background thread owns the connection: connect (with a timeout), send the TFGAME1 hello,
    /// then stream whatever frame is in the latest-frame slot (FrameExchange: latest wins, nothing queues); a second background thread per
    /// connection reads livecap's control lines. Any failure closes the socket and reconnects with a 0.5 s -> 5 s backoff; with nobody listening the
    /// cost is one refused loopback connect every 5 s on a below-normal thread. Nothing here ever throws into the caller.</summary>
    internal sealed class LiveSender
    {
        // ---- configuration (set before Start)
        public int Port = 8095;
        public string Build = "live-1", UnityVersion = "";
        public int Pid;
        public volatile int ScreenW, ScreenH;            // cached by the game thread: Unity's Screen API is main-thread only
        public int ConnectTimeoutMs = 2000, SendTimeoutMs = 10000, SendBufferBytes = 4 << 20;
        public double BackoffStartS = LiveLinkLogic.BackoffStart, BackoffMaxS = LiveLinkLogic.BackoffMax;     // reconnect delay range (tests shrink it)
        /// <summary>(kind, text, isWarning). Kinds are short keys ("up", "down", "lost", "ctl", "thread") so the owner can throttle per kind.</summary>
        public Action<string, string, bool> Log;

        // ---- state shared with the game thread
        public readonly FrameExchange Frames = new FrameExchange();
        volatile bool stop, linkUp;
        long lastSentStamp, bytesSent;                   // Stopwatch timestamp / total bytes; Interlocked
        int framesSent, connects, disconnects;
        volatile int ctlFps, ctlW, ctlPaused;
        readonly AutoResetEvent wake = new AutoResetEvent(false);
        readonly ManualResetEvent stopEvent = new ManualResetEvent(false);
        readonly byte[] head = new byte[LiveLinkLogic.HeaderLen + LiveLinkLogic.MaxMetaLen];
        Thread thread;
        volatile Socket current;

        sealed class Conn { public Socket S; public volatile bool Dead; }

        public bool LinkUp { get { return linkUp; } }
        /// <summary>The fps / width livecap last asked for (clamped), 0 = it never did and the config values apply.</summary>
        public int CtlFps { get { return ctlFps; } }
        public int CtlW { get { return ctlW; } }
        /// <summary>livecap said nobody is watching ("paused": true): the capture stops, the link stays up. Reset to false on every new connection.</summary>
        public bool CtlPaused { get { return ctlPaused != 0; } }
        public int FramesSent { get { return Interlocked.CompareExchange(ref framesSent, 0, 0); } }
        public long BytesSent { get { return Interlocked.Read(ref bytesSent); } }
        public int Connects { get { return Interlocked.CompareExchange(ref connects, 0, 0); } }
        public int Disconnects { get { return Interlocked.CompareExchange(ref disconnects, 0, 0); } }

        /// <summary>Seconds since a frame was last handed to the socket (+Infinity = never).</summary>
        public double SecondsSinceLastSend()
        {
            long t = Interlocked.Read(ref lastSentStamp);
            return t == 0 ? double.PositiveInfinity : (Stopwatch.GetTimestamp() - t) / (double)Stopwatch.Frequency;
        }

        public void Start()
        {
            thread = new Thread(Run) { IsBackground = true, Name = "LiveLink-sender", Priority = ThreadPriority.BelowNormal };
            thread.Start();
        }

        /// <summary>Tell the sender thread a new frame is in the slot.</summary>
        public void Wake() { wake.Set(); }

        public void Stop()
        {
            stop = true;
            try { stopEvent.Set(); wake.Set(); } catch (Exception) { }
            var s = current;
            if (s != null) { try { s.Shutdown(SocketShutdown.Both); } catch (Exception) { } try { s.Close(); } catch (Exception) { } }
        }

        void Say(string kind, string text, bool warn)
        {
            var l = Log;
            if (l == null) return;
            try { l(kind, text, warn); } catch (Exception) { }
        }

        // ------------------------------------------------------------------------------------------------ the sender thread
        void Run()
        {
            double backoff = BackoffStartS;
            bool downLogged = false;
            while (!stop)
            {
                bool up = false; double upSec = 0; string reason;
                try { reason = Session(ref downLogged, out up, out upSec); }
                catch (Exception ex) { reason = ex.GetType().Name + ": " + ex.Message; }
                if (stop) break;
                if (up)
                {
                    Interlocked.Increment(ref disconnects);
                    Say("lost", "link to livecap lost after " + upSec.ToString("0.0", System.Globalization.CultureInfo.InvariantCulture) + " s (" + reason + ")", false);
                    if (upSec >= 5.0) backoff = BackoffStartS;                   // a healthy session: start over; a flapping one keeps backing off
                }
                try { stopEvent.WaitOne((int)(backoff * 1000.0)); } catch (Exception) { break; }
                backoff = LiveLinkLogic.NextBackoff(backoff, BackoffStartS, BackoffMaxS);
            }
        }

        /// <summary>One connection from connect to disconnect. Returns why it ended; `up` says whether it ever got established.</summary>
        string Session(ref bool downLogged, out bool up, out double upSec)
        {
            up = false; upSec = 0;
            string why;
            Socket s = Connect(out why);
            if (s == null)
            {
                if (!downLogged)
                {
                    downLogged = true;
                    Say("down", "livecap is not listening on 127.0.0.1:" + Port + " (" + why + "); retrying quietly, backing off from 0.5 s to 5 s", false);
                }
                return why;
            }
            if (stop) { try { s.Close(); } catch (Exception) { } return "stopping"; }
            long t0 = Stopwatch.GetTimestamp();
            try
            {
                current = s;
                byte[] hello = Encoding.UTF8.GetBytes(LiveLinkLogic.HelloLine(Build, Pid, ScreenW, ScreenH, UnityVersion));
                SendAll(s, hello, 0, hello.Length);
                var conn = new Conn { S = s };
                Frames.Clear();                                                  // never start a connection with a stale picture
                ctlPaused = 0;                                                   // a new connection starts unpaused (livecap sends its state right after the hello)
                var reader = new Thread(() => ReadLoop(conn)) { IsBackground = true, Name = "LiveLink-control" };
                reader.Start();
                linkUp = true; up = true; downLogged = false;
                Interlocked.Increment(ref connects);
                Say("up", "connected to livecap on 127.0.0.1:" + Port, false);
                while (!stop && !conn.Dead)
                {
                    LiveFrame f = Frames.TakeLatest();
                    if (f == null) { wake.WaitOne(250); continue; }              // idle: the timeout also re-checks conn.Dead / stop
                    try { SendFrame(s, f); }
                    finally { Frames.Return(f); }
                }
                return stop ? "stopping" : "livecap closed the connection";
            }
            finally
            {
                linkUp = false;
                current = null;
                if (up) upSec = (Stopwatch.GetTimestamp() - t0) / (double)Stopwatch.Frequency;
                try { s.Shutdown(SocketShutdown.Both); } catch (Exception) { }   // wakes the control reader if it is still blocked in Receive()
                try { s.Close(); } catch (Exception) { }
            }
        }

        Socket Connect(out string why)
        {
            why = null;
            Socket s = null;
            try
            {
                s = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
                s.NoDelay = true;                                                // a frame is two sends (header+meta, pixels): no Nagle delay between them
                s.SendBufferSize = SendBufferBytes;                              // a whole frame fits: Send() returns at once instead of blocking on the reader
                s.ReceiveBufferSize = 64 * 1024;
                s.SendTimeout = SendTimeoutMs;                                   // a consumer that stopped reading for this long is treated as gone
                var ar = s.BeginConnect(IPAddress.Loopback, Port, null, null);
                if (!ar.AsyncWaitHandle.WaitOne(ConnectTimeoutMs)) { why = "connect timeout"; s.Close(); return null; }
                s.EndConnect(ar);
                return s;
            }
            catch (Exception ex)
            {
                var se = ex as SocketException;
                why = se != null ? se.SocketErrorCode.ToString() : ex.GetType().Name;
                try { if (s != null) s.Close(); } catch (Exception) { }
                return null;
            }
        }

        static void SendAll(Socket s, byte[] buf, int off, int len)
        {
            while (len > 0)
            {
                int n = s.Send(buf, off, len, SocketFlags.None);
                if (n <= 0) throw new IOException("send returned " + n);
                off += n; len -= n;
            }
        }

        /// <summary>header + meta in one send, then the pixels straight out of the pooled buffer (no copy).</summary>
        void SendFrame(Socket s, LiveFrame f)
        {
            int metaLen = 0;
            string meta = f.Meta;
            if (!string.IsNullOrEmpty(meta) && meta.Length * 3 <= LiveLinkLogic.MaxMetaLen)
                metaLen = Encoding.UTF8.GetBytes(meta, 0, meta.Length, head, LiveLinkLogic.HeaderLen);
            var h = new FrameHeader { MetaLen = (uint)metaLen, W = (uint)f.W, H = (uint)f.H, Fmt = f.Fmt, TMs = f.TMs, Seq = f.Seq, PayloadLen = (uint)f.Data.Length };
            LiveLinkLogic.EncodeHeader(head, 0, h);
            SendAll(s, head, 0, LiveLinkLogic.HeaderLen + metaLen);
            SendAll(s, f.Data, 0, f.Data.Length);
            Interlocked.Add(ref bytesSent, LiveLinkLogic.HeaderLen + metaLen + f.Data.Length);       // framesSent last: whoever sees the new count sees the rest too
            Interlocked.Exchange(ref lastSentStamp, Stopwatch.GetTimestamp());
            Interlocked.Increment(ref framesSent);
        }

        // ------------------------------------------------------------------------------------------------ control lines (livecap -> plugin)
        void ReadLoop(Conn c)
        {
            var buf = new byte[1024];
            var acc = new byte[4096];
            int n = 0; bool over = false;
            try
            {
                for (;;)
                {
                    int got = c.S.Receive(buf);
                    if (got <= 0) break;                                         // livecap closed
                    for (int i = 0; i < got; i++)
                    {
                        byte b = buf[i];
                        if (b == (byte)'\n') { if (!over && n > 0) HandleLine(Encoding.UTF8.GetString(acc, 0, n)); n = 0; over = false; }
                        else if (n < acc.Length) acc[n++] = b;
                        else over = true;                                        // an over-long line is garbage: skip it up to the newline
                    }
                }
            }
            catch (Exception) { }                                                // reset / closed by our own Session.finally
            c.Dead = true;
            try { c.S.Shutdown(SocketShutdown.Both); } catch (Exception) { }     // frees a sender thread that is blocked inside Send()
            try { wake.Set(); } catch (Exception) { }
        }

        void HandleLine(string line)
        {
            try
            {
                int fps, w, paused;
                if (!LiveLinkLogic.TryParseControl(line, out fps, out w, out paused)) return;   // ping, unknown keys, garbage: ignored
                if (fps > 0) ctlFps = fps;
                if (w > 0) ctlW = w;
                if (paused >= 0) ctlPaused = paused;
                Say("ctl", "control from livecap: fps=" + (fps > 0 ? fps.ToString() : "-") + " w=" + (w > 0 ? w.ToString() : "-") + (paused >= 0 ? " paused=" + (paused > 0 ? "yes" : "no") : ""), false);
            }
            catch (Exception) { }
        }
    }
}
