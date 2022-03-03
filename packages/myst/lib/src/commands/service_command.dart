import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';
import 'package:myst/myst.dart';
import 'package:printx/printx.dart';

class ServiceCommand extends Command
    with YamlInformation
    implements GenerateClassInterface {
  @override
  String get description =>
      "generate service in lib/services and test/services";

  @override
  String get name => "service";

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

  final String parentDir = "services";

  @override
  List<String> get aliases => ['s'];

  /// abstract

  ServiceCommand() {
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
    if (serviceConfig != null) {
      if (serviceConfig!.containsKey("rewrite") == true) {
        rewrite = serviceConfig!['rewrite'];
      }
    }

    final watch = Stopwatch()..start();
    PrintX.cool("service start");

    /// in case user don't want to type --name then take the first input instead
    if (argResults!.arguments.isNotEmpty) {
      inputName ??= argResults!.arguments.first;

      className = (className ?? inputName)!.pascalCase;

      fileName ??= inputName!.snakeCase;

      /// printBlue("${argResults!.options}");
      /// printGreen([inputName, className, fileName]);

      /// generate service class in lib/services
      generateLib();

      /// generate service test class in test/services
      generateTest();
    } else {
      printCyan(usage);
    }

    PrintX.cool("service finished in (${watch.elapsedMilliseconds} ms)");
    watch.stop();
  }

  @override
  void generateLib() async {
    GenerateFileHelper(
      parentDir: parentDir,
      className: className!,
      projectName: projectName!,
    ).generateLib(
        template: serviceTemplate, fileName: fileName!, dirNames: dirNames);
  }

  @override
  void generateTest() {
    /// use helper service to implement geneate file
    GenerateFileHelper(
      parentDir: parentDir,
      className: className!,
      projectName: projectName!,
    ).generateTest(
        template: serviceTestTemplate, fileName: fileName!, dirNames: dirNames);
  }
}
