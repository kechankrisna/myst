// ignore_for_file: unnecessary_this

import 'dart:io' as io;
import 'package:myst/myst.dart';
import 'package:printx/printx.dart';

class FileCreator extends FileCreatorInterface {
  late bool replace;

  FileCreator(
    String path, {
    String? contents,
    bool? replace,
  }) {
    this.path = path;
    this.contents = contents;
    this.replace = replace ?? false;
  }

  @override
  bool run() {
    final file = io.File(path);
    final current = io.Directory.current.path;
    final String exactPath = path.split(RegExp("$current/")).last;
    try {
      if (!file.existsSync()) {
        file.createSync();
        printGreen("✓ $exactPath");
      } else {
        printGreen("☑ $exactPath");
      }

      /// if content not empty then insert
      if (contents != null && replace == true) {
        file.writeAsStringSync(contents!);
      }

      return true;
    } catch (e) {
      printRed("❌ $path -> $e");
      return false;
    }
  }
}
