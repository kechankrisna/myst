import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import 'adptive_builder_screen.dart';

class MyMacosApp extends StatelessWidget {
  const MyMacosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MacosApp(
      title: "macos app demo",
      home: AdaptiveBuilderScreen(),
    );
  }
}
