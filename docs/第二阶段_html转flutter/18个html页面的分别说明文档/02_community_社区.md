# community（社区）

## 设计目的

收集需求与改进建议。

## 路由标识

`community`

## 组件树

```text
community
├─ top-frame-and-tabs
├─ board-my-requests
├─ board-feature-boost
└─ board-feedback
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面截图

- 视口 `390x844`
![community-390x844](../../第一阶段_html细化/html截图验证/community/full/community__390x844__full.png)

- 视口 `430x932`
![community-430x932](../../第一阶段_html细化/html截图验证/community/full/community__430x932__full.png)

- 视口 `834x1194`
![community-834x1194](../../第一阶段_html细化/html截图验证/community/full/community__834x1194__full.png)

---

## 组件详情

### top-frame-and-tabs

![community-top-frame-and-tabs](../../第一阶段_html细化/html截图验证/community/components/top-frame-and-tabs__390x844.png)

- 功能说明: 社区页顶栏与三选栏组合组件，负责板块切换入口。
- 布局契约: 顶部区域固定，内容区由当前tab内容承载。
- 超长文本/数字规范: tab标题单行省略，避免挤压点击区域。
- 响应式规范: 宽屏下等比分配tab宽度，窄屏保持可读和可点。
- 输入/输出: 输入: `pageData.top-frame-and-tabs`。输出: 无跨页跳转，页内展示/状态切换。

### board-my-requests

![community-board-my-requests](../../第一阶段_html细化/html截图验证/community/components/board-my-requests__390x844.png)

- 状态 `tab-0`
![community-board-my-requests-tab-0](../../第一阶段_html细化/html截图验证/community/components/board-my-requests__state-tab-0__390x844.png)

- 功能说明: 我的需求列表。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染并保持上下间距一致。
- 响应式规范: 在不同宽度下保持单列结构，允许容器宽度自适应。
- 输入/输出: 输入: `pageData.board-my-requests`。输出: 无跨页跳转。

### board-feature-boost

- 状态 `tab-1`
![community-board-feature-boost-tab-1](../../第一阶段_html细化/html截图验证/community/components/board-feature-boost__state-tab-1__390x844.png)

- 功能说明: 新功能加速板块。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染并保持上下间距一致。
- 响应式规范: 在不同宽度下保持单列结构，允许容器宽度自适应。
- 输入/输出: 输入: `pageData.board-feature-boost`。输出: 无跨页跳转。

### board-feedback

- 状态 `tab-2`
![community-board-feedback-tab-2](../../第一阶段_html细化/html截图验证/community/components/board-feedback__state-tab-2__390x844.png)

- 功能说明: 改版建议板块。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染并保持上下间距一致。
- 响应式规范: 在不同宽度下保持单列结构，允许容器宽度自适应。
- 输入/输出: 输入: `pageData.board-feedback`。输出: 无跨页跳转。
