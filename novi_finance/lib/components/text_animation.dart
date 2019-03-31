import 'package:flutter/material.dart';

class TextWithAnimation extends StatefulWidget {
  const TextWithAnimation(
      {Key key,
      @required this.value,
      @required this.duration,
      this.textStyle,
      this.reanimateNotifier,
      this.textScaleFactor})
      : super(key: key);
  final double value, textScaleFactor;
  final int duration;
  final TextStyle textStyle;
  final ValueNotifier<bool> reanimateNotifier;
  @override
  _TextWithAnimationState createState() => _TextWithAnimationState();
}

class _TextWithAnimationState extends State<TextWithAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.reanimateNotifier != null) {
      widget.reanimateNotifier.addListener(() {
        _controller.reset();
        _controller.forward();
      });
    }
    _controller = new AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: new Duration(milliseconds: widget.duration),
        vsync: this)
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FittedBox(
            fit: BoxFit.contain,
            child: Text(
              '\$ ${(widget.value * _controller.value).toStringAsFixed(2)}',
              textScaleFactor: widget.textScaleFactor ?? 1.9,
              style: widget.textStyle ??
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          );
        },
        child: Container());
  }
}
