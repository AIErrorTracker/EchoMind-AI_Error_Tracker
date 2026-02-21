/* ============================================
   AI Learning Product v2.0 - App Logic
   ============================================ */

function navigateTo(target) {
  if (!target && target !== 0) return;

  if (typeof window.navigateToRoute === 'function') {
    window.navigateToRoute(target);
    return;
  }

  const value = String(target);
  const isSimpleHtml = /^[^\/]+\.html$/i.test(value);
  if (!isSimpleHtml) {
    window.location.href = value;
    return;
  }

  const slug = value.replace(/\.html$/i, '');
  const inPagesDir = /\/pages\/[^\/]+\/index\.html$/i.test(window.location.pathname);
  const path = inPagesDir ? `../${slug}/index.html` : `pages/${slug}/index.html`;
  window.location.href = path;
}

function setRouteTarget(el, routeInput) {
  if (!el) return;
  const routeId = (typeof window.normalizeRouteInput === 'function')
    ? window.normalizeRouteInput(routeInput)
    : routeInput;
  if (!routeId) return;
  el.setAttribute('data-route', routeId);
  if (el.hasAttribute('onclick')) {
    el.removeAttribute('onclick');
  }
}

/* Component runtime helpers */
const __componentAssets = {
  css: new Set(),
  js: new Set(),
  jsPromises: Object.create(null)
};

function loadStyleOnce(href) {
  if (!href || __componentAssets.css.has(href)) return;
  const link = document.createElement('link');
  link.rel = 'stylesheet';
  link.href = href;
  link.setAttribute('data-component-style', href);
  document.head.appendChild(link);
  __componentAssets.css.add(href);
}

function loadScriptOnce(src) {
  if (!src) return Promise.resolve();
  if (__componentAssets.jsPromises[src]) return __componentAssets.jsPromises[src];

  __componentAssets.jsPromises[src] = new Promise((resolve) => {
    const script = document.createElement('script');
    script.src = src;
    script.async = false;
    script.onload = () => {
      __componentAssets.js.add(src);
      resolve();
    };
    script.onerror = () => {
      console.warn('[component] script load failed:', src);
      resolve();
    };
    document.body.appendChild(script);
  });

  return __componentAssets.jsPromises[src];
}

async function loadComponentTemplate(componentName) {
  const base = `./components/${componentName}`;
  loadStyleOnce(`${base}/${componentName}.css`);
  await loadScriptOnce(`${base}/${componentName}.js`);

  try {
    const resp = await fetch(`${base}/${componentName}.html`, { cache: 'no-store' });
    if (!resp.ok) throw new Error(`HTTP ${resp.status}`);
    return await resp.text();
  } catch (err) {
    console.warn('[component] template load failed:', componentName, err);
    return '';
  }
}

function initPageComponents(pageId, componentNames, context) {
  if (!window.ComponentModules || !Array.isArray(componentNames)) return;
  const baseContext = context || {};
  const pageData = (baseContext.pageData && typeof baseContext.pageData === 'object')
    ? baseContext.pageData
    : {};

  componentNames.forEach((componentName) => {
    const key = `${pageId}/${componentName}`;
    const mod = window.ComponentModules[key];
    if (mod && typeof mod.init === 'function') {
      const root = document.querySelector(`[data-component="${componentName}"]`);
      mod.init({
        ...baseContext,
        pageId,
        componentName,
        route: typeof window.normalizeRouteInput === 'function' ? window.normalizeRouteInput(pageId) : null,
        root: root || null,
        viewport: baseContext.viewport || { width: window.innerWidth, height: window.innerHeight },
        data: pageData[componentName] || {}
      });
    }
  });

  if (typeof window.attachRouteDelegation === 'function') {
    window.attachRouteDelegation(document);
  }
}

function createPageShell(options) {
  const opts = {
    pageId: (options && options.pageId) || '',
    hasTabBar: !!(options && options.hasTabBar),
    activeTab: (options && options.activeTab) || '',
    topInsetMode: (options && options.topInsetMode) || 'spacer'
  };

  return {
    render: function render(parts) {
      const p = parts || {};
      const topInset = opts.topInsetMode === 'spacer'
        ? '<div class="top-spacer" data-region="top-spacer"></div>'
        : '';
      const topHtml = p.topHtml ? `<div class="top-region">${p.topHtml}</div>` : '';
      const contentHtml = p.contentHtml ? `<div class="content-region">${p.contentHtml}</div>` : '<div class="content-region"></div>';
      const bottomHtml = p.bottomHtml ? `<div class="bottom-region">${p.bottomHtml}</div>` : '';
      const tabBarHtml = opts.hasTabBar ? getTabBar(opts.activeTab) : '';

      return `<div class="phone-frame app-shell" data-page-id="${opts.pageId}">${topInset}${topHtml}${contentHtml}${bottomHtml}${tabBarHtml}</div>`;
    }
  };
}

