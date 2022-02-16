const String mystYamlTemplate = """configs:
  rewrite: true
  model:
    rewrite: true
  interface:
    rewrite: true
  controller:
    rewrite: false
  extension:
    rewrite: false
  layout:
    rewrite: false
  screen:
    rewrite: false
  service:
    rewrite: false
  utility:
    rewrite: false
  widget:
    rewrite: false""";

/// ###`testTemplate`
///
/// default test template which can be load into file in test directory
const String testTemplate = """import 'package:test/test.dart';

void main() {
  setUp(() {

  });

}
""";

/// ### `integationTestTemplate`
///
/// default test template which can be load into file in integration_test directory
const String integationTestTemplate =
    """import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("failing test example", (WidgetTester tester) async {
    expect(2 + 2, equals(5));
  });
}
""";

/// ### `modelTemplate`
///
/// will be used when create a new model
/// and its test file
const String modelTemplate = """
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement model
class className{
  
}
""";

const String modelTestTemplate = """import 'package:test/test.dart';

void main() {
  group("className", () {
    late Map<String, dynamic> json;
    late className objectName;
    late Map<String, dynamic> data;

    setUp(() {
      // TODO: initialize json data for testing
      json = {};
      /// objectName = className.fromJson(json);
      /// data = objectName.toJson();
    });

    test(": fromJson(json)", () {
      expect(true, true);
    });

    test(": toJson()", () {
      expect(true, true);
    });

    test(": ==", () {
      expect(true, true);
    });
  });
}""";

/// ### `interfaceTemplate`
///
/// will be used when create a new interface
/// and its test file
const String interfaceTemplate = """
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement abstract class as interface
abstract class className{
  
}
""";

const String interfaceTestTemplate = """import 'package:test/test.dart';

/// TODO: implement and test its implementation 
/// class classNameImp implements className{

/// }

void main() {
  group("className", () {
    /// late classNameImp objectName;

    setUp(() {
      // TODO: initialize impl and assert every method
      /// objectName = classNameImp();
    });
    
    test(": ==", () {
      expect(true, true);
    });
  });
}""";

/// ### `controllerTemplate`
///
/// will be used when create a new controller
/// and its test file
const String controllerTemplate = """
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement controller
class className extends ChangeNotifier with DiagnosticableTreeMixin implements ReassembleHandler{
  
  className(){
    
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    /// list all the properties of your class here.
    /// See the documentation of debugFillProperties for more information.
    /// TODO: implement add
    properties.add(StringProperty('className', null));
  }

  @override
  void reassemble() {
    print('Did hot-reload className');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
""";

const String controllerTestTemplate = """import 'package:test/test.dart';
/// gestures handler
import 'package:flutter/gestures.dart';


void main() {
  group("test controller className", () {
    TestWidgetsFlutterBinding.ensureInitialized();
    
    late Widget app;
    setUp(() {
      app = MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => className(),
          /// child: const CounterScreen(),
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
      /// final titleFinder = find.text("counter");
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
""";


/// ### `extensionTemplate`
///
/// will be used when create a new extension
/// and its test file
const String extensionTemplate = """
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement extension on object
extension className on String {
  
}
""";

const String extensionTestTemplate = """import 'package:test/test.dart';

void main() {
  group("className", () {
    late String objectName;

    setUp(() {
      // TODO: initialize an object and try extension method
      objectName = "String()";
    });
    
    test(": ==", () {
      expect(true, true);
    });
  });
}""";