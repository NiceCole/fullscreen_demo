import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/responsive.dart';
import '../../../mock/mock_data.dart';
import 'video_player_page.dart';

class VideoListPage extends StatelessWidget {
  const VideoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('海康视频')),
      body: ResponsiveBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Row(
                children: [
                  Container(
                    width: 110,
                    height: 34,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                    child: const Row(
                      children: [
                        Expanded(child: Text('西翼深部立井', style: TextStyle(fontSize: 12))),
                        Icon(Icons.keyboard_arrow_down_rounded, size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 34,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                      child: const Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(Icons.search, color: AppColors.textTertiary, size: 17),
                          SizedBox(width: 6),
                          Text('请输入地点名称', style: TextStyle(color: AppColors.textTertiary, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final columns = Responsive.videoColumns(constraints.maxWidth);

                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    itemCount: videoItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: columns > 2 ? 1.08 : 0.92,
                    ),
                    itemBuilder: (context, index) {
                      final item = videoItems[index];
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoPlayerPage(item: item))),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColors.divider)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _VideoThumb(item: item)),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, height: 1.3)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoThumb extends StatelessWidget {
  const _VideoThumb({required this.item});

  final VideoItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
        gradient: LinearGradient(colors: [item.colorA, item.colorB], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 8,
            top: 8,
            child: Row(
              children: [
                Container(width: 7, height: 7, decoration: BoxDecoration(color: item.online ? Colors.greenAccent : Colors.orange, shape: BoxShape.circle)),
                const SizedBox(width: 4),
                Text(item.online ? '在线' : '离线', style: const TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
