# Route Map and Page Shell Spec

## Route Map
| routeId | slug | path (inside pages/*) |
|---|---|---|
| home | index | ../index/index.html |
| community | community | ../community/index.html |
| memory | memory | ../memory/index.html |
| profile | profile | ../profile/index.html |
| globalKnowledge | global-knowledge | ../global-knowledge/index.html |
| globalModel | global-model | ../global-model/index.html |
| globalExam | global-exam | ../global-exam/index.html |
| aiDiagnosis | ai-diagnosis | ../ai-diagnosis/index.html |
| flashcardReview | flashcard-review | ../flashcard-review/index.html |
| knowledgeDetail | knowledge-detail | ../knowledge-detail/index.html |
| knowledgeLearning | knowledge-learning | ../knowledge-learning/index.html |
| modelDetail | model-detail | ../model-detail/index.html |
| modelTraining | model-training | ../model-training/index.html |
| predictionCenter | prediction-center | ../prediction-center/index.html |
| questionAggregate | question-aggregate | ../question-aggregate/index.html |
| questionDetail | question-detail | ../question-detail/index.html |
| uploadHistory | upload-history | ../upload-history/index.html |
| weeklyReview | weekly-review | ../weekly-review/index.html |
| uploadMenu | upload-menu | ../upload-menu/index.html |
| registerStrategy | register-strategy | ../register-strategy/index.html |

## Runtime Interfaces
- `navigateToRoute(routeId, params?)`
- `normalizeRouteInput(input)`
- `attachRouteDelegation(root?)`
- `createPageShell({ pageId, hasTabBar, activeTab, topInsetMode })`

## Page Shell Structure
```html
<div class="phone-frame app-shell" data-page-id="...">
  <div class="top-spacer"></div>
  <div class="top-region">...</div>
  <div class="content-region">...</div>
  <div class="bottom-region">...</div>
  <nav class="tab-bar">...</nav>
</div>
```

## Migration Notes
- Route IDs are the only stable navigation contract.
- `phone-frame` class is now a semantic shell container, not a device frame.
- Fake status bar has been removed by design.
