# 04 global-model 全局模型 — 完成说明

## 实现的组件列表

| 组件 | 文件 | 状态 |
|------|------|------|
| top-frame | `widgets/top_frame_widget.dart` | 已完成 |
| model-tree | `widgets/model_tree_widget.dart` | 已完成 |

## 与截图的差异说明

参照 global-knowledge 的实现模式，实现了可折叠模型树。模型分类（受力分析/运动学/能量守恒/电磁学）含子模型节点，每项带 Level 徽章。

## 路由跳转验证结果

| 触发位置 | 目标路由 | 验证 |
|----------|----------|------|
| 知识点tab | globalKnowledge | OK |
| 考试tab | globalExam | OK |
| 模型叶节点 | modelDetail | OK |

## 已知问题或遗留项

无。

## 截图验证

- 截图文件：`../截图验证/all_pages/06_global_model.png`
- 验证方式：Windows 桌面集成测试 (`OffsetLayer.toImage`)
- 验证结果：所有组件正常渲染，布局完整，无报错。
