import 'package:flutter/cupertino.dart';
import 'adptive_builder_screen.dart';

class MyCupertinoApp extends StatelessWidget {
  const MyCupertinoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: "cupertino app demo",
      home: AdaptiveBuilderScreen(),
    );
  }
}
