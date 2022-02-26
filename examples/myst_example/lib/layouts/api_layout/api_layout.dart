import 'package:myst_example/core.dart';

export 'widgets/api_layout_sidebar.dart';

export 'api_layout_service.dart';
export 'api_layout_controller.dart';

class ApiLayout extends StatelessWidget {
  final Widget child;

  const ApiLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackendLayout(
      child: ChangeNotifierProvider(
        create: (_) => ApiLayoutController(),
        child: AdaptivePlatformWidget(
          child: child,
        ),
      ),
    );
  }
}
