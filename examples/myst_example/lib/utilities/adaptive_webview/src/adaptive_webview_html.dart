// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:myst_example/core.dart';

class AdaptiveWebView extends StatefulWidget {
  final String? url;
  final String? content;
  const AdaptiveWebView({Key? key, this.url, this.content}) : super(key: key);

  @override
  State<AdaptiveWebView> createState() => _AdaptiveWebViewState();
}

class _AdaptiveWebViewState extends State<AdaptiveWebView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final uniqueKey = Random.secure().nextInt(10000);
    final viewType = "adaptive-webview-$uniqueKey";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      viewType,
      (int _) => html.IFrameElement()
        ..src = widget.url
        ..srcdoc = widget.content
        ..style.width = '100%'
        ..style.height = '100%'
        ..allowFullscreen = true,
    );

    return SafeArea(child: HtmlElementView(viewType: viewType));
  }
}
