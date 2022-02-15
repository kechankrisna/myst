import 'package:adaptivex/adaptivex.dart';
import 'package:example/my_cupertino_app.dart';
import 'package:example/my_macos_app.dart';
import 'package:example/my_material_app.dart';
import 'package:example/my_web_app.dart';
import 'package:example/my_window_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const AdaptivePlatformWidget(
      child: MyMaterialApp(),
      ios: MyCupertinoApp(),
      macos: MyMacosApp(),
      web: MyWebApp(),
      window: MyWindowApp(),
    ),
  );
}
