import 'dart:io' as io;

///

//async* + yield* for recursive functions
Stream<io.File> scanningFilesWithAsyncRecursive(io.Directory dir) async* {
  //dirList is FileSystemEntity list for every directories/subdirectories
  //entities in this list might be file, directory or link
  var dirList = dir.list();
  await for (final io.FileSystemEntity entity in dirList) {
    if (entity is io.File) {
      yield entity;
    } else if (entity is io.Directory) {
      yield* scanningFilesWithAsyncRecursive(io.Directory(entity.path));
    }
  }
}
