import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/responsive.dart';
import '../../../mock/mock_data.dart';

class VideoPlayerPage extends StatelessWidget {
  const VideoPlayerPage({super.key, required this.item});

  final VideoItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('视频播放')),
      body: ResponsiveBox(
        padding: EdgeInsets.zero,
        maxWidth: 900,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final controlTop = constraints.maxHeight - 54;

                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [item.colorA, item.colorB], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(color: Colors.white.withValues(alpha: .35), shape: BoxShape.circle),
                            child: const Icon(Icons.pause_rounded, color: Colors.white, size: 34),
                          ),
                        ),
                        _roundButton(Icons.volume_off_rounded, 16, controlTop),
                        _roundButton(Icons.fullscreen_rounded, null, controlTop, right: 16),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: const TextStyle(fontSize: 15, color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.circle, size: 8, color: Colors.green),
                      SizedBox(width: 6),
                      Text('在线', style: TextStyle(color: Colors.green, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roundButton(IconData icon, double? left, double top, {double? right}) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(color: Colors.black.withValues(alpha: .28), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
