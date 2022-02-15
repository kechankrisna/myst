import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'adptive_builder_screen.dart';

class MyLinuxApp extends StatelessWidget {
  const MyLinuxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'meterial app demo',
      theme: yaruMateLight,
      home: const AdaptiveBuilderScreen(),
    );
  }
}
