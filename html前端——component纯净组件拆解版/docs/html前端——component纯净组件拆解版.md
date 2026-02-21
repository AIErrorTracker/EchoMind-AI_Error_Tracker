# html前端——component纯净组件拆解版（主蓝图）

## 1. 项目定位与阶段目标

### 当前在做的软件
本项目是“高中错题闭环系统”的多端前端原型（当前阶段为原生 HTML/CSS/JS）。

核心目标是把错题学习做成完整闭环：
1. 上传错题
2. AI 诊断
3. 路由训练（模型/知识点）
4. 掌握度更新
5. 预测分变化
6. 推荐下一步

### 当前阶段（HTML）目标
1. 用功能区块组件还原 20 页页面结构（18 核心页 + 2 占位页）。
2. 用语义路由（`routeId`）统一跳转语义。
3. 用 `mock-data` 验证长文本/长数字/长列表与多视口稳定性。
4. 为下一阶段 Flutter 迁移提供页面壳层、组件契约和映射基线。

### 下一阶段（Flutter）目标
1. 保持页面功能区块粒度，不降到按钮原子级。
2. 直接复用 `routeId` 作为 Flutter 命名路由语义源。
3. 将页面组件树映射为 Widget 树，保持主流程与视觉层级一致。

---

## 2. 闭环业务主链路（页面落点）

| 业务环节 | 页面落点（routeId/page） | 关键组件 |
|---|---|---|
| 上传错题 | `home/index`、`uploadMenu/upload-menu`、`uploadHistory/upload-history` | `action-overlay`、`main-content`、`history-record-list` |
| AI 诊断 | `aiDiagnosis/ai-diagnosis` | `main-content`、`action-overlay` |
| 模型训练 | `modelDetail/model-detail`、`modelTraining/model-training` | `mastery-dashboard`、`step-stage-nav`、`training-dialogue` |
| 知识点学习 | `knowledgeDetail/knowledge-detail`、`knowledgeLearning/knowledge-learning` | `mastery-dashboard`、`step-stage-nav`、`learning-dialogue` |
| 掌握度更新 | `model-detail`、`knowledge-detail`、`memory` | `mastery-dashboard`、`review-dashboard` |
| 预测分变化 | `predictionCenter/prediction-center` | `score-card`、`trend-card`、`score-path-table`、`priority-model-list` |
| 周复盘与下一步 | `weeklyReview/weekly-review`、`profile/profile` | `weekly-dashboard`、`next-week-focus`、`three-row-navigation` |

---

## 3. 工程架构总览

```text
html前端——component纯净组件拆解版/
  assets/                    # 图标、静态资源
  pages/                     # 20 个页面源码（页面整合层 + 功能区组件）
  shared/                    # 路由、壳层、公共样式、运行时工具
  mock-data/                 # baseline/stress/edge 三模式占位数据
  tools/                     # 自动截图与布局校验脚本
  docs/                      # 主蓝图 + 附录
    html前端——component纯净组件拆解版.md
    appendix/
      01-页面组件总表.md
      02-路由跳转矩阵.md
      03-HTML到Flutter映射表.md
      04-组件契约与术语.md
  artifacts/                 # 可再生产物（非源码）
    page-annotations/
    layout-validation/
```

职责边界：
1. `pages/*` 只负责页面装配与功能区块渲染，不承载全局路由规则。
2. `shared/router.js` 是唯一路由语义源，统一 routeId -> page 映射。
3. `shared/app.js` 负责组件运行时、壳层装配、事件代理。
4. `mock-data/*` 只提供前端压测数据，不引入后端依赖。
5. `artifacts/*` 为结果产物，允许清理与再生成。

---

## 4. 路由与跳转规范

### 4.1 RouteRegistry（20 路由）

