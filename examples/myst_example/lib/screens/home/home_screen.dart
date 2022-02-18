import 'package:myst_example/core.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
