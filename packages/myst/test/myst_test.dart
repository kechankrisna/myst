import 'package:myst/myst.dart';
import 'package:printx/printx.dart';
import 'package:string_scanner/string_scanner.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:test/test.dart';

void main() {
  test('replace regex', () {
    final className = "\$ClassName";
    final source = "here is the template with ClassName";
    final shouldBe = "here is the template with model";
    final result = source.replaceAll(RegExp(r'ClassName'), "model");
    expect(shouldBe, result);
  });
  test("camal case", () {
    String source = "MyCamelCase";
    var shouldBe = "my_camel_case";
    var result = StringUtils.camelCaseToLowerUnderscore(source);

    expect(shouldBe, result);
  });
}
