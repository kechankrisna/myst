
import 'package:data_table_2/data_table_2.dart';
import 'package:myst_example/core.dart';

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
