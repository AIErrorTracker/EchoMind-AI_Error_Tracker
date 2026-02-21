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

  function renderBubble(item) {
    const role = item.role === 'user' ? 'user' : 'ai';
    return '<div class="chat-bubble ' + role + '">' + escapeHtml(item.text || '') + '</div>';
  }

  window.ComponentModules = window.ComponentModules || {};
  window.ComponentModules['model-training/training-dialogue'] = {
    init: function init(ctx) {
      const root = ctx && ctx.root;
      const data = (ctx && ctx.data) || {};
      if (!root) return;

      const messages = Array.isArray(data.messages) ? data.messages : [];
      const chatHost = root.querySelector('[data-role="chat-container"]');
      if (chatHost && messages.length) {
        chatHost.innerHTML = messages.map(renderBubble).join('');
      }

      const options = Array.isArray(data.options) ? data.options : [];
      const optionHost = root.querySelector('[data-role="quick-options"]');
      if (optionHost && options.length) {
        optionHost.innerHTML = options.map(function (text) {
          return '<button class="btn btn-sm btn-outline" style="flex:none;">' + escapeHtml(text) + '</button>';
        }).join('');
      }

      if (data.summary && typeof data.summary === 'object') {
        const titleEl = root.querySelector('[data-role="summary-title"]');
        const tagEl = root.querySelector('[data-role="summary-tag"]');
        const descEl = root.querySelector('[data-role="summary-desc"]');
        if (titleEl && data.summary.title) titleEl.textContent = toText(data.summary.title, '');
        if (tagEl && data.summary.tag) tagEl.textContent = toText(data.summary.tag, '');
        if (descEl && data.summary.desc) descEl.textContent = toText(data.summary.desc, '');
      }
    }
  };
})();
