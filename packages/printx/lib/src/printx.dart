import 'functions.dart';

class PrintX {
  /// warning will use yellow color
  static void warn(Object? object) => printYellow(object);

  /// error when use color red
  static void error(Object? object) => printRed(object);

  /// success will use color green
  static void sucess(Object? object) => printGreen(object);

  /// information will use color blue
  static void info(Object? object) => printBlue(object);

  /// more will use color magenta
  static void fatal(Object? object) => printMagenta(object);

  /// cool will use color cyan
  static void cool(Object? object) => printCyan(object);

  /// hide will use color black
  static void hide(Object? object) => printBlack(object);

  /// hide will use color white
  static void debug(Object? object) => printWhite(object);

  /// shortcut

  /// warning will use yellow color
  static void w(Object? object) => warn(object);

  /// error when use color red
  static void e(Object? object) => error(object);

  /// success will use color green
  static void s(Object? object) => sucess(object);

  /// information will use color blue
  static void i(Object? object) => info(object);

  /// more will use color magenta
  static void f(Object? object) => fatal(object);

  /// cool will use color cyan
  static void c(Object? object) => cool(object);

  /// hide will use color black
  static void h(Object? object) => hide(object);

  /// hide will use color white
  static void d(Object? object) => debug(object);
}
