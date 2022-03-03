import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';
import 'package:myst/myst.dart';
import 'package:printx/printx.dart';

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

  /// split the dirname input into list of parts
  List<String> get dirNames =>
      dirName != null ? [...dirName!.split(RegExp(r"(\\|\/)"))] : [];

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
        return screenNoChildTemplate;
      case "sstl":
        return screenStatelessNotifierNoChildTemplate;
      case "stf":
        return screenStatefulNoChildTemplate;
      default:
        return screenNoChildTemplate;
    }
  }

  /// gererate multiple file for template
  void generateScreenLibFiles() async {
    /// final _dirName = fileName!;
    GenerateFileHelper(
      parentDir: parentDir,
      className: className!,
      projectName: projectName!,
    )

      /// file_name.dart
      ..generateLib(
        template: screenTemplate,
        fileName: fileName!,
        dirNames: [...dirNames, fileName!],
        shouldExport: false,
      )

      /// file_name_controller.dart
      ..generateLib(
        template: screenControllerTemplate,
        fileName: "${fileName!}_controller",
        dirNames: [...dirNames, fileName!],
        shouldExport: false,
      )

      /// file_name_service.dart
      ..generateLib(
        template: screenServiceTemplate,
        fileName: "${fileName!}_service",
        dirNames: [...dirNames, fileName!],
        shouldExport: false,
      )

      /// file_name_core.dart
      ..generateLib(
        template:
            "export '${fileName!}_service.dart';\nexport '${fileName!}_controller.dart';\nexport '${fileName!}.dart';",
        fileName: "${fileName!}_core.dart",
        dirNames: [...dirNames, fileName!],
        shouldExport: true,
      )

      /// file_name/widgets
      ..generateLibDir(name: "widgets", dirNames: [...dirNames, fileName!]);
  }

  /// generate multi files
  void generateScreenTestFiles() {
    /// final _dirName = fileName!;
    GenerateFileHelper(
      parentDir: parentDir,
      className: className!,
      projectName: projectName!,
    )

      /// file_name_test.dart
      ..generateTest(
        template: screenTestTemplate,
        fileName: fileName!,
        dirNames: [...dirNames, fileName!],
      )

      /// file_name_controller_test.dart
      ..generateTest(
        template: controllerTestTemplate.replaceAll(
            RegExp(r"className"), "${className!}Controller"),
        fileName: "${fileName!}_controller",
        dirNames: [...dirNames, fileName!],
      )

      /// file_name_service_test.dart
      ..generateTest(
        template: serviceTestTemplate.replaceAll(
            RegExp(r"className"), "${className!}Service"),
        fileName: "${fileName!}_service",
        dirNames: [...dirNames, fileName!],
      )

      /// file_name/widgets
      ..generateTestDir(name: "widgets", dirNames: [...dirNames, fileName!]);
  }

  @override
  void generateLib() {
    final template = getTemplate();
    GenerateFileHelper(
      parentDir: parentDir,
      className: className!,
      projectName: projectName!,
    ).generateLib(
      template: template,
      fileName: fileName!,
      dirNames: dirNames,
    );
  }

  @override
  void generateTest() {
    GenerateFileHelper(
      parentDir: parentDir,
      className: className!,
      projectName: projectName!,
    ).generateTest(
        template: screenTestTemplate, fileName: fileName!, dirNames: dirNames);
  }
}
