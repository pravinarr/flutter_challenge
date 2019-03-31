import 'package:flutter/material.dart';
import 'package:novi_finance/components/text_animation.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class ExpenseChartItem {
  double value;
  Gradient gradient;
  final String label;
  double amount;
  IconData icon;
  ExpenseChartItem(
      {this.value, this.gradient, this.label, this.icon, this.amount});
}

class ExpenseChart extends StatefulWidget {
  const ExpenseChart(
      {Key key,
      this.data,
      this.radius,
      this.strokeWidth,
      this.centerValue,
      this.exitNotifier,
      this.durationMilliSeconds})
      : super(key: key);

  final List<ExpenseChartItem> data;
  final double centerValue, radius, strokeWidth;
  final int durationMilliSeconds;
  final ValueNotifier exitNotifier;

  @override
  _ExpenseChartState createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controllerRotate;
  ValueNotifier<bool> reanimateNotifierForText = ValueNotifier(false);

  AnimationController _controllerLabelText;

  @override
  void initState() {
    super.initState();
    widget.exitNotifier.addListener(() {
      _controllerRotate.reset();
      _controllerLabelText.reset();
      if (widget.exitNotifier.value) {
        _controllerRotate.forward();
      } else {
        _controller.reset();
        _controller.forward();
      }
      reanimateNotifierForText.value = !reanimateNotifierForText.value;
    });

    _controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: Duration(milliseconds: (widget.durationMilliSeconds ~/ 2)),
        vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controllerRotate.forward();
        }
      })
      ..forward();
    _controllerRotate = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: Duration(milliseconds: (widget.durationMilliSeconds ~/ 2)),
        vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controllerLabelText.forward();
        }
      });
    _controllerLabelText = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: Duration(milliseconds: (widget.durationMilliSeconds ~/ 2)),
        vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerRotate.dispose();
    _controllerLabelText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // RotationTransition(
        //   turns: Tween(begin: 0.0, end: 1.0).animate(_controllerRotate),
        //   child: AnimatedBuilder(
        //       animation: _controller,
        //       builder: (context, child) {
        //         return Stack(children: getChartItems(_controller.value));
        //       },
        //       child: Container()),
        // ),
        AnimatedBuilder(
          animation: _controllerRotate,
          builder: (context, child) {
            if (_controllerRotate.status == AnimationStatus.forward) {
              return Transform.rotate(
                child: child,
                angle: math.radians(360 * _controllerRotate.value),
              );
            }
            return child;
          },
          child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(children: getChartItems(_controller.value));
              },
              child: Container()),
        ),
        Center(
          child: AnimatedBuilder(
              animation: _controllerLabelText,
              builder: (context, child) {
                if (_controllerLabelText.status == AnimationStatus.forward ||
                    _controllerLabelText.status == AnimationStatus.completed) {
                  return Container(
                    color: Colors.white.withOpacity(0.0),
                    child: Stack(
                      children: getExpenseLabels(),
                    ),
                  );
                }
                return child;
              },
              child: Container()),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextWithAnimation(
                reanimateNotifier: reanimateNotifierForText,
                duration: widget.durationMilliSeconds,
                value: 6584.2,
                textScaleFactor: 1,
                textStyle: TextStyle(
                    color: const Color.fromRGBO(235, 4, 255, 1.0),
                    fontWeight: FontWeight.w700),
              ),
              Text(
                'TOTAL',
                textScaleFactor: 0.8,
              )
            ],
          ),
        )
      ],
    );
  }

  List<Widget> getChartItems(double currentAnimationValue) {
    List<Widget> chartItems = [];
    chartItems.add(CustomPaint(
      painter: BaseCircle(
          color: Colors.grey[300],
          radiusStep: widget.radius,
          strokeWidth: widget.strokeWidth),
      child: Container(),
    ));
    int length = 0;
    widget.data.forEach((item) {
      Widget chartItem = Hero(
        tag: 'expense$length',
        child: CustomPaint(
          painter: CirclePainter(
            color: Colors.red,
            radiusStep: widget.radius,
            strokeWidth: widget.strokeWidth,
            percentToDraw: ((widget.data
                    .skip(length)
                    .map((item) => item.value)
                    .toList()
                    .reduce((a, b) => a + b)) *
                _controller.value),
            gradient: item.gradient,
          ),
          child: Container(),
        ),
      );
      length++;
      chartItems.add(chartItem);
    });
    return chartItems;
  }

  List<CustomPaint> getExpenseLabels() {
    List<CustomPaint> list = [];
    double remainingValue = 100 -
        widget.data.map((item) => item.value).toList().reduce((a, b) => a + b);

    int length = 0;
    widget.data.forEach((item) {
      var label = TextPainter(
          text: TextSpan(
            text:
                '${(item.value * _controllerLabelText.value).toStringAsFixed(0)}%',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          textDirection: Directionality.of(context),
          textScaleFactor: 0.8);

      label.layout();
      var newItem = CustomPaint(
        painter: LablePainter(
            radiusStep: widget.radius,
            strokeWidth: widget.strokeWidth,
            textPainter: label,
            activePercent: item.value,
            totalPercent: (widget.data
                .skip(length)
                .map((item) => item.value)
                .toList()
                .reduce((a, b) => a + b))),
        child: Container(),
      );
      length++;
      list.add(newItem);
    });

    if (remainingValue > 0) {
      var label = TextPainter(
          text: TextSpan(
            text:
                '${(remainingValue * _controllerLabelText.value).toStringAsFixed(0)}%',
            style: TextStyle(color: Colors.black),
          ),
          textDirection: Directionality.of(context),
          textScaleFactor: 0.8);
      label.layout();
      var newItem = CustomPaint(
        painter: LablePainter(
            radiusStep: widget.radius,
            strokeWidth: widget.strokeWidth,
            textPainter: label,
            activePercent: remainingValue,
            totalPercent: 100),
        child: Container(),
      );
      list.add(newItem);
    }

    return list;
  }
}

