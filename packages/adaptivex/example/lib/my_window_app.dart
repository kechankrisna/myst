import 'package:example/adptive_builder_screen.dart';
import 'package:fluent_ui/fluent_ui.dart';

class MyWindowApp extends StatefulWidget {
  const MyWindowApp({Key? key}) : super(key: key);

  @override
  _MyWindowAppState createState() => _MyWindowAppState();
}

class _MyWindowAppState extends State<MyWindowApp> {
  @override
  Widget build(BuildContext context) {
    return const FluentApp(
      title: "window app demo",

      /// theme: ThemeData(),
      home: AdaptiveBuilderScreen(),
    );
  }
}
