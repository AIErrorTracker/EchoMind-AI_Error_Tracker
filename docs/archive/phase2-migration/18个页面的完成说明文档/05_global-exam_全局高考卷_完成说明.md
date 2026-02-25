# 05 global-exam 全局高考卷 — 完成说明

## 实现的组件列表

| 组件 | 文件 | 状态 |
|------|------|------|
| top-frame | `widgets/top_frame_widget.dart` | 已完成 |
| exam-heatmap | `widgets/exam_heatmap_widget.dart` | 已完成 |
| question-type-browser | `widgets/question_type_browser_widget.dart` | 已完成 |
| recent-exams | `widgets/recent_exams_widget.dart` | 已完成 |

## 与截图的差异说明

热力图使用 Wrap + 彩色方块实现，含图例。题型浏览和最近卷子均为卡片列表。

## 路由跳转验证结果

| 触发位置 | 目标路由 | 验证 |
|----------|----------|------|
| 知识点tab | globalKnowledge | OK |
| 模型tab | globalModel | OK |
| 热力图方块 | questionAggregate | OK |
| 题型项 | questionAggregate | OK |
| 最近卷子项 | uploadHistory | OK |

## 已知问题或遗留项

无。

## 截图验证

- 截图文件：`../截图验证/all_pages/07_global_exam.png`
- 验证方式：Windows 桌面集成测试 (`OffsetLayer.toImage`)
- 验证结果：所有组件正常渲染，布局完整，无报错。
