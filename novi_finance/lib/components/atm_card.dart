import 'package:flutter/material.dart';

class ATMCard extends StatelessWidget {
  final String cardNumber, cardHolderName, expiry;
  final Color startColor, endColor;
  ATMCard(
      {this.cardNumber,
      this.cardHolderName,
      this.expiry,
      this.startColor,
      this.endColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: [
      CardBack(
        startColor: this.startColor,
        endColor: this.endColor,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Flexible(
            flex: 1,
            child: LayoutBuilder(
              builder: (context, layout) {
                return Container(
                  padding: EdgeInsets.only(left: (layout.maxWidth / 19) * 1.1),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      cardNumber,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      textScaleFactor: 1.5,
                    ),
                  ),
                );
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: LayoutBuilder(
              builder: (context, layout) {
                return Container(
                  padding: EdgeInsets.only(left: (layout.maxWidth / 19) * 1.1),
                  child: Flex(
                    direction: Axis.horizontal,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width:
                            (layout.maxWidth - (layout.maxWidth / 19) * 1.1) /
                                2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Card Holder',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              cardHolderName,
                              textScaleFactor: 1.4,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width:
                            (layout.maxWidth - (layout.maxWidth / 19) * 1.1) /
                                2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Exp Date',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              expiry,
                              textScaleFactor: 1.4,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      )
    ]));
  }
}

class CardBack extends StatelessWidget {
  final Color startColor, endColor;
  const CardBack({Key key, this.startColor, this.endColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                stops: [0.3, 0.9],
                end: Alignment
                    .bottomRight, // 10% of the width, so there are ten blinds.
                colors: [startColor, endColor],
              ),
            ),
          ),
          CustomPaint(
            painter: CirclePainter(
              mid: CurveStep(11, -2),
              radiusStep: 5,
              color: const Color.fromRGBO(255, 255, 255, 0.2),
            ),
            child: Container(),
          ),
          CustomPaint(
            painter: CirclePainter(
              mid: CurveStep(11, -2),
              radiusStep: 3,
              color: const Color.fromRGBO(255, 255, 255, 0.2),
            ),
            child: Container(),
          ),
          CustomPaint(
            painter: LeftCurve(
              firstControlStep: CurveStep(2.5, 8),
              firstEndStep: CurveStep(3.5, 6),
              secondControlStep: CurveStep(4.5, 2.5),
              secondEndStep: CurveStep(4, 0),
              color: const Color.fromRGBO(255, 255, 255, 0.1),
            ),
            child: Container(),
          ),
          CustomPaint(
            painter: LastCurve(
                firstControlStep: CurveStep(0.1, 8),
                firstEndStep: CurveStep(0.8, 6),
                secondControlStep: CurveStep(2.5, 2.5),
                secondEndStep: CurveStep(2, 0),
                color: const Color.fromRGBO(255, 255, 255, 0.1),
                leftEnd: 9.3),
            child: Container(),
          ),
          CustomPaint(
            painter: CurvePainter(
              firstControlStep: CurveStep(16.2, 3.5),
              firstEndStep: CurveStep(12, 4.8),
              secondControlStep: CurveStep(7.9, 5.5),
              secondEndStep: CurveStep(6.2, 8.3),
              thirdControlStep: CurveStep(5.5, 11),
              thirdEndStep: CurveStep(7.5, 12),
              startStep: CurveStep(17.5, 0),
              color: const Color.fromRGBO(255, 255, 255, 0.1),
            ),
            child: Container(),
          ),
          CustomPaint(
            painter: CurvePainter(
              firstControlStep: CurveStep(17.2, 5.5),
              firstEndStep: CurveStep(12.5, 6),
              secondControlStep: CurveStep(7.8, 7.3),
              secondEndStep: CurveStep(8.2, 9.4),
              thirdControlStep: CurveStep(8, 11),
              thirdEndStep: CurveStep(10.5, 12),
              startStep: CurveStep(19, 1),
              color: const Color.fromRGBO(255, 255, 255, 0.1),
            ),
            child: Container(),
          ),
          CustomPaint(
            painter: CurvePainter(
              firstControlStep: CurveStep(17.9, 7),
              firstEndStep: CurveStep(16.2, 7.5),
              secondControlStep: CurveStep(14, 8.1),
              secondEndStep: CurveStep(14.2, 9.3),
              thirdControlStep: CurveStep(14, 11),
              thirdEndStep: CurveStep(18, 12),
              startStep: CurveStep(19, 6),
              color: const Color.fromRGBO(255, 255, 255, 0.1),
            ),
            child: Container(),
          ),
          CustomPaint(
            painter: MasterCardLogoPainter(
              radiusStep: 1.1,
              mid: CurveStep(2.2, 2.2),
              color: const Color.fromRGBO(255, 255, 255, 1.0),
            ),
            child: Container(),
          )
        ],
      ),
    );
  }
}

class CurveStep {
  double stepX, stepY;
  CurveStep(this.stepX, this.stepY);
}

class CurvePainter extends CustomPainter {
  CurveStep firstControlStep, firstEndStep;
  CurveStep secondControlStep, secondEndStep;
  CurveStep thirdControlStep, thirdEndStep;
  CurveStep startStep;
  Color color;

