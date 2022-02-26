import 'package:myst_example/core.dart';
import 'dasbhoard_title.dart';
import 'select_project_title.dart';

class DashboardLayoutDrawer extends StatelessWidget {
  const DashboardLayoutDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          if (context.isXSS)
            ListTile(
              title: DashboardTitle(),
            ),
          if (context.isXSS) Divider(),
          if (context.isXSS) SelectProjectTitle(),
          if (context.isXSS) Divider(),
          ListTile(
            title: Text("Home"),
            leading: Icon(MdiIcons.homeOutline),
            onTap: () {},
          ),
          ListTile(
            title: Text("Recent"),
            leading: Icon(MdiIcons.history),
            onTap: () {},
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: ListTile(
              title: Text("View all products"),
              leading: Icon(MdiIcons.viewDashboard),
              onTap: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  side: BorderSide(
                    color: Theme.of(context).dividerColor,
                  )),
            ),
          ),
          Divider(height: 1),
          ListTile(
            title: Text("PINNED"),
          ),
          PopupMenuButton<String>(
            enabled: true,
            offset: Offset(kDrawerWidth, 0),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: ListTile(
                  title: Text("Myst Cloud Service"),
                ),
              ),
            ],
            child: ListTile(
              title: Text("APIs and Services"),
              leading: Icon(MdiIcons.api),
              trailing: Icon(MdiIcons.arrowRightThin),
              onTap: null,
            ),
          ),

          /// ExpansionTile(
          ///   initiallyExpanded: true,
          ///   title: ListTile(
          ///     title: Text("APIs and Services"),
          ///     leading: Icon(MdiIcons.api),
          ///     onTap: () {},
          ///   ),
          ///   children: [
          ///     ListTile(
          ///       title: Text("Myst Cloud Service"),
          ///     ),
          ///   ],
          /// ),
          ListTile(
            title: Text("Marketplace"),
            leading: Icon(MdiIcons.basketPlusOutline),
            onTap: () {},
          ),
          Divider(height: 1),
          ListTile(
            title: Text("MORE PRODUCTS"),
          ),
          Divider(height: 1),
          Expanded(
              child: ListView.builder(
            primary: false,
            itemCount: 100,
            itemBuilder: (_, i) => ListTile(
              title: Text("Product random"),
              onTap: () {},
            ),
          ))
        ],
      ),
    );
  }
}

class CustomPopupMouseOver extends StatefulWidget {
  const CustomPopupMouseOver({Key? key}) : super(key: key);

  @override
  State<CustomPopupMouseOver> createState() => _CustomPopupMouseOverState();
}

class _CustomPopupMouseOverState extends State<CustomPopupMouseOver> {
  double _animatedContainerHeight = 30; //Default height
  double _animatedContainerWidth = 30; //Default width

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          _animatedContainerHeight = 50; //OnHover height
          _animatedContainerWidth = 50; //OnHover width
        });
      },
      onExit: (value) {
        setState(() {
          _animatedContainerHeight = 30; //Return back to normal height
          _animatedContainerWidth = 30; //Return back to normal width
        });
      },
      cursor: SystemMouseCursors.click, //Cursor type on hover
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: _animatedContainerHeight, //Animation height control
        width: _animatedContainerWidth, //Animation width control
      ),
    );
  }
}
