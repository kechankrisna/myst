import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:flutter_highlight/themes/vs2015.dart';
import 'package:highlight/highlight.dart';
import 'package:highlight/languages/all.dart';
import 'package:highlight/languages/xml.dart';
import 'package:myst_example/core.dart';

class TemplateScreenController extends ChangeNotifier {
  late String inputString;
  late String htmlContent;
  late String error;
  late String themeName;
  late String languageName;
  late CodeController controller;

  static final List<String> themes = [...themeMap.keys.toList()];

  static final Map<String, Mode> languages = allLanguages;

  TemplateScreenController() {
    inputString = "";
    htmlContent = "";
    error = "";
    themeName = "vs2015";
    languageName = "xml";
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
      modifiers: [],
    );
  }

  changeTheme(String key) {
    var theme = themeMap[key];
    themeName = key;
    assert(theme != null);
    controller = controller.copyWith(theme: theme);
    notifyListeners();
  }

  changeLanguage(Mode language, String name) {
    languageName = name;
    controller = controller.copyWith(language: language);
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

extension on CodeController {
  CodeController copyWith({
    String? text,
    Mode? language,
    Map<String, TextStyle>? theme,
    Map<String, TextStyle>? patternMap,
    Map<String, TextStyle>? stringMap,
    EditorParams? params,
    List<CodeModifier>? modifiers,
    bool? webSpaceFix,
    void Function(String)? onChange,
  }) {
    return CodeController(
      text: text ?? this.text,
      language: language ?? this.language,
      theme: theme ?? this.theme,
      patternMap: patternMap ?? this.patternMap,
      stringMap: stringMap ?? this.stringMap,
      params: params ?? this.params,
      modifiers: modifiers ?? this.modifiers,
      webSpaceFix: webSpaceFix ?? this.webSpaceFix,
      onChange: this.onChange,
    );
  }
}
