import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/responsive.dart';
import '../../../core/widgets/section_header.dart';
import '../../../mock/mock_data.dart';

class WorkbenchPage extends StatelessWidget {
  const WorkbenchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = homeMenuPages.expand((page) => page).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('工作台')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 90),
        children: [
          ResponsiveBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                    child: const Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.search, size: 18, color: AppColors.textTertiary),
                        SizedBox(width: 6),
                        Text('搜索功能', style: TextStyle(color: AppColors.textTertiary, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                const SectionHeader(title: '全部应用'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AppCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        for (var i = 0; i < items.length; i++) ...[
                          ListTile(
                            leading: Icon(items[i].icon, color: items[i].color),
                            title: Text(items[i].title, style: const TextStyle(fontWeight: FontWeight.w800)),
                            subtitle: const Text('点击进入功能模块', style: TextStyle(color: AppColors.textSecondary)),
                            trailing: const Icon(Icons.chevron_right_rounded),
                          ),
                          if (i != items.length - 1) const Divider(height: 1, indent: 72, color: AppColors.divider),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
