(async function () {
  const pageId = 'weekly-review';
  const mockMode = typeof getMockMode === 'function' ? getMockMode() : 'baseline';
  const mockSeed = typeof getMockSeed === 'function' ? getMockSeed() : 20260220;
  const pageData = typeof getPageMockData === 'function' ? await getPageMockData(pageId, mockMode) : {};

  const c_top_frame = await loadComponentTemplate('top-frame');

  const c_weekly_dashboard = await loadComponentTemplate('weekly-dashboard');

  const c_score_change = await loadComponentTemplate('score-change');

  const c_weekly_progress = await loadComponentTemplate('weekly-progress');

  const c_next_week_focus = await loadComponentTemplate('next-week-focus');

    const root = document.getElementById('page-root');
  if (!root) return;

  const shell = createPageShell({
    pageId,
    hasTabBar: false,
    topInsetMode: 'spacer'
  });

  root.innerHTML = shell.render({
    topHtml: c_top_frame,
    contentHtml: c_weekly_dashboard + c_score_change + c_weekly_progress + c_next_week_focus
  });


  initPageComponents(pageId, [
    'top-frame',
    'weekly-dashboard',
    'score-change',
    'weekly-progress',
    'next-week-focus'
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


