import 'package:printx/printx.dart';

void main() {
  final String object = "Let see this string value in each print line";

  PrintX.warn(object); // or PrintX.w(object);

  PrintX.error(object); // or PrintX.e(object);

  PrintX.cool(object); // or PrintX.c(object);

  PrintX.sucess(object); // or PrintX.s(object);

  PrintX.info(object); // or PrintX.i(object);

  PrintX.fatal(object); // or PrintX.f(object);

  PrintX.hide(object); // or PrintX.h(object);

  PrintX.debug(object); // or PrintX.d(object);
}
