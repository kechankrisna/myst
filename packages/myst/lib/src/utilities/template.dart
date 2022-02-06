const String testTemplate = """import 'package:test/test.dart';

void main() {
  setUp(() {

  });

}
""";


const String integationTestTemplate = """import 'package:flutter_test/flutter_test.dart';
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
      /// initialize json data for testing
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