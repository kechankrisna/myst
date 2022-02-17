import 'package:myst_example/core.dart';

/// ### `UserProfileWidget`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement the UserProfileWidget
class UserProfileWidget extends StatelessWidget {
  final Widget child;
  const UserProfileWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatformWidget(child: child);
  }
}
