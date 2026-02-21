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

  window.ComponentModules = window.ComponentModules || {};
  window.ComponentModules['upload-history/history-date-scroll'] = {
    init: function init(ctx) {
      const root = ctx && ctx.root;
      const pageData = (ctx && ctx.pageData) || {};
      const data = (ctx && ctx.data) || {};
      if (!root) return;

      const groups = (data.groups && Array.isArray(data.groups) && data.groups.length)
        ? data.groups
        : ((pageData['history-record-list'] && Array.isArray(pageData['history-record-list'].groups))
            ? pageData['history-record-list'].groups
            : []);

      if (!groups.length) return;

      root.innerHTML = groups.map(function (group) {
        return '<div style="padding:12px 16px 4px; font-size:var(--font-sm); font-weight:600; color:var(--text-secondary);" class="u-ellipsis-1">'
          + escapeHtml(group.date || '')
          + '</div>';
      }).join('');
    }
  };
})();
