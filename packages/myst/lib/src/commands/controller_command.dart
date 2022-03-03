import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';
import 'package:myst/myst.dart';
import 'package:printx/printx.dart';

class ControllerCommand extends Command
    with YamlInformation
    implements GenerateClassInterface {
  @override
  String get description =>
      "generate controller in lib/controllers and test/controllers";

  @override
  String get name => "controller";

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

  final String parentDir = "controllers";

  @override
  List<String> get aliases => ['c'];

  /// controller

  ControllerCommand() {
    argParser.addOption("name",
        callback: (v) => inputName = className = v,
        help: "please enter the class name correctly");

    argParser.addOption("file",
        callback: (v) => fileName = v,
        help: "please enter the file name correctly");

    argParser.addOption("dir",
        callback: (v) => dirName = v,
        help: "please enter the class name correctly");

    argParser.addFlag("rewrite",
        callback: (value) => rewrite = value, defaultsTo: false);
  }

  @override
  run() {
    /// ensure yaml load correctly
    ensureYamlInitialized();

    /// split rewrite config if exist in myst.yaml
    if (controllerConfig != null) {
      if (controllerConfig!.containsKey("rewrite") == true) {
        rewrite = controllerConfig!['rewrite'];
      }
    }

    final watch = Stopwatch()..start();
    PrintX.cool("controller start");

    /// in case user don't want to type --name then take the first input instead
    if (argResults!.arguments.isNotEmpty) {
      inputName ??= argResults!.arguments.first;

      className = (className ?? inputName)!.pascalCase;

      fileName ??= inputName!.snakeCase;

      /// printBlue("${argResults!.options}");
      /// printGreen([inputName, className, fileName]);

      /// generate controller class in lib/controllers
      generateLib();

      /// generate controller test class in test/controllers
      generateTest();
    } else {
      printCyan(usage);
    }

    PrintX.cool("controller finished in (${watch.elapsedMilliseconds} ms)");
    watch.stop();
  }

  @override
  void generateLib() async {
    GenerateFileHelper(
      parentDir: parentDir,
      className: className!,
      projectName: projectName!,
    ).generateLib(
        template: controllerTemplate, fileName: fileName!, dirNames: dirNames);
  }

  @override
  void generateTest() {
    GenerateFileHelper(
      parentDir: parentDir,
      className: className!,
      projectName: projectName!,
    ).generateTest(
        template: controllerTestTemplate,
        fileName: fileName!,
        dirNames: dirNames);
  }
}
