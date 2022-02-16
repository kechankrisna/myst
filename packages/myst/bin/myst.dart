import 'dart:io' as io;
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:myst/myst.dart' as myst;
import "package:os_detect/os_detect.dart" as os;
import 'package:printx/printx.dart';

void main(List<String> arguments) {
  var parser = ArgParser()
    ..addOption("name", abbr: 'n', help: "class name")
    ..addOption("dir", abbr: 'd', help: "directory name")
    ..addOption("file",
        abbr: 'f', help: "file name will be use instead of class name")
    ..addFlag("rewrite", defaultsTo: false)
    ..addFlag("version",
        defaultsTo: false,
        abbr: 'v',
        aliases: ['v'],
        help: 'Display the current myst version')
    ..addFlag('help',
        abbr: 'h',
        help: 'Display the usage information',
        hide: true,
        defaultsTo: false);

  var results = parser.parse(arguments);

  final runner =
      CommandRunner("myst", "dart package to generate nice flutter structure");

  /// display version
  if (results.arguments.contains("--version")) {
    printCyan(
        "myst: ${myst.version} (${DateTime.now().toLocal()}) on ${os.operatingSystem}");
    return;
  }

  /// add generate command to generate structure
  runner.addCommand(myst.InitCommand());

  /// repair export in lib directory
  runner.addCommand(myst.RepairCommand());

  /// add model command to generate model and its test
  runner.addCommand(myst.ModelCommand());

  /// add interface command to generate interface and its test
  runner.addCommand(myst.InterfaceCommand());

  /// add extension command to generate extension parsing and its test
  runner.addCommand(myst.ExtensionCommand());

  /// add controller command to generate controller and its test
  runner.addCommand(myst.ControllerCommand());

  runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    printRed(error);
    io.exit(64); // Exit code 64 indicates a usage error.
  });
}
