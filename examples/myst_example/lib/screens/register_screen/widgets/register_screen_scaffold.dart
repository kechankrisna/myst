import 'package:myst_example/core.dart';

class RegisterScreenScaffold extends StatelessWidget {
  const RegisterScreenScaffold({Key? key}) : super(key: key);

  static const String title = "register";

  static const String logginButtonText = "back to loggin";

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
                  title: Text(title),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.all(12),
                  child: TextField(),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: TextField(),
                ),
                Expanded(child: SizedBox()),
                Container(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              context.goNamed(loginRouteName);
                            },
                            child: Text(logginButtonText)),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            context
                                .read<AuthenticationController>()
                                .register(name: "name", token: "token");
                          },
                          child: Text("register"),
                        ),
                      ],
                    )),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