// Tab bar HTML generator
function getTabBar(active) {
  const tabs = [
    { id: 'home', label: '主页', routeId: 'home', icon: '<svg viewBox="0 0 24 24"><path d="M3 9.5L12 3l9 6.5V20a1 1 0 01-1 1H4a1 1 0 01-1-1V9.5z"/><path d="M9 21V12h6v9"/></svg>' },
    { id: 'global', label: '全局', routeId: 'globalKnowledge', icon: '<svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M12 3c-2.5 3-4 6.5-4 9s1.5 6 4 9c2.5-3 4-6.5 4-9s-1.5-6-4-9z"/><path d="M3.5 9h17M3.5 15h17"/></svg>' },
    { id: 'memory', label: '记忆', routeId: 'memory', icon: '<svg viewBox="0 0 24 24"><rect x="3" y="3" width="18" height="18" rx="3"/><path d="M8 8h8M8 12h5"/></svg>' },
    { id: 'community', label: '社区', routeId: 'community', icon: '<svg viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg>' },
    { id: 'profile', label: '我的', routeId: 'profile', icon: '<svg viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>' }
  ];

  return `<nav class="tab-bar" data-region="tab-bar">${tabs.map((t) => `
    <a class="tab-item ${t.id === active ? 'active' : ''}" data-route="${t.routeId}" href="#" aria-label="${t.label}">
      <span class="tab-icon">${t.icon}</span>
      <span class="tab-label">${t.label}</span>
    </a>`).join('')}</nav>`;
}

// Backward compatible status bar helper (deprecated)
function getStatusBar() {
  return '';
}

// Level helpers
function getLevelText(level) {
  const texts = {
    0: '未接触',
    1: '卡住',
    2: '薄弱',
    3: '待巩固',
    4: '已掌握',
    5: '稳定'
  };
  return texts[level] || '未知';
}

function getLevelModelText(level) {
  const texts = {
    0: '未接触',
    1: '建模卡住',
    2: '列式卡住',
    3: '执行卡住',
    4: '做对过',
    5: '稳定掌握'
  };
  return texts[level] || '未知';
}

function getLevelKPText(level) {
  const texts = {
    0: '未接触',
    1: '记不住',
    2: '理解不深',
    3: '使用出错',
    4: '能正确使用',
    5: '稳定掌握'
  };
  return texts[level] || '未知';
}

function getLevelClass(level) {
  return 'l' + level;
}

// Toggle tree
function toggleTree(el) {
  el.classList.toggle('open');
  const content = el.nextElementSibling;
  if (content) {
    content.style.display = content.style.display === 'none' ? 'block' : 'none';
  }
}

// Show/hide modal
function showModal(id) {
  const el = document.getElementById(id);
  if (el) el.classList.add('show');
}

function hideModal(id) {
  const el = document.getElementById(id);
  if (el) el.classList.remove('show');
}

// Flip flashcard
function flipCard(el) {
  el.classList.toggle('flipped');
}

// Simple chart drawing (SVG polyline)
function drawTrendLine(svgId, data, color) {
  const svg = document.getElementById(svgId);
  if (!svg || !Array.isArray(data) || !data.length) return;
  const w = svg.clientWidth;
  const h = svg.clientHeight;
  const padding = 20;
  const maxVal = Math.max(...data);
  const minVal = Math.min(...data);
  const range = maxVal - minVal || 1;

  const points = data.map((v, i) => {
    const x = padding + (i / (data.length - 1)) * (w - padding * 2);
    const y = h - padding - ((v - minVal) / range) * (h - padding * 2);
    return `${x},${y}`;
  }).join(' ');

  const firstX = padding;
  const lastX = padding + (w - padding * 2);
  const areaPoints = `${firstX},${h - padding} ${points} ${lastX},${h - padding}`;

  svg.innerHTML = `
    <defs>
      <linearGradient id="grad-${svgId}" x1="0" y1="0" x2="0" y2="1">
        <stop offset="0%" stop-color="${color}" stop-opacity="0.15"/>
        <stop offset="100%" stop-color="${color}" stop-opacity="0"/>
      </linearGradient>
    </defs>
    <polygon points="${areaPoints}" fill="url(#grad-${svgId})"/>
    <polyline points="${points}" fill="none" stroke="${color}" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
    ${data.map((v, i) => {
      if (i === data.length - 1) {
        const x = padding + (i / (data.length - 1)) * (w - padding * 2);
        const y = h - padding - ((v - minVal) / range) * (h - padding * 2);
        return `<circle cx="${x}" cy="${y}" r="4" fill="${color}" stroke="#fff" stroke-width="2"/>`;
      }
      return '';
    }).join('')}
  `;
}

const DEMO = {
  scoreHistory: [55, 57, 59, 61, 60, 63]
};

// Page init
document.addEventListener('DOMContentLoaded', function () {
  if (typeof window.attachRouteDelegation === 'function') {
    window.attachRouteDelegation(document);
  }

  const frame = document.querySelector('.phone-frame');
  if (frame && frame.dataset.tabs && !frame.querySelector('.tab-bar')) {
    frame.insertAdjacentHTML('beforeend', getTabBar(frame.dataset.tabs));
  }

  const trendSvg = document.getElementById('trend-chart');
  if (trendSvg) {
    setTimeout(function () {
      drawTrendLine('trend-chart', DEMO.scoreHistory, '#007AFF');
    }, 100);
  }
});
