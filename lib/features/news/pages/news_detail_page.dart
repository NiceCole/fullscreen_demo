import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/responsive.dart';
import '../../../mock/mock_data.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('行业动态')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
        children: [
          ResponsiveBox(
            padding: EdgeInsets.zero,
            maxWidth: 760,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('中国中煤模块栈桥首次实现海外应用', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, height: 1.35)),
                const SizedBox(height: 8),
                const Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    Text('来源：中国中煤', style: TextStyle(color: AppColors.primary, fontSize: 12)),
                    Text('2026-07-07 10:46:21发布', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 12),
                for (var i = 0; i < articleParagraphs.length; i++) ...[
                  if (i == 1) const _ArticleImage(),
                  Text(articleParagraphs[i], style: const TextStyle(fontSize: 16, color: AppColors.textPrimary, height: 1.75)),
                  const SizedBox(height: 14),
                ],
                const Text('背景链接', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                const Text(
                  '“中煤雷奥”成套式模块栈桥是第四代新型工业栈桥，广泛应用于矿山、电力、港口、化工等领域，提升运输系统的工业动脉。',
                  style: TextStyle(fontSize: 16, color: AppColors.textPrimary, height: 1.75),
                ),
                const SizedBox(height: 20),
                const Text('阅读 2000', style: TextStyle(color: AppColors.textTertiary, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleImage extends StatelessWidget {
  const _ArticleImage();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          gradient: const LinearGradient(
            colors: [Color(0xFFBFE5FF), Color(0xFFEEF5F0), Color(0xFFC3D69B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomPaint(painter: _IndustrialPainter()),
      ),
    );
  }
}

class _IndustrialPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFB7CDA1);
    canvas.drawRect(Rect.fromLTWH(0, size.height * .66, size.width, size.height * .34), paint);
    paint.color = const Color(0xFF8BA98B);
    canvas.drawRect(Rect.fromLTWH(size.width * .1, size.height * .52, size.width * .75, 12), paint);
    paint.color = const Color(0xFF596A5E);
    canvas.drawRect(Rect.fromLTWH(size.width * .72, size.height * .25, 12, size.height * .42), paint);
    paint.color = const Color(0xFF6E7D70);
    canvas.drawRect(Rect.fromLTWH(size.width * .82, size.height * .15, 18, size.height * .52), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
