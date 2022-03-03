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

    /// generate the router file
    await generateRouterLib();

    /// generate the main file
    await generateMainLib();

    /// generate the app file
    await generateAppLib();

    /// generate the core
    await generateCoreLib();

    /// generate the application_service and authentication_service
    await generateDefaultService();

    /// generate the application_controller and authentication_controller
    await generateDefaultController();

    /// generate the home_screen, login_screen, register_screen, dashboard_screen
    await generateDefaultScreen();

    /// gererate the home_layout and dashboard layout
    await generateDefaultLayout();

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

  /// generate the router.dart in lib and router_test.dart in test
  Future<void> generateRouterLib() async {
    final _routePath = path.join(libraryPath, ApplicationConfig.router.path);
    final _testFileName = ApplicationConfig.router.path
        .replaceAll(RegExp(r'.dart'), '_test.dart');
    final _routeTestFilePath = path.join(testPath, _testFileName);
    String fileHeadContent =
        """/// Application route handler\nimport 'package:$projectName/core.dart';\n\n""";
    var created = FileCreator(_routePath,
            contents: fileHeadContent + ApplicationConfig.router.contents!,
            rewrite: rewrite)
        .run();
    if (created) {
      /// then create a test for route
      var contents = flutter
          ? testTemplate.replaceAll(RegExp(r'package:test/test.dart'),
              'package:flutter_test/flutter_test.dart')
          : testTemplate;
      FileCreator(_routeTestFilePath, contents: contents, rewrite: rewrite)
          .run();
    }
  }

  /// generate the main.dart in lib and app_test.dart in test
  Future<void> generateMainLib() async {
    final _mainPath = path.join(libraryPath, ApplicationConfig.main.path);
    final _testFileName =
        ApplicationConfig.main.path.replaceAll(RegExp(r'.dart'), '_test.dart');
    final _mainTestFilePath = path.join(testPath, _testFileName);

    var created = FileCreator(_mainPath,
            contents: ApplicationConfig.main.contents!
                .replaceAll(RegExp(r"projectName"), projectName!),
            rewrite: rewrite)
        .run();
    if (created) {
      var contents = flutter
          ? testTemplate.replaceAll(RegExp(r'package:test/test.dart'),
              'package:flutter_test/flutter_test.dart')
          : testTemplate;
      FileCreator(_mainTestFilePath, contents: contents, rewrite: rewrite)
          .run();
    }
  }

  /// generate the app.dart in lib and app_test.dart in test
  Future<void> generateAppLib() async {
    final _appPath = path.join(libraryPath, ApplicationConfig.app.path);
    final _testFileName =
        ApplicationConfig.app.path.replaceAll(RegExp(r'.dart'), '_test.dart');
    final _appTestFilePath = path.join(testPath, _testFileName);
    var created = FileCreator(_appPath,
            contents: ApplicationConfig.app.contents, rewrite: rewrite)
        .run();
    if (created) {
      var contents = flutter
          ? testTemplate.replaceAll(RegExp(r'package:test/test.dart'),
              'package:flutter_test/flutter_test.dart')
          : testTemplate;
      FileCreator(_appTestFilePath, contents: contents, rewrite: rewrite).run();
    }
  }

  /// generate the core in lib directory
  Future<void> generateCoreLib() async {
    final _corePath = path.join(libraryPath, ApplicationConfig.core.path);
    var contents = ApplicationConfig.core.contents!;
    if (flutter) {
      contents += "\nexport 'package:flutter/material.dart';";
    }

    /// handle go_router
    if (!go_router) {
      await Shell().run("flutter pub add go_router");
      contents += "\nexport 'package:go_router/go_router.dart';";
    } else if (go_router) {
      contents += "\nexport 'package:go_router/go_router.dart';";
    }

    /// handle provider
    if (!provider) {
      await Shell().run("flutter pub add provider");
      contents += "\nexport 'package:provider/provider.dart';";
    } else if (provider) {
      contents += "\nexport 'package:provider/provider.dart';";
    }

    /// handle adaptivex
    if (!adaptivex) {
      await Shell().run("flutter pub add adaptivex");
      contents += "\nexport 'package:adaptivex/adaptivex.dart';";
    } else if (adaptivex) {
      contents += "\nexport 'package:adaptivex/adaptivex.dart';";
    }

    /// handle printx
    if (!printx) {
      await Shell().run("flutter pub add printx");
      contents += "\nexport 'package:printx/printx.dart';";
    } else if (printx) {
      contents += "\nexport 'package:printx/printx.dart';";
    }

    /// handle material_design_icons_flutter
    if (!mdi) {
      await Shell().run("flutter pub add material_design_icons_flutter:any");
      contents +=
          "\nexport 'package:material_design_icons_flutter/material_design_icons_flutter.dart';";
    } else if (mdi) {
      contents +=
          "\nexport 'package:material_design_icons_flutter/material_design_icons_flutter.dart';";
    }

    /// handle easy_localization
    if (!sharedpref) {
      await Shell().run("flutter pub add easy_localization:^3.0.1-dev");
      contents +=
          "\nexport 'package:easy_localization/easy_localization.dart' hide TextDirection;";
    } else if (sharedpref) {
      contents +=
          "\nexport 'package:easy_localization/easy_localization.dart' hide TextDirection;";
    }

    /// handle shared_preferences
    if (!sharedpref) {
      await Shell().run("flutter pub add shared_preferences:^2.0.13");
      contents +=
          "\nexport 'package:shared_preferences/shared_preferences.dart';";
    } else if (sharedpref) {
      contents +=
          "\nexport 'package:shared_preferences/shared_preferences.dart';";
    }

    /// if one of them are not exist yet
    if (!go_router || !provider) {
      await Shell().run("flutter pub get");
    }
    FileCreator(_corePath, contents: contents, rewrite: rewrite).run();
  }

  /// generate home screen
  Future<void> generateDefaultScreen() async {
    /// home_screen.dart
    ScreenCommand()
      ..className = "HomeScreen"
      ..fileName = "home_screen"
      ..projectName = projectName
      ..generateScreenLibFiles()
      ..generateScreenTestFiles();

    /// login_screen.dart
    ScreenCommand()
      ..className = "LoginScreen"
      ..fileName = "login_screen"
      ..projectName = projectName
      ..generateScreenLibFiles()
      ..generateScreenTestFiles();

    /// register_screen.dart
    ScreenCommand()
      ..className = "RegisterScreen"
      ..fileName = "register_screen"
      ..projectName = projectName
      ..generateScreenLibFiles()
      ..generateScreenTestFiles();

    /// reset_screen.dart
    ScreenCommand()
      ..className = "ResetScreen"
      ..fileName = "reset_screen"
      ..projectName = projectName
      ..generateScreenLibFiles()
      ..generateScreenTestFiles();

    /// dashboard_screen.dart
    ScreenCommand()
      ..className = "DashboardScreen"
      ..fileName = "dashboard_screen"
      ..projectName = projectName
      ..dirName = "admin"
      ..generateScreenLibFiles()
      ..generateScreenTestFiles();

    /// profile_screen.dart
    ScreenCommand()
      ..className = "ProfileScreen"
      ..fileName = "profile_screen"
      ..projectName = projectName
      ..dirName = "admin"
      ..generateScreenLibFiles()
      ..generateScreenTestFiles();

    /// await Shell().run("flutter pub run myst screen home_screen --template=mvc");
    /// await Shell()
    ///     .run("flutter pub run myst screen login_screen --template=mvc");
    /// await Shell()
    ///     .run("flutter pub run myst screen register_screen --template=mvc");
    /// await Shell()
    ///     .run("flutter pub run myst screen reset_screen --template=mvc");
    /// await Shell().run(
    ///     "flutter pub run myst screen dashboard_screen --dir=admin --template=mvc");
    /// await Shell().run(
    ///     "flutter pub run myst screen profile_screen --dir=admin --template=mvc");
  }

  Future<void> generateDefaultLayout() async {
    /// blank_layout.dart
    LayoutCommand()
      ..className = "BlankLayout"
      ..fileName = "blank_layout"
      ..projectName = projectName
      ..generateScreenLibFiles()
      ..generateScreenTestFiles();

    /// admin_layout.dart
    LayoutCommand()
      ..className = "AdminLayout"
      ..fileName = "admin_layout"
      ..projectName = projectName
      ..generateScreenLibFiles()
      ..generateScreenTestFiles();
  }

  Future<void> generateDefaultService() async {
    /// application_service.dart
    GenerateFileHelper(
        parentDir: "services",
        className: "ApplicationService",
        projectName: projectName!)
      ..generateLib(
          template: applicationServiceTemplate, fileName: "application_service")
      ..generateTest(
          template: serviceTemplate, fileName: "application_service");

    /// authentication_service.dart
    GenerateFileHelper(
        parentDir: "services",
        className: "AuthenticationService",
        projectName: projectName!)
      ..generateLib(
          template: authenticationServiceTemplate,
          fileName: "authentication_service")
      ..generateTest(
          template: serviceTemplate, fileName: "authentication_service");

    /// await Shell().run("flutter pub run myst service application_service");
    /// await Shell().run("flutter pub run myst service authentication_service");
  }

  Future<void> generateDefaultController() async {
    /// application_controller.dart
    GenerateFileHelper(
        parentDir: "controllers",
        className: "ApplicationController",
        projectName: projectName!)
      ..generateLib(
          template: applicationControllerTemplate,
          fileName: "application_controller")
      ..generateTest(
          template: controllerTestTemplate, fileName: "application_controller");

    /// authentication_controller.dart
    GenerateFileHelper(
        parentDir: "controllers",
        className: "AuthenticationController",
        projectName: projectName!)
      ..generateLib(
          template: authenticationControllerTemplate,
          fileName: "authentication_controller")
      ..generateTest(
          template: controllerTestTemplate,
          fileName: "authentication_controller");

    /// await Shell().run("flutter pub run myst controller application_controller");
    /// await Shell()
    ///     .run("flutter pub run myst controller authentication_controller");
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
