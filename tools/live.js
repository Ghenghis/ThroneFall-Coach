/* Live View video player (served at /live.js by coach-server.py and by livecap itself).
 *
 * What it does: connects to livecap (ws://<host>:8097/ws), decodes the JPEG frames in a WORKER (createImageBitmap) and draws them - together
 * with the bot overlay (doors, castle, builds, aim, foes, path, avoid zones, incident rings) - onto an OffscreenCanvas that the browser's
 * compositor presents on its own thread. So the picture stays smooth even while the page's main thread is busy rendering chat/incident DOM.
 *
 *   - latest-frame-wins: a frame that is still undecoded when the next one arrives is dropped (never a backlog => no growing delay)
 *   - ack-based flow control with the server (it never sends more than 3 frames ahead of what this client has decoded)
 *   - overlay is world-locked: markers/zones/rings are re-projected with the newest camera matrix on EVERY drawn frame
 *   - honest HUD: real decoded fps, real capture->display latency, capture source, and what is wrong when there is no picture
 *   - if livecap is not reachable the page's legacy <img> MJPEG path keeps working (LV.active stays false)
 *
 * Public API (window.LV): active, state, stats, set({fps,width,quality}), reconnect(), setIncidents(list), snapshot() -> Promise<Blob>, hit(x,y) -> Promise
 */
