import 'package:myst_example/core.dart';

class DashboardShellSessionIcon extends StatelessWidget {
  const DashboardShellSessionIcon({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(MdiIcons.twoFactorAuthentication),
      
      onPressed: (){},
    );
  }
}