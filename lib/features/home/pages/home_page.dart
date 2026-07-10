import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/responsive.dart';
import '../../../mock/mock_data.dart';
import '../../message/pages/message_page.dart';
import '../../news/pages/news_list_page.dart';
import '../../people/pages/underground_people_page.dart';
import '../../video/pages/video_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: _HomeHeader()),
        SliverToBoxAdapter(
          child: ResponsiveBox(
            child: _MenuPager(onTap: (item) => _openMenu(context, item)),
          ),
        ),
        SliverToBoxAdapter(
          child: ResponsiveBox(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: _NoticeCard(
                onMoreTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MessagePage(showScaffold: true))),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ResponsiveBox(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 24),
              child: _DutyCard(onMoreTap: () {}),
            ),
          ),
        ),
      ],
    );
  }

  void _openMenu(BuildContext context, MenuEntry item) {
    Widget? page;
    switch (item.routeKey) {
      case 'people':
        page = const UndergroundPeoplePage();
        break;
      case 'news':
        page = const NewsListPage();
        break;
      case 'video':
        page = const VideoListPage();
        break;
      case 'message':
        page = const MessagePage(showScaffold: true);
        break;
    }
    if (page != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => page!));
    }
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(child: CustomPaint(painter: _HeaderBackgroundPainter())),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 16, 10, 13),
          child: SafeArea(
            bottom: false,
            child: ResponsiveBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 11),
                  const Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white, size: 14),
                      SizedBox(width: 5),
                      Text(
                        companyName,
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 19),
                  const _MetricStrip(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderBackgroundPainter extends CustomPainter {
  const _HeaderBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final basePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF1E55D1), Color(0xFF4F83E7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);

    canvas.drawRect(rect, basePaint);

    final arcPaint = Paint()..style = PaintingStyle.fill;
    final center = Offset(size.width * 0.06, -size.height * 0.6);
    final radii = [size.width * 0.44, size.width * 0.74, size.width * 1.05];
    final alphas = [0.11, 0.075, 0.05];

    for (var i = 0; i < radii.length; i++) {
      arcPaint.color = Colors.white.withValues(alpha: alphas[i]);
      canvas.drawCircle(center, radii[i], arcPaint);
    }

    final fadePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0),
          Colors.white.withValues(alpha: 0.18),
          Colors.white.withValues(alpha: 0.34),
        ],
        stops: const [0, 0.62, 1],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);
    canvas.drawRect(rect, fadePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MetricStrip extends StatelessWidget {
  const _MetricStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          for (var i = 0; i < homeMetrics.length; i++) ...[
            Expanded(
              child: Column(
                children: [
                  Text(
                    homeMetrics[i].value,
                    style: const TextStyle(color: AppColors.primary, fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 6),
                  Text(homeMetrics[i].label, style: const TextStyle(color: AppColors.textPrimary, fontSize: 11)),
                ],
              ),
            ),
            if (i != homeMetrics.length - 1) Container(width: 1, height: 34, color: AppColors.divider),
          ],
        ],
      ),
    );
  }
}

class _MenuPager extends StatefulWidget {
  const _MenuPager({required this.onTap});

  final ValueChanged<MenuEntry> onTap;

  @override
  State<_MenuPager> createState() => _MenuPagerState();
}

class _MenuPagerState extends State<_MenuPager> {
  final _controller = PageController(keepPage: false);
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = Responsive.homeMenuColumns(constraints.maxWidth);
        final height = columns > 4 ? 184.0 : 166.0;

        return Container(
          height: height,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: homeMenuPages.length,
                  onPageChanged: (value) => setState(() => _page = value),
                  itemBuilder: (context, pageIndex) {
                    final items = homeMenuPages[pageIndex];
                    return GridView.builder(
                      padding: const EdgeInsets.fromLTRB(14, 13, 14, 3),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        mainAxisSpacing: 11,
                        crossAxisSpacing: 8,
                        mainAxisExtent: columns > 4 ? 62 : 56,
                      ),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () => widget.onTap(item),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _HomeMenuIcon(item: item),
                              const SizedBox(height: 7),
                              Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12, color: AppColors.textPrimary, height: 1.15),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < homeMenuPages.length; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: _page == i ? 12 : 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: _page == i ? AppColors.primary : AppColors.divider,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 7),
            ],
          ),
        );
      },
    );
  }
}

