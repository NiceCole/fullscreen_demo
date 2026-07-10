import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../home/pages/home_page.dart';
import '../../message/pages/message_page.dart';
import '../../profile/pages/profile_page.dart';
import '../../workbench/pages/workbench_page.dart';

class AppShellPage extends StatefulWidget {
  const AppShellPage({super.key});

  @override
  State<AppShellPage> createState() => _AppShellPageState();
}

class _AppShellPageState extends State<AppShellPage> {
  int _currentIndex = 0;

  final _pages = const [
    HomePage(),
    MessagePage(),
    WorkbenchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth >= 900;

        if (useRail) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (index) => setState(() => _currentIndex = index),
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded),
                      label: Text('\u9996\u9875'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.notifications_none_rounded),
                      selectedIcon: Icon(Icons.notifications_rounded),
                      label: Text('\u6d88\u606f'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.inventory_2_outlined),
                      selectedIcon: Icon(Icons.inventory_2_rounded),
                      label: Text('\u5de5\u4f5c\u53f0'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline_rounded),
                      selectedIcon: Icon(Icons.person_rounded),
                      label: Text('\u4e2a\u4eba\u4e2d\u5fc3'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: IndexedStack(
                    index: _currentIndex,
                    children: _pages,
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          bottomNavigationBar: _MobileTabBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
          ),
        );
      },
    );
  }
}

class _MobileTabBar extends StatelessWidget {
  const _MobileTabBar({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 58,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFF0F2F6), width: 0.5)),
        ),
        child: Row(
          children: [
            _TabItem(index: 0, active: currentIndex == 0, label: '首页', kind: _TabIconKind.home, onTap: onTap),
            _TabItem(index: 1, active: currentIndex == 1, label: '消息', kind: _TabIconKind.message, onTap: onTap),
            _TabItem(index: 2, active: currentIndex == 2, label: '工作台', kind: _TabIconKind.workbench, onTap: onTap),
            _TabItem(index: 3, active: currentIndex == 3, label: '个人中心', kind: _TabIconKind.profile, onTap: onTap),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.index,
    required this.active,
    required this.label,
    required this.kind,
    required this.onTap,
  });

  final int index;
  final bool active;
  final String label;
  final _TabIconKind kind;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.primary : const Color(0xFFD8DDE3);
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TabIcon(kind: kind, color: color),
            const SizedBox(height: 3),
            Text(label, style: TextStyle(color: color, fontSize: 10, height: 1)),
          ],
        ),
      ),
    );
  }
}

enum _TabIconKind { home, message, workbench, profile }

class _TabIcon extends StatelessWidget {
  const _TabIcon({
    required this.kind,
    required this.color,
  });

  final _TabIconKind kind;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: _TabIconPainter(kind: kind, color: color)),
    );
  }
}

class _TabIconPainter extends CustomPainter {
  const _TabIconPainter({
    required this.kind,
    required this.color,
  });

  final _TabIconKind kind;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    switch (kind) {
      case _TabIconKind.home:
        _paintHome(canvas, size, paint);
        break;
      case _TabIconKind.message:
        _paintMessage(canvas, size, paint);
        break;
      case _TabIconKind.workbench:
        _paintWorkbench(canvas, size, paint);
        break;
      case _TabIconKind.profile:
        _paintProfile(canvas, size, paint);
        break;
    }
  }

  void _paintHome(Canvas canvas, Size size, Paint paint) {
    final path = Path()
      ..moveTo(size.width * 0.17, size.height * 0.43)
      ..lineTo(size.width * 0.5, size.height * 0.18)
      ..lineTo(size.width * 0.83, size.height * 0.43)
      ..lineTo(size.width * 0.83, size.height * 0.82)
      ..quadraticBezierTo(size.width * 0.83, size.height * 0.9, size.width * 0.75, size.height * 0.9)
      ..lineTo(size.width * 0.25, size.height * 0.9)
      ..quadraticBezierTo(size.width * 0.17, size.height * 0.9, size.width * 0.17, size.height * 0.82)
      ..close();
    canvas.drawPath(path, paint);

    final cutout = Paint()..color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.39, size.height * 0.62, size.width * 0.22, size.height * 0.055),
        const Radius.circular(2),
      ),
      cutout,
    );
  }

  void _paintMessage(Canvas canvas, Size size, Paint paint) {
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.45), size.width * 0.34, paint);
    final tail = Path()
      ..moveTo(size.width * 0.42, size.height * 0.72)
      ..lineTo(size.width * 0.33, size.height * 0.85)
      ..lineTo(size.width * 0.56, size.height * 0.74)
      ..close();
    canvas.drawPath(tail, paint);

    final dotPaint = Paint()..color = Colors.white.withValues(alpha: 0.92);
    for (final x in [0.38, 0.5, 0.62]) {
      canvas.drawCircle(Offset(size.width * x, size.height * 0.45), 1.25, dotPaint);
    }
  }

  void _paintWorkbench(Canvas canvas, Size size, Paint paint) {
    final top = Path()
      ..moveTo(size.width * 0.18, size.height * 0.32)
      ..lineTo(size.width * 0.5, size.height * 0.16)
      ..lineTo(size.width * 0.82, size.height * 0.32)
      ..lineTo(size.width * 0.5, size.height * 0.49)
      ..close();
    canvas.drawPath(top, paint..color = color.withValues(alpha: 0.9));

    final body = Path()
      ..moveTo(size.width * 0.19, size.height * 0.37)
      ..lineTo(size.width * 0.48, size.height * 0.53)
      ..lineTo(size.width * 0.48, size.height * 0.86)
      ..lineTo(size.width * 0.19, size.height * 0.7)
      ..close()
      ..moveTo(size.width * 0.52, size.height * 0.53)
      ..lineTo(size.width * 0.81, size.height * 0.37)
      ..lineTo(size.width * 0.81, size.height * 0.7)
      ..lineTo(size.width * 0.52, size.height * 0.86)
      ..close();
    canvas.drawPath(body, paint..color = color);

    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.45)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.5), Offset(size.width * 0.5, size.height * 0.84), linePaint);
  }

  void _paintProfile(Canvas canvas, Size size, Paint paint) {
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.34), size.width * 0.18, paint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.22, size.height * 0.58, size.width * 0.56, size.height * 0.25),
        Radius.circular(size.width * 0.13),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _TabIconPainter oldDelegate) {
    return oldDelegate.kind != kind || oldDelegate.color != color;
  }
}
