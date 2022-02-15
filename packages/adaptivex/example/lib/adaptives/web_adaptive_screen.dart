import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/material.dart';

class WebAdaptiveScreen extends StatefulWidget {
  const WebAdaptiveScreen({Key? key}) : super(key: key);

  @override
  _WebAdaptiveScreenState createState() => _WebAdaptiveScreenState();
}

class _WebAdaptiveScreenState extends State<WebAdaptiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("adaptive builder on web"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              otherAccountsPictures: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.verified_user_outlined)),
              ],
              accountName: const Text("learn html"),
              accountEmail: const Text("www@www.www"),
            ),
            Expanded(
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
            const Divider(),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("logout"),
                      )),
                  flex: 5,
                ),
                Flexible(
                  child: SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("settings"),
                    ),
                  ),
                  flex: 5,
                ),
              ],
            )
          ],
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
    );
  }
}
