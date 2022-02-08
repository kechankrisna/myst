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

  late bool rewrite;

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

          modelConfig = mystConfig!['model'];
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

    /// current project path
    currentPath = io.Directory.current.path;

    /// its lib path
    libraryPath = path.join(currentPath, 'lib');

    testPath = path.join(currentPath, 'test');
  }
}
