import 'package:myst_example/core.dart';
import 'widgets/register_screen_scaffold.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  ///
  static const Key screenKey = ValueKey("RegisterScreen");

  static const String title = "register";

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatformWidget(
      /// child: Scaffold(
      ///   appBar: AppBar(
      ///     title: const Text(HomeService.title),
      ///   ),
      ///   body: const AdaptivePlatformWidget(
      ///     child: Center(child: Text("welcome")),
      ///   ),
      /// ),
      child: const RegisterScreenScaffold(),
    );
  }
}

