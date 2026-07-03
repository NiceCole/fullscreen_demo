import 'package:flutter/material.dart';

import 'pages/detail_page.dart';
import 'pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '班组 App Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2B67F6)),
        scaffoldBackgroundColor: const Color(0xFFF3F6FB),
        useMaterial3: true,
        fontFamily: 'PingFang SC',
      ),
      routes: {
        '/': (_) => const HomePage(),
        DetailPage.routeName: (_) => const DetailPage(),
      },
    );
  }
}