class CirclePainter extends CustomPainter {
  Color color;
  double radiusStep;
  double strokeWidth;
  double percentToDraw;
  Gradient gradient;
  TextPainter labelPainter;
  CirclePainter(
      {this.color,
      this.radiusStep,
      this.strokeWidth,
      this.percentToDraw,
      this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    var centerOffset = Offset(size.width / 2, size.height / 2);
    Rect rect = new Rect.fromCircle(
      center: centerOffset,
      radius: size.height / 5,
    );

    var firstControlPoint = Offset(size.width / 2, size.height / 2);

    canvas.drawArc(
        Rect.fromCircle(center: firstControlPoint, radius: radiusStep),
        math.radians(-90.0),
        math.radians(3.6 * percentToDraw),
        false,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..shader = gradient.createShader(rect)
          ..strokeCap = StrokeCap.round);
    if (labelPainter != null) {
      //  _paintLabel(canvas, size, labelPainter);
    }
  }

  void _paintLabel(Canvas canvas, Size size, TextPainter labelPainter) {
    if (labelPainter != null) {
      labelPainter.paint(
        canvas,
        new Offset(
          size.width / 2 - labelPainter.width / 2,
          size.height / 2 - labelPainter.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LablePainter extends CustomPainter {
  Color color;
  double radiusStep;
  double strokeWidth;
  double totalPercent;
  double activePercent;
  TextPainter textPainter;

  LablePainter(
      {this.color,
      this.radiusStep,
      this.strokeWidth,
      this.textPainter,
      this.totalPercent,
      this.activePercent});
  @override
  void paint(Canvas canvas, Size size) {
    _paintLabel(canvas, size, textPainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double getLabelPrintingPostion() {
    return 3.6 * (totalPercent - (activePercent / 2));
  }

  double getLabelAdjustment() {
    var testValue = (totalPercent - (activePercent / 2));
    if (testValue < 20) {
      return radiusStep / 30;
    }
    if (testValue < 50) {
      return -radiusStep / 5;
    }
    if (testValue > 60) {
      return radiusStep / 10;
    }
    return 0;
  }

  void _paintLabel(Canvas canvas, Size size, TextPainter labelPainter) {
    canvas.translate(size.width / 2, size.height / 2);
    var nextOffset = Offset.fromDirection(
        math.radians(getLabelPrintingPostion() - 90),
        radiusStep + getLabelAdjustment());
    if (labelPainter != null) {
      labelPainter.paint(canvas, nextOffset);
    }
  }
}

class BaseCircle extends CustomPainter {
  Color color;
  double radiusStep;
  double strokeWidth;
  BaseCircle({this.color, this.radiusStep, this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    var firstControlPoint = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(
        firstControlPoint,
        radiusStep,
        Paint()
          ..color = this.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
