import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/material.dart';

class LinuxAdaptiveScreen extends StatefulWidget {
  const LinuxAdaptiveScreen({Key? key}) : super(key: key);

  @override
  _LinuxAdaptiveScreenState createState() => _LinuxAdaptiveScreenState();
}

class _LinuxAdaptiveScreenState extends State<LinuxAdaptiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("adaptive builder on linux"),
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
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text("disk"),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
