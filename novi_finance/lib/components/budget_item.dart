import 'package:flutter/material.dart';
import 'package:drawing_animation/drawing_animation.dart';
import 'dart:math' as math;

import 'package:novi_finance/components/text_animation.dart';

class BudgetitemCard extends StatelessWidget {
  const BudgetitemCard(
      {Key key,
      @required this.savings,
      @required this.months,
      @required this.totalSavings,
      @required this.label,
      this.entryController,
      this.exitController,
      this.gradient})
      : super(key: key);

  final List<double> savings;
  final List<String> months;
  final double totalSavings;
  final String label;
  final Gradient gradient;
  final AnimationController entryController;
  final AnimationController exitController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: exitController,
      builder: (context, child) {
        return Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width * exitController.value, 0),
            child: child);
      },
      child: AnimatedBuilder(
        animation: entryController,
        builder: (context, child) {
          return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(-1.57 + (1.57 * entryController.value)),
              alignment: FractionalOffset.center,
              child: child);
        },
        child: Container(
          // color: Colors.yellow,
          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 250.0,
          child: Stack(
            children: [
              Container(
                // color: Colors.yellow,
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: gradient),
              ),
              Column(
                children: <Widget>[
                  Flexible(
                      flex: 3,
                      child: LayoutBuilder(
                        builder: (context, layout) {
                          return Container(
                            padding: EdgeInsets.only(left: 20.0, top: 10.0),
                            width: layout.maxWidth,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  this.label,
                                  textScaleFactor: 1.3,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextWithAnimation(
                                  value: totalSavings,
                                  duration: 1000,
                                )
                              ],
                            ),
                          );
                        },
                      )),
                  Flexible(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: DrawGraph(
                        graphData: savings,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: months
                          .map((item) => Text(
                                item,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ))
                          .toList(),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawGraph extends StatefulWidget {
  final List<double> graphData;
  const DrawGraph({this.graphData});

  @override
  _DrawGraphState createState() => _DrawGraphState();
}

class _DrawGraphState extends State<DrawGraph> {
  bool run = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.teal,
      child: LayoutBuilder(
        builder: (context, layout) {
          return AnimatedDrawing.paths(
            getGraph(layout),
            paints: [
              Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 5.0
                ..color = Colors.white
            ],
            width: layout.maxWidth,
            run: this.run,
            animationOrder: PathOrders.original,
            duration: new Duration(seconds: 1),
            lineAnimation: LineAnimation.oneByOne,
            animationCurve: Curves.linear,
            onFinish: () => setState(() {
                  this.run = false;
                }),
          );
        },
      ),
    );
  }

  List<Path> getGraph(BoxConstraints layout) {
    double max = widget.graphData.reduce(math.max);
    double stepValue = max / 10;
    List<Path> paths = [];
    int length = 0;
    Path path = Path();
    path.moveTo(-15, layout.maxHeight);
    //path.
    var previousOffSet = Offset(0, 0);
    widget.graphData.forEach((item) {
      var off = Offset(
          (layout.maxWidth / widget.graphData.length) * length,
          (layout.maxHeight - (layout.maxHeight / 10) * (item / stepValue)) +
              5);

      path.quadraticBezierTo(
          off.dx - 15,
          (previousOffSet.dy > off.dy) ? off.dy - 13 : off.dy + 13,
          off.dx,
          off.dy);
      previousOffSet = off;
      length++;
    });
    paths.add(path);
    return paths;
    //path.lineTo(x, y)
  }
}
