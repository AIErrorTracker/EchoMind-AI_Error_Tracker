(async function () {
  const pageId = 'global-exam';
  const mockMode = typeof getMockMode === 'function' ? getMockMode() : 'baseline';
  const mockSeed = typeof getMockSeed === 'function' ? getMockSeed() : 20260220;
  const pageData = typeof getPageMockData === 'function' ? await getPageMockData(pageId, mockMode) : {};

  const c_top_frame = await loadComponentTemplate('top-frame');

  const c_exam_heatmap = await loadComponentTemplate('exam-heatmap');

  const c_question_type_browser = await loadComponentTemplate('question-type-browser');

  const c_recent_exams = await loadComponentTemplate('recent-exams');

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
    contentHtml: c_exam_heatmap + c_question_type_browser + c_recent_exams
  });


  initPageComponents(pageId, [
    'top-frame',
    'exam-heatmap',
    'question-type-browser',
    'recent-exams'
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


