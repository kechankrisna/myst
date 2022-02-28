import 'package:myst_example/core.dart';

class RoadMapLessonModel {
  final Widget title;
  final Widget content;
  RoadMapLessonModel({
    required this.title,
    required this.content,
  });
  

  RoadMapLessonModel copyWith({
    final Widget? title,
    final Widget? content,
  }) {
    return RoadMapLessonModel(
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  @override
  String toString() => 'RoadMapLessonModel(title: $title, content: $content)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RoadMapLessonModel &&
      other.title == title &&
      other.content == content;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode;
}