| routeId | page slug | 页面入口 |
|---|---|---|
| `home` | `index` | `pages/index/index.html` |
| `community` | `community` | `pages/community/index.html` |
| `memory` | `memory` | `pages/memory/index.html` |
| `profile` | `profile` | `pages/profile/index.html` |
| `globalKnowledge` | `global-knowledge` | `pages/global-knowledge/index.html` |
| `globalModel` | `global-model` | `pages/global-model/index.html` |
| `globalExam` | `global-exam` | `pages/global-exam/index.html` |
| `aiDiagnosis` | `ai-diagnosis` | `pages/ai-diagnosis/index.html` |
| `flashcardReview` | `flashcard-review` | `pages/flashcard-review/index.html` |
| `knowledgeDetail` | `knowledge-detail` | `pages/knowledge-detail/index.html` |
| `knowledgeLearning` | `knowledge-learning` | `pages/knowledge-learning/index.html` |
| `modelDetail` | `model-detail` | `pages/model-detail/index.html` |
| `modelTraining` | `model-training` | `pages/model-training/index.html` |
| `predictionCenter` | `prediction-center` | `pages/prediction-center/index.html` |
| `questionAggregate` | `question-aggregate` | `pages/question-aggregate/index.html` |
| `questionDetail` | `question-detail` | `pages/question-detail/index.html` |
| `uploadHistory` | `upload-history` | `pages/upload-history/index.html` |
| `weeklyReview` | `weekly-review` | `pages/weekly-review/index.html` |
| `uploadMenu` | `upload-menu` | `pages/upload-menu/index.html` |
| `registerStrategy` | `register-strategy` | `pages/register-strategy/index.html` |

### 4.2 跳转规则
1. 优先使用 `data-route="<routeId>"`。
2. 页面内点击由统一事件代理处理（`attachRouteDelegation`）。
3. 保留 `navigateTo('xxx.html')` 兼容层，仅用于旧代码过渡。
4. 页面间跳转关系详见附录：`docs/appendix/02-路由跳转矩阵.md`。

---

## 5. 页面总清单与组件树（20 页）

| 页面 | routeId | 功能区组件树（L1 -> L2） |
|---|---|---|
| index | home | top-frame -> top-dashboard -> recommendation-list -> recent-upload -> action-overlay |
| community | community | top-frame-and-tabs -> board-my-requests/board-feature-boost/board-feedback |
| global-knowledge | globalKnowledge | top-frame -> knowledge-tree |
| global-model | globalModel | top-frame -> model-tree |
| global-exam | globalExam | top-frame -> exam-heatmap -> question-type-browser -> recent-exams |
| memory | memory | top-frame -> review-dashboard -> card-category-list |
| profile | profile | top-frame -> user-info-card -> target-score-card -> three-row-navigation -> two-row-navigation -> learning-stats |
| upload-history | uploadHistory | top-frame -> history-panel -> history-filter -> history-date-scroll -> history-record-list |
| question-aggregate | questionAggregate | top-frame -> single-question-dashboard -> exam-analysis -> question-history-list |
| question-detail | questionDetail | top-frame -> question-content -> answer-result -> question-relations -> question-source |
| ai-diagnosis | aiDiagnosis | top-frame -> main-content -> action-overlay |
| model-detail | modelDetail | top-frame -> mastery-dashboard -> prerequisite-knowledge-list -> related-question-list -> training-record-list |
| model-training | modelTraining | top-frame -> step-stage-nav -> training-dialogue -> step-1..6 -> action-overlay |
| knowledge-detail | knowledgeDetail | top-frame -> mastery-dashboard -> concept-test-records -> related-models |
| knowledge-learning | knowledgeLearning | top-frame -> step-stage-nav -> learning-dialogue -> step-1..5 -> action-overlay |
| flashcard-review | flashcardReview | top-frame -> flashcard |
| prediction-center | predictionCenter | top-frame -> score-card -> trend-card -> score-path-table -> priority-model-list |
| weekly-review | weeklyReview | top-frame -> weekly-dashboard -> score-change -> weekly-progress -> next-week-focus |
| upload-menu | uploadMenu | top-frame -> main-content |
| register-strategy | registerStrategy | top-frame -> main-content |

详表见附录：`docs/appendix/01-页面组件总表.md`。

---

## 6. 逐页规格（20 页）

> 统一字段：页面目的、组件树、组件表（组件标识/基本信息/输入/输出/预期功能）、进入路由与离开路由、Flutter 映射建议。

### 6.1 首页 `index`（routeId: `home`）

页面目的：展示学习总览，承接“推荐学习 + 快速开始 + 上传入口”。

