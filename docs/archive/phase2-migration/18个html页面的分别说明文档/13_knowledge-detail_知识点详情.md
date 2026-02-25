# knowledge-detail（知识点详情）

## 设计目的

知识点掌握诊断与学习入口。

## 路由标识

`knowledgeDetail`

## 组件树

```text
knowledge-detail
├─ top-frame
├─ mastery-dashboard
├─ concept-test-records
└─ related-models
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- 来源: `global-knowledge` (knowledge-tree) / `model-detail` (prerequisite-knowledge-list) / `question-detail` (question-relations)
- 去向: `knowledge-learning` (mastery-dashboard) / `model-detail` (related-models)

## 页面截图

- 视口 `390x844`
![knowledge-detail-390x844](../../第一阶段_html细化/html截图验证/knowledge-detail/full/knowledge-detail__390x844__full.png)

- 视口 `430x932`
![knowledge-detail-430x932](../../第一阶段_html细化/html截图验证/knowledge-detail/full/knowledge-detail__430x932__full.png)

- 视口 `834x1194`
![knowledge-detail-834x1194](../../第一阶段_html细化/html截图验证/knowledge-detail/full/knowledge-detail__834x1194__full.png)

---

## 组件详情

### top-frame

![knowledge-detail-top-frame](../../第一阶段_html细化/html截图验证/knowledge-detail/components/top-frame__390x844.png)

- 功能说明: 返回与知识点标题。
- 布局契约: 位于页面上方固定区域，不与正文内容重叠。
- 输入/输出: 输入: `pageData.top-frame`。输出: 可触发路由跳转: globalKnowledge。

### mastery-dashboard

![knowledge-detail-mastery-dashboard](../../第一阶段_html细化/html截图验证/knowledge-detail/components/mastery-dashboard__390x844.png)

- 功能说明: 掌握度仪表与开始学习。
- 布局契约: 统计卡区域位于内容前段，数值与摘要信息需要稳定对齐。
- 响应式规范: 窄屏自动换行排列卡片，平板维持单列分组不跳层。
- 输入/输出: 输入: `pageData.mastery-dashboard`。输出: 可触发路由跳转: knowledgeLearning。

### concept-test-records

![knowledge-detail-concept-test-records](../../第一阶段_html细化/html截图验证/knowledge-detail/components/concept-test-records__390x844.png)

- 功能说明: 概念检测记录。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染并保持上下间距一致。
- 输入/输出: 输入: `pageData.concept-test-records`。输出: 无跨页跳转。

### related-models

![knowledge-detail-related-models](../../第一阶段_html细化/html截图验证/knowledge-detail/components/related-models__390x844.png)

- 功能说明: 关联模型列表。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染并保持上下间距一致。
- 输入/输出: 输入: `pageData.related-models`。输出: 可触发路由跳转: modelDetail。
