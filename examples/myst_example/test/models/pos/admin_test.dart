import 'package:flutter_test/flutter_test.dart';
import 'package:myst_example/core.dart';

void main() {
  group("Admin", () {
    late Map<String, dynamic> json;
    late Admin admin;
    late Map<String, dynamic> data;

    setUp(() {
      // TODO: initialize json data for testing
      json = {};

      /// admin = Admin.fromJson(json);
      /// data = admin.toJson();
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
