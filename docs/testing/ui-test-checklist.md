# EchoMind 前端自动化测试规范（Flutter）

> 文档位置：`docs/testing/ui-test-checklist.md`
> 
> 版本：v2.0（重构版）
> 
> 更新日期：2026-02-28
> 
> 适用对象：开发、测试、项目管理（含非测试背景成员）

## 1. 文档目标与适用范围

本规范用于建立 EchoMind 前端的标准化测试流程，覆盖：

- 需要测试什么（测试范围）
- 用什么环境测试（环境要求）
- 如何做自动化测试（脚本规范）
- 如何做真机测试与 APK 打包（发布前验收）
- 何时允许提测、何时允许发布（质量门禁）

适用项目：`D:\AI\AI+high school homework\EchoMind-AI_Error_Tracker\echomind_app`

---

## 2. 当前项目现状（基线）

基于当前仓库代码与命令执行结果（2026-02-28）确认：

1. 当前是 Flutter 项目，已包含 `test/` 与 `integration_test/`。
2. `flutter test` 目前失败，主要原因：
   - `test/widget_test.dart` 仍引用已不存在的 `MyApp`。
   - `test/screenshot_test.dart` 依赖绝对路径 golden 文件，且未完成基线管理。
   - 部分测试受 `SharedPreferences`、`google_fonts` 运行时加载影响，稳定性不足。
3. `integration_test/screenshot_22_pages_test.dart` 在 Windows 目标可跑通。
4. 项目目录当前缺少 `android/`，暂不具备直接打 APK 的条件。

结论：

- 自动化测试框架“有基础，但不达标”。
- 需要按本规范先做“测试工程化整改”，再进入稳定迭代。

---

## 3. 测试策略（软件工程规范）

采用“测试金字塔 + 发布门禁”策略：

1. `Unit Test`（单元测试）
   - 目标：验证纯逻辑（模型转换、工具函数、Provider 业务逻辑）
   - 特点：快、稳定、覆盖面高
2. `Widget Test`（组件/页面测试）
   - 目标：验证页面渲染、交互、状态变化、错误态
   - 特点：比集成测试快，适合回归主力
3. `Integration Test`（集成测试）
   - 目标：验证真实路由流、核心端到端流程
   - 特点：更接近真实用户，但执行慢
4. `Manual Real Device`（真机人工测试）
   - 目标：验证摄像头、相册、权限、弱网、安装升级等自动化难覆盖项

发布前必须同时满足自动化与人工验收，不能只依赖其中一类。

---

## 4. 测试范围与覆盖要求

### 4.1 核心业务流（必须覆盖）

1. 认证流：注册、登录、token 跳转
2. 导航流：5 个底部 Tab 与主要详情页跳转
3. 上传流：拍照/相册选择、上传成功与失败提示
4. 学习流：知识点详情、模型详情、错题详情、复习页面
5. 个人中心流：统计数据、入口导航
6. 异常流：接口超时、断网、空数据、非法参数 ID

### 4.2 页面覆盖基线

已识别路由共 22 个，应至少保证：

- 100% 路由“可进入 + 不崩溃”自动化覆盖
- 核心页面（登录、首页、上传、错题、个人中心）具备交互断言
- Demo/占位页至少有 smoke（可渲染）测试

### 4.3 非功能覆盖

1. 性能：冷启动、页面首屏可交互时间
2. 兼容：不同 Android 版本与分辨率
3. 稳定性：连续操作、前后台切换、弱网与断网
4. 安全：release 包不可含调试日志与测试开关

---

## 5. 环境要求

### 5.1 本地开发/测试环境

1. Flutter SDK：`>= 3.27.0`（建议与当前环境对齐为 `3.41.2`）
2. Dart SDK：与 Flutter 捆绑
3. JDK：`17+`（当前环境为 JDK 21，可用）
4. Android SDK：建议 API 34 及以上
5. 可用设备：至少 1 台模拟器或真机

### 5.2 后端与网络环境

1. API 基地址（当前代码）：`http://8.130.16.212:8001/api`
2. 健康检查：`GET http://8.130.16.212:8001/health`
3. 测试前要求：后端可访问、测试账号可登录、基础测试数据可用

### 5.3 测试数据要求

建议准备至少 3 类账号：

1. 新用户（几乎无数据）
2. 普通用户（有上传、错题、学习记录）
3. 边界用户（异常数据、空数据、历史脏数据）

---

## 6. 自动化测试执行规范

### 6.1 目录与命名规范

1. 单元测试：`test/unit/*_test.dart`
2. 组件测试：`test/widget/*_test.dart`
3. 集成测试：`integration_test/*_test.dart`
4. 文件命名：`feature_action_expected_test.dart`

### 6.2 脚本结构规范（AAA）

每个测试遵循：

1. Arrange：初始化依赖、mock、页面
2. Act：执行用户动作
3. Assert：验证结果

每个测试必须至少有 1 条有效断言，禁止“只跑不验”。

### 6.3 EchoMind 项目专用稳定性规则

1. 涉及路由鉴权时，必须显式设置 `SharedPreferences.setMockInitialValues(...)`。
2. 禁止在测试里依赖绝对路径截图（不可移植）。
3. 禁止依赖在线字体拉取；测试环境需关闭 runtime fetching。
4. 若页面存在无限动画，避免直接 `pumpAndSettle()`，改为固定帧 `pump`。
5. 尽量用 `Key` 定位组件，避免用易变化文本定位。

### 6.4 推荐命令（本地）

