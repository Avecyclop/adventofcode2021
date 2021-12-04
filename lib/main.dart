import 'package:flutter/material.dart';

import 'day1.dart';
import 'day2.dart';
import 'day3.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var days = [Day1(), Day2(), Day3()];
    var tabs = <Tab>[];
    for (int i = 1; i <= days.length; i++) {
      tabs.add(Tab(text: "Day $i"));
    }

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
