# 任务 08：question-aggregate 单题聚合（待实现）

> 开始前请先阅读 `00_总起说明_每个任务必读.md`

## 任务目标

将 question-aggregate 页面从 stub 实现为完整页面。按题号查看历史表现与薄弱点。

## 参考资料

- 页面说明：`docs/第二阶段_html转flutter/18个html页面的分别说明文档/08_question-aggregate_单题聚合.md`
- 页面截图：`docs/第一阶段_html细化/html截图验证/question-aggregate/full/question-aggregate__390x844__full.png`
- 组件截图：`docs/第一阶段_html细化/html截图验证/question-aggregate/components/`

## 目标文件

- `echomind_app/lib/features/question_aggregate/question_aggregate_page.dart`
- `echomind_app/lib/features/question_aggregate/widgets/top_frame_widget.dart`
- `echomind_app/lib/features/question_aggregate/widgets/single_question_dashboard_widget.dart`
- `echomind_app/lib/features/question_aggregate/widgets/exam_analysis_widget.dart`
- `echomind_app/lib/features/question_aggregate/widgets/question_history_list_widget.dart`

## 组件清单

| 组件 | 功能 | 跳转 |
|------|------|------|
| top-frame | 返回 + 题号标题 | globalExam（返回） |
| single-question-dashboard | 做题次数、正确率、预测得分 | 无 |
| exam-analysis | 态度与关联薄弱信息 | 无 |
| question-history-list | 该题号历史题目列表 | questionDetail |

## 页面结构

```
Scaffold → SafeArea → Column [TopFrame, Expanded(ListView [Dashboard, ExamAnalysis, HistoryList])]
```

## 输出要求

1. **截图留档**：保存页面效果截图到 `docs/第二阶段_html转flutter/截图验证/08_question-aggregate_单题聚合_完成效果.png`
2. **完成说明**：创建 `docs/第二阶段_html转flutter/18个页面的完成说明文档/08_question-aggregate_单题聚合_完成说明.md`，内容包括：实现的组件列表、与截图的差异说明、路由跳转验证结果、已知问题或遗留项
3. **拉起下一任务**：完成后自动读取 `09_question-detail_题目详情.md` 并开始执行下一个页面的工作流

---

# 附录：页面说明文档（question-aggregate 单题聚合）

## 设计目的

按题号查看历史表现与薄弱点。

## 路由标识

`questionAggregate`

## 组件树

```text
question-aggregate
├─ top-frame
├─ single-question-dashboard
├─ exam-analysis
└─ question-history-list
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- 来源: `global-exam` (exam-heatmap / question-type-browser)
- 去向: `question-detail` (question-history-list)

## 页面截图

- 视口 `390x844`
![question-aggregate-390x844](../../第一阶段_html细化/html截图验证/question-aggregate/full/question-aggregate__390x844__full.png)

- 视口 `430x932`
![question-aggregate-430x932](../../第一阶段_html细化/html截图验证/question-aggregate/full/question-aggregate__430x932__full.png)

- 视口 `834x1194`
![question-aggregate-834x1194](../../第一阶段_html细化/html截图验证/question-aggregate/full/question-aggregate__834x1194__full.png)

---

## 组件详情

### top-frame

![question-aggregate-top-frame](../../第一阶段_html细化/html截图验证/question-aggregate/components/top-frame__390x844.png)

- 功能说明: 返回与题号标题。
- 布局契约: 位于页面上方固定区域，不与正文内容重叠。
- 输入/输出: 输入: `pageData.top-frame`。输出: 可触发路由跳转: globalExam。

### single-question-dashboard

![question-aggregate-single-question-dashboard](../../第一阶段_html细化/html截图验证/question-aggregate/components/single-question-dashboard__390x844.png)

- 功能说明: 做题次数、正确率、预测得分。
- 布局契约: 统计卡区域位于内容前段，数值与摘要信息需要稳定对齐。
- 响应式规范: 窄屏自动换行排列卡片，平板维持单列分组不跳层。
- 输入/输出: 输入: `pageData.single-question-dashboard`。输出: 无跨页跳转。

### exam-analysis

![question-aggregate-exam-analysis](../../第一阶段_html细化/html截图验证/question-aggregate/components/exam-analysis__390x844.png)

- 功能说明: 态度与关联薄弱信息。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染并保持上下间距一致。
- 响应式规范: 在不同宽度下保持单列结构，允许容器宽度自适应。
- 输入/输出: 输入: `pageData.exam-analysis`。输出: 无跨页跳转。

### question-history-list

![question-aggregate-question-history-list](../../第一阶段_html细化/html截图验证/question-aggregate/components/question-history-list__390x844.png)

- 功能说明: 该题号历史题目列表。
- 布局契约: 列表区采用自然文档流纵向扩展，列表增长后应推动后续区域下移。
- 响应式规范: 在窄屏保持单列；在长屏增加可视条目但不改变信息层级。
- 输入/输出: 输入: `pageData.question-history-list`。输出: 可触发路由跳转: questionDetail。
