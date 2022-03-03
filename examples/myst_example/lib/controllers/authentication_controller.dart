import 'package:flutter/foundation.dart';
import 'package:myst_example/core.dart';

/// ### `AuthenticationController`
///
/// `Description`: this controller will handle the login/logout/register/profile state for the entire app
///
/// `Example`:
class AuthenticationController extends ChangeNotifier
    with DiagnosticableTreeMixin
    implements ReassembleHandler {
  late String? _name;
  String? get name => _name;

  late String? _token;
  String? get token => _token;

  late bool _isLoggedIn;
  bool get isLoggedIn => _isLoggedIn;

  late AuthenticationService _authenticationService;

  AuthenticationController([AuthenticationService? authenticationService]) {
    _authenticationService = authenticationService ?? AuthenticationService();

    _name = _authenticationService.getName;
    _token = _authenticationService.getToken;
    _isLoggedIn = _authenticationService.getName.isNotEmpty &&
        _authenticationService.getToken.isNotEmpty;
  }

  /// `login`
  ///
  /// if user logged in correctly then update the current state,
  /// else do something to notify
  login({required String name, required String token}) async {
    /// assum if always true
    var isLoggedIn =
        await _authenticationService.login(name: name, token: token);
    if (isLoggedIn) {
      _name = name;
      _token = token;
      _isLoggedIn = true;
      notifyListeners();
    } else {
      /// TODO: do something
    }
  }

  /// `register`
  ///
  /// if user registered in correctly then update the current state,
  /// else do something to notify
  register({required String name, required String token}) async {
    /// assum if always true
    var isLoggedIn =
        await _authenticationService.register(name: name, token: token);
    if (isLoggedIn) {
      _name = name;
      _token = token;
      _isLoggedIn = true;
      notifyListeners();
    } else {
      /// TODO: do something
    }
  }

  /// `logout`
  ///
  /// if user loggout correctly then update the current state,
  /// else do something to notify
  logout() async {
    var isLoggedOut = await _authenticationService.logout();
    if (isLoggedOut) {
      _name = "";
      _token = "";
      _isLoggedIn = false;
      notifyListeners();
    } else {
      /// TODO: do something
    }
  }

  /// `profile`
  ///
  /// load the current profile for cache or server
  /// else do something
  profile() async {
    var result = await _authenticationService.profile();
    if (result != null) {
      _name = result['name'];
      _token = result['token'];
      printGreen("loadProfile name $_name and token $_token");
      notifyListeners();
    } else {
      /// TODO: do something
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    /// list all the properties of your class here.
    /// See the documentation of debugFillProperties for more information.
    /// TODO: implement add
    properties.add(StringProperty('name', _name));
    properties.add(StringProperty('token', _token));
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
