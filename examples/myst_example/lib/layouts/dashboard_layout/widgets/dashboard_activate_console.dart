import 'package:myst_example/core.dart';
import '../dashboard_layout_controller.dart';

class DashboardActivateConsole extends StatelessWidget {
  const DashboardActivateConsole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var activateConsole = context
        .select<DashboardLayoutController, bool>((ctl) => ctl.activateConsole);
    return IconButton(
      icon: Icon(
        MdiIcons.console,
        color: activateConsole ? Colors.grey : Colors.white,
      ),
      onPressed: activateConsole
          ? null
          : () {
              context.read<DashboardLayoutController>().openConsole();
            },
    );
  }
}
