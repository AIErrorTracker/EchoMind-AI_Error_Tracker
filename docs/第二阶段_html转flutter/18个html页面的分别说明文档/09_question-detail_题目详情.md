# question-detail（题目详情）

## 设计目的

单题详情与诊断入口。

## 路由标识

`questionDetail`

## 组件树

```text
question-detail
├─ top-frame
├─ question-content
├─ answer-result
├─ question-relations
└─ question-source
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- 来源: `question-aggregate` / `upload-history`
- 去向: `ai-diagnosis` (answer-result) / `knowledge-detail` / `model-detail` (question-relations)

## 页面截图

- 视口 `390x844`
![question-detail-390x844](../../第一阶段_html细化/html截图验证/question-detail/full/question-detail__390x844__full.png)

- 视口 `430x932`
![question-detail-430x932](../../第一阶段_html细化/html截图验证/question-detail/full/question-detail__430x932__full.png)

- 视口 `834x1194`
![question-detail-834x1194](../../第一阶段_html细化/html截图验证/question-detail/full/question-detail__834x1194__full.png)

---

## 组件详情

### top-frame

![question-detail-top-frame](../../第一阶段_html细化/html截图验证/question-detail/components/top-frame__390x844.png)

- 功能说明: 返回与标题。
- 布局契约: 位于页面上方固定区域，不与正文内容重叠。
- 输入/输出: 输入: `pageData.top-frame`。输出: 可触发路由跳转: questionAggregate。

### question-content

![question-detail-question-content](../../第一阶段_html细化/html截图验证/question-detail/components/question-content__390x844.png)

- 功能说明: 题干/题图内容。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染并保持上下间距一致。
- 响应式规范: 在不同宽度下保持单列结构，允许容器宽度自适应。
- 输入/输出: 输入: `pageData.question-content`。输出: 无跨页跳转。

### answer-result

![question-detail-answer-result](../../第一阶段_html细化/html截图验证/question-detail/components/answer-result__390x844.png)

- 功能说明: 对错状态与进入诊断入口。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染并保持上下间距一致。
- 输入/输出: 输入: `pageData.answer-result`。输出: 可触发路由跳转: aiDiagnosis。

### question-relations

![question-detail-question-relations](../../第一阶段_html细化/html截图验证/question-detail/components/question-relations__390x844.png)

- 功能说明: 归属模型与关联知识点。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染并保持上下间距一致。
- 输入/输出: 输入: `pageData.question-relations`。输出: 可触发路由跳转: knowledgeDetail、modelDetail。

### question-source

![question-detail-question-source](../../第一阶段_html细化/html截图验证/question-detail/components/question-source__390x844.png)

- 功能说明: 来源卷子、题号、分值、态度。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染并保持上下间距一致。
- 输入/输出: 输入: `pageData.question-source`。输出: 无跨页跳转。
