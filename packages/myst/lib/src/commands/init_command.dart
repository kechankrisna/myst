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
  run() async {
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
    await generateAssetsDirectory();

    /// if flutter then add integration_test
    await generateIntegrateTestDirectory();

    /// generate lib directory and test
    await generateLibDirectory();

    /// generate the route
    await generateRoutesLib();

    /// generate the core
    await generateCoreLib();

    PrintX.cool("init finished in (${watch.elapsedMilliseconds} ms)");
    watch.stop();
  }

  /// generate asset directory
  Future<void> generateAssetsDirectory() async {
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
  Future<void> generateLibDirectory() async {
    final skelentons = [
      ...ApplicationConfig.skeleton,
      if (flutter) ...[ApplicationConfig.widgets, ApplicationConfig.providers]
    ];
    for (var directory in skelentons) {
      final _innerLibPath = path.join(libraryPath, directory.path);
      final _innerTestPath = path.join(testPath, directory.path);
      var createdDir = DirectoryCreator(_innerLibPath).run();
      if (createdDir) {
        var missExports = <String>[];

        var scan = scanningFilesWithAsyncRecursive(io.Directory(_innerLibPath));

        for (var f in (await scan.toList())) {
          var _path = f.path.split(RegExp("$_innerLibPath/")).last;
          if (_path != "${directory.path}.dart") {
            missExports.add(_path);
          }
        }

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
  Future<void> generateIntegrateTestDirectory() async {
    /// if current project is flutter and not yet add integration_test to dev
    /// bool isIntegrationTest = dev_dependencies.containsKey("integration_test");
    if (flutter && integration_test) {
      Shell().run("flutter pub add integration_test --dev --sdk=flutter");

      String _integrationTestsPath =
          path.join(currentPath, 'integration_tests');
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
        var _driveTestsPath =
            path.join(_testDrivePath, 'integration_test.dart');
        final contents =
            """import 'package:integration_test/integration_test_driver.dart'; \n\nFuture<void> main() => integrationDriver();""";
        FileCreator(_driveTestsPath, contents: contents, rewrite: rewrite)
            .run();
      }

      /// ensure the test folder must be exist
      DirectoryCreator(testPath).run();
    }
  }

  /// generate the routes.dart in lib and routes_test.dart in test
  Future<void> generateRoutesLib() async {
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
  Future<void> generateCoreLib() async {
    final _corePath = path.join(libraryPath, ApplicationConfig.core.path);
    var contents = ApplicationConfig.core.contents!;
    if (flutter) {
      contents += "\nexport 'package:flutter/material.dart';";
    }
    if(!go_router){
       await Shell().run("flutter pub add go_router");
      contents += "\nexport 'package:go_router/go_router.dart';";
    }else if (go_router) {
      contents += "\nexport 'package:go_router/go_router.dart';";
    }
    if (!provider) {
      await Shell().run("flutter pub add provider");
      contents += "\nexport 'package:provider/provider.dart';";
    } else if (provider) {
      contents += "\nexport 'package:provider/provider.dart';";
    }
    /// if one of them are not exist yet
    if(!go_router || !provider){
      await Shell().run("flutter pub get");
    }
    FileCreator(_corePath, contents: contents, rewrite: rewrite).run();
  }

  /// print the welcome message
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
