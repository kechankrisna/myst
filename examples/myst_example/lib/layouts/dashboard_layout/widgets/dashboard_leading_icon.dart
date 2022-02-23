import 'package:myst_example/core.dart';

class DashboardLeadingIcon extends StatelessWidget {
  const DashboardLeadingIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: Icon(MdiIcons.menu),
      color: Colors.white,
    );
  }
}
