import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:myst_example/core.dart';
import 'package:screenshot/screenshot.dart';

class TemplateScreenHtmlEditor extends StatelessWidget {
  const TemplateScreenHtmlEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TemplateScreenEditor(),
        ),
        Expanded(
          child: TemplateScreenViewer(),
        ),
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
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode(canRequestFocus: true);
    super.initState();
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("update your template"),
          trailing: TextButton.icon(
            onPressed: () {
              context.read<TemplateScreenController>().validateInput();
            },
            icon: Icon(Icons.preview),
            label: Text("preview"),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: CodeField(
              controller: context.read<TemplateScreenController>().controller,
              minLines: 10,
              focusNode: focusNode,
              enabled: true,
            ),
          ),
        ),
      ],
    );
  }
}

class TemplateScreenViewer extends StatefulWidget {
  const TemplateScreenViewer({Key? key}) : super(key: key);

  @override
  State<TemplateScreenViewer> createState() => _TemplateScreenViewerState();
}

class _TemplateScreenViewerState extends State<TemplateScreenViewer> {
  late ScreenshotController _controller;

  @override
  void initState() {
    _controller = ScreenshotController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printGreen("build TemplateScreenViewer");

    /// return Container(
    ///   child: Column(
    ///     children: [
    ///       ListTile(
    ///         trailing: IconButton(
    ///           icon: Icon(Icons.screenshot),
    ///           onPressed: () {
    ///             double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    ///             var watch = Stopwatch();
    ///             watch.start();
    ///             _controller
    ///                 .capture(
    ///                     delay: const Duration(seconds: 1),
    ///                     pixelRatio: pixelRatio)
    ///                 .then((value) {
    ///               printGreen("${watch.elapsedMilliseconds} ms");
    ///               watch.stop();

    ///               showDialog(
    ///                 context: context,
    ///                 builder: (_) {
    ///                   return Dialog(
    ///                     child: Image.memory(value!),
    ///                   );
    ///                 },
    ///               );
    ///             });
    ///           },
    ///         ),
    ///       ),
    ///       Expanded(
    ///         child: Screenshot(
    ///           child: SingleChildScrollView(
    ///             child: AdaptiveWebView(
    ///               key: UniqueKey(),
    ///               content: context.select<TemplateScreenController, String>(
    ///                   (c) => c.htmlContent),
    ///             ),
    ///           ),
    ///           controller: _controller,
    ///         ),
    ///       ),
    ///     ],
    ///   ),
    /// );
    return Scaffold(
      body: Screenshot(
        child: SingleChildScrollView(
          child: Html(
            shrinkWrap: true,
            key: UniqueKey(),
            data: context
                .select<TemplateScreenController, String>((c) => c.htmlContent),
          ),

          /// child: AdaptiveWebView(
          ///   content: context.select<TemplateScreenController, String>(
          ///       (c) => c.htmlContent),
          /// ),
        ),
        controller: _controller,
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.screenshot),
        onPressed: () {
          var watch = Stopwatch();
          watch.start();
          _controller.capture().then((value) {
            printGreen("${watch.elapsedMilliseconds} ms");
            watch.stop();

            showDialog(
              context: context,
              builder: (_) {
                return Dialog(
                  child: Image.memory(value!),
                );
              },
            );
          });
        },
      ),
    );
  }
}
