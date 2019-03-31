import 'package:flutter/material.dart';
import 'package:novi_finance/components/legend.dart';
import 'package:novi_finance/components/progress_animation.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(
      {Key key,
      this.amount,
      this.icon,
      this.gradient,
      this.percentage,
      this.index,
      this.reAnimateNotifier})
      : super(key: key);
  final Gradient gradient;
  final IconData icon;
  final double amount;
  final double percentage;
  final int index;
  final ValueNotifier reAnimateNotifier;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, layout) {
      return Container(
        width: layout.maxWidth,
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: LayoutBuilder(
                builder: (context, layout) {
                  return new AnimatedLegendIcon(
                    gradient: gradient,
                    icon: icon,
                    layout: layout,
                    reAnimate: reAnimateNotifier,
                  );
                },
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                width: layout.maxWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: ProgressBarWithAnimation(
                        reAnimate: reAnimateNotifier,
                        tag: 'expense$index',
                        horzontalMargin: 0,
                        percent: percentage,
                        gradient: gradient,
                        durationSeconds: 2,
                        verticalHeight: 15,
                        textScaleFactor: 0,
                      ),
                    ),
                    Text(
                      '\$ ${amount.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.black54),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class AnimatedLegendIcon extends StatefulWidget {
  const AnimatedLegendIcon(
      {Key key,
      @required this.gradient,
      @required this.icon,
      @required this.layout,
      this.reAnimate})
      : super(key: key);

  final Gradient gradient;
  final IconData icon;
  final BoxConstraints layout;
  final ValueNotifier<bool> reAnimate;

  @override
  _AnimatedLegendIconState createState() => _AnimatedLegendIconState();
}

class _AnimatedLegendIconState extends State<AnimatedLegendIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animate;

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
    _controller =
        AnimationController(duration: Duration(milliseconds: 1500), vsync: this)
          ..forward();
    animate =
        new CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animate,
      child: LegendIcon(
        gradient: widget.gradient,
        radius: widget.layout.maxWidth / 5,
        icon: Icon(
          widget.icon,
          size: widget.layout.maxWidth / 5,
          color: Colors.white,
        ),
      ),
    );
  }
}
