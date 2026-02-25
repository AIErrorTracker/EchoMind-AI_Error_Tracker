# flashcard-review（闪卡复习）

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
