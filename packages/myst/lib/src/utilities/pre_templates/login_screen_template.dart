String loginScreenTemplate = """import 'package:projectName/core.dart';
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
""";

String loginScreenControllerTemplate =
    """import 'package:projectName/core.dart';

class LoginScreenController extends ChangeNotifier {
  late TextEditingController nameController;
  late TextEditingController secretController;

  late String? name;
  late String? secret;

  LoginScreenController() {
    name = "";
    secret = "";
    nameController = TextEditingController(text: name);
    secretController = TextEditingController(text: secret);
  }

  onReset() {
    name = "";
    secret = "";
    nameController.value = TextEditingValue.empty;
    secretController.value = TextEditingValue.empty;
    notifyListeners();
  }

  onChangeName(String? value) {
    name = value;
    notifyListeners();
  }

  onChangeSecret(String? value) {
    secret = value;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    secretController.dispose();
    super.dispose();
  }
}
""";

const String loginScreenScaffoldTemplate =
    """import 'package:projectName/core.dart';

class LoginScreenScaffold extends StatelessWidget {
  const LoginScreenScaffold({Key? key}) : super(key: key);

  static const String createAccountText = "create an account";

  static const String loginAccountText = "login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text("login").tr(),
                  trailing: SwitchThemeButton(),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                    onChanged: (value) => context
                        .read<LoginScreenController>()
                        .onChangeName(value),
                    controller:
                        context.read<LoginScreenController>().nameController,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                    onChanged: (value) => context
                        .read<LoginScreenController>()
                        .onChangeToken(value),
                    controller:
                        context.read<LoginScreenController>().tokenController,
                  ),
                ),
                Expanded(child: SizedBox()),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          context.goNamed(registerRouteName);
                        },
                        child: Text(createAccountText),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          final name =
                              context.read<LoginScreenController>().name;
                          final token =
                              context.read<LoginScreenController>().token;
                          var result = await context
                              .read<AuthenticationController>()
                              .login(name: name!, token: token!);

                          
                        },
                        child: Text(loginAccountText),
                      ),
                    ],
                  ),
                ),

                /// TextButton(
                ///   onPressed: () async {
                ///     context.read<LoginScreenController>().onReset();
                ///   },
                ///   child: Text("reset"),
                /// ),
                SizedBox(height: 20),
                SwitchLanguageButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
""";
