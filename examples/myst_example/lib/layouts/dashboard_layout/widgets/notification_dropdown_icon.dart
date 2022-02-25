import 'package:myst_example/core.dart';

class NotificationDropDownIcon extends StatelessWidget {
  const NotificationDropDownIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double width = 600;
    return PopupMenuButton<void>(
        initialValue: null,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Icon(
            MdiIcons.bellAlert,
            color: Colors.white,
          ),
        ),
        offset: Offset(0, kToolbarHeight),
        constraints: BoxConstraints(minWidth: 300),
        itemBuilder: (_) => [
              PopupMenuTitle(
                child: Container(
                  width: width,
                  alignment: Alignment.center,
                  child: Text("Notifications"),
                ),
              ),
              PopupMenuDivider(),
              ...List.generate(
                3,
                (index) => PopupMenuItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Icon(MdiIcons.checkCircle),
                        padding: EdgeInsets.all(8),
                      ),
                      Expanded(
                          child: Text("Enable service: container.google.com")),
                    ],
                  ),
                ),
              ).toList()
            ]);
  }
}

class PopupMenuTitle extends PopupMenuEntry<Never> {
  final Widget child;
  const PopupMenuTitle({Key? key, this.height = 36, required this.child})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _PopupMenuTitleState();

  @override
  final double height;

  @override
  bool represents(void value) => false;
}

class _PopupMenuTitleState extends State<PopupMenuTitle> {
  @override
  Widget build(BuildContext context) =>
      SizedBox(height: widget.height, child: widget.child);
}
