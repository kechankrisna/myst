export 'src/adaptive_image_none.dart'
    if (dart.library.io) 'src/adaptive_image_io.dart'
    if (dart.library.html) 'src/adaptive_image_html.dart';


/// image https://stackoverflow.com/questions/65630743/how-to-solve-flutter-web-api-cors-error-only-with-dart-code