```bash
cd echomind_app
flutter pub get
flutter analyze
flutter test --coverage
flutter test integration_test/screenshot_22_pages_test.dart -d windows
```

说明：

- 当前仓库下 `flutter test` 仍会因旧测试脚本失败，需要先整改历史脚本。
- 集成测试可先用 `windows` 作为 smoke 基线，后续补 Android 真机/模拟器。

---

## 7. 自动化测试脚本编写模板

### 7.1 Widget 测试模板（推荐）

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:echomind_app/main.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({'auth_token': 'test_token'});
  });

  testWidgets('home smoke renders', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: EchoMindApp()));

    // 避免无限动画导致 pumpAndSettle 卡住
    for (var i = 0; i < 12; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(find.text('首页'), findsOneWidget);
  });
}
```

### 7.2 Integration 测试模板（核心流）

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:echomind_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('auth + navigation smoke', (tester) async {
    SharedPreferences.setMockInitialValues({'auth_token': 'test_token'});

    await tester.pumpWidget(const EchoMindApp());
    for (var i = 0; i < 15; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(find.text('首页'), findsOneWidget);

    await tester.tap(find.text('我的'));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(find.text('个人中心'), findsWidgets);
  });
}
```

### 7.3 Golden/Screenshot 规范

1. 基线目录使用相对路径，例如：`test/goldens/`。
2. 变更 UI 后，必须说明“是预期视觉更新”再更新基线。
3. screenshot 测试不替代功能断言，二者都要有。

---

## 8. APK 打包与真机测试规范

### 8.1 前置条件（当前项目必须先做）

当前 `echomind_app` 缺少 `android/` 目录，先补齐 Android 平台：

```bash
cd echomind_app
flutter create --platforms=android .
```

补齐后再执行 APK 打包。

### 8.2 构建命令

```bash
# 调试包
flutter build apk --debug

# 发布包（通用）
flutter build apk --release

# 按 ABI 拆分（减小包体）
flutter build apk --release --split-per-abi

# 商店分发建议
flutter build appbundle --release
```

产物路径（默认）：

- APK：`build/app/outputs/flutter-apk/`
- AAB：`build/app/outputs/bundle/release/`

### 8.3 Release 签名要求

1. 必须使用 keystore 签名，禁止 debug key 上线。
2. `key.properties` 不入库（加入 `.gitignore`）。
3. 签名信息由项目负责人保管，至少 2 人可恢复。

### 8.4 真机测试设备矩阵（最小集）

至少覆盖：

1. Android 10（API 29）
2. Android 12（API 31/32）
3. Android 14+（API 34+）

每个系统至少 1 台机型（优先覆盖不同厂商：小米/华为/OPPO/vivo/三星）。

### 8.5 真机验收清单（发布前必须通过）

1. 安装与启动：首次安装、覆盖安装、卸载重装
2. 权限流程：相机、相册权限申请与拒绝后的提示
3. 上传能力：拍照上传、相册上传、失败重试
4. 网络场景：Wi-Fi、4G/5G、断网、弱网
5. 生命周期：前后台切换、锁屏恢复
6. 稳定性：连续操作 15 分钟无崩溃
7. 日志：`adb logcat` 无高频 crash/ANR

---

## 9. 测试流程与质量门禁

### 9.1 提测准入（开发自检）

满足以下全部条件才可提测：

1. `flutter analyze` 通过
2. 新增/修改功能具备对应测试用例
3. 本地自动化测试通过（至少 smoke + 相关模块）
4. 代码评审通过

### 9.2 发布准出（测试验收）

满足以下全部条件才可发版：

1. P0/P1 缺陷为 0
2. P2 缺陷有明确规避与修复计划
3. 自动化回归通过率 100%
4. 真机验收清单全部通过
5. 发布包签名正确，可安装可回滚

---

## 10. 缺陷分级与报告模板

### 10.1 严重级别定义

1. P0：崩溃、无法登录、核心流程不可用
2. P1：核心功能可用但严重异常（高概率失败）
3. P2：非核心异常或有可行绕过方案
4. P3：UI 文案/样式问题，不影响主流程

### 10.2 标准缺陷模板

```text
【标题】[模块] 现象简述
【环境】设备/系统版本/网络类型/App 版本
【前置条件】账号、数据、权限状态
【复现步骤】
1. ...
2. ...
3. ...
【期望结果】...
【实际结果】...
【复现频率】必现/概率
【附件】截图、录屏、logcat、请求响应
```

---

## 11. 本项目下一步整改计划（建议按优先级）

1. 修复失效测试：`test/widget_test.dart` 改为 `EchoMindApp` 并补 mock。
2. 重构 screenshot 测试：改相对路径、建立 golden 基线管理。
3. 增加核心集成流：登录/导航/上传/错题详情 4 条主链路。
4. 补齐 Android 平台目录并建立 APK 打包流水线。
5. 将以上命令接入 CI（PR 阶段自动执行）。

---

## 12. 快速执行清单（给初学者）

1. 安装 Flutter 与 Android Studio，先执行 `flutter doctor -v`。
2. 进入 `echomind_app` 后执行 `flutter pub get`。
3. 跑静态检查：`flutter analyze`。
4. 跑自动化：`flutter test` 与 `flutter test integration_test/...`。
5. 若要真机 APK：先补 `android/`，再 `flutter build apk --release`。
6. 按“真机验收清单”逐项验证并记录缺陷。

> 说明：你当前仓库最先要做的是“修复旧测试 + 补 Android 平台”，否则自动化与 APK 流程都无法稳定落地。
