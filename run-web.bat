@echo off
setlocal
cd /d "%~dp0"
set "FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn"
set "PUB_HOSTED_URL=https://pub.flutter-io.cn"
flutter\bin\flutter.bat build web
node scripts\serve-web.mjs
