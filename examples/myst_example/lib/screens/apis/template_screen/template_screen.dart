import 'package:myst_example/core.dart';
import 'widgets/template_screen_html_editor.dart';

class TemplateScreen extends StatelessWidget {
  const TemplateScreen({Key? key}) : super(key: key);

  static const Key screenKey = ValueKey("TemplateScreen");

  static const String title = "template";

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatformWidget(
      child: ApiLayout(
        child: ChangeNotifierProvider(
          create: (_) => TemplateScreenController(),
          child: TemplateScreenBody(),
        ),
      ),
    );
  }
}

class TemplateScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: builder,
      xsBuilder: xsBuilder,
      smBuilder: xsBuilder,
    );
  }

  Widget xsBuilder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ApiLayoutSideBar(),
        TemplateScreenBodyHeader(),
        Divider(),
        Expanded(
          child: SingleChildScrollView(
            primary: false,
            child: TemplateScreenHtmlEditor(),
          ),
        )
      ],
    );
  }

  Widget builder(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ApiLayoutSideBar(),
        VerticalDivider(width: 1),
        Expanded(
          child: Material(
            type: MaterialType.card,
            child: TemplateScreenHtmlEditor(),
          ),
        )
      ],
    );
  }
}

class TemplateScreenBodyHeader extends StatelessWidget {
  const TemplateScreenBodyHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      child: ListTile(
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text("customize your template here"),
            ),
          ],
        ),
      ),
    );
  }
}
