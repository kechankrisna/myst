import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';
import 'package:myst/myst.dart';
import 'package:printx/printx.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;

class ModelCommand extends Command
    with YamlInformation
    implements GenerateClassInterface {
  @override
  String get description => "generate model in lib/models and test/models";

  @override
  String get name => "model";

  /// input from user and print help if null
  late String? inputName;

  /// generate class name as camel case style
  late String? className;

  /// generate file name as underscore lowercase style
  late String? fileName;

  @override
  List<String> get aliases => ['m'];

  ModelCommand() {
    /// ensure yaml load correctly
    ensureYamlInitialized();

    argParser.addOption("name",
        callback: (v) => inputName = className = v,
        help: "please enter the class name correctly");

    argParser.addOption("file",
        callback: (v) => fileName = v,
        help: "please enter the file name correctly");
  }

  @override
  run() {
    final watch = Stopwatch()..start();
    PrintX.cool("model start");

    /// in case user don't want to type --name then take the first input instead
    if (argResults!.arguments.isNotEmpty) {
      inputName ??= argResults!.arguments.first;

      className = (className ?? inputName)!.pascalCase;

      fileName ??= inputName!.snakeCase;

      printBlue("${argResults!.options}");
      printGreen([inputName, className, fileName]);

      /// generate model class in lib/models
      generateLib();

      /// generate model test class in test/models
      generateTest();
    } else {
      printCyan(usage);
    }

    PrintX.cool("model finished in (${watch.elapsedMilliseconds} ms)");
    watch.stop();
  }

  @override
  void generateLib() async {
    var contents = modelTemplate.replaceAll(RegExp(r"className"), className!);
    printCyan(contents);

    final _parent = "models";

    /// current file parent path
    final _parentLibPath = path.join(libraryPath, _parent, "$_parent.dart");

    /// current new file path
    final _filePath = path.join(libraryPath, _parent, "$fileName.dart");

    /// write content
    io.File(_filePath).writeAsStringSync(contents);

    /// printBlack(content);
    ///
    /// add to its parent lib if none exist

    var content = io.File(_parentLibPath).readAsStringSync();
    var exist = content.contains(RegExp("$fileName.dart"));
    if (!exist) {
      content += "\nexport './$fileName.dart';";
      io.File(_parentLibPath).writeAsStringSync(content);
    }
    printGreen("exist $exist");
  }

  @override
  void generateTest() {
    /// load content and repllace
    var contents = modelTestTemplate
        .replaceAll(RegExp(r"className"), className!)

        ///
        .replaceAll(RegExp(r"objectName"), className!.camelCase);

    if (flutter) {
      contents = contents.replaceAll(RegExp(r'package:test/test.dart'),
          'package:flutter_test/flutter_test.dart');
    }

    /// add import
    contents = contents.replaceAll(RegExp(r"_test.dart';"),
        "_test.dart';\nimport 'package:$projectName/models/$fileName.dart';");

    printCyan(contents);

    /// current new file path
    final _filePath = path.join(testPath, "models", "$fileName\_test.dart");

    /// write content
    io.File(_filePath).writeAsStringSync(contents);
  }
}
