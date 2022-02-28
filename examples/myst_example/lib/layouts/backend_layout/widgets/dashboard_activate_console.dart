import 'package:myst_example/core.dart';

class DashboardActivateConsole extends StatelessWidget {
  const DashboardActivateConsole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var activateConsole = context
        .select<BackendLayoutController, bool>((ctl) => ctl.activateConsole);
    return IconButton(
      icon: Icon(
        MdiIcons.console,
        color: activateConsole ? Colors.grey : Colors.white,
      ),
      onPressed: activateConsole
          ? null
          : () {
              context.read<BackendLayoutController>().toggleConsole();
            },
    );
  }
}
