import 'package:flutter/material.dart';
import 'package:novi_finance/pages/overview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ValueNotifier<bool> notifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Novi Finance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Overview(),
    );
  }
}
