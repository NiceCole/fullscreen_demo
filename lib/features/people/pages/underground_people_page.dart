import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/responsive.dart';
import '../../../mock/mock_data.dart';
import 'person_track_page.dart';

class UndergroundPeoplePage extends StatefulWidget {
  const UndergroundPeoplePage({super.key});

  @override
  State<UndergroundPeoplePage> createState() => _UndergroundPeoplePageState();
}

class _UndergroundPeoplePageState extends State<UndergroundPeoplePage> {
  int _tab = 0;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final groups = _tab == 0 ? stationGroups : departmentGroups;
    return Scaffold(
      appBar: AppBar(title: const Text('井下人员统计')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          ResponsiveBox(
            child: Column(
              children: [
                _Tabs(value: _tab, onChanged: (value) => setState(() => _tab = value)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                  child: _SearchBox(),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: _StatsCard(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: AppCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        for (var i = 0; i < groups.length; i++) ...[
                          _GroupRow(
                            group: groups[i],
                            expanded: _tab == 0 && i == 0 && _expanded,
                            onTap: () {
                              if (_tab == 0 && i == 0) {
                                setState(() => _expanded = !_expanded);
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PersonTrackPage()));
                              }
                            },
                          ),
                          if (_tab == 0 && i == 0 && _expanded) const _PersonGrid(),
                          if (i != groups.length - 1) const Divider(height: 1, color: AppColors.divider),
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

class _Tabs extends StatelessWidget {
  const _Tabs({required this.value, required this.onChanged});

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Colors.white,
      child: Row(
        children: [
          _tab('分站', 0),
          _tab('部门', 1),
        ],
      ),
    );
  }

  Widget _tab(String text, int index) {
    final active = value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              text,
              style: TextStyle(
                color: active ? AppColors.primary : AppColors.textPrimary,
                fontSize: 15,
                fontWeight: active ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Container(height: 2, color: active ? AppColors.primary : Colors.transparent),
          ],
        ),
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: const Row(
        children: [
          SizedBox(width: 10),
          Icon(Icons.search, color: AppColors.textTertiary, size: 18),
          SizedBox(width: 6),
          Text('输入姓名查找', style: TextStyle(color: AppColors.textTertiary, fontSize: 12)),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    const labels = ['总人数', '超时人数', '零点班', '八点班', '四点班'];
    const values = ['745', '0', '0', '489', '256'];
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.admin_panel_settings_outlined, size: 18),
              SizedBox(width: 4),
              Text('数据统计', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (var i = 0; i < labels.length; i++)
                Expanded(
                  child: Column(
                    children: [
                      Text(values[i], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 5),
                      Text(labels[i], style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GroupRow extends StatelessWidget {
  const _GroupRow({required this.group, required this.expanded, required this.onTap});

  final PersonGroup group;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: group.name,
                  children: [
                    TextSpan(text: ' [${group.count}人]', style: const TextStyle(color: AppColors.primary)),
                  ],
                ),
                style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
              ),
            ),
            Icon(expanded ? Icons.keyboard_arrow_down_rounded : Icons.chevron_right_rounded, size: 20),
          ],
        ),
      ),
    );
  }
}

class _PersonGrid extends StatelessWidget {
  const _PersonGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = Responsive.compactGridColumns(constraints.maxWidth);

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: peopleNames.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 9,
            crossAxisSpacing: 8,
            childAspectRatio: columns > 4 ? 2.6 : 2.25,
          ),
          itemBuilder: (context, index) => Container(
            alignment: Alignment.center,
            color: const Color(0xFFF4F6FA),
            child: Text(peopleNames[index], style: const TextStyle(fontSize: 14)),
          ),
        );
      },
    );
  }
}
