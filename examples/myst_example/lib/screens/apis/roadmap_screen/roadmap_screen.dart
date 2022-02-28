import 'package:myst_example/core.dart';

import 'widgets/roadmap_screen_sidebar.dart';
import 'widgets/roadmap_screen_stepper.dart';

class RoadMapScreen extends StatelessWidget {
  final String? index;
  const RoadMapScreen({Key? key,  this.index}) : super(key: key);

  static const Key screenKey = ValueKey("RoadMapScreen");

  static const String title = "RoadMap";

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatformWidget(
      child: ApiLayout(
        child: ChangeNotifierProvider(
          create: (_) => RoadMapScreenController(initialPage: int.tryParse(index ?? '0') ?? 0),
          child: const RoadMapScreenScaffold(),
        ),
      ),
    );
  }
}

class RoadMapScreenScaffold extends StatelessWidget {
  const RoadMapScreenScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: builder,
      xsBuilder: xsBuilder,
      smBuilder: xsBuilder,
    );
  }

  Widget xsBuilder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ApiLayoutSideBar(),
        Divider(),
        Expanded(
          child: RoadMapScreenStepper(),
        )
      ],
    );
  }

  Widget builder(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ApiLayoutSideBar(),
        VerticalDivider(width: 1),
        SizedBox(
          width: kDrawerWidth,
          child: RoadMapScreenSidebar(),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(24),
            child: RoadMapScreenStepper(),
          ),
        )
      ],
    );
  }
}
