import 'package:myst_example/core.dart';

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

                          printMagenta("name $name");
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
