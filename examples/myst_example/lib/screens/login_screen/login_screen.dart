import 'package:myst_example/core.dart';
import 'widgets/login_screen_scaffold.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const Key screenKey = ValueKey("LoginScreen");

  static const String title = "login";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginScreenController(),
      child: AdaptivePlatformWidget(
        /// child: Scaffold(
        ///   appBar: AppBar(
        ///     title: const Text(HomeService.title),
        ///   ),
        ///   body: const AdaptivePlatformWidget(
        ///     child: Center(child: Text("welcome")),
        ///   ),
        /// ),
        child: const LoginScreenScaffold(),
      ),
    );
  }
}
