import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:novi_finance/data.dart';

class LineChart extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  final List<ChartData> data;

  LineChart({this.animate, this.data, this.seriesList});

  @override
  _LineChartState createState() => _LineChartState();

  static List<charts.Series<ChartData, int>> createChartData(
      List<ChartData> data) {
    const col = charts.Color(r: 255, g: 255, b: 255, a: 80);
    return [
      new charts.Series<ChartData, int>(
        id: 'chart',
        colorFn: (_, index) {
          if (index >= data.length / 2) {
            return charts.MaterialPalette.deepOrange.shadeDefault;
          }
          return charts.MaterialPalette.purple.shadeDefault;
        },
        domainFn: (ChartData data, _) => data.index,
        measureFn: (ChartData data, _) => data.value,
        data: data,
        areaColorFn: (_, __) => col,
        labelAccessorFn: (ChartData data, _) => '\$${data.value}',
      )
    ];
  }
}

class _LineChartState extends State<LineChart> {
  ValueNotifier<double> selectedvalue;

  void initState() {
    super.initState();
    selectedvalue = ValueNotifier(null);
  }

  @override
  void dispose() {
    selectedvalue.dispose();
    super.dispose();
  }

  get staticTicks => widget.data
      .map((item) => charts.TickSpec(item.index, label: item.label))
      .toList();

  void _infoSelectionModelUpdated(charts.SelectionModel<num> model) {
    if (model.selectedDatum.length > 0) {
      selectedvalue.value = ((model.selectedDatum[0].datum) as ChartData).value;
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedvalue.value = null;
    return Stack(
      children: <Widget>[
        charts.LineChart(
          this.widget.seriesList,
          animate: true,
          selectionModels: [
            charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
                updatedListener: _infoSelectionModelUpdated)
          ],
          animationDuration: Duration(milliseconds: 500),
          defaultInteractions: true,
          domainAxis: charts.NumericAxisSpec(
            showAxisLine: false,
            tickProviderSpec: charts.StaticNumericTickProviderSpec(staticTicks),
            renderSpec: charts.GridlineRendererSpec(
                labelStyle: new charts.TextStyleSpec(
                  color: charts.MaterialPalette.black.lighter,
                ),
                lineStyle: charts.LineStyleSpec(
                    thickness: 0,
                    color: charts.MaterialPalette.purple.makeShades(100)[0])),
          ),
          primaryMeasureAxis: charts.NumericAxisSpec(
            showAxisLine: false,
            renderSpec: charts.SmallTickRendererSpec(
                labelStyle: new charts.TextStyleSpec(
                  fontSize: 0,
                ),
                lineStyle: charts.LineStyleSpec(thickness: 0)),
          ),
          secondaryMeasureAxis: charts.NumericAxisSpec(showAxisLine: false),
          defaultRenderer: charts.LineRendererConfig(
            smoothLine: true,
            strokeWidthPx: 5,
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: CharSelectedLabel(selectedvalue: selectedvalue),
        )
      ],
    );
  }
}

class CharSelectedLabel extends StatefulWidget {
  const CharSelectedLabel({
    Key key,
    @required this.selectedvalue,
  }) : super(key: key);

  final ValueNotifier<double> selectedvalue;

  @override
  _CharSelectedLabelState createState() => _CharSelectedLabelState();
}

class _CharSelectedLabelState extends State<CharSelectedLabel> {
  double value;

  void initState() {
    super.initState();
    widget.selectedvalue.addListener(() {
      setState(() {
        value = widget.selectedvalue.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return value == null
        ? Container()
        : Container(
           padding: EdgeInsets.all(3.0),
           margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Text(
              '\$${value}',
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            ),
          );
  }
}
