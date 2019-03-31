import 'package:flutter/material.dart';
import 'package:novi_finance/components/expense_item.dart';
import 'package:novi_finance/components/spending_chart.dart';
import 'package:novi_finance/data.dart';

class ExpenseCard extends StatefulWidget {
  const ExpenseCard({Key key, this.notifier}) : super(key: key);
  final ValueNotifier<bool> notifier;

  @override
  _ExpenseCardState createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  bool visible = false;

  @override
  void initState() {
    super.initState();
    widget.notifier.addListener(() {
      setState(() {
        visible = widget.notifier.value;
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: visible ? 1.0 : 0.0,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _getListItems(),
            ),
          ),
        ),
        AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: visible ? 0.0 : 1.0,
          child: SpendingChart(
            exitNotifier: widget.notifier,
          ),
        ),
      ],
    );
  }

  List<Widget> _getListItems() {
    List<Widget> list = [];
    for (int i = 0; i < Data.getExpenseData().length; i++) {
      list.add(ExpenseItem(
        reAnimateNotifier: widget.notifier,
        amount: Data.getExpenseData()[i].amount,
        percentage: Data.getExpenseData()[i].value,
        gradient: Data.getExpenseData()[i].gradient,
        icon: Data.getExpenseData()[i].icon,
        index: i,
      ));
    }
    return list;
  }
}
