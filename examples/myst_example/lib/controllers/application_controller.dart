import 'package:flutter/foundation.dart';
import 'package:myst_example/core.dart';

/// ### `ApplicationController`
///
/// `Description`: this application controller will take controll of theme, language, global configuration and other app sharedable state
///
/// `Example`:
class ApplicationController extends ChangeNotifier
    with DiagnosticableTreeMixin
    implements ReassembleHandler {
  late ApplicationService service;

  /// current application locale
  late Locale locale;

  /// current application theme mode
  late ThemeMode themeMode;

  /// application title
  late String generatedTitle;

  ApplicationController([ApplicationService? applicationService]) {
    service = applicationService ?? ApplicationService();
    themeMode = service.currentTheme;
    locale = service.currentLocale;
    generatedTitle = appTitle;
  }

  /// `changeThemeMode`
  ///
  /// change the thememode in controller then update shared key to remember the choice
  changeThemeMode(String value) {
    themeMode = value.toThemeMode;
    notifyListeners();

    /// then update in shared key
    service.saveTheme(value);
  }

  /// `changeLanguage`
  ///
  /// change the language in controller then update shared key to remember the choice
  changeLocale(Locale value) {
    locale = value;

    notifyListeners();

    /// then update in shared key
    service.saveLanguage(value.toStringWithSeparator(separator: "_"));
  }

  /// `changeTitle`
  ///
  /// might not work or use application service instead of, to change browser title
  changeTitle(String value) {
    generatedTitle = value;

    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    /// list all the properties of your class here.
    /// See the documentation of debugFillProperties for more information.
    /// TODO: implement add
    properties.add(StringProperty('ApplicationController', null));
  }

  @override
  void reassemble() {
    print('Did hot-reload ApplicationController');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