  CurvePainter(
      {this.firstControlStep,
      this.firstEndStep,
      this.secondControlStep,
      this.secondEndStep,
      this.thirdControlStep,
      this.thirdEndStep,
      this.startStep,
      this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.lineTo((size.width / 19) * this.thirdEndStep.stepX, size.height);
    path.lineTo(size.width, size.height);
    if (this.startStep.stepY == 0) {
      path.lineTo(size.width, 0);
    }
    path.lineTo((size.width / 19) * this.startStep.stepX,
        (size.height / 12) * this.startStep.stepY);
    var firstControlPoint = Offset(
        (size.width / 19) * this.firstControlStep.stepX,
        (size.height / 12) * this.firstControlStep.stepY);
    var firstEndPoint = Offset((size.width / 19) * this.firstEndStep.stepX,
        (size.height / 12) * this.firstEndStep.stepY);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(
        (size.width / 19) * this.secondControlStep.stepX,
        (size.height / 12) * this.secondControlStep.stepY);
    var secondEndPoint = Offset((size.width / 19) * this.secondEndStep.stepX,
        (size.height / 12) * this.secondEndStep.stepY);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = Offset(
        (size.width / 19) * this.thirdControlStep.stepX,
        (size.height / 12) * this.thirdControlStep.stepY);
    var thirdEndPoint = Offset((size.width / 19) * this.thirdEndStep.stepX,
        (size.height / 12) * this.thirdEndStep.stepY);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    canvas.clipPath(path);
    canvas.drawRRect(
      RRect.fromLTRBR(0.0, 0.0, size.width, size.height, Radius.circular(10.0)),
      new Paint()..color = this.color,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MasterCardLogoPainter extends CustomPainter {
  Color color;
  double radiusStep;
  CurveStep mid;
  MasterCardLogoPainter({this.color, this.mid, this.radiusStep});

  @override
  void paint(Canvas canvas, Size size) {
    var firstControlPoint = Offset((size.width / 19) * this.mid.stepX,
        (size.height / 12) * this.mid.stepY);
    var secondControlPoint = Offset((size.width / 19) * (this.mid.stepX + 1.5),
        (size.height / 12) * this.mid.stepY);
    canvas.drawCircle(firstControlPoint, (size.width / 19) * radiusStep,
        Paint()..color = this.color);
    canvas.drawCircle(
        secondControlPoint,
        ((size.width / 19) * radiusStep -
            ((size.width / 19) * radiusStep) / 8.5),
        Paint()
          ..color = this.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = ((size.width / 19) * radiusStep) / 4);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CirclePainter extends CustomPainter {
  Color color;
  double radiusStep;
  CurveStep mid;
  CirclePainter({this.color, this.mid, this.radiusStep});

  @override
  void paint(Canvas canvas, Size size) {
    var firstControlPoint = Offset((size.width / 19) * this.mid.stepX,
        (size.height / 12) * this.mid.stepY);
    canvas.drawCircle(firstControlPoint, (size.width / 19) * radiusStep,
        Paint()..color = this.color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class LeftCurve extends CustomPainter {
  Color color;
  CurveStep firstControlStep, firstEndStep;
  CurveStep secondControlStep, secondEndStep;
  LeftCurve(
      {this.color,
      this.firstControlStep,
      this.secondEndStep,
      this.secondControlStep,
      this.firstEndStep});

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo((size.width / 19) * this.secondEndStep.stepX, size.height);
    var firstControlPoint = Offset(
        (size.width / 19) * this.firstControlStep.stepX,
        (size.height / 12) * this.firstControlStep.stepY);
    var firstEndPoint = Offset((size.width / 19) * this.firstEndStep.stepX,
        (size.height / 12) * this.firstEndStep.stepY);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(
        (size.width / 19) * this.secondControlStep.stepX,
        (size.height / 12) * this.secondControlStep.stepY);
    var secondEndPoint = Offset((size.width / 19) * this.secondEndStep.stepX,
        (size.height / 12) * this.secondEndStep.stepY);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(0, 0);

    canvas.clipPath(path);
    canvas.drawRRect(
      RRect.fromLTRBR(0.0, 0.0, size.width, size.height, Radius.circular(10.0)),
      new Paint()..color = this.color,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class LastCurve extends CustomPainter {
  Color color;
  CurveStep firstControlStep, firstEndStep;
  CurveStep secondControlStep, secondEndStep;
  double leftEnd;
  LastCurve(
      {this.color,
      this.firstControlStep,
      this.secondEndStep,
      this.secondControlStep,
      this.firstEndStep,
      this.leftEnd});

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, (size.height / 12) * this.leftEnd);
    var firstControlPoint = Offset(
        (size.width / 19) * this.firstControlStep.stepX,
        (size.height / 12) * this.firstControlStep.stepY);
    var firstEndPoint = Offset((size.width / 19) * this.firstEndStep.stepX,
        (size.height / 12) * this.firstEndStep.stepY);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(
        (size.width / 19) * this.secondControlStep.stepX,
        (size.height / 12) * this.secondControlStep.stepY);
    var secondEndPoint = Offset((size.width / 19) * this.secondEndStep.stepX,
        (size.height / 12) * this.secondEndStep.stepY);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(0, 0);

    canvas.clipPath(path);
    canvas.drawRRect(
      RRect.fromLTRBR(0.0, 0.0, size.width, size.height, Radius.circular(10.0)),
      new Paint()..color = this.color,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
