import 'package:myst_example/core.dart';

class HomeService {
  static GoRoute route(String? Function(GoRouterState) redirect) => GoRoute(
        path: "/",
        name: "home",
        pageBuilder: (_, state) => const NoTransitionPage(
            child: HomeScreen(key: HomeService.screenKey)),
        redirect: redirect,
      );

  static GoRoute get router => route((p0) => null);

  static const Key screenKey = ValueKey("HomeScreen");

  static const String title = "home";
}
