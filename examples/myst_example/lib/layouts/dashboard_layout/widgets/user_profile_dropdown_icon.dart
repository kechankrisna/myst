import 'package:myst_example/core.dart';

class UserProfileDropDownIcon extends StatelessWidget {
  const UserProfileDropDownIcon({Key? key}) : super(key: key);

  static List<PopupMenuEntry> get menuItems {
    const double kListMenuItemHeight = 30;
    return [
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
        child: Text(
          "Send feedback",
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
        child: CircleAvatar(
          child: FadeInImage.assetNetwork(
              placeholder: placeholder, image: "https://i.pravatar.cc/300"),

          /// child: AdaptiveImage(
          ///   url: 'https://i.pravatar.cc/300',
          ///   width: 100,
          /// ),
        ),
      ),
      constraints: BoxConstraints(maxWidth: 300),
      offset: Offset(0, kToolbarHeight),
      itemBuilder: (_) => [
        PopupMenuItem(
          enabled: false,
          child: Text("This account is managed by ......com."),
        ),
        PopupMenuItem(
            enabled: false,
            child: Container(
              height: 100,
              child: Row(
                children: [
                  Flexible(
                    flex: 5,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 7,
                    child: UserAccountsDrawerHeader(
                      accountEmail: Text("accountEmail"),
                      accountName: Text("accountName"),
                    ),
                  ),
                ],
              ),
            )),
        PopupMenuItem(
          enabled: false,
          child: Row(
            children: [
              Expanded(child: SizedBox()),
              TextButton(
                  onPressed: () {
                    context.read<AuthenticationController>().logout();
                  },
                  child: Text("logout"))
            ],
          ),
        ),
      ],
    );
  }
}
