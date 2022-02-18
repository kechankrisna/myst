import 'package:myst_example/core.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatformWidget(
      child: DashboardLayout(child: _DashboardScreenBody()),
    );
  }
}

class _DashboardScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("dashboard"),
    );
  }
}
