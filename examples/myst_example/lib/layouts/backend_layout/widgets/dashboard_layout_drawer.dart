import 'package:myst_example/core.dart';
import 'package:popover/popover.dart';
import 'dasbhoard_title.dart';
import 'select_project_title.dart';

class DashboardLayoutDrawer extends StatelessWidget {
  const DashboardLayoutDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var appBarHeight = kToolbarHeight;

    return Drawer(
      child: Column(
        children: [
          if (context.isXSS)
            ListTile(
              title: DashboardTitle(),
            ),
          if (context.isXSS) Divider(),
          if (context.isXSS) SelectProjectTitle(),
          if (context.isXSS) Divider(),
          ListTile(
            title: Text("Home"),
            leading: Icon(MdiIcons.homeOutline),
            onTap: () {},
          ),
          ListTile(
            title: Text("Recent"),
            leading: Icon(MdiIcons.history),
            onTap: () {},
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: ListTile(
              title: Text("View all products"),
              leading: Icon(MdiIcons.viewDashboard),
              onTap: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                side: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
          ),
          Divider(height: 1),
          ListTile(
            title: Text("PINNED"),
          ),
          ListTile(
            title: Text("APIs and Services"),
            leading: Icon(MdiIcons.api),
            trailing: Icon(MdiIcons.arrowRightThin),
            onTap: () {
              showPopover(
                context: context,
                bodyBuilder: (_) => ListView(
                  children: [
                    ListTile(
                      title: Text("Myst Cloud Service"),
                    ),
                  ],
                ),
                direction: PopoverDirection.right,
                onPop: () {
                  context.read<BackendLayoutController>().toggleSubDrawer();
                },
                barrierDismissible: true,
                arrowDyOffset: 0,
              );
            },
          ),
          PopupMenuButton(
            child: ListTile(
              title: Text("Marketplace"),
              leading: Icon(MdiIcons.basketPlusOutline),
              onTap: null,
            ),
            constraints: BoxConstraints(
              maxWidth: context.deviceWidth - kDrawerWidth,
              maxHeight: context.deviceHeight - kToolbarHeight,
            ),
            offset: Offset(kDrawerWidth, kToolbarHeight),
            padding: EdgeInsets.zero,
            itemBuilder: (_) => [
              PopupMenuItem(
                padding: EdgeInsets.zero,
                enabled: false,
                child: Container(
                  width: context.deviceWidth - kDrawerWidth,
                  height: context.deviceHeight - kToolbarHeight,
                  child: MarketDrawerContainer(),
                ),
              ),
            ],
          ),
          ListTile(
            title: Text("Marketplace"),
            leading: Icon(MdiIcons.basketPlusOutline),
            onTap: () {
              showPopover(
                context: context,
                bodyBuilder: (_) => Container(),
              );
            },
          ),
          Divider(height: 1),
          ListTile(
            title: Text("MORE PRODUCTS"),
          ),
          Divider(height: 1),
          Expanded(
              child: ListView.builder(
            primary: false,
            itemCount: 100,
            itemBuilder: (_, i) => ListTile(
              title: Text("Product random"),
              onTap: () {},
            ),
          ))
        ],
      ),
    );
  }
}

class MarketDrawerContainer extends StatelessWidget {
  const MarketDrawerContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    label: Text("enter a keyword")),
              ),
              Expanded(
                child: SingleChildScrollView(
                    primary: false,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: _SampleMenuList(
                                  title: ListTile(title: Text("Sample one")),
                                  length: 15)),
                          Expanded(
                              child: _SampleMenuList(
                                  title: ListTile(title: Text("Sample two")),
                                  length: 26)),
                          Expanded(
                              child: _SampleMenuList(
                                  title: ListTile(title: Text("Sample three")),
                                  length: 38))
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
        Container(
          width: 120,
          child: ListView.separated(
            primary: false,
            itemCount: 20,
            itemBuilder: (_, i) {
              return ListTile(
                onTap: () {},
                title: Text("sub menu $i"),
              );
            },
            separatorBuilder: (_, i) => Divider(height: 1),
          ),
        ),
      ],
    );
  }
}

class _SampleMenuList extends StatelessWidget {
  final Widget title;
  final int length;
  const _SampleMenuList({Key? key, required this.title, required this.length})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          title,
          ...List.generate(
              length,
              (i) => ListTile(
                    onTap: () {},
                    title: Text("_SampleMenuList $i"),
                  )).toList(),
        ],
      ),
    );
  }
}
