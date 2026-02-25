# 任务 05：global-exam 全局高考卷（待实现）

> 开始前请先阅读 `00_总起说明_每个任务必读.md`

## 任务目标

将 global-exam 页面从 stub 实现为完整页面。含热力图、题型浏览、最近卷子三个核心组件。

## 参考资料

- 页面说明：`docs/第二阶段_html转flutter/18个html页面的分别说明文档/05_global-exam_全局高考卷.md`
- 页面截图：`docs/第一阶段_html细化/html截图验证/global-exam/full/global-exam__390x844__full.png`
- 组件截图：`docs/第一阶段_html细化/html截图验证/global-exam/components/`
- 参考已完成页面：`echomind_app/lib/features/global_knowledge/`（顶部tab结构相似）

## 目标文件

- `echomind_app/lib/features/global_exam/global_exam_page.dart`
- `echomind_app/lib/features/global_exam/widgets/top_frame_widget.dart`
- `echomind_app/lib/features/global_exam/widgets/exam_heatmap_widget.dart`
- `echomind_app/lib/features/global_exam/widgets/question_type_browser_widget.dart`
- `echomind_app/lib/features/global_exam/widgets/recent_exams_widget.dart`

## 工作流

1. 读取页面说明文档，查看截图
2. 读取 global_knowledge 的 TopFrame 实现作为参考
3. 实现 TopFrameWidget：全局标题 + 三个子tab，当前高亮"高考卷"
4. 实现 ExamHeatmapWidget：题号热力图网格（用 Wrap + 小方块）
5. 实现 QuestionTypeBrowserWidget：按题型分组浏览列表
6. 实现 RecentExamsWidget：最近卷子入口列表
7. 组装页面，对照截图自检

## 组件清单

| 组件 | 功能 | 跳转 |
|------|------|------|
| top-frame | 全局标题与子tab，高亮"高考卷" | globalKnowledge, globalModel |
| exam-heatmap | 题号热力图网格 | questionAggregate |
| question-type-browser | 按题型分组浏览 | questionAggregate, uploadMenu |
| recent-exams | 最近卷子入口 | uploadHistory |

## 页面结构

```
Scaffold → SafeArea → ListView [TopFrame, ExamHeatmap, QuestionTypeBrowser, RecentExams]
```

## 输出要求

1. **截图留档**：保存页面效果截图到 `docs/第二阶段_html转flutter/截图验证/05_global-exam_全局高考卷_完成效果.png`
2. **完成说明**：创建 `docs/第二阶段_html转flutter/18个页面的完成说明文档/05_global-exam_全局高考卷_完成说明.md`，内容包括：实现的组件列表、与截图的差异说明、路由跳转验证结果、已知问题或遗留项
3. **拉起下一任务**：完成后自动读取 `06_memory_记忆.md` 并开始执行下一个页面的工作流

---

# 附录：页面说明文档（global-exam 全局高考卷）

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
