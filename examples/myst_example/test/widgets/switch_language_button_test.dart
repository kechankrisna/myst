import 'package:flutter_test/flutter_test.dart'; 
import 'package:myst_example/core.dart';

/// gestures handler
import 'package:flutter/gestures.dart';


void main() {
  group("test controller SwitchLanguageButton", () {
    TestWidgetsFlutterBinding.ensureInitialized();
    
    late Widget app;
    setUp(() {
      app = MaterialApp(
        home: SwitchLanguageButton(
          /// child: const Text("sample"),
        ),
      );
    });

    tearDown(() {
      ///
    });

    testWidgets("start a screen to pump widget and test", (tester) async {
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      /// TODO: implement find
      /// final titleFinder = find.text("sample");
      /// final incrementFinder = find.byKey(CounterScreen.incrementkey);
      /// await tester.pumpAndSettle();
      
      /// TODO: guester
      /// await tester.tap(incrementFinder);
      /// await tester.pumpAndSettle();
      
      /// TODO: expected
      /// expect(titleFinder, findsWidgets);
      /// expect(incrementFinder, findsOneWidget);

    });
  });
}
