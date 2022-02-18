import 'package:myst_example/core.dart';
import 'package:tab_container/tab_container.dart';

class SelectProjectTitle extends StatelessWidget {
  const SelectProjectTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Text(
          "your project",
          style: themeData.textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => Dialog(
                  child: SelectProjectDialog(),
                ));
      },
    );
  }
}

class SelectProjectDialog extends StatelessWidget {
  const SelectProjectDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      constraints: BoxConstraints(maxWidth: 800),
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ListTile(
              title: Text(
                "select project".toUpperCase(),
                style: themeData.textTheme.titleLarge,
              ),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(MdiIcons.folderHome)),
                  TextButton(
                    onPressed: () {},
                    child: Text("new project".toUpperCase()),
                  )
                ],
              ),
            ),
          ),
          Divider(),
          TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search projects and folders")),
          Expanded(child: ListOfProjects()),
          SizedBox(
            width: double.infinity,
            child: Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () {}, child: Text("cancel".toUpperCase())),
                  TextButton(
                      onPressed: () {}, child: Text("open".toUpperCase())),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ListOfProjects extends StatelessWidget {
  const ListOfProjects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabContainer(
      children: [
        ListView.separated(
          itemCount: 7,
          itemBuilder: (_, i) => ListTile(
            dense: true,
            title: Text("project $i"),
          ),
          separatorBuilder: (_, i) => Divider(height: 1),
        ),
        ListView.separated(
          itemCount: 3,
          itemBuilder: (_, i) => ListTile(
            dense: true,
            title: Text("project ${i + 7}"),
          ),
          separatorBuilder: (_, i) => Divider(height: 1),
        ),
        ListView.separated(
          itemCount: 10,
          itemBuilder: (_, i) => ListTile(
            dense: true,
            title: Text("project $i"),
          ),
          separatorBuilder: (_, i) => Divider(height: 1),
        ),
      ],
      tabs: [
        Text("recent".toUpperCase()),
        Text("starred".toUpperCase()),
        Text("all".toUpperCase())
      ],
    );
  }
}
