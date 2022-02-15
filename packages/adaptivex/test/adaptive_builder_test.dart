import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdaptiveBuilderWidget', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    late Widget widget;
    setUpAll(() {
      widget = MaterialApp(
        title: "demo",
        home: Scaffold(
          body: AdaptiveBuilder(
            xlBuilder: (context) => Text("xlBuilder"),
            lgBuilder: (context) => Text("lgBuilder"),
            mdBuilder: (context) => Text("mdBuilder"),
            smBuilder: (context) => Text("smBuilder"),
            xsBuilder: (context) => Text("xsBuilder"),
            builder: (context) => Text("builder"),
          ),
        ),
      );
    });

    testWidgets("test xsBuilder", (WidgetTester tester) async {
      /// set the screen size to small screen
      tester.binding.window.physicalSizeTestValue = Size(400, 600);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(widget);

      await tester.pumpAndSettle();

      expect(find.text("xsBuilder"), findsOneWidget);

      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    });

    testWidgets("test smBuilder", (WidgetTester tester) async {
      /// set the screen size to small screen
      tester.binding.window.physicalSizeTestValue = Size(600, 600);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(widget);

      await tester.pumpAndSettle();

      expect(find.text("smBuilder"), findsOneWidget);

      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    });

    testWidgets(
      "test mdBuilder",
      (WidgetTester tester) async {
        /// set the screen size to small screen
        tester.binding.window.physicalSizeTestValue = Size(900, 700);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(widget);

        if (DeviceService.isMobile) {
          await tester.pumpAndSettle();

          expect(find.text("smBuilder"), findsOneWidget);
        } else {
          await tester.pumpAndSettle();

          expect(find.text("mdBuilder"), findsOneWidget);
        }

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      },
      variant: TargetPlatformVariant.all(),
    );

    testWidgets(
      "test lgBuilder",
      (WidgetTester tester) async {
        /// set the screen size to small screen
        tester.binding.window.physicalSizeTestValue = Size(1000, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(widget);

        if (DeviceService.isMobile) {
          await tester.pumpAndSettle();

          expect(find.text("mdBuilder"), findsOneWidget);
        } else {
          await tester.pumpAndSettle();

          expect(find.text("lgBuilder"), findsOneWidget);
        }

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      },
      variant: TargetPlatformVariant.all(),
    );

    testWidgets(
      "test xlBuilder",
      (WidgetTester tester) async {
        /// set the screen size to small screen
        tester.binding.window.physicalSizeTestValue = Size(1200, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(widget);

        if (DeviceService.isMobile) {
          await tester.pumpAndSettle();

          expect(find.text("mdBuilder"), findsOneWidget);
        } else {
          await tester.pumpAndSettle();

          expect(find.text("xlBuilder"), findsOneWidget);
        }

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      },
      variant: TargetPlatformVariant.all(),
    );
  });
}
