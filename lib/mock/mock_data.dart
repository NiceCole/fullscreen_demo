import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';

class HomeMetric {
  const HomeMetric(this.value, this.label);

  final String value;
  final String label;
}

class MenuEntry {
  const MenuEntry({
    required this.title,
    required this.icon,
    required this.color,
    this.routeKey,
  });

  final String title;
  final IconData icon;
  final Color color;
  final String? routeKey;
}

class NoticeLine {
  const NoticeLine(this.tag, this.title);

  final String tag;
  final String title;
}

class DutyPerson {
  const DutyPerson(this.name, this.avatarText);

  final String name;
  final String avatarText;
}

class MessageItem {
  const MessageItem({
    required this.type,
    required this.title,
    required this.content,
    required this.time,
    required this.kind,
  });

  final String type;
  final String title;
  final String content;
  final String time;
  final String kind;
}

class NewsItem {
  const NewsItem({
    required this.type,
    required this.title,
    required this.time,
    required this.reads,
  });

  final String type;
  final String title;
  final String time;
  final String reads;
}

class PersonGroup {
  const PersonGroup(this.name, this.count, [this.expanded = false]);

  final String name;
  final int count;
  final bool expanded;
}

class VideoItem {
  const VideoItem(this.title, this.colorA, this.colorB, {this.online = true});

  final String title;
  final Color colorA;
  final Color colorB;
  final bool online;
}

const companyName = '新郑煤电有限责任公司';

const homeMetrics = [
  HomeMetric('36', '设备监测'),
  HomeMetric('17', '环境监测'),
  HomeMetric('3', '人员监测'),
  HomeMetric('46', '视频监测'),
];

const homeMenuPages = [
  [
    MenuEntry(title: '值班带班', icon: Icons.event_available_rounded, color: Color(0xFFFF7890)),
    MenuEntry(title: '行业动态', icon: Icons.badge_rounded, color: Color(0xFF48B9F5), routeKey: 'news'),
    MenuEntry(title: '新闻资讯', icon: Icons.article_rounded, color: Color(0xFFFFA640), routeKey: 'news'),
    MenuEntry(title: '安全巡检', icon: Icons.location_on_rounded, color: Color(0xFF9B78F6)),
    MenuEntry(title: '一张图', icon: Icons.image_rounded, color: Color(0xFF35A8F5)),
    MenuEntry(title: '自动化', icon: Icons.settings_rounded, color: Color(0xFF8B6AF7)),
    MenuEntry(title: '公文公告', icon: Icons.person_pin_rounded, color: Color(0xFFF36F6F)),
    MenuEntry(title: '待办事项', icon: Icons.verified_rounded, color: Color(0xFFFFA33D), routeKey: 'message'),
  ],
  [
    MenuEntry(title: '人员定位', icon: Icons.supervised_user_circle_rounded, color: Color(0xFF43B9EE), routeKey: 'people'),
    MenuEntry(title: '水文监测', icon: Icons.water_drop_rounded, color: Color(0xFFFF708A)),
    MenuEntry(title: '安全监测', icon: Icons.workspace_premium_rounded, color: Color(0xFFFFB14A)),
    MenuEntry(title: '海康视频', icon: Icons.videocam_rounded, color: Color(0xFF9B78F6), routeKey: 'video'),
    MenuEntry(title: '预警报警', icon: Icons.notifications_active_rounded, color: Color(0xFFFFA33D), routeKey: 'message'),
    MenuEntry(title: '安全状况', icon: Icons.shield_rounded, color: Color(0xFF35A8F5)),
    MenuEntry(title: '调度信息', icon: Icons.swap_horiz_rounded, color: Color(0xFF8B6AF7)),
    MenuEntry(title: '文档管理', icon: Icons.article_rounded, color: Color(0xFFF36F6F)),
  ],
];

const noticeLines = [
  NoticeLine('要闻', '集团公司党委扩大会议召开'),
  NoticeLine('图片新闻', '骄傲！考上清华了！'),
  NoticeLine('要闻', '集团公司党委扩大会议召开，部署资产清查盘活工作，观看跨境电商辅导片'),
];

const dutyPeople = [
  DutyPerson('姚丙傲', '姚'),
  DutyPerson('朱茗丽', '朱'),
  DutyPerson('王小虎', '王'),
  DutyPerson('李燕', '李'),
];

const messages = [
  MessageItem(type: '系统报警', title: '系统报警', content: '人员定位超员报警：井下限员人数870人，当前总人数893人。', time: '2026-05-29 14:52:42', kind: 'alarm'),
  MessageItem(type: '系统报警', title: '系统报警', content: '人员定位超员报警：井下限员人数870人，当前总人数882人。', time: '2026-05-28 14:52:42', kind: 'alarm'),
  MessageItem(type: '消息通知', title: '赵家寨煤矿内部工作通知', content: '为进一步强化安全生产管理，提升标准化作业水...', time: '2025-12-29 14:52:42', kind: 'notice'),
  MessageItem(type: '流程审批', title: '锦源公司OA系统及公司官网运维服务的开票申请', content: '考试编码：20240801\n发布时间：08/19 15:33:24\n考试截止时间：08/22 23:59:59', time: '2025-08-14 14:52:42', kind: 'approval'),
];

