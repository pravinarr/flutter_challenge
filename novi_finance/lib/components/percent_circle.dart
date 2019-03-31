import 'package:flutter/material.dart';

class BubbleFiller extends StatelessWidget {
  final double percent;
  final Color textColor;
  final Gradient gradient;
  const BubbleFiller({Key key, this.percent, this.gradient, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomPaint(
          painter: DrawCircle(color: Colors.purple.shade50, radiusStep: 30),
          child: Container(),
        ),
        CustomPaint(
          painter: DrawPercentFiller(
              color: Colors.pink,
              radiusStep: 30,
              percent: this.percent,
              gradient: this.gradient),
          child: Container(),
        ),
        Center(
          child: Container(
            child: FittedBox(
              fit: BoxFit.cover,
              child: Text(
                '${this.percent.toStringAsFixed(1)}%',
                style: TextStyle(
                    color: this.textColor, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class DrawCircle extends CustomPainter {
  Color color;
  double radiusStep;
  DrawCircle({this.color, this.radiusStep});

  @override
  void paint(Canvas canvas, Size size) {
    var firstControlPoint = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(
        firstControlPoint, size.height / 3, Paint()..color = this.color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DrawPercentFiller extends CustomPainter {
  Color color;
  double radiusStep;
  double percent;
  Gradient gradient;
  DrawPercentFiller({this.color, this.radiusStep, this.percent, this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    var centerOffset = Offset(size.width / 2, size.height / 2);
    Rect rect = new Rect.fromCircle(
      center: centerOffset,
      radius: size.height / 3,
    );
    double startHeight = (1 - (this.percent / 100)) * size.height;
    var path = Path();
    path.lineTo(0, startHeight);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, startHeight);
    var firstControlPoint =
        Offset((size.width / 4) * 3, startHeight - (size.height / 10));
    var firstEndPoint = Offset((size.width / 4) * 2, startHeight);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset((size.width / 4) * 1, startHeight + (size.height / 10));
    var secondEndPoint = Offset(0, startHeight);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    canvas.clipPath(path);
    canvas.drawCircle(centerOffset, size.height / 3,
        Paint()..shader = gradient.createShader(rect));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
