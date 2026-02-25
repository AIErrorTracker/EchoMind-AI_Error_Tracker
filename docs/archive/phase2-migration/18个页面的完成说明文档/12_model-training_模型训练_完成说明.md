# 12 model-training 模型训练 — 完成说明

## 实现的组件列表

| 组件 | 文件 | 状态 |
|------|------|------|
| top-frame | `widgets/top_frame_widget.dart` | 已完成 |
| step-stage-nav | `widgets/step_stage_nav_widget.dart` | 已完成 |
| step-1~6 通用卡 | `widgets/step1_identification_training_widget.dart` | 已完成（单文件+stepIndex参数） |
| training-dialogue | `widgets/training_dialogue_widget.dart` | 已完成 |
| action-overlay | `widgets/action_overlay_widget.dart` | 已完成 |

## 与截图的差异说明

6个步骤卡合并为一个通用组件，通过 stepIndex 参数切换内容。其余布局按截图实现。

## 路由跳转验证结果

| 触发位置 | 目标路由 | 验证 |
|----------|----------|------|
| 返回按钮 | pop | OK |

## 已知问题或遗留项

step2~step6 的独立 stub 文件未使用（页面使用通用组件替代）。

## 截图验证

- 截图文件：`../截图验证/all_pages/13_model_training.png`
- 验证方式：Windows 桌面集成测试 (`OffsetLayer.toImage`)
- 验证结果：所有组件正常渲染，布局完整，无报错。
