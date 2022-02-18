import 'package:myst_example/core.dart';

class DashboardService {
  static GoRoute route(String? Function(GoRouterState) redirect) => GoRoute(
        path: "/dashboard",
        name: "dashboard",
        pageBuilder: (_, state) => const NoTransitionPage(
            child: DashboardScreen(key: DashboardService.screenKey)),
        redirect: redirect,
      );

  static GoRoute get router => route((p0) => null);

  static const Key screenKey = ValueKey("DashboardScreen");

  static const String title = "dashboard";
}
