import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'dart:io' as io;

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

    /// if current maxWidth less than kXsBreakPoint
    if (width < kXsBreakPoint) {
      return BoxSize.xs;

      /// if current maxWidth between kXsBreakPoint and kSmBreakPoint
    } else if (kXsBreakPoint <= width && width < kSmBreakPoint) {
      return BoxSize.sm;

      /// if current maxWidth between kSmBreakPoint and kMdBreakPoint
    } else if (kSmBreakPoint <= width && width < kMdBreakPoint) {
      return BoxSize.md;

      /// if current maxWidth between kMdBreakPoint and kLgBreakPoint
    } else if (kMdBreakPoint <= width && width < kLgBreakPoint) {
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
    // (io.Platform.isIOS || io.Platform.isAndroid) &&
    final Size size = mediaQueryData.size;
    if (!kIsWeb) {
      if ((io.Platform.isIOS || io.Platform.isAndroid)) {
        return mediaQueryData.orientation == Orientation.landscape
            ? size.height
            : size.width;
      }
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
    if (!kIsWeb) {
      if ((io.Platform.isIOS || io.Platform.isAndroid)) {
        return mediaQueryData.orientation == Orientation.landscape
            ? size.width
            : size.height;
      }
    }
    return size.height;
  }

  /// `deviceType`
  ///
  /// represent the current device type based on its frame width
  ///
  ///
  DeviceType get deviceType {
    /// if device with less than kXsBreakPoint
    if (deviceWidth > 0 && deviceWidth < kXsBreakPoint) {
      return DeviceType.smartphone;

      /// if device with less than kSmBreakPoint
    } else if (deviceWidth >= kXsBreakPoint && deviceWidth < kSmBreakPoint) {
      return DeviceType.miniTablet;

      /// if device with less than kMdBreakPoint
    } else if (deviceWidth >= kSmBreakPoint && deviceWidth < kMdBreakPoint) {
      return DeviceType.tablet;

      /// if device with larger than kMdBreakPoint
    } else if (deviceWidth >= kMdBreakPoint) {
      return DeviceType.desktop;

      /// if device with larger than kLgBreakPoint
    } else if (deviceWidth >= kLgBreakPoint) {
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
    if (deviceWidth < kXsBreakPoint) {
      return DeviceSize.xs;
    } else if (kXsBreakPoint <= deviceWidth && deviceWidth < kSmBreakPoint) {
      return DeviceSize.sm;
    } else if (kSmBreakPoint <= deviceWidth && deviceWidth < kMdBreakPoint) {
      return DeviceSize.md;
    } else if (kMdBreakPoint <= deviceWidth && deviceWidth < kLgBreakPoint) {
      return DeviceSize.lg;
    } else {
      return DeviceSize.xl;
    }
  }

  /// `screenSize`
  ///
  /// represent the screen size enumeration while it based on screen width rather than device with
  /// sometime user rotate the device, then its screen width will be changed too
  ///
  ///
  ScreenSize get screenSize {
    final double width = screenWidth;
    if (width < kXsBreakPoint) {
      return ScreenSize.xs;
    } else if (kXsBreakPoint <= width && width < kSmBreakPoint) {
      return ScreenSize.sm;
    } else if (kSmBreakPoint <= width && width < kMdBreakPoint) {
      return ScreenSize.md;
    } else if (kMdBreakPoint <= width && width < kLgBreakPoint) {
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
}

/// `DeviceType`
///
/// refer to the type of device, this will
enum DeviceType { smartphone, miniTablet, tablet, desktop, unknown }

/// refer to the device width
enum DeviceSize { xs, sm, md, lg, xl }

/// refer to the screen width
enum ScreenSize { xs, sm, md, lg, xl }

/// refer to the box width
enum BoxSize { xs, sm, md, lg, xl }
