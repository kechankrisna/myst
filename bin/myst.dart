import 'dart:io' as io;
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:myst/myst.dart' as myst;

void main(List<String> arguments) {
  var parser = ArgParser()
    ..addOption("name")
    ..addFlag("replace", defaultsTo: false)
    ..addOption('help', abbr: 'h', help: 'increase logging');

  var results = parser.parse(arguments);

  final runner =
      CommandRunner("myst", "dart package to generate nice flutter structure");

  /// add generate command to generate structure
  runner.addCommand(myst.InitCommand());

  runner.run(results.arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    io.exit(64); // Exit code 64 indicates a usage error.
  });
}
