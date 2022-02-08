import 'package:args/command_runner.dart';
import 'package:myst/myst.dart';
import 'package:path/path.dart' as path;
import 'package:printx/printx.dart';
import 'package:process_run/shell.dart';
import 'dart:io' as io;

class InitCommand extends Command with YamlInformation {
  @override
  String get description => "generate structure of flutter application";

  @override
  String get name => "init";

  @override
  List<String> get aliases => ['i'];

  InitCommand() {
    /// get rewrite flag
    argParser.addFlag("rewrite",
        callback: (value) => rewrite = value, defaultsTo: false);
  }

  @override
  run() {
    /// ensure yaml load correctly
    ensureYamlInitialized();

    final watch = Stopwatch()..start();
    PrintX.cool("init start");

    /// welcome message
    printWelcome();
    if (projectName == null) {
      throw StateError('project name can not be found');
    }

    /// generate assets directory
    generateAssetsDirectory();

    /// if flutter then add integration_test
    generateIntegrateTestDirectory();

    /// generate lib directory and test
    generateLibDirectory();

    /// generate the route
    generateRoutesLib();

    /// generate the core
    generateCoreLib();

    PrintX.cool("init finished in (${watch.elapsedMilliseconds} ms)");
    watch.stop();
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

  /// generate asset directory
  void generateLibDirectory() {
    final skelentons = [
      ...ApplicationConfig.skeleton,
      if (flutter) ...[ApplicationConfig.widgets, ApplicationConfig.providers]
    ];
    for (var directory in skelentons) {
      final _innerLibPath = path.join(libraryPath, directory.path);
      final _innerTestPath = path.join(testPath, directory.path);
      var createdDir = DirectoryCreator(_innerLibPath).run();
      if (createdDir) {
        /// check if any exist file then add these file to its plural name .dart
        var files = io.Directory(_innerLibPath).listSync();
        var missExports = <String>[];
        var existDarts = files
            .where((f) => !f.path.contains(RegExp("${directory.path}.dart")));
        missExports = existDarts
            .map((f) => f.path.split(RegExp("$_innerLibPath/")).last)
            .toList();

        /// create its tests
        DirectoryCreator(_innerTestPath).run();

        /// lib file
        /// and test file
        for (var innerFile in directory.inners) {
          final _currentLibFilePath = path.join(_innerLibPath, innerFile.path);
          var innerFileContent = innerFile.contents!;
          if (missExports.isNotEmpty) {
            innerFileContent +=
                missExports.map((f) => "\nexport '$f';").join('');
          }
          var createdFile = FileCreator(_currentLibFilePath,
                  contents: innerFileContent, rewrite: rewrite)
              .run();
          if (createdFile) {
            final _testFileName =
                innerFile.path.replaceAll(RegExp(r'.dart'), '_test.dart');
            final _currentTestFilePath =
                path.join(_innerTestPath, _testFileName);
            var contents = flutter
                ? testTemplate.replaceAll(RegExp(r'package:test/test.dart'),
                    'package:flutter_test/flutter_test.dart')
                : testTemplate;
            FileCreator(_currentTestFilePath,
                    contents: contents, rewrite: rewrite)
                .run();
          }
        }
      }
    }
  }

  /// generate integrate test directory
  void generateIntegrateTestDirectory() {
    /// if current project is flutter and not yet add integration_test to dev
    bool isIntegrationTest = dev_dependencies.containsKey("integration_test");
    if (flutter && !isIntegrationTest) {
      Shell().run("flutter pub add integration_test --dev --sdk=flutter");
    }

    String _integrationTestsPath = path.join(currentPath, 'integration_tests');
    String _testDrivePath = path.join(currentPath, 'test_driver');
    if (DirectoryCreator(_integrationTestsPath).run()) {
      var _appIntegrationTestsPath =
          path.join(_integrationTestsPath, 'app_test.dart');
      final contents = integationTestTemplate;
      FileCreator(_appIntegrationTestsPath,
              contents: contents, rewrite: rewrite)
          .run();
    }
    if (DirectoryCreator(_testDrivePath).run()) {
      var _driveTestsPath = path.join(_testDrivePath, 'integration_test.dart');
      final contents =
          """import 'package:integration_test/integration_test_driver.dart'; \n\nFuture<void> main() => integrationDriver();""";
      FileCreator(_driveTestsPath, contents: contents, rewrite: rewrite).run();
    }

    /// ensure the test folder must be exist
    DirectoryCreator(testPath).run();
  }

  /// generate the routes.dart in lib and routes_test.dart in test
  generateRoutesLib() {
    final _routePath = path.join(libraryPath, ApplicationConfig.routes.path);
    final _testFileName = ApplicationConfig.routes.path
        .replaceAll(RegExp(r'.dart'), '_test.dart');
    final _routeTestFilePath = path.join(testPath, _testFileName);
    var created = FileCreator(_routePath,
            contents: ApplicationConfig.routes.contents, rewrite: rewrite)
        .run();
    if (created) {
      var contents = flutter
          ? testTemplate.replaceAll(RegExp(r'package:test/test.dart'),
              'package:flutter_test/flutter_test.dart')
          : testTemplate;
      FileCreator(_routeTestFilePath, contents: contents, rewrite: rewrite)
          .run();
    }
  }

  /// generate the core in lib directory
  generateCoreLib() {
    final _corePath = path.join(libraryPath, ApplicationConfig.core.path);
    FileCreator(_corePath,
            contents: ApplicationConfig.core.contents, rewrite: rewrite)
        .run();
  }

  void printWelcome() {
    var border = List.generate(50, (i) => "=").toList().join();
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
