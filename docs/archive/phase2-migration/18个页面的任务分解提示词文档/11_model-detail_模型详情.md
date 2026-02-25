# 任务 11：model-detail 模型详情（待实现）

> 开始前请先阅读 `00_总起说明_每个任务必读.md`

## 任务目标

将 model-detail 页面从 stub 实现为完整页面。围绕模型展示掌握度、前置知识、关联题目和训练记录。

## 参考资料

- 页面说明：`docs/第二阶段_html转flutter/18个html页面的分别说明文档/11_model-detail_模型详情.md`
- 页面截图：`docs/第一阶段_html细化/html截图验证/model-detail/full/model-detail__390x844__full.png`
- 组件截图：`docs/第一阶段_html细化/html截图验证/model-detail/components/`

## 目标文件

- `echomind_app/lib/features/model_detail/model_detail_page.dart`
- `echomind_app/lib/features/model_detail/widgets/top_frame_widget.dart`
- `echomind_app/lib/features/model_detail/widgets/mastery_dashboard_widget.dart`
- `echomind_app/lib/features/model_detail/widgets/prerequisite_knowledge_list_widget.dart`
- `echomind_app/lib/features/model_detail/widgets/related_question_list_widget.dart`
- `echomind_app/lib/features/model_detail/widgets/training_record_list_widget.dart`

## 组件清单

| 组件 | 功能 | 跳转 |
|------|------|------|
| top-frame | 返回与模型名 | globalModel（返回） |
| mastery-dashboard | 掌握漏斗与训练入口 | modelTraining |
| prerequisite-knowledge-list | 前置知识点与补强建议 | knowledgeDetail |
| related-question-list | 关联题目列表 | questionDetail |
| training-record-list | 训练历史记录 | 无 |

## 页面结构

```
Scaffold → SafeArea → Column [
  TopFrame,
  Expanded(ListView [MasteryDashboard, PrerequisiteKnowledgeList, RelatedQuestionList, TrainingRecordList])
]
```

## 输出要求

1. **截图留档**：保存页面效果截图到 `docs/第二阶段_html转flutter/截图验证/11_model-detail_模型详情_完成效果.png`
2. **完成说明**：创建 `docs/第二阶段_html转flutter/18个页面的完成说明文档/11_model-detail_模型详情_完成说明.md`，内容包括：实现的组件列表、与截图的差异说明、路由跳转验证结果、已知问题或遗留项
3. **拉起下一任务**：完成后自动读取 `12_model-training_模型训练.md` 并开始执行下一个页面的工作流

---

# 附录：页面说明文档（model-detail 模型详情）

## 设计目的

围绕模型进行训练决策。

## 路由标识

`modelDetail`

## 组件树

```text
model-detail
├─ top-frame
├─ mastery-dashboard
├─ prerequisite-knowledge-list
├─ related-question-list
└─ training-record-list
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- 来源: `global-model` (model-tree) / `index` / `question-detail` (question-relations)
- 去向: `model-training` (mastery-dashboard) / `knowledge-detail` (prerequisite-knowledge-list) / `question-detail` (related-question-list)

## 页面截图

- 视口 `390x844`
![model-detail-390x844](../../第一阶段_html细化/html截图验证/model-detail/full/model-detail__390x844__full.png)

- 视口 `430x932`
![model-detail-430x932](../../第一阶段_html细化/html截图验证/model-detail/full/model-detail__430x932__full.png)

- 视口 `834x1194`
![model-detail-834x1194](../../第一阶段_html细化/html截图验证/model-detail/full/model-detail__834x1194__full.png)

---

## 组件详情

### top-frame

![model-detail-top-frame](../../第一阶段_html细化/html截图验证/model-detail/components/top-frame__390x844.png)

- 功能说明: 返回与模型名。
- 布局契约: 位于页面上方固定区域，不与正文内容重叠。
- 输入/输出: 输入: `pageData.top-frame`。输出: 可触发路由跳转: globalModel。

### mastery-dashboard

![model-detail-mastery-dashboard](../../第一阶段_html细化/html截图验证/model-detail/components/mastery-dashboard__390x844.png)

- 功能说明: 掌握漏斗与训练入口。
- 布局契约: 统计卡区域位于内容前段，数值与摘要信息需要稳定对齐。
- 响应式规范: 窄屏自动换行排列卡片，平板维持单列分组不跳层。
- 输入/输出: 输入: `pageData.mastery-dashboard`。输出: 可触发路由跳转: modelTraining。

### prerequisite-knowledge-list

![model-detail-prerequisite-knowledge-list](../../第一阶段_html细化/html截图验证/model-detail/components/prerequisite-knowledge-list__390x844.png)

- 功能说明: 前置知识点与补强建议。
- 布局契约: 列表区采用自然文档流纵向扩展，列表增长后应推动后续区域下移。
- 输入/输出: 输入: `pageData.prerequisite-knowledge-list`。输出: 可触发路由跳转: knowledgeDetail。

### related-question-list

![model-detail-related-question-list](../../第一阶段_html细化/html截图验证/model-detail/components/related-question-list__390x844.png)

- 功能说明: 关联题目列表。
- 布局契约: 列表区采用自然文档流纵向扩展，列表增长后应推动后续区域下移。
- 输入/输出: 输入: `pageData.related-question-list`。输出: 可触发路由跳转: questionDetail。

### training-record-list

![model-detail-training-record-list](../../第一阶段_html细化/html截图验证/model-detail/components/training-record-list__390x844.png)

- 功能说明: 训练历史记录。
- 布局契约: 列表区采用自然文档流纵向扩展，列表增长后应推动后续区域下移。
- 输入/输出: 输入: `pageData.training-record-list`。输出: 无跨页跳转。
