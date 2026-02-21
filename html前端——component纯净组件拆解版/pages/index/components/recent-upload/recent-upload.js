(function () {
  function toText(value, fallback) {
    if (value === null || value === undefined) return fallback || '';
    return String(value);
  }

  window.ComponentModules = window.ComponentModules || {};
  window.ComponentModules['index/recent-upload'] = {
    init: function init(ctx) {
      const root = ctx && ctx.root;
      const data = (ctx && ctx.data) || {};
      if (!root) return;

      const titleEl = root.querySelector('[data-role="title"]');
      const subtitleEl = root.querySelector('[data-role="subtitle"]');
      const cardEl = root.querySelector('[data-role="recent-card"]');

      if (titleEl && data.title) titleEl.textContent = toText(data.title, '最近上传');
      if (subtitleEl && data.subtitle) subtitleEl.textContent = toText(data.subtitle, '');
      if (cardEl && data.route) {
        setRouteTarget(cardEl, toText(data.route, 'upload-history.html'));
      }
    }
  };
})();
