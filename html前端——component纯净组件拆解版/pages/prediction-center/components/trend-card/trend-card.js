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
  window.ComponentModules['prediction-center/trend-card'] = {
    init: function init(ctx) {
      const root = ctx && ctx.root;
      const data = (ctx && ctx.data) || {};
      if (!root) return;

      const labelsHost = root.querySelector('[data-role="labels"]');
      const labels = Array.isArray(data.labels) && data.labels.length
        ? data.labels
        : ['1月20日', '1月27日', '2月3日', '2月10日'];

      if (labelsHost) {
        labelsHost.innerHTML = labels.map(function (label) {
          return '<span class="u-ellipsis-1">' + escapeHtml(label) + '</span>';
        }).join('');
      }

      const trend = Array.isArray(data.trend) && data.trend.length ? data.trend : [55, 57, 59, 61, 60, 63];
      if (typeof drawTrendLine === 'function') {
        setTimeout(function () {
          drawTrendLine('trend-chart', trend, '#007AFF');
        }, 60);
      }
    }
  };
})();
