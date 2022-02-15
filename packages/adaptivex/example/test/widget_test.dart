// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:example/my_cupertino_app.dart';
import 'package:example/my_fusion_app.dart';
import 'package:example/my_linux_app.dart';
import 'package:example/my_macos_app.dart';
import 'package:example/my_material_app.dart';
import 'package:example/my_window_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  group("run and test for all target platforms", () {
    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    testWidgets(
      "assert for all TargetPlatform",
      (WidgetTester tester) async {
        await tester.pumpWidget(const MyApp());

        await tester.pumpAndSettle();

        if (defaultTargetPlatform == TargetPlatform.iOS) {
          expect(find.byType(MyCupertinoApp), findsOneWidget);
          await tester.pumpAndSettle();
        } else if (defaultTargetPlatform == TargetPlatform.android) {
          expect(find.byType(MyMaterialApp), findsOneWidget);
          await tester.pumpAndSettle();
        } else if (defaultTargetPlatform == TargetPlatform.windows) {
          expect(find.byType(MyWindowApp), findsOneWidget);
          await tester.pumpAndSettle();
        } else if (defaultTargetPlatform == TargetPlatform.macOS) {
          expect(find.byType(MyMacosApp), findsOneWidget);
          await tester.pumpAndSettle();
        } else if (defaultTargetPlatform == TargetPlatform.linux) {
          expect(find.byType(MyLinuxApp), findsOneWidget);
          await tester.pumpAndSettle();
        } else {
          expect(find.byType(MyFusionApp), findsOneWidget);
          await tester.pumpAndSettle();
        }
      },
      variant: TargetPlatformVariant.all(),
      skip: true,
    );

    tearDownAll(() {});
  });
}
