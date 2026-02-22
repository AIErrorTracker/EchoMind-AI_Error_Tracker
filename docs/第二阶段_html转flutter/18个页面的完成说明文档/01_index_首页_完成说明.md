# 01 index 首页 — 完成说明

## 实现的组件列表

| 组件 | 文件 | 状态 |
|------|------|------|
| top-frame | `widgets/top_frame_widget.dart` | 已完成 |
| top-dashboard | `widgets/top_dashboard_widget.dart` | 已完成 |
| recommendation-list | `widgets/recommendation_list_widget.dart` | 已完成 |
| recent-upload | `widgets/recent_upload_widget.dart` | 已完成 |
| action-overlay | `widgets/action_overlay_widget.dart` | 已完成 |

## 与截图的差异说明

逐组件对比 HTML 截图，未发现显著偏差：
- top-frame：大号粗体标题"主页"，间距正确
- top-dashboard：3个统计卡 + 预测分卡（含折线图 CustomPaint）+ 快速开始按钮，布局与截图一致
- recommendation-list：4条推荐项，图标/标题/标签/箭头均匹配
- recent-upload：卡片式摘要，文案与截图一致
- action-overlay：相机图标 + 输入框占位符 + 发送按钮，贴底布局正确

## 路由跳转验证结果

| 触发位置 | 目标路由 | 验证 |
|----------|----------|------|
| 预测分卡片 | predictionCenter | OK |
| 快速开始按钮 | modelTraining | OK |
| 推荐项1 | aiDiagnosis | OK |
| 推荐项2/4 | modelDetail | OK |
| 推荐项3 | knowledgeDetail | OK |
| 最近上传卡片 | uploadHistory | OK |
| 相机图标 | uploadMenu | OK |

## 已知问题或遗留项

无。页面实现与截图一致，无需修改。

## 截图验证

- 截图文件：`../截图验证/all_pages/01_home.png`
- 验证方式：Windows 桌面集成测试 (`OffsetLayer.toImage`)
- 验证结果：所有组件正常渲染，布局完整，无报错。
