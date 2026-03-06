# EchoMind APK 打包与真机调试操作手册

> 文档路径：`docs/testing/apk-real-device-debug-guide.md`
>
> 更新时间：2026-02-28
>
> 适用项目：`echomind_app`（Flutter）

## 1. 本次实测结果（已执行）

### 1.1 实测环境

1. 主机系统：Windows 11
2. Flutter：3.41.2
3. 设备：`PGP110`（Android 15，API 35）
4. 设备 ID：`a1a9a75`

### 1.2 实测命令与结论

1. `flutter build apk --debug`：通过
2. `flutter build apk --release`：通过
3. `adb install -r app-debug.apk`：通过
4. `adb install -r app-release.apk`：通过
5. `flutter run -d a1a9a75 --debug --trace-startup`：通过
6. 首帧耗时（真机）：`734 ms`
7. 启动追踪文件：`echomind_app/build/start_up_info.json`

### 1.3 APK 产物路径

1. `echomind_app/build/app/outputs/flutter-apk/app-debug.apk`
2. `echomind_app/build/app/outputs/flutter-apk/app-release.apk`

---

## 2. 首次准备（只做一次）

### 2.1 手机端准备

1. 打开开发者选项（连续点击版本号）。
2. 开启 `USB 调试`。
3. 数据线连接电脑后，在手机弹窗中点 `允许 USB 调试`。

### 2.2 电脑端检查

在 `echomind_app` 目录执行：

```bash
flutter doctor -v
adb devices -l
flutter devices
```

判定标准：

1. `adb devices -l` 中设备状态为 `device`，不是 `unauthorized/offline`。
2. `flutter devices` 能看到 Android 手机设备。

---

## 3. APK 打包步骤

在 `echomind_app` 目录执行：

```bash
flutter pub get
flutter build apk --debug
flutter build apk --release
```

可选（减小包体）：

```bash
flutter build apk --release --split-per-abi
```

---

## 4. 真机安装与启动

### 4.1 安装 APK

```bash
adb -s <deviceId> install -r "build/app/outputs/flutter-apk/app-debug.apk"
adb -s <deviceId> install -r "build/app/outputs/flutter-apk/app-release.apk"
```

示例（本次设备）：

```bash
adb -s a1a9a75 install -r "build/app/outputs/flutter-apk/app-debug.apk"
```

### 4.2 启动 App

```bash
adb -s <deviceId> shell am start -n com.example.echomind_app/.MainActivity
```

说明：

1. 当前包名是 `com.example.echomind_app`。
2. 如果后续修改了 `applicationId`，这里要同步替换。

---

## 5. 真机调试方法

### 5.1 常规调试（交互式）

```bash
flutter run -d <deviceId> --debug
```

调试时常用命令：

1. `r`：热重载（Hot Reload）
2. `R`：热重启（Hot Restart）
3. `q`：退出调试

### 5.2 自动退出调试（适合 CI 或一次性验证）

```bash
flutter run -d <deviceId> --debug --trace-startup
```

执行后会自动退出，并输出：

1. 首帧时间
2. `build/start_up_info.json` 启动性能数据

### 5.3 调试自动登录（默认开启，推荐）

项目已支持“调试自动登录”，用于真机联调时自动拿到真实 `auth_token`。

默认账号（debug 环境）：

1. 手机号：`18222830713`
2. 密码：`yanbaojie00000`

作用：

1. 仅在 `debug` 生效，`release` 不生效。
2. 无 token 时会自动调用 `/auth/login` 并写入本地 token。
3. 这样进入业务页时，请求会带 `Authorization`，后端数据可正常加载。

示例 1：直接进入“我的”页（自动登录 + 指定路由）

```bash
flutter run -d <deviceId> --debug --route /profile
```

示例 2：覆盖默认自动登录账号

```bash
flutter run -d <deviceId> --debug --route /profile --dart-define=DEV_AUTO_LOGIN_PHONE=你的手机号 --dart-define=DEV_AUTO_LOGIN_PASSWORD=你的密码
```

示例 3：关闭自动登录（回到手动登录）

```bash
flutter run -d <deviceId> --debug --dart-define=DEV_AUTO_LOGIN=false
```

说明：

1. `--route` 可用于快速定位单页回归测试。
2. 详情页参数必须符合路由格式（如 `/model-detail/<id>`）。
3. `DEV_BYPASS_AUTH=true` 仍可用，但那种方式没有 token，不适合联调后端数据。

---

## 6. 日志与问题定位

### 6.1 Flutter 日志

```bash
flutter logs -d <deviceId>
```

### 6.2 ADB 日志

```bash
adb -s <deviceId> logcat
```

只看当前应用（Windows PowerShell）：

```powershell
adb -s <deviceId> logcat | Select-String "com.example.echomind_app"
```

---

## 7. 常见问题与处理

### 7.1 `device unauthorized`

1. 重新插拔数据线。
2. 手机端重新确认 USB 调试授权。
3. 执行 `adb kill-server && adb start-server`。

### 7.2 `INSTALL_FAILED_VERSION_DOWNGRADE`

1. 先卸载旧包：

```bash
adb -s <deviceId> uninstall com.example.echomind_app
```

2. 再安装新包。

### 7.3 App 能安装但打不开网络

1. 检查后端地址是否可访问。
2. 检查 Android 明文 HTTP 配置（若用 `http://`，需允许 cleartext）。
3. 真机浏览器直接访问健康检查接口确认联通性。

### 7.4 真机调试启动慢

1. 首次安装是正常现象。
2. 第二次起通常明显变快。
3. 可用 `--trace-startup` 持续记录首帧数据做对比。

---

## 8. 发布前提醒（必须）

1. 当前 `release` 默认使用 debug 签名，仅用于测试。
2. 上线前必须改为正式 keystore 签名。
3. 建议将 `applicationId` 改为正式包名（非 `com.example.*`）。

---

## 9. 一键复现命令清单

```bash
cd echomind_app
flutter pub get
adb devices -l
flutter devices
flutter build apk --debug
flutter build apk --release
adb -s <deviceId> install -r "build/app/outputs/flutter-apk/app-debug.apk"
flutter run -d <deviceId> --debug --trace-startup
```
