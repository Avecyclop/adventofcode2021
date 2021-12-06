import 'package:flutter/material.dart';

import 'day1.dart';
import 'day2.dart';
import 'day4.dart';
import 'day5.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var days = [Day1(), Day2(), Day4(), Day5()];
    var tabs = ["Day 1", "Day 2", "Day 4", "Day 5"]
        .map((e) => Tab(text: e)).toList();

    return MaterialApp(
      home: DefaultTabController(
        length: days.length,
        child: Scaffold(
          primary: true,
          appBar: AppBar(
            title: Text('Advent of Code 2021'),
            bottom: TabBar(
              tabs: tabs,
            ),
          ),
          body: TabBarView(
            children: days,
          ),
        ),
      ),
    );
  }
}
