import 'package:args/command_runner.dart';
import 'package:myst/myst.dart';
import 'package:printx/printx.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

class RepairCommand extends Command with YamlInformation {
  @override
  String get description => "repair any export directory";

  @override
  String get name => "repair";

  /// directory from user and print help if null
  late String? dirName;

  @override
  List<String> get aliases => ['r'];

  RepairCommand() {
    argParser.addOption("dir",
        callback: (v) => dirName = v,
        help: "please enter the class name correctly");

    argParser.addFlag("rewrite",
        callback: (value) => rewrite = value, defaultsTo: true);
  }

  @override
  run() async {
    /// ensure yaml load correctly
    ensureYamlInitialized();

    final watch = Stopwatch()..start();
    PrintX.cool("repair start");

    /// in case user don't want to type --name then take the first input instead
    if (argResults!.arguments.isNotEmpty) {
      dirName ??= argResults!.arguments.first;

      /// printBlue("${argResults!.options}");
      /// printGreen([dirName]);
    }

    /// start to repair export

    await repairExport();

    PrintX.cool("repair finished in (${watch.elapsedMilliseconds} ms)");
    watch.stop();
  }

  Future<void> repairExport() async {
    /// if none dir name specify, then repair for all
    var structures = [
      ...ApplicationConfig.skeleton,
      if (flutter) ...[ApplicationConfig.widgets, ApplicationConfig.providers]
    ];
    List<String> _paths = (structures.map((e) => e.path).toList());

    bool existDir = dirName == null
        ? false
        : (dirName!.endsWith("s")
            ? _paths.contains(dirName!)
            : _paths.contains("${dirName!}s"));

    final skelentons = existDir
        ? [
            structures.firstWhere((e) =>
                e.path == (dirName!.endsWith("s") ? dirName! : "${dirName}s"))
          ]
        : structures;
    for (var directory in skelentons) {
      final _innerLibPath = path.join(libraryPath, directory.path);
      var createdDir = DirectoryCreator(_innerLibPath).run();

      YamlMap? directoryConfig = mystYaml[directory.path];
      List<RegExp> includedRegex = [];
      List<RegExp> excludedRegex = [];
      if (directoryConfig != null) {
        if (directoryConfig.containsKey("included") == true) {
          includedRegex = (directoryConfig['included'] as YamlList)
              .map((e) => RegExp(e))
              .toList();
        }
        if (directoryConfig.containsKey("excluded") == true) {
          excludedRegex = (directoryConfig['excluded'] as YamlList)
              .map((e) => RegExp(e))
              .toList();
        }
      }

      if (createdDir) {
        var missExports = <String>[];

        var scan = scanningFilesWithAsyncRecursive(io.Directory(_innerLibPath));

        for (var f in (await scan.toList())) {
          var _path = f.path.split(RegExp("$_innerLibPath/")).last;

          if (_path != "${directory.path}.dart") {
            /// if any include expression exist then check otherwise true all
            /// and check with exclude expression if exist
            bool _canBeIncluded = (includedRegex.isEmpty
                    ? true
                    : (includedRegex
                        .where((regex) => _path.contains(regex))
                        .isNotEmpty)) &&
                (excludedRegex.where((regex) => _path.contains(regex)).isEmpty);
            if (_canBeIncluded) {
              missExports.add(_path);
            }
          }
        }

        /// lib file
        for (var innerFile in directory.inners) {
          final _currentLibFilePath = path.join(_innerLibPath, innerFile.path);
          var innerFileContent = innerFile.contents!;
          if (missExports.isNotEmpty) {
            innerFileContent +=
                missExports.map((f) => "\nexport '$f';").join('');
          }
          FileCreator(_currentLibFilePath,
                  contents: innerFileContent, rewrite: rewrite)
              .run();
        }
      }
    }
  }
}
