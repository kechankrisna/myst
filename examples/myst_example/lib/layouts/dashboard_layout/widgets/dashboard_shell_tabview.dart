import 'dart:math';
import 'package:myst_example/core.dart';


class DashboardShellTabView extends StatefulWidget {
  const DashboardShellTabView({Key? key}) : super(key: key);

  @override
  State<DashboardShellTabView> createState() => _DashboardShellTabViewState();
}

class _DashboardShellTabViewState extends State<DashboardShellTabView> {
  late int _index = 0;
  List<int> tabs = List.generate(2, (i) => Random().nextInt(1000000));
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        ...tabs
            .map((index) => TabItem(
                  index: index,
                  isActive: _index == index,
                  onTap: () {
                    setState(() {
                      _index = index;
                    });
                  },
                  onClose: () {
                    setState(() {
                      tabs.removeWhere((e) => e == index);
                    });
                  },
                ))
            .toList(),
        IconButton(
          onPressed: () {
            var index = Random().nextInt(1000000);
            setState(() {
              tabs.add(index);
              _index = index;
            });
          },
          icon: Icon(Icons.add),
        )
      ],
    );
  }
}

class TabItem extends StatelessWidget {
  final bool isActive;
  final int index;
  final Function()? onTap;
  final Function()? onClose;
  const TabItem({
    Key? key,
    this.isActive = false,
    required this.index,
    this.onTap,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: isActive
              ? Border(
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "(prime-buffer-$index)",
              style: TextStyle(
                color: isActive ? Theme.of(context).primaryColor : null,
              ),
            ),
            IconButton(
              onPressed: onClose,
              icon: Icon(Icons.close),
              color: isActive ? Theme.of(context).primaryColor : null,
            )
          ],
        ),
      ),
    );
  }
}
