# global-model（全局-模型）

## 设计目的

全局浏览模型/方法结构。

## 路由标识

`globalModel`

## 组件树

```text
global-model
├─ top-frame
└─ model-tree
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- `global-knowledge` <-> `global-model` <-> `global-exam`（顶部tab互切）
- `model-tree` -> `model-detail`

## 页面截图

- 视口 `390x844`
![global-model-390x844](../../第一阶段_html细化/html截图验证/global-model/full/global-model__390x844__full.png)

- 视口 `430x932`
![global-model-430x932](../../第一阶段_html细化/html截图验证/global-model/full/global-model__430x932__full.png)

- 视口 `834x1194`
![global-model-834x1194](../../第一阶段_html细化/html截图验证/global-model/full/global-model__834x1194__full.png)

---

## 组件详情

### top-frame

![global-model-top-frame](../../第一阶段_html细化/html截图验证/global-model/components/top-frame__390x844.png)

- 功能说明: 页面顶栏组件，承载返回、标题和顶部导航语义。
- 布局契约: 位于页面上方固定区域，不与正文内容重叠。
- 超长文本/数字规范: 标题单行省略，避免顶栏高度波动。
- 响应式规范: 不同宽度下保持左右安全边距与点击区域。
- 输入/输出: 输入: `pageData.top-frame`。输出: 可触发路由跳转: globalExam、globalKnowledge。

### model-tree

![global-model-model-tree](../../第一阶段_html细化/html截图验证/global-model/components/model-tree__390x844.png)

- 功能说明: 多层可折叠模型树组件，承载模型节点与子问题层级。
- 布局契约: 树结构展开后高度自增长，禁止固定高度裁剪内容。
- 超长文本/数字规范: 模型名称支持两行截断，必要时自动换行保留语义。
- 响应式规范: 不同宽度下保留层级缩进与节点间距，避免层级错位。
- 输入/输出: 输入: `pageData.model-tree`。输出: 可触发路由跳转: modelDetail。
