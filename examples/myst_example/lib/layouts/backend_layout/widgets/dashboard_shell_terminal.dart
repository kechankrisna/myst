import 'package:myst_example/core.dart';

class DashboardShellTerminal extends StatelessWidget {
  const DashboardShellTerminal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: AdaptiveWebView(
        content: """<h2 style="color:white">
        Hello world
      </h2>""",
      ),
    );
  }
}
