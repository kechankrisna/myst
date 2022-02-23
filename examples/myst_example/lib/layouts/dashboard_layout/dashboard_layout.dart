import 'package:myst_example/core.dart';
import 'widgets/dashboard_shell_terminal.dart';
import 'widgets/dashboard_shell_tabview.dart';
import 'widgets/dashboard_shell_close_icon.dart';
import 'widgets/dashboard_shell_webview_icon.dart';
import 'dashboard_layout_controller.dart';
import 'widgets/dashboard_cloud_shell_icon.dart';
import 'widgets/dashboard_keyboard_icon.dart';
import 'widgets/dashboard_open_editor_icon.dart';
import 'widgets/dashboard_shell_full_icon.dart';
import 'widgets/dashboard_shell_new_window_icon.dart';
import 'widgets/dashboard_shell_session_icon.dart';
import 'widgets/dashboard_shell_setting_icon.dart';
import 'widgets/select_project_title.dart';
import 'widgets/search_product_resource.dart';
import 'widgets/help_dropdown_icon.dart';
import 'widgets/notification_dropdown_icon.dart';
import 'widgets/more_option_dropdown_icon.dart';
import 'widgets/user_profile_dropdown_icon.dart';
import 'widgets/dasbhoard_title.dart';
import 'widgets/dashboard_leading_icon.dart';
import 'widgets/dashboard_activate_console.dart';

/// ### `DashboardLayout`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement the DashboardLayout
class DashboardLayout extends StatelessWidget {
  final Widget child;
  const DashboardLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var appBarHeight = kToolbarHeight;
    return ChangeNotifierProvider(
      create: (_) => DashboardLayoutController(),
      child: AdaptivePlatformWidget(
        child: Scaffold(
          appBar: _DashboardLayoutAppbar(),
          drawer: AdaptiveBuilder(
            builder: (_) => _DashboardLayoutDrawer(),
            xlBuilder: (_) => Container(
              padding: EdgeInsets.only(top: statusBarHeight + appBarHeight + 1),
              width: 300,
              child: _DashboardLayoutDrawer(),
            ),
            lgBuilder: (_) => Container(
              padding: EdgeInsets.only(top: statusBarHeight + appBarHeight + 1),
              width: 300,
              child: _DashboardLayoutDrawer(),
            ),
          ),
          body: child,
          bottomNavigationBar: _DashboardLayoutBottomBar(),
        ),
      ),
    );
  }
}

class _DashboardLayoutAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    if (context.isXSD) {
      return AppBar(
        leading: DashboardLeadingIcon(),
        title: DashboardTitle(),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
          if (context.isMd) HelperDropDownIcon(),
          NotificationDropDownIcon(),
          MoreOptionDropDownIcon(),
          if (context.isMd) UserProfileDropDownIcon(),
        ],
      );
    }
    return AppBar(
      leading: DashboardLeadingIcon(),
      flexibleSpace: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DashboardLeadingIcon(),
            DashboardTitle(),
            SelectProjectTitle(),
            Flexible(child: SearchProductResource()),
            DashboardActivateConsole(),
            HelperDropDownIcon(),
            NotificationDropDownIcon(),
            MoreOptionDropDownIcon(),
            UserProfileDropDownIcon(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class _DashboardLayoutBottomBar extends StatelessWidget {
  const _DashboardLayoutBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: kBottomNavigationBarHeight,
        maxHeight: context.deviceHeight / 2,
      ),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
        color: Theme.of(context).dividerColor,
      ))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: kBottomNavigationBarHeight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DashobardCloudShellIcon(),
                if (!context.isXSS) Expanded(child: DashboardShellTabView()),
                DashboardOpenEditorIcon(),
                DashboardKeyboardIcon(),
                DashboardShellSettingIcon(),
                DashboardShellWebviewIcon(),
                DashboardShellSessionIcon(),
                if (!context.isXSS) VerticalDivider(indent: 8, endIndent: 8),
                if (!context.isXSS) DashboardShellFullIcon(),
                if (!context.isXSS) DashboardShellNewWindowsIcon(),
                if (!context.isXSS) DashboardShellCloseIcon(),
              ],
            ),
          ),
          if (context.select<DashboardLayoutController, bool>(
              (state) => state.activateConsole))
            Expanded(child: DashboardShellTerminal()),
        ],
      ),
    );
  }
}

class _DashboardLayoutDrawer extends StatelessWidget {
  const _DashboardLayoutDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  )),
            ),
          ),
          Divider(height: 1),
          ListTile(
            title: Text("PINNED"),
          ),
          ListTile(
            title: Text("APIs and Services"),
            leading: Icon(MdiIcons.api),
            onTap: () {},
          ),
          ListTile(
            title: Text("Marketplace"),
            leading: Icon(MdiIcons.basketPlusOutline),
            onTap: () {},
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
