import 'package:myst_example/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String isMiniMenuKey = "is_mini_menu";

class ApiLayoutService {
  late SharedPreferences prefs;

  ApiLayoutService() {
    prefs = ApplicationService.preferences!;
  }

  bool getIsMiniMenu() => prefs.getBool(isMiniMenuKey) ?? false;

  void setIsMiniMenu(bool value) => prefs.setBool(isMiniMenuKey, value);
}
