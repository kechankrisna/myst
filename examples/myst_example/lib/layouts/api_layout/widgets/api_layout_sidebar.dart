import 'package:myst_example/core.dart';

class ApiLayoutSideBar extends StatelessWidget {
  const ApiLayoutSideBar({Key? key}) : super(key: key);

  static ListTile get header {
    return ListTile(
      leading: Icon(MdiIcons.api),
      title: Text("APIs and Services"),
      onTap: () {},
    );
  }

  static List<ListTile> getMenus(BuildContext context) {
    return [
      ListTile(
        leading: Icon(MdiIcons.viewDashboardOutline),
        title: Text("Dashboard"),
        onTap: () {
          context.goNamed(dashboardRouteName);
        },
      ),
      ListTile(
        leading: Icon(MdiIcons.walk),
        title: Text("RoadMap"),
        onTap: () {
          context.goNamed(roadMapRouteName);
        },
      ),
      ListTile(
        leading: Icon(MdiIcons.library),
        title: Text("Libary"),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(MdiIcons.key),
        title: Text("Credential"),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(MdiIcons.twoFactorAuthentication),
        title: Text("OAuth consent screen"),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(MdiIcons.check),
        title: Text("Domain verification"),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(MdiIcons.cogBox),
        title: Text("Page usage agreements"),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(MdiIcons.toyBrick),
        title: Text("Template"),
        onTap: () {
          context.goNamed(templateRouteName);
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: builder,
      xsBuilder: xsBuilder,
      smBuilder: xsBuilder,
    );
  }

  Widget xsBuilder(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return PopupMenuButton(
      constraints: BoxConstraints(
        minWidth: width,
        maxWidth: width,
      ),
      offset: Offset(0, kToolbarHeight),
      padding: EdgeInsets.zero,
      enableFeedback: true,
      itemBuilder: (_) => [
        PopupMenuItem(
          enabled: false,
          padding: EdgeInsets.zero,
          child: Container(
            height: height - ((kToolbarHeight * 3) + 16),
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                children: ApiLayoutSideBar.getMenus(context),
              ),
            ),
          ),
        )
      ],
      child: Card(
        child: ListTile(
          title: ApiLayoutSideBar.header.title,
          leading: ApiLayoutSideBar.header.leading,
          trailing: Icon(Icons.arrow_drop_down),
        ),
      ),
    );
  }

  Widget builder(BuildContext context) {
    return MouseRegion(
      onEnter: (pointer) {
        context.read<ApiLayoutController>().toggleTemporarySidebar(true);
      },
      onExit: (pointer) {
        context.read<ApiLayoutController>().toggleTemporarySidebar(false);
      },
      child: Material(
        type: MaterialType.card,
        child: (context.select<ApiLayoutController, bool>(
                    (ctrl) => !ctrl.isMiniMenu)) ||
                (context.select<ApiLayoutController, bool>(
                    (ctrl) => ctrl.isFullTemporary))
            ? ApiLayoutLargeSidebar()
            : ApiLayoutMiniSidebar(),
      ),
    );
  }
}

class ApiLayoutLargeSidebar extends StatelessWidget {
  const ApiLayoutLargeSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          ApiLayoutSideBar.header,
          Divider(),
          Expanded(
              child: ListView(
            children: [...ApiLayoutSideBar.getMenus(context)],
          )),
          ListTile(
            leading: Icon(MdiIcons.pageFirst),
            onTap: () {
              context.read<ApiLayoutController>().toggleSidebar();
            },
          ),
        ],
      ),
    );
  }
}

class ApiLayoutMiniSidebar extends StatelessWidget {
  const ApiLayoutMiniSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kMiniLeftDrawerWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
              leading: ApiLayoutSideBar.header.leading,
              onTap: ApiLayoutSideBar.header.onTap),
          Divider(),
          Expanded(
              child: ListView(
            children: [
              ...ApiLayoutSideBar.getMenus(context).map(
                (e) => ListTile(leading: e.leading, onTap: e.onTap),
              ),
            ],
          )),
          ListTile(
            leading: Icon(MdiIcons.pageLast),
            onTap: () {
              context.read<ApiLayoutController>().toggleSidebar();
            },
          ),
        ],
      ),
    );
  }
}
