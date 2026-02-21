(function () {
  function toText(value, fallback) {
    if (value === null || value === undefined) return fallback || '';
    return String(value);
  }

  function escapeHtml(value) {
    return toText(value, '').replace(/[&<>"']/g, function (ch) {
      return ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[ch];
    });
  }

  function renderItem(item) {
    const route = item.route ? toText(item.route, 'model-detail.html') : 'model-detail.html';
    const routeId = typeof normalizeRouteInput === 'function' ? normalizeRouteInput(route) : route;
    const rank = toText(item.rank, '1');

    return '<div class="list-item" data-route="' + escapeHtml(routeId || 'modelDetail') + '">'
      + '<div style="width:24px; text-align:center; margin-right:10px; font-weight:800; color:var(--accent); font-size:var(--font-lg);" class="u-num-tabular">' + escapeHtml(rank) + '</div>'
      + '<div class="list-body">'
      + '<div class="list-label u-wrap-break">' + escapeHtml(item.name || '') + '</div>'
      + '<div class="list-desc u-clamp-2">' + escapeHtml(item.desc || '') + '</div>'
      + '</div><span class="list-chevron"></span></div>';
  }

  window.ComponentModules = window.ComponentModules || {};
  window.ComponentModules['prediction-center/priority-model-list'] = {
    init: function init(ctx) {
      const root = ctx && ctx.root;
      const data = (ctx && ctx.data) || {};
      if (!root) return;

      const host = root.querySelector('[data-role="priority-items"]');
      const items = Array.isArray(data.items) && data.items.length ? data.items : [];
      if (host && items.length) {
        host.innerHTML = items.map(renderItem).join('');
      }
    }
  };
})();
