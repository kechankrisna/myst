library extensions;

import 'dart:io' as io;

import 'package:ansicolor/ansicolor.dart';

/// colorize text in cli print out
extension StringParsing on String {
  bool get isSupportCli => !io.stdout.supportsAnsiEscapes;
  String get toBlack => (AnsiPen()..black()).call("\x1B[30m$this\x1B[0m");
  String get toRed => (AnsiPen()..red()).call("\x1B[31m$this\x1B[0m");
  String get toGreen => (AnsiPen()..green()).call("\x1B[32m$this\x1B[0m");
  String get toYellow => (AnsiPen()..yellow()).call("\x1B[33m$this\x1B[0m");
  String get toBlue => (AnsiPen()..blue()).call("\x1B[34m$this\x1B[0m");
  String get toMagenta => (AnsiPen()..magenta()).call("\x1B[35m$this\x1B[0m");
  String get toCyan => (AnsiPen()..cyan()).call("\x1B[36m$this\x1B[0m");
  String get toWhite => (AnsiPen()..white()).call("\x1B[37m$this\x1B[0m");
  String get toReset => (AnsiPen()..reset()).call("\x1B[0m$this\x1B[0m");
}
