import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:myst_example/core.dart';

class SearchProductResource extends StatefulWidget {
  const SearchProductResource({Key? key}) : super(key: key);

  @override
  State<SearchProductResource> createState() => _SearchProductResourceState();
}

class _SearchProductResourceState extends State<SearchProductResource> {
  bool _isMore = false;
  bool _filled = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CardTheme cardTheme = CardTheme.of(context);

    return SizedBox(
      width: double.infinity,
      child: LayoutBuilder(builder: (_, constrains) {
        return TextField(
          onTap: () => setState(() => _filled = true),
          decoration: InputDecoration(
            prefixIcon: Container(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Icon(Icons.search_outlined),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                  ),
                  Container(
                    child: Text("Search"),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                  ),
                ],
              ),
            ),
            filled: _filled,
            suffixIcon: PopupMenuButton(
              offset: Offset(0, kTextTabBarHeight),
              constraints: BoxConstraints(minWidth: constrains.maxWidth),
              onCanceled: () {
                setState(() => _isMore = false);
              },
              child:
                  Icon(!_isMore ? Icons.arrow_drop_down : Icons.arrow_drop_up),
              itemBuilder: (_) => [
                PopupMenuItem(
                  enabled: false,
                  child: CustomFilter(),
                ),
              ],
            ),
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              gapPadding: 4.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              gapPadding: 4.0,
            ),
          ),
        );
      }),
    );
  }
}

class CustomFilter extends StatefulWidget {
  const CustomFilter({Key? key}) : super(key: key);

  @override
  _CustomFilterState createState() => _CustomFilterState();
}

class _CustomFilterState extends State<CustomFilter> {
  String _project = "any";
  String _type = "all";
  CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("Filter by"),
            trailing: IconButton(
                onPressed: () async {
                  var result = await showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      child: Container(
                        width: 500,
                        height: 500,
                        child: Container(
                          child: Center(
                            child: Text("i am center"),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.horizontal_distribute)),
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              label: Text("Project"),
            ),
            value: _project,
            items: [
              DropdownMenuItem(
                child: Text("Any"),
                value: "any",
                onTap: () {},
              ),
              DropdownMenuItem(
                child: Text("Current"),
                value: "current",
                onTap: () {},
              ),
            ],
            onChanged: (v) {
              setState(() => _project = v!);
            },
            onSaved: (v) {
              setState(() => _project = v!);
            },
          ),
          SizedBox(height: 15),
          PopupMenuButton(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: ListTile(
                title: Text("Type"),
                trailing: Icon(Icons.arrow_drop_down),
              ),
            ),
            constraints: BoxConstraints(minWidth: 400),
            itemBuilder: (_) => [
              PopupMenuItem(
                enabled: false,
                child: Container(
                  width: 400,
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CheckboxListTile(
                        value: false,
                        onChanged: (v) => {},
                        title: Text("Select all"),
                      ),
                      Divider(),
                      Expanded(
                        child: ListView(
                          children: [
                            ListTile(
                              dense: true,
                              title: Text("General"),
                            ),
                            CheckboxListTile(
                              dense: true,
                              value: false,
                              onChanged: (v) {},
                              title: Text("Product or Page"),
                            ),
                            CheckboxListTile(
                              dense: true,
                              value: false,
                              onChanged: (v) {},
                              title: Text("Product or Page"),
                            ),
                            CheckboxListTile(
                              dense: true,
                              value: false,
                              onChanged: (v) {},
                              title: Text("Product or Page"),
                            ),
                            CheckboxListTile(
                              dense: true,
                              value: false,
                              onChanged: (v) {},
                              title: Text("Product or Page"),
                            ),
                            CheckboxListTile(
                              dense: true,
                              value: false,
                              onChanged: (v) {},
                              title: Text("Product or Page"),
                            ),
                            Divider(),
                            ListTile(
                              dense: true,
                              title: Text("General"),
                            ),
                            CheckboxListTile(
                              dense: true,
                              value: false,
                              onChanged: (v) {},
                              title: Text("Product or Page"),
                            ),
                            CheckboxListTile(
                              dense: true,
                              value: false,
                              onChanged: (v) {},
                              title: Text("Product or Page"),
                            ),
                            CheckboxListTile(
                              dense: true,
                              value: false,
                              onChanged: (v) {},
                              title: Text("Product or Page"),
                            ),
                            CheckboxListTile(
                              dense: true,
                              value: false,
                              onChanged: (v) {},
                              title: Text("Product or Page"),
                            ),
                            CheckboxListTile(
                              dense: true,
                              value: false,
                              onChanged: (v) {},
                              title: Text("Product or Page"),
                            ),
                            Divider(),
                            ListTile(
                              dense: true,
                              title: Text("General"),
                            ),
                            CheckboxListTile(
                              dense: true,
                              value: false,
                              onChanged: (v) {},
                              title: Text("Product or Page"),
                            ),
                            CheckboxListTile(
                              dense: true,
                              value: false,
                              onChanged: (v) {},
                              title: Text("Product or Page"),
                            ),
                            CheckboxListTile(
                              dense: true,
                              value: false,
                              onChanged: (v) {},
                              title: Text("Product or Page"),
                            ),
                            CheckboxListTile(
                              dense: true,
                              value: false,
                              onChanged: (v) {},
                              title: Text("Product or Page"),
                            ),
                            CheckboxListTile(
                              dense: true,
                              value: false,
                              onChanged: (v) {},
                              title: Text("Product or Page"),
                            )
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      Container(
                        padding: EdgeInsets.all(6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text("close"),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Container(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("cancel")),
                TextButton(
                    onPressed: () {
                      ///
                      Navigator.of(context).pop();
                    },
                    child: Text("search")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
