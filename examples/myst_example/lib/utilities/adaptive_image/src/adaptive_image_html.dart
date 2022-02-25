// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

class AdaptiveImage extends StatelessWidget {
  final String url;
  final int? width;
  final int? height;
  final String? assetUrl;

  const AdaptiveImage(
      {Key? key, required this.url, this.width, this.height, this.assetUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// empty string must be avoid  to load
    assert(url.isNotEmpty);

    String imageUrl = url;
    // https://github.com/flutter/flutter/issues/41563
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      imageUrl,
      (int _) => html.ImageElement()
        ..src = imageUrl
        ..width = width
        ..height = height,
    );
    return HtmlElementView(viewType: imageUrl);
  }
}
