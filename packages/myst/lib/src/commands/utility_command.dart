import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';
import 'package:myst/myst.dart';
import 'package:printx/printx.dart';

class UtilityCommand extends Command
    with YamlInformation
    implements GenerateClassInterface {
  @override
  String get description =>
      "generate utility in lib/utilities and test/utilities";

  @override
  String get name => "util";

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

  final String parentDir = "utilities";

  @override
  List<String> get aliases => ['u'];

  /// abstract

  UtilityCommand() {
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
    if (utilityConfig != null) {
      if (utilityConfig!.containsKey("rewrite") == true) {
        rewrite = utilityConfig!['rewrite'];
      }
    }

    final watch = Stopwatch()..start();
    PrintX.cool("utility start");

    /// in case user don't want to type --name then take the first input instead
    if (argResults!.arguments.isNotEmpty) {
      inputName ??= argResults!.arguments.first;

      className = (className ?? inputName)!.pascalCase;

      fileName ??= inputName!.snakeCase;

      /// printBlue("${argResults!.options}");
      /// printGreen([inputName, className, fileName]);

      /// generate utility class in lib/utilities
      generateLib();

      /// generate utility test class in test/utilities
      generateTest();
    } else {
      printCyan(usage);
    }

    PrintX.cool("utility finished in (${watch.elapsedMilliseconds} ms)");
    watch.stop();
  }

  @override
  void generateLib() async {
    GenerateFileHelper(
      parentDir: parentDir,
      className: className!,
      projectName: projectName!,
    )
      ..generateLib(
        /// template: utilityTemplate,
        template: """export 'src/${fileName}_none.dart'
    if (dart.library.io) 'src/${fileName}_io.dart'
    if (dart.library.html) 'src/${fileName}_html.dart';""",
        fileName: fileName!,
        dirNames: [...dirNames, fileName!],
      )
      ..generateLib(
        template: utilityTemplate,
        dirNames: [...dirNames, fileName!, "src"],
        fileName: "${fileName!}_none",
        shouldExport: false,
      )
      ..generateLib(
        template: utilityTemplate,
        dirNames: [...dirNames, fileName!, "src"],
        fileName: "${fileName!}_io",
        shouldExport: false,
      )
      ..generateLib(
        template: utilityTemplate,
        dirNames: [...dirNames, fileName!, "src"],
        fileName: "${fileName!}_html",
        shouldExport: false,
      );
  }

  @override
  void generateTest() {
    GenerateFileHelper(
      parentDir: parentDir,
      className: className!,
      projectName: projectName!,
    ).generateTest(
        template: utilityTestTemplate, fileName: fileName!, dirNames: dirNames);
  }
}
