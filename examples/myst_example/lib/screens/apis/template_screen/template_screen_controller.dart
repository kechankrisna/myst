import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:flutter_highlight/themes/vs2015.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:highlight/highlight.dart';
import 'package:highlight/languages/xml.dart';
import 'package:myst_example/core.dart';

class TemplateScreenController extends ChangeNotifier {
  late String inputString;
  late String htmlContent;
  late String error;
  late CodeController controller;

  TemplateScreenController() {
    inputString = "";
    htmlContent = "";
    error = "";

    controller = CodeController(
      language: xml,
      theme: vs2015Theme,
      onChange: onChangeInput,
      patternMap: {
        r"\.\.":
            TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
        r"\{{.*?\}}":
            TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent),
        r"\{%.*?\%}":
            TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
      },
      modifiers: [
        /// const IntendModifier(),
        /// const CloseBlockModifier(),

        /// const TabModifier(),
      ],
    );
  }

  changeTheme(String key) {
    /// controller.theme;
    notifyListeners();
  }

  changeLanguage(Mode vaue) {
    controller.language;
    notifyListeners();
  }

  onChangeInput(String v) {
    inputString = v;
    notifyListeners();
  }

  validateInput() {
    var _parsed = _tryParsed(inputString);
    printBlue("_parsed is $_parsed");
    if (_parsed != null) {
      _onChangeHtml(_parsed);
    } else {
      onChangeError("some thing error");
    }
  }

  String? _tryParsed(String v) {
    /// if not error then return
    /// else null
    return v;
  }

  String _parsed(String v) {
    /// v is input
    /// while output will be ...
    return v;
  }

  _onChangeHtml(String v) {
    htmlContent = v;
    notifyListeners();
    print("Onchanged");
  }

  onChangeError(String v) {
    error = v;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
