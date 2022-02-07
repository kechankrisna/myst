// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io' as io;
import 'package:path/path.dart' as path;
import 'package:printx/printx.dart';
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

  /// current project models config
  late YamlMap? modelConfig;

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

  late bool flutter;

  late bool rewrite;

  ensureYamlInitialized() {
    pubspec = io.File('pubspec.yaml');
    if (!pubspec.existsSync()) {
      throw StateError('Pubspec cannot be located.');
    }

    myst = io.File('myst.yaml');
    if (!myst.existsSync()) {
      PrintX.f("no myst.yaml were config");
    } else {
      mystEntries = loadYaml(myst.readAsStringSync(encoding: utf8));
      if (mystEntries.containsKey('configs') &&
          mystEntries['configs'] != null) {
        modelConfig = mystEntries['configs']['model'];
        if (modelConfig?.containsKey("rewrite") == true) {
          rewrite = modelConfig!['rewrite'];
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

    /// current project path
    currentPath = io.Directory.current.path;

    /// its lib path
    libraryPath = path.join(currentPath, 'lib');

    testPath = path.join(currentPath, 'test');
  }
}
