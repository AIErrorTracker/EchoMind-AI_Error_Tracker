(async function () {
  const pageId = 'index';
  const mockMode = typeof getMockMode === 'function' ? getMockMode() : 'baseline';
  const mockSeed = typeof getMockSeed === 'function' ? getMockSeed() : 20260220;
  const pageData = typeof getPageMockData === 'function' ? await getPageMockData(pageId, mockMode) : {};

  const c_top_frame = await loadComponentTemplate('top-frame');
  const c_top_dashboard = await loadComponentTemplate('top-dashboard');
  const c_recommendation_list = await loadComponentTemplate('recommendation-list');
  const c_recent_upload = await loadComponentTemplate('recent-upload');
  const c_action_overlay = await loadComponentTemplate('action-overlay');

    const root = document.getElementById('page-root');
  if (!root) return;

  const shell = createPageShell({
    pageId,
    hasTabBar: true,
    activeTab: 'home',
    topInsetMode: 'spacer'
  });

  root.innerHTML = shell.render({
    topHtml: c_top_frame,
    contentHtml: '<div class="page-content"><div class="scroll-content" id="index-scroll-content"></div></div>',
    bottomHtml: c_action_overlay
  });

  const scroll = document.getElementById('index-scroll-content');
  if (scroll) {
    scroll.innerHTML = c_top_dashboard + c_recommendation_list + c_recent_upload;
  }

  initPageComponents(pageId, [
    'top-frame',
    'top-dashboard',
    'recommendation-list',
    'recent-upload',
    'action-overlay'
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