组件树：`top-frame -> top-dashboard -> recommendation-list -> recent-upload -> action-overlay`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部导航区，非滚动 | 静态标题/日期 | 无 | 提供页面识别与顶部统一头部 |
| `top-dashboard` | 顶部仪表区，内容区首屏 | `stats/prediction/quickStart` | `modelTraining`、`predictionCenter` | 展示今日学习统计、预测分入口、快速开始 |
| `recommendation-list` | 推荐列表区，随内容下推 | `title/items[]` | 默认 `aiDiagnosis`（可由 item.route 覆盖） | 给出下一条最优学习任务 |
| `recent-upload` | 最近上传摘要卡 | `title/subtitle/route` | 默认 `uploadHistory` | 快速回看最新上传记录 |
| `action-overlay` | 底部悬浮操作区 | 静态菜单配置 | `uploadMenu` | 统一上传入口（拍照/相册/文本） |

进入路由：`home`

离开路由：`aiDiagnosis`、`modelTraining`、`predictionCenter`、`uploadHistory`、`uploadMenu`、主 Tab（`home/globalKnowledge/memory/community/profile`）

Flutter 映射建议：`HomePage` + `TopDashboardRegion` + `RecommendationListRegion` + `ActionOverlayRegion`。

### 6.2 社区页 `community`（routeId: `community`）

页面目的：承载社区反馈三板块与主导航回路。

