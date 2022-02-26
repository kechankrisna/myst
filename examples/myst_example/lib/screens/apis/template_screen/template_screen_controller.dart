import 'package:html_editor_enhanced/html_editor.dart';
import 'package:myst_example/core.dart';

class TemplateScreenController extends ChangeNotifier {
  late String inputString;
  late String htmlContent;
  late HtmlEditorController controller;
  late String error;

  TemplateScreenController() {
    inputString = "";
    htmlContent = "";
    error = "";
    controller = HtmlEditorController();
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
  }

  onChangeError(String v) {
    error = v;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.disable();
    super.dispose();
  }
}
