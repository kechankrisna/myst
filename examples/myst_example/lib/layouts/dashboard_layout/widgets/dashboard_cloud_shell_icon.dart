import 'package:myst_example/core.dart';

class DashobardCloudShellIcon extends StatelessWidget {
  const DashobardCloudShellIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          child: Icon(
            MdiIcons.laptop,
            size: 34,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("cloud shell".toUpperCase()),
              Text("Terminal"),
            ],
          ),
        ),
      ],
    );
  }
}
