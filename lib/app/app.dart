import 'package:flutter/material.dart';

import '../features/shell/pages/app_shell_page.dart';
import 'theme/app_theme.dart';

class ControlPlatformApp extends StatelessWidget {
  const ControlPlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '管控平台',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AppShellPage(),
    );
  }
}
