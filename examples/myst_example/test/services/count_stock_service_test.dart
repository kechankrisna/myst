import 'package:flutter_test/flutter_test.dart';
import 'package:myst_example/core.dart';

void main() {
  group("CountStockService", () {
    late CountStockService countStockService;

    setUp(() {
      // TODO: initialize countStockService to test the behavior
      countStockService = CountStockService();
    });

    test(": ==", () {
      expect(true, true);
    });
  });
}
