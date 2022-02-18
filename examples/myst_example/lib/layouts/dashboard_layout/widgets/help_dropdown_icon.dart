import 'package:myst_example/core.dart';

class HelperDropDownIcon extends StatelessWidget {
  const HelperDropDownIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double kListMenuItemHeight = 30;
    return PopupMenuButton<void>(
        initialValue: null,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Icon(
            MdiIcons.help,
            color: Colors.white,
          ),
        ),
        offset: Offset(0, (kToolbarHeight - 10)),
        itemBuilder: (_) => [
              PopupMenuItem(
                height: kListMenuItemHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("Documentation"), Icon(MdiIcons.openInNew)],
                ),
              ),
              PopupMenuItem(
                height: kListMenuItemHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("Start a tutorial")],
                ),
              ),
              PopupMenuItem(
                height: kListMenuItemHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("Get support")],
                ),
              ),
              PopupMenuItem(
                height: kListMenuItemHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("Help")],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                height: kListMenuItemHeight,
                child: Text("Keyboard shortcut"),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                height: kListMenuItemHeight,
                child: Text("Send feedback"),
              ),
            ]);
  }
}
