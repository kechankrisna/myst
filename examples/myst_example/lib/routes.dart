/// Application route handler
import 'package:myst_example/core.dart';

/// TODO: handle router in the neat way

class MyRouter {
  late AuthenticationController authenticationController;
  MyRouter(this.authenticationController);

  late final router = GoRouter(
    refreshListenable: authenticationController,
    debugLogDiagnostics: true,
    urlPathStrategy: UrlPathStrategy.path,
    initialLocation: "/login",
    routes: [
      /// TODO: HomeScreenService.router,
      GoRoute(
        name: rootRouteName,
        path: rootRoutePath,
        pageBuilder: (_, state) => NoTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(key: HomeScreenService.screenKey)),
        routes: [
          /// nested routes
        ],

        /// redirect: redirect,
      ),

      /// TODO: LoginScreenService.router,
      GoRoute(
        name: loginRouteName,
        path: loginRoutePath,
        pageBuilder: (_, state) => NoTransitionPage(
            key: state.pageKey,
            child: const LoginScreen(key: LoginScreenService.screenKey)),
        routes: [
          /// nested routes
        ],

        /// redirect: redirect,
      ),

      /// TODO: RegisterScreenService.router,
      GoRoute(
        name: registerRouteName,
        path: registerRoutePath,
        pageBuilder: (_, state) => NoTransitionPage(
            key: state.pageKey,
            child: const RegisterScreen(key: RegisterScreenService.screenKey)),
        routes: [
          /// nested routes
        ],

        /// redirect: redirect,
      ),

      /// TODO: PostsService.router,
      /// GoRoute(
      ///   path: "/posts",
      ///   name: "posts",
      ///   pageBuilder: (_, state) => const NoTransitionPage(
      ///       child: PostListScreen(key: PostsService.postsScreenKey)),
      ///   routes: [
      ///     /// nested routes
      ///   ],

      ///   /// redirect: redirect,
      /// ),

      /// TODO: DashboardService.router,
      GoRoute(
        name: apiRouteName,
        path: apiRoutePath,
        pageBuilder: (_, state) => NoTransitionPage(
            key: state.pageKey,
            child: const Center(child: CircularProgressIndicator())),
        routes: [
          GoRoute(
            name: dashboardRouteName,
            path: dashboardRoutePath,
            pageBuilder: (_, state) => const NoTransitionPage(
                child: DashboardScreen(key: DashboardScreenService.screenKey)),
            routes: [
              /// nested routes
            ],

            /// redirect: redirect,
          ),
        ],
        redirect: (state) {
          final dashboardLocation = state.namedLocation(dashboardRouteName);
          return dashboardLocation;
        },
      ),
    ],

    /// handle error
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),

    /// handle redirect or middlewar
    redirect: (state) {
      /// if user is in login screen
      final loginLocation = state.namedLocation(loginRouteName);
      final loggingIn = state.subloc == loginLocation;

      /// if user is in register screen
      final registerAccountLocation = state.namedLocation(registerRouteName);
      final registeringAccount = state.subloc == registerAccountLocation;

      final isLoggedIn = authenticationController.isLoggedIn;
      final rootLocation = state.namedLocation(rootRouteName);
      final apiLocation = state.namedLocation(apiRouteName);
      final dashboardLocation = state.namedLocation(dashboardRouteName);

      /// if not logged-in nor in loggin page nor in register page then go to login
      if (!isLoggedIn && !loggingIn && !registeringAccount) {
        return loginLocation;
      }

      /// if login and but sticted in login or register page, then go to api dashboard
      if (isLoggedIn && (loggingIn || registeringAccount)) {
        return apiLocation;
      }

      return null;
    },
  );
}
