import 'package:flutter_test/flutter_test.dart'; 
import 'package:myst_example/core.dart';


void main() {
  group("ApplicationService", () {
    late ApplicationService applicationService;

    setUp(() {
      // TODO: initialize applicationService to test the behavior
      applicationService = ApplicationService();
    });

    test(": ==", () {
      expect(true, true);
    });
  });
}