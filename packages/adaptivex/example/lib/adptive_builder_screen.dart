import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/material.dart';

class AdaptiveBuilderScreen extends StatefulWidget {
  const AdaptiveBuilderScreen({Key? key}) : super(key: key);

  @override
  _AdaptiveBuilderScreenState createState() => _AdaptiveBuilderScreenState();
}

class _AdaptiveBuilderScreenState extends State<AdaptiveBuilderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("using adaptive builder"),
      ),
      body: Center(
        child: AdaptiveBuilder(
          xlBuilder: (_) => const Text("xlBuilder"),
          lgBuilder: (_) => const Text("lgBuilder"),
          mdBuilder: (_) => const Text("mdBuilder"),
          smBuilder: (_) => const Text("smBuilder"),

          /// xsBuilder: (_) => const Text("xsBuilder"),
          builder: (_) => const Text("xsBuilder"),
        ),
      ),
    );
  }
}
