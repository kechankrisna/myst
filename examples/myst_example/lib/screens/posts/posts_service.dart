import 'package:myst_example/core.dart';

class PostsService {
  static GoRoute route(String? Function(GoRouterState) redirect) => GoRoute(
        path: "/posts",
        name: "posts",
        pageBuilder: (_, state) => const NoTransitionPage(
            child: PostListScreen(key: PostsService.postsScreenKey)),
        redirect: redirect,
      );

  static GoRoute get router => route((p0) => null);

  static const Key postsScreenKey = ValueKey("PostListScreen");

  static const String title = "posts";
}
