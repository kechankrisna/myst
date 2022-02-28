import 'package:myst_example/core.dart';

class RoadMapScreenSidebar extends StatelessWidget {
  const RoadMapScreenSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lessons = RoadMapScreenService.lessons;
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: lessons.length,
      itemBuilder: (_, index) {
        final lesson = lessons[index];
        return RoadMapScreenSidebarLisTile(
          lesson: lesson,
          index: index,
        );
      },
    );
  }
}

class RoadMapScreenSidebarLisTile extends StatelessWidget {
  final RoadMapLessonModel lesson;
  final int index;
  const RoadMapScreenSidebarLisTile(
      {Key? key, required this.lesson, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = index ==
        (context.select<RoadMapScreenController, int>((e) => e.currentPage));
    final bgColor = selected ? Theme.of(context).primaryColor : Colors.grey;
    final textColor = index <
            context.select<RoadMapScreenController, int>((e) => e.currentPage)
        ? Colors.black
        : bgColor;
    return Card(
      elevation: selected ? 2 : 1,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.all(8),
        leading: CircleAvatar(
          backgroundColor: bgColor,
          child: Text(
            "${index + 1}",
            style: TextStyle(color: Colors.white),
          ),
        ),
        textColor: textColor,
        iconColor: textColor,
        title: lesson.title,
        selected: selected,
        onTap: () {
          /// printGreen(GoRouter.of(context).location);
          /// printGreen(GoRouter.of(context).namedLocation(roadMapRouteName));
          /// var state = GoRouter.of(context).navigator;
          /// GoRouter.of(context).routerDelegate;
          /// context.pushNamed(roadMapRouteName, queryParams: {"index": "0"});
          /// context.goNamed(roadMapRouteName, params: {"index": "0"});
          context.read<RoadMapScreenController>().goToPage(index);
        },
      ),
    );
  }
}
