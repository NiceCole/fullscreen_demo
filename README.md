# 班组 APP 首页 Demo

## 项目目标

本 Demo 基于参考设计稿实现了一个可演示的纯前端移动端方案：

- Flutter 负责首页首屏，优先保证加载速度与交互稳定性。
- H5 负责详情页，方便后续内容快速迭代。
- 当前版本不依赖任何接口，所有数据均为本地静态 mock。
- 目标设备包含手机、折叠手机、平板，并支持 iOS 真机预演示。

## 已实现内容

### 1. 首页

参考 `D:\work\cad\班组设计图(1)\班组APP\首页@2x.png` 的信息结构，完成了以下模块：

- 顶部蓝色品牌头图
- 公告通知条
- 9 宫格功能入口
- 待办任务列表
- 底部导航栏

首页由 Flutter 原生组件绘制，避免首屏依赖 WebView，从而尽可能优化秒开体验。

### 2. 详情页

详情页使用本地 H5 文件 `assets/html/detail.html` 承载，并通过 `webview_flutter` 在 Flutter 中打开。

这样做的好处：

- 保证首页仍然是 Flutter 原生渲染
- 详情内容可以继续走前端页面化开发
- 后续接入接口时改造成本较低

## 目录结构

```text
fullscreen_demo/
├─ assets/
│  └─ html/
│     └─ detail.html
├─ lib/
│  ├─ main.dart
│  └─ pages/
│     ├─ detail_page.dart
│     └─ home_page.dart
├─ analysis_options.yaml
├─ pubspec.yaml
└─ README.md
```

## 关键实现说明

### 首屏性能策略

首页性能优先的核心策略如下：

1. 首页全部使用 Flutter 原生组件渲染，不在首屏引入 WebView。
2. 页面数据本地内置，避免启动阶段等待接口或远程配置。
3. 卡片结构与列表结构保持轻量，减少复杂绘制和深层嵌套。
4. 详情页延迟到用户点击后再打开，避免影响首页首帧。

### 适配策略

首页通过屏幕宽度断点控制宫格列数：

- 小屏手机：2 列
- 大屏手机 / 折叠态：3 列
- 小平板：4 列
- 大平板：5 列

同时在以下位置做了自适应处理：

- 顶部区块使用 `SafeArea`
- 横向边距按屏宽变化
- 标题与卡片文本支持截断
- H5 详情页使用响应式布局与 `viewport-fit=cover`

## 运行方式

### 前提

需要本机已安装 Flutter SDK，且能够执行 `flutter --version`。

当前我所在的环境没有可用的 Flutter CLI，因此本次未能直接替你运行构建和真机调试，但工程代码已经按标准 Flutter 结构组织完成。

### 本地启动

```bash
flutter pub get
flutter run
```

### 当前电脑预览方式

本电脑已在项目目录内安装本地 Flutter SDK：

```text
D:\work\fullscreen_demo\flutter
```

当前可直接预览 Web 版：

```bash
flutter\bin\flutter.bat build web
node scripts\serve-web.mjs
```

然后打开：

```text
http://localhost:51731
```

也可以直接运行：

```bash
run-web.bat
```

说明：本机当前缺少 Android SDK 和 Visual Studio C++ 工具链，所以暂时优先使用 Chrome/Web 方式预览。后续如果要运行 Android 模拟器或 Windows 桌面版，需要继续安装对应工具链。

### iOS 真机预演示

在 macOS + Xcode + Flutter 环境下：

```bash
flutter pub get
flutter run -d <ios-device-id>
```

如果首次运行 iOS 工程，通常还需要：

1. 打开 `ios/Runner.xcworkspace`
2. 配置开发者签名
3. 在真机上信任开发者证书

## 后续建议

如果你准备继续往可交付版本推进，建议下一步按这个顺序扩展：

1. 补齐标准 Flutter 工程目录（`ios/`、`android/`、`web/` 等）
2. 将设计稿中的图标替换成正式视觉资源
3. 为 H5 详情页补充多个业务模板
4. 等接口文档明确后，再接入真实数据层

## 技术选型补充

### 是否需要改用 uni-app

当前阶段不建议改成 uni-app。

原因很直接：

- 你这次最看重的是首页首屏性能
- 需要在 iOS 真机上做稳定演示
- 当前只做一个首页 demo，不是大规模业务页面铺设

在这个场景下，Flutter 更合适。

### Flutter 和 uni-app 的区别

`Flutter` 更偏性能和体验优先：

- 使用原生风格渲染
- 首屏和动画表现通常更好
- 复杂布局一致性更强

`uni-app` 更偏开发效率优先：

- 前端团队更容易上手
- 多端复用更方便
- 适合快速铺业务页面

结合本项目，建议继续采用：

- Flutter 做首页
- H5 做详情页

这样能同时兼顾首屏体验和后续迭代效率。

## 本次说明

本次按照你的要求，只实现了一个首页内容 demo，用于方案演示和真机预览准备，不包含后端接口、不包含完整业务闭环、不包含全部页面还原。
