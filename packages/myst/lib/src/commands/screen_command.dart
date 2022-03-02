import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';
import 'package:myst/myst.dart';
import 'package:printx/printx.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;

class ScreenCommand extends Command
    with YamlInformation
    implements GenerateClassInterface {
  @override
  String get description => "generate screen in lib/screens and test/screens";

  @override
  String get name => "screen";

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

  final String parentDir = "screens";

  @override
  List<String> get aliases => ['sc'];

  /// Xtension

  ScreenCommand() {
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
          "mvc",
        ],
        allowedHelp: {
          "stl": "stateless widget",
          "sstl": "stateless widget with change notifier for state management",
          "stf": "stateful widget when its contain its own state",
          "mvc": "split stateless widget, controller, service and (widgets)"
        });

    argParser.addFlag("rewrite",
        callback: (value) => rewrite = value, defaultsTo: false);
  }

  @override
  run() {
    /// ensure yaml load correctly
    ensureYamlInitialized();

    /// split rewrite config if exist in myst.yaml
    if (screenConfig != null) {
      if (screenConfig!.containsKey("rewrite") == true) {
        rewrite = screenConfig!['rewrite'];
      }

      if (screenConfig!.containsKey("template") == true) {
        templateName = screenConfig!['template'];
      }
    }

    final watch = Stopwatch()..start();
    PrintX.cool("screen start");

    /// in case user don't want to type --name then take the first input instead
    if (argResults!.arguments.isNotEmpty) {
      inputName ??= argResults!.arguments.first;

      className = (className ?? inputName)!.pascalCase;

      fileName ??= inputName!.snakeCase;

      /// printBlue("${argResults!.options}");
      /// printGreen([inputName, className, fileName]);

      /// generate screen class in lib/screens
      if (templateName == "mvc") {
        ///
        generateScreenLibFiles();

        generateScreenTestFiles();
      } else {
        generateLib();

        /// generate screen test class in test/screens
        generateTest();
      }
    } else {
      printCyan(usage);
    }

    PrintX.cool("screen finished in (${watch.elapsedMilliseconds} ms)");
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

  /// gererate multiple file for template
  void generateScreenLibFiles() async {
    String screenContents = "import 'package:$projectName/core.dart';\n" +
        screenTemplate.replaceAll(RegExp(r"className"), className!);
    String screenControllerContents =
        "import 'package:$projectName/core.dart';\nimport 'package:flutter/foundation.dart';\n" +
            screenControllerTemplate.replaceAll(
                RegExp(r"className"), className!);
    String screenServiceContents =
        screenServiceTemplate.replaceAll(RegExp(r"className"), className!);
    String screenCoreContents =
        screenCoreTemplate.replaceAll(RegExp(r"fileName"), fileName!);

    /// if user input directory name,
    /// then create the new sub directory if not exists
    if (dirName != null) {
      DirectoryCreator(path.join(libraryPath, parentDir, dirName)).run();
      DirectoryCreator(path.join(libraryPath, parentDir, dirName, fileName))
          .run();
      DirectoryCreator(
              path.join(libraryPath, parentDir, dirName, fileName, "widgets"))
          .run();
    } else {
      DirectoryCreator(path.join(libraryPath, parentDir, fileName)).run();
      DirectoryCreator(path.join(libraryPath, parentDir, fileName, "widgets"))
          .run();
    }

    /// current file parent path
    final _parentLibPath = path.join(libraryPath, parentDir, "$parentDir.dart");

    /// current new file paths
    final _screenfilePath = dirName != null
        ? path.join(libraryPath, parentDir, dirName, fileName, "$fileName.dart")
        : path.join(libraryPath, parentDir, fileName, "$fileName.dart");
    final _servicefilePath = dirName != null
        ? path.join(libraryPath, parentDir, dirName, fileName,
            "${fileName}_service.dart")
        : path.join(
            libraryPath, parentDir, fileName, "${fileName}_service.dart");
    final _controllerfilePath = dirName != null
        ? path.join(libraryPath, parentDir, dirName, fileName,
            "${fileName}_controller.dart")
        : path.join(
            libraryPath, parentDir, fileName, "${fileName}_controller.dart");
    final _corefilePath = dirName != null
        ? path.join(
            libraryPath, parentDir, dirName, fileName, "${fileName}_core.dart")
        : path.join(libraryPath, parentDir, fileName, "${fileName}_core.dart");

    /// write content
    ///
    FileCreator(_screenfilePath, contents: screenContents, rewrite: rewrite)
        .run();
    FileCreator(_servicefilePath,
            contents: screenServiceContents, rewrite: rewrite)
        .run();
    FileCreator(_controllerfilePath,
            contents: screenControllerContents, rewrite: rewrite)
        .run();
    FileCreator(_corefilePath, contents: screenCoreContents, rewrite: rewrite)
        .run();

    /// add to its parent lib if none exist
    var content = io.File(_parentLibPath).readAsStringSync();
    var exist = content.contains(RegExp("${fileName}_core.dart"));
    if (!exist) {
      content += dirName == null
          ? "\nexport '$fileName/${fileName}_core.dart';"
          : "\nexport '$dirName/$fileName/${fileName}_core.dart';";

      /// force to rewrite
      FileCreator(_parentLibPath, contents: content, rewrite: true).run();
    }
  }

  /// generate multi files
  void generateScreenTestFiles() {
    /// load content and repllace
    var screenContents = layoutTestTemplate
        .replaceAll(RegExp(r"className"), className!)
        .replaceAll(RegExp(r"objectName"), className!.camelCase);
    var screenControllerContents = controllerTestTemplate
        .replaceAll(RegExp(r"className"), "${className!}Controller")
        .replaceAll(RegExp(r"objectName"), className!.camelCase);
    var screenServiceContents = serviceTestTemplate
        .replaceAll(RegExp(r"className"), "${className!}Service")
        .replaceAll(RegExp(r"objectName"), className!.camelCase);

    if (flutter) {
      screenContents = screenContents.replaceAll(
          RegExp(r'package:test/test.dart'),
          'package:flutter_test/flutter_test.dart');
      screenControllerContents = screenControllerContents.replaceAll(
          RegExp(r'package:test/test.dart'),
          'package:flutter_test/flutter_test.dart');
      screenServiceContents = screenServiceContents.replaceAll(
          RegExp(r'package:test/test.dart'),
          'package:flutter_test/flutter_test.dart');
    }

    /// add import
    screenContents = screenContents.replaceAll(RegExp(r"_test.dart';"),
        "_test.dart'; \nimport 'package:$projectName/core.dart';\n");
    screenServiceContents = screenServiceContents.replaceAll(
        RegExp(r"_test.dart';"),
        "_test.dart'; \nimport 'package:$projectName/core.dart';\n");
    screenControllerContents = screenControllerContents.replaceAll(
        RegExp(r"_test.dart';"),
        "_test.dart'; \nimport 'package:$projectName/core.dart';\n");

    /// printCyan(contents);

    /// if user input directory name,
    /// then create the new sub directory if not exists
    if (dirName != null) {
      DirectoryCreator(path.join(testPath, parentDir, dirName)).run();
      DirectoryCreator(path.join(testPath, parentDir, dirName, fileName)).run();
      DirectoryCreator(
              path.join(testPath, parentDir, dirName, fileName, "widgets"))
          .run();
    } else {
      DirectoryCreator(path.join(testPath, parentDir, fileName)).run();
      DirectoryCreator(path.join(testPath, parentDir, fileName, "widgets"))
          .run();
    }

    /// current new file path
    final _screenFilePath = dirName != null
        ? path.join(
            testPath, parentDir, dirName, fileName, "${fileName}_test.dart")
        : path.join(testPath, parentDir, fileName, "${fileName}_test.dart");
    final _servicefilePath = dirName != null
        ? path.join(testPath, parentDir, dirName, fileName,
            "${fileName}_service_test.dart")
        : path.join(
            testPath, parentDir, fileName, "${fileName}_service_test.dart");
    final _controllerfilePath = dirName != null
        ? path.join(testPath, parentDir, dirName, fileName,
            "${fileName}_controller_test.dart")
        : path.join(
            testPath, parentDir, fileName, "${fileName}_controller_test.dart");

    /// write content
    FileCreator(_screenFilePath, contents: screenContents, rewrite: rewrite)
        .run();
    FileCreator(_servicefilePath,
            contents: screenServiceContents, rewrite: rewrite)
        .run();
    FileCreator(_controllerfilePath,
            contents: screenControllerContents, rewrite: rewrite)
        .run();
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
