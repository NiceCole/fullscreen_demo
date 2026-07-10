// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:control_platform_mobile/app/app.dart';

void main() {
  testWidgets('Control platform app starts', (WidgetTester tester) async {
    await tester.pumpWidget(const ControlPlatformApp());
    await tester.pump();

    expect(find.text('新郑煤电有限责任公司'), findsOneWidget);
  });
}
