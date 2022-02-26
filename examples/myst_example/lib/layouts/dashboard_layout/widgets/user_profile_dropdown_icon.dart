import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_network/image_network.dart';
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
    final imageUrl = "https://i.pravatar.cc/300";
    return PopupMenuButton<void>(
      initialValue: null,
      child: CircleAvatar(
        child: ImageNetwork(
          image: imageUrl,
          imageCache: CachedNetworkImageProvider(imageUrl),
          height: 100,
          width: 100,
          duration: 1500,
          curve: Curves.easeIn,
          onPointer: true,
          debugPrint: true,
          fullScreen: false,
          fitAndroidIos: BoxFit.cover,
          fitWeb: BoxFitWeb.cover,
          onLoading: const CircularProgressIndicator(
            color: Colors.indigoAccent,
          ),
          onError: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(70),
          onTap: null,
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
                      child: CircleAvatar(
                        child: ImageNetwork(
                          image: imageUrl,
                          imageCache: CachedNetworkImageProvider(imageUrl),
                          height: 150,
                          width: 150,
                          duration: 1500,
                          curve: Curves.easeIn,
                          onPointer: true,
                          debugPrint: false,
                          fullScreen: false,
                          fitAndroidIos: BoxFit.cover,
                          fitWeb: BoxFitWeb.cover,
                          onLoading: const CircularProgressIndicator(
                            color: Colors.indigoAccent,
                          ),
                          onError: const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(70),
                          onTap: () {
                            printCyan("hello bro");
                          },
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 7,
                    child: _UserProfileInfo(),
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

class _UserProfileInfo extends StatelessWidget {
  const _UserProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthenticationController>();
    final themeData = Theme.of(context);
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Colors.transparent),
      accountEmail: Text(
        "email is ${controller.name ?? ""}",
        style: themeData.textTheme.bodyText1,
      ),
      accountName: Text(
        "name is ${controller.token ?? ""}",
        style: themeData.textTheme.bodyText1,
      ),
    );
  }
}
