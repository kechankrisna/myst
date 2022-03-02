// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io' as io;
import 'package:myst/myst.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

mixin YamlInformation {
  /// current project pubspec
  late io.File pubspec;

  /// current project myst
  late io.File myst;

  /// current project pubspec entries
  late YamlMap pubspecEntries;

  /// current project myst entries
  late YamlMap mystEntries;

  /// current project myst entries
  late YamlMap? mystConfig;

  /// current project models config
  YamlMap? modelConfig;

  /// current project interfaces config
  YamlMap? interfaceConfig;

  /// current project controllers config
  YamlMap? controllerConfig;

  /// current project extensions config
  YamlMap? extensionConfig;

  /// current project layouts config
  YamlMap? layoutConfig;

  /// current project screens config
  YamlMap? screenConfig;

  /// current project services config
  YamlMap? serviceConfig;

  /// current project utilities config
  YamlMap? utilityConfig;

  /// current project widgets config
  YamlMap? widgetConfig;

  /// current project name
  late String? projectName;

  /// current project verison
  late String? projectVersion;

  /// current path
  late String currentPath;

  /// libary path (project/lib)
  late String libraryPath;

  /// test path (project/test)
  late String testPath;

  /// dependencies yaml as map
  late YamlMap dependencies;

  /// dev_dependencies yaml as map
  late YamlMap dev_dependencies;

  // if current project is flutter app
  late bool flutter;

  // if current project using go_router
  late bool go_router;

  // if current project using provider
  late bool provider;

  // if current project using adaptivex
  late bool adaptivex;

  // if current project using printx
  late bool printx;

  // if current project using material_design_icons_flutter
  late bool mdi;

  // if current project using integration_test
  late bool integration_test;

  late bool rewrite;

  Map<String, YamlMap?> get mystYaml {
    return {
      "configs": mystConfig,
      "models": modelConfig,
      "controllers": controllerConfig,
      "services": serviceConfig,
      "interfaces": interfaceConfig,
      "widgets": widgetConfig,
      "utilities": utilityConfig,
      "screens": screenConfig,
      "extensions": extensionConfig,
      "layouts": layoutConfig,
      /// "route": routeConfig,
      /// "provider": providerConfig,
    };
  }

  ensureYamlInitialized() {
    pubspec = io.File('pubspec.yaml');
    if (!pubspec.existsSync()) {
      throw StateError('Pubspec cannot be located.');
    }

    final mystYamlPath = path.join("myst.yaml");
    myst = io.File(mystYamlPath);
    if (!myst.existsSync()) {
      FileCreator(mystYamlPath, contents: mystYamlTemplate, rewrite: true)
          .run();
    } else {
      mystEntries = loadYaml(myst.readAsStringSync(encoding: utf8));
      if (mystEntries.containsKey('configs') &&
          mystEntries['configs'] != null) {
        mystConfig = mystEntries['configs'];
        if (mystConfig != null) {
          if (mystConfig!.containsKey('rewrite')) {
            rewrite = mystConfig!['rewrite'];
          }

          /// get the config from myst.yml
          modelConfig = mystConfig!['model'];
          interfaceConfig = mystConfig!['interface'];
          controllerConfig = mystConfig!['controller'];
          extensionConfig = mystConfig!['extension'];
          layoutConfig = mystConfig!['layout'];
          screenConfig = mystConfig!['screen'];
          serviceConfig = mystConfig!['service'];
          utilityConfig = mystConfig!['utility'];
          widgetConfig = mystConfig!['widget'];
        }
      }
    }

    /// load the entire pubspect.yaml
    pubspecEntries = loadYaml(pubspec.readAsStringSync(encoding: utf8));

    /// access the project name
    projectName = '${pubspecEntries['name']}';

    /// acces the project version
    projectVersion = '${pubspecEntries['version']}';

    /// access the dependencies
    dependencies = pubspecEntries['dependencies'];

    /// access the dev_dependencies
    dev_dependencies = pubspecEntries['dev_dependencies'];

    /// check if current project is flutter application
    flutter = dependencies.nodes.containsKey("flutter");

    /// check if current project using go_router
    go_router = dependencies.nodes.containsKey("go_router");

    /// check if current project using provider
    provider = dependencies.nodes.containsKey("provider");

    /// check if current project using adaptivex
    adaptivex = dependencies.nodes.containsKey("adaptivex");

    /// check if current project using printx
    printx = dependencies.nodes.containsKey("printx");

    /// check if current project using material_design_icons_flutter
    mdi = dependencies.nodes.containsKey("material_design_icons_flutter");

    /// check if current project using integration_test
    integration_test = dev_dependencies.nodes.containsKey("integration_test");

    /// current project path
    currentPath = io.Directory.current.path;

    /// its lib path
    libraryPath = path.join(currentPath, 'lib');

    testPath = path.join(currentPath, 'test');
  }
}
