# 任务 10：ai-diagnosis AI诊断（待实现）

> 开始前请先阅读 `00_总起说明_每个任务必读.md`

## 任务目标

将 ai-diagnosis 页面从 stub 实现为完整页面。对话式诊断页面，含题目引用、对话区、底部输入框。

## 参考资料

- 页面说明：`docs/第二阶段_html转flutter/18个html页面的分别说明文档/10_ai-diagnosis_AI诊断.md`
- 页面截图：`docs/第一阶段_html细化/html截图验证/ai-diagnosis/full/ai-diagnosis__390x844__full.png`
- 组件截图：`docs/第一阶段_html细化/html截图验证/ai-diagnosis/components/`
- 参考：home 页的 ActionOverlayWidget（底部浮层模式）

## 目标文件

- `echomind_app/lib/features/ai_diagnosis/ai_diagnosis_page.dart`
- `echomind_app/lib/features/ai_diagnosis/widgets/top_frame_widget.dart`
- `echomind_app/lib/features/ai_diagnosis/widgets/main_content_widget.dart`
- `echomind_app/lib/features/ai_diagnosis/widgets/action_overlay_widget.dart`

## 组件清单

| 组件 | 功能 | 跳转 |
|------|------|------|
| top-frame | 返回与标题 | questionDetail（返回） |
| main-content | 题目引用 + 诊断对话 + 结论与行动按钮 | modelTraining, questionDetail |
| action-overlay | 底部输入框 | 无 |

## 页面结构

```
Scaffold → SafeArea → Column [
  TopFrame,
  Expanded(MainContent),  // 对话滚动区
  ActionOverlay            // 固定底部输入框
]
```

## 实现要点

- 对话区用 ListView 展示消息气泡（AI 左侧、用户右侧）
- 顶部引用题目卡片
- 底部结论区含"开始训练"按钮跳转 modelTraining

## 输出要求

1. **截图留档**：保存页面效果截图到 `docs/第二阶段_html转flutter/截图验证/10_ai-diagnosis_AI诊断_完成效果.png`
2. **完成说明**：创建 `docs/第二阶段_html转flutter/18个页面的完成说明文档/10_ai-diagnosis_AI诊断_完成说明.md`，内容包括：实现的组件列表、与截图的差异说明、路由跳转验证结果、已知问题或遗留项
3. **拉起下一任务**：完成后自动读取 `11_model-detail_模型详情.md` 并开始执行下一个页面的工作流

---

# 附录：页面说明文档（ai-diagnosis AI诊断）

## 设计目的

对单题错误进行对话式定位。

## 路由标识

`aiDiagnosis`

## 组件树

```text
ai-diagnosis
├─ top-frame
├─ main-content
└─ action-overlay
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。底部浮层固定贴底，主内容预留底部安全区，避免按钮被遮挡。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- 来源: `question-detail` (answer-result) / `index` (recommendation-list)
- 去向: `model-training` (main-content) / `question-detail` (top-frame返回)

## 页面截图

- 视口 `390x844`
![ai-diagnosis-390x844](../../第一阶段_html细化/html截图验证/ai-diagnosis/full/ai-diagnosis__390x844__full.png)

- 视口 `430x932`
![ai-diagnosis-430x932](../../第一阶段_html细化/html截图验证/ai-diagnosis/full/ai-diagnosis__430x932__full.png)

- 视口 `834x1194`
![ai-diagnosis-834x1194](../../第一阶段_html细化/html截图验证/ai-diagnosis/full/ai-diagnosis__834x1194__full.png)

---

## 组件详情

### top-frame

![ai-diagnosis-top-frame](../../第一阶段_html细化/html截图验证/ai-diagnosis/components/top-frame__390x844.png)

- 功能说明: 返回与标题。
- 布局契约: 位于页面上方固定区域，不与正文内容重叠。
- 输入/输出: 输入: `pageData.top-frame`。输出: 可触发路由跳转: questionDetail。

### main-content

![ai-diagnosis-main-content](../../第一阶段_html细化/html截图验证/ai-diagnosis/components/main-content__390x844.png)

- 功能说明: 题目引用、诊断对话、结论与行动按钮。
- 布局契约: 对话主体位于主滚动区，需与底部输入区解耦，避免输入条遮挡消息。
- 响应式规范: 窄屏优先消息可读；长屏扩大对话可视高度。
- 输入/输出: 输入: `pageData.main-content`。输出: 可触发路由跳转: modelTraining、questionDetail。

### action-overlay

![ai-diagnosis-action-overlay](../../第一阶段_html细化/html截图验证/ai-diagnosis/components/action-overlay__390x844.png)

- 功能说明: 底部浮层交互组件（输入框/FAB/发送），负责关键动作入口。
- 布局契约: 固定贴底显示，需与主内容留出安全区，避免遮挡主操作按钮。
- 响应式规范: 在长屏/平板仍贴底，横向空间增大时输入框优先扩展宽度。
- 输入/输出: 输入: `pageData.action-overlay`。输出: 无跨页跳转。
