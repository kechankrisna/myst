import 'package:flutter/material.dart';

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

    return Image.network(
      imageUrl,
      width: width?.toDouble(),
      height: height?.toDouble(),
      
    );
  }
}
