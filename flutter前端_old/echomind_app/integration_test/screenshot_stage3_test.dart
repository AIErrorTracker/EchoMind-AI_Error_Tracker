import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:echomind_app/main.dart';
import 'package:echomind_app/app/app_router.dart';

// -- Import all widget types for find.byType --
// home
import 'package:echomind_app/features/home/widgets/top_frame_widget.dart' as home_tf;
import 'package:echomind_app/features/home/widgets/top_dashboard_widget.dart';
import 'package:echomind_app/features/home/widgets/recommendation_list_widget.dart';
import 'package:echomind_app/features/home/widgets/recent_upload_widget.dart';
// home action_overlay_widget.dart actually exports UploadErrorCardWidget
import 'package:echomind_app/features/home/widgets/action_overlay_widget.dart';
// community
import 'package:echomind_app/features/community/widgets/top_frame_and_tabs_widget.dart';
import 'package:echomind_app/features/community/widgets/board_feature_boost_widget.dart';
import 'package:echomind_app/features/community/widgets/board_feedback_widget.dart';
import 'package:echomind_app/features/community/widgets/board_my_requests_widget.dart';
// global_knowledge
import 'package:echomind_app/features/global_knowledge/widgets/top_frame_widget.dart' as gk_tf;
import 'package:echomind_app/features/global_knowledge/widgets/knowledge_tree_widget.dart';
// global_model
import 'package:echomind_app/features/global_model/widgets/top_frame_widget.dart' as gm_tf;
import 'package:echomind_app/features/global_model/widgets/model_tree_widget.dart';
// global_exam
import 'package:echomind_app/features/global_exam/widgets/top_frame_widget.dart' as ge_tf;
import 'package:echomind_app/features/global_exam/widgets/exam_heatmap_widget.dart';
import 'package:echomind_app/features/global_exam/widgets/question_type_browser_widget.dart';
import 'package:echomind_app/features/global_exam/widgets/recent_exams_widget.dart';
// memory
import 'package:echomind_app/features/memory/widgets/top_frame_widget.dart' as mem_tf;
import 'package:echomind_app/features/memory/widgets/review_dashboard_widget.dart';
import 'package:echomind_app/features/memory/widgets/card_category_list_widget.dart';
// flashcard_review
import 'package:echomind_app/features/flashcard_review/widgets/top_frame_widget.dart' as fr_tf;
import 'package:echomind_app/features/flashcard_review/widgets/flashcard_widget.dart';
// question_aggregate
import 'package:echomind_app/features/question_aggregate/widgets/top_frame_widget.dart' as qa_tf;
import 'package:echomind_app/features/question_aggregate/widgets/single_question_dashboard_widget.dart';
import 'package:echomind_app/features/question_aggregate/widgets/exam_analysis_widget.dart';
import 'package:echomind_app/features/question_aggregate/widgets/question_history_list_widget.dart';
// question_detail
import 'package:echomind_app/features/question_detail/widgets/top_frame_widget.dart' as qd_tf;
import 'package:echomind_app/features/question_detail/widgets/question_content_widget.dart';
import 'package:echomind_app/features/question_detail/widgets/answer_result_widget.dart';
import 'package:echomind_app/features/question_detail/widgets/question_relations_widget.dart';
import 'package:echomind_app/features/question_detail/widgets/question_source_widget.dart';
// ai_diagnosis
import 'package:echomind_app/features/ai_diagnosis/widgets/top_frame_widget.dart' as ai_tf;
import 'package:echomind_app/features/ai_diagnosis/widgets/main_content_widget.dart' as ai_mc;
import 'package:echomind_app/features/ai_diagnosis/widgets/action_overlay_widget.dart' as ai_ao;
// model_detail
import 'package:echomind_app/features/model_detail/widgets/top_frame_widget.dart' as md_tf;
import 'package:echomind_app/features/model_detail/widgets/mastery_dashboard_widget.dart' as md_mastery;
import 'package:echomind_app/features/model_detail/widgets/prerequisite_knowledge_list_widget.dart';
import 'package:echomind_app/features/model_detail/widgets/related_question_list_widget.dart';
import 'package:echomind_app/features/model_detail/widgets/training_record_list_widget.dart';
// model_training
import 'package:echomind_app/features/model_training/widgets/top_frame_widget.dart' as mt_tf;
import 'package:echomind_app/features/model_training/widgets/step_stage_nav_widget.dart' as mt_nav;
import 'package:echomind_app/features/model_training/widgets/step1_identification_training_widget.dart';
import 'package:echomind_app/features/model_training/widgets/training_dialogue_widget.dart' as mt_dlg;
import 'package:echomind_app/features/model_training/widgets/action_overlay_widget.dart' as mt_ao;
// knowledge_detail
import 'package:echomind_app/features/knowledge_detail/widgets/top_frame_widget.dart' as kd_tf;
import 'package:echomind_app/features/knowledge_detail/widgets/mastery_dashboard_widget.dart' as kd_mastery;
import 'package:echomind_app/features/knowledge_detail/widgets/concept_test_records_widget.dart';
import 'package:echomind_app/features/knowledge_detail/widgets/related_models_widget.dart';
// knowledge_learning
import 'package:echomind_app/features/knowledge_learning/widgets/top_frame_widget.dart' as kl_tf;
import 'package:echomind_app/features/knowledge_learning/widgets/step_stage_nav_widget.dart' as kl_nav;
import 'package:echomind_app/features/knowledge_learning/widgets/step1_concept_present_widget.dart';
import 'package:echomind_app/features/knowledge_learning/widgets/learning_dialogue_widget.dart';
import 'package:echomind_app/features/knowledge_learning/widgets/action_overlay_widget.dart' as kl_ao;
// prediction_center
import 'package:echomind_app/features/prediction_center/widgets/top_frame_widget.dart' as pc_tf;
import 'package:echomind_app/features/prediction_center/widgets/score_card_widget.dart';
import 'package:echomind_app/features/prediction_center/widgets/trend_card_widget.dart';
import 'package:echomind_app/features/prediction_center/widgets/score_path_table_widget.dart';
import 'package:echomind_app/features/prediction_center/widgets/priority_model_list_widget.dart';
// upload_history
import 'package:echomind_app/features/upload_history/widgets/top_frame_widget.dart' as uh_tf;
import 'package:echomind_app/features/upload_history/widgets/history_filter_widget.dart';
import 'package:echomind_app/features/upload_history/widgets/history_record_list_widget.dart';
// weekly_review
import 'package:echomind_app/features/weekly_review/widgets/top_frame_widget.dart' as wr_tf;
import 'package:echomind_app/features/weekly_review/widgets/weekly_dashboard_widget.dart';
import 'package:echomind_app/features/weekly_review/widgets/score_change_widget.dart';
import 'package:echomind_app/features/weekly_review/widgets/weekly_progress_widget.dart';
import 'package:echomind_app/features/weekly_review/widgets/next_week_focus_widget.dart';
// profile
import 'package:echomind_app/features/profile/widgets/top_frame_widget.dart' as pf_tf;
import 'package:echomind_app/features/profile/widgets/user_info_card_widget.dart';
import 'package:echomind_app/features/profile/widgets/target_score_card_widget.dart';
import 'package:echomind_app/features/profile/widgets/three_row_navigation_widget.dart';
import 'package:echomind_app/features/profile/widgets/two_row_navigation_widget.dart';
import 'package:echomind_app/features/profile/widgets/learning_stats_widget.dart';
// upload_menu
import 'package:echomind_app/features/upload_menu/widgets/top_frame_widget.dart' as um_tf;
import 'package:echomind_app/features/upload_menu/widgets/main_content_widget.dart' as um_mc;
// register_strategy
import 'package:echomind_app/features/register_strategy/widgets/top_frame_widget.dart' as rs_tf;
import 'package:echomind_app/features/register_strategy/widgets/main_content_widget.dart' as rs_mc;


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late String baseDir;

  /// Take a full-page screenshot and save to [dir]/full/[name]__390x844__full.png
  Future<void> fullScreenshot(WidgetTester tester, String dir, String name) async {
    await tester.pumpAndSettle();
    final outDir = Directory('$baseDir/$dir/full');
    if (!outDir.existsSync()) outDir.createSync(recursive: true);
    final renderObject = tester.binding.renderViews.first;
    final layer = renderObject.debugLayer! as OffsetLayer;
    final image = await layer.toImage(renderObject.paintBounds);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    File('${outDir.path}/${name}__390x844__full.png')
        .writeAsBytesSync(byteData!.buffer.asUint8List());
    image.dispose();
  }

  /// Take a component screenshot by finding [widgetType] and cropping its bounds.
  Future<void> componentScreenshot(
    WidgetTester tester,
    String dir,
    String componentName,
    Type widgetType, {
    bool scrollFirst = false,
  }) async {
    await tester.pumpAndSettle();
    final finder = find.byType(widgetType);
    if (finder.evaluate().isEmpty) {
      debugPrint('⚠ Widget $widgetType not found on page $dir, skipping.');
      return;
    }
    if (scrollFirst) {
      try {
        await tester.scrollUntilVisible(finder, 200);
        await tester.pumpAndSettle();
      } catch (_) {}
    }
    final outDir = Directory('$baseDir/$dir/components');
    if (!outDir.existsSync()) outDir.createSync(recursive: true);

    // Get the component's render object bounds in global coordinates
    final RenderBox renderBox = tester.renderObject(finder.first);
    final topLeft = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final componentRect = Rect.fromLTWH(topLeft.dx, topLeft.dy, size.width, size.height);

    // Capture the full screen then crop
    final renderView = tester.binding.renderViews.first;
    final layer = renderView.debugLayer! as OffsetLayer;
    final fullImage = await layer.toImage(renderView.paintBounds);
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawImageRect(
      fullImage,
      componentRect,
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint(),
    );
    final picture = recorder.endRecording();
    final croppedImage = await picture.toImage(size.width.ceil(), size.height.ceil());
    final byteData = await croppedImage.toByteData(format: ui.ImageByteFormat.png);
    File('${outDir.path}/${componentName}__390x844.png')
        .writeAsBytesSync(byteData!.buffer.asUint8List());
    fullImage.dispose();
    croppedImage.dispose();
  }

  // ── Page definitions: route, folder name, display name, components ──
  // Each component: (componentName, Type, needsScroll)

  testWidgets('Stage 3: Screenshot all pages and components', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const EchoMindApp());
    await tester.pumpAndSettle();

    // Save directly to the docs folder (works on Windows/desktop targets)
    baseDir = r'D:\AI\AI+high school homework\EchoMind-AI_Error_Tracker\docs\第三阶段_flutter美化\flutter截图验证';
    debugPrint('Screenshots will be saved to: $baseDir');

    // ════════════════════════════════════════
    // 01 - home
    // ════════════════════════════════════════
    appRouter.go('/');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'home', 'home');
    await componentScreenshot(tester, 'home', 'top-frame', home_tf.TopFrameWidget);
    await componentScreenshot(tester, 'home', 'top-dashboard', TopDashboardWidget);
    await componentScreenshot(tester, 'home', 'recommendation-list', RecommendationListWidget, scrollFirst: true);
    await componentScreenshot(tester, 'home', 'recent-upload', RecentUploadWidget, scrollFirst: true);
    await componentScreenshot(tester, 'home', 'action-overlay', UploadErrorCardWidget);

    // ════════════════════════════════════════
    // 02 - community
    // ════════════════════════════════════════
    appRouter.go('/community');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'community', 'community');
    await componentScreenshot(tester, 'community', 'top-frame-and-tabs', TopFrameAndTabsWidget);
    await componentScreenshot(tester, 'community', 'board-feature-boost', BoardFeatureBoostWidget);
    await componentScreenshot(tester, 'community', 'board-feedback', BoardFeedbackWidget, scrollFirst: true);
    await componentScreenshot(tester, 'community', 'board-my-requests', BoardMyRequestsWidget, scrollFirst: true);

    // ════════════════════════════════════════
    // 03 - community-detail
    // ════════════════════════════════════════
    appRouter.go('/community-detail');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'community-detail', 'community-detail');

    // ════════════════════════════════════════
    // 04 - global-knowledge
    // ════════════════════════════════════════
    appRouter.go('/global-knowledge');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'global-knowledge', 'global-knowledge');
    await componentScreenshot(tester, 'global-knowledge', 'top-frame', gk_tf.TopFrameWidget);
    await componentScreenshot(tester, 'global-knowledge', 'knowledge-tree', KnowledgeTreeWidget);

    // ════════════════════════════════════════
    // 05 - global-model
    // ════════════════════════════════════════
    appRouter.go('/global-model');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'global-model', 'global-model');
    await componentScreenshot(tester, 'global-model', 'top-frame', gm_tf.TopFrameWidget);
    await componentScreenshot(tester, 'global-model', 'model-tree', ModelTreeWidget);

    // ════════════════════════════════════════
    // 06 - global-exam
    // ════════════════════════════════════════
    appRouter.go('/global-exam');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'global-exam', 'global-exam');
    await componentScreenshot(tester, 'global-exam', 'top-frame', ge_tf.TopFrameWidget);
    await componentScreenshot(tester, 'global-exam', 'exam-heatmap', ExamHeatmapWidget);
    await componentScreenshot(tester, 'global-exam', 'question-type-browser', QuestionTypeBrowserWidget, scrollFirst: true);
    await componentScreenshot(tester, 'global-exam', 'recent-exams', RecentExamsWidget, scrollFirst: true);

    // ════════════════════════════════════════
    // 07 - memory
    // ════════════════════════════════════════
    appRouter.go('/memory');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'memory', 'memory');
    await componentScreenshot(tester, 'memory', 'top-frame', mem_tf.TopFrameWidget);
    await componentScreenshot(tester, 'memory', 'review-dashboard', ReviewDashboardWidget);
    await componentScreenshot(tester, 'memory', 'card-category-list', CardCategoryListWidget, scrollFirst: true);

    // ════════════════════════════════════════
    // 08 - flashcard-review
    // ════════════════════════════════════════
    appRouter.go('/flashcard-review');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'flashcard-review', 'flashcard-review');
    await componentScreenshot(tester, 'flashcard-review', 'top-frame', fr_tf.TopFrameWidget);
    await componentScreenshot(tester, 'flashcard-review', 'flashcard', FlashcardWidget);

    // ════════════════════════════════════════
    // 09 - question-aggregate
    // ════════════════════════════════════════
    appRouter.go('/question-aggregate');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'question-aggregate', 'question-aggregate');
    await componentScreenshot(tester, 'question-aggregate', 'top-frame', qa_tf.TopFrameWidget);
    await componentScreenshot(tester, 'question-aggregate', 'single-question-dashboard', SingleQuestionDashboardWidget);
    await componentScreenshot(tester, 'question-aggregate', 'exam-analysis', ExamAnalysisWidget, scrollFirst: true);
    await componentScreenshot(tester, 'question-aggregate', 'question-history-list', QuestionHistoryListWidget, scrollFirst: true);

    // ════════════════════════════════════════
    // 10 - question-detail
    // ════════════════════════════════════════
    appRouter.go('/question-detail');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'question-detail', 'question-detail');
    await componentScreenshot(tester, 'question-detail', 'top-frame', qd_tf.TopFrameWidget);
    await componentScreenshot(tester, 'question-detail', 'question-content', QuestionContentWidget);
    await componentScreenshot(tester, 'question-detail', 'answer-result', AnswerResultWidget, scrollFirst: true);
    await componentScreenshot(tester, 'question-detail', 'question-relations', QuestionRelationsWidget, scrollFirst: true);
    await componentScreenshot(tester, 'question-detail', 'question-source', QuestionSourceWidget, scrollFirst: true);

    // ════════════════════════════════════════
    // 11 - ai-diagnosis
    // ════════════════════════════════════════
    appRouter.go('/ai-diagnosis');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'ai-diagnosis', 'ai-diagnosis');
    await componentScreenshot(tester, 'ai-diagnosis', 'top-frame', ai_tf.TopFrameWidget);
    await componentScreenshot(tester, 'ai-diagnosis', 'main-content', ai_mc.MainContentWidget);
    await componentScreenshot(tester, 'ai-diagnosis', 'action-overlay', ai_ao.ActionOverlayWidget);

    // ════════════════════════════════════════
    // 12 - model-detail
    // ════════════════════════════════════════
    appRouter.go('/model-detail');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'model-detail', 'model-detail');
    await componentScreenshot(tester, 'model-detail', 'top-frame', md_tf.TopFrameWidget);
    await componentScreenshot(tester, 'model-detail', 'mastery-dashboard', md_mastery.MasteryDashboardWidget);
    await componentScreenshot(tester, 'model-detail', 'prerequisite-knowledge-list', PrerequisiteKnowledgeListWidget, scrollFirst: true);
    await componentScreenshot(tester, 'model-detail', 'related-question-list', RelatedQuestionListWidget, scrollFirst: true);
    await componentScreenshot(tester, 'model-detail', 'training-record-list', TrainingRecordListWidget, scrollFirst: true);

    // ════════════════════════════════════════
    // 13 - model-training (default shows step1)
    // ════════════════════════════════════════
    appRouter.go('/model-training');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'model-training', 'model-training');
    await componentScreenshot(tester, 'model-training', 'top-frame', mt_tf.TopFrameWidget);
    await componentScreenshot(tester, 'model-training', 'step-stage-nav', mt_nav.StepStageNavWidget);
    await componentScreenshot(tester, 'model-training', 'step1-identification-training', Step1IdentificationTrainingWidget);
    await componentScreenshot(tester, 'model-training', 'training-dialogue', mt_dlg.TrainingDialogueWidget, scrollFirst: true);
    await componentScreenshot(tester, 'model-training', 'action-overlay', mt_ao.ActionOverlayWidget);

    // ════════════════════════════════════════
    // 14 - knowledge-detail
    // ════════════════════════════════════════
    appRouter.go('/knowledge-detail');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'knowledge-detail', 'knowledge-detail');
    await componentScreenshot(tester, 'knowledge-detail', 'top-frame', kd_tf.TopFrameWidget);
    await componentScreenshot(tester, 'knowledge-detail', 'mastery-dashboard', kd_mastery.MasteryDashboardWidget);
    await componentScreenshot(tester, 'knowledge-detail', 'concept-test-records', ConceptTestRecordsWidget, scrollFirst: true);
    await componentScreenshot(tester, 'knowledge-detail', 'related-models', RelatedModelsWidget, scrollFirst: true);

    // ════════════════════════════════════════
    // 15 - knowledge-learning (default shows step1)
    // ════════════════════════════════════════
    appRouter.go('/knowledge-learning');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'knowledge-learning', 'knowledge-learning');
    await componentScreenshot(tester, 'knowledge-learning', 'top-frame', kl_tf.TopFrameWidget);
    await componentScreenshot(tester, 'knowledge-learning', 'step-stage-nav', kl_nav.StepStageNavWidget);
    await componentScreenshot(tester, 'knowledge-learning', 'step1-concept-present', Step1ConceptPresentWidget);
    await componentScreenshot(tester, 'knowledge-learning', 'learning-dialogue', LearningDialogueWidget, scrollFirst: true);
    await componentScreenshot(tester, 'knowledge-learning', 'action-overlay', kl_ao.ActionOverlayWidget);

    // ════════════════════════════════════════
    // 16 - prediction-center
    // ════════════════════════════════════════
    appRouter.go('/prediction-center');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'prediction-center', 'prediction-center');
    await componentScreenshot(tester, 'prediction-center', 'top-frame', pc_tf.TopFrameWidget);
    await componentScreenshot(tester, 'prediction-center', 'score-card', ScoreCardWidget);
    await componentScreenshot(tester, 'prediction-center', 'trend-card', TrendCardWidget, scrollFirst: true);
    await componentScreenshot(tester, 'prediction-center', 'score-path-table', ScorePathTableWidget, scrollFirst: true);
    await componentScreenshot(tester, 'prediction-center', 'priority-model-list', PriorityModelListWidget, scrollFirst: true);

    // ════════════════════════════════════════
    // 17 - upload-history
    // ════════════════════════════════════════
    appRouter.go('/upload-history');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'upload-history', 'upload-history');
    await componentScreenshot(tester, 'upload-history', 'top-frame', uh_tf.TopFrameWidget);
    await componentScreenshot(tester, 'upload-history', 'history-filter', HistoryFilterWidget);
    await componentScreenshot(tester, 'upload-history', 'history-record-list', HistoryRecordListWidget, scrollFirst: true);

    // ════════════════════════════════════════
    // 18 - weekly-review
    // ════════════════════════════════════════
    appRouter.go('/weekly-review');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'weekly-review', 'weekly-review');
    await componentScreenshot(tester, 'weekly-review', 'top-frame', wr_tf.TopFrameWidget);
    await componentScreenshot(tester, 'weekly-review', 'weekly-dashboard', WeeklyDashboardWidget);
    await componentScreenshot(tester, 'weekly-review', 'score-change', ScoreChangeWidget, scrollFirst: true);
    await componentScreenshot(tester, 'weekly-review', 'weekly-progress', WeeklyProgressWidget, scrollFirst: true);
    await componentScreenshot(tester, 'weekly-review', 'next-week-focus', NextWeekFocusWidget, scrollFirst: true);

    // ════════════════════════════════════════
    // 19 - profile
    // ════════════════════════════════════════
    appRouter.go('/profile');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'profile', 'profile');
    await componentScreenshot(tester, 'profile', 'top-frame', pf_tf.TopFrameWidget);
    await componentScreenshot(tester, 'profile', 'user-info-card', UserInfoCardWidget);
    await componentScreenshot(tester, 'profile', 'target-score-card', TargetScoreCardWidget);
    await componentScreenshot(tester, 'profile', 'three-row-navigation', ThreeRowNavigationWidget, scrollFirst: true);
    await componentScreenshot(tester, 'profile', 'two-row-navigation', TwoRowNavigationWidget, scrollFirst: true);
    await componentScreenshot(tester, 'profile', 'learning-stats', LearningStatsWidget, scrollFirst: true);

    // ════════════════════════════════════════
    // 20 - upload-menu
    // ════════════════════════════════════════
    appRouter.go('/upload-menu');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'upload-menu', 'upload-menu');
    await componentScreenshot(tester, 'upload-menu', 'top-frame', um_tf.TopFrameWidget);
    await componentScreenshot(tester, 'upload-menu', 'main-content', um_mc.MainContentWidget);

    // ════════════════════════════════════════
    // 21 - register-strategy
    // ════════════════════════════════════════
    appRouter.go('/register-strategy');
    await tester.pumpAndSettle();
    await fullScreenshot(tester, 'register-strategy', 'register-strategy');
    await componentScreenshot(tester, 'register-strategy', 'top-frame', rs_tf.TopFrameWidget);
    await componentScreenshot(tester, 'register-strategy', 'main-content', rs_mc.MainContentWidget);

    debugPrint('✅ All 21 pages screenshot complete!');
  });
}
