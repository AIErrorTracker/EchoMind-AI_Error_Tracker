(async function () {
  const pageId = 'question-aggregate';
  const mockMode = typeof getMockMode === 'function' ? getMockMode() : 'baseline';
  const mockSeed = typeof getMockSeed === 'function' ? getMockSeed() : 20260220;
  const pageData = typeof getPageMockData === 'function' ? await getPageMockData(pageId, mockMode) : {};

  const c_top_frame = await loadComponentTemplate('top-frame');

  const c_single_question_dashboard = await loadComponentTemplate('single-question-dashboard');

  const c_exam_analysis = await loadComponentTemplate('exam-analysis');

  const c_question_history_list = await loadComponentTemplate('question-history-list');

    const root = document.getElementById('page-root');
  if (!root) return;

  const shell = createPageShell({
    pageId,
    hasTabBar: false,
    topInsetMode: 'spacer'
  });

  root.innerHTML = shell.render({
    topHtml: c_top_frame,
    contentHtml: c_single_question_dashboard + c_exam_analysis + c_question_history_list
  });


  initPageComponents(pageId, [
    'top-frame',
    'single-question-dashboard',
    'exam-analysis',
    'question-history-list'
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


