import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'full_screen_platform.dart';

class FullScreenButton extends StatelessWidget {
  const FullScreenButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        FullScreenService().requestFullScreen();
      },
      icon: Icon(MdiIcons.fullscreen),
    );
  }
}
