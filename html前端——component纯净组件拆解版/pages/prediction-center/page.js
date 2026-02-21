(async function () {
  const pageId = 'prediction-center';
  const mockMode = typeof getMockMode === 'function' ? getMockMode() : 'baseline';
  const mockSeed = typeof getMockSeed === 'function' ? getMockSeed() : 20260220;
  const pageData = typeof getPageMockData === 'function' ? await getPageMockData(pageId, mockMode) : {};

  const c_top_frame = await loadComponentTemplate('top-frame');
  const c_score_card = await loadComponentTemplate('score-card');
  const c_trend_card = await loadComponentTemplate('trend-card');
  const c_score_path_table = await loadComponentTemplate('score-path-table');
  const c_priority_model_list = await loadComponentTemplate('priority-model-list');

    const root = document.getElementById('page-root');
  if (!root) return;

  const shell = createPageShell({
    pageId,
    hasTabBar: false,
    topInsetMode: 'spacer'
  });

  root.innerHTML = shell.render({
    topHtml: c_top_frame,
    contentHtml: '<div class="page-content with-nav" style="padding-bottom:40px;"><div class="scroll-content" id="prediction-scroll-content"></div></div>'
  });

  const scroll = document.getElementById('prediction-scroll-content');
  if (scroll) {
    scroll.innerHTML = c_score_card + c_trend_card + c_score_path_table + c_priority_model_list;
  }

  initPageComponents(pageId, [
    'top-frame',
    'score-card',
    'trend-card',
    'score-path-table',
    'priority-model-list'
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

