import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';
import 'package:myst/myst.dart';
import 'package:printx/printx.dart';

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
    ensureYamlInitialized();

    argParser.addOption("name",
        callback: (v) => inputName = className = v,
        help: "please enter the class name correctly");

    argParser.addOption("file",
        callback: (v) => fileName = v,
        help: "please enter the file name correctly");

    PrintX.sucess("generate model success");
  }

  @override
  run() {
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
  }

  @override
  void generateLib() {
    // TODO: implement generateLib
  }

  @override
  void generateTest() {
    // TODO: implement generateTest
  }
}
