import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';
import 'package:myst/myst.dart';
import 'package:printx/printx.dart';

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

  /// split the dirname input into list of parts
  List<String> get dirNames =>
      dirName != null ? [...dirName!.split(RegExp(r"(\\|\/)"))] : [];

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
        return layoutStatelessNoChildTemplate;
      case "sstl":
        return layoutStatelessNotifierNoChildTemplate;
      case "stf":
        return layoutStatefulNoChildTemplate;
      default:
        return layoutStatelessNoChildTemplate;
    }
  }

  @override
  void generateLib() async {
    GenerateFileHelper(
      parentDir: parentDir,
      className: className!,
      projectName: projectName!,
    ).generateLib(
        template: getTemplate(), fileName: fileName!, dirNames: dirNames);
  }

  @override
  void generateTest() {
    GenerateFileHelper(
      parentDir: parentDir,
      className: className!,
      projectName: projectName!,
    ).generateTest(
        template: layoutNoChildTestTemplate, fileName: fileName!, dirNames: dirNames);
  }
}
