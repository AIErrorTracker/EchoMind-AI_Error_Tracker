(function () {
  function toText(value, fallback) {
    if (value === null || value === undefined) return fallback || '';
    return String(value);
  }

  window.ComponentModules = window.ComponentModules || {};
  window.ComponentModules['prediction-center/score-card'] = {
    init: function init(ctx) {
      const root = ctx && ctx.root;
      const data = (ctx && ctx.data) || {};
      if (!root) return;

      const predictedEl = root.querySelector('[data-role="predicted"]');
      const totalEl = root.querySelector('[data-role="total"]');
      const targetEl = root.querySelector('[data-role="target"]');
      const gapEl = root.querySelector('[data-role="gap-text"]');

      if (predictedEl && data.predicted !== undefined) predictedEl.textContent = toText(data.predicted, '63');
      if (totalEl && data.total !== undefined) totalEl.textContent = '/ ' + toText(data.total, '100');
      if (targetEl && data.target !== undefined) targetEl.textContent = toText(data.target, '70');
      if (gapEl && data.gapText) gapEl.textContent = toText(data.gapText, '');
    }
  };
})();
