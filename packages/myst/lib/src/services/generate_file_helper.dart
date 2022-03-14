import 'package:myst/myst.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;
import 'package:printx/printx.dart';
import 'package:recase/recase.dart';

class GenerateFileHelper {
  late String className;
  late String projectName;
  late String? parentDir;

  ///
  late String currentPath;
  late String libraryPath;
  late String testPath;

  GenerateFileHelper({
    required this.className,
    required this.projectName,
    this.parentDir,
  }) {
    /// current project path
    currentPath = io.Directory.current.path;

    /// its lib path
    libraryPath = path.join(currentPath, 'lib');

    testPath = path.join(currentPath, 'test');
  }

  String generateLib({
    required String template,
    required String fileName,
    List<String> dirNames = const [],

    /// String? dirName,
    bool rewrite = false,

    ///
    bool flutter = true,

    /// should export current file to its core lib
    bool shouldExport = true,
  }) {
    var contents = template
        .replaceAll(RegExp(r"className"), className)
        .replaceAll(RegExp(r"objectName"), className.camelCase)
        .replaceAll(RegExp(r"projectName"), projectName);

    /// if user input directory name,
    /// then create the new sub directory if not exists

    /// TODO: old
    /// if (dirName != null) {
    ///   DirectoryCreator(path.join(libraryPath, parentDir, dirName)).run();
    /// }

    DirectoryCreator(path.joinAll(
        [libraryPath, if (parentDir != null) parentDir!, ...dirNames])).run();

    /// current file parent path
    final _parentLibPath = path.joinAll([
      libraryPath,
      if (parentDir != null) ...[parentDir!, "${parentDir!}.dart"]
    ]);

    /// printRed("_parentLibPath $_parentLibPath");

    /// current new file path
    final _filePath = path.joinAll([
      libraryPath,
      if (parentDir != null) parentDir!,
      ...dirNames,
      "$fileName.dart"
    ]);

    FileCreator(_filePath, contents: contents, rewrite: rewrite);

    /// write content
    FileCreator(_filePath, contents: contents, rewrite: rewrite).run();

    /// printCyan(content);

    /// add to its parent lib if none exist
    if (_parentLibPath != libraryPath) {
      var content = io.File(_parentLibPath).readAsStringSync();
      var exist = content.contains(RegExp("$fileName.dart"));
      if (!exist && shouldExport) {
        content +=
            "\nexport '${dirNames.isNotEmpty ? (dirNames.join("/") + "/") : ""}$fileName.dart';";

        /// force to rewrite
        FileCreator(_parentLibPath, contents: content, rewrite: true).run();
      }
    }

    return _filePath;
  }

  String generateTest({
    required String template,
    required String fileName,
    List<String> dirNames = const [],

    /// String? dirName,
    bool rewrite = false,
    bool flutter = true,
  }) {
    /// load content and repllace
    var contents = template
        .replaceAll(RegExp(r"className"), className)
        .replaceAll(RegExp(r"objectName"), className.camelCase)
        .replaceAll(RegExp(r"projectName"), projectName);

    if (flutter) {
      contents = contents.replaceAll(RegExp(r'package:test/test.dart'),
          'package:flutter_test/flutter_test.dart');
    }

    /// add import
    contents = contents.replaceAll(RegExp(r"_test.dart';"),
        "_test.dart'; \nimport 'package:$projectName/core.dart';\n");

    /// printCyan(contents);

    /// if user input directory name,
    /// then create the new sub directory if not exists

    /// TODO: old
    /// if (dirName != null) {
    ///   DirectoryCreator(path.join(testPath, parentDir, dirName)).run();
    /// }
    DirectoryCreator(path.joinAll(
        [testPath, if (parentDir != null) parentDir!, ...dirNames])).run();

    /// current new file path
    /// TODO: old
    /// final _filePath = dirName != null
    ///     ? path.join(testPath, parentDir, dirName, "${fileName}_test.dart")
    ///     : path.join(testPath, parentDir, "${fileName}_test.dart");

    final _filePath = path.joinAll([
      testPath,
      if (parentDir != null) parentDir!,
      ...dirNames,
      "${fileName}_test.dart"
    ]);

    /// write content
    FileCreator(_filePath, contents: contents, rewrite: rewrite).run();

    return _filePath;
  }

  String generateLibDir({
    required String name,
    List<String> dirNames = const [],
  }) {
    String dirPath = path.joinAll(
        [libraryPath, if (parentDir != null) parentDir!, ...dirNames, name]);
    DirectoryCreator(dirPath).run();
    return dirPath;
  }

  String generateTestDir({
    required String name,
    List<String> dirNames = const [],
  }) {
    String dirPath = path.joinAll(
        [testPath, if (parentDir != null) parentDir!, ...dirNames, name]);
    DirectoryCreator(dirPath).run();
    return dirPath;
  }
}
