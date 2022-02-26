import 'package:myst_example/core.dart';

class DashboardShellNewWindowsIcon extends StatelessWidget {
  const DashboardShellNewWindowsIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(MdiIcons.openInNew),
      onPressed: () {},
    );
  }
}
