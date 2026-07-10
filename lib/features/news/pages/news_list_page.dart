import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/responsive.dart';
import '../../../mock/mock_data.dart';
import 'news_detail_page.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  int _tab = 0;
  final _tabs = const ['全部', '要闻', '行业动态', '新闻资讯'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('行业动态')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 18),
        children: [
          ResponsiveBox(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _tabs.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final active = _tab == index;
                      return GestureDetector(
                        onTap: () => setState(() => _tab = index),
                        child: Container(
                          width: 72,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: active ? AppColors.primary : Colors.white, borderRadius: BorderRadius.circular(3)),
                          child: Text(_tabs[index], style: TextStyle(color: active ? Colors.white : AppColors.textPrimary, fontSize: 12)),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 6),
                for (final item in news) ...[
                  AppCard(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NewsDetailPage())),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(color: item.type == '要闻' ? Colors.red : const Color(0xFFFFC107), shape: BoxShape.circle),
                              child: const Icon(Icons.volume_up_rounded, color: Colors.white, size: 12),
                            ),
                            const SizedBox(width: 6),
                            Text(item.type, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(item.title, style: const TextStyle(fontSize: 15, height: 1.35, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        Text('阅读 ${item.reads}    ${item.time}', style: const TextStyle(color: AppColors.textTertiary, fontSize: 12)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
