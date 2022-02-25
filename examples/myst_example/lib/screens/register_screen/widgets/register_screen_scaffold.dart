import 'package:myst_example/core.dart';

class RegisterScreenScaffold extends StatelessWidget {
  const RegisterScreenScaffold({Key? key}) : super(key: key);

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
                  title: Text("register"),
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
                TextButton(
                  onPressed: () {},
                  child: Text("register"),
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
