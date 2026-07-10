import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/responsive.dart';

class PersonTrackPage extends StatelessWidget {
  const PersonTrackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('胡永国历史轨迹')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        children: const [
          ResponsiveBox(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _BaseInfoCard(),
                SizedBox(height: 10),
                _TrackCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BaseInfoCard extends StatelessWidget {
  const _BaseInfoCard();

  @override
  Widget build(BuildContext context) {
    return const AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('基础信息', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
          SizedBox(height: 14),
          _InfoLine('下井时间：', '2026-07-06 14:44:56'),
          _InfoLine('下井时长：', '2分30秒'),
          _InfoLine('所属部门：', '运输一队'),
          _InfoLine('所属分站：', '中央采区轨道上山二车场'),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text.rich(
        TextSpan(text: label, style: const TextStyle(color: AppColors.textSecondary), children: [
          TextSpan(text: value, style: const TextStyle(color: AppColors.textPrimary)),
        ]),
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}

class _TrackCard extends StatelessWidget {
  const _TrackCard();

  @override
  Widget build(BuildContext context) {
    const tracks = [
      ('中央采区轨道上山二车场', '14:50:05'),
      ('中央采区轨道上山底车场', '14:47:26'),
      ('副井底', '14:44:56'),
    ];
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('历史轨迹', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          for (var i = 0; i < tracks.length; i++)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(width: 7, height: 7, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                    if (i != tracks.length - 1) Container(width: 1, height: 52, color: AppColors.primary.withValues(alpha: 0.35)),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    color: const Color(0xFFF5F7FB),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tracks[i].$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                        const SizedBox(height: 4),
                        Text(tracks[i].$2, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
