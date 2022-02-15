import 'package:flutter/material.dart';
import 'adptive_builder_screen.dart';

class MyWebApp extends StatelessWidget {
  const MyWebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'web app demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AdaptiveBuilderScreen(),
    );
  }
}
