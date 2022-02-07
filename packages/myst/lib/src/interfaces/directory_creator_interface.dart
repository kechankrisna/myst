import 'file_creator_interface.dart';

abstract class DirectoryCreatorInterface {
  /// a must
  late String path;

  /// inner files inside of current directory
  late List<FileCreatorInterface> inners;

  /// run
  bool run();
}
