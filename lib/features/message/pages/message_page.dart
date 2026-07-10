import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/responsive.dart';
import '../../../mock/mock_data.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key, this.showScaffold = false});

  final bool showScaffold;

  @override
  Widget build(BuildContext context) {
    final content = _MessageContent(showBottomPadding: !showScaffold);
    if (showScaffold) {
      return Scaffold(
        body: content,
      );
    }
    return Scaffold(
      body: content,
    );
  }
}

class _MessageContent extends StatefulWidget {
  const _MessageContent({required this.showBottomPadding});

  final bool showBottomPadding;

  @override
  State<_MessageContent> createState() => _MessageContentState();
}

class _MessageContentState extends State<_MessageContent> {
  int _tab = 0;
  final _tabs = const ['全部', '预警报警', '消息通知', '流程审批'];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: widget.showBottomPadding ? 82 : 18),
      children: [
        const _MessageHeader(),
        ResponsiveBox(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 8),
              SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _tabs.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 9),
                  itemBuilder: (context, index) {
                    final active = _tab == index;
                    return GestureDetector(
                      onTap: () => setState(() => _tab = index),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 70,
                            height: 34,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: active ? AppColors.primary : Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              _tabs[index],
                              style: TextStyle(color: active ? Colors.white : AppColors.textPrimary, fontSize: 12, height: 1),
                            ),
                          ),
                          if (index == 1)
                            Positioned(
                              right: 2,
                              top: -1,
                              child: Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 6),
              for (var i = 0; i < messages.length; i++) ...[
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2)),
                    child: Text(messages[i].time, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ),
                ),
                _MessageCard(item: messages[i]),
                const SizedBox(height: 14),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MessageHeader extends StatelessWidget {
  const _MessageHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: ResponsiveBox(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 42,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 7, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text('消息中心', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w800)),
                  ),
                  const Spacer(),
                  _SearchCapsule(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({required this.item});

  final MessageItem item;

  @override
  Widget build(BuildContext context) {
    final isAlarm = item.kind == 'alarm';
    return AppCard(
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(item.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
              if (isAlarm)
                Container(
                  margin: const EdgeInsets.only(left: 3, bottom: 9),
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(item.content, style: const TextStyle(color: AppColors.textSecondary, height: 1.55, fontSize: 14)),
          if (item.kind == 'notice') ...[
            const SizedBox(height: 12),
            Container(
              height: 92,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF0654CE), Color(0xFF08317E)]),
                borderRadius: BorderRadius.circular(2),
              ),
              alignment: Alignment.center,
              child: const Text('最新通知', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900)),
            ),
          ],
          const Divider(height: 18, color: AppColors.divider),
          InkWell(
            onTap: isAlarm ? () => _showAlarmDialog(context) : null,
            child: const Row(
              children: [
                Text('立即处理', style: TextStyle(color: AppColors.textPrimary, fontSize: 12)),
                Spacer(),
                Icon(Icons.chevron_right_rounded, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAlarmDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => const _AlarmDialog(),
    );
  }
}

class _AlarmDialog extends StatelessWidget {
  const _AlarmDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 54),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Text('报警处理', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900))),
                  const SizedBox(height: 16),
                  const Text('发布时间：', style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Radio<bool>(value: false, groupValue: true, onChanged: (_) {}),
                      const Text('实警'),
                      const SizedBox(width: 18),
                      Radio<bool>(value: true, groupValue: true, onChanged: (_) {}),
                      const Text('误报'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('备注：', style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    height: 76,
                    padding: const EdgeInsets.all(10),
                    color: const Color(0xFFF0F2F6),
                    alignment: Alignment.topLeft,
                    child: const Text('请输入', style: TextStyle(color: AppColors.textTertiary)),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.divider),
            SizedBox(
              height: 44,
              child: Row(
                children: [
                  Expanded(child: TextButton(onPressed: () => Navigator.pop(context), child: const Text('取消', style: TextStyle(color: AppColors.textPrimary)))),
                  Container(width: 1, color: AppColors.divider),
                  Expanded(child: TextButton(onPressed: () => Navigator.pop(context), child: const Text('确定'))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchCapsule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 28,
      decoration: BoxDecoration(color: const Color(0xFFF7F8FB), borderRadius: BorderRadius.circular(14)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_rounded, size: 15, color: Color(0xFF6B7280)),
          SizedBox(width: 4),
          Text('搜索', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }
}
