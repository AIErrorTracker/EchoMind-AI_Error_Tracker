class AppRoutes {
  static const home = '/home';
  static const community = '/community';
  static const memory = '/memory';
  static const profile = '/profile';

  static const globalKnowledge = '/global-knowledge';
  static const globalModel = '/global-model';
  static const globalExam = '/global-exam';

  static const uploadHistory = '/upload-history';
  static const questionAggregate = '/question-aggregate';
  static const questionDetail = '/question-detail';
  static const aiDiagnosis = '/ai-diagnosis';
  static const modelDetail = '/model-detail';
  static const modelTraining = '/model-training';
  static const knowledgeDetail = '/knowledge-detail';
  static const knowledgeLearning = '/knowledge-learning';
  static const flashcardReview = '/flashcard-review';
  static const predictionCenter = '/prediction-center';
  static const weeklyReview = '/weekly-review';
  static const uploadMenu = '/upload-menu';
  static const registerStrategy = '/register-strategy';

  static const all = <String>{
    home,
    community,
    memory,
    profile,
    globalKnowledge,
    globalModel,
    globalExam,
    uploadHistory,
    questionAggregate,
    questionDetail,
    aiDiagnosis,
    modelDetail,
    modelTraining,
    knowledgeDetail,
    knowledgeLearning,
    flashcardReview,
    predictionCenter,
    weeklyReview,
    uploadMenu,
    registerStrategy,
  };

  // Keep routeId semantics aligned with the HTML project.
  static const routeIdToPath = <String, String>{
    'home': home,
    'community': community,
    'memory': memory,
    'profile': profile,
    'globalKnowledge': globalKnowledge,
    'globalModel': globalModel,
    'globalExam': globalExam,
    'uploadHistory': uploadHistory,
    'questionAggregate': questionAggregate,
    'questionDetail': questionDetail,
    'aiDiagnosis': aiDiagnosis,
    'modelDetail': modelDetail,
    'modelTraining': modelTraining,
    'knowledgeDetail': knowledgeDetail,
    'knowledgeLearning': knowledgeLearning,
    'flashcardReview': flashcardReview,
    'predictionCenter': predictionCenter,
    'weeklyReview': weeklyReview,
    'uploadMenu': uploadMenu,
    'registerStrategy': registerStrategy,
  };

  static String? fromRouteId(String routeId) => routeIdToPath[routeId];
}
