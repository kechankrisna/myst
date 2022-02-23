import 'package:myst_example/core.dart';
import '../dashboard_layout_controller.dart';

class DashboardShellCloseIcon extends StatelessWidget {
  const DashboardShellCloseIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(MdiIcons.close),
      onPressed: () {
         context.read<DashboardLayoutController>().closeConsole();
      },
    );
  }
}
