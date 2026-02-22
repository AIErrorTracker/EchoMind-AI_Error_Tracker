# weekly-review（周复盘）

## 设计目的

周维度复盘与下周规划。

## 路由标识

`weeklyReview`

## 组件树

```text
weekly-review
├─ top-frame
├─ weekly-dashboard
├─ score-change
├─ weekly-progress
└─ next-week-focus
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- 来源: `profile` (three-row-navigation)
- 返回: `profile`

## 页面截图

- 视口 `390x844`
![weekly-review-390x844](../../第一阶段_html细化/html截图验证/weekly-review/full/weekly-review__390x844__full.png)

- 视口 `430x932`
![weekly-review-430x932](../../第一阶段_html细化/html截图验证/weekly-review/full/weekly-review__430x932__full.png)

- 视口 `834x1194`
![weekly-review-834x1194](../../第一阶段_html细化/html截图验证/weekly-review/full/weekly-review__834x1194__full.png)

---

## 组件详情

### top-frame

![weekly-review-top-frame](../../第一阶段_html细化/html截图验证/weekly-review/components/top-frame__390x844.png)

- 功能说明: 返回与周次信息。
- 输入/输出: 输入: `pageData.top-frame`。输出: 可触发路由跳转: profile。

### weekly-dashboard

![weekly-review-weekly-dashboard](../../第一阶段_html细化/html截图验证/weekly-review/components/weekly-dashboard__390x844.png)

- 功能说明: 本周总览数据。
- 布局契约: 统计卡区域位于内容前段，数值与摘要信息需要稳定对齐。

### score-change

![weekly-review-score-change](../../第一阶段_html细化/html截图验证/weekly-review/components/score-change__390x844.png)

- 功能说明: 分数前后对比。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染。

### weekly-progress

![weekly-review-weekly-progress](../../第一阶段_html细化/html截图验证/weekly-review/components/weekly-progress__390x844.png)

- 功能说明: 本周进展条目。
- 布局契约: 列表区采用自然文档流纵向扩展。

### next-week-focus

![weekly-review-next-week-focus](../../第一阶段_html细化/html截图验证/weekly-review/components/next-week-focus__390x844.png)

- 功能说明: 下周重点建议。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染。
