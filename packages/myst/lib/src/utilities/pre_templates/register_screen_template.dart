String registerScreenTemplate = """import 'package:projectName/core.dart';
import 'widgets/register_screen_scaffold.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const Key pageKey = ValueKey("RegisterScreen");

  static const String title = "register";

  @override
  Widget build(BuildContext context) {
    ApplicationService.setTitle(context, title);

    return ChangeNotifierProvider(
      create: (_) => RegisterScreenController(),
      child: const AdaptivePlatformWidget(
        child: RegisterScreenScaffold(),
      ),
    );
  }
}
""";

String registerScreenControllerTemplate =
    """import 'package:projectName/core.dart';

class RegisterScreenController extends ChangeNotifier {
  late TextEditingController nameController;
  late TextEditingController secretController;

  late String? name;
  late String? secret;

  RegisterScreenController() {
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

const String registerScreenScaffoldTemplate =
    """import 'package:projectName/core.dart';

class RegisterScreenScaffold extends StatelessWidget {
  const RegisterScreenScaffold({Key? key}) : super(key: key);

  static const String createAccountText = "create an account";

  static const String registerAccountText = "register";

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
                  title: Text("register").tr(),
                  trailing: SwitchThemeButton(),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                    onChanged: (value) => context
                        .read<RegisterScreenController>()
                        .onChangeName(value),
                    controller:
                        context.read<RegisterScreenController>().nameController,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                    onChanged: (value) => context
                        .read<RegisterScreenController>()
                        .onChangeToken(value),
                    controller:
                        context.read<RegisterScreenController>().tokenController,
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
                              context.read<RegisterScreenController>().name;
                          final token =
                              context.read<RegisterScreenController>().token;
                          var result = await context
                              .read<AuthenticationController>()
                              .register(name: name!, token: token!);

                          
                        },
                        child: Text(registerAccountText),
                      ),
                    ],
                  ),
                ),

                /// TextButton(
                ///   onPressed: () async {
                ///     context.read<RegisterScreenController>().onReset();
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
