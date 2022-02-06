/// import 'package:flutter_test/flutter_test.dart';
import 'package:test/test.dart';

void main() {
  group("ModelName", () {
    late Map<String, dynamic> json;
    late ModelName name;
    late Map<String, dynamic> data;

    setUp(() {
      /// initialize json data for testing
      json = {};
      /// name = ModelName.fromJson(json);
      /// data = name.toJson();
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
}