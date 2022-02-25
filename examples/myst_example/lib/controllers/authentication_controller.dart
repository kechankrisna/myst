import 'package:flutter/foundation.dart';
import 'package:myst_example/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ### `AuthenticationController`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement controller
class AuthenticationController extends ChangeNotifier
    with DiagnosticableTreeMixin
    implements ReassembleHandler {
  final SharedPreferences pref = ApplicationService.preferences!;
  late String? name;
  late String? token;

  bool get isLoggedIn => AuthenticationService.isLoggedIn;

  AuthenticationController();

  login({required String name, required String token}) async {
    /// assum if always true
    await AuthenticationService.login(name: name, token: token);
    name = name;
    token = token;
    notifyListeners();
  }

  logout() async {
    await AuthenticationService.logout();
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    /// list all the properties of your class here.
    /// See the documentation of debugFillProperties for more information.
    /// TODO: implement add
    properties.add(StringProperty('AuthenticationController', null));
  }

  @override
  void reassemble() {
    print('Did hot-reload AuthenticationController');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
