import 'package:flutter/material.dart';
import 'package:intradaypl/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intraday P&L',
      theme: ThemeData(
          primarySwatch: Colors.blue, primaryColor: Color(0XFF0043b4)),
      home: Homepage(),
    );
  }
}
