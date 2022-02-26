// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:myst_example/core.dart';

class AdaptiveImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Widget? cover;
  final String? assetUrl;

  const AdaptiveImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius = 50,
    this.cover,
    this.assetUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// empty string must be avoid  to load
    assert(url.isNotEmpty);

    String _imageUrl = assetUrl ?? url;
    Widget _coverWidet = cover ??
        Opacity(
          opacity: 0.1,
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            height: double.infinity,
          ),
        );
    // https://github.com/flutter/flutter/issues/41563
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      _imageUrl,
      (int _) => html.DivElement()

        /// ..src = imageUrl
        /// ..style.width = '100%'
        ..children = [
          html.ImageElement(src: _imageUrl)
            ..style.width = '100%'
            ..style.height = '100%'
            ..style.clip = 'circle'
            ..style.objectFit = 'cover'
            ..style.position = 'relative'
            ..style.borderRadius = '$borderRadius%'
            ..style.transitionDuration = '0.3 s',
        ]
        ..style.objectFit = 'cover'
        ..style.transitionDelay = '0.3 s'
        ..style.transitionDuration = '0.3 s'
        ..style.border = 'none',
    );
    return AnimatedContainer(
      duration: const Duration(seconds: 3),
      curve: Curves.fastOutSlowIn,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            HtmlElementView(viewType: _imageUrl),
            Positioned(
              child: _coverWidet,
            )
          ],
        ),
      ),
    );
  }
}
