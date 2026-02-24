# prediction-center（预测中心）

## 设计目的

集中展示分数预测与提分路径。

## 路由标识

`predictionCenter`

## 组件树

```text
prediction-center
├─ top-frame
├─ score-card
├─ trend-card
├─ score-path-table
└─ priority-model-list
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- 来源: `index` (top-dashboard)
- 去向: `question-aggregate` (score-path-table) / `model-detail` (priority-model-list)

## 页面截图

- 视口 `390x844`
  ![prediction-center-390x844](../../第一阶段_html细化/html截图验证/prediction-center/full/prediction-center__390x844__full.png)
- 视口 `430x932`
  ![prediction-center-430x932](../../第一阶段_html细化/html截图验证/prediction-center/full/prediction-center__430x932__full.png)
- 视口 `834x1194`
  ![prediction-center-834x1194](../../第一阶段_html细化/html截图验证/prediction-center/full/prediction-center__834x1194__full.png)

---

## 组件详情

### top-frame

![prediction-center-top-frame](../../第一阶段_html细化/html截图验证/prediction-center/components/top-frame__390x844.png)

- 功能说明: 返回与标题。
- 输入/输出: 输入: `pageData.top-frame`。输出: 可触发路由跳转: home。

### score-card

![prediction-center-score-card](../../第一阶段_html细化/html截图验证/prediction-center/components/score-card__390x844.png)

- 功能说明: 预测分与目标差距。
- 布局契约: 统计卡区域位于内容前段，数值与摘要信息需要稳定对齐。
- 输入/输出: 输入: `pageData.score-card`。输出: 无跨页跳转。

### trend-card

![prediction-center-trend-card](../../第一阶段_html细化/html截图验证/prediction-center/components/trend-card__390x844.png)

- 功能说明: 预测分趋势（折线图）。
- 布局契约: 统计卡区域位于内容前段，数值与摘要信息需要稳定对齐。
- 输入/输出: 输入: `pageData.trend-card`。输出: 无跨页跳转。

### score-path-table

![prediction-center-score-path-table](../../第一阶段_html细化/html截图验证/prediction-center/components/score-path-table__390x844.png)

- 功能说明: 题号维度提分路径表。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染。
- 输入/输出: 输入: `pageData.score-path-table`。输出: 可触发路由跳转: questionAggregate。

![prediction-center-priority-model-list](../../第一阶段_html细化/html截图验证/prediction-center/components/priority-model-list__390x844.png)

- 功能说明: 优先训练模型列表。
- 布局契约: 列表区采用自然文档流纵向扩展。
- 输入/输出: 输入: `pageData.priority-model-list`。输出: 可触发路由跳转: modelDetail。
