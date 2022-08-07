import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class MacosAdaptiveScreen extends StatefulWidget {
  const MacosAdaptiveScreen({Key? key}) : super(key: key);

  @override
  State<MacosAdaptiveScreen> createState() => _MacosAdaptiveScreenState();
}

class _MacosAdaptiveScreenState extends State<MacosAdaptiveScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
        builder: (_, controller) {
          return SidebarItems(
            currentIndex: pageIndex,
            onChanged: (i) => setState(() => pageIndex = i),
            scrollController: controller,
            items: const [
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.square_on_circle),
                label: Text('Buttons'),
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.arrow_2_circlepath),
                label: Text('Indicators'),
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.textbox),
                label: Text('Fields'),
              ),
              SidebarItem(
                label: Text('Disclosure'),
                disclosureItems: [
                  SidebarItem(
                    leading: MacosIcon(CupertinoIcons.infinite),
                    label: Text('Colors'),
                  ),
                  SidebarItem(
                    leading: MacosIcon(CupertinoIcons.heart),
                    label: Text('Context Menus'),
                  ),
                  SidebarItem(
                    leading: MacosIcon(CupertinoIcons.infinite),
                    label: Text('Item 3'),
                  ),
                ],
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.rectangle),
                label: Text('Dialogs & Sheets'),
              ),
            ],
          );
        },
        minWidth: 400,
        bottom: const Padding(
          padding: EdgeInsets.all(16.0),
          child: MacosListTile(
            leading: MacosIcon(CupertinoIcons.profile_circled),
            title: Text('Tim Apple'),
            subtitle: Text('tim@apple.com'),
          ),
        ),
      ),
      child: IndexedStack(
        children: [
          CupertinoTabView(
            builder: (_) => MacosScaffold(
              toolBar: 
                   ToolBar(title: Text("adaptive builder on macos")),
              children: [
                ResizablePane(
                  minWidth: 180,
                  startWidth: 200,
                  windowBreakpoint: 700,
                  resizableSide: ResizableSide.right,
                  builder: (_, __) {
                    return const Center(
                      child: Text('Resizable Pane'),
                    );
                  },
                ),
                ContentArea(
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Center(
                      child: AdaptiveBuilder(
                        xlBuilder: (_) => const Text("xlBuilder"),
                        lgBuilder: (_) => const Text("lgBuilder"),
                        mdBuilder: (_) => const Text("mdBuilder"),
                        smBuilder: (_) => const Text("smBuilder"),

                        /// xsBuilder: (_) => const Text("xsBuilder"),
                        builder: (_) => const Text("xsBuilder"),
                      ),
                    );
                  },
                ),
                ResizablePane(
                  minWidth: 180,
                  startWidth: 200,
                  windowBreakpoint: 700,
                  resizableSide: ResizableSide.left,
                  builder: (_, __) {
                    return const Center(
                      child: Text('Resizable Pane'),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
