import 'package:flutter_test/flutter_test.dart'; 
import 'package:myst_example/core.dart';


void main() {
  group("User", () {
    late Map<String, dynamic> json;
    late User user;
    late Map<String, dynamic> data;

    setUp(() {
      // TODO: initialize json data for testing
      json = {};
      /// user = User.fromJson(json);
      /// data = user.toJson();
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