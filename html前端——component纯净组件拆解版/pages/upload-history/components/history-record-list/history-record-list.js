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
    const routeId = item.route && typeof normalizeRouteInput === 'function' ? normalizeRouteInput(item.route) : null;
    const route = routeId ? ' data-route="' + escapeHtml(routeId) + '"' : '';
    const statusClass = item.statusClass || 'tag tag-gray';
    const typeTone = item.type === 'EX' ? 'var(--accent)' : (item.type === 'QK' ? 'var(--gray-600)' : 'var(--gray-900)');

    return '<div class="list-item"' + route + '>'
      + '<div class="list-icon" style="background:' + typeTone + '; color:#fff; font-size:10px;">' + escapeHtml(item.type || 'HW') + '</div>'
      + '<div class="list-body">'
      + '<div class="list-label u-wrap-break">' + escapeHtml(item.label || '') + '</div>'
      + '<div class="list-desc u-clamp-2">' + escapeHtml(item.desc || '') + '</div>'
      + '</div>'
      + '<div style="display:flex; flex-direction:column; align-items:flex-end; gap:2px;">'
      + '<span style="font-size:var(--font-xs); color:var(--text-secondary);">' + escapeHtml(item.time || '--:--') + '</span>'
      + '<span class="' + escapeHtml(statusClass) + '" style="font-size:9px;">' + escapeHtml(item.status || '') + '</span>'
      + '</div>'
      + '</div>';
  }

  window.ComponentModules = window.ComponentModules || {};
  window.ComponentModules['upload-history/history-record-list'] = {
    init: function init(ctx) {
      const root = ctx && ctx.root;
      const data = (ctx && ctx.data) || {};
      if (!root) return;

      const groups = Array.isArray(data.groups) && data.groups.length ? data.groups : [];
      if (!groups.length) return;

      root.innerHTML = groups.map(function (group) {
        const items = Array.isArray(group.items) ? group.items : [];
        return '<div class="list-group" data-list-region="history-group-' + escapeHtml(group.date || 'default') + '">'
          + items.map(renderItem).join('')
          + '</div>';
      }).join('');
    }
  };
})();
