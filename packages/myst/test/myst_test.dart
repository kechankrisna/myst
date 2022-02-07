/// import 'package:myst/myst.dart';
/// import 'package:printx/printx.dart';
/// import 'package:string_scanner/string_scanner.dart';
import 'package:recase/recase.dart';
import 'package:test/test.dart';

void main() {
  test('replace regex', () {
    final className = "\$className";
    final source = "here is the template with className";
    final shouldBe = "here is the template with model";
    final result = source.replaceAll(RegExp(r'className'), "model");
    expect(shouldBe, result);
  });

  test("camal case", () {
    String source = "MyCamelCase";
    var shouldBe = "my_camel_case";
    var result = "MyCamelCase".snakeCase;

    expect(shouldBe, result);
  });
}
