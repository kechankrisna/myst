import 'package:myst_example/core.dart';

/// BackendLayoutController
class BackendLayoutController extends ChangeNotifier {
  late bool activateConsole;
  late BackendLayoutService service;

  BackendLayoutController() {
    service = BackendLayoutService();
    activateConsole = service.getActivateConsole();
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
}
