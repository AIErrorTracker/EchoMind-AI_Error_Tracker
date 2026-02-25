# model-training（模型训练）

## 设计目的

分阶段完成模型训练闭环。

## 路由标识

`modelTraining`

## 组件树

```text
model-training
├─ top-frame
├─ step-stage-nav
├─ step-1-identification-training
├─ step-2-decision-training
├─ step-3-equation-training
├─ step-4-trap-analysis
├─ step-5-complete-solve
├─ step-6-variation-training
├─ training-dialogue
└─ action-overlay
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。阶段导航为粘性层，切换步骤只替换步骤卡，不重建对话区。底部浮层固定贴底，主内容预留底部安全区，避免按钮被遮挡。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- 来源: `model-detail` (mastery-dashboard) / `ai-diagnosis` (main-content)
- 返回: `model-detail`

## 页面截图

- 视口 `390x844`
![model-training-390x844](../../第一阶段_html细化/html截图验证/model-training/full/model-training__390x844__full.png)

- 视口 `430x932`
![model-training-430x932](../../第一阶段_html细化/html截图验证/model-training/full/model-training__430x932__full.png)

- 视口 `834x1194`
![model-training-834x1194](../../第一阶段_html细化/html截图验证/model-training/full/model-training__834x1194__full.png)

---

## 组件详情

### top-frame

![model-training-top-frame](../../第一阶段_html细化/html截图验证/model-training/components/top-frame__390x844.png)

- 功能说明: 返回与训练标题。
- 布局契约: 位于页面上方固定区域，不与正文内容重叠。
- 输入/输出: 输入: `pageData.top-frame`。输出: 可触发路由跳转: modelDetail。

### step-stage-nav

![model-training-step-stage-nav](../../第一阶段_html细化/html截图验证/model-training/components/step-stage-nav__390x844.png)

- 功能说明: 阶段导航组件，用于切换学习/训练步骤状态。
- 布局契约: 顶部粘性区域，切换步骤仅替换步骤卡，不重建对话区。
- 响应式规范: 窄屏允许横向滚动或压缩间距，保持可点击性。
- 输入/输出: 输入: `pageData.step-stage-nav`。输出: 页内状态切换。

### training-dialogue

![model-training-training-dialogue](../../第一阶段_html细化/html截图验证/model-training/components/training-dialogue__390x844.png)

- 功能说明: 固定对话训练区（步骤切换不替换该区域）。
- 布局契约: 对话主体位于主滚动区，需与底部输入区解耦，避免输入条遮挡消息。
- 响应式规范: 窄屏优先消息可读；长屏扩大对话可视高度。
- 输入/输出: 输入: `pageData.training-dialogue`。输出: 无跨页跳转。

### step-1 ~ step-6 步骤卡

| 步骤 | 截图 | 状态截图 |
|------|------|----------|
| step-1 识别训练 | ![](../../第一阶段_html细化/html截图验证/model-training/components/step-1-identification-training__390x844.png) | ![](../../第一阶段_html细化/html截图验证/model-training/components/step-1-identification-training__state-step-1__390x844.png) |
| step-2 决策训练 | ![](../../第一阶段_html细化/html截图验证/model-training/components/step-2-decision-training__390x844.png) | ![](../../第一阶段_html细化/html截图验证/model-training/components/step-2-decision-training__state-step-2__390x844.png) |
| step-3 列式训练 | ![](../../第一阶段_html细化/html截图验证/model-training/components/step-3-equation-training__390x844.png) | ![](../../第一阶段_html细化/html截图验证/model-training/components/step-3-equation-training__state-step-3__390x844.png) |
| step-4 陷阱辨析 | ![](../../第一阶段_html细化/html截图验证/model-training/components/step-4-trap-analysis__390x844.png) | ![](../../第一阶段_html细化/html截图验证/model-training/components/step-4-trap-analysis__state-step-4__390x844.png) |
| step-5 完整求解 | ![](../../第一阶段_html细化/html截图验证/model-training/components/step-5-complete-solve__390x844.png) | ![](../../第一阶段_html细化/html截图验证/model-training/components/step-5-complete-solve__state-step-5__390x844.png) |
| step-6 变式训练 | ![](../../第一阶段_html细化/html截图验证/model-training/components/step-6-variation-training__390x844.png) | ![](../../第一阶段_html细化/html截图验证/model-training/components/step-6-variation-training__state-step-6__390x844.png) |

- 布局契约: 功能块位于页面主内容区，跟随文档流渲染并保持上下间距一致。
- 交互模型: 只切换顶部 step 卡片，下面对话区保持不变。

### action-overlay

![model-training-action-overlay](../../第一阶段_html细化/html截图验证/model-training/components/action-overlay__390x844.png)

- 功能说明: 底部浮层交互组件（输入框/FAB/发送）。
- 布局契约: 固定贴底显示，需与主内容留出安全区。
- 输入/输出: 输入: `pageData.action-overlay`。输出: 无跨页跳转。
