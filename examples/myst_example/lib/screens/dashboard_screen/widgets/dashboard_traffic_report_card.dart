import 'dart:math';

import 'package:myst_example/core.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardTrafficReportCard extends StatefulWidget {
  final Widget title;
  const DashboardTrafficReportCard({Key? key, required this.title})
      : super(key: key);

  @override
  State<DashboardTrafficReportCard> createState() =>
      _DashboardTrafficReportCardState();
}

class _DashboardTrafficReportCardState
    extends State<DashboardTrafficReportCard> {
  final _controller = DashboardTrafficReportCardController();
  @override
  void initState() {
    _controller.load();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          ListTile(
            key: ValueKey("testtesttest"),
            title: widget.title,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {}, icon: Icon(MdiIcons.chartBarStacked)),
                IconButton(
                    onPressed: _controller.requestFullScreenMode,
                    icon: Icon(MdiIcons.fullscreen)),
                PopupMenuButton(
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text("Download PNG"),
                      value: "PNG",
                    ),
                    PopupMenuItem(
                      child: Text("Download CSV"),
                      value: "CSV",
                    ),
                    PopupMenuItem(
                      child: Text("Add to Custom Dashboard"),
                      value: "add",
                    ),
                    PopupMenuItem(
                      child: Text("View in Metrics Explorer"),
                      value: "view",
                    ),
                    PopupMenuItem(
                      child: Text("Reload"),
                      value: "reload",
                      onTap: _controller.load,
                    ),
                    if (_controller.isFullScreen)
                      PopupMenuItem(
                        child: Text("Exit FullScreen"),
                        value: "exit",
                        onTap: _controller.exitFullScreenMode,
                      ),
                  ],
                  child: Icon(MdiIcons.dotsVertical),
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, c) => SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                /// title: ChartTitle(
                ///     text: widget.title, alignment: ChartAlignment.near),

                // Enable legend
                legend: Legend(isVisible: false),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),

                series: <ChartSeries<_SalesData, String>>[
                  LineSeries<_SalesData, String>(
                    dataSource: _controller.data,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'number',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// model
class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

/// controller
class DashboardTrafficReportCardController extends ChangeNotifier {
  late List<_SalesData> data;
  late bool isFullScreen;

  DashboardTrafficReportCardController() {
    data = [];
    isFullScreen = false;
  }

  load() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    generateMock();
  }

  generateMock() {
    DateTime.january;
    data = [
      _SalesData(DateTime.january.toString(), Random().nextDouble()),
      _SalesData(DateTime.february.toString(), Random().nextDouble()),
      _SalesData(DateTime.march.toString(), Random().nextDouble()),
      _SalesData(DateTime.april.toString(), Random().nextDouble()),
      _SalesData(DateTime.may.toString(), Random().nextDouble()),
      _SalesData(DateTime.june.toString(), Random().nextDouble()),
      _SalesData(DateTime.july.toString(), Random().nextDouble()),
      _SalesData(DateTime.august.toString(), Random().nextDouble()),
      _SalesData(DateTime.october.toString(), Random().nextDouble()),
      _SalesData(DateTime.november.toString(), Random().nextDouble()),
      _SalesData(DateTime.september.toString(), Random().nextDouble()),
      _SalesData(DateTime.december.toString(), Random().nextDouble()),
    ];
    notifyListeners();
  }

  requestFullScreenMode() {
    FullScreenService().requestFullScreen();
    isFullScreen = true;
    notifyListeners();
  }

  exitFullScreenMode() {
    FullScreenService().exitFullScreen();
    isFullScreen = false;
    notifyListeners();
  }
}
