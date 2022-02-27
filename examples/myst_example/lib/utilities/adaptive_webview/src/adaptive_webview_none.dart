import 'dart:typed_data' show Uint8List;

import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:myst_example/core.dart';

class AdaptiveWebView extends StatelessWidget {
  final String? url;
  final String? content;
  final Function(Uint8List data)? onScreenshot;
  const AdaptiveWebView({Key? key, this.url, this.content, this.onScreenshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// if (DeviceService.isMobile) {
    ///   return SafeArea(
    ///     child: Container(
    ///       child: Text("data"),
    ///     ),
    ///   );
    /// }
    printGreen("build AdaptiveWebView");
    return SafeArea(
      child: Html(data: content),
    );
  }
}
