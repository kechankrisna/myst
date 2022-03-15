library extensions;

import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/widgets.dart';

extension AdaptiveXBoxConstraintsParsing on BoxConstraints {
  /// `boxSize`
  ///
  /// box size on constrains work based on its maxWidth
  ///
  /// Example:
  /// ```dart
  ///   class Example extends StatelessWidget {
  ///   const Example({Key? key}) : super(key: key);
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return LayoutBuilder(
  ///       builder: (_, constrains) {
  ///         return Text("${constrains.boxSize}");
  ///       },
  ///     );
  ///   }
  /// }
  /// ```
  BoxSize get boxSize {
    final double width = maxWidth;

    /// if current maxWidth less than LayoutBreakPoint.kXsBreakPoint
    if (width < LayoutBreakPoint.kXsBreakPoint) {
      return BoxSize.xs;

      /// if current maxWidth between LayoutBreakPoint.kXsBreakPoint and LayoutBreakPoint.kSmBreakPoint
    } else if (LayoutBreakPoint.kXsBreakPoint <= width &&
        width < LayoutBreakPoint.kSmBreakPoint) {
      return BoxSize.sm;

      /// if current maxWidth between LayoutBreakPoint.kSmBreakPoint and LayoutBreakPoint.kMdBreakPoint
    } else if (LayoutBreakPoint.kSmBreakPoint <= width &&
        width < LayoutBreakPoint.kMdBreakPoint) {
      return BoxSize.md;

      /// if current maxWidth between LayoutBreakPoint.kMdBreakPoint and LayoutBreakPoint.kLgBreakPoint
    } else if (LayoutBreakPoint.kMdBreakPoint <= width &&
        width < LayoutBreakPoint.kLgBreakPoint) {
      return BoxSize.lg;

      /// else the size must be extremly large
    } else {
      return BoxSize.xl;
    }
  }
}

extension AdaptiveXBuildContextParsing on BuildContext {
  /// `boxWidth`
  ///
  /// its box size width
  ///
  /// Example:
  /// ```dart
  /// class Example extends StatelessWidget {
  /// const Example({Key? key}) : super(key: key);

  /// @override
  /// Widget build(BuildContext context) {
  ///   return Text("${context.boxWidth}");
  ///   }
  /// }
  /// ```
  double get boxWidth => mediaQueryData.size.width;

  /// `boxWidth`
  ///
  /// its screen size width
  /// Example:
  /// ```dart
  /// class Example extends StatelessWidget {
  /// const Example({Key? key}) : super(key: key);

  /// @override
  /// Widget build(BuildContext context) {
  ///   return Text("${context.screenWidth}");
  ///   }
  /// }
  /// ```
  double get screenWidth => mediaQueryData.size.width;

  /// `deviceWidth`
  ///
  /// represent the device height, check if current display in landscape
  /// mode then return its height as total width instead of its size width
  ///
  ///
  double get deviceWidth {
    final Size size = mediaQueryData.size;
    if (DeviceService.isMobile) {
      return mediaQueryData.orientation == Orientation.landscape
          ? size.height
          : size.width;
    }
    return size.width;
  }

  /// `deviceHeight`
  ///
  /// represent the device height, check if current display in landscape
  /// mode then return its width as total height instead of its size height
  ///
  ///
  double get deviceHeight {
    final Size size = mediaQueryData.size;
    if (DeviceService.isMobile) {
      return mediaQueryData.orientation == Orientation.landscape
          ? size.width
          : size.height;
    }
    return size.height;
  }

  /// `deviceType`
  ///
  /// represent the current device type based on its frame width
  ///
  ///
  DeviceType get deviceType {
    /// if device with less than LayoutBreakPoint.kXsBreakPoint
    if (deviceWidth > 0 && deviceWidth < LayoutBreakPoint.kXsBreakPoint) {
      return DeviceType.smartphone;

      /// if device with less than LayoutBreakPoint.kSmBreakPoint
    } else if (deviceWidth >= LayoutBreakPoint.kXsBreakPoint &&
        deviceWidth < LayoutBreakPoint.kSmBreakPoint) {
      return DeviceType.miniTablet;

      /// if device with less than LayoutBreakPoint.kMdBreakPoint
    } else if (deviceWidth >= LayoutBreakPoint.kSmBreakPoint &&
        deviceWidth < LayoutBreakPoint.kMdBreakPoint) {
      return DeviceType.tablet;

      /// if device with larger than LayoutBreakPoint.kMdBreakPoint
    } else if (deviceWidth >= LayoutBreakPoint.kMdBreakPoint) {
      return DeviceType.desktop;

      /// if device with larger than LayoutBreakPoint.kLgBreakPoint
    } else if (deviceWidth >= LayoutBreakPoint.kLgBreakPoint) {
      return DeviceType.desktop;

      /// can be negative number
    } else {
      return DeviceType.unknown;
    }
  }

