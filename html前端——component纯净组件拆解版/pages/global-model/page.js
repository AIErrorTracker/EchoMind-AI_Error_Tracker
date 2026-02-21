(async function () {
  const pageId = 'global-model';
  const mockMode = typeof getMockMode === 'function' ? getMockMode() : 'baseline';
  const mockSeed = typeof getMockSeed === 'function' ? getMockSeed() : 20260220;
  const pageData = typeof getPageMockData === 'function' ? await getPageMockData(pageId, mockMode) : {};

  const c_top_frame = await loadComponentTemplate('top-frame');

  const c_model_tree = await loadComponentTemplate('model-tree');

    const root = document.getElementById('page-root');
  if (!root) return;

  const shell = createPageShell({
    pageId,
    hasTabBar: true,
    activeTab: 'global',
    topInsetMode: 'spacer'
  });

  root.innerHTML = shell.render({
    topHtml: c_top_frame,
    contentHtml: c_model_tree
  });


  initPageComponents(pageId, [
    'top-frame',
    'model-tree'
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


