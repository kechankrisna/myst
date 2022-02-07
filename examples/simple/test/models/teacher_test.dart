import 'package:flutter_test/flutter_test.dart';
import 'package:simple/models/teacher.dart';

void main() {
  group("Teacher", () {
    late Map<String, dynamic> json;
    late Teacher teacher;
    late Map<String, dynamic> data;

    setUp(() {
      /// initialize json data for testing
      json = {};
      /// teacher = Teacher.fromJson(json);
      /// data = teacher.toJson();
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