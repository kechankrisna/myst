import 'package:flutter_portal/flutter_portal.dart';
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
    return PortalEntry(
      child: SizedBox(
        width: double.infinity,
        child: TextField(
          onTap: () => setState(() => _filled = true),
          decoration: InputDecoration(
            prefixIcon: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(Icons.search),
                ),
                Padding(
                  padding: EdgeInsets.all(6),
                  child: Text("Search"),
                ),
              ],
            ),
            filled: _filled,
            suffixIcon: IconButton(
                onPressed: () => setState(() => _isMore = !_isMore),
                icon: Icon(Icons.arrow_drop_down)),
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
        ),
      ),
      visible: _isMore,
      childAnchor: Alignment.bottomCenter,
      portalAnchor: Alignment.topCenter,
      portal: Material(
        elevation: 8,
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(title: Text('option 1')),
              ListTile(title: Text('option 2')),
            ],
          ),
        ),
      ),
    );
  }
}
