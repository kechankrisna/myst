import 'package:adaptivex/adaptivex.dart';
import 'package:example/adaptives/android_adaptive_screen.dart';
import 'package:example/adaptives/window_adaptive_screen.dart';
import 'package:flutter/material.dart';

import 'adaptives/ios_adaptive_screen.dart';
import 'adaptives/macos_adaptive_screen.dart';
import 'adaptives/web_adaptive_screen.dart';

class AdaptiveBuilderScreen extends StatefulWidget {
  const AdaptiveBuilderScreen({Key? key}) : super(key: key);

  @override
  _AdaptiveBuilderScreenState createState() => _AdaptiveBuilderScreenState();
}

class _AdaptiveBuilderScreenState extends State<AdaptiveBuilderScreen> {
  @override
  Widget build(BuildContext context) {
    return const AdaptivePlatformWidget(
      /// child will required by default
      child: AndroidAdaptiveScreen(),

      /// ios app
      ios: IOSAdaptiveScreen(),

      /// macos app
      macos: MacosAdaptiveScreen(),

      /// web app
      web: WebAdaptiveScreen(),

      /// windows app
      window: WindowsAdaptiveScreen(),
    );
  }
}
