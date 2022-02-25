import 'package:flutter_test/flutter_test.dart'; 
import 'package:myst_example/core.dart';


void main() {
  group("AuthenticationService", () {
    late AuthenticationService authenticationService;

    setUp(() {
      // TODO: initialize authenticationService to test the behavior
      authenticationService = AuthenticationService();
    });

    test(": ==", () {
      expect(true, true);
    });
  });
}