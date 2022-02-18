import 'package:myst_example/core.dart';

class MoreOptionDropDownIcon extends StatelessWidget {
  const MoreOptionDropDownIcon({Key? key}) : super(key: key);

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
              PopupMenuItem(
                height: kListMenuItemHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("Perference"), Icon(MdiIcons.openInNew)],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                height: kListMenuItemHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("Downloads"), Icon(MdiIcons.openInNew)],
                ),
              ),
              PopupMenuItem(
                height: kListMenuItemHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("Cloud Partner"), Icon(MdiIcons.openInNew)],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                height: kListMenuItemHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Terms of service"),
                    Icon(MdiIcons.openInNew)
                  ],
                ),
              ),
              PopupMenuItem(
                height: kListMenuItemHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("Privacy"), Icon(MdiIcons.openInNew)],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                height: kListMenuItemHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("project setting"), Icon(MdiIcons.openInNew)],
                ),
              ),
            ]);
  }
}
