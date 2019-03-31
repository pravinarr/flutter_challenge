import 'package:flutter/material.dart';
import 'package:novi_finance/components/expense_chart.dart';
import 'package:novi_finance/components/legend.dart';
import 'package:novi_finance/data.dart';

class SpendingChart extends StatelessWidget {
  const SpendingChart({
    Key key,
    this.exitNotifier
  }) : super(key: key);
  final ValueNotifier exitNotifier;


  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: LayoutBuilder(
            builder: (context, layout) {
              return ExpenseChart(
                  data: Data.getExpenseData(),
                  radius: layout.maxWidth / 3,
                  strokeWidth: 23,
                  exitNotifier: exitNotifier,
                  durationMilliSeconds: 1000);
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: Data.getExpenseData()
                    .map((item) => Legend(
                          gradient: item.gradient,
                          label: item.label,
                        ))
                    .toList()
                    .reversed
                    .toList()),
          ),
        )
      ],
    );
  }
}
