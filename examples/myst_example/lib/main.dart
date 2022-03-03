import 'package:myst_example/core.dart';

void main() async {
  // flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  /// easy localization
  await EasyLocalization.ensureInitialized();

  /// shared preference
  await ApplicationService.ensureInitialized();

  final authenticationController = AuthenticationController();

  runApp(EasyLocalization(
      path: translationsPath,
      supportedLocales: supportedLocales,
      fallbackLocale: fallbackLocale,
      startLocale:startLocale,
      saveLocale: true,
      child: MyApp(authenticationController: authenticationController)));
}
