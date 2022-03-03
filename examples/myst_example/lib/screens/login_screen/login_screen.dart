import 'package:myst_example/core.dart';
import 'widgets/login_screen_scaffold.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const Key pageKey = ValueKey("LoginScreen");

  static const String title = "login";

  @override
  Widget build(BuildContext context) {
    ApplicationService.setTitle(context, title);

    return ChangeNotifierProvider(
      create: (_) => LoginScreenController(),
      child: const AdaptivePlatformWidget(
        child: LoginScreenScaffold(),
      ),
    );
  }
}
