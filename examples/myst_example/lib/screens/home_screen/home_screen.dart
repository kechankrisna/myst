import 'package:myst_example/core.dart';

import 'widgets/home_screen_macos.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const Key screenKey = ValueKey("HomeScreen");

  static const String title = "home";

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
      child: const HomeScreenMacos(),
    );
  }
}
