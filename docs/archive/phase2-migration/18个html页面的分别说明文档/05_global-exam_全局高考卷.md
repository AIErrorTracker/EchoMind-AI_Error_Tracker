# global-exam（全局-高考卷）

## 设计目的

以卷面视角进行提分诊断。

## 路由标识

`globalExam`

## 组件树

```text
global-exam
├─ top-frame
├─ exam-heatmap
├─ question-type-browser
└─ recent-exams
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- `global-knowledge` <-> `global-model` <-> `global-exam`（顶部tab互切）
- `exam-heatmap` / `question-type-browser` -> `question-aggregate`
- `recent-exams` -> `upload-history`

## 页面截图

- 视口 `390x844`
![global-exam-390x844](../../第一阶段_html细化/html截图验证/global-exam/full/global-exam__390x844__full.png)

- 视口 `430x932`
![global-exam-430x932](../../第一阶段_html细化/html截图验证/global-exam/full/global-exam__430x932__full.png)

- 视口 `834x1194`
![global-exam-834x1194](../../第一阶段_html细化/html截图验证/global-exam/full/global-exam__834x1194__full.png)

---

## 组件详情

### top-frame

![global-exam-top-frame](../../第一阶段_html细化/html截图验证/global-exam/components/top-frame__390x844.png)

- 功能说明: 页面顶栏组件，承载返回、标题和顶部导航语义。
- 布局契约: 位于页面上方固定区域，不与正文内容重叠。
- 输入/输出: 输入: `pageData.top-frame`。输出: 可触发路由跳转: globalKnowledge、globalModel。

### exam-heatmap

![global-exam-exam-heatmap](../../第一阶段_html细化/html截图验证/global-exam/components/exam-heatmap__390x844.png)

- 功能说明: 卷面热力图组件，基于题号与掌握状态渲染格子，参数变化会直接影响图形结果。
- 布局契约: 网格区域随容器宽度自适应换列，不允许固定列宽写死导致遮挡。
- 超长文本/数字规范: 格子内题号/分值保持短文本；图例说明使用自动换行，不省略关键含义。
- 响应式规范: 窄屏优先保证格子可点按；宽屏增加每行列数但保持触控面积。
- 输入/输出: 输入: `pageData.exam-heatmap`。输出: 可触发路由跳转: questionAggregate。

### question-type-browser

![global-exam-question-type-browser](../../第一阶段_html细化/html截图验证/global-exam/components/question-type-browser__390x844.png)

- 功能说明: 按题型分组浏览。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染并保持上下间距一致。
- 响应式规范: 在不同宽度下保持单列结构，允许容器宽度自适应。
- 输入/输出: 输入: `pageData.question-type-browser`。输出: 可触发路由跳转: questionAggregate、uploadMenu。

### recent-exams

![global-exam-recent-exams](../../第一阶段_html细化/html截图验证/global-exam/components/recent-exams__390x844.png)

- 功能说明: 最近卷子入口。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染并保持上下间距一致。
- 响应式规范: 在不同宽度下保持单列结构，允许容器宽度自适应。
- 输入/输出: 输入: `pageData.recent-exams`。输出: 可触发路由跳转: uploadHistory。
