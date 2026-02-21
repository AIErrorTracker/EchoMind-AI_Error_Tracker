(async function () {
  const pageId = 'profile';
  const mockMode = typeof getMockMode === 'function' ? getMockMode() : 'baseline';
  const mockSeed = typeof getMockSeed === 'function' ? getMockSeed() : 20260220;
  const pageData = typeof getPageMockData === 'function' ? await getPageMockData(pageId, mockMode) : {};

  const c_top_frame = await loadComponentTemplate('top-frame');

  const c_user_info_card = await loadComponentTemplate('user-info-card');

  const c_target_score_card = await loadComponentTemplate('target-score-card');

  const c_three_row_navigation = await loadComponentTemplate('three-row-navigation');

  const c_two_row_navigation = await loadComponentTemplate('two-row-navigation');

  const c_learning_stats = await loadComponentTemplate('learning-stats');

    const root = document.getElementById('page-root');
  if (!root) return;

  const shell = createPageShell({
    pageId,
    hasTabBar: true,
    activeTab: 'profile',
    topInsetMode: 'spacer'
  });

  root.innerHTML = shell.render({
    topHtml: c_top_frame,
    contentHtml: c_user_info_card + c_target_score_card + c_three_row_navigation + c_two_row_navigation + c_learning_stats
  });


  initPageComponents(pageId, [
    'top-frame',
    'user-info-card',
    'target-score-card',
    'three-row-navigation',
    'two-row-navigation',
    'learning-stats'
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


