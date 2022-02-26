import 'package:myst_example/core.dart';

class DashboardOpenEditorIcon extends StatelessWidget {
  const DashboardOpenEditorIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: TextButton.icon(
        icon: Icon(MdiIcons.pencil),
        label: Text("Open Editor"),
        onPressed: () {},
      ),
    );
  }
}
