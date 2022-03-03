import 'package:flutter/services.dart';
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

  /// `setTitle`
  ///
  /// allow every page or screen to change current display title
  static setTitle(BuildContext context, String title) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: title,
      primaryColor: Theme.of(context).primaryColor.value,
    ));
  }

  /// save then current theme into the preference key
  Future<bool> saveTheme(String value) async {
    return await preferences!.setString(themeKey, value);
  }

  /// save the current lang into the preference key
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
    if (this != null) {
      return Locale(this!.split("_").first, this!.split("_").last);
    }
    return fallbackLocale;
  }
}
