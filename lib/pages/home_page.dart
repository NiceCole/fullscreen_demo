import 'package:flutter/material.dart';

import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<_QuickEntry> _entries = const [
    _QuickEntry('工作项分配', '任务分配，目标明确', Icons.assignment_rounded, Color(0xFFFF6B6B)),
    _QuickEntry('定工定分', '明确职责，量化考核', Icons.fact_check_rounded, Color(0xFF2B9BF4)),
    _QuickEntry('工分统计', '绩效清晰，工分累积', Icons.bar_chart_rounded, Color(0xFF33C7BE)),
    _QuickEntry('发布通知', '重要通知，一键发送', Icons.campaign_rounded, Color(0xFF7B61FF)),
    _QuickEntry('每日一题', '知识充电，每日精进', Icons.menu_book_rounded, Color(0xFFFF6F91)),
    _QuickEntry('计划进度', '项目追踪，进度可视', Icons.pie_chart_rounded, Color(0xFFFFA63D)),
    _QuickEntry('隐患排查治理', '安全预警，隐患速报', Icons.description_rounded, Color(0xFF25C6DA)),
    _QuickEntry('培训学习', '技能提升，在线学习', Icons.cast_for_education_rounded, Color(0xFF8B5CF6)),
    _QuickEntry('更多功能', '支持扩展更多能力', Icons.grid_view_rounded, Color(0xFF42A5F5)),
  ];

  final List<_TodoItem> _todos = const [
    _TodoItem('领取任务', '8月12日中班的任务还没有领取，请及时处理。', '08/12 12:46:38', Icons.campaign_rounded, Color(0xFF56A8F5)),
    _TodoItem('学习任务', '每日一题尚未完成，点击进入继续学习。', '08/12 12:46:38', Icons.auto_stories_rounded, Color(0xFFFFA726)),
    _TodoItem('签到提醒', '今日还未签到，请尽快完成班前签到。', '08/12 12:46:38', Icons.event_available_rounded, Color(0xFF35C759)),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final crossAxisCount = _resolveGridCount(size.width);
    final horizontalPadding = size.width >= 900 ? 32.0 : 16.0;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _HeaderSection(
              onMessageTap: _openDetail,
              onNoticeTap: _openDetail,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 0),
            sliver: SliverToBoxAdapter(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _entries.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: size.width >= 700 ? 1.2 : 0.92,
                ),
                itemBuilder: (context, index) {
                  final entry = _entries[index];
                  return _EntryCard(entry: entry, onTap: _openDetail);
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(horizontalPadding, 24, horizontalPadding, 12),
              child: Row(
                children: [
                  const Text(
                    '待办任务',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E2432),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _openDetail,
                    child: const Text('查看全部'),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 100),
            sliver: SliverList.separated(
              itemCount: _todos.length,
              itemBuilder: (context, index) => _TodoCard(item: _todos[index], onTap: _openDetail),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
          if (index != 0) {
            _openDetail();
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: '首页'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: '消息'),
          NavigationDestination(icon: Icon(Icons.apps_outlined), selectedIcon: Icon(Icons.apps), label: '工作台'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }

  int _resolveGridCount(double width) {
    if (width >= 1024) return 5;
    if (width >= 768) return 4;
    if (width >= 520) return 3;
    return 2;
  }

  void _openDetail() {
    Navigator.of(context).pushNamed(DetailPage.routeName);
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({required this.onMessageTap, required this.onNoticeTap});

  final VoidCallback onMessageTap;
  final VoidCallback onNoticeTap;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.sizeOf(context).width >= 900 ? 32.0 : 16.0;

    return Container(
      padding: EdgeInsets.fromLTRB(padding, 18, padding, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2B67F6), Color(0xFF88A4F6)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.location_on_rounded, color: Colors.white, size: 22),
                const SizedBox(width: 6),
                const Expanded(
                  child: Text(
                    '郑煤集团大平煤矿',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onNoticeTap,
                  icon: const Icon(Icons.search_rounded, color: Colors.white, size: 30),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: onMessageTap,
                      icon: const Icon(Icons.mark_chat_unread_outlined, color: Colors.white, size: 28),
                    ),
                    Positioned(
                      top: 10,
                      right: 12,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),
            GestureDetector(
              onTap: onNoticeTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.96),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Row(
                  children: [
                    Text(
                      '公告',
                      style: TextStyle(
                        color: Color(0xFF2B67F6),
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '2024年中秋节假期安排通知',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF1E2432),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({required this.entry, required this.onTap});

  final _QuickEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [entry.color, entry.color.withValues(alpha: 0.75)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: entry.color.withValues(alpha: 0.22),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(entry.icon, color: Colors.white, size: 28),
              ),
              const Spacer(),
              Text(
                entry.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF1E2432),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                entry.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF667085),
                  fontSize: 13,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodoCard extends StatelessWidget {
  const _TodoCard({required this.item, required this.onTap});

  final _TodoItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(item.icon, color: item.color, size: 30),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E2432),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.time,
                          style: const TextStyle(
                            color: Color(0xFF667085),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF667085),
                        fontSize: 14,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickEntry {
  const _QuickEntry(this.title, this.subtitle, this.icon, this.color);

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
}

class _TodoItem {
  const _TodoItem(this.title, this.description, this.time, this.icon, this.color);

  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color color;
}
