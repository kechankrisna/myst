import 'package:myst_example/core.dart';

class DasbhoardScreenSideBar extends StatelessWidget {
  const DasbhoardScreenSideBar({Key? key}) : super(key: key);

  static ListTile get header {
    return ListTile(
      leading: Icon(MdiIcons.api),
      title: Text("APIs and Services"),
      onTap: () {},
    );
  }

  static List<ListTile> get menus {
    return [
      ListTile(
        leading: Icon(MdiIcons.viewDashboardOutline),
        title: Text("Dashboard"),
        onTap: () {},
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
      enableFeedback: false,
      itemBuilder: (_) => [
        PopupMenuItem(
          enabled: false,
          padding: EdgeInsets.zero,
          child: Container(
            height: height - ((kToolbarHeight * 3) + 16),
            child: SingleChildScrollView(
              child: Column(
                children: DasbhoardScreenSideBar.menus,
              ),
            ),
          ),
        )
      ],
      child: Card(
        child: ListTile(
          title: DasbhoardScreenSideBar.header.title,
          leading: DasbhoardScreenSideBar.header.leading,
          trailing: Icon(Icons.arrow_drop_down),
        ),
      ),
    );
    return Material(
      type: MaterialType.card,
      child: ExpansionPanelList(
        expandedHeaderPadding: EdgeInsets.zero,
        expansionCallback: (panelIndex, isExpanded) {
          context.read<DashboardScreenController>().toggleMenubar();
        },
        children: [
          ExpansionPanel(
            isExpanded: context.select<DashboardScreenController, bool>(
                (ctrl) => ctrl.isExpanedMenu),
            headerBuilder: (_, isOpen) => ListTile(
              title: DasbhoardScreenSideBar.header.title,
              leading: DasbhoardScreenSideBar.header.leading,
            ),
            body: SizedBox(
              height: context.deviceHeight -
                  ((kToolbarHeight * 2) + kBottomNavigationBarHeight),
              child: Column(
                children: [Divider(), ...DasbhoardScreenSideBar.menus],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget builder(BuildContext context) {
    return MouseRegion(
      onEnter: (pointer) {
        context.read<DashboardScreenController>().toggleTemporarySidebar(true);
      },
      onExit: (pointer) {
        context.read<DashboardScreenController>().toggleTemporarySidebar(false);
      },
      child: Material(
        type: MaterialType.card,
        child: (context.select<DashboardScreenController, bool>(
                    (ctrl) => !ctrl.isMiniMenu)) ||
                (context.select<DashboardScreenController, bool>(
                    (ctrl) => ctrl.isFullTemporary))
            ? DashboardScreenLargeSidebar()
            : DashboardScreenMiniSidebar(),
      ),
    );
  }
}

class DashboardScreenLargeSidebar extends StatelessWidget {
  const DashboardScreenLargeSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          DasbhoardScreenSideBar.header,
          Divider(),
          Expanded(
              child: ListView(
            children: [...DasbhoardScreenSideBar.menus],
          )),
          ListTile(
            leading: Icon(MdiIcons.pageFirst),
            onTap: () {
              context.read<DashboardScreenController>().toggleSidebar();
            },
          ),
        ],
      ),
    );
  }
}

class DashboardScreenMiniSidebar extends StatelessWidget {
  const DashboardScreenMiniSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65,
      child: Column(
        children: [
          ListTile(
              leading: DasbhoardScreenSideBar.header.leading,
              onTap: DasbhoardScreenSideBar.header.onTap),
          Divider(),
          Expanded(
              child: ListView(
            children: [
              ...DasbhoardScreenSideBar.menus.map(
                (e) => ListTile(leading: e.leading, onTap: e.onTap),
              ),
            ],
          )),
          ListTile(
            leading: Icon(MdiIcons.pageLast),
            onTap: () {
              context.read<DashboardScreenController>().toggleSidebar();
            },
          ),
        ],
      ),
    );
  }
}
