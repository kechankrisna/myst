// ignore_for_file: unnecessary_this

import 'dart:io' as io;
import 'package:myst/myst.dart';
import 'package:printx/printx.dart';

class FileCreator extends FileCreatorInterface {
  late bool rewrite;

  FileCreator(
    String path, {
    String? contents,
    bool? rewrite,
  }) {
    this.path = path;
    this.contents = contents;
    this.rewrite = rewrite ?? false;
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
      if (contents != null && rewrite == true) {
        file.writeAsStringSync(contents!);
      }

      return true;
    } catch (e) {
      printRed("❌ $path -> $e");
      return false;
    }
  }
}
