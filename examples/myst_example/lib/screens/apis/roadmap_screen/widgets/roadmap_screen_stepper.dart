import 'package:myst_example/core.dart';

class RoadMapScreenStepper extends StatelessWidget {
  const RoadMapScreenStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    printGreen("build RoadMapScreenStepper");
    return AdaptiveBuilder(
      builder: builder,
      xsBuilder: xsBuilder,
      smBuilder: xsBuilder,
    );
  }

  Widget builder(BuildContext context) {
    return CurrentLessonBodyPageView();
  }

  Widget xsBuilder(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CurrentLessonListTile(),
        Expanded(
          child: CurrentLessonBodyPageView(),
        ),
      ],
    );
  }
}

class CurrentLessonBodyPageView extends StatelessWidget {
  const CurrentLessonBodyPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: builder,
      xsBuilder: xsBuilder,
      smBuilder: xsBuilder,
      mdBuilder: xsBuilder,
    );
  }

  Widget xsBuilder(BuildContext context) {
    final lessons = RoadMapScreenService.lessons;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: PageView(
            allowImplicitScrolling: false,
            scrollBehavior:
                context.read<RoadMapScreenController>().scrollBehavior,
            pageSnapping: false,
            padEnds: false,
            controller: context.read<RoadMapScreenController>().pageController,
            children: lessons.map((e) => e.content).toList(),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(child: const MoveToPrevButton()),
              Spacer(),
              Expanded(child: const MoveToNextButton()),
            ],
          ),
        ),
      ],
    );
  }

  Widget builder(BuildContext context) {
    final lessons = RoadMapScreenService.lessons;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const MoveToPrevButton(),
        Expanded(
          child: PageView(
            allowImplicitScrolling: false,
            scrollBehavior:
                context.read<RoadMapScreenController>().scrollBehavior,
            pageSnapping: false,
            padEnds: false,
            controller: context.read<RoadMapScreenController>().pageController,
            children: lessons.map((e) => e.content).toList(),
          ),
        ),
        const MoveToNextButton(),
      ],
    );
  }
}

class CurrentLessonListTile extends StatelessWidget {
  const CurrentLessonListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex =
        context.select<RoadMapScreenController, int>((e) => e.currentPage);
    final lesson = RoadMapScreenService.lessons[currentIndex];
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text("${(currentIndex + 1)}")),
        title: lesson.title,
      ),
    );
  }
}

class MoveToPrevButton extends StatelessWidget {
  const MoveToPrevButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:
            !(context.select<RoadMapScreenController, bool>((e) => e.canGoLast))
                ? null
                : () {
                    context.read<RoadMapScreenController>().goLastPage();
                  },
        child: Text("PREV"));
  }
}

class MoveToNextButton extends StatelessWidget {
  const MoveToNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:
            !(context.select<RoadMapScreenController, bool>((e) => e.canGoNext))
                ? null
                : () {
                    context.read<RoadMapScreenController>().goNextPage();
                  },
        child: Text("NEXT"));
  }
}

class IndividualSection extends StatelessWidget {
  final Widget? header;
  const IndividualSection({Key? key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (header != null) header!,
              Text(RoadMapScreenService.dummyText),
              Text(RoadMapScreenService.dummyText),
              Text(RoadMapScreenService.dummyText),
              Text(RoadMapScreenService.dummyText),
              Text(RoadMapScreenService.dummyText),
              Text(RoadMapScreenService.dummyText),
            ],
          ),
        ),
      ),
    );
  }
}
