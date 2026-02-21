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

  function renderRow(row) {
    const routeId = row.route && typeof normalizeRouteInput === 'function' ? normalizeRouteInput(row.route) : null;
    const routeAttr = routeId ? ' data-route="' + escapeHtml(routeId) + '"' : '';
    const pointerStyle = routeId ? ' style="cursor:pointer;"' : '';
    const attitudeClass = row.attitudeClass || 'attitude-try';
    let deltaStyle = 'font-weight:700;';
    if (row.deltaClass === 'accent') deltaStyle += ' color:var(--accent);';
    if (row.deltaClass === 'gray') deltaStyle += ' color:var(--gray-500);';
    if (row.deltaClass === 'muted') deltaStyle += ' color:var(--gray-400);';

    return '<tr' + routeAttr + pointerStyle + '>'
      + '<td style="font-weight:600;" class="u-ellipsis-1">' + escapeHtml(row.title || '') + '</td>'
      + '<td><span class="' + escapeHtml(attitudeClass) + '">' + escapeHtml(row.attitude || '') + '</span></td>'
      + '<td style="font-size:var(--font-sm);" class="u-clamp-2">' + escapeHtml(row.action || '') + '</td>'
      + '<td style="' + deltaStyle + '" class="u-num-tabular">' + escapeHtml(row.delta || '--') + '</td>'
      + '</tr>';
  }

  window.ComponentModules = window.ComponentModules || {};
  window.ComponentModules['prediction-center/score-path-table'] = {
    init: function init(ctx) {
      const root = ctx && ctx.root;
      const data = (ctx && ctx.data) || {};
      if (!root) return;

      const rowsHost = root.querySelector('[data-role="rows"]');
      const rows = Array.isArray(data.rows) && data.rows.length ? data.rows : [];
      if (rowsHost && rows.length) {
        rowsHost.innerHTML = rows.map(renderRow).join('');
      }
    }
  };
})();
