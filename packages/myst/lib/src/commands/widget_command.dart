import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';
import 'package:myst/myst.dart';
import 'package:printx/printx.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;

class WidgetCommand extends Command
    with YamlInformation
    implements GenerateClassInterface {
  @override
  String get description => "generate widget in lib/widgets and test/widgets";

  @override
  String get name => "widget";

  /// input from user and print help if null
  late String? inputName;

  /// generate class name as camel case style
  late String? className;

  /// generate file name as underscore lowercase style
  late String? fileName;

  /// directory from user and print help if null
  late String? dirName;

  /// template from user and print help if null
  late String? templateName;

  final String parentDir = "widgets";

  @override
  List<String> get aliases => ['w'];

  /// Xtension

  WidgetCommand() {
    argParser.addOption("name",
        callback: (v) => inputName = className = v,
        help: "please enter the class name correctly");

    argParser.addOption("file",
        callback: (v) => fileName = v,
        help: "please enter the file name correctly");

    argParser.addOption("dir",
        callback: (v) => dirName = v,
        help: "please enter the directory name correctly");

    argParser.addOption("template",
        callback: (v) => templateName = v,
        help: "please enter the template name correctly",
        allowed: [
          "stl",
          "sstl",
          "stf",
        ],
        allowedHelp: {
          "stl": "stateless widget",
          "sstl": "stateless widget with change notifier for state management",
          "stf": "stateful widget when its contain its own state",
        });

    argParser.addFlag("rewrite",
        callback: (value) => rewrite = value, defaultsTo: false);
  }

  @override
  run() {
    /// ensure yaml load correctly
    ensureYamlInitialized();

    /// split rewrite config if exist in myst.yaml
    if (widgetConfig != null) {
      if (widgetConfig!.containsKey("rewrite") == true) {
        rewrite = widgetConfig!['rewrite'];
      }
    }

    final watch = Stopwatch()..start();
    PrintX.cool("widget start");

    /// in case user don't want to type --name then take the first input instead
    if (argResults!.arguments.isNotEmpty) {
      inputName ??= argResults!.arguments.first;

      className = (className ?? inputName)!.pascalCase;

      fileName ??= inputName!.snakeCase;

      /// printBlue("${argResults!.options}");
      /// printGreen([inputName, className, fileName]);

      /// generate widget class in lib/widgets
      generateLib();

      /// generate widget test class in test/widgets
      generateTest();
    } else {
      printCyan(usage);
    }

    PrintX.cool("widget finished in (${watch.elapsedMilliseconds} ms)");
    watch.stop();
  }

  /// get template of current file
  String getTemplate() {
    switch (templateName) {
      case "stl":
        return layoutStatelessTemplate;
      case "sstl":
        return layoutStatelessNotifierTemplate;  
      case "stf":
        return layoutStatefulTemplate;
      default:
        return layoutStatelessTemplate;
    }
  }

  @override
  void generateLib() async {
    String contents = "import 'package:$projectName/core.dart';\n" +
        getTemplate().replaceAll(RegExp(r"className"), className!);

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
    var contents = layoutTestTemplate
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
