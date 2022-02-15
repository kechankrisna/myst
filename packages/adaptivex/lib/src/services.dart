import 'package:flutter/foundation.dart';

/// ### `DeviceService`
///
/// easy to identify the current running targent platform
class DeviceService {
  static bool get isAndroid =>
      kIsWeb ? false : defaultTargetPlatform == TargetPlatform.android;

  static bool get isIOS =>
      kIsWeb ? false : defaultTargetPlatform == TargetPlatform.iOS;

  static bool get isWindows =>
      kIsWeb ? false : defaultTargetPlatform == TargetPlatform.windows;

  static bool get isMacOS =>
      kIsWeb ? false : defaultTargetPlatform == TargetPlatform.macOS;

  static bool get isLinux =>
      kIsWeb ? false : defaultTargetPlatform == TargetPlatform.linux;

  static bool get isWeb => kIsWeb;

  static bool get isDesktop => kIsWeb
      ? false
      : (defaultTargetPlatform == TargetPlatform.macOS) ||
          (defaultTargetPlatform == TargetPlatform.windows) ||
          (defaultTargetPlatform == TargetPlatform.linux);

  static bool get isMobile => kIsWeb
      ? false
      : (defaultTargetPlatform == TargetPlatform.iOS) ||
          (defaultTargetPlatform == TargetPlatform.android);
}
