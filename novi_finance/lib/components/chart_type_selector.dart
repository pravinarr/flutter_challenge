import 'package:flutter/material.dart';

class ChartDataTypeSelector extends StatefulWidget {
  const ChartDataTypeSelector({Key key, this.typeNotifier}) : super(key: key);
  final ValueNotifier<String> typeNotifier;

  @override
  _ChartDataTypeSelectorState createState() => _ChartDataTypeSelectorState();
}

class _ChartDataTypeSelectorState extends State<ChartDataTypeSelector> {
  Map<int, double> mapPositions = {1: -1.0, 2: -0.35, 3: 0.35, 4: 1};
  int currentPosition = 0;

  int getPosition(String type) {
    if (widget.typeNotifier.value == 'WEEKLY') {
      return 2;
    }
    if (widget.typeNotifier.value == 'MONTHLY') {
      return 3;
    }
    if (widget.typeNotifier.value == 'YEARLY') {
      return 4;
    }
    return 1;
  }

  @override
  void initState() {
    super.initState();
    currentPosition = getPosition(widget.typeNotifier.value);
    widget.typeNotifier.addListener(() {
      setState(() {
        currentPosition = getPosition(widget.typeNotifier.value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, layout) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: layout.maxWidth / 25),
                child: AnimatedAlign(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  alignment:
                      AlignmentDirectional(mapPositions[currentPosition], 0),
                  child: Container(
                    width: layout.maxWidth / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
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
                    child: Container(),
                  ),
                ),
              );
            },
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    widget.typeNotifier.value = 'DAILY';
                  },
                  child: Text(
                    'Daily',
                    style: TextStyle(
                        color: currentPosition == 1
                            ? Colors.white
                            : Colors.black54),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    widget.typeNotifier.value = 'WEEKLY';
                  },
                  child: Text(
                    'Weekly',
                    style: TextStyle(
                        color: currentPosition == 2
                            ? Colors.white
                            : Colors.black54),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    widget.typeNotifier.value = 'MONTHLY';
                  },
                  child: Text(
                    'Monthly',
                    style: TextStyle(
                        color: currentPosition == 3
                            ? Colors.white
                            : Colors.black54),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    widget.typeNotifier.value = 'YEARLY';
                  },
                  child: Text(
                    'Yearly',
                    style: TextStyle(
                        color: currentPosition == 4
                            ? Colors.white
                            : Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
