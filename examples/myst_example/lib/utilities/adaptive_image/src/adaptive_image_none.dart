import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AdaptiveImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final String? assetUrl;

  const AdaptiveImage(
      {Key? key, required this.url, this.width, this.height, this.assetUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// empty string must be avoid  to load
    assert(url.isNotEmpty);

    String imageUrl = url;

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      placeholder:
          assetUrl == null ? null : (_, value) => Image.asset(assetUrl!),
    );
  }
}
