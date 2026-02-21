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
  window.ComponentModules['knowledge-learning/learning-dialogue'] = {
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
    }
  };
})();
