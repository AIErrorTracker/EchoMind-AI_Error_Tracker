# 03 HTML 到 Flutter 映射表

> 目标：将当前 HTML 功能区块直接映射为 Flutter 的页面级/功能区级 Widget，不降到按钮原子级。

| HTML 页面 | HTML 组件 | Flutter Widget 建议类名 | State Owner | 说明 |
|---|---|---|---|---|
| ai-diagnosis | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| ai-diagnosis | main-content | AiDiagnosisMainContent | PageState | 页面功能区块 |
| ai-diagnosis | action-overlay | ActionOverlayRegion | PageState | 底部输入/FAB/弹层交互区 |
| community | top-frame-and-tabs | TopFrameWithTabsRegion | PageState | 社区页顶部+三选栏 |
| community | board-my-requests | CommunityBoardMyRequests | PageState | 页面功能区块 |
| community | board-feature-boost | CommunityBoardFeatureBoost | PageState | 页面功能区块 |
| community | board-feedback | CommunityBoardFeedback | PageState | 页面功能区块 |
| flashcard-review | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| flashcard-review | flashcard | FlashcardReviewFlashcard | PageState | 页面功能区块 |
| global-exam | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| global-exam | exam-heatmap | ExamHeatmapRegion | ComponentViewModel | 题号热力网格，可参数化渲染 |
| global-exam | question-type-browser | GlobalExamQuestionTypeBrowser | PageState | 页面功能区块 |
| global-exam | recent-exams | GlobalExamRecentExams | PageState | 页面功能区块 |
| global-knowledge | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| global-knowledge | knowledge-tree | KnowledgeTreeRegion | ComponentViewModel | 可折叠树结构，建议使用 ExpansionTile 组合 |
| global-model | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| global-model | model-tree | ModelTreeRegion | ComponentViewModel | 可折叠树结构，建议使用 ExpansionTile 组合 |
| index | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| index | top-dashboard | IndexTopDashboard | ComponentViewModel | 页面功能区块 |
| index | recommendation-list | IndexRecommendationList | ComponentViewModel | 页面功能区块 |
| index | recent-upload | IndexRecentUpload | ComponentViewModel | 页面功能区块 |
| index | action-overlay | ActionOverlayRegion | PageState | 底部输入/FAB/弹层交互区 |
| knowledge-detail | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| knowledge-detail | mastery-dashboard | KnowledgeDetailMasteryDashboard | PageState | 页面功能区块 |
| knowledge-detail | concept-test-records | KnowledgeDetailConceptTestRecords | PageState | 页面功能区块 |
| knowledge-detail | related-models | KnowledgeDetailRelatedModels | PageState | 页面功能区块 |
| knowledge-learning | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| knowledge-learning | step-stage-nav | StageNavRegion | PageState | 阶段切换导航（知识点/模型训练） |
| knowledge-learning | learning-dialogue | ChatDialogueRegion | ComponentViewModel | AI 对话区，消息和快捷选项由数据驱动 |
| knowledge-learning | step-1-concept-present | KnowledgeLearningStep1ConceptPresent | PageState | 页面功能区块 |
| knowledge-learning | step-2-understanding-check | KnowledgeLearningStep2UnderstandingCheck | PageState | 页面功能区块 |
| knowledge-learning | step-3-discrimination-training | KnowledgeLearningStep3DiscriminationTraining | PageState | 页面功能区块 |
| knowledge-learning | step-4-practical-application | KnowledgeLearningStep4PracticalApplication | PageState | 页面功能区块 |
| knowledge-learning | step-5-concept-test | KnowledgeLearningStep5ConceptTest | PageState | 页面功能区块 |
| knowledge-learning | action-overlay | ActionOverlayRegion | PageState | 底部输入/FAB/弹层交互区 |
| memory | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| memory | review-dashboard | MemoryReviewDashboard | PageState | 页面功能区块 |
| memory | card-category-list | MemoryCardCategoryList | PageState | 页面功能区块 |
| model-detail | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| model-detail | mastery-dashboard | ModelDetailMasteryDashboard | PageState | 页面功能区块 |
| model-detail | prerequisite-knowledge-list | ModelDetailPrerequisiteKnowledgeList | PageState | 页面功能区块 |
| model-detail | related-question-list | ModelDetailRelatedQuestionList | PageState | 页面功能区块 |
| model-detail | training-record-list | ModelDetailTrainingRecordList | PageState | 页面功能区块 |
| model-training | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| model-training | step-stage-nav | StageNavRegion | PageState | 阶段切换导航（知识点/模型训练） |
| model-training | training-dialogue | ChatDialogueRegion | ComponentViewModel | AI 对话区，含历史步骤总结卡 |
| model-training | step-1-identification-training | ModelTrainingStep1IdentificationTraining | PageState | 页面功能区块 |
| model-training | step-2-decision-training | ModelTrainingStep2DecisionTraining | PageState | 页面功能区块 |
| model-training | step-3-equation-training | ModelTrainingStep3EquationTraining | PageState | 页面功能区块 |
| model-training | step-4-trap-analysis | ModelTrainingStep4TrapAnalysis | PageState | 页面功能区块 |
| model-training | step-5-complete-solve | ModelTrainingStep5CompleteSolve | PageState | 页面功能区块 |
| model-training | step-6-variation-training | ModelTrainingStep6VariationTraining | PageState | 页面功能区块 |
| model-training | action-overlay | ActionOverlayRegion | PageState | 底部输入/FAB/弹层交互区 |
| prediction-center | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| prediction-center | score-card | PredictionCenterScoreCard | ComponentViewModel | 页面功能区块 |
| prediction-center | trend-card | PredictionCenterTrendCard | ComponentViewModel | 页面功能区块 |
| prediction-center | score-path-table | PredictionCenterScorePathTable | ComponentViewModel | 页面功能区块 |
| prediction-center | priority-model-list | PredictionCenterPriorityModelList | ComponentViewModel | 页面功能区块 |
| profile | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| profile | user-info-card | ProfileUserInfoCard | PageState | 页面功能区块 |
| profile | target-score-card | ProfileTargetScoreCard | PageState | 页面功能区块 |
| profile | three-row-navigation | ProfileThreeRowNavigation | PageState | 页面功能区块 |
| profile | two-row-navigation | ProfileTwoRowNavigation | PageState | 页面功能区块 |
| profile | learning-stats | ProfileLearningStats | PageState | 页面功能区块 |
| question-aggregate | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| question-aggregate | single-question-dashboard | QuestionAggregateSingleQuestionDashboard | PageState | 页面功能区块 |
| question-aggregate | exam-analysis | QuestionAggregateExamAnalysis | PageState | 页面功能区块 |
| question-aggregate | question-history-list | QuestionAggregateQuestionHistoryList | PageState | 页面功能区块 |
| question-detail | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| question-detail | question-content | QuestionDetailQuestionContent | PageState | 页面功能区块 |
| question-detail | answer-result | QuestionDetailAnswerResult | PageState | 页面功能区块 |
| question-detail | question-relations | QuestionDetailQuestionRelations | PageState | 页面功能区块 |
| question-detail | question-source | QuestionDetailQuestionSource | PageState | 页面功能区块 |
| register-strategy | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| register-strategy | main-content | RegisterStrategyMainContent | PageState | 页面功能区块 |
| upload-history | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| upload-history | history-panel | UploadHistoryHistoryPanel | PageState | 页面功能区块 |
| upload-history | history-filter | UploadHistoryHistoryFilter | ComponentViewModel | 页面功能区块 |
| upload-history | history-date-scroll | UploadHistoryHistoryDateScroll | ComponentViewModel | 页面功能区块 |
| upload-history | history-record-list | UploadHistoryHistoryRecordList | ComponentViewModel | 页面功能区块 |
| upload-menu | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| upload-menu | main-content | UploadMenuMainContent | PageState | 页面功能区块 |
| weekly-review | top-frame | TopFrameRegion | PageState | 统一顶部导航区（可回退/标题/子切换） |
| weekly-review | weekly-dashboard | WeeklyReviewWeeklyDashboard | PageState | 页面功能区块 |
| weekly-review | score-change | WeeklyReviewScoreChange | PageState | 页面功能区块 |
| weekly-review | weekly-progress | WeeklyReviewWeeklyProgress | PageState | 页面功能区块 |
| weekly-review | next-week-focus | WeeklyReviewNextWeekFocus | PageState | 页面功能区块 |

## 迁移建议
- `PageState` 建议在 Flutter 中对应每页的 `StatefulWidget + Controller/Notifier`。
- `ComponentViewModel` 建议对应独立 `ChangeNotifier/ValueNotifier`，通过构造参数注入。
- `TopFrameRegion/ActionOverlayRegion/StageNavRegion` 可沉淀到 `lib/shared/widgets/` 复用。