const news = [
  NewsItem(type: '要闻', title: '集团公司组织退休老干部开展“学回信精神助改革发展”专题调研', time: '2小时前', reads: '1234'),
  NewsItem(type: '行业动态', title: '如何让科技创新更好护航矿山安全生产', time: '2小时前', reads: '1234'),
  NewsItem(type: '要闻', title: '集团公司组织退休老干部开展“学回信精神助改革发展”专题调研', time: '2小时前', reads: '1234'),
  NewsItem(type: '行业动态', title: '集团公司召开资产清查盘活工作推进会', time: '2026-05-29', reads: '1234'),
  NewsItem(type: '行业动态', title: '推进“人工智能+”能源高质量发展两部门出新规', time: '2026-04-13', reads: '1234'),
  NewsItem(type: '行业动态', title: '7月全国进口煤炭同比降22.9%', time: '2025-12-23', reads: '1234'),
];

const stationGroups = [
  PersonGroup('副井底', 82, true),
  PersonGroup('中央采区轨道上山二车场', 20),
  PersonGroup('西翼轨道大巷与爆破材料库岔口', 20),
  PersonGroup('西翼轨道大巷与14采区上部车场岔口', 5),
  PersonGroup('14采区轨道上山与14下部变电所岔口', 12),
  PersonGroup('14采区轨道上山与14204下底抽巷车场岔口', 2),
  PersonGroup('14采区轨道上山与14206下车场岔口', 33),
  PersonGroup('中央采区轨道上山与12采区变电所岔口', 7),
];

const departmentGroups = [
  PersonGroup('中层', 82),
  PersonGroup('通风队', 20),
  PersonGroup('生产技术科', 20),
  PersonGroup('防突科', 5),
  PersonGroup('综掘一队', 12),
  PersonGroup('开拓二队', 2),
  PersonGroup('抽探二队', 33),
  PersonGroup('安检大队', 7),
];

const videoItems = [
  VideoItem('新郑煤电西翼深部沉淀池泵房', Color(0xFFE3F4DE), Color(0xFFE6B989)),
  VideoItem('新郑煤电西翼深部立井回风副提升车房', Color(0xFF9EC6B7), Color(0xFF1F5364)),
  VideoItem('新郑煤电西翼深部立井回风副提升车房内', Color(0xFFB7DAD0), Color(0xFF2D6E67)),
  VideoItem('新郑煤电西翼深部立井回风井井底', Color(0xFF87C4E5), Color(0xFF426D7A), online: false),
  VideoItem('新郑煤电西翼深部立井回风井口东码', Color(0xFF6D6C5C), Color(0xFF302D29)),
  VideoItem('新郑煤电西翼深部立井回风井口通道', Color(0xFFCF7D44), Color(0xFF3D2C22)),
  VideoItem('新郑煤电西翼深部立井回风井口西码', Color(0xFF39414B), Color(0xFF0F172A)),
  VideoItem('新郑煤电西翼深部立井井底材料库', Color(0xFFB6865B), Color(0xFF32515A)),
];

const peopleNames = ['胡永国', '胡永国', '胡永国', '胡永国', '胡永国', '胡永国', '胡永国', '胡永国', '胡永国', '胡永国', '胡永国', '胡永国', '胡永国', '胡永国', '胡永国', '胡永国', '胡永国', '胡永国', '胡永国', '胡永国'];

const articleParagraphs = [
  '7月2日，中国中煤首个海外模块栈桥工程——蒙古国MAK Khuut煤矿250TPH选煤厂项目模块栈桥工程圆满完成吊装任务，首次实现海外落地应用，标志着中国中煤拥有自主知识产权的“中煤雷奥”模块栈桥输煤技术正式走出国门。',
  '蒙古国MAK Khuut煤矿250TPH选煤厂项目隶属该国MAK集团，坐落于该国内戈壁省巴彦热尔嘎兰县Khuut矿区，年洗选规模约180万吨。项目采用块煤重介旋流器+细煤浮选联合分选工艺，配套了完整的原煤准备、主洗分选、煤泥水闭路循环、产品储运系统，同步建设应用的模块化密闭栈桥等公用配套设施，适配当地低温、风沙、有效施工期短的工况，兼具密闭抑尘、绿色环保、抗寒耐腐、运维简便等优势。',
  '中煤建设集团作为该项目模块栈桥的施工单位，首次采用“设备供应+技术服务”一体化模式，为工程提供全链条产品配套与全周期现场技术指导。',
  '中国中煤模块栈桥首次实现海外落地应用，充分体现了“中煤雷奥”模块栈桥“专精特新”的产品优势，擦亮了“中煤制造”海外名片，对模块栈桥海外业务布局具有重要意义。',
];

