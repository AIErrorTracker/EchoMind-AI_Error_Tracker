(async function () {
  const pageId = 'community';
  const mockMode = typeof getMockMode === 'function' ? getMockMode() : 'baseline';
  const mockSeed = typeof getMockSeed === 'function' ? getMockSeed() : 20260220;
  const pageData = typeof getPageMockData === 'function' ? await getPageMockData(pageId, mockMode) : {};

  const c_top_frame_and_tabs = await loadComponentTemplate('top-frame-and-tabs');
  const c_board_my_requests = await loadComponentTemplate('board-my-requests');
  const c_board_feature_boost = await loadComponentTemplate('board-feature-boost');
  const c_board_feedback = await loadComponentTemplate('board-feedback');

  const root = document.getElementById('page-root');
  if (!root) return;
  const shell = createPageShell({
    pageId,
    hasTabBar: true,
    activeTab: 'community',
    topInsetMode: 'spacer'
  });
  root.innerHTML = shell.render({
    topHtml: c_top_frame_and_tabs,
    contentHtml: '<div class="page-content"><div class="scroll-content" id="community-scroll-content"></div></div>'
  });

  const scroll = document.getElementById('community-scroll-content');
  if (scroll) {
    scroll.innerHTML = c_board_my_requests + c_board_feature_boost + c_board_feedback;
  }

  // Expose for inline onclick handlers in tab buttons.
  window.switchCommTab = function (idx) {
    for (let i = 0; i < 3; i++) {
      document.getElementById('comm-tab-' + i).style.display = i === idx ? 'block' : 'none';
      document.getElementById('st' + (i + 1)).classList.toggle('active', i === idx);
    }
  };


  initPageComponents(pageId, [
    'top-frame-and-tabs',
    'board-my-requests',
    'board-feature-boost',
    'board-feedback'
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

