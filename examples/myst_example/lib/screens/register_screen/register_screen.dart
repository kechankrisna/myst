import 'package:myst_example/core.dart';
import 'widgets/register_screen_scaffold.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const Key pageKey = ValueKey("RegisterScreen");

  static const String title = "register";

  @override
  Widget build(BuildContext context) {
    ApplicationService.setTitle(context, title);
    return const AdaptivePlatformWidget(
      child: RegisterScreenScaffold(),
    );
  }
}
