import 'dart:convert';
import 'package:args/command_runner.dart';
import 'package:myst/myst.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;
import 'package:printx/printx.dart';
import 'package:yaml/yaml.dart';

class InitCommand extends Command {
  @override
  String get description => "generate structure of flutter application";

  @override
  String get name => "init";

  @override
  List<String> get aliases => ['i'];

  /// current project pubspec
  late io.File pubspec;

  /// current project pubspecEntries
  late dynamic pubspecEntries;

  /// current project name
  late String? projectName;

  /// current project verison
  late String? projectVersion;

  /// current path
  late String currentPath;

  late bool replace;

  InitCommand() {
    /// get replace flag
    argParser.addFlag("replace",
        callback: (value) => replace = value, defaultsTo: false);

    pubspec = io.File('pubspec.yaml');
    if (!pubspec.existsSync()) {
      throw StateError('Pubspec cannot be located.');
    }
    pubspecEntries = loadYaml(pubspec.readAsStringSync(encoding: utf8));

    projectName = '${pubspecEntries['name']}';

    projectVersion = '${pubspecEntries['version']}';

    currentPath = io.Directory.current.path;
  }

  @override
  run() {
    /// welcome message
    printWelcome();
    if (projectName == null) {
      throw StateError('project name can not be found');
    }

    /// generate assets directory
    generateAssetsDirectory();

    /// generate lib directory and test
    generateLibDirectory();
  }

  /// generate asset directory
  void generateAssetsDirectory() {
    String _assetsPath = path.join(currentPath, 'assets');
    String _fontsPath = path.join(_assetsPath, "fonts");
    String _imagesPath = path.join(_assetsPath, "images");
    String _translationsPath = path.join(_assetsPath, "translations");
    List<String> _assetsSub = [_fontsPath, _imagesPath, _translationsPath];
    if (DirectoryCreator(_assetsPath).run()) {
      for (var p in _assetsSub) {
        DirectoryCreator(p).run();
      }
    }
  }

  /// keys will present directory
  /// values will present description
  final Map<String, String> libDirectories = {
    "configs": "Application configuration",
    "controllers": "Data featching controller",
    "extensions": "Extra more extesion on dart code",
    "interfaces": "For base class or abstraction",
    "layouts": "Application overlay or layouts",
    "models": "Application data models",
    "screens": "Application screens or pages",
    "services": "Application services for handle data or background",
    "utilities": "Application utilities",
    "widgets": "application widgets and shared ui"
  };

  /// generate asset directory
  void generateLibDirectory() {
    String _libPath = path.join(currentPath, 'lib');
    String _testPath = path.join(currentPath, 'test');

    libDirectories.forEach((key, value) {
      String _keylibPath = path.join(_libPath, key);
      String _keytestPath = path.join(_testPath, key);

      if (DirectoryCreator(_keylibPath).run()) {
        /// create its tests
        DirectoryCreator(_keytestPath).run();

        ///  lib
        FileCreator(path.join(_keylibPath, "$key.dart"),
                contents: "/// $value \nlibrary $key;", replace: true)
            .run();
      }
    });
  }

  void printWelcome() {
    var border = List.generate(100, (i) => "=").toList().join();
    printCyan("""
$border
||
|| GENERATE FLUTTER STRUCTURE
||
$border
|| name: $projectName
|| version: $projectVersion
|| path: $currentPath
$border
""");
  }
}
