import 'package:myst_example/core.dart';

/// ### `AuthenticationService`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement service
class AuthenticationService {
  AuthenticationService();

  static Future<bool> login(
      {required String name, required String token}) async {
    final prefs = ApplicationService.preferences!;
    await Future.delayed(Duration(milliseconds: 300));
    await prefs.setString(userNameKey, name);
    await prefs.setString("token", token);
    return true;
  }

  static Future<bool> logout() async {
    final prefs = ApplicationService.preferences!;
    await Future.delayed(Duration(milliseconds: 300));
    await prefs.remove(userNameKey);
    await prefs.remove(userTokenKey);
    return true;
  }

  static Future<String?> profile() async {
    final prefs = ApplicationService.preferences!;
    await Future.delayed(Duration(milliseconds: 300));

    var name = prefs.getString(userNameKey);
    return name;
  }

  static get isLoggedIn =>
      ApplicationService.preferences!.getString(userNameKey) != null;
}
