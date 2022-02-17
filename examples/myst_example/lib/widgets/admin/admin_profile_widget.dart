import 'package:myst_example/core.dart';
/// ### `AdminProfileWidget`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement the AdminProfileWidget
class AdminProfileWidget extends StatelessWidget {
  final Widget child;
  const AdminProfileWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatformWidget(child: child);
  }
}
