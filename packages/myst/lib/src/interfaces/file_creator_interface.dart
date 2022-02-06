abstract class FileCreatorInterface {
  /// a must
  late String path;

  /// nullable content
  late String? contents;

  /// run
  bool run();
}
