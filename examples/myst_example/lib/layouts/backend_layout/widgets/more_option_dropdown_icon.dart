import 'package:myst_example/core.dart';
import 'help_dropdown_icon.dart';

class MoreOptionDropDownIcon extends StatelessWidget {
  const MoreOptionDropDownIcon({Key? key}) : super(key: key);

  static List<PopupMenuEntry> get menuItems {
    const double kListMenuItemHeight = 30;
    final icon = Icon(MdiIcons.openInNew, color: Colors.grey);
    return [
      PopupMenuItem(
        height: kListMenuItemHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [Text("Perference"), icon],
        ),
      ),
      PopupMenuDivider(),
      PopupMenuItem(
        height: kListMenuItemHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [Text("Downloads"), icon],
        ),
      ),
      PopupMenuItem(
        height: kListMenuItemHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [Text("Cloud Partner"), icon],
        ),
      ),
      PopupMenuDivider(),
      PopupMenuItem(
        height: kListMenuItemHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [Text("Terms of service"), icon],
        ),
      ),
      PopupMenuItem(
        height: kListMenuItemHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [Text("Privacy"), icon],
        ),
      ),
      PopupMenuDivider(),
      PopupMenuItem(
        height: kListMenuItemHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [Text("project setting"), icon],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const double kListMenuItemHeight = 30;
    return PopupMenuButton<void>(
      initialValue: null,
      child: Container(
        padding: EdgeInsets.all(12),
        child: Icon(
          MdiIcons.dotsVertical,
          color: Colors.white,
        ),
      ),
      offset: Offset(0, (kToolbarHeight - 10)),
      itemBuilder: (_) => [
        if (context.isXSS) ...[
          PopupMenuItem(
              child: Text("Activate cloud sheel"),
              onTap: () {
                context.read<BackendLayoutController>().openConsole();
              }),
          PopupMenuDivider()
        ],
        ...menuItems,
        if (context.isXSS) ...HelperDropDownIcon.menuItems,
      ],
    );
  }
}
