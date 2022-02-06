import 'package:args/command_runner.dart';
import 'package:myst/myst.dart';
import 'package:path/path.dart' as path;
import 'package:printx/printx.dart';

class InitCommand extends Command with YamlInformation {
  @override
  String get description => "generate structure of flutter application";

  @override
  String get name => "init";

  @override
  List<String> get aliases => ['i'];

  late bool replace;

  InitCommand() {
    ensureYamlInitialized();
    
    /// get replace flag
    argParser.addFlag("replace",
        callback: (value) => replace = value, defaultsTo: false);

    /// ensure yaml load correctly
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

    libDirectories.forEach((key, value) {
      String _keylibPath = path.join(libraryPath, key);
      String _keytestPath = path.join(testablePath, key);

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
