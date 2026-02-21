(async function () {
  const pageId = 'upload-history';
  const mockMode = typeof getMockMode === 'function' ? getMockMode() : 'baseline';
  const mockSeed = typeof getMockSeed === 'function' ? getMockSeed() : 20260220;
  const pageData = typeof getPageMockData === 'function' ? await getPageMockData(pageId, mockMode) : {};

  const c_top_frame = await loadComponentTemplate('top-frame');
  const c_history_panel = await loadComponentTemplate('history-panel');
  const c_history_filter = await loadComponentTemplate('history-filter');
  const c_history_date_scroll = await loadComponentTemplate('history-date-scroll');
  const c_history_record_list = await loadComponentTemplate('history-record-list');

    const root = document.getElementById('page-root');
  if (!root) return;

  const shell = createPageShell({
    pageId,
    hasTabBar: false,
    topInsetMode: 'spacer'
  });

  root.innerHTML = shell.render({
    topHtml: c_top_frame,
    contentHtml: '<div class="page-content with-nav" style="padding-bottom:40px;"><div class="scroll-content" id="upload-history-scroll"></div></div>'
  });

  const scroll = document.getElementById('upload-history-scroll');
  if (scroll) {
    scroll.innerHTML = c_history_panel;
    const panel = scroll.querySelector('[data-component="history-panel"]') || scroll;
    panel.innerHTML = c_history_filter + c_history_date_scroll + c_history_record_list + '<div style="height:40px;"></div>';
  }

  initPageComponents(pageId, [
    'top-frame',
    'history-panel',
    'history-filter',
    'history-date-scroll',
    'history-record-list'
  ], {
    pageId,
    mode: mockMode,
    seed: mockSeed,
    pageData,
    viewport: { width: window.innerWidth, height: window.innerHeight }
  });

  if (typeof applyMockStressToPage === 'function') {
    applyMockStressToPage(pageId, mockMode);
  }
})();

