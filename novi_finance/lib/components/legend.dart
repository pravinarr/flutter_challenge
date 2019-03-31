import 'package:flutter/material.dart';

class Legend extends StatelessWidget {
  const Legend({Key key, this.gradient, this.label}) : super(key: key);

  final String label;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: new LegendIcon(
            gradient: gradient,
            radius: 10,
          ),
        ),
        Flexible(
          flex: 4,
          child: Text(
            label,
            style: TextStyle(color: Colors.black54),
          ),
        )
      ],
    );
  }
}

class LegendIcon extends StatelessWidget {
  final Gradient gradient;
  final double radius;
  final Icon icon;
  const LegendIcon({
    Key key,
    this.gradient,
    this.radius,
    this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.yellow,
      child: Stack(
        children: <Widget>[
          CustomPaint(
            painter: DrawCircleIcon(gradient: gradient, radiusStep: radius),
            child: Container(),
          ),
          Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: gradient.colors[0],
                      blurRadius: 20.0
                    ),
                  ]
                ),
                child: Transform.translate(
                  offset: Offset(0, -10),
                  child: icon,
                )??Container(),
              ))
        ],
      ),
    );
  }
}

class DrawCircleIcon extends CustomPainter {
  Gradient gradient;
  double radiusStep;
  DrawCircleIcon({this.gradient, this.radiusStep});

  @override
  void paint(Canvas canvas, Size size) {
    var centerOffset = Offset(size.width / 2, size.height / 2);
    Rect rect = new Rect.fromCircle(
      center: centerOffset,
      radius: radiusStep,
    );
    canvas.drawCircle(
        centerOffset,
        radiusStep,
        Paint()
          ..style = PaintingStyle.fill
          ..shader = gradient.createShader(rect));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
