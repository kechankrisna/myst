library widgets;

import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/material.dart';

class AdaptiveBuilder extends StatelessWidget {
  /// `xlBuilder`
  ///
  /// this widget will render on xlarge width
  final Widget Function(BuildContext context)? xlBuilder;

  /// `lgBuilder`
  ///
  /// this widget will render on large width
  final Widget Function(BuildContext context)? lgBuilder;

  /// `mdBuilder`
  ///
  /// this widget will render on medium width
  final Widget Function(BuildContext context)? mdBuilder;

  /// `smBuilder`
  ///
  /// this widget will render on small width
  final Widget Function(BuildContext context)? smBuilder;

  /// `xsBuilder`
  ///
  /// this widget will render on xsmall width
  final Widget Function(BuildContext context)? xsBuilder;

  /// `builder`
  ///
  /// this is required as the default rendering
  final Widget Function(BuildContext context) builder;

  /// ### `AdaptiveBuilder`
  ///
  /// This widget will render base on context size width
  ///
  /// Example:
  /// ```dart
  /// Scaffold(
  ///   appBar: AppBar(
  ///     title: const Text("using adaptive builder"),
  ///   ),
  ///   body: Center(
  ///     child: AdaptiveBuilder(
  ///       xlBuilder: (_) => const Text("xlBuilder"),
  ///       lgBuilder: (_) => const Text("lgBuilder"),
  ///       mdBuilder: (_) => const Text("mdBuilder"),
  ///       smBuilder: (_) => const Text("smBuilder"),
  ///       // xsBuilder: (_) => const Text("xsBuilder"),
  ///       builder: (_) => const Text("xsBuilder"),
  ///     ),
  ///   ),
  /// )
  /// ```
  const AdaptiveBuilder({
    Key? key,
    this.xlBuilder,
    this.lgBuilder,
    this.mdBuilder,
    this.smBuilder,
    this.xsBuilder,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (context.deviceSize) {
      case DeviceSize.xl:
        return xlBuilder?.call(context) ?? builder.call(context);
      case DeviceSize.lg:
        return lgBuilder?.call(context) ?? builder.call(context);
      case DeviceSize.md:
        return mdBuilder?.call(context) ?? builder.call(context);
      case DeviceSize.sm:
        return smBuilder?.call(context) ?? builder.call(context);
      case DeviceSize.xs:
        return xsBuilder?.call(context) ?? builder.call(context);
      default:
        return builder.call(context);
    }
  }
}

class AdaptivePlatformWidget extends StatelessWidget {
  final Widget child;
  final Widget? web;
  final Widget? ios;
  final Widget? android;
  final Widget? macos;
  final Widget? window;
  final Widget? linux;

  /// ### `AdaptivePlatformWidget`
  ///
  /// This widget will render based on the current running platform
  ///
  /// Example:
  /// ```dart
  /// AdaptivePlatformWidget(
  ///   child: MyMaterialApp(),
  ///   ios: MyCupertinoApp(),
  ///   macos: MyMacosApp(),
  ///   web: MyWebApp(),
  ///   window: MyWindowApp(),
  /// )
  /// ```
  const AdaptivePlatformWidget({
    Key? key,
    required this.child,
    this.web,
    this.ios,
    this.android,
    this.macos,
    this.window,
    this.linux,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// if brower and web widget is not null
    if (DeviceService.isWeb && web != null) {
      return web!;
    }

    /// if android and android widget is not null
    else if (DeviceService.isWeb && web != null) {
      return web!;
    } else if (DeviceService.isAndroid && android != null) {
      return android!;

      /// if ios and ios widget is not null
    } else if (DeviceService.isIOS && ios != null) {
      return ios!;

      /// if macos and macos widget is not null
    } else if (DeviceService.isMacOS && macos != null) {
      return macos!;

      /// if window and window widget is not null
    } else if (DeviceService.isWindows && window != null) {
      return window!;

      /// if linux and linux widget is not null
    } else if (DeviceService.isLinux && linux != null) {
      return linux!;
    }

    return child;
  }
}
