import 'package:shared_preferences/shared_preferences.dart';

/// ### `ApplicationService`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement service
class ApplicationService {
  static SharedPreferences? preferences;

  static ensureSharedPreferences() async {
    preferences ??= await SharedPreferences.getInstance();
  }
}
