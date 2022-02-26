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
    await prefs.setString(userTokenKey, token);
    return true;
  }

  static Future<bool> logout() async {
    final prefs = ApplicationService.preferences!;
    await Future.delayed(Duration(milliseconds: 300));
    await prefs.remove(userNameKey);
    await prefs.remove(userTokenKey);
    return true;
  }

  static Future<Map<String, dynamic>> profile() async {
    final prefs = ApplicationService.preferences!;
    await Future.delayed(Duration(milliseconds: 300));

    var name = prefs.getString(userNameKey);
    var token = prefs.getString(userTokenKey);
    return {"name": name, "token": token};
  }

  static get isLoggedIn =>
      ApplicationService.preferences!.getString(userNameKey) != null;
}
