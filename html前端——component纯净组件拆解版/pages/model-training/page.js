(async function () {
  const pageId = 'model-training';
  const mockMode = typeof getMockMode === 'function' ? getMockMode() : 'baseline';
  const mockSeed = typeof getMockSeed === 'function' ? getMockSeed() : 20260220;
  const pageData = typeof getPageMockData === 'function' ? await getPageMockData(pageId, mockMode) : {};

  const c_top_frame = await loadComponentTemplate('top-frame');
  const c_step_stage_nav = await loadComponentTemplate('step-stage-nav');
  const c_training_dialogue = await loadComponentTemplate('training-dialogue');
  const c_action_overlay = await loadComponentTemplate('action-overlay');

  const stepCards = {
    1: await loadComponentTemplate('step-1-identification-training'),
    2: await loadComponentTemplate('step-2-decision-training'),
    3: await loadComponentTemplate('step-3-equation-training'),
    4: await loadComponentTemplate('step-4-trap-analysis'),
    5: await loadComponentTemplate('step-5-complete-solve'),
    6: await loadComponentTemplate('step-6-variation-training'),
  };

  function escapeHtml(value) {
    return String(value === undefined || value === null ? '' : value).replace(/[&<>"']/g, function (ch) {
      return ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[ch];
    });
  }

  function buildStepCard(step, index, total) {
    const title = (step && step.title) || '';
    const subTitle = (step && step.subTitle) || ('Step ' + index + ' / ' + total + ' -- ' + title);
    const note = (step && step.note) || '本步骤只切换顶部 step 模块，下面对话区保持不变';

    return '<div class="card" style="margin-top:4px;" data-component="step-' + index + '" data-region="step-' + index + '">'
      + '<div style="font-size:var(--font-xs); color:var(--accent); font-weight:600; text-transform:uppercase; letter-spacing:0.5px; margin-bottom:8px;" class="u-ellipsis-1">'
      + escapeHtml(subTitle)
      + '</div>'
      + '<div style="font-size:var(--font-lg); font-weight:700; margin-bottom:8px;" class="u-ellipsis-1">' + escapeHtml(title) + '</div>'
      + '<div style="font-size:var(--font-sm); color:var(--text-secondary); line-height:1.5;" class="u-clamp-2">' + escapeHtml(note) + '</div>'
      + '</div>';
  }

  const configuredSteps = Array.isArray(pageData.steps) && pageData.steps.length ? pageData.steps : null;
  if (configuredSteps) {
    configuredSteps.forEach(function (step, idx) {
      const stepIndex = idx + 1;
      stepCards[stepIndex] = buildStepCard(step, stepIndex, configuredSteps.length);
    });
  }

  let currentStep = Number(pageData.currentStep) || 2;
  if (!stepCards[currentStep]) currentStep = 2;

  function renderStepCard() {
    const mount = document.getElementById('mt-step-card-host');
    if (!mount) return;
    mount.innerHTML = stepCards[currentStep] || '';
  }

  function updateStepNavState() {
    for (let i = 1; i <= 6; i++) {
      const dot = document.getElementById('mt-dot-' + i);
      if (dot) {
        dot.classList.remove('completed', 'current', 'pending');
        if (i < currentStep) dot.classList.add('completed');
        else if (i === currentStep) dot.classList.add('current');
        else dot.classList.add('pending');
      }

      const label = document.getElementById('mt-label-' + i);
      if (label) {
        if (i === currentStep) {
          label.style.color = 'var(--accent)';
          label.style.fontWeight = '600';
        } else {
          label.style.color = 'var(--text-secondary)';
          label.style.fontWeight = '500';
        }
      }

      if (i <= 5) {
        const line = document.getElementById('mt-line-' + i);
        if (line) line.classList.toggle('completed', i < currentStep);
      }
    }
  }

  function switchModelTrainingStep(step) {
    const next = Number(step);
    if (!stepCards[next]) return;
    currentStep = next;
    renderStepCard();
    updateStepNavState();
  }

  window.switchModelTrainingStep = switchModelTrainingStep;

    const root = document.getElementById('page-root');
  if (!root) return;

  const shell = createPageShell({
    pageId,
    hasTabBar: false,
    topInsetMode: 'spacer'
  });

  root.innerHTML = shell.render({
    topHtml: c_top_frame,
    contentHtml: c_step_stage_nav + c_training_dialogue,
    bottomHtml: c_action_overlay
  });

  switchModelTrainingStep(currentStep);

  initPageComponents(pageId, [
    'top-frame',
    'step-stage-nav',
    'training-dialogue',
    'step-1-identification-training',
    'step-2-decision-training',
    'step-3-equation-training',
    'step-4-trap-analysis',
    'step-5-complete-solve',
    'step-6-variation-training',
    'action-overlay'
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

