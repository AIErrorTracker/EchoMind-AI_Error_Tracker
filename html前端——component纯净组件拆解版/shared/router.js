/* ============================================
   Semantic Router (Flutter-ready)
   ============================================ */
(function () {
  const ROUTES = {
    home: 'index',
    community: 'community',
    memory: 'memory',
    profile: 'profile',
    globalKnowledge: 'global-knowledge',
    globalModel: 'global-model',
    globalExam: 'global-exam',
    aiDiagnosis: 'ai-diagnosis',
    flashcardReview: 'flashcard-review',
    knowledgeDetail: 'knowledge-detail',
    knowledgeLearning: 'knowledge-learning',
    modelDetail: 'model-detail',
    modelTraining: 'model-training',
    predictionCenter: 'prediction-center',
    questionAggregate: 'question-aggregate',
    questionDetail: 'question-detail',
    uploadHistory: 'upload-history',
    weeklyReview: 'weekly-review',
    uploadMenu: 'upload-menu',
    registerStrategy: 'register-strategy',
  };

  const FILE_TO_ROUTE = {
    'index.html': 'home',
    'community.html': 'community',
    'memory.html': 'memory',
    'profile.html': 'profile',
    'global-knowledge.html': 'globalKnowledge',
    'global-model.html': 'globalModel',
    'global-exam.html': 'globalExam',
    'ai-diagnosis.html': 'aiDiagnosis',
    'flashcard-review.html': 'flashcardReview',
    'knowledge-detail.html': 'knowledgeDetail',
    'knowledge-learning.html': 'knowledgeLearning',
    'model-detail.html': 'modelDetail',
    'model-training.html': 'modelTraining',
    'prediction-center.html': 'predictionCenter',
    'question-aggregate.html': 'questionAggregate',
    'question-detail.html': 'questionDetail',
    'upload-history.html': 'uploadHistory',
    'weekly-review.html': 'weeklyReview',
    'upload-menu.html': 'uploadMenu',
    'register-strategy.html': 'registerStrategy',
  };

  function normalizeRouteInput(input) {
    if (!input && input !== 0) return null;
    const value = String(input).trim();
    if (!value) return null;

    if (ROUTES[value]) return value;

    if (/^[^/]+\.html$/i.test(value)) {
      const lower = value.toLowerCase();
      if (FILE_TO_ROUTE[lower]) return FILE_TO_ROUTE[lower];
      const slug = lower.replace(/\.html$/i, '');
      const candidate = Object.keys(ROUTES).find((id) => ROUTES[id] === slug);
      return candidate || null;
    }

    const slugMatch = value.match(/(?:^|\/)([a-z0-9-]+)(?:\/index\.html)?(?:[?#].*)?$/i);
    if (slugMatch && slugMatch[1]) {
      const slug = slugMatch[1].toLowerCase();
      const candidate = Object.keys(ROUTES).find((id) => ROUTES[id] === slug);
      if (candidate) return candidate;
    }

    return null;
  }

  function hasRouteId(routeId) {
    return !!(routeId && ROUTES[routeId]);
  }

  function getAllRouteIds() {
    return Object.keys(ROUTES);
  }

  function resolveRoutePath(routeId) {
    if (!hasRouteId(routeId)) return null;
    const slug = ROUTES[routeId];
    const inPagesDir = /\/pages\/[^/]+\/index\.html$/i.test(window.location.pathname);
    return inPagesDir ? `../${slug}/index.html` : `pages/${slug}/index.html`;
  }

  function navigateToRoute(routeInput, params) {
    const routeId = normalizeRouteInput(routeInput);
    if (!routeId) {
      console.warn('[router] unknown route input:', routeInput);
      return;
    }
    const base = resolveRoutePath(routeId);
    if (!base) {
      console.warn('[router] route not registered:', routeId);
      return;
    }

    const url = new URL(base, window.location.href);
    if (params && typeof params === 'object') {
      Object.keys(params).forEach((k) => {
        if (params[k] !== undefined && params[k] !== null) {
          url.searchParams.set(k, String(params[k]));
        }
      });
    }
    window.location.href = url.toString();
  }

  function attachRouteDelegation(root) {
    const scope = root || document;
    if (!scope || scope.__routeDelegationBound) return;

    scope.addEventListener('click', function (event) {
      const target = event.target && event.target.closest ? event.target.closest('[data-route]') : null;
      if (!target) return;

      const routeId = target.getAttribute('data-route');
      if (!routeId) return;

      event.preventDefault();
      navigateToRoute(routeId);
    });

    scope.__routeDelegationBound = true;
  }

  window.RouteRegistry = ROUTES;
  window.RouteFileAlias = FILE_TO_ROUTE;
  window.normalizeRouteInput = normalizeRouteInput;
  window.hasRouteId = hasRouteId;
  window.getAllRouteIds = getAllRouteIds;
  window.resolveRoutePath = resolveRoutePath;
  window.navigateToRoute = navigateToRoute;
  window.attachRouteDelegation = attachRouteDelegation;
})();
