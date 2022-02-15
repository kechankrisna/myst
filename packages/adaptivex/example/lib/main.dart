import 'package:adaptivex/adaptivex.dart';
import 'package:example/my_cupertino_app.dart';
import 'package:example/my_fusion_app.dart';
import 'package:example/my_linux_app.dart';
import 'package:example/my_macos_app.dart';
import 'package:example/my_material_app.dart';
import 'package:example/my_web_app.dart';
import 'package:example/my_window_app.dart';

/// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// change this line to any target platform you want to see, except web version
  /// debugDefaultTargetPlatformOverride = TargetPlatform.android;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AdaptivePlatformWidget(
      child: MyFusionApp(),
      android: MyMaterialApp(),
      ios: MyCupertinoApp(),
      macos: MyMacosApp(),
      web: MyWebApp(),
      window: MyWindowApp(),
      linux: MyLinuxApp(),
    );
  }
}
