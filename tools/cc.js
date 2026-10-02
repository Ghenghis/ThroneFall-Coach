/* Command center for the Live View (served at /cc.js, injected by coach-server.py). Self-contained: builds its own DOM inside #p-live,
 polls /botpulse /incidents /mmactions /engineer-queue /audit /view.json, never touches the page's own state. */
(function () {
  'use strict';
  if (window.__ccLoaded) return;
  window.__ccLoaded = true;

  const $ = (s, r) => (r || document).querySelector(s);
  const esc = s => String(s == null ? '' : s).replace(/[&<>"']/g, m => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[m]));
  const fmtS = s => { s = Math.max(0, Math.round(s)); return s < 60 ? s + 's' : s < 3600 ? Math.floor(s / 60) + 'm' + ('0' + (s % 60)).slice(-2) + 's' : Math.floor(s / 3600) + 'h' + ('0' + Math.floor((s % 3600) / 60)).slice(-2) + 'm'; };
  const now = () => Date.now() / 1000;
  const ago = t => (t ? fmtS(now() - t) + ' ago' : 'never');
  const hhmm = t => { if (!t) return '—'; const d = new Date(t * 1000); return ('0' + d.getHours()).slice(-2) + ':' + ('0' + d.getMinutes()).slice(-2) + ':' + ('0' + d.getSeconds()).slice(-2); };
  const KIND = { stuck: 'STUCK', hotspot: 'HOTSPOT', idle: 'IDLE', loop: 'LOOP', wedge: 'WEDGE', feed: 'FEED DEAD', code: 'CODE ERROR' };
  const ICON = { stuck: '⛔', hotspot: '🔥', idle: '💤', loop: '🔁', wedge: '🧊', feed: '📡', code: '🐞' };

  async function jget(u, ms) {
    const c = new AbortController(); const to = setTimeout(() => c.abort(), ms || 4000);
    try { const r = await fetch(u, { signal: c.signal, cache: 'no-store' }); if (!r.ok) throw new Error('HTTP ' + r.status); return await r.json(); }
    finally { clearTimeout(to); }
  }
  async function jpost(u, d) {
    const r = await fetch(u, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(d || {}) });
    return r.json();
  }

  const S = { pulse: null, inc: null, acts: [], queue: [], audit: null, view: null, err: 0, errMsg: '', tab: 'inc', frame: {}, cache: {}, toast: '' };

  // ------------------------------------------------------------------ DOM
  function build() {
    const live = $('#p-live'); const view = $('#view');
    if (!live || !view) return false;
    if ($('#ccAlert')) return true;
    const alert = document.createElement('div'); alert.id = 'ccAlert'; alert.className = 'ok'; alert.textContent = 'loading command center…';
    live.insertBefore(alert, view);
    const strip = document.createElement('div'); strip.id = 'ccStrip';
    const meta = $('#livemeta'); (meta && meta.parentNode ? meta.parentNode : live).insertBefore(strip, meta ? meta.nextSibling : null);
    const cv = document.createElement('canvas'); cv.id = 'ccmk'; view.appendChild(cv);
    const wrap = document.createElement('div'); wrap.id = 'ccWrap';
    wrap.innerHTML =
      '<div class="cc-tabs" id="ccTabs"></div>' +
      '<div class="cc-pane" id="ccp-inc"></div><div class="cc-pane" id="ccp-mm"></div><div class="cc-pane" id="ccp-sched"></div>' +
      '<div class="cc-pane" id="ccp-eng"></div><div class="cc-pane" id="ccp-doors"></div><div id="ccToast" class="hint"></div>';
    live.appendChild(wrap);
    const hd = $('#hd');
    if (hd && !$('#ccHdChip')) {
      const chip = document.createElement('button'); chip.id = 'ccHdChip'; chip.className = 'chip ok'; chip.textContent = '● command center';
      chip.title = 'incident watchdog — click to open the Live View';
      chip.onclick = () => { try { if (typeof tool === 'function') tool('live'); } catch (e) { /* page without tool() */ } };
      const sp = hd.querySelector('.sp'); hd.insertBefore(chip, sp || null);
    }
    live.addEventListener('click', onClick);
    live.addEventListener('change', onChange);
    return true;
  }

  function setIf(el, key, html) { if (!el) return; if (S.cache[key] !== html) { S.cache[key] = html; el.innerHTML = html; } }

  // ------------------------------------------------------------------ render: alert banner
  function worst() { const o = (S.inc && S.inc.open) || []; return o.length ? o[0] : null; }
  function resultClass(r) { r = String(r || ''); return /^(UNSUPPORTED|ERROR|rejected|refused)/.test(r) ? 'bad' : /(queued|suppressed|NOT confirmed|dropped|needs)/.test(r) ? 'warn' : 'ok'; }
  function lastActionLine(i) {
    const a = (i.actions || []).filter(x => x.by === 'minimax' && x.action && x.action.type !== 'wake').slice(-1)[0];
    if (!a) {
      const w = S.pulse && S.pulse.minimax; const pend = w && w.pending_alerts;
      return i.alerts ? (w && w.inflight ? 'MiniMax is thinking…' : (pend ? 'alert queued for MiniMax' : 'alerted MiniMax ' + ago(i.t_alert))) : 'not alerted yet';
    }
    const t = a.action; const what = t.type === 'unstick' ? 'unstick/' + t.how + (t.r ? ' ' + t.r + 'm' : '') + (t.ttl_s ? ' ' + fmtS(t.ttl_s) : '') : t.type === 'command' ? 'knobs ' + JSON.stringify(t.patch || {}).slice(0, 60) : t.type;
    return 'MiniMax ' + ago(a.t) + ': ' + what + ' → ' + a.result;
  }
  function renderAlert() {
    const el = $('#ccAlert'); if (!el) return;
    let cls = 'ok', html = '';
    const bot = (S.pulse && S.pulse.bot) || {}; const r = (S.inc && S.inc.ratings) || {};
    if (S.err >= 2) { cls = 'off'; html = '<span class="cc-t">⚠ command center unreachable</span><span class="cc-dim">' + esc(S.errMsg) + ' — the coach server may be restarting (the supervisor brings it back); retrying every second</span>'; }
    else if (!S.pulse || !S.inc) { html = '<span class="cc-dim">loading command center…</span>'; }
    else if (S.pulse.watchdog && !S.pulse.watchdog.alive) { cls = 'crit'; html = '<span class="cc-t">⚠ watchdog thread is dead</span><span class="cc-dim">the scheduler self-check restarts it within 30 s</span>'; }
    else {
      const w = worst();
      if (w) {
        cls = w.sev === 'crit' ? 'crit' : 'warn';
        const ob = w.obstacle || {}; const pos = w.pos ? '(' + Math.round(w.pos[0]) + ', ' + Math.round(w.pos[1]) + ')' : '';
        const more = S.inc.open.length > 1 ? ' <span class="cc-dim">+' + (S.inc.open.length - 1) + ' more</span>' : '';
        html = '<div class="cc-row"><span class="cc-t">' + (ICON[w.kind] || '⚠') + ' ' + (KIND[w.kind] || esc(w.kind)) + ' <span data-v="dur:' + esc(w.id) + '">' + fmtS(w.dur_s || 0) + '</span></span>' +
          '<span>' + (ob.class && ob.class !== 'unknown' ? esc(ob.class) + ' “' + esc(ob.name) + '” ' : '') + pos + (w.target ? ' · target ' + esc(w.target) : '') + '</span>' + more +
          '<span class="cc-sp"></span><button data-cc="wake" data-id="' + esc(w.id) + '">Ask MiniMax now</button><button data-cc="ack" data-id="' + esc(w.id) + '">Ack</button></div>' +
          '<div class="cc-dim">' + esc(lastActionLine(w)) + '</div>';
      } else {
        html = '<div class="cc-row"><span class="cc-t">● all clear</span><span>health ' + (r.health != null ? esc(r.health) + ' (' + esc(r.grade) + ')' : '—') + '</span><span class="cc-dim">speed ' + (r.speed_mps != null ? r.speed_mps + ' m/s' : '—') + ' · moving ' + (r.moving_pct_60s != null ? r.moving_pct_60s + '%' : '—') + ' · ' + (S.inc.counters ? S.inc.counters.opened + ' incidents so far' : '') + '</span></div>';
      }
      if (bot.audit_age_s != null && bot.audit_age_s > 10) { cls = 'crit'; html = '<div class="cc-row"><span class="cc-t">📡 bot silent for ' + fmtS(bot.audit_age_s) + '</span><span class="cc-dim">no telemetry — game frozen or closed?</span></div>' + html; }
    }
    el.className = cls; setIf(el, 'alert', html);
    const chip = $('#ccHdChip');
    if (chip) {
      const o = (S.inc && S.inc.open) || []; const crit = o.filter(x => x.sev === 'crit').length;
      chip.className = 'chip ' + (S.err >= 2 ? 'crit' : crit ? 'crit' : o.length ? 'warn' : 'ok');
      chip.textContent = S.err >= 2 ? '▲ cc offline' : o.length ? '▲ ' + o.length + ' incident' + (o.length > 1 ? 's' : '') + (crit ? ' (' + crit + ' crit)' : '') : '● all clear';
    }
  }

  // ------------------------------------------------------------------ render: heartbeat strip
  function dot(c) { return '<span class="cc-dot ' + c + '"></span>'; }
  function renderStrip() {
    const el = $('#ccStrip'); if (!el) return;
    const p = S.pulse; if (!p) { setIf(el, 'strip', ''); return; }
    const bot = p.bot || {}, mm = p.minimax || {}, wd = p.watchdog || {}, r = (S.inc && S.inc.ratings) || {}, jobs = p.scheduler || [];
    const age = bot.audit_age_s; const botDot = age == null ? 'bad' : age < 6 ? 'ok' : age < 10 ? 'warn' : 'bad';
    const nextJob = jobs.filter(j => j.enabled).sort((a, b) => a.next - b.next)[0];
    const lw = mm.last_wake || {}; const mmDot = mm.mode === 'off' ? 'warn' : lw.ok === false ? 'bad' : 'ok';
    const hcol = r.grade ? 'g' + String(r.grade).replace(/[^A-F]/g, '') : '';
    const modes = ['off', 'semi', 'auto', 'aggressive'].map(m => '<button data-cc="mode" data-mode="' + m + '" class="' + (mm.mode === m ? 'on' : '') + '" title="' + ({ off: 'no MiniMax calls, alerts only logged', semi: 'MiniMax decides, you approve each action', auto: 'validated actions run themselves', aggressive: 'auto + no dedupe' }[m]) + '">' + m.slice(0, 4).toUpperCase() + '</button>').join('');
    const sup = p.supervisor || {};
    const supAge = sup.t ? now() - sup.t : null;
    const cells = [
      '<div class="cc-cell"><div class="k">' + dot(botDot) + ' bot</div><div class="v">' + esc(bot.scene || '—') + '</div><div class="s">' + esc(bot.mode || '') + ' · feed ' + (age == null ? '—' : age.toFixed(0) + 's old') + '</div></div>',
      '<div class="cc-cell"><div class="k">' + dot(wd.alive ? 'ok' : 'bad') + ' watchdog</div><div class="v">' + (wd.alive ? 'alive' : 'DEAD') + '</div><div class="s">polled ' + (wd.age_s == null ? '—' : wd.age_s.toFixed(0) + 's ago') + ' · up ' + fmtS(wd.uptime_s || 0) + '</div></div>',
      '<div class="cc-cell"><div class="k">' + dot(mmDot) + ' minimax</div><div class="v">' + esc((mm.mode || '—').toUpperCase()) + (mm.inflight ? ' · thinking…' : '') + '</div><div class="s">woke ' + (lw.t ? ago(lw.t) : 'never') + (lw.ok === false ? ' · ERROR' : '') + ' · ' + (mm.calls_10min || 0) + '/' + (mm.budget_10min || 0) + ' in 10m</div><div class="cc-modes">' + modes + '</div></div>',
      '<div class="cc-cell"><div class="k">' + dot(nextJob ? 'ok' : 'warn') + ' scheduler</div><div class="v">' + (nextJob ? esc(nextJob.id) + ' in ' + fmtS(nextJob.next - now()) : 'idle') + '</div><div class="s">' + jobs.filter(j => j.enabled).length + '/' + jobs.length + ' jobs on · review every ' + fmtS(((jobs.find(j => j.id === 'review') || {}).every_s) || 0) + '</div></div>',
      '<div class="cc-cell"><div class="k">health</div><div class="v ' + hcol + '">' + (r.grade ? esc(r.grade) + ' · ' + esc(r.health) : '—') + '</div><div class="s">stuck ' + (r.stuck_s_now || 0) + 's · moving ' + (r.moving_pct_60s != null ? r.moving_pct_60s + '%' : '—') + (r.useful_pct != null ? ' · useful ' + Math.round(r.useful_pct) + '%' : '') + '</div></div>',
      '<div class="cc-cell"><div class="k">incidents</div><div class="v">' + esc(r.open || 0) + ' open' + (r.crit ? ' · ' + esc(r.crit) + ' crit' : '') + '</div><div class="s">' + ((S.inc && S.inc.counters) ? S.inc.counters.opened + ' opened · ' + S.inc.counters.resolved + ' resolved · ' + S.inc.counters.alerts + ' alerts' : '') + '</div></div>',
      '<div class="cc-cell"><div class="k">' + dot(sup.t ? (supAge < 150 ? 'ok' : 'warn') : 'warn') + ' supervisor</div><div class="v">' + (sup.t ? 'watching' : 'not installed') + '</div><div class="s">' + (sup.t ? 'checked ' + fmtS(supAge) + ' ago · ' + (sup.restarts || 0) + ' restarts' : 'keeps this server alive') + '</div></div>'
    ];
    setIf(el, 'strip', cells.join(''));
  }

  // ------------------------------------------------------------------ render: tabs
  function renderTabs() {
    const open = (S.inc && S.inc.open) || []; const crit = open.filter(x => x.sev === 'crit').length;
    const pend = (S.pulse && S.pulse.pending) || [];
    const q = (S.queue || []).filter(x => ['queued', 'working', 'patched'].includes(x.status)).length;
    const tabs = [['inc', 'Incidents', open.length, crit ? 'crit' : open.length ? 'warn' : ''], ['mm', 'MiniMax' + (pend.length ? ' ⏳' : ''), S.acts.length || '', ''], ['sched', 'Scheduler', '', ''], ['eng', 'Engineer', q || '', q ? 'warn' : ''], ['doors', 'Doors & foes', '', '']];
    setIf($('#ccTabs'), 'tabs', tabs.map(t => '<button data-cc="tab" data-tab="' + t[0] + '" class="' + (S.tab === t[0] ? 'on' : '') + '">' + t[1] + (t[2] !== '' ? '<span class="n ' + t[3] + '">' + t[2] + '</span>' : '') + '</button>').join(''));
    ['inc', 'mm', 'sched', 'eng', 'doors'].forEach(k => { const p = $('#ccp-' + k); if (p) p.className = 'cc-pane' + (S.tab === k ? ' on' : ''); });
    if (S.tab === 'inc') renderInc(); else if (S.tab === 'mm') renderMM(); else if (S.tab === 'sched') renderSched(); else if (S.tab === 'eng') renderEng(); else renderDoors();
  }

  function incCard(i) {
    const ob = i.obstacle || {}; const pos = i.pos ? '(' + Math.round(i.pos[0]) + ', ' + Math.round(i.pos[1]) + ')' : '';
    const acts = (i.actions || []).slice(-6).map(a => {
      const t = a.action || {}; const what = t.type === 'unstick' ? 'unstick/' + t.how + (t.r ? ' r' + t.r : '') + (t.ttl_s ? ' ' + fmtS(t.ttl_s) : '') : t.type === 'command' ? 'knobs ' + esc(JSON.stringify(t.patch || {}).slice(0, 50)) : t.type === 'code_task' ? 'code task: ' + esc((t.title || '').slice(0, 60)) : esc(t.type || '');
      return '<div><span class="cc-dim">' + hhmm(a.t) + ' ' + esc(a.by) + '</span> ' + what + ' → <span class="cc-res ' + resultClass(a.result) + '">' + esc(a.result) + '</span></div>';
    }).join('');
    const f = S.frame[i.id] ? '<img class="cc-frame" src="/incident/frame?id=' + esc(i.id) + '" alt="frame at incident open">' : '';
    return '<div class="cc-inc sev-' + esc(i.sev) + (i.acked ? ' acked' : '') + '" data-id="' + esc(i.id) + '">' +
      '<div class="cc-ih"><span class="cc-badge ' + esc(i.kind) + '">' + (KIND[i.kind] || esc(i.kind)) + '</span><b>' + esc(i.id) + '</b><span class="cc-sev ' + esc(i.sev) + '">' + esc(String(i.sev).toUpperCase()) + '</span>' +
      '<span class="cc-dim">open <span data-v="age:' + esc(i.id) + '">' + fmtS(now() - i.t_open) + '</span>' + (i.acked ? ' · acked by ' + esc(i.acked.by) : '') + '</span><span class="cc-sp"></span>' +
      '<button class="cc-btn" data-cc="wake" data-id="' + esc(i.id) + '">Ask MiniMax</button><button class="cc-btn" data-cc="ack" data-id="' + esc(i.id) + '">Ack</button><button class="cc-btn" data-cc="frame" data-id="' + esc(i.id) + '">Frame</button></div>' +
      '<div class="cc-ib">' + (i.kind === 'stuck' || i.kind === 'hotspot' ? 'pinned <b data-v="dur:' + esc(i.id) + '">' + fmtS(i.dur_s || 0) + '</b>' + (i.count ? ' · ' + i.count + (i.kind === 'hotspot' ? ' visits' : ' strikes') : '') + ' on ' : '') +
      (ob.class && ob.class !== 'unknown' ? '<b>' + esc(ob.class) + '</b> “' + esc(ob.name) + '” <span class="cc-tag ' + (ob.immovable ? 'imm' : 'mov') + '">' + (ob.immovable ? 'immovable' : ob.immovable === false ? 'movable' : '?') + '</span> ' : '') + pos +
      (i.target ? ' · target <b>' + esc(i.target) + '</b>' : '') + (i.mode ? ' · ' + esc(i.mode) : '') + '</div>' +
      (i.detail && !(i.kind === 'stuck' || i.kind === 'hotspot') ? '<div class="cc-dim">' + esc(i.detail) + '</div>' : '') +
      (acts ? '<div class="cc-act">' + acts + '</div>' : '<div class="cc-act cc-dim">' + esc(lastActionLine(i)) + '</div>') + f + '</div>';
  }
  function renderInc() {
    const el = $('#ccp-inc'); if (!el || !S.inc) return;
    const open = S.inc.open || []; const rec = S.inc.recent || [];
    const sig = JSON.stringify([open.map(i => [i.id, i.sev, i.acked, (i.actions || []).length, i.alerts, i.count, S.frame[i.id]]), rec.map(i => i.id), (S.pulse && S.pulse.pending || []).length]);
    if (S.cache.incSig !== sig) {
      S.cache.incSig = sig;
      const pend = (S.pulse && S.pulse.pending) || [];
      const pendHtml = pend.length ? '<div class="cc-pend"><b>Awaiting your approval (' + pend.length + ')</b>' + pend.map((x, idx) => '<div class="cc-row" style="display:flex;gap:6px;align-items:center;margin-top:3px"><span style="flex:1">' + esc(x.note || '') + ' <span class="cc-dim">' + esc(JSON.stringify(x.patch || {}).slice(0, 90)) + '</span></span><button class="cc-btn" data-cc="approve" data-idx="' + idx + '">Approve</button><button class="cc-btn" data-cc="reject" data-idx="' + idx + '">Reject</button></div>').join('') + '</div>' : '';
      const openHtml = open.length ? open.map(incCard).join('') : '<div class="cc-empty">No open incidents. The watchdog flags a pin streak ≥ 5 s, the same spot pinned again and again, gold-idle, wedged UI, a dead feed and exceptions in the game log — and wakes MiniMax the moment one appears.</div>';
      const recHtml = rec.length ? '<table class="cc-tbl"><tr><th>id</th><th>kind</th><th>lasted</th><th>where / what</th><th>closed by</th><th>tried</th></tr>' + rec.map(i => '<tr><td>' + esc(i.id) + '</td><td>' + (KIND[i.kind] || esc(i.kind)) + '</td><td>' + fmtS(i.dur_s || 0) + '</td><td>' + (i.pos ? '(' + Math.round(i.pos[0]) + ', ' + Math.round(i.pos[1]) + ') ' : '') + esc(i.obstacle && i.obstacle.class && i.obstacle.class !== 'unknown' ? i.obstacle.class : '') + '</td><td>' + esc(i.resolved_by || '') + '</td><td>' + ((i.actions || []).filter(a => a.by === 'minimax' && a.action && a.action.type !== 'wake').map(a => esc((a.action.how || a.action.type))).join(', ') || '—') + '</td></tr>').join('') + '</table>' : '<div class="cc-empty">nothing resolved yet this session</div>';
      el.innerHTML = pendHtml + openHtml + '<div class="cc-card"><h5>Recently resolved</h5>' + recHtml + '</div>';
    }
    tickVolatile();
  }
  function tickVolatile() {
    const byId = {}; ((S.inc && S.inc.open) || []).forEach(i => { byId[i.id] = i; });
    document.querySelectorAll('#p-live [data-v]').forEach(e => {
      const [k, id] = e.getAttribute('data-v').split(':'); const i = byId[id]; if (!i) return;
      const live = k === 'dur' ? fmtS(i.dur_s || 0) : k === 'age' ? fmtS(now() - i.t_open) : null; if (live != null && e.textContent !== live) e.textContent = live;
    });
  }

  function renderMM() {
    const el = $('#ccp-mm'); if (!el) return;
    const acts = S.acts || [];
    const html = acts.length ? acts.slice().reverse().map(r => {
      const rows = (r.actions || []).map(a => '<div>' + esc(a.type) + (a.how ? '/' + esc(a.how) : '') + ' <span class="cc-dim">' + esc(JSON.stringify(a.params || {}).slice(0, 110)) + '</span> → <span class="cc-res ' + resultClass(a.result) + '">' + esc(a.result) + '</span></div>').join('');
      return '<div class="cc-card"><h5>' + hhmm(r.t) + ' · ' + esc(r.reason || '') + (r.incidents && r.incidents.length ? ' · ' + esc(r.incidents.join(', ')) : '') + '</h5>' +
        (r.error ? '<div class="cc-res bad">ERROR: ' + esc(r.error) + '</div>' : '') +
        (r.diagnosis ? '<div class="diag">' + esc(r.diagnosis) + '</div>' : '') +
        '<div class="cc-dim">' + (r.cause ? 'cause: ' + esc(r.cause) + ' · ' : '') + (r.confidence != null ? 'confidence ' + esc(r.confidence) + ' · ' : '') + (r.latency_s != null ? r.latency_s + 's · ' : '') + ((r.usage && r.usage.total_tokens) ? r.usage.total_tokens + ' tokens' : '') + '</div>' +
        (rows ? '<div class="cc-act">' + rows + '</div>' : '') + '</div>';
    }).join('') : '<div class="cc-empty">MiniMax has not been woken yet. It wakes on incidents, on a bad health rating, and for a scheduled review.</div>';
    setIf(el, 'mm', html);
  }

  function renderSched() {
    const el = $('#ccp-sched'); if (!el) return;
    const jobs = (S.pulse && S.pulse.scheduler) || [];
    const sig = JSON.stringify(jobs.map(j => [j.id, j.enabled, j.every_s, j.runs, j.last_ok, j.last_note]));
    if (S.cache.schedSig !== sig) {
      S.cache.schedSig = sig;
      el.innerHTML = '<div class="cc-card"><h5>System scheduler — always on while the coach server runs</h5><table class="cc-tbl"><tr><th>job</th><th>every (s)</th><th>on</th><th>last</th><th>next</th><th></th></tr>' +
        jobs.map(j => '<tr><td><b>' + esc(j.id) + '</b><div class="cc-dim">' + esc(j.desc) + '</div></td><td><input type="number" min="10" data-cc="job-every" data-job="' + esc(j.id) + '" value="' + Math.round(j.every_s) + '"></td><td><span class="cc-tgl ' + (j.enabled ? 'on' : '') + '" data-cc="job-toggle" data-job="' + esc(j.id) + '" data-on="' + (j.enabled ? 1 : 0) + '"></span></td><td><span data-lastj="' + esc(j.id) + '">' + ago(j.last) + '</span><div class="cc-res ' + (j.last_ok === false ? 'bad' : 'ok') + '">' + esc(j.last_note || '') + '</div><div class="cc-dim">' + (j.runs || 0) + ' runs</div></td><td><span data-nextj="' + esc(j.id) + '"></span></td><td><button class="cc-btn" data-cc="job-run" data-job="' + esc(j.id) + '">run now</button></td></tr>').join('') +
        '</table><div class="hint">pulse = heartbeat + wake on bad health · review = MiniMax studies the incident statistics and the effect of its earlier actions · selfcheck = restarts the watchdog thread if it dies · report = hourly summary in the chat. MiniMax\'s own cron jobs live in the MiniMax Control tab.</div></div>';
    }
    jobs.forEach(j => { const a = el.querySelector('[data-nextj="' + j.id + '"]'); if (a) a.textContent = j.enabled ? 'in ' + fmtS(j.next - now()) : 'off'; const b = el.querySelector('[data-lastj="' + j.id + '"]'); if (b) b.textContent = ago(j.last); });
  }

  function renderEng() {
    const el = $('#ccp-eng'); if (!el) return;
    const q = S.queue || [];
    const html = q.length ? q.map(e => '<div class="cc-card"><h5>' + esc(e.id) + ' · ' + esc(e.status) + ' · ' + esc(e.priority || '') + ' · ' + hhmm(e.t) + '</h5><div class="diag"><b>' + esc(e.title) + '</b></div><div class="cc-dim">' + esc(e.file || '') + ' ' + esc(e.function || '') + (e.incidents && e.incidents.length ? ' · from ' + esc(e.incidents.join(', ')) : '') + '</div>' + (e.evidence ? '<div class="cc-dim">evidence: ' + esc(e.evidence) + '</div>' : '') + (e.fix ? '<div class="cc-dim">fix: ' + esc(e.fix) + '</div>' : '') + '</div>').join('') : '<div class="cc-empty">No code tasks queued. When an incident needs a code change that no command can make, MiniMax files an URGENT task here (and in proposals.jsonl) with file, function and evidence.</div>';
    setIf(el, 'eng', html);
  }

  function renderDoors() {
    const el = $('#ccp-doors'); if (!el) return; const a = S.audit || {};
    const lines = a.door_lines || [], units = a.door_units || [];
    const html = '<div class="cc-card"><h5>Wave &amp; foes</h5><div class="cc-dim">wave ' + esc(a.wave) + '/' + esc(a.wave_total) + ' · foes ' + esc(a.foes) + ' · next wave ' + esc(a.next_foes) + ' foes · ' + (a.night ? 'NIGHT' : 'day') + (a.red ? ' · <b style="color:var(--bad)">RED ALERT</b>' : '') + ' · gold ' + esc(a.gold) + ' · army ' + esc(a.ally) + '/' + esc(a.army_target) + '</div></div>' +
      '<div class="cc-card"><h5>Door posts (' + esc(a.doors_cov) + '/' + esc(a.doors) + ' covered, ' + esc(a.doors_parked || 0) + ' parked)</h5>' + (lines.length ? '<table class="cc-tbl"><tr><th>#</th><th>corridor</th><th>units posted</th><th>state</th></tr>' + lines.map((l, i) => '<tr><td>' + i + '</td><td>' + esc(l) + '</td><td>' + (units[i] || 0) + '</td><td>' + ((units[i] || 0) > 0 ? '<span class="cc-res ok">covered</span>' : '<span class="cc-res bad">open</span>') + '</td></tr>').join('') + '</table>' : '<div class="cc-empty">no door data in the audit yet</div>') + '</div>';
    setIf(el, 'doors', html);
  }

  // ------------------------------------------------------------------ world overlay (needs view.json from the plugin: camera matrix)
  function project(vp, x, y, z, pw, ph) {
    const cx = vp[0] * x + vp[1] * y + vp[2] * z + vp[3], cy = vp[4] * x + vp[5] * y + vp[6] * z + vp[7], cw = vp[12] * x + vp[13] * y + vp[14] * z + vp[15];
    if (cw <= 0.0001) return null;
    return [(cx / cw * 0.5 + 0.5) * pw, (1 - (cy / cw * 0.5 + 0.5)) * ph];
  }
  function drawOverlay() {
    const cv = $('#ccmk'), img = $('#shot'); if (!cv || !img) return;
    if (window.LV && window.LV.active) { if (cv.width) cv.getContext('2d').clearRect(0, 0, cv.width, cv.height); return; }   // live.js draws zones + incident rings itself, world-locked
    const w = img.clientWidth, h = img.clientHeight; if (cv.width !== w) cv.width = w; if (cv.height !== h) cv.height = h;
    const g = cv.getContext('2d'); g.clearRect(0, 0, w, h);
    const v = S.view; if (!v || !v.vp || !S.inc) return;
    const sx = w / v.pw, sy = h / v.ph;
    const inc = (S.inc.open || []).filter(i => i.pos);
    inc.forEach(i => {
      const p = project(v.vp, i.pos[0], v.gy || 0, i.pos[1], v.pw, v.ph); if (!p) return;
      const x = p[0] * sx, y = p[1] * sy, col = i.sev === 'crit' ? '#ff5a4a' : '#f0b35e';
      const r = Math.max(14, 22 * (w / 900));
      g.lineWidth = 3; g.strokeStyle = col; g.setLineDash([6, 4]); g.beginPath(); g.arc(x, y, r, 0, 6.283); g.stroke(); g.setLineDash([]);
      g.fillStyle = col; g.font = 'bold 12px Segoe UI'; const label = (ICON[i.kind] || '') + ' ' + i.id + ' ' + fmtS(i.dur_s || 0) + (i.obstacle && i.obstacle.class !== 'unknown' ? ' · ' + i.obstacle.class : '');
      g.fillStyle = 'rgba(0,0,0,.65)'; const tw = g.measureText(label).width; g.fillRect(x + r + 3, y - 9, tw + 8, 18); g.fillStyle = col; g.fillText(label, x + r + 7, y + 4);
    });
    (v.zones || []).forEach(z => {                                    // avoid zones the bot is currently honouring: circle of r metres
      const p = project(v.vp, z.x, v.gy || 0, z.z, v.pw, v.ph), q = project(v.vp, z.x + z.r, v.gy || 0, z.z, v.pw, v.ph); if (!p || !q) return;
      const rr = Math.hypot((q[0] - p[0]) * sx, (q[1] - p[1]) * sy);
      g.strokeStyle = 'rgba(255,90,74,.9)'; g.fillStyle = 'rgba(255,90,74,.12)'; g.lineWidth = 2; g.beginPath(); g.arc(p[0] * sx, p[1] * sy, rr, 0, 6.283); g.fill(); g.stroke();
      g.fillStyle = '#ff9d8f'; g.font = '11px Segoe UI'; g.fillText('avoid ' + fmtS(z.ttl_left || 0), p[0] * sx - 20, p[1] * sy - rr - 4);
    });
  }

  // ------------------------------------------------------------------ actions
  function toast(m) { const t = $('#ccToast'); if (t) { t.textContent = m; clearTimeout(toast._t); toast._t = setTimeout(() => { t.textContent = ''; }, 6000); } }
  async function onClick(e) {
    const b = e.target.closest('[data-cc]'); if (!b) return; const k = b.getAttribute('data-cc');
    try {
      if (k === 'tab') { S.tab = b.getAttribute('data-tab'); S.cache.incSig = null; S.cache.schedSig = null; renderTabs(); }
      else if (k === 'ack') { await jpost('/incident/ack', { id: b.getAttribute('data-id'), note: 'acked from the Live View' }); toast('acknowledged ' + b.getAttribute('data-id')); poll(true); }
      else if (k === 'wake') { const r = await jpost('/incident/wake', { id: b.getAttribute('data-id') }); toast('MiniMax woken for ' + (r.ids || []).join(', ')); setTimeout(() => poll(true), 3000); }
      else if (k === 'frame') { const id = b.getAttribute('data-id'); S.frame[id] = !S.frame[id]; S.cache.incSig = null; renderInc(); }
      else if (k === 'mode') { await jpost('/mmconfig', { mode: b.getAttribute('data-mode') }); toast('MiniMax mode → ' + b.getAttribute('data-mode')); poll(true); }
      else if (k === 'job-toggle') { await jpost('/scheduler', { job: b.getAttribute('data-job'), enabled: b.getAttribute('data-on') !== '1' }); poll(true); }
      else if (k === 'job-run') { await jpost('/scheduler', { job: b.getAttribute('data-job'), run: true }); toast('job started: ' + b.getAttribute('data-job')); setTimeout(() => poll(true), 2000); }
      else if (k === 'approve' || k === 'reject') { const r = await jpost(k === 'approve' ? '/mmapprove' : '/mmreject', { idx: +b.getAttribute('data-idx') }); toast(k + 'd' + (r.applied ? ' (applied)' : '')); S.cache.incSig = null; poll(true); }
    } catch (err) { toast('action failed: ' + err); }
  }
  async function onChange(e) {
    const b = e.target.closest('[data-cc="job-every"]'); if (!b) return;
    try { await jpost('/scheduler', { job: b.getAttribute('data-job'), every_s: +b.value }); toast('interval set'); poll(true); } catch (err) { toast('failed: ' + err); }
  }

  // ------------------------------------------------------------------ polling
  let busy = false, n = 0;
  async function poll(force) {
    if (busy && !force) return; busy = true; n++;
    try {
      const [p, i] = await Promise.all([jget('/botpulse'), jget('/incidents?n=40')]);
      S.pulse = p; S.inc = i; S.err = 0;
      if (window.LV && window.LV.setIncidents) window.LV.setIncidents((i && i.open) || []);
      if (force || n % 3 === 1) { try { S.audit = await jget('/audit'); } catch (e) { /* audit is optional */ } }
      if (force || n % 4 === 1) { try { S.acts = await jget('/mmactions?n=10'); } catch (e) { /* ignore */ } }
      if (force || n % 8 === 1) { try { S.queue = await jget('/engineer-queue'); } catch (e) { /* ignore */ } }
      if (!(window.LV && window.LV.active)) { try { const v = await jget('/view.json', 2500); S.view = v && v.vp ? v : null; } catch (e) { S.view = null; } }   // live.js gets the camera over its own socket
    } catch (e) { S.err++; S.errMsg = String(e && e.message || e); }
    busy = false; render();
  }
  function render() { renderAlert(); renderStrip(); renderTabs(); tickVolatile(); }

  function start() {
    if (!build()) { if (start.tries++ < 40) setTimeout(start, 500); return; }
    poll(true); setInterval(poll, 1000); setInterval(drawOverlay, 250); setInterval(() => { renderAlert(); renderStrip(); tickVolatile(); if (S.tab === 'sched') renderSched(); }, 1000);
  }
  start.tries = 0;
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', start); else start();
})();
