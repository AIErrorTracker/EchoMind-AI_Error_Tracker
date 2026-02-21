(function () {
  const VALID_MODES = new Set(['baseline', 'stress', 'edge']);
  const SCRIPT_CACHE = Object.create(null);

  window.PageMockDataRegistry = window.PageMockDataRegistry || {};

  function normalizeMode(mode) {
    if (!mode) return 'baseline';
    const normalized = String(mode).trim().toLowerCase();
    return VALID_MODES.has(normalized) ? normalized : 'baseline';
  }

  function getMockMode() {
    const params = new URLSearchParams(window.location.search || '');
    return normalizeMode(params.get('mock'));
  }

  function getMockSeed() {
    const params = new URLSearchParams(window.location.search || '');
    const parsed = Number(params.get('seed'));
    return Number.isFinite(parsed) ? parsed : 20260220;
  }

  function getRootPrefix() {
    return /\/pages\/[^/]+\//.test(window.location.pathname) ? '../../' : './';
  }

  function resolveMockUrl(relativePath) {
    const base = new URL(`${getRootPrefix()}mock-data/`, window.location.href);
    return new URL(relativePath, base).toString();
  }

  function loadScriptOnce(url) {
    if (SCRIPT_CACHE[url]) return SCRIPT_CACHE[url];

    SCRIPT_CACHE[url] = new Promise((resolve) => {
      const script = document.createElement('script');
      script.src = url;
      script.async = false;
      script.onload = () => resolve(true);
      script.onerror = () => {
        console.warn('[mock-runtime] failed to load script:', url);
        resolve(false);
      };
      document.body.appendChild(script);
    });

    return SCRIPT_CACHE[url];
  }

  async function ensureScenarioLoaded() {
    await loadScriptOnce(resolveMockUrl('scenarios.js'));
  }

  async function ensurePageMockLoaded(pageId) {
    await loadScriptOnce(resolveMockUrl(`pages/${pageId}.mock.js`));
  }

  function deepClone(value) {
    if (value == null) return value;
    if (Array.isArray(value)) return value.map(deepClone);
    if (typeof value === 'object') {
      const out = {};
      Object.keys(value).forEach((key) => {
        out[key] = deepClone(value[key]);
      });
      return out;
    }
    return value;
  }

  function deepMerge(base, override) {
    if (Array.isArray(base) && Array.isArray(override)) {
      return override.map(deepClone);
    }
    if (typeof base === 'object' && base && typeof override === 'object' && override) {
      const out = deepClone(base);
      Object.keys(override).forEach((key) => {
        out[key] = deepMerge(out[key], override[key]);
      });
      return out;
    }
    if (override === undefined) return deepClone(base);
    return deepClone(override);
  }

  function createRng(seed) {
    let t = seed >>> 0;
    return function rng() {
      t += 0x6D2B79F5;
      let r = Math.imul(t ^ (t >>> 15), 1 | t);
      r ^= r + Math.imul(r ^ (r >>> 7), 61 | r);
      return ((r ^ (r >>> 14)) >>> 0) / 4294967296;
    };
  }

  function isLikelyRoute(value) {
    return typeof value === 'string' && /\.html$/i.test(value);
  }

  function stretchText(text, mode) {
    const source = String(text || '');
    if (!source.trim()) return source;

    const suffix = mode === 'edge'
      ? ' —— 这是用于极端场景验证的超长描述文本SuperLongTokenWithoutBreak0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      : ' —— 这是用于压力测试的扩展描述';

    const repeat = mode === 'edge' ? 3 : 2;
    return Array.from({ length: repeat }).map(() => source).join(' / ') + suffix;
  }

  function stretchNumber(value, mode) {
    if (!Number.isFinite(value)) return value;
    if (mode === 'edge') return Number(`${Math.abs(Math.round(value))}889900`);
    return Number(`${Math.abs(Math.round(value))}7700`);
  }

  function applyStressTransform(input, mode, seed) {
    const normalized = normalizeMode(mode);
    if (normalized === 'baseline') return deepClone(input || {});

    const rng = createRng(seed || 20260220);

    function walk(value, keyHint) {
      if (Array.isArray(value)) {
        const transformed = value.map((item) => walk(item, keyHint));
        if (transformed.length > 0) {
          const minTarget = normalized === 'edge' ? Math.max(8, transformed.length * 3) : Math.max(5, transformed.length * 2);
          while (transformed.length < minTarget) {
            const index = Math.floor(rng() * transformed.length);
            transformed.push(deepClone(transformed[index]));
          }
        }
        return transformed;
      }

      if (value && typeof value === 'object') {
        const out = {};
        Object.keys(value).forEach((key) => {
          out[key] = walk(value[key], key);
        });
        return out;
      }

      if (typeof value === 'string') {
        if (isLikelyRoute(value)) return value;
        if (/^(\d{1,2}:\d{2}|[0-9/.-]+)$/.test(value)) return value;
        return stretchText(value, normalized);
      }

      if (typeof value === 'number') {
        const numericKeys = new Set(['score', 'target', 'predicted', 'value', 'rank', 'delta', 'count']);
        if (numericKeys.has(String(keyHint || '').toLowerCase())) {
          return stretchNumber(value, normalized);
        }
        return value;
      }

      return value;
    }

    return walk(input, '');
  }

  async function getPageMockData(pageId, mode) {
    const normalized = normalizeMode(mode || getMockMode());
    const seed = getMockSeed();

    await ensureScenarioLoaded();
    await ensurePageMockLoaded(pageId);

    const registry = window.PageMockDataRegistry || {};
    const pageMock = registry[pageId] || {};

    const baseline = deepClone(pageMock.baseline || {});
    const modeData = deepMerge(baseline, pageMock[normalized] || {});

    return applyStressTransform(modeData, normalized, seed);
  }

  function applyTextGuards(root) {
    if (!root) return;

    root.querySelectorAll('.rec-title, .card-title, .section-title').forEach((el) => {
      el.classList.add('u-ellipsis-1');
    });

    root.querySelectorAll('.list-desc, .card-subtitle, .chat-bubble').forEach((el) => {
      el.classList.add('u-clamp-2');
    });

    root.querySelectorAll('.list-label, .strategy-table td, .strategy-table th').forEach((el) => {
      el.classList.add('u-wrap-break');
    });

    root.querySelectorAll('.score-big, .stat-value').forEach((el) => {
      el.classList.add('u-num-tabular');
    });
  }

  function amplifyDomForMode(root, mode) {
    const normalized = normalizeMode(mode);
    if (!root || normalized === 'baseline') return;

    applyTextGuards(root);

    const listGroups = Array.from(root.querySelectorAll('.list-group, [data-list-region]'));
    listGroups.forEach((group) => {
      const itemSelector = group.classList.contains('list-group') ? ':scope > .list-item' : ':scope > *';
      const children = Array.from(group.querySelectorAll(itemSelector));
      if (!children.length) return;

      const target = normalized === 'edge' ? Math.max(children.length * 3, 9) : Math.max(children.length * 2, 5);
      while (group.querySelectorAll(itemSelector).length < target) {
        const clone = children[group.querySelectorAll(itemSelector).length % children.length].cloneNode(true);
        const label = clone.querySelector('.list-label, .card-title, .rec-title');
        if (label) {
          label.textContent = `${label.textContent || ''}（复制项）`;
        }
        group.appendChild(clone);
      }
    });

    root.querySelectorAll('.stat-value, .score-big').forEach((el) => {
      const text = (el.textContent || '').trim();
      if (/^\d+(\.\d+)?$/.test(text)) {
        el.textContent = normalized === 'edge' ? `${text}8899` : `${text}77`;
      }
    });

    root.querySelectorAll('.list-desc, .card-subtitle, .chat-bubble').forEach((el) => {
      const text = (el.textContent || '').trim();
      if (text && text.length < 80) {
        el.textContent = stretchText(text, normalized);
      }
    });
  }

  function applyMockStressToPage(pageId, mode) {
    const frame = document.querySelector('.phone-frame');
    if (!frame) return;

    amplifyDomForMode(frame, mode);

    frame.dataset.mockMode = normalizeMode(mode);
    frame.dataset.mockPage = pageId || '';
  }

  window.getMockMode = getMockMode;
  window.getMockSeed = getMockSeed;
  window.getPageMockData = getPageMockData;
  window.applyStressTransform = applyStressTransform;
  window.applyMockStressToPage = applyMockStressToPage;
})();
