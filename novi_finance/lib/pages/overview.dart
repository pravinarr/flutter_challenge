import 'package:flutter/material.dart';
import 'package:novi_finance/components/expense_card.dart';
import 'package:novi_finance/components/percent_circle.dart';
import 'package:novi_finance/components/progress_animation.dart';
import 'package:novi_finance/data.dart';
import 'package:novi_finance/navigation/fade_transition.dart';
import 'package:novi_finance/pages/budget.dart';

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> notifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black45,
          ),
          onPressed: () {
            // notifier.value = true;
          },
        ),
        title: Center(
            child: Text(
          'Overview',
          style: TextStyle(color: Colors.black),
        )),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black45,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: new OverviewBody(
        notifier: notifier,
        startYoffset: MediaQuery.of(context).size.height,
      ),
    );
  }
}

class OverviewBody extends StatefulWidget {
  const OverviewBody({Key key, @required this.notifier, this.startYoffset})
      : super(key: key);

  final ValueNotifier<bool> notifier;
  final double startYoffset;

  @override
  _OverviewBodyState createState() => _OverviewBodyState();
}

class _OverviewBodyState extends State<OverviewBody>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> offset1;
  Animation<Offset> offset2;
  Animation<Offset> offset3;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this)
      ..forward();
    offset1 = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
        .animate(_controller);
    offset2 = Tween<Offset>(begin: Offset(0.0, 4.0), end: Offset(0.0, 0.0))
        .animate(_controller);
    offset3 = Tween<Offset>(begin: Offset(0.0, 3.0), end: Offset(0.0, 0.0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 25.0),
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Accounts',
                          textScaleFactor: 1.2,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'View All',
                          textScaleFactor: 0.9,
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: new AccountCards(),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: SlideTransition(
              position: offset1,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Spendings',
                              textScaleFactor: 1.2,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.notifier.value = !widget.notifier.value;
                              },
                              child: Text(
                                'View All',
                                textScaleFactor: 0.9,
                                style: TextStyle(color: Colors.black54),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        decoration: new BoxDecoration(
                            boxShadow: Data.getBoxShadows(15.0),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Card(
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 0,
                            child: ExpenseCard(
                              notifier: widget.notifier,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: SlideTransition(
              position: offset2,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Budgets',
                            textScaleFactor: 1.2,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(FadeRoute(
                                widget: BudgetPage(),
                              ));
                            },
                            child: Text(
                              'View All',
                              textScaleFactor: 0.9,
                              style: TextStyle(color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                            boxShadow: Data.getBoxShadows(15.0),
                            borderRadius: BorderRadius.circular(10.0)),
                        margin: EdgeInsets.symmetric(vertical: 15.0),
                        child: ProgressBarWithAnimation(
                          durationSeconds: 1,
                          percent: 68,
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            stops: [0.3, 0.9],
                            end: Alignment
                                .centerRight, // 10% of the width, so there are ten blinds.
                            colors: [
                              const Color.fromRGBO(235, 4, 255, 1.0),
                              const Color.fromRGBO(140, 9, 255, 1.0)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: SlideTransition(
              position: offset3,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Cash flow',
                              textScaleFactor: 1.2,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'View All',
                              textScaleFactor: 0.9,
                              style: TextStyle(color: Colors.black54),
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        child: Card(
                          margin: EdgeInsets.all(0),
                          elevation: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: Data.getBoxShadows(5.0),
                            ),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Flexible(
                                  flex: 2,
                                  child: BubbleFiller(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        stops: [0.3, 0.9],
                                        end: Alignment
                                            .centerRight, // 10% of the width, so there are ten blinds.
                                        colors: [
                                          const Color.fromRGBO(
                                              235, 4, 255, 1.0),
                                          const Color.fromRGBO(140, 9, 255, 1.0)
                                        ],
                                      ),
                                      percent: 55,
                                      textColor: Colors.white),
                                ),
                                Flexible(
                                  flex: 6,
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          'Earned',
                                          textScaleFactor: 1.4,
                                          style: TextStyle(
                                              color: Colors.black26,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          '\$ 7.630',
                                          textScaleFactor: 1.3,
                                          style: TextStyle(
                                              color: Colors.deepPurpleAccent,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        child: Card(
                          margin: EdgeInsets.all(0),
                          elevation: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: Data.getBoxShadows(8.0),
                            ),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Flexible(
                                  flex: 2,
                                  child: BubbleFiller(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        stops: [0.3, 0.9],
                                        end: Alignment
                                            .centerRight, // 10% of the width, so there are ten blinds.
                                        colors: [
                                          const Color.fromRGBO(
                                              235, 4, 255, 1.0),
                                          Colors.purpleAccent
                                        ],
                                      ),
                                      percent: 45,
                                      textColor: Colors.purpleAccent),
                                ),
                                Flexible(
                                  flex: 6,
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          'Spent',
                                          textScaleFactor: 1.4,
                                          style: TextStyle(
                                              color: Colors.black26,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          '-\$ 6.321',
                                          textScaleFactor: 1.3,
                                          style: TextStyle(
                                              color: Colors.purpleAccent,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class AccountCards extends StatefulWidget {
  const AccountCards({
    Key key,
  }) : super(key: key);

  @override
  _AccountCardsState createState() => _AccountCardsState();
}

class _AccountCardsState extends State<AccountCards>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: new Duration(milliseconds: 500),
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
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-1.57 + (1.57 * _controller.value)),
                  alignment: FractionalOffset.center,
                  child: child);
            },
            child: Card(
              elevation: 0,
              margin: EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      stops: [0.3, 0.9],
                      end: Alignment
                          .bottomRight, // 10% of the width, so there are ten blinds.
                      colors: [
                        const Color.fromRGBO(235, 4, 255, 1.0),
                        const Color.fromRGBO(140, 9, 255, 1.0)
                      ],
                    )),
                child: LayoutBuilder(
                  builder: (context, layout) {
                    return Container(
                      width: layout.maxWidth,
                      margin: EdgeInsets.only(left: layout.maxWidth / 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Cash',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '\$ 35,170',
                            textScaleFactor: 1.5,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(1.57 + (-1.57 * _controller.value)),
                  alignment: FractionalOffset.center,
                  child: child);
            },
            child: Card(
              elevation: 0,
              margin: EdgeInsets.only(bottom: 5.0, top: 5.0, left: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: Data.getBoxShadows(5.0),
                ),
                child: LayoutBuilder(
                  builder: (context, layout) {
                    return Container(
                      width: layout.maxWidth,
                      margin: EdgeInsets.only(left: layout.maxWidth / 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Credit Debt',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '-\$ 4,320',
                            textScaleFactor: 1.5,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: const Color.fromRGBO(235, 4, 255, 1.0),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
      ],
    );
  }
}