  /// `deviceSize`
  ///
  /// represent the device size enumeration while it based on device width
  ///
  ///
  DeviceSize get deviceSize {
    if (deviceWidth < LayoutBreakPoint.kXsBreakPoint) {
      return DeviceSize.xs;
    } else if (LayoutBreakPoint.kXsBreakPoint <= deviceWidth &&
        deviceWidth < LayoutBreakPoint.kSmBreakPoint) {
      return DeviceSize.sm;
    } else if (LayoutBreakPoint.kSmBreakPoint <= deviceWidth &&
        deviceWidth < LayoutBreakPoint.kMdBreakPoint) {
      return DeviceSize.md;
    } else if (LayoutBreakPoint.kMdBreakPoint <= deviceWidth &&
        deviceWidth < LayoutBreakPoint.kLgBreakPoint) {
      return DeviceSize.lg;
    } else {
      return DeviceSize.xl;
    }
  }

  /// name convention to check if xsmall screen
  bool get isXs => deviceSize == DeviceSize.xs;

  /// name convention to check if small screen
  bool get isSm => deviceSize == DeviceSize.sm;

  /// name convention to check if xsmall or small screen
  bool get isXSS => deviceSize == DeviceSize.xs || deviceSize == DeviceSize.sm;

  /// name convention to check if medium screen
  bool get isMd => deviceSize == DeviceSize.md;

  /// name convention to check if xsmall or small screen or medium screen
  bool get isXSM =>
      deviceSize == DeviceSize.xs ||
      deviceSize == DeviceSize.sm ||
      deviceSize == DeviceSize.md;

  /// name convention to check if large screen
  bool get isLg => deviceSize == DeviceSize.lg;

  /// name convention to check if xlarge screen
  bool get isXl => deviceSize == DeviceSize.xl;

  bool get isXLL => deviceSize == DeviceSize.lg || deviceSize == DeviceSize.xl;

  bool get isXLM =>
      deviceSize == DeviceSize.lg ||
      deviceSize == DeviceSize.xl ||
      deviceSize == DeviceSize.md;

  /// `screenSize`
  ///
  /// represent the screen size enumeration while it based on screen width rather than device with
  /// sometime user rotate the device, then its screen width will be changed too
  ///
  ///
  ScreenSize get screenSize {
    final double width = screenWidth;
    if (width < LayoutBreakPoint.kXsBreakPoint) {
      return ScreenSize.xs;
    } else if (LayoutBreakPoint.kXsBreakPoint <= width &&
        width < LayoutBreakPoint.kSmBreakPoint) {
      return ScreenSize.sm;
    } else if (LayoutBreakPoint.kSmBreakPoint <= width &&
        width < LayoutBreakPoint.kMdBreakPoint) {
      return ScreenSize.md;
    } else if (LayoutBreakPoint.kMdBreakPoint <= width &&
        width < LayoutBreakPoint.kLgBreakPoint) {
      return ScreenSize.lg;
    } else {
      return ScreenSize.xl;
    }
  }

  /// `orientation`
  ///
  /// the alias use instead of MediaQuery.of(this).orientation
  ///
  /// Usage: ```
  /// context.orientation
  /// ```
  Orientation get orientation => mediaQueryData.orientation;

  /// `mediaQueryData`
  ///
  /// alias use instead of MediaQuery.of(this)
  ///
  /// Usage: ```
  /// context.mediaQueryData
  /// ```
  MediaQueryData get mediaQueryData => MediaQuery.of(this);

  /// MediaQueryData.fromWindow(WidgetsBinding.instance.window);
}
