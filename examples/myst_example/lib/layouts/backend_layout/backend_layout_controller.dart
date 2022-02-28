import 'package:myst_example/core.dart';

/// BackendLayoutController
class BackendLayoutController extends ChangeNotifier {
  /// `activateConsole`
  ///
  /// track if any console is activated
  late bool activateConsole;

  /// `subDrawerDisplay`
  ///
  /// track if any sub drawer is displayed
  late bool subDrawerDisplay;

  late BackendLayoutService service;

  BackendLayoutController() {
    service = BackendLayoutService();
    activateConsole = service.getActivateConsole();

    /// false on start
    subDrawerDisplay = false;
  }

  toggleConsole() {
    activateConsole = !activateConsole;
    notifyListeners();
    service.setActivateConsole(activateConsole);
  }

  openConsole() {
    activateConsole = true;
    notifyListeners();
    service.setActivateConsole(true);
  }

  closeConsole() {
    activateConsole = false;
    notifyListeners();
    service.setActivateConsole(false);
  }

  toggleSubDrawer() {
    subDrawerDisplay = !subDrawerDisplay;
    notifyListeners();
  }
}
