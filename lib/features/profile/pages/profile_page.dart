import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/responsive.dart';
import '../../../mock/mock_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(alignment: Alignment.centerLeft, child: Text('个人中心')),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 90),
        children: const [
          ResponsiveBox(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _UserHeader(),
                SizedBox(height: 16),
                AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _ProfileTile(icon: Icons.verified_rounded, title: '版本信息', subtitle: '记得更新版本哦~'),
                      Divider(height: 1, indent: 58, color: AppColors.divider),
                      _ProfileTile(icon: Icons.groups_rounded, title: '关于我们', subtitle: '开发者信息请看这里'),
                      Divider(height: 1, indent: 58, color: AppColors.divider),
                      _ProfileTile(icon: Icons.cleaning_services_rounded, title: '清理缓存', subtitle: '定期清理，节省空间'),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                AppCard(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Center(
                    child: Text('退出登录', style: TextStyle(color: AppColors.textPrimary, fontSize: 15)),
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

class _UserHeader extends StatelessWidget {
  const _UserHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(colors: [Color(0xFFC7A27B), Color(0xFF2D3341)]),
            border: Border.all(color: Colors.white, width: 2),
          ),
          alignment: Alignment.center,
          child: const Text('管', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('超级管理员', style: TextStyle(color: AppColors.textPrimary, fontSize: 19, fontWeight: FontWeight.w900)),
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.workspace_premium_outlined, color: AppColors.textTertiary, size: 14),
                  SizedBox(width: 4),
                  Text('综合办公室', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.apartment_rounded, color: AppColors.textTertiary, size: 14),
                  SizedBox(width: 4),
                  Text(companyName, style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        IconButton(onPressed: null, icon: Icon(Icons.hexagon_outlined, color: AppColors.textPrimary)),
      ],
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: Icon(icon, color: const Color(0xFF333333)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textTertiary, fontSize: 12)),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textPrimary),
    );
  }
}
