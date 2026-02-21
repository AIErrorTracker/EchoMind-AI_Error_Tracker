(async function () {
  const pageId = 'knowledge-detail';
  const mockMode = typeof getMockMode === 'function' ? getMockMode() : 'baseline';
  const mockSeed = typeof getMockSeed === 'function' ? getMockSeed() : 20260220;
  const pageData = typeof getPageMockData === 'function' ? await getPageMockData(pageId, mockMode) : {};

  const c_top_frame = await loadComponentTemplate('top-frame');

  const c_mastery_dashboard = await loadComponentTemplate('mastery-dashboard');

  const c_concept_test_records = await loadComponentTemplate('concept-test-records');

  const c_related_models = await loadComponentTemplate('related-models');

    const root = document.getElementById('page-root');
  if (!root) return;

  const shell = createPageShell({
    pageId,
    hasTabBar: false,
    topInsetMode: 'spacer'
  });

  root.innerHTML = shell.render({
    topHtml: c_top_frame,
    contentHtml: c_mastery_dashboard + c_concept_test_records + c_related_models
  });


  initPageComponents(pageId, [
    'top-frame',
    'mastery-dashboard',
    'concept-test-records',
    'related-models'
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


