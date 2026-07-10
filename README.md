# 管控平台手机端

基于 Flutter 实现的管控平台移动端静态页面工程。当前阶段主要根据蓝湖设计稿还原移动端 UI，接口尚未接入，页面数据暂时使用本地 mock。

## 项目名称

- 应用名称：管控平台手机端
- Flutter 包名：`control_platform_mobile`
- 当前定位：纯 Flutter 移动端 UI 静态页面

## 目录结构

```text
control_platform_mobile/
├─ android/                    # Android 工程
├─ ios/                        # iOS 工程
├─ web/                        # Flutter Web 预览入口
├─ lib/
│  ├─ main.dart                # 应用入口
│  ├─ app/
│  │  ├─ app.dart              # MaterialApp 配置
│  │  └─ theme/                # 全局主题、颜色
│  ├─ core/
│  │  └─ widgets/              # 公共组件
│  │     ├─ app_card.dart
│  │     ├─ responsive.dart
│  │     ├─ section_header.dart
│  │     └─ status_tag.dart
│  ├─ features/
│  │  ├─ shell/                # 底部导航/平板侧边导航
│  │  ├─ home/                 # 首页
│  │  ├─ message/              # 消息中心
│  │  ├─ people/               # 井下人员统计、轨迹
│  │  ├─ news/                 # 行业动态列表、详情
│  │  ├─ video/                # 海康视频列表、播放
│  │  ├─ profile/              # 个人中心
│  │  └─ workbench/            # 工作台
│  └─ mock/
│     └─ mock_data.dart        # 静态 mock 数据
├─ .vscode/
│  ├─ launch.json              # VS Code Flutter 启动配置
│  └─ settings.json            # 保存自动热重载配置
├─ pubspec.yaml
└─ README.md
```

## 开发约定

- 新页面放在 `lib/features/<模块名>/pages/`。
- 公共 UI 组件放在 `lib/core/widgets/`。
- 全局颜色和主题放在 `lib/app/theme/`。
- 静态 mock 数据放在 `lib/mock/mock_data.dart`。
- 普通列表、详情、表单页面外层优先使用 `ResponsiveBox`，保证手机、折叠屏、平板都有合理宽度。

## 启动方式

### 1. 安装依赖

```bash
flutter pub get
```

### 2. 查看可运行设备

```bash
flutter devices
```

### 3. Chrome 预览

```bash
flutter run -d chrome
```

### 4. Android 真机或模拟器

```bash
flutter run
```

如果有多个设备，可以指定设备 ID：

```bash
flutter run -d <device-id>
```

## VS Code 热重载

项目已提供 VS Code 配置：

```text
.vscode/launch.json
.vscode/settings.json
```

使用方式：

1. VS Code 打开项目根目录。
2. 安装 `Flutter` 和 `Dart` 插件。
3. 在 Run and Debug 中选择 `Flutter - Chrome` 或 `Flutter - Android / Selected Device`。
4. 按 `F5` 启动。
5. 修改 `.dart` 文件并保存，会自动触发 Hot Reload。

终端运行时也可以手动触发：

```text
r  # 热重载，保留当前页面状态
R  # 热重启，重置应用状态
q  # 退出运行
```

说明：修改普通 UI、padding、颜色、文字时通常热重载即可；修改入口、全局状态、路由结构、构造参数时建议热重启。

## 当前状态

- 已实现首页、消息中心、工作台、个人中心等主要静态页面。
- 已加入基础响应式适配，覆盖手机、折叠屏和平板宽度。
- 暂未接入后端接口，后续接口明确后再补充数据层和请求封装。
