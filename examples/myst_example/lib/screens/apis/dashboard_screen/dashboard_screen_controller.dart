import 'package:myst_example/core.dart';

class DashboardScreenController extends ChangeNotifier {
  late bool isMiniMenu;
  late bool isFullTemporary;
  late bool isExpanedMenu;
  DashboardScreenController() {
    isMiniMenu = false;
    isFullTemporary = false;
    isExpanedMenu = false;
  }

  /// `toggleSidebar`
  ///
  /// handle the left sidebar
  toggleSidebar() {
    isMiniMenu = !isMiniMenu;
    notifyListeners();
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
