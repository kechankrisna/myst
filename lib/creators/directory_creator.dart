import 'dart:io' as io;
import 'package:myst/interfaces/interfaces.dart';
import 'package:myst/myst.dart';

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
      if (!dir.existsSync()) {
        dir.createSync();
        printGreen("✓ $exactPath");
      } else {
        printGreen("☑ $exactPath");
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
