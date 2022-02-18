import 'package:myst_example/core.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeLayout(
      appBar: AppBar(title: const Text("your post list")),
      child: const _PostListBody(
        key: ValueKey("_PostListBody"),
      ),
    );
  }
}

class _PostListBody extends StatefulWidget {
  const _PostListBody({Key? key}) : super(key: key);

  @override
  __PostListBodyState createState() => __PostListBodyState();
}

class __PostListBodyState extends State<_PostListBody> {
  @override
  Widget build(BuildContext context) {
    printGreen(runtimeType);
    return Container(
      child: Center(
        child: Text("post list view"),
      ),
    );
  }
}
