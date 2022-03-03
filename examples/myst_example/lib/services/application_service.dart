import 'package:myst_example/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ### `ApplicationService`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement service
class ApplicationService {
  static SharedPreferences? preferences;

  static ensureInitialized() async {
    // ensure preference
    preferences ??= await SharedPreferences.getInstance();
  }

  Future<bool> saveTheme(String value) async {
    return await preferences!.setString(themeKey, value);
  }

  Future<bool> saveLanguage(String value) async {
    return await preferences!.setString(languageKey, value);
  }

  ThemeMode get currentTheme => preferences!.getString(themeKey).toThemeMode;

  Locale get currentLocale => preferences!.getString(languageKey).toLocale;
}

extension ApplicationServiceStringExt on String? {
  ThemeMode get toThemeMode {
    switch (this) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Locale get toLocale {
    switch (this) {
      case "km":
        return Locale("km", "KH");

      default:
        return fallbackLocale;
    }
  }
}
