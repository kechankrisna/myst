/// import 'package:flutter_quill/flutter_quill.dart' as fq;
import 'package:code_editor/code_editor.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:myst_example/core.dart';

class TemplateScreenHtmlEditor extends StatelessWidget {
  const TemplateScreenHtmlEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSplitView(
      axis: Axis.horizontal,
      children: [
        TemplateScreenEditor(),
        TemplateScreenViewer(),
      ],
    );
  }
}

class TemplateScreenEditor extends StatefulWidget {
  const TemplateScreenEditor({Key? key}) : super(key: key);

  @override
  State<TemplateScreenEditor> createState() => _TemplateScreenEditorState();
}

class _TemplateScreenEditorState extends State<TemplateScreenEditor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text("update your template"),
          ),
          Expanded(
            child: SingleChildScrollView(
              /// child: fq.QuillEditor(
              ///   expands: true,
              ///   controller: fq.QuillController(
              ///       document: fq.Document(),
              ///       selection: TextSelection(baseOffset: 0, extentOffset: 1)),
              ///   scrollable: true,
              ///   autoFocus: true,
              ///   readOnly: false,
              ///   padding: EdgeInsets.zero,
              ///   focusNode: FocusNode(),
              ///   scrollController: ScrollController(),
              /// ),

              child: CodeEditor(
                model: EditorModel(
                  files: [], // the files created above
                  // you can customize the editor as you want
                  styleOptions: EditorModelStyleOptions(
                    fontSize: 13,
                  ),
                ),
                onSubmit: (language, content) {
                  context
                      .read<TemplateScreenController>()
                      .onChangeInput(content!);
                  context.read<TemplateScreenController>().validateInput();
                },
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  context.read<TemplateScreenController>().validateInput();
                },
                icon: Icon(Icons.preview),
                label: Text("preview"),
              )
            ],
          )
        ],
      ),
    );
  }
}

class TemplateScreenViewer extends StatefulWidget {
  const TemplateScreenViewer({Key? key}) : super(key: key);

  @override
  State<TemplateScreenViewer> createState() => _TemplateScreenViewerState();
}

class _TemplateScreenViewerState extends State<TemplateScreenViewer> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveWebView(
      content: context
          .select<TemplateScreenController, String>((c) => c.htmlContent),
    );
  }
}
