import 'package:flutter/foundation.dart';
import 'package:myst_example/core.dart';

/// ### `AuthenticationController`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement controller
class AuthenticationController extends ChangeNotifier
    with DiagnosticableTreeMixin
    implements ReassembleHandler {
  final pref = ApplicationService.preferences!;
  late String? name;
  late String? token;

  bool get isLoggedIn => _authenticationService.isLoggedIn;
  late AuthenticationService _authenticationService;

  AuthenticationController([AuthenticationService? authenticationService]) {
    _authenticationService = authenticationService ?? AuthenticationService();
    name = "";
    token = "";
  }

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

  loadProfile() async {
    var result = await AuthenticationService.profile();
    name = result['name'];
    token = result['token'];
    printGreen("loadProfile name $name and token $token");
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    /// list all the properties of your class here.
    /// See the documentation of debugFillProperties for more information.
    /// TODO: implement add
    properties.add(StringProperty('name', name));
    properties.add(StringProperty('token', token));
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
