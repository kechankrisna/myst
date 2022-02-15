import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/material.dart';

class AndroidAdaptiveScreen extends StatefulWidget {
  const AndroidAdaptiveScreen({Key? key}) : super(key: key);

  @override
  _AndroidAdaptiveScreenState createState() => _AndroidAdaptiveScreenState();
}

class _AndroidAdaptiveScreenState extends State<AndroidAdaptiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("adaptive builder on android"),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
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
            ListView(
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
          ],
        ),
      ),
    );
  }
}
