import 'package:myst_example/core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  // TODO: register route here
  final _router = GoRouter(routes: [
    HomeService.router,
    PostsService.router,
    DashboardService.router,
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'myst example',
      theme: ThemeData(primarySwatch: Colors.blue),
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
