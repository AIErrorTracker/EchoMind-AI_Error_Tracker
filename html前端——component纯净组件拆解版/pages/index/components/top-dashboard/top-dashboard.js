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

  function renderStats(root, stats) {
    const row = root.querySelector('[data-role="stats-row"]');
    if (!row || !Array.isArray(stats) || !stats.length) return;

    row.innerHTML = stats.map(function (item) {
      return '<div class="stat-card">'
        + '<div class="stat-value u-num-tabular">' + escapeHtml(item.value) + '</div>'
        + '<div class="stat-label u-ellipsis-1">' + escapeHtml(item.label) + '</div>'
        + '</div>';
    }).join('');
  }

  window.ComponentModules = window.ComponentModules || {};
  window.ComponentModules['index/top-dashboard'] = {
    init: function init(ctx) {
      const root = ctx && ctx.root;
      const data = (ctx && ctx.data) || {};
      if (!root) return;

      renderStats(root, data.stats);

      const prediction = data.prediction || {};
      const scoreEl = root.querySelector('[data-role="prediction-score"]');
      const totalEl = root.querySelector('[data-role="prediction-total"]');
      const hintEl = root.querySelector('[data-role="prediction-hint"]');

      if (scoreEl && prediction.score !== undefined) scoreEl.textContent = toText(prediction.score, '63');
      if (totalEl && prediction.total !== undefined) totalEl.textContent = '/ ' + toText(prediction.total, '100');
      if (hintEl && prediction.hint) hintEl.textContent = toText(prediction.hint, '');

      const quickStart = data.quickStart || {};
      const quickBtn = root.querySelector('[data-role="quick-start-btn"]');
      const quickTitle = root.querySelector('[data-role="quick-start-title"]');
      const quickSubtitle = root.querySelector('[data-role="quick-start-subtitle"]');

      if (quickTitle && quickStart.title) quickTitle.textContent = toText(quickStart.title, '');
      if (quickSubtitle && quickStart.subtitle) quickSubtitle.textContent = '-- ' + toText(quickStart.subtitle, '');
      if (quickBtn && quickStart.route) {
        setRouteTarget(quickBtn, toText(quickStart.route, 'model-training.html'));
      }

      const trend = Array.isArray(prediction.trend) && prediction.trend.length ? prediction.trend : [55, 57, 59, 61, 60, 63];
      if (typeof drawTrendLine === 'function') {
        setTimeout(function () {
          drawTrendLine('mini-trend', trend, '#007AFF');
        }, 60);
      }
    }
  };
})();
