# EchoMind Flutter App（迁移骨架版）

本目录是从 `html前端——component纯净组件拆解版` 迁移出来的 Flutter 前端骨架。

## 已完成
1. Flutter 项目初始化（`flutter create`）。
2. 20 个页面路由接入（18 核心页 + 2 占位页）。
3. 统一页面壳层（TopFrame / StageNav / BottomTab / ActionOverlay）。
4. 按功能区块复刻页面模块（Dashboard/List/Tree/Heatmap/Chat/Table/Flashcard）。
5. 静态检查与测试通过（`flutter analyze`、`flutter test`）。

## 目录说明
```text
lib/
  app/
    app.dart
    app_routes.dart
    app_router.dart
  features/
    feature_page.dart
    specs/
      page_spec.dart
      page_specs.dart
  shared/
    theme/app_theme.dart
    widgets/
      main_bottom_nav.dart
      page_shell.dart
      section_blocks.dart
flutterw.bat                # Flutter 命令包装器（本机 FVM 路径）
```

## 运行方式
优先使用项目内包装器：

```powershell
.\flutterw.bat pub get
.\flutterw.bat run -d windows
```

如果你想直接用 Flutter SDK：

```powershell
C:\Users\Administrator\fvm\versions\stable\bin\flutter.bat run -d windows
```

常用检查：

```powershell
.\flutterw.bat analyze
.\flutterw.bat test
```

## 下一步（逐页精修）
1. 首页 `home`：按 HTML 精确调整卡片间距与图表样式。
2. `global-exam`：热力图改为参数驱动绘制（CustomPainter）。
3. `knowledge-learning` / `model-training`：把每个 step 卡独立成 Widget 文件。
4. `upload-history`：改为分组列表 + 吸顶日期头。
5. `prediction-center`：折线图与提分表格细化为真实数据模型。
