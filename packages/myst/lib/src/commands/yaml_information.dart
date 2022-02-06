// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io' as io;
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

mixin YamlInformation {
  /// current project pubspec
  late io.File pubspec;

  /// current project pubspecEntries
  late YamlMap pubspecEntries;

  /// current project name
  late String? projectName;

  /// current project verison
  late String? projectVersion;

  /// current path
  late String currentPath;

  late String libraryPath;

  late String testablePath;

  late YamlMap dependencies;

  late YamlMap dev_dependencies;

  late bool flutter;

  ensureYamlInitialized() {
    pubspec = io.File('pubspec.yaml');
    if (!pubspec.existsSync()) {
      throw StateError('Pubspec cannot be located.');
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

    testablePath = path.join(currentPath, 'test');
  }
}
