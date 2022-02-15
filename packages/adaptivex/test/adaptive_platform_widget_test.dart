import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdaptivePlatformWidget', () {
    late Widget widget;
    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      widget = MaterialApp(
        home: AdaptivePlatformWidget(
          child: Text("child"),
          ios: Text("ios"),
          android: Text("android"),
          macos: Text("macos"),
          window: Text("window"),
          linux: Text("linux"),
        ),
      );
    });

    tearDown(() {
      ///
    });

    testWidgets(
      "assert child for TargetPlatform.all() as default",
      (WidgetTester tester) async {
        final childWidget = MaterialApp(
          home: AdaptivePlatformWidget(
            child: Text("child"),
          ),
        );

        await tester.pumpWidget(childWidget);

        await tester.pump();

        expect(find.text("child"), findsOneWidget);
      },
      variant: TargetPlatformVariant.all(),
    );

    testWidgets(
      "assert for all TargetPlatform",
      (WidgetTester tester) async {
        await tester.pumpWidget(widget);

        await tester.pump();

        if (defaultTargetPlatform == TargetPlatform.iOS) {
          expect(find.text("ios"), findsOneWidget);
          await tester.pumpAndSettle();
        } else if (defaultTargetPlatform == TargetPlatform.android) {
          expect(find.text("android"), findsOneWidget);
          await tester.pumpAndSettle();
        } else if (defaultTargetPlatform == TargetPlatform.windows) {
          expect(find.text("window"), findsOneWidget);
          await tester.pumpAndSettle();
        } else if (defaultTargetPlatform == TargetPlatform.macOS) {
          expect(find.text("macos"), findsOneWidget);
          await tester.pumpAndSettle();
        } else if (defaultTargetPlatform == TargetPlatform.linux) {
          expect(find.text("linux"), findsOneWidget);
          await tester.pumpAndSettle();
        } else {
          expect(find.text("child"), findsOneWidget);
          await tester.pumpAndSettle();
        }
      },
      variant: TargetPlatformVariant.all(),
    );

    testWidgets(
      "assert ios for TargetPlatform.iOS",
      (WidgetTester tester) async {
        await tester.pumpWidget(widget);

        await tester.pump();

        expect(find.text("ios"), findsOneWidget);
      },
      variant: TargetPlatformVariant.only(TargetPlatform.iOS),
    );

    testWidgets(
      "assert android for TargetPlatform.android",
      (WidgetTester tester) async {
        await tester.pumpWidget(widget);

        await tester.pump();

        expect(find.text("android"), findsOneWidget);
        debugDefaultTargetPlatformOverride = null;
      },
    );

    testWidgets(
      "assert macos on TargetPlatform.macOS",
      (WidgetTester tester) async {
        await tester.pumpWidget(widget);

        await tester.pump();

        expect(find.text("macos"), findsOneWidget);
      },
      variant: TargetPlatformVariant.only(TargetPlatform.macOS),
    );

    testWidgets(
      "assert window on TargetPlatform.windows",
      (WidgetTester tester) async {
        await tester.pumpWidget(widget);

        await tester.pump();

        expect(find.text("window"), findsOneWidget);
      },
      variant: TargetPlatformVariant.only(TargetPlatform.windows),
    );

    testWidgets(
      "assert linux on TargetPlatform.linux",
      (WidgetTester tester) async {
        await tester.pumpWidget(widget);

        await tester.pump();

        expect(find.text("linux"), findsOneWidget);
      },
      variant: TargetPlatformVariant.only(TargetPlatform.linux),
    );
  });
}
