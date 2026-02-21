(async function () {
  const pageId = 'memory';
  const mockMode = typeof getMockMode === 'function' ? getMockMode() : 'baseline';
  const mockSeed = typeof getMockSeed === 'function' ? getMockSeed() : 20260220;
  const pageData = typeof getPageMockData === 'function' ? await getPageMockData(pageId, mockMode) : {};

  const c_top_frame = await loadComponentTemplate('top-frame');

  const c_review_dashboard = await loadComponentTemplate('review-dashboard');

  const c_card_category_list = await loadComponentTemplate('card-category-list');

    const root = document.getElementById('page-root');
  if (!root) return;

  const shell = createPageShell({
    pageId,
    hasTabBar: true,
    activeTab: 'memory',
    topInsetMode: 'spacer'
  });

  root.innerHTML = shell.render({
    topHtml: c_top_frame,
    contentHtml: c_review_dashboard + c_card_category_list
  });


  initPageComponents(pageId, [
    'top-frame',
    'review-dashboard',
    'card-category-list'
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


