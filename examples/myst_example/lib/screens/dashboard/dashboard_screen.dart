import 'package:myst_example/core.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatformWidget(
      child: DashboardLayout(
        child: _DashboardScreenBody(),
      ),
    );
  }
}

class _DashboardScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _DasbhoardSideBar(),
        VerticalDivider(width: 1),
        Expanded(child: _DashboardBody())
      ],
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("_DashboardBody"),
      ),
    );
  }
}

class _DasbhoardSideBar extends StatefulWidget {
  const _DasbhoardSideBar({Key? key}) : super(key: key);

  @override
  State<_DasbhoardSideBar> createState() => _DasbhoardSideBarState();
}

class _DasbhoardSideBarState extends State<_DasbhoardSideBar> {
  bool _isMini = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _isMini ? 75 : 300,
      child: Column(
        children: [
          _isMini
              ? IconButton(onPressed: () {}, icon: Icon(MdiIcons.api))
              : ListTile(
                  leading: Icon(MdiIcons.api),
                  title: Text("APIs and Services"),
                  onTap: () {},
                ),
          Divider(),
          Expanded(
            child: ListView(
              children: [
                _isMini
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(MdiIcons.viewDashboardOutline))
                    : ListTile(
                        leading: Icon(MdiIcons.viewDashboardOutline),
                        title: Text("Dashboard"),
                        onTap: () {},
                      ),
                _isMini
                    ? IconButton(onPressed: () {}, icon: Icon(MdiIcons.library))
                    : ListTile(
                        leading: Icon(MdiIcons.library),
                        title: Text("Libary"),
                        onTap: () {},
                      ),
                _isMini
                    ? IconButton(onPressed: () {}, icon: Icon(MdiIcons.key))
                    : ListTile(
                        leading: Icon(MdiIcons.key),
                        title: Text("Credential"),
                        onTap: () {},
                      ),
                _isMini
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(MdiIcons.twoFactorAuthentication))
                    : ListTile(
                        leading: Icon(MdiIcons.twoFactorAuthentication),
                        title: Text("OAuth consent screen"),
                        onTap: () {},
                      ),
                _isMini
                    ? IconButton(onPressed: () {}, icon: Icon(MdiIcons.check))
                    : ListTile(
                        leading: Icon(MdiIcons.check),
                        title: Text("Domain verification"),
                        onTap: () {},
                      ),
                _isMini
                    ? IconButton(onPressed: () {}, icon: Icon(MdiIcons.cogBox))
                    : ListTile(
                        leading: Icon(MdiIcons.cogBox),
                        title: Text("Page usage agreements"),
                        onTap: () {},
                      ),
              ],
            ),
          ),
          _isMini
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isMini = !_isMini;
                    });
                  },
                  icon: Icon(MdiIcons.pageLast))
              : ListTile(
                  leading: Icon(MdiIcons.pageFirst),
                  onTap: () {
                    setState(() {
                      _isMini = !_isMini;
                    });
                  },
                ),
        ],
      ),
    );
  }
}
