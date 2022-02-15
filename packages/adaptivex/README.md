### adpativex

This package allow you to build the widget based on width (screen) size or platform.You can use design any adaptive ui base on the running platform, and very flexible ot the screen size.

#### screenshot

![ios](https://github.com/kechankrisna/myst/blob/main/packages/adaptivex/screenshot/ios.png?raw=true)

![macos](https://github.com/kechankrisna/myst/blob/main/packages/adaptivex/screenshot/macos.png?raw=true)

![windows](https://github.com/kechankrisna/myst/blob/main/packages/adaptivex/screenshot/windows.png?raw=true)

![web](https://github.com/kechankrisna/myst/blob/main/packages/adaptivex/screenshot/web.png?raw=true)


### Getting start

Make sure you have flutter and dart installed on you current marchine

```yaml
flutter pub add adaptivex
```

### Widgets

| widget                 | description                                                   | parameters                                                |
| ---------------------- | ------------------------------------------------------------- | --------------------------------------------------------- |
| AdaptivePlatformWidget | This widget will render based on the current running platform | Widget child is required                                  |
| AdaptiveBuilder        | This widget will render base on context size width            | Widget Function(BuildContext context) builder is required |

### usage

`AdaptiveBuilder`: use this widget when you want to render different ui for different screen size

```dart
Scaffold(
  appBar: AppBar(
    title: const Text("using adaptive builder"),
  ),
  body: Center(
    child: AdaptiveBuilder(
      xlBuilder: (_) => const Text("xlBuilder"),
      lgBuilder: (_) => const Text("lgBuilder"),
      mdBuilder: (_) => const Text("mdBuilder"),
      smBuilder: (_) => const Text("smBuilder"),
      // xsBuilder: (_) => const Text("xsBuilder"),
      builder: (_) => const Text("xsBuilder"),
    ),
  ),
)
```

`AdaptivePlatformWidget`: use this widget when you want use different ui for different platform
```dart
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

```



### for more information please take a took at the example
