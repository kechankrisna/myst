import 'package:flutter/material.dart';

class MyFusionApp extends StatefulWidget {
  const MyFusionApp({Key? key}) : super(key: key);

  @override
  _MyFusionAppState createState() => _MyFusionAppState();
}

class _MyFusionAppState extends State<MyFusionApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("fusion app demo"),
        ),
        body: const Text("fusion"),
      ),
    );
  }
}
