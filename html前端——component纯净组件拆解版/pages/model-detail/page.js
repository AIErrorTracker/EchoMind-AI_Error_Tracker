(async function () {
  const pageId = 'model-detail';
  const mockMode = typeof getMockMode === 'function' ? getMockMode() : 'baseline';
  const mockSeed = typeof getMockSeed === 'function' ? getMockSeed() : 20260220;
  const pageData = typeof getPageMockData === 'function' ? await getPageMockData(pageId, mockMode) : {};

  const c_top_frame = await loadComponentTemplate('top-frame');

  const c_mastery_dashboard = await loadComponentTemplate('mastery-dashboard');

  const c_prerequisite_knowledge_list = await loadComponentTemplate('prerequisite-knowledge-list');

  const c_related_question_list = await loadComponentTemplate('related-question-list');

  const c_training_record_list = await loadComponentTemplate('training-record-list');

    const root = document.getElementById('page-root');
  if (!root) return;

  const shell = createPageShell({
    pageId,
    hasTabBar: false,
    topInsetMode: 'spacer'
  });

  root.innerHTML = shell.render({
    topHtml: c_top_frame,
    contentHtml: c_mastery_dashboard + c_prerequisite_knowledge_list + c_related_question_list + c_training_record_list
  });


  initPageComponents(pageId, [
    'top-frame',
    'mastery-dashboard',
    'prerequisite-knowledge-list',
    'related-question-list',
    'training-record-list'
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


