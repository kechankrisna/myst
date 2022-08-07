library widgets;

import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/material.dart';

/// import 'package:printx/printx.dart';

class AdaptiveBuilder extends StatelessWidget {
  /// `xlBuilder`
  ///
  /// this widget will render on xlarge width
  final WidgetBuilder? xlBuilder;

  /// `lgBuilder`
  ///
  /// this widget will render on large width
  final WidgetBuilder? lgBuilder;

  /// `mdBuilder`
  ///
  /// this widget will render on medium width
  final WidgetBuilder? mdBuilder;

  /// `smBuilder`
  ///
  /// this widget will render on small width
  final WidgetBuilder? smBuilder;

  /// `xsBuilder`
  ///
  /// this widget will render on xsmall width
  final WidgetBuilder? xsBuilder;

  /// `builder`
  ///
  /// this is required as the default rendering
  final WidgetBuilder builder;

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
        // extra large builder or large builder or medium builder or small builder or extra small builder or default builder
        return xlBuilder?.call(context) ??
            lgBuilder?.call(context) ??
            mdBuilder?.call(context) ??
            smBuilder?.call(context) ??
            xsBuilder?.call(context) ??
            builder.call(context);
      case DeviceSize.lg:
        // large builder or medium builder or small builder or extra small builder or default builder
        return lgBuilder?.call(context) ??
            mdBuilder?.call(context) ??
            smBuilder?.call(context) ??
            xsBuilder?.call(context) ??
            builder.call(context);
      case DeviceSize.md:
        // medium builder or small builder or extra small builder or default builder
        return mdBuilder?.call(context) ??
            smBuilder?.call(context) ??
            xsBuilder?.call(context) ??
            builder.call(context);
      case DeviceSize.sm:
        // small builder or extra small builder or default builder
        return smBuilder?.call(context) ??
            xsBuilder?.call(context) ??
            builder.call(context);
        // extra small builder or default
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

class AdaptivePopup extends StatefulWidget {
  /// `child`
  /// Creates a widget that centers its child.
  final Widget child;
  final WidgetBuilder builder;
  final bool barrierDismissible;
  final Color barrierColor;
  final Offset offset;
  final Duration animationDuration;
  final double? maxDropdownWidth;
  final double? maxDropdownHeight;
  final PopupPosition position;
  final RouteSettings? settings;
  final bool isPopped;
  final Function(bool value)? onPopup;

  /// create a widget for an adptive dropdown
  ///
  /// `child` will render by default
  ///
  /// `builder` will be hide by default and only render when gesture dectected
  ///
  /// `barrierColor` will be used for force display dropdown overlay in defferent color
  ///
  /// `animationDuration` duration of trasition builder
  ///
  ///
  const AdaptivePopup({
    Key? key,
    required this.child,
    required this.builder,
    this.barrierDismissible = true,
    this.offset = Offset.zero,
    this.animationDuration = const Duration(milliseconds: 100),
    this.maxDropdownWidth,
    this.maxDropdownHeight,
    this.position = PopupPosition.bottom,
    this.barrierColor = Colors.transparent,
    this.settings,
    this.onPopup,
    this.isPopped = false,
  }) : super(key: key);

  @override
  _AdaptivePopupState createState() => _AdaptivePopupState();
}

class _AdaptivePopupState extends State<AdaptivePopup> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    if (widget.isPopped == true) {
      Future.delayed(widget.animationDuration)
          .then((value) => _onPoppedUp.call());
    }
  }

  Positioned getPosition({
    required Widget child,
    required Offset offset,
    required Size childSize,
  }) {
    /// printGreen(offset);
    /// printCyan(widget.alignment);
    /// printGreen(childSize);
    final dropDownWidth = widget.maxDropdownWidth ?? childSize.width;

    /// final dropDownHeight = widget.maxDropdownHeight ?? childSize.height;

    if (widget.position == PopupPosition.bottom) {
      final extendHeight = 5;
      final right = offset.dx + childSize.width - dropDownWidth;
      final top = (offset.dy + childSize.height + extendHeight);
      return Positioned(
        right: right,
        top: top,
        left: null,
        bottom: null,
        child: child,
      );
    } else if (widget.position == PopupPosition.top) {
      final right = offset.dx + childSize.width - dropDownWidth;
      final bottom = (offset.dy);
      return Positioned(
        right: right,
        top: null,
        left: null,
        bottom: bottom,
        child: child,
      );
    }
    return Positioned(
      right: offset.dx,
      top: offset.dy,
      child: child,
    );
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  _onPoppedUp() async {
    /// final _screenSize = MediaQuery.of(context).size;
    /// final _overlayBackground = widget.overlayBackground;
    /// final _animationDuration = widget.animationDuration;
    /// final _opacity = widget.opacity;
    final overlay = _globalKey.currentContext!.findRenderObject() as RenderBox;
    final childSize = (overlay.size);
    final _offset = overlay.localToGlobal(widget.offset);
    final Widget build = widget.builder(context);
    final dropDownWidth = widget.maxDropdownWidth ?? childSize.width;
    final dropDownHeight = widget.maxDropdownHeight ?? childSize.height;

    /// printRed("dropDownHeight $dropDownHeight");
    /// printRed("dropDownWidth $dropDownWidth");

    var position = getPosition(
      offset: _offset,
      childSize: childSize,
      child: build,
    );

    ///
    widget.onPopup?.call(true);

    await Navigator.of(context).push(
      AdaptivePopupRoute(
        builder: (_) => build,
        settings: widget.settings,
        top: position.top,
        right: position.right,
        bottom: position.bottom,
        left: position.left,
        contentHeight: dropDownHeight,
        contentWidth: dropDownWidth,
        barrierDismissible: widget.barrierDismissible,
        barrierColor: widget.barrierColor,
        duration: widget.animationDuration,
      ),
    );

    widget.onPopup?.call(false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _globalKey,
      child: widget.child,
      onTap: _onPoppedUp,
    );
  }
}

enum PopupPosition { top, bottom }
