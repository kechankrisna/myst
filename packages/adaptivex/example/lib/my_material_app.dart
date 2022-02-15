import 'package:flutter/material.dart';
import 'adptive_builder_screen.dart';

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'meterial app demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AdaptiveBuilderScreen(),
    );
  }
}
