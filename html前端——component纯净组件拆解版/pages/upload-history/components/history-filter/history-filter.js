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
  window.ComponentModules['upload-history/history-filter'] = {
    init: function init(ctx) {
      const root = ctx && ctx.root;
      const data = (ctx && ctx.data) || {};
      if (!root) return;

      const chipsHost = root.querySelector('[data-role="chips"]');
      const chips = Array.isArray(data.chips) && data.chips.length
        ? data.chips
        : ['全部', '待诊断', '已完成', '作业', '考试'];
      const active = toText(data.active, chips[0]);

      if (!chipsHost) return;
      chipsHost.innerHTML = chips.map(function (chip) {
        const cls = chip === active ? 'filter-chip active' : 'filter-chip';
        return '<button class="' + cls + '">' + escapeHtml(chip) + '</button>';
      }).join('');
    }
  };
})();
