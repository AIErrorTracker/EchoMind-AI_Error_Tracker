# 任务 01：index 首页（已完成 — 验证与补齐）

> 开始前请先阅读 `00_总起说明_每个任务必读.md`

## 任务目标

首页已基本实现，本任务为验证与补齐。对照截图检查视觉还原度，修复偏差。

## 参考资料

- 页面说明：`docs/第二阶段_html转flutter/18个html页面的分别说明文档/01_index_首页.md`
- 页面截图：`docs/第一阶段_html细化/html截图验证/index/full/index__390x844__full.png`
- 组件截图：`docs/第一阶段_html细化/html截图验证/index/components/`

## 目标文件

- `echomind_app/lib/features/home/home_page.dart`
- `echomind_app/lib/features/home/widgets/top_frame_widget.dart`
- `echomind_app/lib/features/home/widgets/top_dashboard_widget.dart`
- `echomind_app/lib/features/home/widgets/recommendation_list_widget.dart`
- `echomind_app/lib/features/home/widgets/recent_upload_widget.dart`
- `echomind_app/lib/features/home/widgets/action_overlay_widget.dart`

## 工作流

1. 读取页面说明文档，查看截图
2. 读取现有 Flutter 实现代码
3. 逐组件对比截图，检查：布局结构、间距、颜色、文案、跳转
4. 修复发现的偏差
5. 确认路由跳转正确：`predictionCenter`、`aiDiagnosis`、`modelTraining`、`uploadHistory`、`uploadMenu`

## 组件清单

| 组件 | 功能 | 跳转 |
|------|------|------|
| top-frame | 状态栏与主页标题 | 无 |
| top-dashboard | 今日闭环/学习时长/预测分/快速开始 | predictionCenter, modelTraining |
| recommendation-list | 推荐诊断/训练/补强任务 | aiDiagnosis |
| recent-upload | 最近上传错题摘要 | uploadHistory |
| action-overlay | 悬浮上传与新建菜单 | uploadMenu |

## 页面结构

```
PageShell(tabIndex: 0) → Column → [
  Expanded(ListView [TopFrame, TopDashboard, RecommendationList, RecentUpload]),
  ActionOverlay
]
```

## 输出要求

1. **截图留档**：保存页面效果截图到 `docs/第二阶段_html转flutter/截图验证/01_index_首页_完成效果.png`
2. **完成说明**：创建 `docs/第二阶段_html转flutter/18个页面的完成说明文档/01_index_首页_完成说明.md`，内容包括：实现的组件列表、与截图的差异说明、路由跳转验证结果、已知问题或遗留项
3. **拉起下一任务**：完成后自动读取 `02_community_社区.md` 并开始执行下一个页面的工作流

---

# 附录：页面说明文档（index 首页）

## 设计目的

展示学习总览并提供闭环起点入口。

## 路由标识

`home`

## 组件树

```text
index
├─ top-frame
├─ top-dashboard
├─ recommendation-list
├─ recent-upload
└─ action-overlay
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。底部浮层固定贴底，主内容预留底部安全区，避免按钮被遮挡。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

跳转目标：`prediction-center` / `ai-diagnosis` / `model-detail` / `knowledge-detail` / `model-training` / `upload-history`

## 页面截图

- 视口 `390x844`
![index-390x844](../../第一阶段_html细化/html截图验证/index/full/index__390x844__full.png)

- 视口 `430x932`
![index-430x932](../../第一阶段_html细化/html截图验证/index/full/index__430x932__full.png)

- 视口 `834x1194`
![index-834x1194](../../第一阶段_html细化/html截图验证/index/full/index__834x1194__full.png)

---

## 组件详情

### top-frame

![index-top-frame](../../第一阶段_html细化/html截图验证/index/components/top-frame__390x844.png)

- 功能说明: 页面顶栏组件，承载返回、标题和顶部导航语义。
- 布局契约: 位于页面上方固定区域，不与正文内容重叠。
- 超长文本/数字规范: 标题单行省略，避免顶栏高度波动。
- 响应式规范: 不同宽度下保持左右安全边距与点击区域。
- 输入/输出: 输入: `pageData.top-frame` 与页面状态。输出: 无跨页跳转，主要为页内展示/状态切换。

### top-dashboard

![index-top-dashboard](../../第一阶段_html细化/html截图验证/index/components/top-dashboard__390x844.png)

- 功能说明: 核心信息展示与交互承接，统计卡区域。
- 布局契约: 统计卡区域位于内容前段，数值与摘要信息需要稳定对齐。
- 超长文本/数字规范: 标题建议单行省略；描述使用两行截断或自动换行；超长无空格词允许断词。
- 响应式规范: 窄屏自动换行排列卡片，平板维持单列分组不跳层。
- 输入/输出: 输入: `pageData.top-dashboard`。输出: 可触发路由跳转: modelTraining、predictionCenter。

### recommendation-list

![index-recommendation-list](../../第一阶段_html细化/html截图验证/index/components/recommendation-list__390x844.png)

- 功能说明: 推荐诊断/训练/补强任务列表。
- 布局契约: 列表区采用自然文档流纵向扩展，列表增长后应推动后续区域下移。
- 超长文本/数字规范: 标题建议单行省略；描述使用两行截断或自动换行。
- 响应式规范: 在窄屏保持单列；在长屏增加可视条目但不改变信息层级。
- 输入/输出: 输入: `pageData.recommendation-list`。输出: 可触发路由跳转: aiDiagnosis。

### recent-upload

![index-recent-upload](../../第一阶段_html细化/html截图验证/index/components/recent-upload__390x844.png)

- 功能说明: 最近上传错题摘要。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染并保持上下间距一致。
- 超长文本/数字规范: 标题建议单行省略；描述使用两行截断或自动换行。
- 响应式规范: 在不同宽度下保持单列结构，允许容器宽度自适应。
- 输入/输出: 输入: `pageData.recent-upload`。输出: 可触发路由跳转: uploadHistory。

### action-overlay

![index-action-overlay](../../第一阶段_html细化/html截图验证/index/components/action-overlay__390x844.png)

- 功能说明: 底部浮层交互组件（输入框/FAB/发送），负责关键动作入口。
- 布局契约: 固定贴底显示，需与主内容留出安全区，避免遮挡主操作按钮。
- 超长文本/数字规范: 输入占位文案使用单行省略；发送按钮文案保持短文本。
- 响应式规范: 在长屏/平板仍贴底，横向空间增大时输入框优先扩展宽度。
- 输入/输出: 输入: `pageData.action-overlay`。输出: 可触发路由跳转: uploadMenu。
