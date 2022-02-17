import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';
import 'package:myst/myst.dart';
import 'package:printx/printx.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;

class ExtensionCommand extends Command
    with YamlInformation
    implements GenerateClassInterface {
  @override
  String get description =>
      "generate extension in lib/extensions and test/extensions";

  @override
  String get name => "extension";

  /// input from user and print help if null
  late String? inputName;

  /// generate class name as camel case style
  late String? className;

  /// generate file name as underscore lowercase style
  late String? fileName;

  /// directory from user and print help if null
  late String? dirName;

  final String parentDir = "extensions";

  @override
  List<String> get aliases => ['x'];

  /// Xtension

  ExtensionCommand() {
    argParser.addOption("name",
        callback: (v) => inputName = className = v,
        help: "please enter the class name correctly");

    argParser.addOption("file",
        callback: (v) => fileName = v,
        help: "please enter the file name correctly");

    argParser.addOption("dir",
        callback: (v) => dirName = v,
        help: "please enter the directory name correctly");

    argParser.addFlag("rewrite",
        callback: (value) => rewrite = value, defaultsTo: false);
  }

  @override
  run() {
    /// ensure yaml load correctly
    ensureYamlInitialized();

    /// split rewrite config if exist in myst.yaml
    if (extensionConfig != null) {
      if (extensionConfig!.containsKey("rewrite") == true) {
        rewrite = extensionConfig!['rewrite'];
      }
    }

    final watch = Stopwatch()..start();
    PrintX.cool("extension start");

    /// in case user don't want to type --name then take the first input instead
    if (argResults!.arguments.isNotEmpty) {
      inputName ??= argResults!.arguments.first;

      className = (className ?? inputName)!.pascalCase;

      fileName ??= inputName!.snakeCase;

      /// printBlue("${argResults!.options}");
      /// printGreen([inputName, className, fileName]);

      /// generate extension class in lib/extensions
      generateLib();

      /// generate extension test class in test/extensions
      generateTest();
    } else {
      printCyan(usage);
    }

    PrintX.cool("extension finished in (${watch.elapsedMilliseconds} ms)");
    watch.stop();
  }

  @override
  void generateLib() async {
    var contents =
        extensionTemplate.replaceAll(RegExp(r"className"), className!);

    /// if user input directory name,
    /// then create the new sub directory if not exists
    if (dirName != null) {
      DirectoryCreator(path.join(libraryPath, parentDir, dirName)).run();
    }

    /// current file parent path
    final _parentLibPath = path.join(libraryPath, parentDir, "$parentDir.dart");

    /// current new file path
    final _filePath = dirName != null
        ? path.join(libraryPath, parentDir, dirName, "$fileName.dart")
        : path.join(libraryPath, parentDir, "$fileName.dart");

    FileCreator(_filePath, contents: contents, rewrite: rewrite);

    /// write content
    FileCreator(_filePath, contents: contents, rewrite: rewrite).run();

    /// printCyan(content);

    /// add to its parent lib if none exist
    var content = io.File(_parentLibPath).readAsStringSync();
    var exist = content.contains(RegExp("$fileName.dart"));
    if (!exist) {
      content += dirName == null
          ? "\nexport '$fileName.dart';"
          : "\nexport '$dirName/$fileName.dart';";

      /// force to rewrite
      FileCreator(_parentLibPath, contents: content, rewrite: true).run();
    }
  }

  @override
  void generateTest() {
    /// load content and repllace
    var contents = extensionTestTemplate
        .replaceAll(RegExp(r"className"), className!)
        .replaceAll(RegExp(r"objectName"), className!.camelCase);

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
    if (dirName != null) {
      DirectoryCreator(path.join(testPath, parentDir, dirName)).run();
    }

    /// current new file path
    final _filePath = dirName != null
        ? path.join(testPath, parentDir, dirName, "${fileName}_test.dart")
        : path.join(testPath, parentDir, "${fileName}_test.dart");

    /// write content
    FileCreator(_filePath, contents: contents, rewrite: rewrite).run();
  }
}
