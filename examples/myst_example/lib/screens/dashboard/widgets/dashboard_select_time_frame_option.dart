import 'package:myst_example/core.dart';

class DashboardSelectTimeFrameOption extends StatefulWidget {
  const DashboardSelectTimeFrameOption({Key? key}) : super(key: key);

  @override
  State<DashboardSelectTimeFrameOption> createState() =>
      _DashboardSelectTimeFrameOptionState();
}

class _DashboardSelectTimeFrameOptionState
    extends State<DashboardSelectTimeFrameOption> {
  final _controller = DashboardSelectTimeFrameOptionController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) => AdaptiveBuilder(
          builder: builder,
          lgBuilder: lgBuilder,
          xlBuilder: lgBuilder,
        ),
      ),
    );
  }

  Widget builder(BuildContext context) {
    return Material(
      type: MaterialType.card,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          DropdownButton<String>(
            value: _controller.option,
            items: _controller.options
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: (v) => _controller.selectOption(v!),
          ),
        ],
      ),
    );
  }

  Widget lgBuilder(BuildContext context) {
    final themeData = Theme.of(context);
    return Material(
      type: MaterialType.card,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          ..._controller.options
              .map(
                (e) => e != _controller.option
                    ? TextButton(
                        onPressed: () => _controller.selectOption(e),
                        child: Text(
                          e,
                          style: themeData.textTheme.caption?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                    : TextButton.icon(
                        onPressed: () => _controller.selectOption(e),
                        icon: Icon(Icons.check),
                        label: Text(
                          e,
                          style: themeData.textTheme.caption?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              )
              .toList()
        ],
      ),
    );
  }
}

class DashboardSelectTimeFrameOptionController extends ChangeNotifier {
  late String option;

  List<String> get options {
    return [
      "1 hour",
      "6 hours",
      "12 hours",
      "1 day",
      "2 days",
      "4 days",
      "7 days",
      "14 days",
      "30 days",
    ];
  }

  DashboardSelectTimeFrameOptionController() {
    option = options.first;
  }

  selectOption(String v) {
    option = v;
    notifyListeners();
  }
}