(function () {
  'use strict';
  if (window.LV && window.LV.__v) return;
  const host = document.getElementById('view');
  if (!host) return;
  const standalone = !!window.LV_STANDALONE;
  const shot = document.getElementById('shot');
  const cfg = window.LV_CFG || {};
  const hostName = location.hostname || '127.0.0.1';
  const livecapPort = cfg.port || (standalone && +location.port) || 8097;
  const wsUrl = cfg.ws || ('ws://' + hostName + ':' + livecapPort + '/ws');
  const httpBase = cfg.http || ('http://' + hostName + ':' + livecapPort);
  const LV = window.LV = {
    __v: 1, active: false, state: 'connecting', detail: '', stats: {}, base: httpBase, wsUrl, frameW: 0, frameH: 0,
    set(o) { post({ type: 'set', set: o }); },
    reconnect() { post({ type: 'reconnect' }); },
    setIncidents(list) { post({ type: 'incidents', list: (list || []).filter(i => i && i.pos).map(i => ({ id: i.id, kind: i.kind, sev: i.sev, x: i.pos[0], z: i.pos[1], dur: i.dur_s || 0, cls: (i.obstacle && i.obstacle.class) || '' })) }); },
    snapshot() { return rpc({ type: 'snapshot' }); },
    hit(x, y) { return rpc({ type: 'hit', x, y }); },                      // CSS px inside the canvas -> name of the marker under it (or null)
    world(x, y) { return rpc({ type: 'world', x, y }); },                  // CSS px inside the canvas -> {x, z} world metres on the ground plane (or null)
    mark(m) { post({ type: 'mark', mark: m }); },                          // world-locked temporary marker {id, x, z, r(m, optional), label, color, ttl(s)}: command feedback, previews
    unmark(id) { post({ type: 'unmark', id }); },
  };

  // ------------------------------------------------------------------------------------------------ worker (runs off the main thread)
  function workerMain() {
    let ws = null, gen = 0, retry = 250, retryT = 0, url = '';
    let canvas = null, ctx = null, cw = 0, ch = 0, dpr = 1;
    let bmp = null, info = null, pending = null, decoding = false, dirty = true;
    let view = null, mk = null, incidents = [], marks = [], perf = null, perfAt = 0, gpu = null, gpuAt = 0, lastHud = null;      // perf = the GAME's own frame-time telemetry (plugin FramePerf) relayed by livecap; gpu = VRAM pressure (Windows counters)
    let flags = { door: 1, castle: 1, bld: 1, aim: 1, foe: 1, path: 1, hero: 1, THREAT: 1, GO: 1, zones: 1, inc: 1, hud: 1 };
    let state = 'connecting', detail = '', serverV = '', cfgInfo = {};
    let lastFrameT = 0, lastMsgT = 0, sw = 0, sh = 0, openT = 0, announce = true, hidden = false;
    const st = { recv: 0, dec: 0, drawn: 0, dropped: 0, err: 0, bytes: 0, decMs: [], lat: [], t0: performance.now() };
    const drawT = [];                                  // timestamps of drawn NEW frames (for the fps readout)
    const recvT = [];
    let mkSentT = 0;

    const send = o => { try { if (ws && ws.readyState === 1) ws.send(JSON.stringify(o)); } catch (e) { /* closing */ } };
    const post = o => self.postMessage(o);
    const q = (a, p) => { if (!a.length) return 0; const s = a.slice().sort((x, y) => x - y); return s[Math.min(s.length - 1, Math.floor(s.length * p))]; };
    const rate = a => { const n = performance.now(); while (a.length && n - a[0] > 2000) a.shift(); return a.length > 1 ? (a.length - 1) / ((a[a.length - 1] - a[0]) / 1000) : 0; };

    function connect() {
      clearTimeout(retryT);
      const my = ++gen;
      try { ws = new WebSocket(url); } catch (e) { ws = null; sched(my); return; }
      ws.binaryType = 'arraybuffer';
      ws.onopen = () => { if (my !== gen) return; retry = 250; openT = performance.now(); lastMsgT = openT; send({ hello: { client: 'live.js', ua: (self.navigator && navigator.userAgent || '').slice(0, 60), dpr, w: cw, h: ch } }); };
      ws.onmessage = e => { if (my === gen) onMsg(e); };
      ws.onclose = ws.onerror = () => { if (my !== gen) return; gen++; try { ws.close(); } catch (e) { /* already closed */ } ws = null; state = 'disconnected'; detail = 'livecap not reachable'; dirty = true; announce = true; if (!hidden) sched(gen); };
    }
    function sched(my) { clearTimeout(retryT); retryT = setTimeout(connect, retry); retry = Math.min(2000, Math.round(retry * 1.6)); }

    function onMsg(e) {
      const d = e.data; lastMsgT = performance.now();
      if (typeof d === 'string') {
        let m; try { m = JSON.parse(d); } catch (err) { return; }
        if (m.type === 'view') { view = m; dirty = true; }
        else if (m.type === 'mk') { mk = m; dirty = true; }
        else if (m.type === 'perf') { perf = m; perfAt = performance.now(); }
        else if (m.type === 'gpu') { gpu = m; gpuAt = performance.now(); }
        else if (m.type === 'state') { state = m.state; detail = m.detail || ''; dirty = true; }
        else if (m.type === 'hello') { cfgInfo = m; serverV = m.v; if (m.state) state = m.state; }
        return;
      }
      const dv = new DataView(d);
      if (dv.getUint8(0) !== 0x54) return;
      const ml = dv.getUint16(20, true);
      const f = { flags: dv.getUint16(2, true), seq: dv.getUint32(4, true), t: dv.getFloat64(8, true), w: dv.getUint16(16, true), h: dv.getUint16(18, true), off: 22 + ml, buf: d, meta: null };
      if (ml) { try { f.meta = JSON.parse(new TextDecoder().decode(new Uint8Array(d, 22, ml))); } catch (err) { /* meta is optional */ } }
      if (pending) st.dropped++;
      pending = f; st.recv++; st.bytes += d.byteLength - f.off; recvT.push(performance.now());
      if (!decoding) pump();
    }

    async function pump() {
      decoding = true;
      while (pending) {
        const f = pending; pending = null;
        const t0 = performance.now();
        try {
          const nb = await createImageBitmap(new Blob([new Uint8Array(f.buf, f.off)], { type: 'image/jpeg' }));
          st.decMs.push(performance.now() - t0); if (st.decMs.length > 120) st.decMs.shift();
          const old = bmp; bmp = nb; info = f; if (old) old.close();
          if (f.meta && f.meta.vp) fv = f.meta;                 // the camera this very frame was rendered with (in-game capture only)
          st.dec++; lastFrameT = performance.now(); dirty = true; fresh = true;
          if (state === 'connecting' || state === 'disconnected' || state === 'static') state = (f.flags & 4) ? 'game' : (f.flags & 1) ? 'plugin' : 'wgc';
          if (f.w !== sw || f.h !== sh || announce) { sw = f.w; sh = f.h; announce = false; post({ type: 'size', w: sw, h: sh }); }   // also after a reconnect: the page re-activates the player
        } catch (err) { st.err++; }
        send({ ack: f.seq });
      }
      decoding = false;
    }
    let fresh = false, fv = null, vx = 0, vy = 0, vw = 0, vh = 0;

    // -------------------------------------------------------------------------------------------- overlay
    function V() {                                       // the camera of the picture on screen: the frame's own meta when the plugin sends it, else the newest view.json
      if (fv && fv.vp && fv.pw) return { vp: fv.vp, pw: fv.pw, ph: fv.ph, gy: fv.gy || 0, ok: true, zones: view && view.zones };
      return view && view.ok && view.vp ? view : null;
    }
    function proj(wx, y, wz) {
      const v = V(); if (!v) return null; const m = v.vp;
      const w = m[12] * wx + m[13] * y + m[14] * wz + m[15]; if (w <= 1e-4) return null;
      return [((m[0] * wx + m[1] * y + m[2] * wz + m[3]) / w * 0.5 + 0.5) * v.pw, (1 - ((m[4] * wx + m[5] * y + m[6] * wz + m[7]) / w * 0.5 + 0.5)) * v.ph];
    }
    const kind = t => t.startsWith('door') ? 'door' : t.startsWith('bld') ? 'bld' : t;
    function ptPos(p) {                                  // [px, py] in the plugin's screen space (pw x ph); world-locked when we can
      const v = V();
      if (p.wx !== undefined && v) { const r = proj(p.wx, v.gy || 0, p.wz); if (r) return r; }
      return [p.x / (p.w || 1920) * (mk.pw || 1920), p.y / (p.h || 1440) * (mk.ph || 1440)];
    }
    function drawOverlay() {
      ctx.save(); ctx.translate(vx, vy);                 // overlay coordinates are relative to the video rectangle (letterboxed in the standalone viewer)
      try { overlayBody(); } finally { ctx.restore(); }
    }
    function overlayBody() {
      const v = V(), pw = (v && v.pw) || (mk && mk.pw) || 1920, ph = (v && v.ph) || (mk && mk.ph) || 1440;
      const sx = vw / pw, sy = vh / ph, k = Math.max(1, dpr);
      ctx.lineJoin = 'round';
      // avoid zones the bot is honouring
      if (flags.zones && v && v.zones) for (const z of v.zones) {
        const p = proj(z.x, v.gy || 0, z.z), e = proj(z.x + z.r, v.gy || 0, z.z); if (!p || !e) continue;
        const r = Math.hypot((e[0] - p[0]) * sx, (e[1] - p[1]) * sy);
        ctx.fillStyle = 'rgba(255,90,74,.06)'; ctx.strokeStyle = 'rgba(255,90,74,.6)'; ctx.lineWidth = 1.5 * k;     // zones are big (14-18 m): keep them readable without hiding the scene
        ctx.beginPath(); ctx.arc(p[0] * sx, p[1] * sy, r, 0, 6.283); ctx.fill(); ctx.stroke();
        ctx.font = (11 * k) + 'px sans-serif'; ctx.fillStyle = '#ff9d8f'; ctx.fillText('avoid ' + fmt(z.ttl_left || 0), p[0] * sx - 20 * k, p[1] * sy - r - 4 * k);
      }
      // temporary marks from the page (command feedback: where the hero was sent, an avoid-zone preview, a probe result...)
      if (v) { const nowT = performance.now(); marks = marks.filter(m => m.until > nowT); }
      if (v) for (const m of marks) {
        const p = proj(m.x, v.gy || 0, m.z); if (!p) continue;
        const x = p[0] * sx, y = p[1] * sy, col = m.color || '#ffffff';
        let r = 14 * k;
        if (m.r) { const e = proj(m.x + m.r, v.gy || 0, m.z); if (e) r = Math.hypot((e[0] - p[0]) * sx, (e[1] - p[1]) * sy); }
        ctx.lineWidth = 3 * k; ctx.strokeStyle = col; ctx.fillStyle = m.r ? 'rgba(255,255,255,.08)' : 'rgba(0,0,0,0)';
        ctx.beginPath(); ctx.arc(x, y, r, 0, 6.283); ctx.fill(); ctx.stroke();
        if (m.label) { ctx.font = 'bold ' + (11 * k) + 'px sans-serif'; const tw = ctx.measureText(m.label).width; ctx.fillStyle = 'rgba(0,0,0,.7)'; ctx.fillRect(x - tw / 2 - 4 * k, y - r - 20 * k, tw + 8 * k, 16 * k); ctx.fillStyle = col; ctx.fillText(m.label, x - tw / 2, y - r - 8 * k); }
      }
      // incident rings (positions come from the command center)
      if (flags.inc && v) for (const i of incidents) {
        const p = proj(i.x, v.gy || 0, i.z); if (!p) continue;
        const x = p[0] * sx, y = p[1] * sy, col = i.sev === 'crit' ? '#ff5a4a' : '#f0b35e', r = 22 * k;
        ctx.lineWidth = 3 * k; ctx.strokeStyle = col; ctx.setLineDash([6 * k, 4 * k]); ctx.beginPath(); ctx.arc(x, y, r, 0, 6.283); ctx.stroke(); ctx.setLineDash([]);
        const label = i.id + ' ' + fmt(i.dur) + (i.cls && i.cls !== 'unknown' ? ' · ' + i.cls : '');
        ctx.font = 'bold ' + (12 * k) + 'px sans-serif'; const tw = ctx.measureText(label).width;
        ctx.fillStyle = 'rgba(0,0,0,.65)'; ctx.fillRect(x + r + 3 * k, y - 9 * k, tw + 8 * k, 18 * k); ctx.fillStyle = col; ctx.fillText(label, x + r + 7 * k, y + 4 * k);
      }
      if (!mk) return;
      // the nav path the hero is walking
      if (flags.path) {
        const pts = [];
        if (mk.lw && v) mk.lw.forEach(w => { const r = w && proj(w[0], v.gy || 0, w[1]); if (r) pts.push(r); });
        else if (mk.ln) mk.ln.forEach(a => pts.push(a));
        if (pts.length > 1) {
          ctx.beginPath(); ctx.strokeStyle = '#fd4'; ctx.lineWidth = 2 * k; ctx.setLineDash([5 * k, 4 * k]);
          pts.forEach((r, i) => { const x = r[0] * sx, y = r[1] * sy; i ? ctx.lineTo(x, y) : ctx.moveTo(x, y); }); ctx.stroke(); ctx.setLineDash([]);
        }
      }
      if (!mk.pts) return;
      for (const p of mk.pts) {
        const kd = kind(p.t); if (flags[kd] === 0) continue;
        const r0 = ptPos(p), px = r0[0] * sx, py = r0[1] * sy;
        if (px < -20 || py < -20 || px > vw + 20 || py > vh + 20) continue;
        if (p.t === 'foe') { ctx.beginPath(); ctx.arc(px, py, 3.5 * k, 0, 7); ctx.fillStyle = p.c; ctx.fill(); continue; }
        const rr = (p.t === 'THREAT' ? 12 : p.t === 'castle' ? 9 : p.t.startsWith('door') ? 7 : 5) * k;
        ctx.beginPath(); ctx.arc(px, py, rr + 2.5 * k, 0, 7); ctx.strokeStyle = 'rgba(0,0,0,.8)'; ctx.lineWidth = 4 * k; ctx.stroke();
        ctx.beginPath(); ctx.arc(px, py, rr, 0, 7); ctx.strokeStyle = p.c; ctx.lineWidth = 2 * k; ctx.stroke();
        ctx.font = 'bold ' + (10 * k) + 'px monospace'; ctx.strokeStyle = 'rgba(0,0,0,.9)'; ctx.lineWidth = 3 * k; ctx.strokeText(p.t, px + 7 * k, py - 6 * k);
        ctx.fillStyle = p.c; ctx.fillText(p.t, px + 7 * k, py - 6 * k);
      }
    }
    function fmt(s) { s = Math.max(0, Math.round(s)); return s < 60 ? s + 's' : Math.floor(s / 60) + 'm' + ('0' + (s % 60)).slice(-2) + 's'; }

    function vramInfo(g) {                              // GB figures + the biggest holders other than the game itself; pressure = max(resident, committed) / physical
      const gb = mb => mb / 1024, nm = n => String(n || '?').replace(/\.exe$/i, '');
      const top = (g.top || []).map(t => ({ name: nm(t.name), gb: gb(t.mb) }));
      return { usedGB: gb(g.used_mb), commitGB: gb(g.committed_mb), totalGB: gb(g.total_mb), pressure: g.pressure != null ? g.pressure : Math.max(g.used_mb, g.committed_mb) / g.total_mb, top, others: top.filter(t => !/^thronefall/i.test(t.name)) };
    }
    function summary() {
      const now = performance.now(), idle = lastFrameT ? now - lastFrameT : 1e9;
      const fps = rate(drawT), net = rate(recvT), lat = st.lat.length ? q(st.lat, .5) : 0;
      let level = 'ok', text;
      if (!ws || ws.readyState !== 1) { level = 'bad'; text = 'NO SIGNAL · reconnecting'; }
      else if (state === 'plugin' || (info && (info.flags & 1) && !(info.flags & 4))) { level = 'warn'; text = 'FALLBACK plugin screenshots ' + fps.toFixed(1) + ' fps'; }
      else if (state === 'no-window') { level = 'bad'; text = 'GAME NOT RUNNING'; }
      else if (idle > 1500) { level = state === 'static' ? 'warn' : 'bad'; text = (state === 'static' ? 'STATIC SCENE' : 'NO NEW FRAMES') + ' · ' + (idle / 1000).toFixed(1) + 's'; }
      else { level = fps >= 24 && lat < 150 ? 'ok' : fps >= 12 ? 'warn' : 'bad'; text = fps.toFixed(1) + ' fps · ' + Math.round(lat) + ' ms'; }
      // say WHO is slow: frames arriving slowly = the game / capture; frames arriving fast but drawn slowly = this browser
      let reason = level === 'ok' || !ws ? '' : net < 20 ? 'the game is presenting only ' + net.toFixed(0) + ' fps - not a video problem' : fps < net * 0.7 ? 'this browser is dropping frames' : lat >= 150 ? 'high latency' : '';
      const pf = perf && now - perfAt < 6000 ? perf : null;                      // ground truth from inside the game: who is stalling it
      const gp = gpu && now - gpuAt < 20000 ? gpu : null;                        // VRAM, sampled every 5 s while somebody watches
      const vram = gp && gp.total_mb ? vramInfo(gp) : null;
      if (reason && pf && pf.causes && pf.causes.n >= 10) {
        const c = pf.causes;
        // Each real stall is counted once (livecap drops the log's delta-time echoes). "engine" = time not inside one of the plugin's measured sections: the game's own work, GPU / driver / OS,
        // plugin work outside Update, and stalls just under the logging threshold. So this says WHERE the stall is, never WHY; the VRAM figure is shown as a fact next to it, not as the cause.
        const secs = c.sections ? Object.keys(c.sections).slice(0, 2).map(k => k + ' ' + Math.round(c.sections[k] * 100) + '%').join(', ') : '';
        if (c.plugin > 0.4) reason = 'plugin code is stalling the game (' + Math.round(c.plugin * 100) + '% of stalled time' + (secs ? ': ' + secs : '') + ')';
        else if (c.engine > 0.7) reason = 'the game itself stalls (' + c.n + ' stalls >100 ms in the last minute) - not the video; ' + Math.round(c.engine * 100) + '% of that time is outside the plugin\'s measured code' + (vram && vram.pressure >= 0.9 ? ' · VRAM ' + Math.round(vram.pressure * 100) + '% full' + (vram.others.length ? ' (' + vram.others.slice(0, 2).map(o => o.name + ' ' + o.gb.toFixed(1) + ' GB').join(', ') + ')' : '') : '');
      }
      if (reason && pf && pf.causes && pf.causes.period_s) reason += ' · a stall >200 ms every ' + pf.causes.period_s.toFixed(0) + ' s (a timer)';
      return { vram, hud: lastHud, perf: pf ? { fps: pf.fps, p99: pf.frame_ms && pf.frame_ms.p99, stalls100: pf.stalls_100, pluginMs: pf.plugin_ms && pf.plugin_ms.avg, causes: pf.causes } : null, reason, fps, net, lat, latP95: q(st.lat, .95), dec: q(st.decMs, .5), decP95: q(st.decMs, .95), dropped: st.dropped, recv: st.recv, drawn: st.drawn, err: st.err, idle, level, text, state, detail,
               src: info ? ((info.flags & 4) ? 'game' : (info.flags & 1) ? 'plugin' : state === 'synthetic' ? 'test' : 'wgc') : '', w: sw, h: sh, kbps: Math.round(st.bytes / 1024 / Math.max(1, (now - st.t0) / 1000)), serverV, cfg: cfgInfo };
    }
    function drawHud() {
      if (!flags.hud) return;
      const s = summary(), k = Math.max(1, dpr), col = { ok: '#7bc96f', warn: '#e8a33d', bad: '#e0604f' }[s.level];
      const x = 14 * k, y = ch - 28 * k, maxW = Math.max(80 * k, cw - x - 10 * k);      // bottom-left: the page banner owns the top edge, the gold chest the bottom-right
      const mainFont = 'bold ' + (11 * k) + 'px sans-serif', dimFont = (10 * k) + 'px sans-serif';
      // The pane can be narrow (the Coach page's Live pane is ~320 px wide): every line is fitted to it, least important parts dropped first.
      const fit = (parts, font) => {
        ctx.font = font;
        for (let n = parts.length; n > 1; n--) { const t = parts.slice(0, n).join(' · '); if (ctx.measureText(t).width <= maxW) return t; }
        let t = parts[0]; while (t.length > 4 && ctx.measureText(t + '…').width > maxW) t = t.slice(0, -1);
        return t === parts[0] ? t : t + '…';
      };
      const label = fit(['● ' + s.text, (s.src || '') + (s.w ? ' ' + s.w + '×' + s.h : '')].filter(t => t.trim()), mainFont);
      ctx.font = mainFont; const tw = ctx.measureText(label).width;
      ctx.fillStyle = 'rgba(10,6,3,.62)'; ctx.fillRect(x - 6 * k, y, tw + 12 * k, 20 * k); ctx.fillStyle = col; ctx.fillText(label, x, y + 14 * k);
      const lines = [];                                                               // [text, colour], bottom to top; the last ones are dropped when the pane is too short
      if (s.perf) {                                                                   // the game's own numbers: fps it renders, 100 ms+ stalls per 5 s, who stalls it
        const c = s.perf.causes;
        lines.push([fit(['game ' + s.perf.fps + ' fps', 'stalls>100ms ' + s.perf.stalls100 + '/5s', c && c.n >= 5 ? 'engine ' + Math.round((c.engine || 0) * 100) + '% plugin ' + Math.round((c.plugin || 0) * 100) + '%' : '',
                          s.perf.pluginMs != null ? 'plugin ' + s.perf.pluginMs.toFixed(1) + ' ms/frame' : ''].filter(Boolean), dimFont), '#b9a98a']);
        if (c && c.period_s) lines.push(['a stall >200 ms every ' + c.period_s.toFixed(0) + ' s (a timer)', '#e8a33d']);        // recurring freezes are a timer, not load: say so in amber
      }
      if (s.vram) {                                                                   // GPU memory as a fact, with who holds it (no claim that it is the cause)
        const v = s.vram;
        lines.push([fit(['VRAM ' + Math.max(v.usedGB, v.commitGB).toFixed(1) + '/' + v.totalGB.toFixed(1) + ' GB (' + Math.round(v.pressure * 100) + '%)'].concat(v.top.slice(0, 3).map(t => t.name + ' ' + t.gb.toFixed(1))), dimFont),
                     v.pressure >= 1 ? '#e0604f' : v.pressure >= 0.9 ? '#e8a33d' : '#b9a98a']);
      }
      const shown = [[label, Math.round(tw)]];
      lines.slice(0, Math.max(0, Math.floor((y - 2 * k) / (16 * k)))).forEach((l, i) => {
        const top = y - 16 * k * (i + 1);
        ctx.font = dimFont; const w = ctx.measureText(l[0]).width; shown.push([l[0], Math.round(w)]);
        ctx.fillStyle = 'rgba(10,6,3,.55)'; ctx.fillRect(x - 6 * k, top, w + 12 * k, 15 * k); ctx.fillStyle = l[1]; ctx.fillText(l[0], x, top + 11 * k);
      });
      lastHud = { cw: Math.round(cw), x: Math.round(x), lines: shown };                 // what was drawn and how wide: the narrow-pane test reads it through LV.stats.hud
    }

    function layout() {                                  // contain-fit the frame into the canvas (identical rectangles when the page container already has the frame's aspect)
      const fw = (info && info.w) || sw || 4, fh = (info && info.h) || sh || 3, sc = Math.min(cw / fw, ch / fh);
      vw = fw * sc; vh = fh * sc; vx = (cw - vw) / 2; vy = (ch - vh) / 2;
    }
    function render() {
      if (!ctx) return;
      layout();
      if (bmp) { if (vx > 0.5 || vy > 0.5) { ctx.fillStyle = '#0d0906'; ctx.fillRect(0, 0, cw, ch); } ctx.drawImage(bmp, vx, vy, vw, vh); } else { ctx.fillStyle = '#0d0906'; ctx.fillRect(0, 0, cw, ch); }
      if (bmp) drawOverlay();
      if (fresh) {                                       // a NEW video frame reached the screen (not just an overlay redraw)
        fresh = false; st.drawn++; drawT.push(performance.now());
        if (info) { st.lat.push(Math.max(0, Date.now() - info.t)); if (st.lat.length > 120) st.lat.shift(); }
      }
      drawHud();
      if (!bmp) {                                        // no picture yet: say why, in words
        const s = summary(), k = Math.max(1, dpr);
        ctx.fillStyle = '#c9b79a'; ctx.font = (14 * k) + 'px sans-serif'; ctx.textAlign = 'center';
        ctx.fillText(s.state === 'no-window' ? 'Thronefall is not running' : s.state === 'minimized' ? 'Game window is minimised - restore it for live video' : 'Waiting for the first frame… (' + s.state + ')', cw / 2, ch / 2);
        if (detail) { ctx.fillStyle = '#8f7e63'; ctx.font = (11 * k) + 'px sans-serif'; ctx.fillText(detail, cw / 2, ch / 2 + 22 * k); }
        ctx.textAlign = 'left';
      }
    }
    let tok = 0;
    function schedule() {                                  // vsync-aligned when the browser renders frames; a timer takes over when it does not (hidden pane, throttling)
      const my = ++tok;
      if (self.requestAnimationFrame) self.requestAnimationFrame(() => { if (my === tok) loop(); });
      setTimeout(() => { if (my === tok) loop(); }, 24);
    }
    function loop() {
      if (dirty && ctx) { dirty = false; try { render(); } catch (e) { st.err++; } }
      const n = performance.now();
      if (n - mkSentT > 200 && mk) { mkSentT = n; postMk(); }
      schedule();
    }
    function postMk() {                                   // legacy-format markers (screen px in the plugin's pw x ph space) for the page's click-to-command hit test
      const v = V(), pw = (v && v.pw) || mk.pw || 1920, ph = (v && v.ph) || mk.ph || 1440, pts = [];
      for (const p of (mk.pts || [])) { const r = ptPos(p); pts.push({ t: p.t, x: r[0], y: r[1], w: pw, h: ph, c: p.c }); }
      post({ type: 'mk', mk: { pw, ph, pts } });
    }

    setInterval(() => {
      const s = summary(); post({ type: 'status', s });
      send({ stats: { fps: +s.fps.toFixed(1), net: +s.net.toFixed(1), lat: Math.round(s.lat), latP95: Math.round(s.latP95), dec: +s.dec.toFixed(1), dropped: s.dropped, w: dpr * 0 + cw, h: ch } });
      if (ws && ws.readyState === 1 && performance.now() - lastMsgT > 8000) { try { ws.close(); } catch (e) { /* force a reconnect */ } }
    }, 500);
    setInterval(() => { dirty = true; }, 250);            // keep the HUD / ring labels / zone countdowns fresh even when the picture is static

    self.onmessage = async e => {
      const m = e.data;
      if (m.type === 'init') {
        canvas = m.canvas; dpr = m.dpr || 1; cw = canvas.width = m.w; ch = canvas.height = m.h; ctx = canvas.getContext('2d', { alpha: false, desynchronized: true });
        url = m.url; connect(); loop();
      } else if (m.type === 'size') { cw = canvas.width = m.w; ch = canvas.height = m.h; dpr = m.dpr || dpr; dirty = true; }
      else if (m.type === 'flags') { flags = Object.assign(flags, m.flags); dirty = true; }
      else if (m.type === 'incidents') { incidents = m.list; dirty = true; }
      else if (m.type === 'set') send({ set: m.set });
      else if (m.type === 'reconnect') { try { if (ws) ws.close(); } catch (err) { /* ignore */ } gen++; retry = 100; hidden = false; connect(); }
      else if (m.type === 'visible') {                    // a tab nobody is looking at must not decode 60 fps of video: drop the socket, come back when shown
        if (!m.v && !hidden) { hidden = true; clearTimeout(retryT); gen++; try { if (ws) ws.close(); } catch (err) { /* ignore */ } ws = null; state = 'paused'; detail = 'page hidden'; }
        else if (m.v && hidden) { hidden = false; retry = 100; connect(); }
      }
      else if (m.type === 'snapshot') {
        if (!bmp) { post({ type: 'rpc', id: m.id, error: 'no frame yet' }); return; }
        try { const oc = new OffscreenCanvas(bmp.width, bmp.height); oc.getContext('2d').drawImage(bmp, 0, 0); post({ type: 'rpc', id: m.id, blob: await oc.convertToBlob({ type: 'image/png' }) }); }
        catch (err) { post({ type: 'rpc', id: m.id, error: String(err) }); }
      } else if (m.type === 'hit') {
        let best = null, bd = 24 * Math.max(1, dpr);
        if (mk && mk.pts) {
          const v = V(), pw = (v && v.pw) || mk.pw || 1920, ph = (v && v.ph) || mk.ph || 1440;
          for (const p of mk.pts) { const r = ptPos(p), d = Math.hypot(vx + r[0] / pw * vw - m.x * dpr, vy + r[1] / ph * vh - m.y * dpr); if (d < bd) { bd = d; best = p.t; } }
        }
        post({ type: 'rpc', id: m.id, hit: best });
      } else if (m.type === 'mark') { marks = marks.filter(x => x.id !== m.mark.id); marks.push(Object.assign({}, m.mark, { until: performance.now() + (m.mark.ttl || 10) * 1000 })); dirty = true; }
      else if (m.type === 'unmark') { marks = marks.filter(x => x.id !== m.id); dirty = true; }
      else if (m.type === 'world') {                      // click position (CSS px in the canvas) -> world metres on the ground plane, for "send the hero here"
        const v = V(); let res = null;
        if (v && vw > 0) {
          const px = ((m.x * dpr - vx) / vw) * v.pw, py = ((m.y * dpr - vy) / vh) * v.ph, M = v.vp, gy = v.gy || 0;
          const nx = (px / v.pw) * 2 - 1, ny = (1 - py / v.ph) * 2 - 1, a = M[0], b = M[2], c = M[4], d = M[6], det = a * d - b * c;
          if (Math.abs(M[12]) < 1e-6 && Math.abs(M[13]) < 1e-6 && Math.abs(M[14]) < 1e-6 && Math.abs(M[15] - 1) < 1e-6 && Math.abs(det) > 1e-12) {      // orthographic camera only
            const rx = nx - M[1] * gy - M[3], ry = ny - M[5] * gy - M[7];
            res = { x: Math.round((rx * d - b * ry) / det * 100) / 100, z: Math.round((a * ry - c * rx) / det * 100) / 100 };
          }
        }
        post({ type: 'rpc', id: m.id, world: res });
      }
    };
  }

  // ------------------------------------------------------------------------------------------------ main thread glue
  const rpcs = {}; let rpcN = 0;
  function rpc(msg) { return new Promise((res, rej) => { const id = ++rpcN; rpcs[id] = { res, rej }; post(Object.assign({ id }, msg)); setTimeout(() => { if (rpcs[id]) { delete rpcs[id]; rej(new Error('timeout')); } }, 4000); }); }
  let worker = null;
  function post(m) { if (worker) worker.postMessage(m); }

  const canvas = document.createElement('canvas');
  canvas.id = 'lvc';
  canvas.style.cssText = 'position:absolute;left:0;top:0;width:100%;height:100%;border-radius:9px;display:none;background:#0d0906';
  if (standalone || !shot) { host.appendChild(canvas); canvas.style.borderRadius = '0'; }
  else shot.parentNode.insertBefore(canvas, shot.nextSibling);
  const SPACER = (w, h) => "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='" + w + "' height='" + h + "'/>";
  let spacerKey = '';
  const lvAge = document.getElementById('lvAge'), lvFps = document.getElementById('lvFps');
  if (!standalone && lvFps && lvFps.parentNode && !document.getElementById('lvQ')) {      // stream quality picker (livecap applies it for every viewer; the plugin is told too)
    const sel = document.createElement('select'); sel.id = 'lvQ'; sel.title = 'video quality (applies to the capture process)';
    sel.style.cssText = 'background:#2a2016;color:var(--dim,#b9a98a);border:1px solid var(--bord,#4a3a28);border-radius:6px;font-size:10px;padding:0 3px;margin:0 6px;max-width:130px';
    [['', 'quality…'], ['smooth', 'Smooth 30 fps · 960'], ['balanced', 'Balanced 60 fps · 1280'], ['sharp', 'Sharp 60 fps · 1920']].forEach(([v, t]) => { const o = document.createElement('option'); o.value = v; o.textContent = t; sel.appendChild(o); });
    sel.onchange = () => { const p = { smooth: { fps: 30, width: 960, quality: 9 }, balanced: { fps: 60, width: 1280, quality: 7 }, sharp: { fps: 60, width: 1920, quality: 5 } }[sel.value]; if (p) LV.set(p); };
    lvFps.parentNode.insertBefore(sel, lvFps);
  }

  function setActive(on, w, h) {
    if (on) {
      canvas.style.display = 'block';
      if (shot && !standalone) {
        try { if (typeof mkx !== 'undefined') mkx.clearRect(0, 0, mkcv.width, mkcv.height); } catch (e) { /* the page's legacy marker layer - cleared once, we draw them now */ }
        const key = w + 'x' + h;
        if (key !== spacerKey) { spacerKey = key; shot.onerror = null; shot.src = SPACER(w, h); }   // keeps the container sized; stops the MJPEG download
        shot.style.visibility = 'hidden';
      }
      if (!LV.active) { LV.active = true; try { document.dispatchEvent(new CustomEvent('lv-active', { detail: true })); } catch (e) { /* old browser */ } }
    } else if (LV.active) {
      LV.active = false; canvas.style.display = 'none';
      if (shot && !standalone) { shot.style.visibility = ''; spacerKey = ''; try { if (typeof reconnectStream === 'function') reconnectStream(); } catch (e) { /* page without it */ } }
      try { document.dispatchEvent(new CustomEvent('lv-active', { detail: false })); } catch (e) { /* old browser */ }
    }
  }

  function dims() {
    const r = host.getBoundingClientRect(); const dpr = Math.min(2, window.devicePixelRatio || 1);
    return { w: Math.max(2, Math.round((r.width || host.clientWidth || 640) * dpr)), h: Math.max(2, Math.round((r.height || host.clientHeight || 480) * dpr)), dpr };
  }
  function start() {
    if (!window.OffscreenCanvas || !canvas.transferControlToOffscreen || !window.Worker) { LV.state = 'unsupported'; return; }
    let url; try { url = URL.createObjectURL(new Blob(['(' + workerMain.toString() + ')()'], { type: 'text/javascript' })); worker = new Worker(url); } catch (e) { LV.state = 'unsupported'; return; }
    canvas.style.display = 'block';                 // must be laid out before we measure it
    const d = dims(); const off = canvas.transferControlToOffscreen();
    canvas.style.display = 'none';
    worker.postMessage({ type: 'init', canvas: off, url: wsUrl, w: d.w, h: d.h, dpr: d.dpr }, [off]);
    let t = 0, lastVis = null;
    const pushVisible = () => {                      // nobody is looking (tab hidden, or the Live pane is not the open one): close the socket so livecap can stop capturing
      const v = !document.hidden && host.clientWidth > 40 && host.clientHeight > 20;
      if (v !== lastVis) { lastVis = v; post({ type: 'visible', v }); }
    };
    new ResizeObserver(() => { clearTimeout(t); t = setTimeout(() => { const n = dims(); post({ type: 'size', w: n.w, h: n.h, dpr: n.dpr }); }, 60); pushVisible(); }).observe(host);
    worker.onmessage = e => {
      const m = e.data;
      if (m.type === 'size') { LV.frameW = m.w; LV.frameH = m.h; setActive(true, m.w, m.h); const n = dims(); post({ type: 'size', w: n.w, h: n.h, dpr: n.dpr }); }
      else if (m.type === 'status') onStatus(m.s);
      else if (m.type === 'mk') { try { if (typeof lastMk !== 'undefined') lastMk = m.mk; } catch (err) { /* page without lastMk */ } }
      else if (m.type === 'rpc') { const p = rpcs[m.id]; if (p) { delete rpcs[m.id]; m.error ? p.rej(new Error(m.error)) : p.res('blob' in m ? m.blob : 'hit' in m ? m.hit : 'world' in m ? m.world : m); } }
    };
    worker.onerror = () => { LV.state = 'worker-error'; setActive(false); };
    document.addEventListener('visibilitychange', pushVisible);
    pushVisible();
    setInterval(() => { try { if (typeof mkOn !== 'undefined') post({ type: 'flags', flags: mkOn }); } catch (e) { /* ignore */ } }, 500);
    window.addEventListener('keydown', ev => {
      if (!standalone || ev.ctrlKey || ev.altKey || ev.metaKey) return;
      if (ev.key === 'f') { document.fullscreenElement ? document.exitFullscreen() : document.documentElement.requestFullscreen().catch(() => {}); }
      else if (ev.key === 'h') post({ type: 'flags', flags: { hud: LV.hudOff ? 1 : 0 } }), (LV.hudOff = !LV.hudOff);
      else if (ev.key === '1') LV.set({ fps: 30, width: 960, quality: 9 });
      else if (ev.key === '2') LV.set({ fps: 60, width: 1280, quality: 7 });
      else if (ev.key === '3') LV.set({ fps: 60, width: 1920, quality: 5 });
    });
  }
  function onStatus(s) {
    LV.stats = s; LV.state = s.state; LV.detail = s.detail;
    if (!LV.active && s.drawn === 0 && s.recv === 0) return;
    if (lvFps) lvFps.textContent = s.fps.toFixed(1) + ' fps · ' + Math.round(s.lat) + ' ms' + (s.dropped ? ' · ' + s.dropped + ' dropped' : '');
    if (lvAge) lvAge.textContent = s.level === 'ok' ? 'live ' + (s.src || '') + ' ' + s.w + '×' + s.h : (s.reason || s.text);
    // no signal for 8 s: hand the picture back to the page's legacy feed (plugin screenshots) while the worker keeps trying to reconnect; the first frame after that re-activates us
    const down = s.state === 'disconnected' || (s.idle > 8000 && s.state !== 'static' && s.state !== 'paused');
    if (down) { LV.__down = LV.__down || Date.now(); if (LV.active && Date.now() - LV.__down > 8000) setActive(false); } else LV.__down = 0;
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', start); else start();
})();
