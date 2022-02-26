import 'package:flutter/widgets.dart';

class AdaptiveWebView extends StatefulWidget {
  final String? url;
  final String? content;
  const AdaptiveWebView({ Key? key, this.url, this.content }) : super(key: key);

  @override
  State<AdaptiveWebView> createState() => _AdaptiveWebViewState();
}

class _AdaptiveWebViewState extends State<AdaptiveWebView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Text("data"),
      ),
    );
  }
}