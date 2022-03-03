import 'package:myst_example/core.dart';

/// ### `AuthenticationService`
///
/// `Description`: this service class handle any authenticate method either with server api or cache
///
/// `Example`:
class AuthenticationService {
  AuthenticationService();

  Future<bool> login({required String name, required String token}) async {
    final prefs = ApplicationService.preferences!;
    await Future.delayed(const Duration(milliseconds: 300));
    await prefs.setString(userNameKey, name);
    await prefs.setString(userTokenKey, token);
    return true;
  }

  Future<bool> register({required String name, required String token}) async {
    final prefs = ApplicationService.preferences!;
    await Future.delayed(const Duration(milliseconds: 300));
    await prefs.setString(userNameKey, name);
    await prefs.setString(userTokenKey, token);
    return true;
  }

  Future<bool> logout() async {
    final prefs = ApplicationService.preferences!;
    await Future.delayed(const Duration(milliseconds: 300));
    await prefs.remove(userNameKey);
    await prefs.remove(userTokenKey);
    return true;
  }

  Future<Map<String, dynamic>?> profile() async {
    final prefs = ApplicationService.preferences!;
    await Future.delayed(const Duration(milliseconds: 300));

    var name = prefs.getString(userNameKey);
    var token = prefs.getString(userTokenKey);
    return {"name": name, "token": token};
  }

  String get getToken {
    final prefs = ApplicationService.preferences!;
    return prefs.getString(userTokenKey) ?? "";
  }

  String get getName {
    final prefs = ApplicationService.preferences!;
    return prefs.getString(userNameKey) ?? "";
  }
}
