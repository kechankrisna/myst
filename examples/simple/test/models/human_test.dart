import 'package:flutter_test/flutter_test.dart'; 
import 'package:simple/core.dart';


void main() {
  group("Human", () {
    late Map<String, dynamic> json;
    late Human human;
    late Map<String, dynamic> data;

    setUp(() {
      // TODO: initialize json data for testing
      json = {};
      /// human = Human.fromJson(json);
      /// data = human.toJson();
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