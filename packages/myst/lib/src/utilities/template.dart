const String mystYamlTemplate = """configs:
  rewrite: true
  model:
    rewrite: true
  interface:
    rewrite: true""";

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
