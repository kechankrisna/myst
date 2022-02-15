import 'package:adaptivex/adaptivex.dart';
import 'package:fluent_ui/fluent_ui.dart';

class WindowsAdaptiveScreen extends StatefulWidget {
  const WindowsAdaptiveScreen({Key? key}) : super(key: key);

  @override
  _WindowsAdaptiveScreenState createState() => _WindowsAdaptiveScreenState();
}

class _WindowsAdaptiveScreenState extends State<WindowsAdaptiveScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: const Text("adaptive builder on window"),
        leading: IconButton(
          icon: const Icon(FluentIcons.back),
          onPressed: () {},
        ),
      ),
      pane: NavigationPane(
        selected: index,
        onChanged: (i) => setState(() => index = i),
        size: const NavigationPaneSize(
          openMinWidth: 250,
          openMaxWidth: 320,
        ),
        header: Container(
          height: kOneLineTileHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size: 100,
          ),
        ),
        indicatorBuilder: () {
          return NavigationIndicator.sticky;
        }(),
        items: [
          // It doesn't look good when resizing from compact to open
          // PaneItemHeader(header: Text('User Interaction')),
          PaneItem(
            icon: const Icon(FluentIcons.checkbox_composite),
            title: const Text('Inputs'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.text_field),
            title: const Text('Forms'),
          ),
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.color),
            title: const Text('Colors'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.icon_sets_flag),
            title: const Text('Icons'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.plain_text),
            title: const Text('Typography'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.cell_phone),
            title: const Text('Mobile'),
          ),
        ],
        autoSuggestBox: AutoSuggestBox(
          controller: TextEditingController(),
          items: const ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
        ),
        autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
          ),
        ],
      ),
      content: NavigationBody(
        index: index,
        children: List.generate(8, (i) => const SampleScaffoldpage()).toList(),
      ),
    );
  }
}

class SampleScaffoldpage extends StatelessWidget {
  const SampleScaffoldpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text("adpative scafold page"),
      ),
      content: SizedBox.expand(
        child: Center(
          child: AdaptiveBuilder(
            xlBuilder: (_) => const Text("xlBuilder"),
            lgBuilder: (_) => const Text("lgBuilder"),
            mdBuilder: (_) => const Text("mdBuilder"),
            smBuilder: (_) => const Text("smBuilder"),

            /// xsBuilder: (_) => const Text("xsBuilder"),
            builder: (_) => const Text("xsBuilder"),
          ),
        ),
      ),
    );
  }
}
