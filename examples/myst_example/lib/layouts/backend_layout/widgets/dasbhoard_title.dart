import 'package:myst_example/core.dart';

class DashboardTitle extends StatelessWidget {
  const DashboardTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        "Myst cloud platform",
        style: context.isXSS ? null: themeData.textTheme.titleLarge!.copyWith(color: Colors.white),
      ),
    );
  }
}
