import 'package:printx/printx.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    test("print null", () {
      PrintX.warn(null);

      PrintX.error(null);

      PrintX.cool(null);

      PrintX.sucess(null);

      PrintX.info(null);

      PrintX.fatal(null);

      expect(1, 1);
    });
  });
}
