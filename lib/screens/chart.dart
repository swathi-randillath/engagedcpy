import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/EmployeeReport.dart';
import '../services/api.dart';


class MyChartPage extends StatefulWidget {
  const MyChartPage({Key? key}) : super(key: key);

  @override
  MyChartPageState createState() => MyChartPageState();
}

class MyChartPageState extends State<MyChartPage> {
  List<EmployeeReport> _data = [];

  final List<ChartData> chartData = [];

  @override
  void initState() {
    super.initState();
    getMapData();
  }

  void getMapData() async {
    try {
      ApiService _apiService = ApiService();
      var result = await _apiService.getReport();
      debugPrint("Size:: ${result.length}");
      setState(() {
        _data = result;
        setState(() {
          chartData.add(ChartData(1, _data.first.actualValue ?? 0.0, _data.first.targetValue ?? 0.0, ));
        });
      });
    } on Exception catch (exception) {
      // only executed if error is of type Exception
    } catch (error) {
      // executed for errors of all types other than Ex

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFBF9F7),

        body: SfCartesianChart(
            primaryXAxis: NumericAxis(maximum: 4,),
            primaryYAxis: NumericAxis(),
            series: <ChartSeries<ChartData, double>>[
              ColumnSeries<ChartData, double>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,

                  yValueMapper: (ChartData data, _) => data.y,
                  color: const Color(0xff8697AC)
              ),

              ColumnSeries<ChartData, double>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y1,
                  color: const Color(0xff37B257)

              ),
            ]
        )
    );
  }
}

class ChartData{
  ChartData(this.x, this.y, this.y1,);
  final double x;
  final double y;
  final double y1;

}