组件树：`top-frame-and-tabs -> board-my-requests / board-feature-boost / board-feedback`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame-and-tabs` | 顶部栏 + 三选栏，固定在顶部 | 当前 tab 索引（页面状态） | 切换板块（页内状态） | 在同一页切换“我的需求/新功能加速/改版建议” |
| `board-my-requests` | 内容板块（列表） | 静态/Mock 列表数据 | 无直接跳转 | 展示个人发起需求 |
| `board-feature-boost` | 内容板块（列表） | 静态/Mock 列表数据 | 无直接跳转 | 展示功能加速建议 |
| `board-feedback` | 内容板块（列表） | 静态/Mock 列表数据 | 无直接跳转 | 展示改版反馈建议 |

进入路由：`community`

离开路由：主 Tab（`home/globalKnowledge/memory/community/profile`）

Flutter 映射建议：`CommunityPage` + `TopFrameWithTabsRegion` + `IndexedStack` 三板块。

### 6.3 全局知识点 `global-knowledge`（routeId: `globalKnowledge`）

页面目的：按学科/章节浏览知识点树并进入知识点详情。

组件树：`top-frame -> knowledge-tree`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部全局切换栏 + 学科栏 | 当前子页状态 | `globalModel`、`globalExam` | 在全局三页间切换 |
| `knowledge-tree` | 主体树状区，可折叠 | 树节点数据（章节/节/知识点） | `knowledgeDetail` | 展开折叠知识点并进入详情 |

进入路由：`globalKnowledge`

离开路由：`globalModel`、`globalExam`、`knowledgeDetail`、主 Tab

Flutter 映射建议：`GlobalKnowledgePage` + `KnowledgeTreeRegion(ExpansionTile 组合)`。

### 6.4 全局模型 `global-model`（routeId: `globalModel`）

页面目的：浏览模型/方法树，进入模型详情训练。

组件树：`top-frame -> model-tree`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部全局切换栏 + 学科栏 | 当前子页状态 | `globalKnowledge`、`globalExam` | 全局视图切换 |
| `model-tree` | 主体树状区，可折叠 | 模型树节点数据 | `modelDetail` | 定位模型节点并进入详情 |

进入路由：`globalModel`

离开路由：`globalKnowledge`、`globalExam`、`modelDetail`、主 Tab

Flutter 映射建议：`GlobalModelPage` + `ModelTreeRegion(ExpansionTile 组合)`。

### 6.5 全局高考卷 `global-exam`（routeId: `globalExam`）

页面目的：从卷面热力图与题型入口进入单题统计。

组件树：`top-frame -> exam-heatmap -> question-type-browser -> recent-exams`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 全局切换栏 | 当前子页状态 | `globalKnowledge`、`globalModel` | 在全局维度切换 |
| `exam-heatmap` | 热力图区域 | 题目格子状态/掌握度数据 | `questionAggregate` | 通过热力格直达单题统计 |
| `question-type-browser` | 按题型入口区 | 题型列表数据 | `questionAggregate`、`uploadMenu` | 按题型浏览或补充上传卷子 |
| `recent-exams` | 最近卷子区 | 最近卷子列表 | `uploadHistory` | 回看近期卷子上传记录 |

进入路由：`globalExam`

离开路由：`questionAggregate`、`uploadMenu`、`uploadHistory`、`globalKnowledge`、`globalModel`、主 Tab

Flutter 映射建议：`GlobalExamPage` + `ExamHeatmapRegion(CustomPainter/Grid)`。

### 6.6 记忆页 `memory`（routeId: `memory`）

页面目的：作为错题记忆训练入口，查看复习状态与分类。

组件树：`top-frame -> review-dashboard -> card-category-list`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部标题区 | 静态标题 | 无 | 页面识别与导航一致性 |
| `review-dashboard` | 复习仪表区 | 待复习量/连续天数等统计 | `flashcardReview` | 快速进入闪卡复习 |
| `card-category-list` | 分类列表区 | 分类及数量数据 | 无 | 显示记忆卡片按类别分布 |

进入路由：`memory`

离开路由：`flashcardReview`、主 Tab

Flutter 映射建议：`MemoryPage` + `ReviewDashboardRegion` + `CardCategoryListRegion`。

### 6.7 我的页 `profile`（routeId: `profile`）

页面目的：集中个人信息、目标分与次级功能入口。

组件树：`top-frame -> user-info-card -> target-score-card -> three-row-navigation -> two-row-navigation -> learning-stats`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部标题区 | 静态标题 | 无 | 统一“我的”页头 |
| `user-info-card` | 个人信息卡 | 用户头像/昵称/班级等 | 无 | 展示账号基础资料 |
| `target-score-card` | 目标分卡 | 当前分/目标分 | 无 | 强化目标导向 |
| `three-row-navigation` | 3 行菜单区 | 菜单配置 | `uploadHistory`、`weeklyReview`、`registerStrategy` | 进入历史、周复盘与学习策略 |
| `two-row-navigation` | 2 行菜单区 | 菜单配置 | 可扩展 | 预留更多功能入口 |
| `learning-stats` | 学习统计区 | 周/月统计数据 | 无 | 提供学习概览 |

进入路由：`profile`

离开路由：`uploadHistory`、`weeklyReview`、`registerStrategy`、主 Tab

Flutter 映射建议：`ProfilePage` + 多个 `Card/ListTile` 区块组合。

### 6.8 上传历史 `upload-history`（routeId: `uploadHistory`）

页面目的：按筛选与日期分组查看做题历史。

组件树：`top-frame -> history-panel -> history-filter -> history-date-scroll -> history-record-list`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部返回区 | 静态标题 | `home` | 返回主页 |
| `history-panel` | 历史容器区 | 子组件承载 | 无 | 承接筛选、日期、列表三区 |
| `history-filter` | 筛选器区 | `chips/active` | 筛选状态切换（页内） | 切换全部/待诊断/已完成等 |
| `history-date-scroll` | 日期分组头区 | `groups[].date` | 日期定位（可扩展） | 展示按日期分组的时间线 |
| `history-record-list` | 历史列表区 | `groups[].items[]` | `questionDetail` | 进入题目详情 |

进入路由：`uploadHistory`

离开路由：`home`、`questionDetail`

Flutter 映射建议：`UploadHistoryPage` + `CustomScrollView(SliverList + StickyHeader)`。

### 6.9 单题统计 `question-aggregate`（routeId: `questionAggregate`）

页面目的：展示某题号整体表现与历史题目列表。

组件树：`top-frame -> single-question-dashboard -> exam-analysis -> question-history-list`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部返回区 | 静态标题 | `globalExam` | 返回卷面视图 |
| `single-question-dashboard` | 统计仪表区 | 做题数/正确率/预测得分 | 无 | 显示单题核心统计 |
| `exam-analysis` | 考情分析区 | 薄弱标签/态度标签等 | 无 | 解释该题失分模式 |
| `question-history-list` | 题目历史区 | 历史题列表 | `questionDetail` | 进入某次题目详情 |

进入路由：`questionAggregate`

离开路由：`globalExam`、`questionDetail`

Flutter 映射建议：`QuestionAggregatePage` + `Dashboard + Analysis + List`。

### 6.10 题目详情 `question-detail`（routeId: `questionDetail`）

页面目的：查看题干、答题结果、关联模型与来源，并进入 AI 诊断。

组件树：`top-frame -> question-content -> answer-result -> question-relations -> question-source`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部返回区 | 静态标题 | `questionAggregate` | 返回单题统计 |
| `question-content` | 题干展示区 | 题图/题文 | 无 | 还原题目上下文 |
| `answer-result` | 结果区 | 对错状态/得分/评语 | `aiDiagnosis` | 进入 AI 诊断环节 |
| `question-relations` | 关联区 | 模型标签/知识点标签 | `modelDetail`、`knowledgeDetail` | 快速跳转到关联训练对象 |
| `question-source` | 来源区 | 卷子来源/上传时间 | 无 | 保留题目元数据 |

进入路由：`questionDetail`

离开路由：`questionAggregate`、`aiDiagnosis`、`modelDetail`、`knowledgeDetail`

Flutter 映射建议：`QuestionDetailPage` + `Sliver` 分区卡片。

### 6.11 AI 诊断 `ai-diagnosis`（routeId: `aiDiagnosis`）

页面目的：围绕单题进行 AI 追问诊断，并进入模型训练。

组件树：`top-frame -> main-content -> action-overlay`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部返回区 | 静态标题 | `questionDetail` | 返回当前题详情 |
| `main-content` | 诊断主体区（题目引用 + 对话 +结论） | 对话数据/结论数据 | `modelTraining`、`questionDetail` | 给出诊断结论并引导训练 |
| `action-overlay` | 底部输入区 | 输入占位文案 | 对话提交（页内） | 继续追问 AI |

进入路由：`aiDiagnosis`

离开路由：`questionDetail`、`modelTraining`

Flutter 映射建议：`AiDiagnosisPage` + `ChatTrainingRegion`。

### 6.12 模型详情 `model-detail`（routeId: `modelDetail`）

页面目的：汇总模型掌握度并组织训练前置准备。

组件树：`top-frame -> mastery-dashboard -> prerequisite-knowledge-list -> related-question-list -> training-record-list`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部返回区 | 静态标题 | `globalModel` | 返回模型树 |
| `mastery-dashboard` | 掌握度仪表区 | 掌握等级/漏斗/建议 | `modelTraining` | 一键进入模型训练 |
| `prerequisite-knowledge-list` | 前置知识区 | 前置知识点列表 | `knowledgeDetail` | 补齐前置知识 |
| `related-question-list` | 相关题区 | 关联题目列表 | `questionDetail` | 回到具体题目 |
| `training-record-list` | 训练记录区 | 历史步骤记录 | 无 | 回看训练进展 |

进入路由：`modelDetail`

离开路由：`globalModel`、`modelTraining`、`knowledgeDetail`、`questionDetail`

Flutter 映射建议：`ModelDetailPage` + `MasteryDashboardRegion` + 三列表区域。

### 6.13 模型训练 `model-training`（routeId: `modelTraining`）

页面目的：按阶段执行模型训练并保持对话区持续上下文。

组件树：`top-frame -> step-stage-nav -> training-dialogue -> step-1..6 -> action-overlay`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部返回区 | 静态标题 | `modelDetail` | 返回模型详情 |
| `step-stage-nav` | 6 阶段导航区，sticky 头部 | 当前步骤索引 | 步骤切换（页内） | 在训练阶段间切换 |
| `training-dialogue` | AI 对话区 | `messages/options/summary` | 对话交互（页内） | 维持步骤切换时对话区稳定 |
| `step-1..step-6` | 当前步骤卡片区 | `steps[]/currentStep` | 步骤状态更新 | 展示当前训练目标与提示 |
| `action-overlay` | 底部输入区 | 输入占位文案 | 提交对话（页内） | 固定底部输入与发送 |

进入路由：`modelTraining`

离开路由：`modelDetail`

Flutter 映射建议：`ModelTrainingPage` + `StageNavRegion` + `ChatDialogueRegion` + `IndexedStack` 步骤卡。

### 6.14 知识点详情 `knowledge-detail`（routeId: `knowledgeDetail`）

页面目的：展示知识点掌握情况并进入知识点学习。

组件树：`top-frame -> mastery-dashboard -> concept-test-records -> related-models`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部返回区 | 静态标题 | `globalKnowledge` | 返回知识树 |
| `mastery-dashboard` | 掌握度总结区 | 掌握状态/建议 | `knowledgeLearning` | 进入知识点学习 |
| `concept-test-records` | 概念检测记录区 | 检测记录列表 | 无 | 回看概念检测历史 |
| `related-models` | 关联模型区 | 关联模型列表 | `modelDetail` | 跳到模型训练入口 |

进入路由：`knowledgeDetail`

离开路由：`globalKnowledge`、`knowledgeLearning`、`modelDetail`

Flutter 映射建议：`KnowledgeDetailPage` + `MasterySummaryRegion` + 记录/关联列表。

### 6.15 知识点学习 `knowledge-learning`（routeId: `knowledgeLearning`）

页面目的：按 5 阶段完成知识点学习，保持对话区持续。

组件树：`top-frame -> step-stage-nav -> learning-dialogue -> step-1..5 -> action-overlay`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部返回区 | 静态标题 | `knowledgeDetail` | 返回知识点详情 |
| `step-stage-nav` | 5 阶段导航区，sticky 头部 | 当前步骤索引 | 步骤切换（页内） | 在 5 个学习步骤间切换 |
| `learning-dialogue` | AI 对话区 | `messages/options` | 对话交互（页内） | 承载问答与快捷回复 |
| `step-1..step-5` | 当前步骤卡片区 | `steps[]/currentStep` | 步骤状态更新 | 仅替换步骤卡，不替换对话区 |
| `action-overlay` | 底部输入区 | 输入占位文案 | 提交对话（页内） | 保持贴底输入体验 |

进入路由：`knowledgeLearning`

离开路由：`knowledgeDetail`

Flutter 映射建议：`KnowledgeLearningPage` + `StageNavRegion` + `ChatDialogueRegion` + `IndexedStack`。

### 6.16 闪卡复习 `flashcard-review`（routeId: `flashcardReview`）

页面目的：进行闪卡翻转与记忆反馈。

组件树：`top-frame -> flashcard`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部返回区 | 静态标题 | `memory` | 返回记忆页 |
| `flashcard` | 闪卡主体区 | 闪卡正反面/进度数据 | 记得/忘记/简单（页内） | 实现翻卡与记忆反馈 |

进入路由：`flashcardReview`

离开路由：`memory`

Flutter 映射建议：`FlashcardReviewPage` + `FlashcardRegion(AnimatedSwitcher/Flip)`。

### 6.17 预测中心 `prediction-center`（routeId: `predictionCenter`）

页面目的：展示预测分、趋势、提分路径和优先训练模型。

组件树：`top-frame -> score-card -> trend-card -> score-path-table -> priority-model-list`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部返回区 | 静态标题 | `home` | 返回首页 |
| `score-card` | 预测分主卡 | `predicted/total/target/gapText` | 无 | 展示当前预测分与目标差 |
| `trend-card` | 趋势图卡 | `labels/trend[]` | 无 | 展示分数趋势折线 |
| `score-path-table` | 提分路径表格区 | `rows[]` | `questionAggregate` | 给出提分动作与分值贡献 |
| `priority-model-list` | 优先模型列表区 | `items[]` | `modelDetail` | 指向优先训练模型 |

进入路由：`predictionCenter`

离开路由：`home`、`questionAggregate`、`modelDetail`

Flutter 映射建议：`PredictionCenterPage` + `ScoreTrendChartRegion` + `DataTableRegion`。

### 6.18 周复盘 `weekly-review`（routeId: `weeklyReview`）

页面目的：展示本周学习结果与下周重点。

组件树：`top-frame -> weekly-dashboard -> score-change -> weekly-progress -> next-week-focus`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部返回区 | 静态标题 | `profile` | 返回“我的”页 |
| `weekly-dashboard` | 本周总览区 | 周统计数据 | 无 | 总结做题与训练量 |
| `score-change` | 分数变化区 | 前后对比数据 | 无 | 展示分数变化趋势 |
| `weekly-progress` | 本周进展区 | 进展列表 | 无 | 展示阶段性完成项 |
| `next-week-focus` | 下周重点区 | 下周计划建议 | 无 | 输出下一周学习重点 |

进入路由：`weeklyReview`

离开路由：`profile`

Flutter 映射建议：`WeeklyReviewPage` + 4 个纵向卡片功能区。

### 6.19 上传菜单占位页 `upload-menu`（routeId: `uploadMenu`）

页面目的：补齐上传入口路由，避免链路断开。

组件树：`top-frame -> main-content`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部返回区 | 静态标题 | `home` | 返回主页 |
| `main-content` | 占位内容区 | 静态文案 | `home` | 告知建设中并可返回 |

进入路由：`uploadMenu`

离开路由：`home`

Flutter 映射建议：`UploadMenuPlaceholderPage`，后续替换为正式上传流程。

### 6.20 学习策略占位页 `register-strategy`（routeId: `registerStrategy`）

页面目的：补齐“我的 -> 学习策略”路由，保证导航闭环。

组件树：`top-frame -> main-content`

| 组件标识 | 基本信息 | 输入 | 输出 | 预期功能 |
|---|---|---|---|---|
| `top-frame` | 顶部返回区 | 静态标题 | `profile` | 返回“我的” |
| `main-content` | 占位内容区 | 静态文案 | `profile` | 告知建设中并可返回 |

进入路由：`registerStrategy`

离开路由：`profile`

Flutter 映射建议：`RegisterStrategyPlaceholderPage`，后续扩展策略编排模块。

---

## 7. 全局复用区块规范

| 复用区块 | 当前落地 | 统一行为边界 |
|---|---|---|
| `TopFrameRegion` | 各页 `top-frame*` | 只负责标题/返回/子切换，不承载业务列表 |
| `BottomTabRegion` | `hasTabBar:true` 页面 | 只负责主导航，不承担页面内部状态 |
| `StageNavRegion` | `step-stage-nav` | 只维护步骤切换状态与样式，不渲染对话内容 |
| `ListRegion` | 各类 `*-list` 组件 | 支持长列表下推布局，不固定高度 |
| `ActionOverlayRegion` | `action-overlay` | 固定底部输入/悬浮按钮，避让主体内容 |
| `ChatDialogueRegion` | `learning-dialogue`/`training-dialogue` | 负责消息渲染和快捷输入，不决定步骤结构 |

---

## 8. HTML -> Flutter 迁移指引

### 8.1 目录映射建议

```text
lib/
  app/
    router/                # RouteRegistry -> GoRouter
    shell/                 # PageShell, TopSpacer, BottomTab
  pages/
    <page>/
      <page>_page.dart
      <page>_state.dart
      widgets/
        <functional_region>.dart
  shared/
    widgets/               # TopFrameRegion/StageNavRegion/ActionOverlayRegion
    theme/                 # 设计令牌映射（字号、间距、颜色）
