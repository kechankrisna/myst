import 'dart:io' as io;
import 'package:myst/myst.dart';
import 'package:printx/printx.dart';

class DirectoryCreator extends DirectoryCreatorInterface {
  DirectoryCreator(String path, {List<FileCreator> inners = const []}) {
    this.path = path;
    this.inners = inners;
  }

  @override
  bool run() {
    final dir = io.Directory(path);
    final current = io.Directory.current.path;
    final String exactPath = path.split(RegExp("$current/")).last;
    try {
      bool isNew = false;
      if (!dir.existsSync()) {
        isNew = true;
        dir.createSync();
        printGreen("✓ $exactPath");
      } else {
        printYellow("✓ $exactPath");
      }

      /// create inner files
      for (var file in inners) {
        file.run();
      }
      return true;
    } catch (e) {
      printRed("❌ $path -> $e");
      return false;
    }
  }
}
