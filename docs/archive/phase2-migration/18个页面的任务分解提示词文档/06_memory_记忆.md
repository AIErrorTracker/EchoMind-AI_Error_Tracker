# 任务 06：memory 记忆（已完成 — 验证与补齐）

> 开始前请先阅读 `00_总起说明_每个任务必读.md`

## 任务目标

记忆页已基本实现，本任务为验证与补齐。

## 参考资料

- 页面说明：`docs/第二阶段_html转flutter/18个html页面的分别说明文档/06_memory_记忆.md`
- 页面截图：`docs/第一阶段_html细化/html截图验证/memory/full/memory__390x844__full.png`
- 组件截图：`docs/第一阶段_html细化/html截图验证/memory/components/`

## 目标文件

- `echomind_app/lib/features/memory/memory_page.dart`
- `echomind_app/lib/features/memory/widgets/` 下所有组件

## 组件清单

| 组件 | 功能 | 跳转 |
|------|------|------|
| top-frame | 记忆页标题 | 无 |
| review-dashboard | 待复习数量与复习统计 | flashcardReview |
| card-category-list | 按卡片类别管理复习任务 | 无 |

## 页面结构

```
PageShell(tabIndex: 2) → ListView [TopFrame, ReviewDashboard, CardCategoryList]
```

## 输出要求

1. **截图留档**：保存页面效果截图到 `docs/第二阶段_html转flutter/截图验证/06_memory_记忆_完成效果.png`
2. **完成说明**：创建 `docs/第二阶段_html转flutter/18个页面的完成说明文档/06_memory_记忆_完成说明.md`，内容包括：实现的组件列表、与截图的差异说明、路由跳转验证结果、已知问题或遗留项
3. **拉起下一任务**：完成后自动读取 `07_flashcard-review_闪卡复习.md` 并开始执行下一个页面的工作流

---

# 附录：页面说明文档（memory 记忆）

## 设计目的

进入复习与管理卡片体系。

## 路由标识

`memory`

## 组件树

```text
memory
├─ top-frame
├─ review-dashboard
└─ card-category-list
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- `memory` -> `flashcard-review`

## 页面截图

- 视口 `390x844`
![memory-390x844](../../第一阶段_html细化/html截图验证/memory/full/memory__390x844__full.png)

- 视口 `430x932`
![memory-430x932](../../第一阶段_html细化/html截图验证/memory/full/memory__430x932__full.png)

- 视口 `834x1194`
![memory-834x1194](../../第一阶段_html细化/html截图验证/memory/full/memory__834x1194__full.png)

---

## 组件详情

### top-frame

![memory-top-frame](../../第一阶段_html细化/html截图验证/memory/components/top-frame__390x844.png)

- 功能说明: 页面顶栏组件，承载返回、标题和顶部导航语义。
- 布局契约: 位于页面上方固定区域，不与正文内容重叠。
- 输入/输出: 输入: `pageData.top-frame`。输出: 无跨页跳转。

### review-dashboard

![memory-review-dashboard](../../第一阶段_html细化/html截图验证/memory/components/review-dashboard__390x844.png)

- 功能说明: 待复习数量与复习统计。
- 布局契约: 统计卡区域位于内容前段，数值与摘要信息需要稳定对齐。
- 响应式规范: 窄屏自动换行排列卡片，平板维持单列分组不跳层。
- 输入/输出: 输入: `pageData.review-dashboard`。输出: 可触发路由跳转: flashcardReview。

### card-category-list

![memory-card-category-list](../../第一阶段_html细化/html截图验证/memory/components/card-category-list__390x844.png)

- 功能说明: 按卡片类别管理复习任务。
- 布局契约: 列表区采用自然文档流纵向扩展，列表增长后应推动后续区域下移。
- 响应式规范: 在窄屏保持单列；在长屏增加可视条目但不改变信息层级。
- 输入/输出: 输入: `pageData.card-category-list`。输出: 无跨页跳转。
