import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:novi_finance/data.dart';

class BarChart extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  final List<DailyData> data;

  BarChart({this.animate, this.data, this.seriesList});

  @override
  _BarChartState createState() => _BarChartState();

  static List<charts.Series<DailyData, String>> createChartData(
      List<DailyData> data) {
    const col = charts.Color(r: 255, g: 255, b: 255, a: 80);
    return [
       charts.Series<DailyData, String>(
        id: 'chart',
        colorFn: (_, index) {
          return charts.MaterialPalette.yellow.shadeDefault;
        },
        domainFn: (DailyData data, _) => data.label,
        measureFn: (DailyData data, _) => data.value,
        data: data,
        areaColorFn: (_, __) => col,
        labelAccessorFn: (DailyData data, _) => '\$${data.value}',
      )
    ];
  }
}

class _BarChartState extends State<BarChart> {
  void initState() {
    super.initState();
  }

  get staticTicks => widget.data
      .map((item) => charts.TickSpec(item.index, label: item.label))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        charts.BarChart(
          widget.seriesList,
          animate: true,
          //barRendererDecorator: new charts.BarLabelDecorator<String>(),
        ),
      ],
    );
  }
}
