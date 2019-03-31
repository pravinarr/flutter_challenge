import 'package:flutter/material.dart';
import 'package:novi_finance/components/budget_item.dart';
import 'package:novi_finance/navigation/slide_transition.dart';
import 'package:novi_finance/pages/my_cards.dart';

class BudgetPage extends StatelessWidget {
  final ValueNotifier<bool> notifier = ValueNotifier<bool>(false);

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
          onPressed: ()  {
            notifier.value = true;
           // await Future.delayed(Duration(milliseconds: 600));
           
          },
        ),
        title: Center(
            child: Text(
          'My Budget',
          style: TextStyle(color: Colors.black),
        )),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings_input_composite,
              color: Colors.black45,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black45,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: new Budget(
          exitNotifier: notifier,
        ),
      ),
    );
  }
}

class Budget extends StatefulWidget {
  const Budget({Key key, this.exitNotifier}) : super(key: key);
  final ValueNotifier<bool> exitNotifier;

  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> with TickerProviderStateMixin {
  //Entry Controllers
  AnimationController _controller1;
  AnimationController _controller2;
  AnimationController _controller3;

  //Exit Controllers
  AnimationController _controller1Exit;
  AnimationController _controller2Exit;
  AnimationController _controller3Exit;

  @override
  void initState() {
    super.initState();
    widget.exitNotifier.addListener(() {
      if (widget.exitNotifier.value) {
        _controller1Exit.forward();
      } 
    });
    _controller1 = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this)
      ..addListener(() {
        if (_controller1.value >= 0.5 &&
            _controller2.status != AnimationStatus.forward) {
          _controller2.forward();
        }
      })
      ..forward();
    _controller2 = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this)
      ..addListener(() {
        if (_controller2.value >= 0.5 &&
            _controller3.status != AnimationStatus.forward) {
          _controller3.forward();
        }
      });
    _controller3 = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this);

    _controller1Exit = new AnimationController(
        duration: new Duration(milliseconds: 300), vsync: this)
      ..addListener(() {
        if (_controller1Exit.value >= 0.5 &&
            _controller2Exit.status != AnimationStatus.forward) {
          _controller2Exit.forward();
        }
      });

    _controller2Exit = new AnimationController(
        duration: new Duration(milliseconds: 300), vsync: this)
      ..addListener(() {
        if (_controller2Exit.value >= 0.5 &&
            _controller3Exit.status != AnimationStatus.forward) {
          _controller3Exit.forward();
        }
      });

    _controller3Exit = new AnimationController(
        duration: new Duration(milliseconds: 300), vsync: this)
        ..addStatusListener((status){
          if(status == AnimationStatus.completed){
             Navigator.of(context)
                .pushReplacement(SlideRightRoute(widget: MyCards()));
          }
        });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
     _controller1Exit.dispose();
    _controller2Exit.dispose();
    _controller3Exit.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: BudgetitemCard(
              entryController: _controller1,
              exitController: _controller1Exit,
              months: ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN'],
              savings: [3, 13, 4, 10, 2, 7, 6],
              totalSavings: 2236.0,
              label: 'Savings',
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
          ),
          Flexible(
            flex: 1,
            child: BudgetitemCard(
              entryController: _controller2,
              exitController: _controller2Exit,
              months: ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN'],
              savings: [3, 13, 4, 10, 2, 7, 6],
              totalSavings: 2236.0,
              label: 'Expenses',
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                stops: [0.3, 0.9],
                end: Alignment
                    .bottomRight, // 10% of the width, so there are ten blinds.
                colors: [
                  const Color.fromRGBO(254, 218, 54, 1.0),
                  const Color.fromRGBO(254, 196, 47, 1.0)
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: BudgetitemCard(
              exitController: _controller3Exit,
              entryController: _controller3,
              months: ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN'],
              savings: [3, 13, 4, 10, 2, 7, 6],
              totalSavings: 2236.0,
              label: 'Investments',
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                stops: [0.3, 0.9],
                end: Alignment
                    .bottomRight, // 10% of the width, so there are ten blinds.
                colors: [
                  const Color.fromRGBO(253, 108, 130, 1.0),
                  const Color.fromRGBO(252, 53, 144, 1.0)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
