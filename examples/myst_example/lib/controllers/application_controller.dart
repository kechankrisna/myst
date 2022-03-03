import 'package:flutter/foundation.dart';
import 'package:myst_example/core.dart';

/// ### `ApplicationController`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement controller
class ApplicationController extends ChangeNotifier
    with DiagnosticableTreeMixin
    implements ReassembleHandler {
  late ApplicationService service;

  late Locale locale;

  late ThemeMode themeMode;

  late String generatedTitle;

  ApplicationController([ApplicationService? applicationService]) {
    service = applicationService ?? ApplicationService();
    themeMode = service.currentTheme;
    locale = service.currentLocale;
    generatedTitle = appTitle;
  }

  changeThemeMode(String value) {
    themeMode = value.toThemeMode;
    notifyListeners();

    /// then update in shared key
    service.saveTheme(value);
  }

  changeLanguage(Locale value) {
    locale = value;

    notifyListeners();

    /// then update in shared key
    service.saveLanguage(value.toStringWithSeparator(separator: "_"));
  }

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
