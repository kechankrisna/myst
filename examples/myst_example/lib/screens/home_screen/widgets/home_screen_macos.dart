import 'package:myst_example/core.dart';

class HomeScreenMacos extends StatelessWidget {
  const HomeScreenMacos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeLayout(
        appBar: AppBar(title: const Text("welcome to demo app on macos")),
        child: _HomeScreenMacosBody(key: ValueKey("macos_expand_body")));
  }
}

class _HomeScreenMacosBody extends StatelessWidget {
  const _HomeScreenMacosBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    printGreen(runtimeType);
    return const Center(
      child: Text("welcome"),
    );
  }
}
