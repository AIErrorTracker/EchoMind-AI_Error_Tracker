# 任务 07：flashcard-review 闪卡复习（待实现）

> 开始前请先阅读 `00_总起说明_每个任务必读.md`

## 任务目标

将 flashcard-review 页面从 stub 实现为完整页面。核心是卡片翻转交互和记忆反馈按钮。

## 参考资料

- 页面说明：`docs/第二阶段_html转flutter/18个html页面的分别说明文档/07_flashcard-review_闪卡复习.md`
- 页面截图：`docs/第一阶段_html细化/html截图验证/flashcard-review/full/flashcard-review__390x844__full.png`
- 组件截图：`docs/第一阶段_html细化/html截图验证/flashcard-review/components/`

## 目标文件

- `echomind_app/lib/features/flashcard_review/flashcard_review_page.dart`
- `echomind_app/lib/features/flashcard_review/widgets/top_frame_widget.dart`
- `echomind_app/lib/features/flashcard_review/widgets/flashcard_widget.dart`

## 工作流

1. 读取页面说明文档，查看截图
2. 实现 TopFrameWidget：返回按钮 + 进度计数（如 "3/12"）
3. 实现 FlashcardWidget：卡片正反面翻转 + 底部三个反馈按钮（忘了/记得/简单）
4. 组装页面，对照截图自检

## 组件清单

| 组件 | 功能 | 跳转 |
|------|------|------|
| top-frame | 返回、进度与计数 | memory（返回） |
| flashcard | 卡片翻转 + 忘了/记得/简单反馈 | 无 |

## 页面结构

```
Scaffold → SafeArea → Column [TopFrame, Expanded(Flashcard)]
```

## 实现要点

- 卡片翻转可用 `AnimatedSwitcher` 或简单的正反面状态切换
- 底部三个按钮固定在卡片下方：忘了（红）、记得（蓝）、简单（绿）

## 输出要求

1. **截图留档**：保存页面效果截图到 `docs/第二阶段_html转flutter/截图验证/07_flashcard-review_闪卡复习_完成效果.png`
2. **完成说明**：创建 `docs/第二阶段_html转flutter/18个页面的完成说明文档/07_flashcard-review_闪卡复习_完成说明.md`，内容包括：实现的组件列表、与截图的差异说明、路由跳转验证结果、已知问题或遗留项
3. **拉起下一任务**：完成后自动读取 `08_question-aggregate_单题聚合.md` 并开始执行下一个页面的工作流

---

# 附录：页面说明文档（flashcard-review 闪卡复习）

## 设计目的

单卡复习与反馈打标。

## 路由标识

`flashcardReview`

## 组件树

```text
flashcard-review
├─ top-frame
└─ flashcard
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- 返回 `memory`

## 页面截图

- 视口 `390x844`
![flashcard-review-390x844](../../第一阶段_html细化/html截图验证/flashcard-review/full/flashcard-review__390x844__full.png)

- 视口 `430x932`
![flashcard-review-430x932](../../第一阶段_html细化/html截图验证/flashcard-review/full/flashcard-review__430x932__full.png)

- 视口 `834x1194`
![flashcard-review-834x1194](../../第一阶段_html细化/html截图验证/flashcard-review/full/flashcard-review__834x1194__full.png)

---

## 组件详情

### top-frame

![flashcard-review-top-frame](../../第一阶段_html细化/html截图验证/flashcard-review/components/top-frame__390x844.png)

- 功能说明: 返回、进度与计数。
- 布局契约: 位于页面上方固定区域，不与正文内容重叠。
- 输入/输出: 输入: `pageData.top-frame`。输出: 可触发路由跳转: memory。

### flashcard

![flashcard-review-flashcard](../../第一阶段_html细化/html截图验证/flashcard-review/components/flashcard__390x844.png)

- 功能说明: 卡片翻转与"忘了/记得/简单"反馈。
- 布局契约: 作为底部交互区固定贴底，主滚动内容必须避让，不得被覆盖。
- 响应式规范: 在窄屏优先保留输入与发送按钮可达；在宽屏单列拉伸输入区域。
- 输入/输出: 输入: `pageData.flashcard`。输出: 无跨页跳转，页内展示/状态切换。
