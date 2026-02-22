# model-detail（模型详情）

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
