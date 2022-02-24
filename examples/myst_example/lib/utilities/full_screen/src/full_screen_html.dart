// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class FullScreenService {
  requestFullScreen() {
    html.document.documentElement?.requestFullscreen();

    /// html.document.querySelector("testtesttest")?.requestFullscreen();

    /// html.document.documentElement?.requestFullscreen();
  }

  exitFullScreen() {
    html.document.exitFullscreen();
  }
}
