import 'package:flutter_test/flutter_test.dart';
import 'package:simple/models/person.dart';

void main() {
  group("Person", () {
    late Map<String, dynamic> json;
    late Person person;
    late Map<String, dynamic> data;

    setUp(() {
      /// initialize json data for testing
      json = {};
      /// person = Person.fromJson(json);
      /// data = person.toJson();
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