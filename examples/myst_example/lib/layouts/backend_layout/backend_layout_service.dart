import 'package:myst_example/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String activateConsoleKey = "is_activate_console";

class BackendLayoutService {
  late SharedPreferences prefs;

  BackendLayoutService() {
    prefs = ApplicationService.preferences!;
  }

  bool getActivateConsole() => prefs.getBool(activateConsoleKey) ?? false;

  void setActivateConsole(bool value) => prefs.setBool(activateConsoleKey, value);
}
