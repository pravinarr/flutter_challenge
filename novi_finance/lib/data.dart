import 'package:novi_finance/components/expense_chart.dart';
import 'package:flutter/material.dart';

class ATMCardData {
  String cardNumber, cardHolderName, expiry;
  Color startColor, endColor;
  List<ChartData> monthly, weekly, yearly;
  List<DailyData> daily;

  ATMCardData(
      {this.cardNumber,
      this.cardHolderName,
      this.expiry,
      this.startColor,
      this.monthly,
      this.daily,
      this.weekly,
      this.yearly,
      this.endColor});

  List<ChartData> getLineChartDataByType(String type) {
    if (type == 'MONTHLY') {
      return this.monthly;
    }
    if (type == 'WEEKLY') {
      return this.weekly;
    }
    return this.yearly;
  }
}

class ChartData {
  int index;
  double value;
  String label;
  Color color;
  ChartData({this.index, this.label, this.value, this.color});
}

class DailyData {
  int index;
  double value;
  String label;
  Color color;
  DailyData({this.index, this.label, this.value, this.color});
}

class Data {
  static List<ATMCardData> getAtmCardData() {
    return [
      ATMCardData(
          cardNumber: '1234 2587 2458 2589',
          cardHolderName: 'Hovey',
          expiry: '8/27',
          startColor: const Color.fromRGBO(235, 4, 255, 1.0),
          endColor: const Color.fromRGBO(140, 9, 255, 1.0),
          monthly: [
            ChartData(index: 1, label: 'JAN', value: 10, color: Colors.red),
            ChartData(index: 2, label: 'FEB', value: 30, color: Colors.yellow),
            ChartData(index: 3, label: 'MAR', value: 5, color: Colors.green),
            ChartData(index: 4, label: 'APR', value: 23, color: Colors.blue),
            ChartData(index: 5, label: 'MAY', value: 7, color: Colors.orange),
            ChartData(index: 6, label: 'JUN', value: 22, color: Colors.purple),
          ],
          weekly: [
            ChartData(index: 1, label: 'JAN', value: 22, color: Colors.red),
            ChartData(index: 2, label: 'FEB', value: 7, color: Colors.yellow),
            ChartData(index: 3, label: 'MAR', value: 2, color: Colors.green),
            ChartData(index: 4, label: 'APR', value: 32, color: Colors.blue),
            ChartData(index: 5, label: 'MAY', value: 7, color: Colors.orange),
            ChartData(index: 6, label: 'JUN', value: 15, color: Colors.red),
          ],
          yearly: [
            ChartData(index: 1, label: 'JAN', value: 12, color: Colors.red),
            ChartData(index: 2, label: 'FEB', value: 30, color: Colors.red),
            ChartData(index: 3, label: 'MAR', value: 24, color: Colors.red),
            ChartData(index: 4, label: 'APR', value: 12, color: Colors.red),
            ChartData(index: 5, label: 'MAY', value: 17, color: Colors.red),
            ChartData(index: 6, label: 'JUN', value: 28, color: Colors.red),
          ],
          daily: [
            DailyData(index: 1, label: '02/1', value: 10, color: Colors.yellow),
            DailyData(index: 2, label: '02/2', value: 15, color: Colors.yellow),
            DailyData(index: 3, label: '02/3', value: 5, color: Colors.yellow)
          ]),
      ATMCardData(
          cardNumber: '7654 5432 5435 1212',
          cardHolderName: 'Hovey',
          expiry: '7/22',
          startColor: const Color.fromRGBO(254, 218, 54, 1.0),
          endColor: const Color.fromRGBO(254, 196, 47, 1.0),
          monthly: [
            ChartData(index: 1, label: 'JAN', value: 13),
            ChartData(index: 2, label: 'FEB', value: 22),
            ChartData(index: 3, label: 'MAR', value: 15),
            ChartData(index: 4, label: 'APR', value: 13),
            ChartData(index: 5, label: 'MAY', value: 17),
            ChartData(index: 6, label: 'JUN', value: 2),
          ],
          weekly: [
            ChartData(index: 1, label: 'JAN', value: 2),
            ChartData(index: 2, label: 'FEB', value: 17),
            ChartData(index: 3, label: 'MAR', value: 12),
            ChartData(index: 4, label: 'APR', value: 32),
            ChartData(index: 5, label: 'MAY', value: 17),
            ChartData(index: 6, label: 'JUN', value: 5),
          ],
          yearly: [
            ChartData(index: 1, label: 'JAN', value: 2),
            ChartData(index: 2, label: 'FEB', value: 10),
            ChartData(index: 3, label: 'MAR', value: 14),
            ChartData(index: 4, label: 'APR', value: 14),
            ChartData(index: 5, label: 'MAY', value: 7),
            ChartData(index: 6, label: 'JUN', value: 8),
          ],
          daily: [
            DailyData(index: 1, label: '02/1', value: 13),
            DailyData(index: 1, label: '02/2', value: 12),
            DailyData(index: 1, label: '02/3', value: 16)
          ]),
      ATMCardData(
          cardNumber: '5434 5321 2224 6543',
          cardHolderName: 'Hovey',
          expiry: '10/32',
          startColor: const Color.fromRGBO(253, 108, 130, 1.0),
          endColor: const Color.fromRGBO(252, 53, 144, 1.0),
          monthly: [
            ChartData(index: 1, label: 'JAN', value: 22),
            ChartData(index: 2, label: 'FEB', value: 2),
            ChartData(index: 3, label: 'MAR', value: 5),
            ChartData(index: 4, label: 'APR', value: 5),
            ChartData(index: 5, label: 'MAY', value: 7),
            ChartData(index: 6, label: 'JUN', value: 12),
          ],
          weekly: [
            ChartData(index: 1, label: 'JAN', value: 11),
            ChartData(index: 2, label: 'FEB', value: 17),
            ChartData(index: 3, label: 'MAR', value: 22),
            ChartData(index: 4, label: 'APR', value: 2),
            ChartData(index: 5, label: 'MAY', value: 17),
            ChartData(index: 6, label: 'JUN', value: 5),
          ],
          yearly: [
            ChartData(index: 1, label: 'JAN', value: 2),
            ChartData(index: 2, label: 'FEB', value: 13),
            ChartData(index: 3, label: 'MAR', value: 4),
            ChartData(index: 4, label: 'APR', value: 2),
            ChartData(index: 5, label: 'MAY', value: 7),
            ChartData(index: 6, label: 'JUN', value: 8),
          ],
          daily: [
            DailyData(index: 1, label: '02/1', value: 15),
            DailyData(index: 1, label: '02/2', value: 18),
            DailyData(index: 1, label: '02/3', value:10)
          ]),
    ];
  }

