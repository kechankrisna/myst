import 'package:flutter/services.dart';
import 'package:myst_example/core.dart';

/// ### `ApplicationService`
///
/// `Description`: this class will be use with other application controller to handle global service for application
///
/// `Example`:
class ApplicationService {
  /// shared preference must be initialized before use
  static SharedPreferences? preferences;

  ///
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
    return await preferences!.setString(localeKey, value);
  }

  ThemeMode get currentTheme => preferences!.getString(themeKey).toThemeMode;

  Locale get currentLocale => preferences!.getString(localeKey).toLocale;
}

/// private extension for application service class on string
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
