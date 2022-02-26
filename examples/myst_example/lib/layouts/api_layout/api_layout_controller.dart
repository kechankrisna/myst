import 'package:myst_example/core.dart';

class ApiLayoutController extends ChangeNotifier {
  late bool isMiniMenu;
  late bool isFullTemporary;
  late bool isExpanedMenu;
  late ApiLayoutService service;
  ApiLayoutController() {
    service = ApiLayoutService();
    isMiniMenu = service.getIsMiniMenu();
    isFullTemporary = false;
    isExpanedMenu = false;
  }

  /// `toggleSidebar`
  ///
  /// handle the left sidebar
  toggleSidebar() {
    isMiniMenu = !isMiniMenu;
    notifyListeners();
    service.setIsMiniMenu(isMiniMenu);
  }

  toggleTemporarySidebar(bool v) {
    if (isMiniMenu) {
      isFullTemporary = v;
      notifyListeners();
    }
  }

  /// `toggleMenubar`
  ///
  /// handle expanded ListTile topbar
  toggleMenubar() {
    isExpanedMenu = !isExpanedMenu;
    notifyListeners();
  }
}
