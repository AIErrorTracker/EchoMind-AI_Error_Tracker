(async function () {
  const pageId = 'question-detail';
  const mockMode = typeof getMockMode === 'function' ? getMockMode() : 'baseline';
  const mockSeed = typeof getMockSeed === 'function' ? getMockSeed() : 20260220;
  const pageData = typeof getPageMockData === 'function' ? await getPageMockData(pageId, mockMode) : {};

  const c_top_frame = await loadComponentTemplate('top-frame');

  const c_question_content = await loadComponentTemplate('question-content');

  const c_answer_result = await loadComponentTemplate('answer-result');

  const c_question_relations = await loadComponentTemplate('question-relations');

  const c_question_source = await loadComponentTemplate('question-source');

    const root = document.getElementById('page-root');
  if (!root) return;

  const shell = createPageShell({
    pageId,
    hasTabBar: false,
    topInsetMode: 'spacer'
  });

  root.innerHTML = shell.render({
    topHtml: c_top_frame,
    contentHtml: c_question_content + c_answer_result + c_question_relations + c_question_source
  });


  initPageComponents(pageId, [
    'top-frame',
    'question-content',
    'answer-result',
    'question-relations',
    'question-source'
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


