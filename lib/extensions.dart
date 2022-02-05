library extensions;

import 'dart:io' as io;

/// colorize text in cli print out
extension StringParsing on String {
  bool get isSupportCli => !io.stdout.supportsAnsiEscapes;

  String get toBack => !isSupportCli ? this : "\x1B[30m$this\x1B[0m";
  String get toRed => !isSupportCli ? this : "\x1B[31m$this\x1B[0m";
  String get toGreen => !isSupportCli ? this : "\x1B[32m$this\x1B[0m";
  String get toYellow => !isSupportCli ? this : "\x1B[33m$this\x1B[0m";
  String get toBlue => !isSupportCli ? this : "\x1B[34m$this\x1B[0m";
  String get toMagenta => !isSupportCli ? this : "\x1B[35m$this\x1B[0m";
  String get toCyan => !isSupportCli ? this : "\x1B[36m$this\x1B[0m";
  String get toWhite => !isSupportCli ? this : "\x1B[37m$this\x1B[0m";
  String get toReset => !isSupportCli ? this : "\x1B[0m$this\x1B[0m";
}
