import 'package:flutter/material.dart';
import 'package:novi_finance/components/atm_card.dart';
import 'package:novi_finance/components/bar_chart.dart';
import 'package:novi_finance/components/chart_type_selector.dart';
import 'package:novi_finance/components/cover_flow.dart';
import 'package:novi_finance/components/line_chart.dart';
import 'package:novi_finance/data.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:novi_finance/navigation/fade_transition.dart';
import 'package:novi_finance/pages/overview.dart';

class MyCards extends StatefulWidget {
  @override
  _MyCardsState createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> with TickerProviderStateMixin {
  final ValueNotifier<int> cardSelector = ValueNotifier<int>(0);

  AnimationController _controller1;
  AnimationController _controller2;
  AnimationController _controller3;

  Animation<Offset> offset1;
  Animation<Offset> offset2;
  Animation<Offset> offset3;

  @override
  void initState() {
    super.initState();
    _controller1 = new AnimationController(
        duration: new Duration(milliseconds: 400), vsync: this)
      ..forward();
    _controller2 = new AnimationController(
        duration: new Duration(milliseconds: 600), vsync: this)
      ..forward();
    _controller3 = new AnimationController(
        duration: new Duration(milliseconds: 800), vsync: this)
      ..forward();
    offset1 = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0.0, 0.0))
        .animate(_controller1);
    offset2 = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0.0, 0.0))
        .animate(_controller2);
    offset3 = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0.0, 0.0))
        .animate(_controller3);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    cardSelector.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black45,
          ),
          onPressed: () {
            //notifier.value = true;
            Navigator.of(context).pushReplacement(FadeRoute(
              widget: Overview(),
            ));
          },
        ),
        title: Center(
            child: Text(
          'My Cards',
          style: TextStyle(color: Colors.black),
        )),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black45,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Flexible(
              flex: 4,
              child: SlideTransition(
                position: offset1,
                child: CoverFlow(
                  startIndex: 0,
                  currentItemChangedCallback: (pageNumber) {
                    cardSelector.value = pageNumber;
                  },
                  dismissibleItems: false,
                  itemCount: Data.getAtmCardData().length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: ATMCard(
                        cardHolderName:
                            Data.getAtmCardData()[index].cardHolderName,
                        cardNumber: Data.getAtmCardData()[index].cardNumber,
                        endColor: Data.getAtmCardData()[index].endColor,
                        expiry: Data.getAtmCardData()[index].expiry,
                        startColor: Data.getAtmCardData()[index].startColor,
                      ),
                    );
                  },
                ),
              ),
            ),
            Flexible(
              flex: 8,
              child: SlideTransition(
                position: offset2,
                child: Charts(
                  page: cardSelector,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: SlideTransition(
                position: offset3,
                child: Container(
                  //color: Colors.teal,
                  child: Align(
                    alignment: Alignment.center,
                    child: CircularGradientButton(
                      callback: () {},
                      //increaseHeightBy: 10,
                      increaseWidthBy: 10,
                      //increaseHeightBy: 90,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        stops: [0.3, 0.9],
                        end: Alignment
                            .bottomRight, // 10% of the width, so there are ten blinds.
                        colors: [
                          const Color.fromRGBO(235, 4, 255, 1.0),
                          const Color.fromRGBO(140, 9, 255, 1.0)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Charts extends StatefulWidget {
  const Charts({Key key, this.page}) : super(key: key);
  final ValueNotifier<int> page;

  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  ValueNotifier<String> chartType;
  bool repaint = false;

  void initState() {
    super.initState();
    chartType = ValueNotifier('MONTHLY');
    chartType.addListener(() {
      setState(() {
        repaint = !repaint;
      });
    });
    widget.page.addListener(() {
      setState(() {
        repaint = !repaint;
      });
    });
  }

  @override
  void dispose(){
    chartType.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: ChartDataTypeSelector(
              typeNotifier: chartType,
            ),
          ),
          Flexible(
            flex: 9,
            child: Container(
              child: chartType.value == 'DAILY'
                  ? BarChart(
                      animate: true,
                      data: Data.getAtmCardData()[widget.page.value].daily,
                      seriesList: BarChart.createChartData(
                          Data.getAtmCardData()[widget.page.value].daily),
                    )
                  : LineChart(
                      animate: true,
                      data: Data.getAtmCardData()[widget.page.value]
                          .getLineChartDataByType(chartType.value ?? 'MONTHLY'),
                      seriesList: LineChart.createChartData(
                          Data.getAtmCardData()[widget.page.value]
                              .getLineChartDataByType(
                                  chartType.value ?? 'MONTHLY')),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
