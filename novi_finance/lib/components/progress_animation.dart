import 'package:flutter/material.dart';

class ProgressBarWithAnimation extends StatefulWidget {
  const ProgressBarWithAnimation(
      {Key key,
      this.gradient,
      this.percent,
      this.durationSeconds,
      this.horzontalMargin,
      this.verticalHeight,
      this.tag,
      this.reAnimate,
      this.textScaleFactor})
      : super(key: key);
  final Gradient gradient;
  final double percent;
  final int durationSeconds;
  final ValueNotifier<bool> reAnimate;
  final double horzontalMargin, verticalHeight, textScaleFactor;
  final String tag;

  @override
  _ProgressBarWithAnimationState createState() =>
      _ProgressBarWithAnimationState();
}

class _ProgressBarWithAnimationState extends State<ProgressBarWithAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.reAnimate != null) {
      widget.reAnimate.addListener(() {
        if (widget.reAnimate.value) {
          _controller.reset();
          _controller.forward();
        }
      });
    }

    _controller = new AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: new Duration(seconds: widget.durationSeconds),
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
    return Stack(
      children: <Widget>[
        Container(
          height:
              widget.verticalHeight ?? MediaQuery.of(context).size.width / 16,
          margin: EdgeInsets.symmetric(
              horizontal: widget.horzontalMargin ??
                  MediaQuery.of(context).size.width / 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[200]),
        ),
        AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                height: widget.verticalHeight ??
                    MediaQuery.of(context).size.width / 16,
                margin: EdgeInsets.symmetric(
                    horizontal: widget.horzontalMargin ??
                        MediaQuery.of(context).size.width / 15),
                child: LayoutBuilder(
                  builder: (context, layout) {
                    double paddingValue =
                        layout.maxWidth * (1 - _controller.value);

                    if (paddingValue <
                        (layout.maxWidth * (1.0 - (widget.percent / 100)))) {
                      _controller.stop();
                    }
                    return widget.tag == null
                        ? Container(
                            margin: EdgeInsets.only(right: paddingValue),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: widget.gradient),
                          )
                        : Hero(
                            tag: widget.tag,
                            child: Container(
                              margin: EdgeInsets.only(right: paddingValue),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  gradient: widget.gradient),
                            ),
                          );
                  },
                ),
              );
            },
            child: Container()),
        Container(
          padding: EdgeInsets.only(right: 10.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              widget.percent.toStringAsFixed(0) + '%',
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.grey),
              textScaleFactor: widget.textScaleFactor ?? 1.0,
            ),
          ),
          height: MediaQuery.of(context).size.width / 16,
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[200].withOpacity(0.0)),
        ),
      ],
    );
  }
}
