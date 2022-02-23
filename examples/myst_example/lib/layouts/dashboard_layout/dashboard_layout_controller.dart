import 'package:myst_example/core.dart';

/// DashboardLayoutController
class DashboardLayoutController extends ChangeNotifier {
  late bool _activateConsole;
  bool get activateConsole => _activateConsole;

  DashboardLayoutController() {
    _activateConsole = false;
  }

  openConsole() {
    _activateConsole = true;
    notifyListeners();
  }

  closeConsole() {
    _activateConsole = false;
    notifyListeners();
  }
}
