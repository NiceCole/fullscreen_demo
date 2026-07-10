@echo off
setlocal
cd /d "%~dp0"

set "FLUTTER_HOME=D:\tools\flutter"
set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
set "ANDROID_SDK_ROOT=%ANDROID_HOME%"
set "JAVA_HOME=C:\Program Files\Android\Android Studio\jbr"
set "FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn"
set "PUB_HOSTED_URL=https://pub.flutter-io.cn"
set "PATH=%FLUTTER_HOME%\bin;%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\cmdline-tools\latest\bin;%PATH%"

flutter devices
flutter run
