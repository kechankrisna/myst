import 'package:myst_example/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ApplicationService.ensureSharedPreferences();

  var authenticationController = AuthenticationController();

  runApp(MyApp(authenticationController: authenticationController));
}

