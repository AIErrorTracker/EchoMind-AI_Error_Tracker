# 03 global-knowledge 全局知识点 — 完成说明

## 实现的组件列表

| 组件 | 文件 | 状态 |
|------|------|------|
| top-frame | `widgets/top_frame_widget.dart` | 已完成 |
| knowledge-tree | `widgets/knowledge_tree_widget.dart` | 已完成 |

## 与截图的差异说明

无显著偏差。三选栏(知识点/模型/考试)、学科筛选、三级可折叠知识树均与截图一致。

## 路由跳转验证结果

| 触发位置 | 目标路由 | 验证 |
|----------|----------|------|
| 模型tab | globalModel | OK |
| 考试tab | globalExam | OK |
| 知识点叶节点 | knowledgeDetail | OK |

## 已知问题或遗留项

无。

## 截图验证

- 截图文件：`../截图验证/all_pages/02_global_knowledge.png`
- 验证方式：Windows 桌面集成测试 (`OffsetLayer.toImage`)
- 验证结果：所有组件正常渲染，布局完整，无报错。