class _ModuleHeader extends StatelessWidget {
  const _ModuleHeader({
    required this.title,
    required this.onMoreTap,
  });

  final String title;
  final VoidCallback onMoreTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: const TextStyle(fontSize: 16, color: AppColors.textPrimary, fontWeight: FontWeight.w900)),
        const Spacer(),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onMoreTap,
          child: const Row(
            children: [
              Text('查看更多', style: TextStyle(color: AppColors.primary, fontSize: 13)),
              SizedBox(width: 2),
              Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.primary),
            ],
          ),
        ),
      ],
    );
  }
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({required this.onMoreTap});

  final VoidCallback onMoreTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ModuleHeader(title: '公告通知', onMoreTap: onMoreTap),
          const SizedBox(height: 8),
          const Text('助您轻松了解公司动态', style: TextStyle(color: AppColors.textTertiary, fontSize: 12)),
          const SizedBox(height: 5),
          for (var i = 0; i < noticeLines.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('【${noticeLines[i].tag}】', style: const TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w800)),
                Expanded(
                  child: Text(
                    noticeLines[i].title,
                    maxLines: i == 2 ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, height: 1.45),
                  ),
                ),
              ],
            ),
            if (i != noticeLines.length - 1) const Divider(height: 13, color: AppColors.divider),
          ],
        ],
      ),
    );
  }
}

class _DutyCard extends StatelessWidget {
  const _DutyCard({required this.onMoreTap});

  final VoidCallback onMoreTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      child: Column(
        children: [
          _ModuleHeader(title: '值班带班', onMoreTap: onMoreTap),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final person in dutyPeople)
                Expanded(
                  child: Column(
                    children: [
                      _DutyAvatar(person: person),
                      const SizedBox(height: 5),
                      Text(person.name, style: const TextStyle(fontSize: 12, color: AppColors.textPrimary)),
                      const SizedBox(height: 1),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.phone, color: AppColors.primary, size: 12),
                          SizedBox(width: 2),
                          Text('电话', style: TextStyle(color: AppColors.primary, fontSize: 11)),
                        ],
                      ),
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

class _HomeMenuIcon extends StatelessWidget {
  const _HomeMenuIcon({required this.item});

  final MenuEntry item;

  @override
  Widget build(BuildContext context) {
    final title = item.title;
    final icon = switch (title) {
      '值班带班' => Icons.event_available_rounded,
      '行业动态' => Icons.badge_rounded,
      '新闻资讯' => Icons.article_rounded,
      '安全巡检' => Icons.location_on_rounded,
      '一张图' => Icons.image_rounded,
      '自动化' => Icons.settings_rounded,
      '公文公告' => Icons.person_pin_rounded,
      '待办事项' => Icons.verified_rounded,
      _ => item.icon,
    };

    final radius = title == '安全巡检' || title == '待办事项' ? 16.0 : 5.0;

    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Icon(icon, color: Colors.white, size: 17),
    );
  }
}

class _DutyAvatar extends StatelessWidget {
  const _DutyAvatar({required this.person});

  final DutyPerson person;

  @override
  Widget build(BuildContext context) {
    final highlighted = person.avatarText == '朱' || person.avatarText == '李';
    if (highlighted) {
      return CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.primary,
        child: Text(
          person.avatarText,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFEFF3F8), Color(0xFFD9E2EC)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Icon(Icons.person_rounded, color: Color(0xFF344054), size: 28),
        ),
        Positioned(
          right: -1,
          bottom: -1,
          child: Container(
            width: 16,
            height: 16,
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            child: const Text('主', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
          ),
        ),
      ],
    );
  }
}
