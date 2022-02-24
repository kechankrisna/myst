import 'package:myst_example/core.dart';

class DashboardScreenController extends ChangeNotifier {
  late bool isMiniMenu;
  late bool isExpanedMenu;
  DashboardScreenController() {
    isMiniMenu = false;
    isExpanedMenu = false;
  }

  /// `toggleSidebar`
  ///
  /// handle the left sidebar
  toggleSidebar() {
    isMiniMenu = !isMiniMenu;
    notifyListeners();
  }

  /// `toggleMenubar`
  ///
  /// handle expanded ListTile topbar
  toggleMenubar() {
    isExpanedMenu = !isExpanedMenu;
    notifyListeners();
  }
}
