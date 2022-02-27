import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:highlight/highlight_core.dart';
import 'package:myst_example/core.dart';
import 'package:screenshot/screenshot.dart';

class TemplateScreenHtmlEditor extends StatelessWidget {
  const TemplateScreenHtmlEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: builder,
      xsBuilder: xsBuilder,
      smBuilder: xsBuilder,
    );
  }

  Widget builder(BuildContext context) {
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

  Widget xsBuilder(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: TemplateScreenEditor(),
          ),
          AspectRatio(
            aspectRatio: 1,
            child: TemplateScreenViewer(),
          ),
        ],
      ),
    );
  }
}

class TemplateScreenEditor extends StatelessWidget {
  const TemplateScreenEditor({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    printGreen("build TemplateScreenEditor");
    return Column(
      children: [
        ChangeThemeListTile(),
        Expanded(
          child: SingleChildScrollView(
            child: TemplateCodeField(),
          ),
        ),
      ],
    );
  }
}

class TemplateCodeField extends StatefulWidget {
  const TemplateCodeField({Key? key}) : super(key: key);

  @override
  State<TemplateCodeField> createState() => _TemplateCodeFieldState();
}

class _TemplateCodeFieldState extends State<TemplateCodeField> {
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
    final controller = context
        .select<TemplateScreenController, CodeController>((x) => x.controller);
    return CodeField(
      key: UniqueKey(),
      controller: controller,
      minLines: 10,
      focusNode: focusNode,
      enabled: true,
    );
  }
}

class ChangeThemeListTile extends StatelessWidget {
  const ChangeThemeListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    printGreen("build ChangeThemeListTile");
    return ListTile(
      leading: DropdownButton<String>(
        value: context
            .select<TemplateScreenController, String>((x) => x.themeName),
        onChanged: (v) {
          context.read<TemplateScreenController>().changeTheme(v!);
        },
        items: TemplateScreenController.themes
            .map((e) => DropdownMenuItem(
                  child: Text("$e"),
                  value: e,
                ))
            .toList(),
      ),
      title: _ChangeLanguagePopup(),
      trailing: TextButton.icon(
        onPressed: () {
          context.read<TemplateScreenController>().validateInput();
        },
        icon: Icon(Icons.preview),
        label: Text("preview"),
      ),
    );
  }
}

class _ChangeLanguagePopup extends StatelessWidget {
  const _ChangeLanguagePopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: ListTile(
        title: Text("${context.read<TemplateScreenController>().languageName}"),
      ),
      itemBuilder: (_) => [
        ...TemplateScreenController.languages.entries
            .map(
              (e) => PopupMenuItem(
                child: Text("${e.key}"),
                onTap: () {
                  context
                      .read<TemplateScreenController>()
                      .changeLanguage(e.value, e.key);
                },
              ),
            )
            .toList()
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