  static List<ExpenseChartItem> getExpenseData() {
    List<ExpenseChartItem> list = [];
    list.add(ExpenseChartItem(
      value: 35,
      amount: -895.00,
      icon: Icons.fastfood,
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        stops: [0.3, 0.9],
        end:
            Alignment.centerRight, // 10% of the width, so there are ten blinds.
        colors: [
          const Color.fromRGBO(253, 108, 130, 1.0),
          const Color.fromRGBO(252, 53, 144, 1.0)
        ],
      ),
      label: 'Food & Drink',
    ));
    list.add(ExpenseChartItem(
      value: 25,
      amount: -812.00,
      icon: Icons.hotel,
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        stops: [0.3, 0.9],
        end:
            Alignment.centerRight, // 10% of the width, so there are ten blinds.
        colors: [Colors.green, Colors.teal],
      ),
      label: 'Hotel & Restaurant',
    ));
    list.add(ExpenseChartItem(
      value: 10,
      amount: -240,
      icon: Icons.account_balance,
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        stops: [0.3, 0.9],
        end:
            Alignment.centerRight, // 10% of the width, so there are ten blinds.
        colors: [
          const Color.fromRGBO(235, 4, 255, 1.0),
          const Color.fromRGBO(140, 9, 255, 1.0)
        ],
      ),
      label: 'Home',
    ));
    return list;
  }

  static List<BoxShadow> getBoxShadows(double radius) {
    return [
      BoxShadow(
        color: Colors.indigo.shade100,
        blurRadius: radius,
      ),
      BoxShadow(
        color: Colors.white,
        blurRadius: radius,
      ),
      BoxShadow(
        color: Colors.white,
        blurRadius: radius,
      ),
      BoxShadow(
        color: Colors.white,
        blurRadius: radius,
      ),
    ];
  }
}
