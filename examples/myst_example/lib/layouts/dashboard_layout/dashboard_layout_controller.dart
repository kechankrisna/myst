import 'package:myst_example/core.dart';

/// DashboardLayoutController
class DashboardLayoutController extends ChangeNotifier {
  late bool activateConsole;

  DashboardLayoutController() {
    activateConsole = false;
  }

  openConsole() {
    activateConsole = true;
    notifyListeners();
  }

  closeConsole() {
    activateConsole = false;
    notifyListeners();
  }
}
