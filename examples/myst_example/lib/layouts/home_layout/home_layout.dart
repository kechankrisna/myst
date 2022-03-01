import 'package:myst_example/core.dart';

/// ### `HomeLayout`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement the layout
class HomeLayout extends StatelessWidget {
  final AppBar? appBar;
  final Widget child;
  const HomeLayout({Key? key, required this.child, this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const empty = SizedBox();
    const sidebar = MacosSidebar(key: ValueKey("sidebar"));
    const divider = VerticalDivider(width: 1);
    return ChangeNotifierProvider(
      create: (_) => HomeLayoutContoller(),
      child: Scaffold(
        appBar: context.isXSD && appBar != null ? appBar : null,
        drawer: AdaptiveBuilder(
          lgBuilder: (_) => empty,
          xlBuilder: (_) => empty,
          builder: (_) => const Drawer(child: sidebar),
        ),
        body: AdaptivePlatformWidget(
            child: AdaptiveBuilder(
          key: ValueKey(runtimeType),
          builder: (_) => child,
          smBuilder: (_) => child,
          lgBuilder: (_) => Row(
            children: [
              sidebar,
              divider,
              Expanded(child: child),
            ],
          ),
          xlBuilder: (_) => Row(
            children: [
              sidebar,
              divider,
              Expanded(child: child),
            ],
          ),
        )),
      ),
    );
  }
}

class MacosSidebar extends StatelessWidget {
  const MacosSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = drawers(context);
    if (context.isXLL) {
      return Container(
        alignment: Alignment.center,
        width: 55,
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) => IconButton(
                  onPressed: items[i].onTap,
                  icon: items[i].leading!,
                  iconSize: 28,
                  tooltip: (items[i].title as Text).data,
                )),
      );
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, i) => items[i],
    );
  }
}

List<ListTile> drawers(BuildContext context) => [
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text("home"),
        onTap: () => context.goNamed(rootRouteName),
      ),
      ListTile(
        leading: const Icon(Icons.dashboard_customize),
        title: const Text("dashboard"),
        onTap: () => context.goNamed(dashboardRouteName),
      ),
      ListTile(
        leading: const Icon(Icons.article),
        title: const Text("posts"),
        onTap: () => context.goNamed(PostsService.router.name!),
      ),
    ];


