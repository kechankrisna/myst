import 'dart:io' as io;
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:myst/myst.dart' as myst;

void main(List<String> arguments) {
  var parser = ArgParser()
    ..addOption("name", abbr: 'n', help: "class name")
    ..addOption("file", abbr: 'f', help: "file name")
    ..addFlag("replace", defaultsTo: false)
    ..addFlag('help', abbr: 'h', help: 'increase logging', hide: true, defaultsTo: false);

  var results = parser.parse(arguments);

  final runner =
      CommandRunner("myst", "dart package to generate nice flutter structure");

  /// add generate command to generate structure
  runner.addCommand(myst.InitCommand());
  runner.addCommand(myst.ModelCommand());

  runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    io.exit(64); // Exit code 64 indicates a usage error.
  });
}
