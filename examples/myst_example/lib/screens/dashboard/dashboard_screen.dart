import 'package:data_table_2/data_table_2.dart';
import 'package:myst_example/core.dart';
import 'widgets/dashboard_screen_sidebar.dart';
import 'widgets/dashboard_select_time_frame_option.dart';
import 'widgets/dashboard_traffic_report_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardScreenController(),
      child: AdaptivePlatformWidget(
        child: DashboardLayout(
          child: DashboardScreenBody(),
        ),
      ),
    );
  }
}

class DashboardScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: builder,
      xsBuilder: xsBuilder,
      smBuilder: xsBuilder,
    );
  }

  Widget xsBuilder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DasbhoardScreenSideBar(),
        DashboardScreenBodyHeader(),
        Divider(),
        Expanded(
          child: SingleChildScrollView(
            primary: false,
            child: DashboardScreenReports(),
          ),
        )
      ],
    );
  }

  Widget builder(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DasbhoardScreenSideBar(),
        VerticalDivider(width: 1),
        Expanded(
          child: Material(
            type: MaterialType.card,
            child: Column(
              children: [
                DashboardScreenBodyHeader(),
                Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    primary: false,
                    child: Padding(
                        padding: EdgeInsets.all(24),
                        child: DashboardScreenReports()),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class DashboardScreenBodyHeader extends StatelessWidget {
  const DashboardScreenBodyHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      child: ListTile(
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text("API & Servives"),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text("Enable APIS and Service".toUpperCase())),
            )
          ],
        ),
      ),
    );
  }
}

class DashboardScreenReports extends StatelessWidget {
  const DashboardScreenReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DashboardSelectTimeFrameOption(),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: context.isXSS ? 1 : 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: context.select<DashboardScreenController, bool>(
                  (ctrl) => ctrl.isMiniMenu)
              ? 1.75
              : 1.5,
          children: [
            DashboardTrafficReportCard(title: Text('Traffic')),
            DashboardTrafficReportCard(title: Text('Error')),
            DashboardTrafficReportCard(title: Text('Median latency'))
          ],
        ),
        DashboardFilterProductTable(),
      ],
    );
  }
}

class DashboardFilterProductTable extends StatelessWidget {
  const DashboardFilterProductTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: DataTable2(
        rows: [
          ...List.generate(
              50,
              (i) => DataRow2(
                    cells: [
                      DataCell(Text("BigQuery API")),
                      DataCell(SizedBox()),
                      DataCell(SizedBox()),
                      DataCell(SizedBox()),
                      DataCell(SizedBox()),
                    ],
                  )).toList()
        ],
        columns: [
          DataColumn2(label: Text("name"), tooltip: "name"),
          DataColumn2(label: Text("request"), tooltip: "request"),
          DataColumn2(label: Text("error"), tooltip: "error"),
          DataColumn2(label: Text("latency ms"), tooltip: "latency ms"),
          DataColumn2(label: Text("latency 59%"), tooltip: "latency 59%"),
        ],
      ),
    );
  }
}
