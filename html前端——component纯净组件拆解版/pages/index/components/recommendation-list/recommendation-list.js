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
    const iconTone = ['blue', 'gray', 'dark'].indexOf(item.iconTone) >= 0 ? item.iconTone : 'gray';
    const tags = Array.isArray(item.tags) ? item.tags : [];
    const route = item.route ? toText(item.route, 'index.html') : 'index.html';
    const routeId = typeof normalizeRouteInput === 'function' ? normalizeRouteInput(route) : route;

    return '<div class="rec-card" data-route="' + escapeHtml(routeId || 'home') + '">'
      + '<div class="rec-icon ' + iconTone + '">' + escapeHtml(item.icon || '?') + '</div>'
      + '<div class="rec-body">'
      + '<div class="rec-title u-ellipsis-1">' + escapeHtml(item.title || '') + '</div>'
      + '<div class="rec-meta">'
      + tags.map(function (tag) { return '<span class="rec-tag u-ellipsis-1">' + escapeHtml(tag) + '</span>'; }).join('')
      + '</div></div><span class="card-arrow"></span></div>';
  }

  window.ComponentModules = window.ComponentModules || {};
  window.ComponentModules['index/recommendation-list'] = {
    init: function init(ctx) {
      const root = ctx && ctx.root;
      const data = (ctx && ctx.data) || {};
      if (!root) return;

      const title = root.querySelector('[data-role="title"]');
      if (title && data.title) title.textContent = toText(data.title, '推荐学习');

      const container = root.querySelector('[data-role="recommendation-items"]');
      if (!container) return;

      const items = Array.isArray(data.items) && data.items.length
        ? data.items
        : [
            { icon: '!', iconTone: 'dark', title: '待诊断: 2025天津模拟 第5题', tags: ['待诊断', '上传于今日'], route: 'ai-diagnosis.html' }
          ];

      container.innerHTML = items.map(renderItem).join('');
    }
  };
})();
