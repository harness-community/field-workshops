// Shared by every flavor. It loads showcase.yaml (via /api/config), then polls /version every
// second. Mid-rollout, old and new pods take turns answering, so the strip shows each pod's
// version, announces a new release once, and announces a rollback when the old version is back.
const $ = (id) => document.getElementById(id);
const ENV_COLORS = { dev: "#f5b83d", qa: "#5aa9ff", staging: "#b18cff", prod: "#3ddc84" };

export const RELEASE_STRIP = `
<section class="release">
  <div class="card"><h2>Running release</h2>
    <div class="version mono" id="version">&ndash;</div>
    <div class="facts"><span>Build<b class="mono" id="build">&ndash;</b></span>
      <span>Environment<b class="mono" id="env">&ndash;</b></span>
      <span>Status<b><span class="status" id="status"><span class="dot"></span><span id="status-text">Connecting</span></span></b></span></div>
  </div>
  <div class="card"><h2>Pods answering</h2><ul class="pods mono" id="pods"></ul></div>
  <div class="card"><h2>Release history (this tab)</h2><ul class="log" id="log"></ul></div>
</section>
<footer><span>Built, tested, and deployed by the <a href="https://www.harness.io">Harness</a> Software Delivery Agent</span>
  <span class="mono"><a href="/health">/health</a> &middot; <a href="/version">/version</a></span></footer>`;

export async function loadConfig() {
  const cfg = await (await fetch("/api/config", { cache: "no-store" })).json();
  document.title = cfg.name;
  document.documentElement.style.setProperty("--accent", cfg.accent);
  return cfg;
}

// A stable color per pod name (FNV-1a), so a rolling update visibly swaps the pods
function podColor(name) {
  let h = 2166136261;
  for (const c of name) h = Math.imul(h ^ c.charCodeAt(0), 16777619) >>> 0;
  return `hsl(${h % 360} 70% 60%)`;
}
const clock = () => new Date().toLocaleTimeString([], { hour: "2-digit", minute: "2-digit", second: "2-digit" });
function logEvent(text) {
  const li = document.createElement("li");
  li.innerHTML = `<time class="mono">${clock()}</time><span></span>`;
  li.querySelector("span").textContent = text;
  $("log").prepend(li);
  while ($("log").children.length > 6) $("log").lastChild.remove();
}
function toast(text) {
  $("toast").textContent = text;
  $("toast").classList.add("show");
  setTimeout(() => $("toast").classList.remove("show"), 6000);
}
const newer = (a, b) => String(a).localeCompare(String(b), undefined, { numeric: true }) > 0;

export function startReleaseStrip(onRelease) {
  const pods = new Map(); // pod name -> { version, healthy, seen }
  let current = null;
  let down = false;

  function announce(text, log, version) {
    toast(text);
    logEvent(log);
    current = version;
    $("version").classList.add("bump");
    setTimeout(() => $("version").classList.remove("bump"), 400);
    if (onRelease) onRelease(version);
  }

  async function poll() {
    try {
      const v = await (await fetch("/version", { cache: "no-store" })).json();
      const env = (v.environment || "local").toLowerCase();
      if (down) { logEvent("Connection restored"); down = false; }
      $("status").classList.remove("down");
      $("status-text").textContent = "Live";
      document.documentElement.style.setProperty("--env", ENV_COLORS[env] || "#9aa4b2");
      const now = Date.now();
      pods.set(v.hostname, { version: v.version, healthy: v.healthy, seen: now });

      if (current === null) {
        logEvent(`Connected: version ${v.version} in ${env}`);
        current = v.version;
      } else if (newer(v.version, current)) {
        announce(`New release answering: ${current} → ${v.version}`, `Version ${v.version} is live (was ${current})`, v.version);
      } else if (v.version !== current &&
                 [...pods.values()].every((p) => p.version === v.version || now - p.seen > 5000)) {
        announce(`Rolled back: ${current} → ${v.version}`, `Rolled back to version ${v.version} (was ${current})`, v.version);
      }
      if (v.version === current) {
        $("build").textContent = v.build || "local";
        $("env").textContent = env;
        const ribbon = $("ribbon");
        ribbon.classList.toggle("bad", v.healthy === false);
        ribbon.firstChild.textContent = v.healthy === false ? `${env.toUpperCase()} · UNHEALTHY RELEASE` : env.toUpperCase();
        $("ribbon-sub").textContent = `v${v.version} · ${v.build || "local build"}`;
      }
      $("version").textContent = current;
      renderPods(pods, v.hostname, current);
    } catch (e) {
      if (!down) { logEvent("Connection lost: the app is restarting or redeploying"); down = true; }
      $("status").classList.add("down");
      $("status-text").textContent = "Reconnecting";
    }
  }
  poll();
  setInterval(poll, 1000);
}

function renderPods(pods, hit, current) {
  const now = Date.now();
  for (const [name, p] of pods) if (now - p.seen > 20000) pods.delete(name);
  const ul = $("pods");
  ul.innerHTML = "";
  for (const [name, p] of [...pods].sort()) {
    const li = document.createElement("li");
    if (name === hit) li.className = "hit";
    if (p.version !== current) li.classList.add("old");
    if (p.healthy === false) li.classList.add("sick");
    li.innerHTML = `<span class="chip"></span><span class="name"></span><span class="ver"></span>`;
    li.querySelector(".chip").style.background = podColor(name);
    li.querySelector(".name").textContent = name;
    li.querySelector(".ver").textContent = p.healthy === false ? `${p.version} ✕` : p.version;
    ul.appendChild(li);
  }
}