```

### 8.2 Widget 拆分策略
1. 以“功能区块组件”为最小迁移单元。
2. 页面级状态放到 `PageState`；高交互区（对话/图表/列表）可独立 `ViewModel`。
3. 路由迁移必须保留 routeId 命名，避免双份语义。
4. 当前 HTML 的组件顺序即 Flutter 页面内 section 顺序。

### 8.3 分阶段迁移路径
1. 先迁移 `home -> questionDetail -> aiDiagnosis -> modelTraining` 主链路。
2. 再迁移 `globalKnowledge/globalModel/globalExam` 浏览链路。
3. 最后迁移 `memory/profile/prediction/weekly` 与占位页。

映射详表见：`docs/appendix/03-HTML到Flutter映射表.md`。

---

## 9. 验收与回归基线

1. 布局校验脚本：`tools/validate_mock_layout.py`。
2. 产物输出：`artifacts/layout-validation/report/layout-report.json` 与 `layout-report.md`。
3. 页面标注产物：`artifacts/page-annotations/*`。
4. 验收核心：
   - 20 页可打开；
   - routeId 可解析；
   - stress/edge 模式下无关键布局错位；
   - 主链路跳转可达：`index -> questionDetail/aiDiagnosis/modelTraining/knowledgeLearning/predictionCenter`。

---

## 10. 风险与约束（Flutter 迁移注意）

1. 不要把 HTML 中临时演示样式（如 inline style）直接翻译成 Flutter 固定像素。
2. 不要把步骤页误拆为多个页面；它们是“单页多阶段组件切换”。
3. `routeId` 是唯一导航语义源，禁止迁移时重新发明命名。
4. 列表组件需保持自然文档流，下方组件必须可被“列表增长”推移。
5. 占位页（`upload-menu`、`register-strategy`）当前只保证路由闭环，不代表最终业务完成度。

---

## 11. 附录导航

1. 页面组件总表：`docs/appendix/01-页面组件总表.md`
2. 路由跳转矩阵：`docs/appendix/02-路由跳转矩阵.md`
3. HTML 到 Flutter 映射表：`docs/appendix/03-HTML到Flutter映射表.md`
4. 组件契约与术语：`docs/appendix/04-组件契约与术语.md`
