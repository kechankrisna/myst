import 'package:flutter_test/flutter_test.dart'; 
import 'package:simple/core.dart';


void main() {
  group("Student", () {
    late Map<String, dynamic> json;
    late Student student;
    late Map<String, dynamic> data;

    setUp(() {
      // TODO: initialize json data for testing
      json = {};
      /// student = Student.fromJson(json);
      /// data = student.toJson();
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