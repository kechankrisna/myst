import 'package:myst_example/core.dart';
import 'widgets/select_project_title.dart';
import 'widgets/search_product_resource.dart';
import 'widgets/help_dropdown_icon.dart';
import 'widgets/notification_dropdown_icon.dart';
import 'widgets/more_option_dropdown_icon.dart';
import 'widgets/user_profile_dropdown_icon.dart';

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
    return ChangeNotifierProvider(
      create: (_) => HomeLayoutState(),
      child: AdaptivePlatformWidget(
          child: Scaffold(
        appBar: _DashboardLayoutAppbar(),
      )),
    );
  }
}

/// DashboardLayoutState
class DashboardLayoutState extends ChangeNotifier {}

class _DashboardLayoutAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AppBar(
      flexibleSpace: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(MdiIcons.menu),
              color: Colors.white,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Myst cloud platform",
                style: themeData.textTheme.titleLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
            SelectProjectTitle(),
            Expanded(child: SearchProductResource()),
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
