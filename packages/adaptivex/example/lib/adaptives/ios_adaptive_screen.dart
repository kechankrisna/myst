import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IOSAdaptiveScreen extends StatelessWidget {
  const IOSAdaptiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("adaptive builder on ios"),
        previousPageTitle: "",
        leading: CupertinoButton(
          child: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      child: Center(
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
