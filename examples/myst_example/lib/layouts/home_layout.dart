import 'package:myst_example/core.dart';

/// ### `HomeLayout`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement the layout
class HomeLayout extends StatelessWidget {
  final Widget child;
  const HomeLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeLayoutState(),
      child: AdaptivePlatformWidget(child: child),
    );
  }
}

class HomeLayoutState extends ChangeNotifier {}
