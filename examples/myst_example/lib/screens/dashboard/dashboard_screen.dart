import 'package:myst_example/core.dart';
import 'widgets/dashboard_screen_sidebar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardScreenController(),
      child: AdaptivePlatformWidget(
        child: DashboardLayout(
          child: DashboardScreenBody(),
        ),
      ),
    );
  }
}

class DashboardScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: builder,
      xsBuilder: xsBuilder,
      smBuilder: xsBuilder,
    );
  }

  Widget xsBuilder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DasbhoardScreenSideBar(),
        DashboardScreenBodyHeader(),
        Divider(),
        Expanded(
          child: SingleChildScrollView(
            primary: false,
            child: DashboardScreenReports(),
          ),
        )
      ],
    );
  }

  Widget builder(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DasbhoardScreenSideBar(),
        VerticalDivider(width: 1),
        Expanded(
          child: Material(
            type: MaterialType.card,
            child: Column(
              children: [
                DashboardScreenBodyHeader(),
                Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    primary: false,
                    child: Padding(
                        padding: EdgeInsets.all(24),
                        child: DashboardScreenReports()),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class DashboardScreenBodyHeader extends StatelessWidget {
  const DashboardScreenBodyHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      child: ListTile(
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text("API & Servives"),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text("Enable APIS and Service".toUpperCase())),
            )
          ],
        ),
      ),
    );
  }
}

class DashboardScreenReports extends StatelessWidget {
  const DashboardScreenReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: context.isXSS ? 1 : 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: context.select<DashboardScreenController, bool>(
                  (ctrl) => ctrl.isMiniMenu)
              ? 1.75
              : 1.5,
          children: [
            RandomTrafficReport(),
            RandomTrafficReport(),
            RandomTrafficReport()
          ],
        )
      ],
    );
  }
}

class RandomTrafficReport extends StatelessWidget {
  const RandomTrafficReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
        child: Text("center"),
      ),
    );
  }
}
